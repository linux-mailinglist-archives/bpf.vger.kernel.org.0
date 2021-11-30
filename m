Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67E6464227
	for <lists+bpf@lfdr.de>; Wed,  1 Dec 2021 00:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbhK3XQI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Nov 2021 18:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbhK3XQI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Nov 2021 18:16:08 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2B8C061574
        for <bpf@vger.kernel.org>; Tue, 30 Nov 2021 15:12:48 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 131so57529239ybc.7
        for <bpf@vger.kernel.org>; Tue, 30 Nov 2021 15:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NAePK5DyxWQa5oayotHeBhaS78DL1YirW+skQp6IOF4=;
        b=JaYOmTAPgkGmsxx+EBOXK9sWZigGUeiK3Y523PuxlrmXg0cjmEmyYhN0hQhZV5aQLn
         6PUNgWk/m7niZdAQ5mLei1LZxrg+Ih4EKQ9Be3FOZDr4gVurRw/GK36FKfMuEvpLqnOP
         x5iT/CfcxjK9U+IbibxfbtXrE8Y30zX6WxlZfAM1+kuaxgSV3AteU8P67hzpSBQYWnD3
         8Ht3ziSZsurHZ6HEc7p7bVYrQjajllDCCT2srY9StKUgFI54UyHQf7mWMX5v07q/KJzP
         1ZHeeo2ol3FWqhA4V01gJfOZcO9DQKn0NDEG+T+pvaAljoRsdg3sAkU4ubR/SBT3int0
         nP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NAePK5DyxWQa5oayotHeBhaS78DL1YirW+skQp6IOF4=;
        b=WzqS42AlRw8aMvb5JC+DkidbQEmoWKePi4iZfvWErTuiWW7xh9JsxMyWi4qAMWr1Fe
         LrZF548TxNcEzxICSpCjmrwSaqr/DQcd45y14JoIz4DWjHIcQ/s8xEqntZdxSQmN24Gu
         Z4Pjn7NXpeesY9F2meeftE1SvhUc9NDOh39e+ine4RRTeCUZqDB1H0syJi5BXck7qICO
         kmuKsxZsN2TzyDlIu1JTDsqQgsKr4+cZiRudpFX57sR4474wYCvxsE+NgU8Gy2lWo1qZ
         kJl3twT2Se2JyGGpNNkSc1GcqRHzfgxiAg2uqM+a5bzMwChtMgMuaLijhPRrXFyzFWo7
         Blmw==
X-Gm-Message-State: AOAM530TEuO1tWBjqZhLAZI6bE/1t761+9qTj4gAgnSqOnyadEQwYI/2
        PAWCI2z7p2AMIL1eXPMVGhCs38K+0NfHuSnxCwE=
X-Google-Smtp-Source: ABdhPJwBSiM7jxz7zAHPS4xXoTF+NshCPQrO4kurSJMVeTLifwB8aBfyNafgbX1vPHNae0Ifw9VOqpMpwXbdO7H0Vj8=
X-Received: by 2002:a25:b204:: with SMTP id i4mr2537714ybj.263.1638313967539;
 Tue, 30 Nov 2021 15:12:47 -0800 (PST)
MIME-Version: 1.0
References: <20211124060209.493-1-alexei.starovoitov@gmail.com>
 <20211124060209.493-8-alexei.starovoitov@gmail.com> <CAEf4BzYNkgP-t_icXjLAxddOPWgN7GZZ7vWrsLbCDycN=z9KzA@mail.gmail.com>
 <20211130031819.7ulr5cfqrqagioza@ast-mbp.dhcp.thefacebook.com>
 <CAEf4Bzb3E5qyf3WtOAWHWSiq9ptPLXErGg5pCFQTAdz0LhZCBw@mail.gmail.com> <CAADnVQ+k3jbreSF5JOUROCXKWjuWzTmK3DVm-1L3pAaQoQ+mKw@mail.gmail.com>
