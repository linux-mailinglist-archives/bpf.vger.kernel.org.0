Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130DB6A492D
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 19:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjB0SGH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 13:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjB0SGD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 13:06:03 -0500
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3407A1F93B
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 10:05:38 -0800 (PST)
Received: from fencepost.gnu.org ([2001:470:142:3::e])
        by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <jemarch@gnu.org>)
        id 1pWhsS-0006l4-8T; Mon, 27 Feb 2023 13:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
        s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
        From; bh=c4f7JG5ODggTTZcs/SV+qMJcpk+UjAI7kEFKIyKe5Kw=; b=bR7p0oflLBX1+La0aUUf
        PCPnYLgg6LLuWIOjPNle8Wmm/s7Xv0bHUW6Jcp+di9zoj3YBTqRHNYbMlu+IbqHqEsCC/7NQWfUOx
        KqqHFjKM87j4BSo9DHgEq/VDkHBCowXRgK0pRVQhYnSYeTQDr7W4PUpoWojZOnDorPLgLAz5vOh7A
        yFbYzuJhM5M76lPBcD1Sp4FfhwJExtDY3xD29NQbaZW0Oo+WmaoCvypl/97lBz9T4N5c9BzSa28Z3
        DiT+vEP7jGcnay5UIXxJMNOBkRyIXGrMxP0B6UnhI29kldbEJR4YYU1t+c5HNq8y6nug9K2cf1vnz
        S+PMWR5gKCAu8Q==;
Received: from [141.143.193.72] (helo=termi)
        by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <jemarch@gnu.org>)
        id 1pWhsG-0006Og-3v; Mon, 27 Feb 2023 13:05:28 -0500
From:   "Jose E. Marchesi" <jemarch@gnu.org>
To:     David Vernet <void@manifault.com>
Cc:     "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@ietf.org
Subject: Re: [Bpf] [PATCH] bpf, docs: Document BPF insn encoding in term of
 stored bytes
