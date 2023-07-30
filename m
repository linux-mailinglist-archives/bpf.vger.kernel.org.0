Return-Path: <bpf+bounces-6383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604F1768657
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 18:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7578B1C20B33
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 16:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73BEDF6E;
	Sun, 30 Jul 2023 16:12:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B43FDDA5
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 16:12:16 +0000 (UTC)
Received: from out-87.mta0.migadu.com (out-87.mta0.migadu.com [IPv6:2001:41d0:1004:224b::57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD6B10F5
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 09:12:13 -0700 (PDT)
Message-ID: <8629d2ae-75dc-89de-7cee-1790e9116384@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690733530; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a4EQE47gNu+LgdprzYersmtKjJaahfRlXl3ITiO0Ilo=;
	b=tpQDGpb63NKVAMyy0zuihxNI3X7hyGBLi0Bm1jKBlTN0U+HfcWyeYRrA9TXIaXo83Oj41Q
	TfYgYMc13M94g9ekmZ20I5mniio3uR3Hm7cYNB9O59yBX3TrF+AjMz1X5vTLwwYGE12pw4
	5/tGcnNnmLm4MIPgTBBkD6ufYYV0hc0=
Date: Sun, 30 Jul 2023 09:12:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: GCC and binutils support for BPF V4 instructions
Content-Language: en-US
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
References: <878rb0yonc.fsf@oracle.com>
 <13eb5cae-e599-7f80-aa11-65846fccdc62@linux.dev> <87v8e4x7cr.fsf@oracle.com>
 <87pm4bykxw.fsf@oracle.com>
 <CAADnVQLaZrqq232fxts0GmymaaG=fpvRbSZaBkfNnKFuy0LM8A@mail.gmail.com>
 <87jzujnms6.fsf@oracle.com>
 <CAADnVQ+2mHqRc2EBCKe+NHHPQ+FqaNt2PmD6t9DN6GwPnu1RQg@mail.gmail.com>
 <87edkqm257.fsf@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <87edkqm257.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/29/23 9:54 PM, Jose E. Marchesi wrote:
> 
>> On Sat, Jul 29, 2023 at 1:29 AM Jose E. Marchesi
>> <jose.marchesi@oracle.com> wrote:
>>>
>>>
>>>> On Fri, Jul 28, 2023 at 11:01 AM Jose E. Marchesi
>>>> <jose.marchesi@oracle.com> wrote:
>>>>>
>>>>>
>>>>>>> On 7/28/23 9:41 AM, Jose E. Marchesi wrote:
>>>>>>>> Hello.
>>>>>>>> Just a heads up regarding the new BPF V4 instructions and their
>>>>>>>> support
>>>>>>>> in the GNU Toolchain.
>>>>>>>> V4 sdiv/smod instructions
>>>>>>>>     Binutils has been updated to use the V4 encoding of these
>>>>>>>>     instructions, which used to be part of the xbpf testing dialect used
>>>>>>>>     in GCC.  GCC generates these instructions for signed division when
>>>>>>>>     -mcpu=v4 or higher.
>>>>>>>> V4 sign-extending register move instructions
>>>>>>>> V4 signed load instructions
>>>>>>>> V4 byte swap instructions
>>>>>>>>     Supported in assembler, disassembler and linker.  GCC generates
>>>>>>>> these
>>>>>>>>     instructions when -mcpu=v4 or higher.
>>>>>>>> V4 32-bit unconditional jump instruction
>>>>>>>>     Supported in assembler and disassembler.  GCC doesn't generate
>>>>>>>> that
>>>>>>>>     instruction.
>>>>>>>>     However, the assembler has been expanded in order to perform the
>>>>>>>>     following relaxations when the disp16 field of a jump instruction is
>>>>>>>>     known at assembly time, and is overflown, unless -mno-relax is
>>>>>>>>     specified:
>>>>>>>>       JA disp16  -> JAL disp32
>>>>>>>>       Jxx disp16 -> Jxx +1; JA +1; JAL disp32
>>>>>>>>     Where Jxx is one of the conditional jump instructions such as
>>>>>>>> jeq,
>>>>>>>>     jlt, etc.
>>>>>>>
>>>>>>> Sounds great. The above 'JA/Jxx disp16' transformation matches
>>>>>>> what llvm did as well.
>>>>>>
>>>>>> Not by chance ;)
>>>>>>
>>>>>> Now what is pending in binutils is to relax these jumps in the linker as
>>>>>> well.  But it is very low priority, compared to get these kernel
>>>>>> selftests building and running.  So it will happen, but probably not
>>>>>> anytime soon.
>>>>>
>>>>> By the way, for doing things like that (further object transformations
>>>>> by linkers and the like) we will need to have the ELF files annotated
>>>>> with:
>>>>>
>>>>> - The BPF cpu version the object was compiled for: v1, v2, v3, v4, and
>>>>>
>>>>> - Individual flags specifying the BPF cpu capabilities (alu32, bswap,
>>>>>    jmp32, etc) required/expected by the code in the object.
>>>>>
>>>>> Note it is interesting to being able to denote both, for flexibility.
>>>>>
>>>>> There are 32 bits available for machine-specific flags in e_flags, which
>>>>> are commonly used for this purpose by other arches.  For BPF I would
>>>>> suggest something like:
>>>>>
>>>>> #define EF_BPF_ALU32  0x00000001
>>>>> #define EF_BPF_JMP32  0x00000002
>>>>> #define EF_BPF_BSWAP  0x00000004
>>>>> #define EF_BPF_SDIV   0x00000008
>>>>> #define EF_BPF_CPUVER 0x00FF0000
>>>>
>>>> Interesting idea. I don't mind, but what are we going to do with this info?
>>>> I cannot think of anything useful libbpf could do with it.
>>>> For other archs such flags make sense, since disasm of everything
>>>> to discover properties is hard. For BPF we will parse all insns anyway,
>>>> so additional info in ELF doesn't give any additional insight.
>>>
>>> I mainly had link-time relaxation in mind.  The linker needs to know
>>> what instructions are available (JMP32 or not) in order to decide what
>>> to relax, and to what.
>>
>> But the assembler has little choice when the jump target is >16bits.
>> It can use jmp32 or error.
> 
> When the assembler sees a jump instruction:
> 
>     goto EXPR
> 
> there are several possibilities:
> 
> 1. EXPR consists on a literal number like 1, -10 or 0xff, or an
>     expression that can be resolved during the first assembler pass (like
>     8 * 64).  The numerical result is interpreted as number of 64-bit
>     words minus one.  In this case, the assembler can immediately decide
>     whether the operand is >16 bits, relaxing to the jmp32 jump if cpu >=
>     v4 and unless -mno-relax is passed in the command line.
> 
> 2. EXPR is a symbolic expression involving a symbol that can be resolved
>     during the second assembler pass.  For example, `foo + 10'.  In this
>     case, there are two possibilities:
> 
>     2.1. The symbol is an absolute symbol.  In this case the value is
>          interpreted as-such and no conversion is done by the assembler.
>          So if for example the user invokes the assembler passing
>          `--defsym foo=10', the assembled instruction is `ja 20'.
> 
>     2.2. The symbol is a PC-relative or section-relative symbol.  In this
>          case the value is interpreted as a byte offset (the assembler
>          takes care to transform offsets relative to the current section
>          into PC-relative offsets whenever necessary).  This is the case
>          of labels.  For these symbols, the BPF assembler converts the
>          value from bytes to number of 64-bit words minus one.  So for
>          example for `ja done' where `done' has the value 256 bytes, the
>          assembled instruction is `ja 31'.
> 
> 3. EXPR is a symbolic expression involving a symbol that cannot be
>     resolved during the second assembler pass.  In this case, a
>     relocation for the 16-bit immediate field in the instruction is
>     generated in the assembled object.  There is no R_BPF_64_16
>     relocation defined by BPF as of yet, so we are using
>     R_BPF_GNU_64_16=256, which as we agreed uses a high relocation number
>     to avoid collisions.  Since gas is a standalone assembler, it seems
>     sensible to emit a relocation rather than erroing out in these
>     situations.  ld knows how to handle these relocs when linking BPF
>     objects together.
> 
>> I guess you're proposing to encode this e_flags in the text of asm ?
>> Special asm directive that will force asm to error or use jmp32?
> 
> GAS uses command-line options for that.
> 
> When GCC is invoked with -mcpu=v3, for example, it passes the
> corresponding option to the assembler so it expects a BPF V3 assembly
> program. In that scenario, if the user does a jump to an address that is
>> 16bit in an inline asm, the assembler will error out,
> because relaxing to jmp32 is not a possibility in V3.  Ditto for
> compiler options like -msdiv or -mjmp32, that both clang and GCC
> support.
> 
> I don't know how clang configures its integrated assembler... I guess by
> calling some function.  But it is the same principle: if you tell clang
> to generate v3 bpf and you include a header that uses a v4 instruction
> (or overflown jump that would require relaxation) in inline asm, you
> want an error.

If -mcpu=<version> is specified in the clang command line,
then the cpu <version> will be encoded in IR and will be
passed to the integrated assembler. And if you specify
-mcpu=v3 in the command line and your code has
cpu v4 inline assembly code, the compiler will error out.

> 
>>> Also as you mention the disassembler can look in the object to determine
>>> which instructions shall be recognized and with insructions shall be
>>> reported as <unknown>.  Right now it is necessary to pass an explicit
>>> option to the assembler, and the default is v4.
>>
>> Disambiguating between unknown and exact insn kinda makes sense for disasm.
>> For assembler it's kinda weird. If text says 'sdiv' the asm should emit
>> binary code for it regardless of asm directive.
> 
> Unless configured to not do so?  See above.
> 
>> It seems e_flags can only be emitted by assembler.
>> Like if it needs to use jmp32 it will add EF_BPF_JMP32.
> 
> Yep.
> 
>> Still feels that we can live without these flags, but not a bad
>> addition.
> 
> The individual flags... I am not sure, other arches have them, but maybe
> having them in BPF doesn't make much sense and it is not worth the extra
> complication and wasted bits in e_flags.  How realistic is to expect
> that some kernel may support a particular version of the BPF ISA, and
> also have support for some particular instruction from a later ISA as
> the result of a backport or something?  Not for me to judge... I was
> already bitten by my utter ignorance on kernel business when I added
> that silly useless -mkernel=VERSION option to GCC 8-)
> 
> What I am pretty sure is that we will need something like EF_BPF_CPUVER
> if we are ever gonna support relaxation in any linker external to
> libbpf, and also to detect (and error/warn) when several objects with
> different BPF versions are linked together.
> 
>> As far as flag names, let's use EF_ prefix. I think it's more canonical.
>> And single 0xF is probably enough for cpu ver.
> 
> Agreed.

