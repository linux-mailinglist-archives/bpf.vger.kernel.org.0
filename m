Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B177A433DC0
	for <lists+bpf@lfdr.de>; Tue, 19 Oct 2021 19:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbhJSRvR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Oct 2021 13:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbhJSRvQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Oct 2021 13:51:16 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6205C06161C
        for <bpf@vger.kernel.org>; Tue, 19 Oct 2021 10:49:03 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id t127so12019375ybf.13
        for <bpf@vger.kernel.org>; Tue, 19 Oct 2021 10:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u8ar48zhi7i3uzu5kelFHun05utK6xOe59jHMIqjo6Y=;
        b=ScWlMOzh/TruUWxcrULfTqMgtyf7JsYGZFTmrm3ZVaLVc2U/+dRsR33LlaT327l2MU
         Xno9X2m8M0LWXbLN4Omkm9Qp1lg5hHrYd7uHxkqhvTu96dEqyUe/xzZ8cmvdyiOAb+Y1
         cplphz436ZR9vTAwdYfPsQp6dKJ1TzmkP3kBT/8kpZM0KN72qqVxNQnl45p0y5H9Qlro
         Utvpjf5kCUYA2+2ZEXjFhvYT0+q6dK9ogzkHVtOULrvbZzpnWGPH+N7x3q1xXwRsgzjD
         CzC8jv3s7DbVrWfdtyMtFZJicNNRs7h3lAEiFD252UadQdQ8tae5Ti7xlfFQgRWbYbsG
         1Qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u8ar48zhi7i3uzu5kelFHun05utK6xOe59jHMIqjo6Y=;
        b=C2WdfNC93IH9DAYEpVXE6JdND688hX0yhbMJGOiSYhoi3MoAXTTXfQ4UBVcCd5/IfP
         YFawuYt9n9ZTigtjAva7Voni6X/fB+h3kJwzu/So1MEgWdjVe/llO9afy6XDwxRaQOte
         DG9qjUuL7OIxjV5dcM/5q1tgq69qX07qG8+Vw4eLb60iaX4ym9jDkG1RhDeSCuY4MGkC
         6W7GWb2l6LCMNjGRTzXPJefLRvoAcczH0Ok1hsTXXwD3vBKYjxSnD8kFgJwI+dtLyhPk
         G0DYGInT7G5WxKEJcXntvgWYtc1l7iRXpbhpOwEsKBCeX3qc4ptHenCReMjWT6feZBqy
         DG5g==
X-Gm-Message-State: AOAM530fz0g/JL168Qv6U+UzIWNXBX2+Aqw2o8SzyLp7OdD/k8hvsK7f
        +PdlkZLQNH2UgyqrFXpj9j3hjGNw43ASBjJXZWoTMDlQ6hw=
X-Google-Smtp-Source: ABdhPJwuTXit3KTukFRckyE1I/v+jGrKlNuTQJy3mkcbxpTdi2YI9h+Jj97gLBW9xgLKLy1cle2wc+oSOJgUVextIZg=
X-Received: by 2002:a25:24c1:: with SMTP id k184mr37178407ybk.2.1634665743061;
 Tue, 19 Oct 2021 10:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211009150029.1746383-1-hengqi.chen@gmail.com> <20211009150029.1746383-2-hengqi.chen@gmail.com>
In-Reply-To: <20211009150029.1746383-2-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 19 Oct 2021 10:48:52 -0700
Message-ID: <CAEf4BzZyjoaRATpKHuYFFmZ1u5WnEh4nBdOOpSO+OZi7MH=cHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Add btf__type_cnt() and
 btf__raw_data() APIs
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Oct 9, 2021 at 8:01 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Add btf__type_cnt() and btf__raw_data() APIs and deprecate
> btf__get_nr_type() and btf__get_raw_data() since the old APIs
> don't follow the libbpf naming convention for getters which
> omit 'get' in the name.[0] btf__raw_data() is just an alias to

nit: this ".[0]" looks out of place, please use it as a reference in a
sentence, e.g.,:

omit 'get' in the name (see [0]).

So that it reads naturally and fits the overall commit message.


> the existing btf__get_raw_data(). btf__type_cnt() now returns
> the number of all types of the BTF object including 'void'.
>
>   [0] Closes: https://github.com/libbpf/libbpf/issues/279
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/lib/bpf/btf.c      | 36 ++++++++++++++++++++++--------------
>  tools/lib/bpf/btf.h      |  4 ++++
>  tools/lib/bpf/btf_dump.c |  8 ++++----
>  tools/lib/bpf/libbpf.c   | 32 ++++++++++++++++----------------
>  tools/lib/bpf/libbpf.map |  2 ++
>  tools/lib/bpf/linker.c   | 28 ++++++++++++++--------------
>  6 files changed, 62 insertions(+), 48 deletions(-)
>

[...]

> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 864eb51753a1..49397a22d72b 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -131,7 +131,9 @@ LIBBPF_API __s32 btf__find_by_name(const struct btf *btf,
>                                    const char *type_name);
>  LIBBPF_API __s32 btf__find_by_name_kind(const struct btf *btf,
>                                         const char *type_name, __u32 kind);
> +LIBBPF_DEPRECATED_SINCE(0, 6, "use btf__type_cnt() instead")

it has to be scheduled to 0.7 to have a release with new API
(btf__type_cnt) before we deprecate btf__get_nr_types(). It's probably
worth mentioning in the deprecation message that btf__type_cnt()
return is +1 from btf__get_nr_types(). Maybe something like:

LIBBPF_DEPRECATED_SINCE(0, 7, "use btf__type_cnt() instead; note that
btf__get_nr_types() == btf__type_cnt() - 1")

>  LIBBPF_API __u32 btf__get_nr_types(const struct btf *btf);
> +LIBBPF_API __u32 btf__type_cnt(const struct btf *btf);
>  LIBBPF_API const struct btf *btf__base_btf(const struct btf *btf);
>  LIBBPF_API const struct btf_type *btf__type_by_id(const struct btf *btf,
>                                                   __u32 id);
> @@ -144,7 +146,9 @@ LIBBPF_API int btf__resolve_type(const struct btf *btf, __u32 type_id);
>  LIBBPF_API int btf__align_of(const struct btf *btf, __u32 id);
>  LIBBPF_API int btf__fd(const struct btf *btf);
>  LIBBPF_API void btf__set_fd(struct btf *btf, int fd);
> +LIBBPF_DEPRECATED_SINCE(0, 6, "use btf__raw_data() instead")

same, 0.7+

>  LIBBPF_API const void *btf__get_raw_data(const struct btf *btf, __u32 *size);
> +LIBBPF_API const void *btf__raw_data(const struct btf *btf, __u32 *size);
>  LIBBPF_API const char *btf__name_by_offset(const struct btf *btf, __u32 offset);
>  LIBBPF_API const char *btf__str_by_offset(const struct btf *btf, __u32 offset);
>  LIBBPF_API int btf__get_map_kv_tids(const struct btf *btf, const char *map_name,

[...]
