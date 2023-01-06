Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B708266043E
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 17:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbjAFQ1n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 11:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbjAFQ1h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 11:27:37 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0998CD1A
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 08:27:36 -0800 (PST)
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pDpZ8-000Gyw-Gg; Fri, 06 Jan 2023 17:27:34 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pDpZ8-000JN2-9E; Fri, 06 Jan 2023 17:27:34 +0100
Subject: Re: [PATCH] bpf, docs: Fix modulo zero, division by zero, overflow,
 and underflow
To:     sdf@google.com, dthaler1968@googlemail.com
Cc:     bpf@vger.kernel.org, Dave Thaler <dthaler@microsoft.com>
References: <20230105163223.3472-1-dthaler1968@googlemail.com>
 <Y7cefSXEQ3M3C9pk@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <51a639d4-c140-a10e-cd67-fff92ebcda9d@iogearbox.net>
Date:   Fri, 6 Jan 2023 17:27:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <Y7cefSXEQ3M3C9pk@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26773/Fri Jan  6 09:48:44 2023)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/5/23 8:01 PM, sdf@google.com wrote:
> On 01/05, dthaler1968@googlemail.com wrote:
>> From: Dave Thaler <dthaler@microsoft.com>
> 
>> Fix modulo zero, division by zero, overflow, and underflow.
>> Also clarify how a negative immediate value is used in unsigned division
> 
>> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> 
> Acked-by: Stanislav Fomichev <sdf@google.com>
> 
> With a small note below.
> 
>> ---
>>   Documentation/bpf/instruction-set.rst | 15 +++++++++++++--
>>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
>> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
>> index e672d5ec6cc..2ba7c618f33 100644
>> --- a/Documentation/bpf/instruction-set.rst
>> +++ b/Documentation/bpf/instruction-set.rst
>> @@ -99,19 +99,26 @@ code      value  description
>>   BPF_ADD   0x00   dst += src
>>   BPF_SUB   0x10   dst -= src
>>   BPF_MUL   0x20   dst \*= src
>> -BPF_DIV   0x30   dst /= src
>> +BPF_DIV   0x30   dst = (src != 0) ? (dst / src) : 0
>>   BPF_OR    0x40   dst \|= src
>>   BPF_AND   0x50   dst &= src
>>   BPF_LSH   0x60   dst <<= src
>>   BPF_RSH   0x70   dst >>= src
>>   BPF_NEG   0x80   dst = ~src
>> -BPF_MOD   0x90   dst %= src
>> +BPF_MOD   0x90   dst = (src != 0) ? (dst % src) : dst
>>   BPF_XOR   0xa0   dst ^= src
>>   BPF_MOV   0xb0   dst = src
>>   BPF_ARSH  0xc0   sign extending shift right
>>   BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
>>   ========  =====  ==========================================================
> 
>> +Underflow and overflow are allowed during arithmetic operations,
>> +meaning the 64-bit or 32-bit value will wrap.  If
>> +eBPF program execution would result in division by zero,
>> +the destination register is instead set to zero.
>> +If execution would result in modulo by zero,
>> +the destination register is instead left unchanged.
>> +
>>   ``BPF_ADD | BPF_X | BPF_ALU`` means::
> 
>>     dst_reg = (u32) dst_reg + (u32) src_reg;
>> @@ -128,6 +135,10 @@ BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
> 
>>     dst_reg = dst_reg ^ imm32
> 
> 
> [..]
> 
>> +Also note that the division and modulo operations are unsigned,
>> +where 'imm' is first sign extended to 64 bits and then converted
>> +to an unsigned 64-bit value.  There are no instructions for
>> +signed division or modulo.
> 
> Less sure about this part, but it looks to be true at least by looking at
> the interpreter which does:
> 
> DST = DST / IMM
> 
> where:
> 
> DST === (u64) regs[insn->dst_reg]
> IMM === (s32) insn->imm
> 
> (and s32 is sign-expanded to u64 according to C rules)

Yeap, the actual operation is in the target width, so for 32 bit it's casted
to u32, e.g. for modulo (note that the verifier rewrites it into `(src != 0) ?
(dst % src) : dst` form, so here is just the extract of the plain mod insn and
it's similar for div):

         ALU64_MOD_X:
                 div64_u64_rem(DST, SRC, &AX);
                 DST = AX;
                 CONT;
         ALU_MOD_X:
                 AX = (u32) DST;
                 DST = do_div(AX, (u32) SRC);
                 CONT;
         ALU64_MOD_K:
                 div64_u64_rem(DST, IMM, &AX);
                 DST = AX;
                 CONT;
         ALU_MOD_K:
                 AX = (u32) DST;
                 DST = do_div(AX, (u32) IMM);
                 CONT;

So in above phrasing the middle part needs to be adapted or just removed.

Thanks,
Daniel
