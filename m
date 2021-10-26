Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0527443AB9A
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 07:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbhJZFRR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 01:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbhJZFRR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 01:17:17 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E169FC061745
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 22:14:53 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id i65so31017872ybb.2
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 22:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zQJUeT00AuM/8uM0hhmJqdvPo2FG+9CaeodJxLhMSJs=;
        b=Bp0NPR1X/JMTVEH2X125QU9QrKYDDbF4wNNEppQzmEYtHQZ03vSJhQ/2sP3LbDs0/d
         sHTFe0gHzl7ISlNx39nxwCwdOr4/SATWxa5slPiZHisX4RZKBhvzWOz4w7dXfY3Rz8St
         BcflTTgZdPfhYL74jRK0/bFplzcBJ8OaBAMLN7EQ5pNK+k45odTEnZg7XVKLFWIXKIv1
         LzdMSvd9CjwXBhVmvehLho8jNBG5zjZKOOlKQGHxAyWKMNf329Lc7gJogfjPixjVP6UT
         Iu3S9H8G/5YGvluzcXrlmrQ9GIhJjtQy3xQ0xdQivNYXpb2HPkz3Ws7GBnuo1WcWAmkf
         ec/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zQJUeT00AuM/8uM0hhmJqdvPo2FG+9CaeodJxLhMSJs=;
        b=vCjvts8Bj+8A59dMcBBZ0LkI4G9EykZHaNVkCbDtMRIpcHB6/IMV25zUNtHJLBcWyl
         OH0lTV21ygXUSOvIJst6vXj3psjescI4Dw9oYBJgwWibmeBg+vwLby8Q9YuNwkdWnV8Q
         dVNwdtn2qVzwrN56jBGgWaTc8JKCXFLX4EphxX5uMe/nl00kMQeNk6KJKBnoYNdBZ2+P
         lkoRBiF6j2EzPlbtjtYSA1ekOMzdhAn1r3ubSN47DQrxXIgNEfG/4RKNIObbWKIwEmvk
         V1dTiSNYoZzFT6fEKz2uw5LAqVwy0XlXaPd7aJgK++hAYUesEoCEt/KmOPtUKGKGdStd
         bepQ==
X-Gm-Message-State: AOAM533VN6p22jZ9Z35ysZpllY/2LxDxGU+IsGpsWEVkqJU5aWvWpbd2
        Hd2Ju9bPrG4ns74VWm2WRUeSvmkzPHSVpq0NAq0=
X-Google-Smtp-Source: ABdhPJxDTuH2WUd3m1HoqbvRlGuoqz8iu/j3tlskLcECYS6A1l4q/76RVb7ud1zU9Znf6fdx0n0+yfeedWxdj/Tp5y4=
X-Received: by 2002:a05:6902:701:: with SMTP id k1mr12100007ybt.225.1635225293158;
 Mon, 25 Oct 2021 22:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211025231256.4030142-1-haoluo@google.com> <20211025231256.4030142-3-haoluo@google.com>
 <20211026034854.3ozkpaxaok7hk6kn@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20211026034854.3ozkpaxaok7hk6kn@ast-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 25 Oct 2021 22:14:42 -0700
