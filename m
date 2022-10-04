Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1E05F46CE
	for <lists+bpf@lfdr.de>; Tue,  4 Oct 2022 17:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiJDPiU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 11:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJDPiT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 11:38:19 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60316349AB
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 08:38:17 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w10so6475334edd.4
        for <bpf@vger.kernel.org>; Tue, 04 Oct 2022 08:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=BJgO1iQbcfH8XSBJlfGX8gUcZzdIlfsiXDnfR/9iE/8=;
        b=UxP0yTdQjAP7tlDbia4wjsYwzrjaa3G81Y7Mwcu7GYZPdwrIAYGmYtrU78HKOPZVXF
         w3Ss3EUHrpP8Sn62zu1l8YvE1WFrnXBN+BsINaGnmmFvN3qfEFs8erth2dxLnkAtoSg9
         VQPssFTLiK9QsQYR+qfWlcb6hTCTxKifOva9wk7zH70GSI7jXxpjGMtjGhZiL1sjHzDH
         IzcryfZHlitsRvlUcSADFAOQuri9y2Gx1MSDv9+5+JJeWCBXkJIqYgrRb6pS4X4CKNm6
         V1g4J8WsO44omVjijF5TRGbZRSsf0Wzr4dyWHbfoSsmPy64IkrsJc7pc4FuQRTSDGL2w
         sTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=BJgO1iQbcfH8XSBJlfGX8gUcZzdIlfsiXDnfR/9iE/8=;
        b=xMmMtKCilBIHmkHopHo5J+QWayopUDglMTu86ItIfVemNzN2PNbewBlUCN1TOYxJST
         IbMnV55Cha2rvywJuwbWlbRihbNl4C+Ajqs6YuJpBln9YEOMqpaKCX5HdjZuHVBhGp0G
         HBw2DPBXRvdubLC9Y/7o+Ff/0E1Wi+Cow2KD60Bseh+h8M691okndvHEBuYuG4u4Ssdv
         impL2W0Fg6KAbVZzKohXRV53C6pWzZbR1qqX9Jj/rAtw8cAn0N3MtF1VsTIp7l9XcBjP
         aiCxe0MLIO37Uep/XVYUyuE/QY68qzkT/78h2DVwXo1Ngw+KAU0hLr39pdIrUOPopHJ7
         OvaA==
X-Gm-Message-State: ACrzQf274DPZxmacXyV62iTVu+yBnudQ2Hu4ED3JrrnEp8yRSdjNCthB
        V3cO7I/jbPxFi6nEKJ9HSWY74hOpgRAWBaCEfnE=
X-Google-Smtp-Source: AMsMyM5BqdKflyZ+RzCWCD9tQppWouQWjU1V4dAKx1Jt74tNxW1Q+AMprwiHdU+phPcEGVmZb2L/eFvcowb+9RgnVX4=
X-Received: by 2002:a05:6402:22c7:b0:459:487c:b077 with SMTP id
 dm7-20020a05640222c700b00459487cb077mr4636616edb.66.1664897895759; Tue, 04
 Oct 2022 08:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-11-dthaler1968@googlemail.com> <20220930221624.mqjrzmdxc6etkadm@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB3440664B3010ECDDCF9731D1A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
In-Reply-To: <DM4PR21MB3440664B3010ECDDCF9731D1A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 4 Oct 2022 08:38:04 -0700
Message-ID: <CAADnVQJQvdN2Dm7pwMno59EhMB6XT35RLMY4+w_xhauJ0sdtAQ@mail.gmail.com>
Subject: Re: [PATCH 11/15] ebpf-docs: Improve English readability
To:     Dave Thaler <dthaler@microsoft.com>
Cc:     "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 4, 2022 at 7:32 AM Dave Thaler <dthaler@microsoft.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > > +The eBPF instruction set consists of eleven 64 bit registers, a
> > > +program counter, and 512 bytes of stack space.
> >
> > I would not add 512 to a doc.
> > That's what we have now, but we might relax that in the future.
>
> I think it's important to at least give a minimum.  Will change to
> "at least 512".

I'm not sure 512 stands as a minimum either.
When we have the gatekeeper prog it will be able to enforce
any stack size.

