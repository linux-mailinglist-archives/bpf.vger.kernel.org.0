Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11614467EA4
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 21:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382980AbhLCULa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Dec 2021 15:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383009AbhLCUL3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Dec 2021 15:11:29 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3B9C061751
        for <bpf@vger.kernel.org>; Fri,  3 Dec 2021 12:08:05 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id x32so12448588ybi.12
        for <bpf@vger.kernel.org>; Fri, 03 Dec 2021 12:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Odns47skV7VEFBB8blqwB79PUmZT5oAuKzfjoH93lvQ=;
        b=HuLMvRX6lAwqp0eaCStnHdt9ljyYzq7rlIcE3QVm4HnllPSHReMO6T4wg+K9bqbX86
         Lk5sbR3Do9I6JwXe0F0m6Uc303a/GjtXqTkwycU62iKuN954P6PnL4zrA1+LktsqWWGz
         GVBPxoJk+w2x56iMHdcjm9mtaYHFh65gKnUYOjBZj4wtNPkwdM80tU113hIDBJ+LPLts
         bCjH1uM7yGq4s4su4cJxuyaMyUc5DSqQOdJH2cxkH2YvWevFFjb0mtWxqOMq11XTTzaa
         63pmmQwc3m8mnCvys1/fZC6tQ9M9d5fkzYEw3vs/5JOSjK6FlPkQwLc9XuOJj3eq+Mz3
         WO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Odns47skV7VEFBB8blqwB79PUmZT5oAuKzfjoH93lvQ=;
        b=Sl19b95GMVXLnTxyhCN2ZKZZNCqTPZe3c6eAp6acJsnpvlYVoaDhMk08K++5d+hMug
         CsKygYYiBzkXq2EL3G5GtOsXBiZwH8TuAob1/nn+m69J5xOVg7LcVR5m3Rq7hA82iI7f
         B1s+rFhObsfJsGtSEGBoalw4H1QBtvrY1llAIbevwZmN8TkEMVauFOrbiXhjL6lO+psO
         R+NfSSWhn0dWEYH9vtqgQmzCscWQb56uMcelBgxCtQjX4nVyasLs1XYDy2pa70GuasgG
         Luz1Y5JeinGTPArZrOcFTJsXUoIar7PFxa1X0S4Yw/mnk1SzJDDQnAFJbw/a6kHDRKk/
         5N4g==
X-Gm-Message-State: AOAM530MVRrQCgd91smIp7rLMSa74mwCEvTmERwi2JVeDsH0KxYTMK33
        YhHJpUTBDEkfBJY+BNptCBD29RGRimH1Y1UVXnoxBYMWf10=
X-Google-Smtp-Source: ABdhPJwIGaAGbj6AvVuR4NoEb/W8mvQWD7FGoulUOxDBmNluFSDi/UEnhD4vEfuvel7VTauCq4XycKmfhHes2ej5nYM=
X-Received: by 2002:a25:2c92:: with SMTP id s140mr24390445ybs.308.1638562084252;
 Fri, 03 Dec 2021 12:08:04 -0800 (PST)
MIME-Version: 1.0
References: <20211203182836.16646-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20211203182836.16646-1-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 3 Dec 2021 12:07:52 -0800
Message-ID: <CAEf4BzaYwWw1tCiu0Kk34YpEJeqDTLCKmrxgDCKr8fyZbTQYYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Reduce bpf_core_apply_relo_insn() stack usage.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 3, 2021 at 10:28 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Reduce bpf_core_apply_relo_insn() stack usage and bump
> BPF_CORE_SPEC_MAX_LEN limit back to 64.
>
> Fixes: 29db4bea1d10 ("bpf: Prepare relo_core.c for kernel duty.")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Looks good except for the three separate specs passed as an array.
Let's do separate input args and it should be good to go. Thanks.

>  kernel/bpf/btf.c          | 11 ++++++-
>  tools/lib/bpf/libbpf.c    |  4 ++-
>  tools/lib/bpf/relo_core.c | 60 +++++++++++----------------------------
>  tools/lib/bpf/relo_core.h | 30 +++++++++++++++++++-
>  4 files changed, 59 insertions(+), 46 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index ed4258cb0832..2a902a946f70 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6742,8 +6742,16 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
>  {
>         bool need_cands = relo->kind != BPF_CORE_TYPE_ID_LOCAL;
>         struct bpf_core_cand_list cands = {};
> +       struct bpf_core_spec *specs;
>         int err;
>
> +       /* ~4k of temp memory necessary to convert LLVM spec like "0:1:0:5"
> +        * into arrays of btf_ids of struct fields and array indices.
> +        */
> +       specs = kcalloc(3, sizeof(*specs), GFP_KERNEL);
> +       if (!specs)
> +               return -ENOMEM;
> +
>         if (need_cands) {
>                 struct bpf_cand_cache *cc;
>                 int i;
> @@ -6779,8 +6787,9 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
>         }
>
>         err = bpf_core_apply_relo_insn((void *)ctx->log, insn, relo->insn_off / 8,
> -                                      relo, relo_idx, ctx->btf, &cands);
> +                                      relo, relo_idx, ctx->btf, &cands, specs);
>  out:
> +       kfree(specs);
>         if (need_cands) {
>                 kfree(cands.cands);
>                 mutex_unlock(&cand_cache_mutex);
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index de260c94e418..1ad070b19bb4 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -5515,6 +5515,7 @@ static int bpf_core_apply_relo(struct bpf_program *prog,
>                                const struct btf *local_btf,
>                                struct hashmap *cand_cache)
>  {
> +       struct bpf_core_spec specs[3] = {};

so I get why single kcalloc() is good on the kernel side, but there is
no reason to do it here, please define three separate variables

>         const void *type_key = u32_as_hash_key(relo->type_id);
>         struct bpf_core_cand_list *cands = NULL;
>         const char *prog_name = prog->name;

[...]

>  static bool is_flex_arr(const struct btf *btf,
>                         const struct bpf_core_accessor *acc,
>                         const struct btf_array *arr)
> @@ -1200,9 +1173,10 @@ int bpf_core_apply_relo_insn(const char *prog_name, struct bpf_insn *insn,
>                              const struct bpf_core_relo *relo,
>                              int relo_idx,
>                              const struct btf *local_btf,
> -                            struct bpf_core_cand_list *cands)
> +                            struct bpf_core_cand_list *cands,
> +                            struct bpf_core_spec *specs)

same here, let's pass three separate arguments instead of having to
remember which array element corresponds to which (local vs cand vs
targ). It doesn't prevent kernel-side from using an array and just
passing pointers.

>  {
> -       struct bpf_core_spec local_spec, cand_spec, targ_spec = {};
> +       struct bpf_core_spec *local_spec = &specs[0], *cand_spec = &specs[1], *targ_spec = &specs[2];
>         struct bpf_core_relo_res cand_res, targ_res;
>         const struct btf_type *local_type;
>         const char *local_name;

[...]
