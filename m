Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8E04641F3
	for <lists+bpf@lfdr.de>; Wed,  1 Dec 2021 00:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345172AbhK3XKN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Nov 2021 18:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345147AbhK3XKJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Nov 2021 18:10:09 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37EEC061574
        for <bpf@vger.kernel.org>; Tue, 30 Nov 2021 15:06:49 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id s37so11806337pga.9
        for <bpf@vger.kernel.org>; Tue, 30 Nov 2021 15:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oHwrcHrIJwWcCrvTdxYQG+7BVovCnxTMMiiKKYYbZw4=;
        b=hitJX1nTwj29tU9ZkH6s5H31Qu5TrxQv/2egbLWThWgQhK2yER0i/WV290M7WdcPru
         NrD74896zNIQi3g/H6vHNk7Og2LCbyt0xDkHuhuR+RxsL9EJzhSr2+8zXVkODsRhnPaD
         ibUGAYFt5QO9gKZQZGjckk3PUQPWkhLhjzU195yqkmrl/ZoETXPDbgtmldUmL0cWT1XE
         OI0wHSc/depgNe/hvapmYxpC7e0YMm7ZN24Crzfr5ci+lJpY5ccw5iYLwYLBQIiKqBd5
         9543ZWku4yjTz8Uz00zeikGtbiuuyEjcJnapham6uF9md7XnZILRmSzmKvu/umY+KW03
         UzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oHwrcHrIJwWcCrvTdxYQG+7BVovCnxTMMiiKKYYbZw4=;
        b=kNIqakV3ifJkZBTpCPoF7M25Yua+1ReYYO/GLXdDCQ+4HNf19iFBOD2uW/d7lVXPCO
         GlBYEBo0zeSy3C3kBDWklQ+gddl/raU31BZC50J1U9BmUI/CTJGv11es63JNF13zPFAH
         Kkihj1pbX6WGRQyIUTE4YS2mYOpzpxAKMhNMetiv083L1tLAkDih+ekaL95YUHFPfaaW
         yBzlTcsyK1OPnF6S92RhMdIJ70ciYqvQ1CR42kI58RT/B1O+yRP3wzgPisIuTNUt5yNp
         QM8fS4uB7tSoecRamGvYenCoQAyoeMcVsevI0LCmlaHwFGJ+Fax+ZKtY/rbi773lWJPb
         B7RQ==
X-Gm-Message-State: AOAM532m6RcYUT99zbtn8+tinSKxTRYiGmax+fwUE32cklOEqUlhoLTo
        Vl2xk7RNLo6Ze4yzy2jvA0ARtUQD+pe5hWJ35jo=
X-Google-Smtp-Source: ABdhPJx+ykeEl+/KhKg1qPX551g/qvRVeZ8P/onoCiCUKyxQBpihYCs50/pfoQ7H1NdyHolSBAZEFIW/NT+ewVgTPaI=
X-Received: by 2002:a63:6881:: with SMTP id d123mr1682340pgc.497.1638313609394;
 Tue, 30 Nov 2021 15:06:49 -0800 (PST)
MIME-Version: 1.0
References: <20211124060209.493-1-alexei.starovoitov@gmail.com>
 <20211124060209.493-8-alexei.starovoitov@gmail.com> <CAEf4BzYNkgP-t_icXjLAxddOPWgN7GZZ7vWrsLbCDycN=z9KzA@mail.gmail.com>
 <20211130031819.7ulr5cfqrqagioza@ast-mbp.dhcp.thefacebook.com> <CAEf4Bzb3E5qyf3WtOAWHWSiq9ptPLXErGg5pCFQTAdz0LhZCBw@mail.gmail.com>