In-Reply-To: <Y/zftLx9nDF5tb9G@maniforge> (David Vernet's message of "Mon, 27
        Feb 2023 10:52:04 -0600")
References: <87y1om25l4.fsf@oracle.com> <Y/zftLx9nDF5tb9G@maniforge>
Date:   Mon, 27 Feb 2023 19:05:05 +0100
Message-ID: <877cw39e7i.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Hi David.

Thanks for the comments, and sorry for the rst formatting mistakes.  I
forgot to add the :: before the indented blocks.  I'm resending with
these.

> On Fri, Feb 24, 2023 at 09:04:07PM +0100, Jose E. Marchesi wrote:
>> 
>> This patch modifies instruction-set.rst so it documents the encoding
>> of BPF instructions in terms of how the bytes are stored (be it in an
>> ELF file or as bytes in a memory buffer to be loaded into the kernel
>> or some other BPF consumer) as opposed to how the instruction looks
>> like once loaded.
>> 
>> This is hopefully easier to understand by implementors looking to
>> generate and/or consume bytes conforming BPF instructions.
>> 
>> The patch also clarifies that the unused bytes in a pseudo-instruction
>> shall be cleared with zeros.
>> 
>> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
>
> Hi Jose,
>
> Thanks for writing this up.
>
>> ---
>>  Documentation/bpf/instruction-set.rst | 43 +++++++++++++--------------
>>  1 file changed, 21 insertions(+), 22 deletions(-)
>> 
>> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
>> index 01802ed9b29b..9b28c0e15bb6 100644
>> --- a/Documentation/bpf/instruction-set.rst
>> +++ b/Documentation/bpf/instruction-set.rst
>> @@ -38,15 +38,13 @@ eBPF has two instruction encodings:
>>  * the wide instruction encoding, which appends a second 64-bit immediate (i.e.,
>>    constant) value after the basic instruction for a total of 128 bits.
>>  
>> -The basic instruction encoding looks as follows for a little-endian processor,
>> -where MSB and LSB mean the most significant bits and least significant bits,
>> -respectively:
>> +The fields conforming an encoded basic instruction are stored in the
>> +following order:
>>  
>> -=============  =======  =======  =======  ============
>> -32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
>> -=============  =======  =======  =======  ============
>> -imm            offset   src_reg  dst_reg  opcode
>> -=============  =======  =======  =======  ============
>> +  opcode:8 src:4 dst:4 offset:16 imm:32 // In little-endian BPF.
>> +  opcode:8 dst:4 src:4 offset:16 imm:32 // In big-endian BPF.
>
> Unfortunately this won't render correctly. It'll look something like
> this:
>
> The fields conforming an encoded basic instruction are stored in the following order:
>
> opcode:8 src:4 dst:4 offset:16 imm:32 // In little-endian
> BPF. opcode:8 dst:4 src:4 offset:16 imm:32 // In big-endian BPF.
>
> You'll have to add some extra newlines. You can test out your changes
> with:
>
> make SPHINXDIRS=bpf htmldocs
>
> And then the output is put in Documentation/output/bpf
>
> In general, this is sort of the problem we have with rst. We want to
> strike a balance between readable in a text editor, and readable when
> rendered in a web browser. I think we can strike such a balance here,
> but it'll probably require a bit of rst-fu. As described below, I think
> we can fix this with a literal code block by just adding a : to order:
>
>> +The fields conforming an encoded basic instruction are stored in the
>> +following order::
>
>
>> +
>> +Where,
>>  
>>  **imm**
>>    signed integer immediate value
>> @@ -64,16 +62,17 @@ imm            offset   src_reg  dst_reg  opcode
>>  **opcode**
>>    operation to perform
>>  
>> -and as follows for a big-endian processor:
>> +Note that the contents of multi-byte fields ('imm' and 'offset') are
>> +stored using big-endian byte ordering in big-endian BPF and
>> +little-endian byte ordering in little-endian BPF.
>>  
>> -=============  =======  =======  =======  ============
>> -32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
>> -=============  =======  =======  =======  ============
>> -imm            offset   dst_reg  src_reg  opcode
>> -=============  =======  =======  =======  ============
>> +For example:
>>  
>> -Multi-byte fields ('imm' and 'offset') are similarly stored in
>> -the byte order of the processor.
>> +  opcode         offset imm          assembly
>> +         src dst
>> +  07     0   1   00 00  44 33 22 11  r1 += 0x11223344 // little
>> +         dst src
>> +  07     1   0   00 00  11 22 33 44  r1 += 0x11223344 // big
>
> This also won't render. rst will think it's a "definition list" (see
> [0]), so it's interpreting the line with '// big' as a term that will be
> defined on the next line.
>
> [0]: https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#lists-and-quote-like-blocks
>
> If you do "For example::" it should render correctly. This applies
> elsewhere to the patch. Let's just make all of these literal code
> blocks.
>
> Thanks,
> David
>
>>  
>>  Note that most instructions do not use all of the fields.
>>  Unused fields shall be cleared to zero.
>> @@ -84,18 +83,18 @@ The 64 bits following the basic instruction contain a pseudo instruction
>>  using the same format but with opcode, dst_reg, src_reg, and offset all set to zero,
>>  and imm containing the high 32 bits of the immediate value.
>>  
>> -=================  ==================
>> -64 bits (MSB)      64 bits (LSB)
>> -=================  ==================
>> -basic instruction  pseudo instruction
>> -=================  ==================
>> +This is depicted in the following figure:
>> +
>> +  basic_instruction                 pseudo_instruction
>> +  code:8 regs:16 offset:16 imm:32 | unused:32 imm:32
>>  
>>  Thus the 64-bit immediate value is constructed as follows:
>>  
>>    imm64 = (next_imm << 32) | imm
>>  
>>  where 'next_imm' refers to the imm value of the pseudo instruction
>> -following the basic instruction.
>> +following the basic instruction.  The unused bytes in the pseudo
>> +instruction shall be cleared to zero.
>>  
>>  Instruction classes
>>  -------------------
>> -- 
>> 2.30.2
>> 
>> -- 
>> Bpf mailing list
>> Bpf@ietf.org
>> https://www.ietf.org/mailman/listinfo/bpf
