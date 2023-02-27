Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275BF6A4BE8
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 21:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjB0UBq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 15:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjB0UBo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 15:01:44 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DC527486
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 12:01:41 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id r5so8081506qtp.4
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 12:01:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Nsx9/R8OZK82xQY4Cwy53T9mVgG+tFiDJts1vCADQg=;
        b=v7kMPPqUeJxg5n4evItpxg+Hnbe27nNBwbj5vRt4sc5n7wwrMcamKMl/SZatfLYkPk
         sjd22f9Z4xJozHGaWfu+FsSdwuUOqV8iCUbWcayZFOPQN3k0F0Mt6A3qTgsMIsh3LfPa
         kt9liqf5W1W0Otl7Em1X9hfgW+DSjL8Buxtf2TgwqG7DIRBivFuizslXec0PiZEin2/5
         gnyz2aRhI+bSOO51+me+x1X+6SyJBk9uoHTPL/ElGl0IahVRKKjTxuQPk5MGj1qV4YOu
         gYDY4eAmkhCit7Wy+P06zMtYfDIHRE0dUCu3Uep5U9ccrFeCWH/yz6wPa2iPPQBxsZOO
         yQ6A==
X-Gm-Message-State: AO0yUKVCyxO4U6+syXaGUsrXbhfMeCEI/NMx/yFnSKVFB6ewJm7EGl3J
        iLj6NQelRVX5tvQffuSmEDY=
X-Google-Smtp-Source: AK7set+Lazi4Zpz5rNO5pOWuY77l4eHLcPCVYN7wPnfeG+AGMSca6yRAHpWf31EgbzjJ9bC/1pg0DQ==
X-Received: by 2002:ac8:7d50:0:b0:3bf:e214:942d with SMTP id h16-20020ac87d50000000b003bfe214942dmr824986qtb.21.1677528099730;
        Mon, 27 Feb 2023 12:01:39 -0800 (PST)
Received: from maniforge ([2620:10d:c091:480::1:978f])
        by smtp.gmail.com with ESMTPSA id y24-20020ac87058000000b003b0766cd169sm5360715qtm.2.2023.02.27.12.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 12:01:39 -0800 (PST)
Date:   Mon, 27 Feb 2023 14:01:37 -0600
From:   David Vernet <void@manifault.com>
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@ietf.org
Subject: Re: [Bpf] [PATCH V2] bpf, docs: Document BPF insn encoding in term
 of stored bytes
Message-ID: <Y/0MIXoJ9h+8ASXr@maniforge>
References: <87y1oj7yvu.fsf@oracle.com>
 <Y/z9vtWfevaiRqtP@maniforge>
 <87bkle9a7e.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkle9a7e.fsf@oracle.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 27, 2023 at 08:31:33PM +0100, Jose E. Marchesi wrote:
