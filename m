Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4D36A4FC5
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 00:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjB0XmY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 18:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB0XmX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 18:42:23 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E271C7EF
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 15:42:22 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id y10so4045263qtj.2
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 15:42:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0twPlz7J0OZOmkl9SNfJMtrF4Bcsmf1g8uXEP2fb34=;
        b=5ajjCHpbtp6X54+sIm2kDRdW0soxsQUDRVfBbVZclAFRo0Xh1ybYxlhjWFhOTP2bD+
         KIiRILpell4LUJ+9mSGjx4x5FXYtkTOW6hDIGzgr2eRNnDRPNsqKWo1iZe74B7hHkZ2p
         VLdPuDjvLJDTeR2Mq4cmh9DfDpeNeWhjA5KK2/OzoU8QNj7w6eAmZR7qtRv0dXVwuECO
         lPu4SIrzTNFjgWK919sYnU5W38gwPI06FrLXLimXtPrq4kz5eUYm1H1bHEr0O4Iqxi9S
         0Yx/4/hbWO3ShX3kDGEPpI2BCQNzo8GXybEaEJxtpPNzzvF+fSrXtR0kcvk60/rdqoXE
         lmyg==
X-Gm-Message-State: AO0yUKU2GMTs+tMN9W5hBKOrlc0PzOZvQTgrHlnl0Sotyv1f6EdG4wjX
        FxyG+F7/kLnBYYR7fq/56U8=
X-Google-Smtp-Source: AK7set8KkMGYGymFFVSUpIYSr6C7Zjv+J1FTFfjGuss7IpBc9uFPJy9qOV3HNqgWTxa+UNqQjIAO4g==
X-Received: by 2002:ac8:5b8e:0:b0:3bf:d215:4162 with SMTP id a14-20020ac85b8e000000b003bfd2154162mr1995274qta.42.1677541341102;
        Mon, 27 Feb 2023 15:42:21 -0800 (PST)
Received: from maniforge ([2620:10d:c091:480::1:978f])
        by smtp.gmail.com with ESMTPSA id c20-20020a05620a269400b0073b81e888bfsm5710649qkp.56.2023.02.27.15.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 15:42:20 -0800 (PST)
Date:   Mon, 27 Feb 2023 17:42:18 -0600
From:   David Vernet <void@manifault.com>
To:     Dave Thaler <dthaler@microsoft.com>
Cc:     "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "bpf@ietf.org" <bpf@ietf.org>
Subject: Re: [Bpf] [PATCH V3] bpf, docs: Document BPF insn encoding in term
 of stored bytes
Message-ID: <Y/0/2pCw7d9b3Ji/@maniforge>
References: <877cw295u8.fsf@oracle.com>
 <PH7PR21MB3878F2AF288BE7671D61E257A3AF9@PH7PR21MB3878.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB3878F2AF288BE7671D61E257A3AF9@PH7PR21MB3878.namprd21.prod.outlook.com>
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

