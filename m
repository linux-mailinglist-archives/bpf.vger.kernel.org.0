Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15906A0E21
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 17:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjBWQlA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 11:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjBWQk7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 11:40:59 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189E242BEF
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 08:40:58 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id s26so44288172edw.11
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 08:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JaSR1DIeq7GWB7ZJN+jYQO8Ilh3aVyT+nGtvSfvJ2HM=;
        b=DEQYd8op/PkW0knVv2p40VV+pwfLY8wD641zCyfep0GCo2LmeRw/XPCMG0NDVLsk7K
         sCjkbBDBAUhCK8ldaFQFzarPgOT9GxEjGamOZbA8FNTcyotbwqcT2ad30ghCj7D+iFh4
         vJnME/wRL1s/Iam5G834TYBOHKAWfnhpwLUo8pTXL5sZKU0wFjaCNVWcUZ9FCKo27Q8U
         LZ3ZyFlfQVVsR639aWgqpQitoL96zleQfdEnUWFPnx/U3Z9xRdGnI/D3ioEwBuZvkHp3
         2cT4DIJJ+gUobt/Oq2ralHR5f677583idarXLN4IbeG5dtoV4bnJpG90LGUkuJnRFIpn
         WgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JaSR1DIeq7GWB7ZJN+jYQO8Ilh3aVyT+nGtvSfvJ2HM=;
        b=RavprxvPZzyX4/UbIYShfSkPdVIyRWQX173Awm1e5U5ljTuWo5mG59j1UZJf49gPGI
         kmWdG1/XJ2MEqbRrS4OjtTDABTOTzMr5Yd8odOZnCgrg2BIqcUTKv7fExHiv1CqJQeo9
         RIQ6/iMQUSwdAYiWmuDdETz6ufrBrRjAG5iHfSi6XmWBA6m1EaKLquDicA5mw19DJ0Z+
         fNBE5Cm0PnZPUSeOdAKonF3dTHFZtq2hCfAiyk+NlnSNb2LfKBVsEHc8MRAplX9Lf5K2
         Bja6kCb/ja7q78i7+OvNOZc76Z3pN2IfOyiTpvZHFEMVKNI04houMsvmtskmK7s0O2RA
         O5nA==
X-Gm-Message-State: AO0yUKXdcjydCbS2VkxC9k/PaJzz1NyT/Ooo42l0NxfS/oKxMmGlvVT6
        lZFg4E9agtP11Bn0ftJduKWPJT3SEYePdUVRe0c=
X-Google-Smtp-Source: AK7set/lLKvbI1+C8WkZqPBQhK8jeUBmUJb+q+8xBN8RS7xYpO9pPIRlLu062eEhltMK2hB0oLswQAoFUVRcYPz6gHQ=
X-Received: by 2002:a50:d51d:0:b0:4ac:b618:7fb1 with SMTP id
 u29-20020a50d51d000000b004acb6187fb1mr5612468edi.6.1677170456292; Thu, 23 Feb
 2023 08:40:56 -0800 (PST)
MIME-Version: 1.0
References: <20230220223742.1347-1-dthaler1968@googlemail.com>
 <CAADnVQ++hR7Cj3OXGLWpV_=4MnFndq5qS8r5b-YYPC_OB=gjQg@mail.gmail.com>
 <87ttzdwagy.fsf@oracle.com> <CAADnVQ+k5HrxJbpi17yeowsP9f92fSbnpSXfndMrZ8r=zhx1mg@mail.gmail.com>
 <87bklkseo4.fsf@gnu.org>
In-Reply-To: <87bklkseo4.fsf@gnu.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 23 Feb 2023 08:40:44 -0800
Message-ID: <CAADnVQKoUD7nvmfcEbEsbLZj7gwd0uNdJZ-ZwLtmv7P+47K1ew@mail.gmail.com>
Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Add explanation of endianness
To:     "Jose E. Marchesi" <jemarch@gnu.org>
Cc:     "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>,
        bpf <bpf@vger.kernel.org>, bpf@ietf.org,
        Dave Thaler <dthaler@microsoft.com>,
        David Vernet <void@manifault.com>
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

