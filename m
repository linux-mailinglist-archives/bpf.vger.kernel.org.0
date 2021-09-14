Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8774B40A5BD
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 07:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbhINFKA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 01:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbhINFJ7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 01:09:59 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A00C061574
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 22:08:42 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id s16so25607304ybe.0
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 22:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CT8IRrRPaNg0iRHLJoE0P/wdj4awG/TMXdRZ2giAjV4=;
        b=LAXFD3P4sX/TZuui9iZs1L2f5rWQPQnfCVGrWl7yeX0mKBtW1mvGlJOGMW70WLTF4h
         ET9uzMnLn35iII0HbIgGWYkSZoX6tUQS4PM1oGnWIa/A8nwQJ6sw9MPnNwXzHEOMjsPb
         XRaEunJnJY8s2ZT5lK5kxew0zHrsxD1qUoOdQcP7PZrlO2l2uiTwcxK9UHI0Qgyx9hXw
         hbcx2ZfVnF9FwBXrNyPCPzuqzjgEhDtRSWZakviikHAhvix8paKWAPwEYNfZ5N2ZePUY
         Wb7NkQ0xOL8OSOvPFUjnXp+kYekqA8m+zogFdXOuT8JJ6nxOhRqI2CGZyrQ061vj6Qhj
         0QQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CT8IRrRPaNg0iRHLJoE0P/wdj4awG/TMXdRZ2giAjV4=;
        b=Rz3fwDmS2tgXwY1OfFO2GoG31Co6KhsXuJ4Wi0OnJNEyzu5ak60U7aOvR3rClhs9Yg
         NS8W1it95VJzVMELuAwApiYKdKi8r80jZYBYHV6Y8F31KYnGsunCIdani5m0GuAfHbQ6
         sM8CY1SvySz9KgE67LqprGwqAE9o/bFcPOgG3a+YpqvvoKASZxH5qAw6wR8Xbwwir3F8
         IxmCl/T2DMk/VW1x3uMHOFzJyDhLHOmQFo0tWhD1OUDKaYs66DwDMQj5wcFWNuumZaID
         ZZa6tC4W2xrXoBP4lr6gPTIKE9OIyea6YOkZvaDasDnIxQtYJsO8Gu+z0WbG0fLqsREM
         t0zQ==
X-Gm-Message-State: AOAM531nZWsssVOgfpd8YPR1SxgkXA1Mp6d9LKedQnlh2KMW7IeNymy0
        O2pnjePcV0/cpcq0JAfWmHw64qKKXH8dmqrfHO0=
X-Google-Smtp-Source: ABdhPJyq1jjQLI23NpzgW2Yg7R31Lg7ECJsZbL/TloOqrxeZ31ETXhwmt5jJKp+0rD4dxM+cOTVFVqmMMFHtGckBmdc=
X-Received: by 2002:a5b:408:: with SMTP id m8mr20457562ybp.2.1631596122206;
 Mon, 13 Sep 2021 22:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210913155122.3722704-1-yhs@fb.com> <20210913155133.3723769-1-yhs@fb.com>
In-Reply-To: <20210913155133.3723769-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 13 Sep 2021 22:08:31 -0700
Message-ID: <CAEf4Bza69r-Sp4nFZqd4i1xhD+Dy5u+Xb=FB7TNNSfHzNNvosg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 02/11] bpf: support for new btf kind BTF_KIND_TAG
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 13, 2021 at 8:51 AM Yonghong Song <yhs@fb.com> wrote:
>
> LLVM14 added support for a new C attribute ([1])
>   __attribute__((btf_tag("arbitrary_str")))
> This attribute will be emitted to dwarf ([2]) and pahole
> will convert it to BTF. Or for bpf target, this
> attribute will be emitted to BTF directly ([3], [4]).
> The attribute is intended to provide additional
> information for
>   - struct/union type or struct/union member
>   - static/global variables
>   - static/global function or function parameter.
>
> For linux kernel, the btf_tag can be applied
> in various places to specify user pointer,
> function pre- or post- condition, function
> allow/deny in certain context, etc. Such information
> will be encoded in vmlinux BTF and can be used
> by verifier.
>
> The btf_tag can also be applied to bpf programs
> to help global verifiable functions, e.g.,
> specifying preconditions, etc.
>
> This patch added basic parsing and checking support
> in kernel for new BTF_KIND_TAG kind.
>
>  [1] https://reviews.llvm.org/D106614
>  [2] https://reviews.llvm.org/D106621
>  [3] https://reviews.llvm.org/D106622
>  [4] https://reviews.llvm.org/D109560
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/uapi/linux/btf.h       |  16 ++++-
>  kernel/bpf/btf.c               | 120 +++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/btf.h |  16 ++++-
>  3 files changed, 148 insertions(+), 4 deletions(-)
>

