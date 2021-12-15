Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA22475F5E
	for <lists+bpf@lfdr.de>; Wed, 15 Dec 2021 18:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbhLORb2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Dec 2021 12:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245139AbhLORbG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Dec 2021 12:31:06 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E9DC08E88F;
        Wed, 15 Dec 2021 09:29:56 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id mj19so3121713pjb.3;
        Wed, 15 Dec 2021 09:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nc7uNBCccws9KsLZMQERR1/3Um+qbOa5VtfS7yT7osg=;
        b=MsOY7zSjDYQF/40hGnLECCSy/ZqdxR+vvp9+dauV40u2ELY2UDHo+nmijdQ6yVsCvv
         CpW23Pye3A/yNAI3/snmHyBp7RC+Lu+rJvGkIEoZ9xSBwgwMdxkbD1aWtBSnfqym3502
         /Db5xR7RSnELXi3gsow6A3A3CAZ+PwazysZlU1AgLRyQGLEuhUKZChXaPv39tbit425O
         reU6rBBxOLDXxHmCJxKP0wCplllD/midwlfTBD/mxypjcxyPwheSRLiUrJSbZ5ytf0rO
         Uya0KyYxMUoGhT+5XwjcEtbP5c5ck5t5bPAx+ScXkq2ypbFnUXwl9kmcPLlZZ4SvZNQo
         TLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nc7uNBCccws9KsLZMQERR1/3Um+qbOa5VtfS7yT7osg=;
        b=Aq2YX9K/CH1hX2lFQ4mrcFxiWH9t9ePUS71wjTPcv+Ja1/1bYugLx+wlZJrczL3rG5
         8CINpcBsZ5PzwymPMd4u2OcZ0GpFm/U2BbNHTwJZAkrWVdX2NftmBcatTpdShCVUcWUu
         W/dvP6LZOs26pg2tKaGRdcGdfcbCHifAzK3uC9xsK4BRalYRCni9/sqgA+fFcqkBG3Li
         HZhNsjkhDfyjBgghU8QUbbDV98gzxRBk2DaxJ3r6YrBUB9s8CLEfco1plFpXJ2r7RPzE
         Q0j9wwr3MvjrMvJonhnezp+lHO7f7fbOJB1vPpRTyxJOsNJ/aetIGwwBm+yGDF+0b/0k
         ncew==
X-Gm-Message-State: AOAM531vaGj7m+jdY3HwHPfpcCgGx8qfEpHaqWqX1LZiGfIe6j8rTeRo
        mw/hWMjuLFkZyWoouLHQ8FgWJs8Q3Ur4eRetOOKgK/PN8ak=
X-Google-Smtp-Source: ABdhPJzIiyuz1EaX306RNTkzvorH01oFLWmQLAlD9XIeqmTInyrBPe04eIdwDGHLVtl+62pZtgk04Ih6Smk+5oriUTs=
X-Received: by 2002:a17:902:da8a:b0:148:a2e7:fb33 with SMTP id
 j10-20020a170902da8a00b00148a2e7fb33mr5243907plx.116.1639589395901; Wed, 15
 Dec 2021 09:29:55 -0800 (PST)
MIME-Version: 1.0
References: <20211210172034.13614-1-mcroce@linux.microsoft.com>
 <CAADnVQJRVpL0HL=Lz8_e-ZU5y0WrQ_Z0KvQXF2w8rE660Jr62g@mail.gmail.com> <CAFnufp33Dm_5gffiFYQ+Maf4Bj9fE3WLMpFf3cJ=F5mm71mTEQ@mail.gmail.com>
In-Reply-To: <CAFnufp33Dm_5gffiFYQ+Maf4Bj9fE3WLMpFf3cJ=F5mm71mTEQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 15 Dec 2021 09:29:44 -0800
Message-ID: <CAADnVQ+OeO=f1rzv_F9HFQmJCcJ7=FojkOuZWvx7cT-XLjVDcQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: limit bpf_core_types_are_compat() recursion
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 15, 2021 at 6:54 AM Matteo Croce <mcroce@linux.microsoft.com> wrote:
> >
> > Maybe do a level check here?
> > Since calling it and immediately returning doesn't conserve
> > the stack.
> > If it gets called it can finish fine, but
> > calling it again would be too much.
> > In other words checking the level here gives us
> > room for one more frame.
> >
>
> I thought that the compiler was smart enough to return before
> allocating most of the frame.
> I tried and this is true only with gcc, not with clang.

Interesting. That's a surprise.
Could you share the asm that gcc generates?

> > > +                       err = __bpf_core_types_are_compat(local_btf, local_id,
> > > +                                                         targ_btf, targ_id,
> > > +                                                         level - 1);
> > > +                       if (err <= 0)
> > > +                               return err;
> > > +               }
> > > +
> > > +               /* tail recurse for return type check */
> > > +               btf_type_skip_modifiers(local_btf, local_type->type, &local_id);
> > > +               btf_type_skip_modifiers(targ_btf, targ_type->type, &targ_id);
> > > +               goto recur;
> > > +       }
> > > +       default:
> > > +               pr_warn("unexpected kind %s relocated, local [%d], target [%d]\n",
> > > +                       btf_type_str(local_type), local_id, targ_id);
> >
> > That should be bpf_log() instead.
> >
>
> To do that I need a struct bpf_verifier_log, which is not present
> there, neither in bpf_core_spec_match() or bpf_core_apply_relo_insn().

It is there. See:
        err = bpf_core_apply_relo_insn((void *)ctx->log, insn, ...

> Should we drop the message at all?

Passing it into bpf_core_spec_match() and further into
bpf_core_types_are_compat() is probably unnecessary.
All callers have an error check with a log right after.
So I think we won't lose anything if we drop this log.

>
> > > +               return 0;
> > > +       }
> > > +}
> >
> > Please add tests that exercise this logic by enabling
> > additional lskels and a new test that hits the recursion limit.
> > I suspect we don't have such case in selftests.
> >
> > Thanks!
>
> Will do!

Thanks!
