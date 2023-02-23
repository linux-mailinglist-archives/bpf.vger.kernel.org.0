Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B7D6A00F0
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 02:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjBWB47 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 20:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjBWB46 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 20:56:58 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56B01554A
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 17:56:56 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cy6so32464945edb.5
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 17:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z12wsZK5GhfTa4OhooSllN1ML732F8qYWNQXhciTebU=;
        b=DIJzdbbNEPELbtrbDmW+TNKk9kHJsX9AgXp4hMaykPdsLNtBk6l4DJvoCwiFRgwnFW
         18C7RwBmthWNycOvbUiKCYb6sYQfBPBLgzDxVXM3/hA4x4dkEuuPVKQ19WCrbMjphGqM
         98TKwC5EEPoP612vgCCs7sDrs27j8C/yPa0XPtBf2FGi0jA/JAxnKwlhnsJ075JSt+zv
         TnDowvBrXz5nk18Is1cW2WV4mYbWeZiRPbXzUbh7AL8Z1fzMWAwsNwtfc2Uo49NrhLYL
         OHptbC3f3zemmhQUTajBJ/Ot+qO6aVcsT2jBkS4SAC5wDOPQpoT4l9WhI7MddedrdY5I
         vAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z12wsZK5GhfTa4OhooSllN1ML732F8qYWNQXhciTebU=;
        b=jOP409KrGJdgk8+2h21hQ5BUyM2Q7kGzA4WR0FZGyMOwbmaZdpbremMUBXeHZD8k1T
         xUJJEObEJtQeHoKwZeTuUROYNT6CfGd7p0nbOWGNas8rlkTy0zoHXpYIgRBqfbFdFL3E
         pbUcLOZbdVMCF8D3J+1rvizRm49loFH2AYZtOvrjFZkrhVAn4uaHN8GzQ2VQV2d70959
         r2ec8hERnPAp/nkMAHmBXhI+BPVufkDSxMyNqFEZsW3EDR38ROWk8CC0SemAUmZrM3s7
         /sVLfs/VKszlk/+mwKOxJJKAB3TlEBxZ2t5UiUVuNzJ1dyHprQti0zUncM0PrnRZhIkz
         DWVA==
X-Gm-Message-State: AO0yUKViG/RxHyI+o/GCstzLzkp03N51QxVWHL05cPU6VgPJHOHdh+gV
        kGm6bnuAwChQpr4RB8KJW3kE6xIfU+cgvGneL/A=
X-Google-Smtp-Source: AK7set/rHv44Uqw6FrRf8y/oJZStDeAoC+yRC4LybwkvQvugUiK0XLr6zlTenfockp3rcYOpuVif6ITRnE6yNvG6SLQ=
X-Received: by 2002:a17:906:eb4d:b0:87b:dce7:c245 with SMTP id
 mc13-20020a170906eb4d00b0087bdce7c245mr8310707ejb.3.1677117415158; Wed, 22
 Feb 2023 17:56:55 -0800 (PST)
MIME-Version: 1.0
References: <20230220223742.1347-1-dthaler1968@googlemail.com>
 <CAADnVQ++hR7Cj3OXGLWpV_=4MnFndq5qS8r5b-YYPC_OB=gjQg@mail.gmail.com> <87ttzdwagy.fsf@oracle.com>
In-Reply-To: <87ttzdwagy.fsf@oracle.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 22 Feb 2023 17:56:43 -0800
Message-ID: <CAADnVQ+k5HrxJbpi17yeowsP9f92fSbnpSXfndMrZ8r=zhx1mg@mail.gmail.com>
Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Add explanation of endianness
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc:     Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>,
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

On Wed, Feb 22, 2023 at 3:23 PM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> > On Mon, Feb 20, 2023 at 2:37 PM Dave Thaler
> > <dthaler1968=40googlemail.com@dmarc.ietf.org> wrote:
> >>
> >> From: Dave Thaler <dthaler@microsoft.com>
> >>
> >> Document the discussion from the email thread on the IETF bpf list,
> >> where it was explained that the raw format varies by endianness
> >> of the processor.
> >>
> >> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> >>
> >> Acked-by: David Vernet <void@manifault.com>
> >> ---
> >>
> >> V1 -> V2: rebased on top of latest master
> >> ---
> >>  Documentation/bpf/instruction-set.rst | 16 ++++++++++++++--
> >>  1 file changed, 14 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> >> index af515de5fc3..1d473f060fa 100644
> >> --- a/Documentation/bpf/instruction-set.rst
> >> +++ b/Documentation/bpf/instruction-set.rst
> >> @@ -38,8 +38,9 @@ eBPF has two instruction encodings:
> >>  * the wide instruction encoding, which appends a second 64-bit immediate (i.e.,
> >>    constant) value after the basic instruction for a total of 128 bits.
> >>
> >> -The basic instruction encoding is as follows, where MSB and LSB mean the most significant
> >> -bits and least significant bits, respectively:
> >> +The basic instruction encoding looks as follows for a little-endian processor,
> >> +where MSB and LSB mean the most significant bits and least significant bits,
> >> +respectively:
> >>
> >>  =============  =======  =======  =======  ============
> >>  32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
> >> @@ -63,6 +64,17 @@ imm            offset   src_reg  dst_reg  opcode
> >>  **opcode**
> >>    operation to perform
> >>
> >> +and as follows for a big-endian processor:
> >> +
> >> +=============  =======  ====================  ===============  ============
> >> +32 bits (MSB)  16 bits  4 bits                4 bits           8 bits (LSB)
> >> +=============  =======  ====================  ===============  ============
> >> +immediate      offset   destination register  source register  opcode
> >> +=============  =======  ====================  ===============  ============
> >
> > I've changed it to:
> > imm            offset   dst_reg  src_reg  opcode
> >
> > to match the little endian table,
> > but now one of the tables feels wrong.
> > The encoding is always done by applying C standard to the struct:
> > struct bpf_insn {
> >         __u8    code;           /* opcode */
> >         __u8    dst_reg:4;      /* dest register */
> >         __u8    src_reg:4;      /* source register */
> >         __s16   off;            /* signed offset */
> >         __s32   imm;            /* signed immediate constant */
> > };
> > I'm not sure how to express this clearly in the table.
>
> Perhaps it would be simpler to document how the instruction bytes are
> stored (be it in an ELF file or as bytes in a memory buffer to be loaded
> into the kernel or some other BPF consumer) as opposed to how the
> instructions look like once loaded (as a 64-bit word) by a little-endian
> or big-endian kernel?
>
> Stored little-endian BPF instructions:
>
>   code src_reg dst_reg off imm
>
>   foo-le.o:     file format elf64-bpfle
>
>   0000000000000000 <.text>:
>      0:   07 01 00 00 ef be ad de         r1 += 0xdeadbeef
>
> Stored big-endian BPF instructions:
>
>   code dst_reg src_reg off imm
>
>   foo-be.o:     file format elf64-bpfbe
>
>   0000000000000000 <.text>:
>      0:   07 10 00 00 de ad be ef         r1 += 0xdeadbeef
>
> i.e. in the stored bytes the code always comes first, then the
> registers, then the offset, then the immediate, regardless of
> endianness.
>
> This may be easier to understand by implementors looking to generate
> and/or consume bytes conforming BPF instructions.

+1
I like this format more as well.
Maybe we can drop the table and use a diagram of a kind ?

opcode src dst offset imm          assembly
07     0   1   00 00  ef be ad de  r1 += 0xdeadbeef // little
07     1   0   00 00  de ad be ef  r1 += 0xdeadbeef // big
