Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC765A2F90
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 21:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243877AbiHZTCE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 15:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344267AbiHZTCB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 15:02:01 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955ED4B0C3
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 12:01:59 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-33dbbf69b3dso59012167b3.1
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 12:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5IGsFt88U29g0FS5xaHF37h09E8wApZqucl8B7a7urU=;
        b=NZ/IN3QHe1a9yv4nNj3dXDoQEezOohx3Y28Yw3TJWGSSiiN3cUtJlsU4Y0glp/12jc
         a0FGOhIHCUpiu0+ed3TwJY8aVLdep/em/CfPOZy0LLh+R7iXzSxn7l35VkxZBRZ5fvRo
         Zh3R2RbmKf0njkKWnyy3ElIwwssUsSL5tu7PjR1jH+eyi8D9ZpO9+PeS4QGhi0bEmRUN
         LnKa7MUGyOfG4kF8R40+C7twpS/m0Hgy4jZFNjRGHjmmVGB0tctbbl21AB4DYrBKPHvM
         60AtPTr04C6bV0xj+uh3LYbP69aVlToxjPJnqv1MTfG296dIdlEKZYPsXr38XtjSy62r
         zl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5IGsFt88U29g0FS5xaHF37h09E8wApZqucl8B7a7urU=;
        b=fv6QihHJLcfCDvMZM4DV08pYBHRkkPp/Y1l+nY4XTyKKqnwUo0NVSLaLeCaa33aKJC
         xSxmbBT7k97pS52tmLGuESomobXpu9uPGF14+BnN5TpBJpJEg2fXuf4wu0T65ybW46QT
         q5DfhC8u7bpykskBMyUDLkOhVzeNc21d5BoHvan1Z8ChwhKIynorBeDO6c34s7oxn7Ix
         bxSq3ZpXTmu0z/oc3hfYd0zI1R5+kNZa6RbNd9IVuv7gOSZW01PGqwitmvGdahYaZZ4i
         0dWL2EZKwLCXYZ6gOCl+LTYeu0Wf9sZi6kvq/8aksZiyz3SNfv5vsf4PAGnvX0RXKJis
         y9Xg==
X-Gm-Message-State: ACgBeo0jOxFkzNVyRVvwcYh/QOLpbJYUntp/8wpn9PZkvE7XBHLSkWet
        s0tFBSEyQNcLtfBDAMnLHYzZGgS/UteG4XEeQajkhw==
X-Google-Smtp-Source: AA6agR4uxOHFjT5D1AMN44XQ9iAS6JWEcXawPAt7q0Qtb27j+Gm7+llYNa1lyrnJhLcDNddcjsCmIFnqV2eyMU8iV1A=
X-Received: by 2002:a81:430f:0:b0:33f:c37f:83bd with SMTP id
 q15-20020a81430f000000b0033fc37f83bdmr1235560ywa.438.1661540518831; Fri, 26
 Aug 2022 12:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <1661479927-6953-1-git-send-email-yangtiezhu@loongson.cn> <e785ac4b-c1d6-e9e9-df2f-869e474e18ba@iogearbox.net>
In-Reply-To: <e785ac4b-c1d6-e9e9-df2f-869e474e18ba@iogearbox.net>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Fri, 26 Aug 2022 21:01:46 +0200
Message-ID: <CAM1=_QSNWm0AFA5gXE78ayafayJVQ3MNXjh8ttD-zkG7N6Y+1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, mips: No need to use min() to get MAX_TAIL_CALL_CNT
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        bpf@vger.kernel.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 26, 2022 at 6:18 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 8/26/22 4:12 AM, Tiezhu Yang wrote:
> > MAX_TAIL_CALL_CNT is 33, so min(MAX_TAIL_CALL_CNT, 0xffff) is always
> > MAX_TAIL_CALL_CNT, it is better to use MAX_TAIL_CALL_CNT directly.
> >
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> >   arch/mips/net/bpf_jit_comp32.c | 2 +-
> >   arch/mips/net/bpf_jit_comp64.c | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/mips/net/bpf_jit_comp32.c b/arch/mips/net/bpf_jit_comp32.c
> > index 83c975d..8fee671 100644
> > --- a/arch/mips/net/bpf_jit_comp32.c
> > +++ b/arch/mips/net/bpf_jit_comp32.c
> > @@ -1381,7 +1381,7 @@ void build_prologue(struct jit_context *ctx)
> >        * 16-byte area in the parent's stack frame. On a tail call, the
> >        * calling function jumps into the prologue after these instructions.
> >        */
> > -     emit(ctx, ori, MIPS_R_T9, MIPS_R_ZERO, min(MAX_TAIL_CALL_CNT, 0xffff));
>
> I presume this is the max that can be encoded, right? Maybe just convert this
> to a BUILD_BUG_ON(MAX_TAIL_CALL_CNT > 0xffff) with a comment on why the assertion
> is there?

Correct. The min() is there for a reason. In the unlikely event that
the TCC limit is raised to more than 16 bits, it is clamped to the
maximum value allowed for the generated code (0xffff). One can argue
that it is better fail to compile instead of degrading gracefully, but
some kind check should be there IMO.

>
> > +     emit(ctx, ori, MIPS_R_T9, MIPS_R_ZERO, MAX_TAIL_CALL_CNT);
> >       emit(ctx, sw, MIPS_R_T9, 0, MIPS_R_SP);
> >
> >       /*
> > diff --git a/arch/mips/net/bpf_jit_comp64.c b/arch/mips/net/bpf_jit_comp64.c
> > index 6475828..ac175af 100644
> > --- a/arch/mips/net/bpf_jit_comp64.c
> > +++ b/arch/mips/net/bpf_jit_comp64.c
> > @@ -552,7 +552,7 @@ void build_prologue(struct jit_context *ctx)
> >        * On a tail call, the calling function jumps into the prologue
> >        * after this instruction.
> >        */
> > -     emit(ctx, ori, tc, MIPS_R_ZERO, min(MAX_TAIL_CALL_CNT, 0xffff));
> > +     emit(ctx, ori, tc, MIPS_R_ZERO, MAX_TAIL_CALL_CNT);
> >
> >       /* === Entry-point for tail calls === */
> >
> >
>