Message-ID: <CAEf4BzbvXQ1qpGazNKCBhzUUPmmfe9d9icDtf++weJkJmme0aw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Introduce ARG_PTR_TO_WRITABLE_MEM
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 25, 2021 at 8:48 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Oct 25, 2021 at 04:12:55PM -0700, Hao Luo wrote:
> > Some helper functions may modify its arguments, for example,
> > bpf_d_path, bpf_get_stack etc. Previously, their argument types
> > were marked as ARG_PTR_TO_MEM, which is compatible with read-only
> > mem types, such as PTR_TO_RDONLY_BUF. Therefore it's legitimate
> > to modify a read-only memory by passing it into one of such helper
> > functions.
> >
> > This patch introduces a new arg type ARG_PTR_TO_WRITABLE_MEM to
> > annotate the arguments that may be modified by the helpers. For
> > arguments that are of ARG_PTR_TO_MEM, it's ok to take any mem type,
> > while for ARG_PTR_TO_WRITABLE_MEM, readonly mem reg types are not
> > acceptable.
> >
> > In short, when a helper may modify its input parameter, use
> > ARG_PTR_TO_WRITABLE_MEM instead of ARG_PTR_TO_MEM.
> >
> > So far the difference between ARG_PTR_TO_MEM and ARG_PTR_TO_WRITABLE_MEM
> > is PTR_TO_RDONLY_BUF and PTR_TO_RDONLY_MEM. PTR_TO_RDONLY_BUF is
> > only used in bpf_iter prog as the type of key, which hasn't been
> > used in the affected helper functions. PTR_TO_RDONLY_MEM currently
> > has no consumers.
> >
> > Signed-off-by: Hao Luo <haoluo@google.com>
> > ---
> >  Changes since v1:
> >   - new patch, introduced ARG_PTR_TO_WRITABLE_MEM to differentiate
> >     read-only and read-write mem arg types.
> >
> >  include/linux/bpf.h      |  9 +++++++++
> >  kernel/bpf/cgroup.c      |  2 +-
> >  kernel/bpf/helpers.c     |  2 +-
> >  kernel/bpf/verifier.c    | 18 ++++++++++++++++++
> >  kernel/trace/bpf_trace.c |  6 +++---
> >  net/core/filter.c        |  6 +++---
> >  6 files changed, 35 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 7b47e8f344cb..586ce67d63a9 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -341,6 +341,15 @@ enum bpf_arg_type {
> >       ARG_PTR_TO_STACK_OR_NULL,       /* pointer to stack or NULL */
> >       ARG_PTR_TO_CONST_STR,   /* pointer to a null terminated read-only string */
> >       ARG_PTR_TO_TIMER,       /* pointer to bpf_timer */
> > +     ARG_PTR_TO_WRITABLE_MEM,        /* pointer to valid memory. Compared to
> > +                                      * ARG_PTR_TO_MEM, this arg_type is not
> > +                                      * compatible with RDONLY memory. If the
> > +                                      * argument may be updated by the helper,
> > +                                      * use this type.
> > +                                      */
> > +     ARG_PTR_TO_WRITABLE_MEM_OR_NULL,   /* pointer to memory or null, similar to
> > +                                         * ARG_PTR_TO_WRITABLE_MEM.
> > +                                         */
>
> Instead of adding new types,
> can we do something like this instead:
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index c8a78e830fca..5dbd2541aa86 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -68,7 +68,8 @@ struct bpf_reg_state {
>                         u32 btf_id;
>                 };
>
> -               u32 mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
> +               u32 rd_mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
> +               u32 wr_mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */

This seems more confusing, it's technically possible to express a
memory pointer from which you can read X bytes, but can write Y bytes.

I actually liked the idea that helpers will be explicit about whether
they can write into a memory or only read from it.

Apart from a few more lines of code, are there any downsides to having
PTR_TO_MEM vs PTR_TO_RDONLY_MEM?

BTW, this made me think about read-only (from the BPF side) maps.
Seems like we have some special handling around that right now, but if
we had PTR_TO_RDONLY_MEM and PTR_TO_MEM, could we have used that as a
more uniform way to enforce read-only access to memory?

>
>                 /* Max size from any of the above. */
>                 struct {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c6616e325803..ad46169d422b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4374,7 +4374,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>                         return -EACCES;
>                 }
>                 err = check_mem_region_access(env, regno, off, size,
> -                                             reg->mem_size, false);
> +                                             t == BPF_WRITE ? reg->wr_mem_size : reg->rd_mem_size, false);
>                 if (!err && t == BPF_READ && value_regno >= 0)
>                         mark_reg_unknown(env, regs, value_regno);
>         } else if (reg->type == PTR_TO_CTX) {
> @@ -11511,7 +11511,8 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
>                         goto err_put;
>                 }
>                 aux->btf_var.reg_type = PTR_TO_MEM;
> -               aux->btf_var.mem_size = tsize;
> +               aux->btf_var.rd_mem_size = tsize;
> +               aux->btf_var.wr_mem_size = 0;
>         } else {
>                 aux->btf_var.reg_type = PTR_TO_BTF_ID;
>                 aux->btf_var.btf = btf;
>
