Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E865F4D0B
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 02:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJEAaf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 20:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJEAad (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 20:30:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308BC564F0
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 17:30:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB207B81BEF
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 00:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F2BC433D6
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 00:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664929828;
        bh=loJfn5Cj6PRf82BtsQXIYthDpRs2NFNHyNMLP3wCI6g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ukZAhuHV8x7UNBOlxfKFrTRNdGVqKgugOu/Oui/EF9xv1UWms9N+iTlaQgyyUiWH0
         y44j11rKqkX6A+bhQZpy1wo4NCfZQ+VAWt2xaGISDBI1BQ98Iq3uhs3tGI66R7xQ29
         Vzpso/yvM+smcNP48asaveTftfIvIDnELxgBqcfvEgJS/6ex+elO+QRe1zV6IWHicG
         ymhierpNH1Pql31pC4ZAADHmaLqPn3RhuGTRFyIqF26oVpp4nbYRI/OQ5ugqy1OeVr
         gLC4sW9Cqwa+Fn6lE8QF93YcbWTnviWz2jo3Q3EWAdXuafbIDnAsWZoSjmjyepT6JO
         Z9jTGCI8VEj4Q==
Received: by mail-lf1-f51.google.com with SMTP id bp15so9944224lfb.13
        for <bpf@vger.kernel.org>; Tue, 04 Oct 2022 17:30:28 -0700 (PDT)
X-Gm-Message-State: ACrzQf37kmieX30Gdf0glHJMAdFFHR+UO7yyZJDN40d7mHEOVp4MwWWV
        UNej4zsbmW7jfn9eDPxWbRJhqJ5jZmGfgLOFoPwqGQ==
X-Google-Smtp-Source: AMsMyM5PUY18Rjl4wTLpLL35a95MNyEAlPKRsZM653LGLvzxAsM6MZ5uV4m31mSQH3xDzjBOYX5rdXqYdamR6Si7pGM=
X-Received: by 2002:ac2:5e63:0:b0:4a2:3f2a:818b with SMTP id
 a3-20020ac25e63000000b004a23f2a818bmr4276672lfr.398.1664929826355; Tue, 04
 Oct 2022 17:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221003011727.1192900-1-jmeng@fb.com> <CACYkzJ7_ZNKsE5b9ECqf7+U9qs8E2hbx4GXvAhrnG3iVApqLjg@mail.gmail.com>
 <YzutjPBbEYOPeEzG@fb.com>
In-Reply-To: <YzutjPBbEYOPeEzG@fb.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 5 Oct 2022 02:30:15 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5X-ShtGKHshSt74=5faZW5jWUBWyq7bzfs6x1f4jb65Q@mail.gmail.com>
Message-ID: <CACYkzJ5X-ShtGKHshSt74=5faZW5jWUBWyq7bzfs6x1f4jb65Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf,x64: Remove unnecessary check on existence
 of SSE2
To:     Jie Meng <jmeng@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 4, 2022 at 5:50 AM Jie Meng <jmeng@fb.com> wrote:
>
> On Tue, Oct 04, 2022 at 03:04:20AM +0200, KP Singh wrote:
> > On Mon, Oct 3, 2022 at 3:17 AM Jie Meng <jmeng@fb.com> wrote:
> > >
> > > SSE2 and hence lfence are architectural in x86-64 and no need to check
> > > whether they're supported in CPU.
> >
> > Why do you say this?
> >
> > The Instruction set reference does mention that:
> >
> > Exceptions:
> >
> > #UD If CPUID.01H:EDX.SSE2[bit 26] = 0
> >
> > (undefined instruction when the CPUID.SSE2 bit is unset)
> >
> > and also that the CPUID feature flag is SSE2
>
> Many x86 extensions predate x86-64. When they designed x86-64, AMD
> decided to make some mandatory (and hence architectural) and SSE2 is
> one of them[1]. CMOV, NOPL, PAE, NX etc. are other examples.
>
> These extensions' CPUID flags are still set. If code is to be shared
> between x86 and x86-64 one can still check CPUID, but bpf_jit_comp.c
> is compiled under x86-64 only so the check is redundant.
>
> There's an example Within kernel code too: arch/x86/lib/copy_user_64.S
> uses SSE (sfence) and SSE2 (movnti) instructions and doesn't check
> CPUID for their presence.
>

Thanks, it makes sense.

Can you please add the explanation to the commit description?

> ---
> [1] https://en.wikipedia.org/wiki/X86-64#Microarchitecture_levels
>
> > >
> > > Signed-off-by: Jie Meng <jmeng@fb.com>
> > > ---
> > >  arch/x86/net/bpf_jit_comp.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > > index d09c54f3d2e0..b2124521305e 100644
> > > --- a/arch/x86/net/bpf_jit_comp.c
> > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > @@ -1289,8 +1289,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
> > >
> > >                         /* speculation barrier */
> > >                 case BPF_ST | BPF_NOSPEC:
> > > -                       if (boot_cpu_has(X86_FEATURE_XMM2))
> > > -                               EMIT_LFENCE();
> > > +                       EMIT_LFENCE();
> > >                         break;
> > >
> > >                         /* ST: *(u8*)(dst_reg + off) = imm */
> > > --
> > > 2.30.2
> > >