[...]

>
> +static s32 btf_tag_check_meta(struct btf_verifier_env *env,
> +                             const struct btf_type *t,
> +                             u32 meta_left)
> +{
> +       const struct btf_tag *tag;
> +       u32 meta_needed = sizeof(*tag);
> +       const char *value;
> +
> +       if (meta_left < meta_needed) {
> +               btf_verifier_log_basic(env, t,
> +                                      "meta_left:%u meta_needed:%u",
> +                                      meta_left, meta_needed);
> +               return -EINVAL;
> +       }
> +
> +       value = btf_name_by_offset(env->btf, t->name_off);
> +       if (!value || !value[0]) {
> +               btf_verifier_log_type(env, t, "Invalid value");
> +               return -EINVAL;
> +       }
> +
> +       if (btf_type_vlen(t)) {
> +               btf_verifier_log_type(env, t, "vlen != 0");
> +               return -EINVAL;
> +       }
> +
> +       if (btf_type_kflag(t)) {
> +               btf_verifier_log_type(env, t, "Invalid btf_info kind_flag");
> +               return -EINVAL;
> +       }
> +

probably need to enforce that component_idx is >= -1? -2 is not a
valid supported value right now.

> +       btf_verifier_log_type(env, t, NULL);
> +
> +       return meta_needed;
> +}
> +
> +static int btf_tag_resolve(struct btf_verifier_env *env,
> +                          const struct resolve_vertex *v)
> +{
> +       const struct btf_type *next_type;
> +       const struct btf_type *t = v->t;
> +       u32 next_type_id = t->type;
> +       struct btf *btf = env->btf;
> +       s32 component_idx;
> +       u32 vlen;
> +
> +       next_type = btf_type_by_id(btf, next_type_id);
> +       if (!next_type || !btf_type_is_tag_target(next_type)) {
> +               btf_verifier_log_type(env, v->t, "Invalid type_id");
> +               return -EINVAL;
> +       }
> +
> +       if (!env_type_is_resolve_sink(env, next_type) &&
> +           !env_type_is_resolved(env, next_type_id))
> +               return env_stack_push(env, next_type, next_type_id);
> +
> +       component_idx = btf_type_tag(t)->component_idx;
> +       if (component_idx != -1) {

so here, if it's -2, that should be an error, but currently will be
ignored, right?

> +               if (btf_type_is_var(next_type) || component_idx < 0) {

if is_var(next_type) then component_idx should only be -1, nothing
else. Or am I missing some convention?

> +                       btf_verifier_log_type(env, v->t, "Invalid component_idx");
> +                       return -EINVAL;
> +               }
> +
> +               if (btf_type_is_struct(next_type)) {
> +                       vlen = btf_type_vlen(next_type);
> +               } else {
> +                       next_type = btf_type_by_id(btf, next_type->type);
> +                       vlen = btf_type_vlen(next_type);
> +               }
> +
> +               if ((u32)component_idx >= vlen) {
> +                       btf_verifier_log_type(env, v->t, "Invalid component_idx");
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       env_stack_pop_resolved(env, next_type_id, 0);
> +
> +       return 0;
> +}
> +

[...]