In-Reply-To: <CAADnVQ+k3jbreSF5JOUROCXKWjuWzTmK3DVm-1L3pAaQoQ+mKw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 30 Nov 2021 15:12:36 -0800
Message-ID: <CAEf4BzZkpgqo4LM4rhA_+qG+uEyPa2F=wVBpV9Bbp2LiGpo=Lg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 07/16] bpf: Add bpf_core_add_cands() and wire
 it into bpf_core_apply_relo_insn().
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 30, 2021 at 3:06 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Nov 29, 2021 at 8:10 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > oh, I thought you added those fields initially and forgot to delete or
> > something, didn't notice that you are just "opting them out" for
> > __KERNEL__. I think libbpf code doesn't strictly need this, here's the
> > diff that completely removes their use, it's pretty straightforward
> > and minimal, so maybe instead of #ifdef'ing let's just do that?
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index b59fede08ba7..95fa57eea289 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -5179,15 +5179,18 @@ static int bpf_core_add_cands(struct
> > bpf_core_cand *local_cand,
> >                    struct bpf_core_cand_list *cands)
> >  {
> >      struct bpf_core_cand *new_cands, *cand;
> > -    const struct btf_type *t;
> > -    const char *targ_name;
> > +    const struct btf_type *t, *local_t;
> > +    const char *targ_name, *local_name;
> >      size_t targ_essent_len;
> >      int n, i;
> >
> > +    local_t = btf__type_by_id(local_cand->btf, local_cand->id);
> > +    local_name = btf__str_by_offset(local_cand->btf, local_t->name_off);
> > +
> >      n = btf__type_cnt(targ_btf);
> >      for (i = targ_start_id; i < n; i++) {
> >          t = btf__type_by_id(targ_btf, i);
> > -        if (btf_kind(t) != btf_kind(local_cand->t))
> > +        if (btf_kind(t) != btf_kind(local_t))
> >              continue;
> >
> >          targ_name = btf__name_by_offset(targ_btf, t->name_off);
> > @@ -5198,12 +5201,12 @@ static int bpf_core_add_cands(struct
> > bpf_core_cand *local_cand,
> >          if (targ_essent_len != local_essent_len)
> >              continue;
> >
> > -        if (strncmp(local_cand->name, targ_name, local_essent_len) != 0)
> > +        if (strncmp(local_name, targ_name, local_essent_len) != 0)
> >              continue;
> >
> >          pr_debug("CO-RE relocating [%d] %s %s: found target candidate
> > [%d] %s %s in [%s]\n",
> > -             local_cand->id, btf_kind_str(local_cand->t),
> > -             local_cand->name, i, btf_kind_str(t), targ_name,
> > +             local_cand->id, btf_kind_str(local_t),
> > +             local_name, i, btf_kind_str(t), targ_name,
> >               targ_btf_name);
> >          new_cands = libbpf_reallocarray(cands->cands, cands->len + 1,
> >                            sizeof(*cands->cands));
> > @@ -5212,8 +5215,6 @@ static int bpf_core_add_cands(struct
> > bpf_core_cand *local_cand,
> >
> >          cand = &new_cands[cands->len];
> >          cand->btf = targ_btf;
> > -        cand->t = t;
> > -        cand->name = targ_name;
> >          cand->id = i;
> >
> >          cands->cands = new_cands;
> > @@ -5320,18 +5321,20 @@ bpf_core_find_cands(struct bpf_object *obj,
> > const struct btf *local_btf, __u32 l
> >      struct bpf_core_cand local_cand = {};
> >      struct bpf_core_cand_list *cands;
> >      const struct btf *main_btf;
> > +    const struct btf_type *local_t;
> > +    const char *local_name;
> >      size_t local_essent_len;
> >      int err, i;
> >
> >      local_cand.btf = local_btf;
> > -    local_cand.t = btf__type_by_id(local_btf, local_type_id);
> > -    if (!local_cand.t)
> > +    local_t = btf__type_by_id(local_btf, local_type_id);
> > +    if (!local_t)
> >          return ERR_PTR(-EINVAL);
>
> Heh. Looks like you only compile-tested it :)

of course :)

> I was surprised that CO-RE in the kernel was working,
> but libbpf CO-RE didn't :)
> Thankfully the fix was simple:
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 24d1cbc30084..1341ce539662 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -5333,6 +5333,7 @@ bpf_core_find_cands(struct bpf_object *obj,
> const struct btf *local_btf, __u32 l
>         int err, i;
>
>         local_cand.btf = local_btf;
> +       local_cand.id = local_type_id;

fascinating, we didn't really use id because we just had type
directly, nice find, sorry about that

>         local_t = btf__type_by_id(local_btf, local_type_id);
>
> Just fyi.