> [...]
> > > +Registers R0 - R5 are scratch registers, meaning the BPF program
> > > +needs to either spill them to the BPF stack or move them to callee
> > > +saved registers if these arguments are to be reused across multiple
> > > +function calls. Spilling means that the value in the register is
> > > +moved to the BPF stack. The reverse operation of moving the variable
> > from the BPF stack to the register is called filling.
> > > +The reason for spilling/filling is due to the limited number of registers.
> >
> > More canonical way would be to say that r0-r5 are caller saved.
>
> Will change "scratch" to "caller-saved"
>
> [...]
> > > -``BPF_ADD | BPF_X | BPF_ALU64`` means::
> > > +``BPF_ADD | BPF_X | BPF_ALU64`` (0x0f) means::
> >
> > I don't think adding hex values help here.
>
> I found it very helpful in verifying that the Appendix table
> was correct, and providing a correlation to the text here
> that shows the construction of the value.  So I'd like to keep them.

I think that means that the appendix table shouldn't be there either.
I'd like to avoid both.

> [...]
> > > -The 1-bit source operand field in the opcode is used to to select
> > > what byte -order the operation convert from or to:
> > > +Byte swap instructions use non-default semantics of the 1-bit
> > > +'source' field in
> >
> > I would drop 'non-default'. Many fields have different meanings depending
> > on opcode.
> > BPF_SRC() macro just reads that bit.
>
> Will reword to say:
> Byte swap instructions use the 1-bit 'source' field in the 'opcode' field
> as follows.  Instead of indicating the source operator, it is instead
> used to select what byte order the operation converts from or to:

makes sense.

> [...]
> > > +* mnenomic indicates a short form that might be displayed by some
> > > +tools such as disassemblers
> > > +* 'htoleNN()' indicates converting a NN-bit value from host byte
> > > +order to little-endian byte order
> > > +* 'htobeNN()' indicates converting a NN-bit value from host byte
> > > +order to big-endian byte order
> >
> > I think we need to add normal bswap insn.
> > These to_le and to_be are very awkward to use.
> > As soon as we have new insn the compiler will be using it.
> > There is no equivalent of to_be and to_le in C. It wasn't good ISA design.
>
> I will interpret this as a request for someone to do code work, rather
> than any request for immediately changes to the doc :)
>
> [...]
> > >  Regular load and store operations
> > >  ---------------------------------
> > >
> > >  The ``BPF_MEM`` mode modifier is used to encode regular load and
> > > store  instructions that transfer data between a register and memory.
> > >
> > > -``BPF_MEM | <size> | BPF_STX`` means::
> > > -
> > > -  *(size *) (dst + offset) = src_reg
> > > -
> > > -``BPF_MEM | <size> | BPF_ST`` means::
> > > -
> > > -  *(size *) (dst + offset) = imm32
> > > -
> > > -``BPF_MEM | <size> | BPF_LDX`` means::
> > > -
> > > -  dst = *(size *) (src + offset)
> > > -
> > > -Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW``.
> > > +=============================  =========
> > ====================================
> > > +opcode construction            opcode     pseudocode
> > > +=============================  =========
> > ====================================
> > > +BPF_MEM | BPF_B | BPF_LDX      0x71       dst = \*(uint8_t \*) (src + offset)
> > > +BPF_MEM | BPF_H | BPF_LDX      0x69       dst = \*(uint16_t \*) (src +
> > offset)
> > > +BPF_MEM | BPF_W | BPF_LDX      0x61       dst = \*(uint32_t \*) (src +
> > offset)
> > > +BPF_MEM | BPF_DW | BPF_LDX     0x79       dst = \*(uint64_t \*) (src +
> > offset)
> > > +BPF_MEM | BPF_B | BPF_ST       0x72       \*(uint8_t \*) (dst + offset) = imm
> > > +BPF_MEM | BPF_H | BPF_ST       0x6a       \*(uint16_t \*) (dst + offset) =
> > imm
> > > +BPF_MEM | BPF_W | BPF_ST       0x62       \*(uint32_t \*) (dst + offset) =
> > imm
> > > +BPF_MEM | BPF_DW | BPF_ST      0x7a       \*(uint64_t \*) (dst + offset) =
> > imm
> > > +BPF_MEM | BPF_B | BPF_STX      0x73       \*(uint8_t \*) (dst + offset) = src
> > > +BPF_MEM | BPF_H | BPF_STX      0x6b       \*(uint16_t \*) (dst + offset) =
> > src
> > > +BPF_MEM | BPF_W | BPF_STX      0x63       \*(uint32_t \*) (dst + offset) =
> > src
> > > +BPF_MEM | BPF_DW | BPF_STX     0x7b       \*(uint64_t \*) (dst + offset) =
> > src
> > > +=============================  =========
> > > +====================================
> >
> > I think the table is more verbose and less readable than the original text.
>
> Will change back to original text.

Please see git. I've removed that table. Please don't add it back.
I see no value in such tables other than more things to get wrong.