> 
> > On Mon, Feb 27, 2023 at 07:21:25PM +0100, Jose E. Marchesi wrote:
> >> 
> >> [Differences from V1:
> >> - Use rst literal blocks for figures.
> >> - Avoid using | in the basic instruction/pseudo instruction figure.
> >> - Rebased to today's bpf-next master branch.]
> >> 
> >> This patch modifies instruction-set.rst so it documents the encoding
> >> of BPF instructions in terms of how the bytes are stored (be it in an
> >> ELF file or as bytes in a memory buffer to be loaded into the kernel
> >> or some other BPF consumer) as opposed to how the instruction looks
> >> like once loaded.
> >> 
> >> This is hopefully easier to understand by implementors looking to
> >> generate and/or consume bytes conforming BPF instructions.
> >> 
> >> The patch also clarifies that the unused bytes in a pseudo-instruction
> >> shall be cleared with zeros.
> >> 
> >> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> >
> > Thanks Jose, this looks a lot better. Just left a couple more small
> > suggestions + questions below before stamping.
> >
> >> 
> >> ---
> >>  Documentation/bpf/instruction-set.rst | 44 +++++++++++++--------------
> >>  1 file changed, 22 insertions(+), 22 deletions(-)
> >> 
> >> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> >> index 01802ed9b29b..3341bfe20e4d 100644
> >> --- a/Documentation/bpf/instruction-set.rst
> >> +++ b/Documentation/bpf/instruction-set.rst
> >> @@ -38,15 +38,13 @@ eBPF has two instruction encodings:
> >>  * the wide instruction encoding, which appends a second 64-bit immediate (i.e.,
> >>    constant) value after the basic instruction for a total of 128 bits.
> >>  
> >> -The basic instruction encoding looks as follows for a little-endian processor,
> >> -where MSB and LSB mean the most significant bits and least significant bits,
> >> -respectively:
> >> +The fields conforming an encoded basic instruction are stored in the
> >> +following order::
> >>  
> >> -=============  =======  =======  =======  ============
> >> -32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
> >> -=============  =======  =======  =======  ============
> >> -imm            offset   src_reg  dst_reg  opcode
> >> -=============  =======  =======  =======  ============
> >> +  opcode:8 src:4 dst:4 offset:16 imm:32 // In little-endian BPF.
> >> +  opcode:8 dst:4 src:4 offset:16 imm:32 // In big-endian BPF.
> >
> > The terms below use src_reg and dst_reg. Can we either update these code
> > blocks to match, or change the term definitions to "src" and "dst"? I'd
> > vote for the latter, given that we explain that it's the source /
> > destination register number where they're defined.
> 
> Will change.
> 
> >> +
> >> +Where,
> >
> > IMO, we can probably remove this "Where,". I think it's pretty clear
> > that the following terms are referring to the code block above. Wdyt?
> 
> I added the "Where," to make the reading a little bit more fluid, but I
> don't have a strong opinion on that.
> 
> >
> >>  
> >>  **imm**
> >>    signed integer immediate value
> >> @@ -64,16 +62,17 @@ imm            offset   src_reg  dst_reg  opcode
> >>  **opcode**
> >>    operation to perform
> >>  
> >> -and as follows for a big-endian processor:
> >> +Note that the contents of multi-byte fields ('imm' and 'offset') are
> >> +stored using big-endian byte ordering in big-endian BPF and
> >> +little-endian byte ordering in little-endian BPF.
> >>  
> >> -=============  =======  =======  =======  ============
> >> -32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
> >> -=============  =======  =======  =======  ============
> >> -imm            offset   dst_reg  src_reg  opcode
> >> -=============  =======  =======  =======  ============
> >> +For example::
> >>  
> >> -Multi-byte fields ('imm' and 'offset') are similarly stored in
> >> -the byte order of the processor.
> >> +  opcode         offset imm          assembly
> >> +         src dst
> >> +  07     0   1   00 00  44 33 22 11  r1 += 0x11223344 // little
> >> +         dst src
> >> +  07     1   0   00 00  11 22 33 44  r1 += 0x11223344 // big
> >>  
> >>  Note that most instructions do not use all of the fields.
> >>  Unused fields shall be cleared to zero.
> >> @@ -84,18 +83,19 @@ The 64 bits following the basic instruction contain a pseudo instruction
> >>  using the same format but with opcode, dst_reg, src_reg, and offset all set to zero,
> >>  and imm containing the high 32 bits of the immediate value.
> >>  
> >> -=================  ==================
> >> -64 bits (MSB)      64 bits (LSB)
> >> -=================  ==================
> >> -basic instruction  pseudo instruction
> >> -=================  ==================
> >> +This is depicted in the following figure::
> >> +
> >> +  basic_instruction               pseudo instruction
> >> +  ------------------------------- ------------------
> >> +  code:8 regs:16 offset:16 imm:32 unused:32 imm:32
> >
> > Don't want to bikeshed too much, but this seems a bit hard to read.  It
> > kind of all looks like one line, though perhaps that was the intention.
> > Wdyt about this?
> >
> > This is depicted in the following figure::
> >
> >   code:8 regs:16 offset:16 imm:32  // MSB: basic instruction
> >   reserved:32              imm:32  // LSB: pseudo instruction
> 
> Hmm, yes, that was the intention, to depict the fact that a 128-bit
> instruction is composed by the sequence of a basic instruction followed
> by a pseudo instruction...
> 
> This would be the bombastic ASCII-art version of what I had in mind :)
> 
>          basic_instruction        
>    .-----------------------------.
>    |                             |
>    code:8 regs:16 offset:16 imm:32 unused:32 imm:32
>                                    |              |
>                                    '--------------'
>                                   pseudo instruction

Oh man, I love ASCII-art, bombastic or not. I personally prefer this
over the single-line version, but I think either way is fine. It's
pretty clear what it's conveying.

> 
> I don't think MSB and LSB marks are meaningful in this context.  Bytes
> in a file or in memory are no more or less significative: they just have
> addresses (or file offsets) which can be lower or higher than the
> addresses (or file offsets) of other bytes.

Fair enough, let's leave off MSB / LSB.

> >>  
> >>  Thus the 64-bit immediate value is constructed as follows:
> >>  
> >>    imm64 = (next_imm << 32) | imm
> >>  
> >>  where 'next_imm' refers to the imm value of the pseudo instruction
> >> -following the basic instruction.
> >> +following the basic instruction.  The unused bytes in the pseudo
> >> +instruction shall be cleared to zero.
> >
> > Also apologies if this is also a bikeshed and has already been
> > discussed, but should we say, "The unused bits in the pseudo instruction
> > are reserved" rather than saying they should be cleared to zero?
> > Implemenations should interpret "reserved" to mean that the bits should
> > be zeroed, no? Or at least that seems like the norm in technical
> > manuals.  For example, reserved bits in control registers on x86 should
> > be cleared to avoid unexpected side effects if and when those bits are
> > eventually actually used for something in future releases.
> 
> That is a good point.
> 
> I agree that "reserved" almost always means zero, but I think it is very
> common to say so explicitly.  A couple of examples:

Someone should standardize how manuals describe reserved bits ;-)

> Example 1, from the x86 MBR spec:
> 
>    *  Offset  Size (bytes)  Description
>    *
>    *  0x000   440           MBR Bootstrap (flat binary executable code)
>    *  0x1B8   4             Optional "Unique Disk ID / Signature"
>    *  0x1BC   2             Optional, reserved 0x0000
>    *  0x1BE   16            First partition table entry
>    *  0x1CE   16            Second partition table entry
>    *  0x1DE   16            Third partition table entry
>    *  0x1EE   16            Fourth partition table entry
>    *  0x1FE   2             (0x55, 0xAA) "Valid bootsector" signature bytes
> 
> Example 2, this is how the PE Object File specification defines a
> reserved field:
> 
>    reserved,         A description of a field that indicates that the value
>    must be 0         of the field must be zero for generators and consumers
>                      must ignore the field.
> 
> What about this: "The unused bits in the pseudo instruction are reserved
> and shall be cleared to zero."

Sounds good to me!

Thanks,
David
