import React from 'react'
import styled from 'styled-components'

import { CalculatorField } from './CalculatorField'
import { useEnterKeypress } from '../../hooks/use-enter-keypress'

interface CalculatorFieldProps {
  input: string
  handleChange: (value: string) => any
  handleEnter: () => any
  result?: string
  error?: boolean
  inputRef?: React.MutableRefObject<HTMLInputElement | null>
}

const UnstyledInput = styled.input`
  width: 100%;
  border: none;
  outline: none;
  font: inherit;
  padding: 0;
  height: inherit;
`

export const CalculatorInput: React.FC<CalculatorFieldProps> = ({
  input,
  handleChange,
  handleEnter,
  result,
  error,
  inputRef
}) => {
  const handleKeyPress = useEnterKeypress(handleEnter)
  return (
    <CalculatorField error={error} result={result}>
      <UnstyledInput
        ref={inputRef}
        type="text"
        value={input}
        onChange={event => handleChange(event.target.value)}
        onKeyPress={handleKeyPress}
      />
    </CalculatorField>
  )
}