On Thu, Feb 23, 2023 at 5:19 AM Jose E. Marchesi <jemarch@gnu.org> wrote:
>
>
> > On Wed, Feb 22, 2023 at 3:23 PM Jose E. Marchesi
> > <jose.marchesi@oracle.com> wrote:
> >>
> >>
> >> > On Mon, Feb 20, 2023 at 2:37 PM Dave Thaler
> >> > <dthaler1968=40googlemail.com@dmarc.ietf.org> wrote:
> >> >>
> >> >> From: Dave Thaler <dthaler@microsoft.com>
> >> >>
> >> >> Document the discussion from the email thread on the IETF bpf list,
> >> >> where it was explained that the raw format varies by endianness
> >> >> of the processor.
> >> >>
> >> >> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> >> >>
> >> >> Acked-by: David Vernet <void@manifault.com>
> >> >> ---
> >> >>
> >> >> V1 -> V2: rebased on top of latest master
> >> >> ---
> >> >>  Documentation/bpf/instruction-set.rst | 16 ++++++++++++++--
> >> >>  1 file changed, 14 insertions(+), 2 deletions(-)
> >> >>
> >> >> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> >> >> index af515de5fc3..1d473f060fa 100644
> >> >> --- a/Documentation/bpf/instruction-set.rst
> >> >> +++ b/Documentation/bpf/instruction-set.rst
> >> >> @@ -38,8 +38,9 @@ eBPF has two instruction encodings:
> >> >>  * the wide instruction encoding, which appends a second 64-bit immediate (i.e.,
> >> >>    constant) value after the basic instruction for a total of 128 bits.
> >> >>
> >> >> -The basic instruction encoding is as follows, where MSB and LSB mean the most significant
> >> >> -bits and least significant bits, respectively:
> >> >> +The basic instruction encoding looks as follows for a little-endian processor,
> >> >> +where MSB and LSB mean the most significant bits and least significant bits,
> >> >> +respectively:
> >> >>
> >> >>  =============  =======  =======  =======  ============
> >> >>  32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
> >> >> @@ -63,6 +64,17 @@ imm            offset   src_reg  dst_reg  opcode
> >> >>  **opcode**
> >> >>    operation to perform
> >> >>
> >> >> +and as follows for a big-endian processor:
> >> >> +
> >> >> +=============  =======  ====================  ===============  ============
> >> >> +32 bits (MSB)  16 bits  4 bits                4 bits           8 bits (LSB)
> >> >> +=============  =======  ====================  ===============  ============
> >> >> +immediate      offset   destination register  source register  opcode
> >> >> +=============  =======  ====================  ===============  ============
> >> >
> >> > I've changed it to:
> >> > imm            offset   dst_reg  src_reg  opcode
> >> >
> >> > to match the little endian table,
> >> > but now one of the tables feels wrong.
> >> > The encoding is always done by applying C standard to the struct:
> >> > struct bpf_insn {
> >> >         __u8    code;           /* opcode */
> >> >         __u8    dst_reg:4;      /* dest register */
> >> >         __u8    src_reg:4;      /* source register */
> >> >         __s16   off;            /* signed offset */
> >> >         __s32   imm;            /* signed immediate constant */
> >> > };
> >> > I'm not sure how to express this clearly in the table.
> >>
> >> Perhaps it would be simpler to document how the instruction bytes are
> >> stored (be it in an ELF file or as bytes in a memory buffer to be loaded
> >> into the kernel or some other BPF consumer) as opposed to how the
> >> instructions look like once loaded (as a 64-bit word) by a little-endian
> >> or big-endian kernel?
> >>
> >> Stored little-endian BPF instructions:
> >>
> >>   code src_reg dst_reg off imm
> >>
> >>   foo-le.o:     file format elf64-bpfle
> >>
> >>   0000000000000000 <.text>:
> >>      0:   07 01 00 00 ef be ad de         r1 += 0xdeadbeef
> >>
> >> Stored big-endian BPF instructions:
> >>
> >>   code dst_reg src_reg off imm
> >>
> >>   foo-be.o:     file format elf64-bpfbe
> >>
> >>   0000000000000000 <.text>:
> >>      0:   07 10 00 00 de ad be ef         r1 += 0xdeadbeef
> >>
> >> i.e. in the stored bytes the code always comes first, then the
> >> registers, then the offset, then the immediate, regardless of
> >> endianness.
> >>
> >> This may be easier to understand by implementors looking to generate
> >> and/or consume bytes conforming BPF instructions.
> >
> > +1
> > I like this format more as well.
> > Maybe we can drop the table and use a diagram of a kind ?
> >
> > opcode src dst offset imm          assembly
> > 07     0   1   00 00  ef be ad de  r1 += 0xdeadbeef // little
> > 07     1   0   00 00  de ad be ef  r1 += 0xdeadbeef // big
>
> Good idea.  What about something like this:
>
> opcode         offset imm          assembly
>        src dst
> 07     0   1   00 00  44 33 22 11  r1 += 0x11223344 // little
>        dst src
> 07     1   0   00 00  11 22 33 44  r1 += 0x11223344 // big
>
> I changed the immediate because 0xdeadbeef is negative and it may be
> confusing in the assembly part: strictly it would be r1 += -559038737.

Looks great to me. Do you want to send your first kernel patch? :)
