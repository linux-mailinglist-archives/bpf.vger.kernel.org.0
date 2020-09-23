Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34F22754BF
	for <lists+bpf@lfdr.de>; Wed, 23 Sep 2020 11:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgIWJsD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Sep 2020 05:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgIWJsD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Sep 2020 05:48:03 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D442C0613CE
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 02:48:03 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id t76so24381399oif.7
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 02:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kp9DB3yJ7n4fOK/Le2BJ41nn7yEKAT/fFpyjwGbKsMI=;
        b=heQpS1w19H1RTHI6oZ7jzHtWgTjOZyjB+oHEUjaEO5MsegnRy6P9r4NBBf7M8gIuQj
         ZPazzp642YTXlXdvscMv+G+KCF7OOkrG4g+giPfgeGbgSDGZZSNMSuTJVLdQteUFKWNf
         nyBo9Yos1kscihElwDTU0Dof82hYkXY6o8l/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kp9DB3yJ7n4fOK/Le2BJ41nn7yEKAT/fFpyjwGbKsMI=;
        b=ojwv31VqmsarVugyoRWbjTNkcZ8lwp49/fT7Ux7h8SnuukEFMyhFrrx3wm4IJfm2Jr
         56tVhGnKflZju0xM8OGJWXsdfTrL+G+mdzkGY8h/L0H9voQ9qHbtBwrGpgeUc9LSX37+
         38KCbkwz8MovB0VIT44djbTJg+7sBbr+shq4ivgEnZ1aMWsaW2b9HqYN0AjTSAwGFuTg
         xAoNIxTA8kVQkm3f5pRrteIgWg7aXkI6glTmgOO1Z4DUx+6Nt+bsXnnDYVMiLvbJnlBh
         TuoEpCRXhcTOQ+oozhwgIidNxRKDvZ1LXj+3NiNQPepOHgEW8tWp5l6EDIHxC4CeHr8j
         wwsQ==
X-Gm-Message-State: AOAM532OSW46AZr+V1dPAS8xEC2+wVz980kIcg+XxAQhAs8dXkQnq+wB
        y27KK4FP9S8yRadaLMsg9GPe4Y1MLPRt/SsPdeZ8n+gDBpw=
X-Google-Smtp-Source: ABdhPJw3YAbMdYlUq9nhIyxrwRkQ+KL7befsxSwMfEZS1z9eQAjO1pJpmRqQKw3b6kcjcfvpWgVgYMavizM1/C7F0fM=
X-Received: by 2002:aca:3087:: with SMTP id w129mr4959586oiw.102.1600854482691;
 Wed, 23 Sep 2020 02:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200922070409.1914988-1-kafai@fb.com> <20200922070415.1916194-1-kafai@fb.com>
 <CACAyw9_wEMFuymvUC0fsZVJCH0vsvbD9p=CWTZC1jV2gUiu3KA@mail.gmail.com> <20200922183805.l2fjw462hukiel4n@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200922183805.l2fjw462hukiel4n@kafai-mbp.dhcp.thefacebook.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 23 Sep 2020 10:47:51 +0100
Message-ID: <CACAyw9_ZeCVTmF7XxTKEiK3aj47KaJ7Jb8JaTPTU2-XrXRutdw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 01/11] bpf: Move the PTR_TO_BTF_ID check to check_reg_type()
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 22 Sep 2020 at 19:38, Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Tue, Sep 22, 2020 at 10:56:55AM +0100, Lorenz Bauer wrote:
> > On Tue, 22 Sep 2020 at 08:04, Martin KaFai Lau <kafai@fb.com> wrote:
> > >
> > > check_reg_type() checks whether a reg can be used as an arg of a
> > > func_proto.  For PTR_TO_BTF_ID, the check is actually not
> > > completely done until the reg->btf_id is pointing to a
> > > kernel struct that is acceptable by the func_proto.
> > >
> > > Thus, this patch moves the btf_id check into check_reg_type().
> > > The compatible_reg_types[] usage is localized in check_reg_type() now.
> > >
> > > The "if (!btf_id) verbose(...); " is also removed since it won't happen.
> > >
> > > Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> > > ---
> > >  kernel/bpf/verifier.c | 65 +++++++++++++++++++++++--------------------
> > >  1 file changed, 35 insertions(+), 30 deletions(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 15ab889b0a3f..3ce61c412ea0 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -4028,20 +4028,29 @@ static const struct bpf_reg_types *compatible_reg_types[] = {
> > >         [__BPF_ARG_TYPE_MAX]            = NULL,
> > >  };
> > >
> > > -static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> > > -                         const struct bpf_reg_types *compatible)
> > > +static int check_reg_type(struct bpf_verifier_env *env, u32 arg,
> > > +                         enum bpf_arg_type arg_type,
> > > +                         const struct bpf_func_proto *fn)
> Yes. I think that works as good.
>
> An idea for the mid term, I think this map helper's arg override logic
> should belong to a new map_ops and this new map_ops can return the whole
> "fn" instead of overriding on an arg-by-arg base.

Yeah, agreed. I've had a similar idea, but no time to implement it yet.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
