Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86A344B367
	for <lists+bpf@lfdr.de>; Tue,  9 Nov 2021 20:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243824AbhKITpI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Nov 2021 14:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243810AbhKITpH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Nov 2021 14:45:07 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0637C061764
        for <bpf@vger.kernel.org>; Tue,  9 Nov 2021 11:42:21 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id i11so12557121ilv.13
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 11:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CqTAQriJWxt9mAKXbU3F2fqXg6VvRaRE8bdJSKqe7ZM=;
        b=BTSC0YwhGhmkfCza/8E48z9JoCpAPakOi8MCko6A9rolYL1FU3G+1JEiNBVHJvjIz4
         uaCeCW2RwJ96H11DbkgqcIDEIRfnf9r4tQrG1RlhbZ94SlXeTYU9j4HhjUz/mMWkzP0S
         CaOGR5MS0W1eWYqsWCwSJrl446dZI9x3+eUKYT3ftVJWEytozxqVYCc4IV+I5QM04uFC
         QYnG087plfTQObX+TnoXJ3K7HkebLbRnydxwEA+QBpCtVUcUck/goNp5A7I3R3T0Rhmj
         UD2+oq7+zYG9Dtl8i0mbay/StAXQMsHUfQv2aY4kpI3Fkg/I0VodxoRmgOedbcBCqZNg
         pRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CqTAQriJWxt9mAKXbU3F2fqXg6VvRaRE8bdJSKqe7ZM=;
        b=1Q185zS4wq4frWF9Gf3fpIYob/xihoeDJT8kOPObYxSF6mF+1jKIc7UVjlKxdcj9mz
         /AewdV0txptpcdpdfjSFL+q/XAZNTO97SrIkaAYH5DiYSQYXGVi3Sjr8INsmOUOnZEgh
         GA3qu0paxpCrXxvBlCw8hLI8FJE1o63TxdlJgPmUthMIYYooStX0xiIeiNAKw+vpAXTD
         2qhWMx78Zh/GWOnGRP7K8kKehQV++SKEfo1ERfbZC9HV5SIUaQhtnHW3hh+4RaiYTi/I
         Ph4WpPCfED0dz1mD6GUUf8719D7HMfvinmr2AG/Sl8WUFLnMGyiEGPXj7zacvdilWWlg
         8Few==
X-Gm-Message-State: AOAM530iI1e65H+sPcaKzdHRt17XdFTwIQElXu78Pz35LQW5bslBMn7T
        OYYmroRUS2ON+ygMdte5Yqvrg0j6x4bpxgGA4t6log==
X-Google-Smtp-Source: ABdhPJz9piffFKdnFFVFajNggcN1uukLqExQ5VCF97RNO+/CCWW95QhzHOb2ku9J1f+XDGaZ53sOYVFkpuPZVMwTqu4=
X-Received: by 2002:a05:6e02:bc9:: with SMTP id c9mr7162004ilu.309.1636486940821;
 Tue, 09 Nov 2021 11:42:20 -0800 (PST)
MIME-Version: 1.0
References: <20211109021624.1140446-1-haoluo@google.com> <20211109182128.hhbaqv3j52fddayq@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20211109182128.hhbaqv3j52fddayq@ast-mbp.dhcp.thefacebook.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 9 Nov 2021 11:42:09 -0800
Message-ID: <CA+khW7hZC43ZrCSRL9SqffDPeDyxObzXtcvGneaEiW37=X11hA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/9] bpf: Clean up _OR_NULL arg types
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 9, 2021 at 10:21 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Nov 08, 2021 at 06:16:15PM -0800, Hao Luo wrote:
> > This is a pure cleanup patchset that tries to use flag to mark whether
> > an arg may be null. It replaces enum bpf_arg_type with a struct. Doing
> > so allows us to embed the properties of arguments in the struct, which
> > is a more scalable solution than introducing a new enum. This patchset
> > performs this transformation only on arg_type. If it looks good,
> > follow-up patches will do the same on reg_type and ret_type.
> >
> > The first patch replaces 'enum bpf_arg_type' with 'struct bpf_arg_type'
> > and each of the rest patches transforms one type of ARG_XXX_OR_NULLs.
>
> Nice. Thank you for working on it!

No problem. :)

>
> The enum->struct conversion works for bpf_arg_type, but applying
> the same technique to bpf_reg_type could be problematic.
> Since it's part of bpf_reg_state which in turn is multiplied by a large factor.
> Growing enum from 4 bytes to 8 byte struct will consume quite
> a lot of extra memory.
>
> >  19 files changed, 932 insertions(+), 780 deletions(-)
>
> Just bpf_arg_type refactoring adds a lot of churn which could make
> backports of future fixes not automatic anymore.
> Similar converstion for bpf_reg_type and bpf_return_type will
> be even more churn.

Acknowledged.

> Have you considered using upper bits to represent flags?

Yes, I thought about that. Some of my thoughts are:

- I wasn't sure how many bits should be reserved. Maybe 16 bits is good enough?
- What if we run out of flag bits in future?
- We could fold btf_id in the structure in this patchset. And new
fields could be easily added if needed.

So with these questions, I didn't pursue that approach in the first
place. But I admit that it does look better by writing

+      .arg3_type      = ARG_PTR_TO_STACK | MAYBE_NULL,

Instead of

+       .arg3    = {
+               .type = ARG_PTR_TO_MAP_VALUE,
+               .flag = ARG_FLAG_MAYBE_NULL,
+       },

Let's see if there is any further comment. I can go take a look and
prepare for that approach in the next revision.



>
> Instead of diff:
> -       .arg1_type      = ARG_CONST_MAP_PTR,
> -       .arg2_type      = ARG_PTR_TO_FUNC,
> -       .arg3_type      = ARG_PTR_TO_STACK_OR_NULL,
> -       .arg4_type      = ARG_ANYTHING,
> +       .arg1           = { .type = ARG_CONST_MAP_PTR },
> +       .arg2           = { .type = ARG_PTR_TO_FUNC },
> +       .arg3           = { .type = ARG_PTR_TO_STACK_OR_NULL },
> +       .arg4           = { .type = ARG_ANYTHING },
>
> can we make it look like:
>        .arg1_type      = ARG_CONST_MAP_PTR,
>        .arg2_type      = ARG_PTR_TO_FUNC,
> -      .arg3_type      = ARG_PTR_TO_STACK_OR_NULL,
> +      .arg3_type      = ARG_PTR_TO_STACK | MAYBE_NULL,
>        .arg4_type      = ARG_ANYTHING,
>
> Ideally all three (bpf_reg_type, bpf_return_type, and bpf_arg_type)
> would share the same flag bit: MAYBE_NULL.
> Then static bool arg_type_may_be_null() will be comparing only single bit ?
>
> While
>         if (arg_type == ARG_PTR_TO_MAP_VALUE ||
>             arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE ||
>             arg_type == ARG_PTR_TO_MAP_VALUE_OR_NULL) {
> will become:
>         arg_type &= FLAG_MASK;
>         if (arg_type == ARG_PTR_TO_MAP_VALUE ||
>             arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE) {
>
> Most of the time I would prefer explicit .type and .flag structure,
> but saving memory is important for bpf_reg_type, so explicit bit
> operations are probably justified.