On Mon, Feb 27, 2023 at 09:49:15PM +0000, Dave Thaler wrote:
> > -----Original Message-----
> > From: Bpf <bpf-bounces@ietf.org> On Behalf Of Jose E. Marchesi
> > Sent: Monday, February 27, 2023 1:06 PM
> > To: bpf <bpf@vger.kernel.org>
> > Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>; bpf@ietf.org; David
> > Vernet <void@manifault.com>
> > Subject: [Bpf] [PATCH V3] bpf, docs: Document BPF insn encoding in term of
> > stored bytes
> > 
> > 
> > [Changes from V2:
> > - Use src and dst consistently in the document.
> 
> Since my earlier patch, src and dst refer to the values whereas
> src_reg and dst_reg refer to register numbers.
> 
> > - Use a more graphical depiction of the 128-bit instruction.
> > - Remove `Where:' fragment.
> > - Clarify that unused bits are reserved and shall be zeroed.]
> > 
> > This patch modifies instruction-set.rst so it documents the encoding of BPF
> > instructions in terms of how the bytes are stored (be it in an ELF file or as
> > bytes in a memory buffer to be loaded into the kernel or some other BPF
> > consumer) as opposed to how the instruction looks like once loaded.
> > 
> > This is hopefully easier to understand by implementors looking to generate
> > and/or consume bytes conforming BPF instructions.
> > 
> > The patch also clarifies that the unused bytes in a pseudo-instruction shall be
> > cleared with zeros.
> > 
> > Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> > ---
> >  Documentation/bpf/instruction-set.rst | 63 ++++++++++++++-------------
> >  1 file changed, 33 insertions(+), 30 deletions(-)
> > 
> > diff --git a/Documentation/bpf/instruction-set.rst
> > b/Documentation/bpf/instruction-set.rst
> > index 01802ed9b29b..fae2e48d6a0b 100644
> > --- a/Documentation/bpf/instruction-set.rst
> > +++ b/Documentation/bpf/instruction-set.rst
> > @@ -38,15 +38,11 @@ eBPF has two instruction encodings:
> >  * the wide instruction encoding, which appends a second 64-bit immediate
> > (i.e.,
> >    constant) value after the basic instruction for a total of 128 bits.
> > 
> > -The basic instruction encoding looks as follows for a little-endian processor,
> > -where MSB and LSB mean the most significant bits and least significant bits,
> > -respectively:
> > +The fields conforming an encoded basic instruction are stored in the
> > +following order::
> > 
> > -=============  =======  =======  =======  ============
> > -32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
> > -=============  =======  =======  =======  ============
> > -imm            offset   src_reg  dst_reg  opcode
> > -=============  =======  =======  =======  ============
> > +  opcode:8 src:4 dst:4 offset:16 imm:32 // In little-endian BPF.
> > +  opcode:8 dst:4 src:4 offset:16 imm:32 // In big-endian BPF.
> 
> I think those should be src_reg and dst_reg (as the register numbers)
> not src and dst (which are the values) or this will be a documentation
> regression.
> 
> Right now I think this is a regression since if I understand right, with this
> patch, "src" and "dst" now refer to both in different places which is
> confusing.

Fair enough -- this was my suggestion, and in hindsight I agree that it
would probably be best to avoid ambiguity by using src_reg and dst_reg
here. Apologies for the churn, Jose.

> 
> Dave
> 
> >  **imm**
> >    signed integer immediate value
> > @@ -54,48 +50,55 @@ imm            offset   src_reg  dst_reg  opcode
> >  **offset**
> >    signed integer offset used with pointer arithmetic
> > 
> > -**src_reg**
> > +**src**
> >    the source register number (0-10), except where otherwise specified
> >    (`64-bit immediate instructions`_ reuse this field for other purposes)
> > 
> > -**dst_reg**
> > +**dst**
> >    destination register number (0-10)
> > 
> >  **opcode**
> >    operation to perform
> > 
> > -and as follows for a big-endian processor:
> > +Note that the contents of multi-byte fields ('imm' and 'offset') are
> > +stored using big-endian byte ordering in big-endian BPF and
> > +little-endian byte ordering in little-endian BPF.
> > 
> > -=============  =======  =======  =======  ============
> > -32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
> > -=============  =======  =======  =======  ============
> > -imm            offset   dst_reg  src_reg  opcode
> > -=============  =======  =======  =======  ============
> > +For example::
> > 
> > -Multi-byte fields ('imm' and 'offset') are similarly stored in -the byte order of
> > the processor.
> > +  opcode         offset imm          assembly
> > +         src dst
> > +  07     0   1   00 00  44 33 22 11  r1 += 0x11223344 // little
> > +         dst src
> > +  07     1   0   00 00  11 22 33 44  r1 += 0x11223344 // big
> > 
> >  Note that most instructions do not use all of the fields.
> >  Unused fields shall be cleared to zero.
> > 
> > -As discussed below in `64-bit immediate instructions`_, a 64-bit immediate -
> > instruction uses a 64-bit immediate value that is constructed as follows.
> > -The 64 bits following the basic instruction contain a pseudo instruction -
> > using the same format but with opcode, dst_reg, src_reg, and offset all set to
> > zero, -and imm containing the high 32 bits of the immediate value.
> > +As discussed below in `64-bit immediate instructions`_, a 64-bit
> > +immediate instruction uses a 64-bit immediate value that is constructed
> > +as follows.  The 64 bits following the basic instruction contain a
> > +pseudo instruction using the same format but with opcode, dst, src, and
> > +offset all set to zero, and imm containing the high 32 bits of the
> > +immediate value.
> > 
> > -=================  ==================
> > -64 bits (MSB)      64 bits (LSB)
> > -=================  ==================
> > -basic instruction  pseudo instruction
> > -=================  ==================
> > +This is depicted in the following figure::
> > +
> > +        basic_instruction
> > +  .-----------------------------.
> > +  |                             |
> > +  code:8 regs:16 offset:16 imm:32 unused:32 imm:32
> > +                                  |              |
> > +                                  '--------------'
> > +                                 pseudo instruction
> > 
> >  Thus the 64-bit immediate value is constructed as follows:
> > 
> >    imm64 = (next_imm << 32) | imm
> > 
> >  where 'next_imm' refers to the imm value of the pseudo instruction -
> > following the basic instruction.
> > +following the basic instruction.  The unused bytes in the pseudo
> > +instruction are reserved and shall be cleared to zero.
> > 
> >  Instruction classes
> >  -------------------
> > @@ -137,7 +140,7 @@ code            source  instruction class
> >    source  value  description
> >    ======  =====  ==============================================
> >    BPF_K   0x00   use 32-bit 'imm' value as source operand
> > -  BPF_X   0x08   use 'src_reg' register value as source operand
> > +  BPF_X   0x08   use 'src' register value as source operand
> >    ======  =====  ==============================================
> > 
> >  **instruction class**
> > --
> > 2.30.2
> > 
> > --
> > Bpf mailing list
> > Bpf@ietf.org
> > https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww
> > .ietf.org%2Fmailman%2Flistinfo%2Fbpf&data=05%7C01%7Cdthaler%40micro
> > soft.com%7C65d83bf2fe834f73f84908db19067400%7C72f988bf86f141af91ab
> > 2d7cd011db47%7C1%7C0%7C638131287757978381%7CUnknown%7CTWFpb
> > GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> > Mn0%3D%7C3000%7C%7C%7C&sdata=8il1%2B8I1T8GBqn3U%2B7YJehIKjS6s
> > gvxTRWS2CTpg%2FZY%3D&reserved=0