In-Reply-To: <CAEf4Bzb3E5qyf3WtOAWHWSiq9ptPLXErGg5pCFQTAdz0LhZCBw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 30 Nov 2021 15:06:37 -0800
Message-ID: <CAADnVQ+k3jbreSF5JOUROCXKWjuWzTmK3DVm-1L3pAaQoQ+mKw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 07/16] bpf: Add bpf_core_add_cands() and wire
 it into bpf_core_apply_relo_insn().
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 29, 2021 at 8:10 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> oh, I thought you added those fields initially and forgot to delete or
> something, didn't notice that you are just "opting them out" for
> __KERNEL__. I think libbpf code doesn't strictly need this, here's the
> diff that completely removes their use, it's pretty straightforward
> and minimal, so maybe instead of #ifdef'ing let's just do that?
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b59fede08ba7..95fa57eea289 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -5179,15 +5179,18 @@ static int bpf_core_add_cands(struct
> bpf_core_cand *local_cand,
>                    struct bpf_core_cand_list *cands)
>  {
>      struct bpf_core_cand *new_cands, *cand;
> -    const struct btf_type *t;
> -    const char *targ_name;
> +    const struct btf_type *t, *local_t;
> +    const char *targ_name, *local_name;
>      size_t targ_essent_len;
>      int n, i;
>
> +    local_t = btf__type_by_id(local_cand->btf, local_cand->id);
> +    local_name = btf__str_by_offset(local_cand->btf, local_t->name_off);
> +
>      n = btf__type_cnt(targ_btf);
>      for (i = targ_start_id; i < n; i++) {
>          t = btf__type_by_id(targ_btf, i);
> -        if (btf_kind(t) != btf_kind(local_cand->t))
> +        if (btf_kind(t) != btf_kind(local_t))
>              continue;
>
>          targ_name = btf__name_by_offset(targ_btf, t->name_off);
> @@ -5198,12 +5201,12 @@ static int bpf_core_add_cands(struct
> bpf_core_cand *local_cand,
>          if (targ_essent_len != local_essent_len)
>              continue;
>
> -        if (strncmp(local_cand->name, targ_name, local_essent_len) != 0)
> +        if (strncmp(local_name, targ_name, local_essent_len) != 0)
>              continue;
>
>          pr_debug("CO-RE relocating [%d] %s %s: found target candidate
> [%d] %s %s in [%s]\n",
> -             local_cand->id, btf_kind_str(local_cand->t),
> -             local_cand->name, i, btf_kind_str(t), targ_name,
> +             local_cand->id, btf_kind_str(local_t),
> +             local_name, i, btf_kind_str(t), targ_name,
>               targ_btf_name);
>          new_cands = libbpf_reallocarray(cands->cands, cands->len + 1,
>                            sizeof(*cands->cands));
> @@ -5212,8 +5215,6 @@ static int bpf_core_add_cands(struct
> bpf_core_cand *local_cand,
>
>          cand = &new_cands[cands->len];
>          cand->btf = targ_btf;
> -        cand->t = t;
> -        cand->name = targ_name;
>          cand->id = i;
>
>          cands->cands = new_cands;
> @@ -5320,18 +5321,20 @@ bpf_core_find_cands(struct bpf_object *obj,
> const struct btf *local_btf, __u32 l
>      struct bpf_core_cand local_cand = {};
>      struct bpf_core_cand_list *cands;
>      const struct btf *main_btf;
> +    const struct btf_type *local_t;
> +    const char *local_name;
>      size_t local_essent_len;
>      int err, i;
>
>      local_cand.btf = local_btf;
> -    local_cand.t = btf__type_by_id(local_btf, local_type_id);
> -    if (!local_cand.t)
> +    local_t = btf__type_by_id(local_btf, local_type_id);
> +    if (!local_t)
>          return ERR_PTR(-EINVAL);

Heh. Looks like you only compile-tested it :)
I was surprised that CO-RE in the kernel was working,
but libbpf CO-RE didn't :)
Thankfully the fix was simple:

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 24d1cbc30084..1341ce539662 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5333,6 +5333,7 @@ bpf_core_find_cands(struct bpf_object *obj,
const struct btf *local_btf, __u32 l
        int err, i;

        local_cand.btf = local_btf;
+       local_cand.id = local_type_id;
        local_t = btf__type_by_id(local_btf, local_type_id);

Just fyi.
