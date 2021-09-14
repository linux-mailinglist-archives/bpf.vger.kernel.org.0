Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7E040A5D6
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 07:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239370AbhINFQm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 01:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239328AbhINFQl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 01:16:41 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F21C061574
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 22:15:25 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id m70so24364103ybm.5
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 22:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6tvg2kACeCw7xKC13l1CECvxhBDX2osyoCGW7pUoLtk=;
        b=HVRHg+q/at9TC50hWZvtaTlT3BME4OrmPFvhXbKiioBe/Q1r3rQx4n4afsdzTynoK9
         wdOdOaF136YIvhaYrgxH2mOHNdeh5/JIBDH3KaJeawTmX3sXzMjKT6zN4FXAwebn41To
         7PLkZNosrJlYuBXV+6bU+aA1FsfVbzvtab+v9X45jUDl46j3HVEKMxOSKT0inhW9odRS
         6oXB7GjbfaPY+LgJm5B3bZQ2+IX176CV/wD3EyGhIGoc3xA2ji4mGpgCZyi14bo7to2g
         k/wU7yH15fXlLvNe6R88H0e/cOp7ElQMy6TPsRb7/xfA5VqNLLz8GUxrJQq9eQ0i0S4+
         a5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6tvg2kACeCw7xKC13l1CECvxhBDX2osyoCGW7pUoLtk=;
        b=MP8CISsJX+Y+9sEcw/isywZEWpU3uv12Ijy/ViTc7SzxUoHHQiv5oD5iiB9Opn4JMA
         AiqcRnAfV6vjRx+/jky7X0lcrmnuSh21FaO+ZeTpworxP3J1/xC0ikf3E5xnYhA9Xhic
         4EoAd4tmeYUd6m0TRbpTH5ssJkrZp9QEfKbdC/j/jLE37zzaJwGqEUSVLmp70E4kbXVF
         nJC96x0CEt2R2iMh2rQPLQehB4mzul2H6bOrjSunPM5Bd5BdTwDrOBk9zAOzEx65iNw5
         Z3xSaO6ADKUBaBKv61SDPFHjWweA5rC0wpQgtnidoKDyN+n8mytxJakMPEYnYiXwu5iF
         GfvQ==
X-Gm-Message-State: AOAM533ArSheJUYADyTcuFBhfIHyq7+MGK0SbV/d0xQOrPvf46DGd3tq
        vJE2pCmq8ZZ08KKxyAjfXb4ZLyO9NbEGRQiJMeI=
X-Google-Smtp-Source: ABdhPJwWLK7/xqNqc7vYr+KDZzdXXBXfiZQapYKdgeqUXvAeKBoGlLlzLmsttSObrfB7d4becklYEwV8dO5ZDY7K2PM=
X-Received: by 2002:a25:9881:: with SMTP id l1mr20110738ybo.455.1631596524268;
 Mon, 13 Sep 2021 22:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210913155122.3722704-1-yhs@fb.com> <20210913155145.3726307-1-yhs@fb.com>
In-Reply-To: <20210913155145.3726307-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 13 Sep 2021 22:15:13 -0700
Message-ID: <CAEf4BzZC=AeZRGBeHk23zR8rZw3LaCjps5mf7jyjgqO9zgTTHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 04/11] libbpf: add support for BTF_KIND_TAG
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
> Add BTF_KIND_TAG support for parsing and dedup.
> Also added sanitization for BTF_KIND_TAG. If BTF_KIND_TAG is not
> supported in the kernel, sanitize it to INTs.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/lib/bpf/btf.c             | 69 +++++++++++++++++++++++++++++++++
>  tools/lib/bpf/btf.h             | 15 +++++++
>  tools/lib/bpf/btf_dump.c        |  3 ++
>  tools/lib/bpf/libbpf.c          | 31 +++++++++++++--
>  tools/lib/bpf/libbpf.map        |  5 +++
>  tools/lib/bpf/libbpf_internal.h |  2 +
>  6 files changed, 122 insertions(+), 3 deletions(-)
>

Just a few small nits.

[...]

> @@ -2440,6 +2446,49 @@ int btf__add_datasec_var_info(struct btf *btf, int var_type_id, __u32 offset, __
>         return 0;
>  }
>
> +/*
> + * Append new BTF_KIND_TAG type with:
> + *   - *value* - non-empty/non-NULL string;
> + *   - *ref_type_id* - referenced type ID, it might not exist yet;
> + *   - *component_idx* - -1 for tagging reference type, otherwise struct/union
> + *     member or function argument index;
> + * Returns:
> + *   - >0, type ID of newly added BTF type;
> + *   - <0, on error.
> + */
> +int btf__add_tag(struct btf *btf, const char *value, int ref_type_id,
> +                int component_idx)
> +{
> +       bool for_ref_type = false;

leftovers from the previous revision? let's just use 0 for kflag argument below

> +       struct btf_type *t;
> +       int sz, value_off;
> +
> +       if (!value || !value[0] || component_idx < -1)
> +               return libbpf_err(-EINVAL);
> +
> +       if (validate_type_id(ref_type_id))
> +               return libbpf_err(-EINVAL);
> +
> +       if (btf_ensure_modifiable(btf))
> +               return libbpf_err(-ENOMEM);
> +
> +       sz = sizeof(struct btf_type) + sizeof(struct btf_tag);
> +       t = btf_add_type_mem(btf, sz);
> +       if (!t)
> +               return libbpf_err(-ENOMEM);
> +
> +       value_off = btf__add_str(btf, value);
> +       if (value_off < 0)
> +               return value_off;
> +
> +       t->name_off = value_off;
> +       t->info = btf_type_info(BTF_KIND_TAG, 0, for_ref_type);
> +       t->type = ref_type_id;
> +       ((struct btf_tag *)(t + 1))->component_idx = component_idx;

nit: btf_tag(t)->component_idx

> +
> +       return btf_commit_type(btf, sz);
> +}
> +
>  struct btf_ext_sec_setup_param {
>         __u32 off;
>         __u32 len;

[...]

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 8f579c6666b2..4a62ef714562 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -195,6 +195,8 @@ enum kern_feature_id {
>         FEAT_BTF_FLOAT,
>         /* BPF perf link support */
>         FEAT_PERF_LINK,
> +       /* BTF_KIND_ATTR support */

s/BTF_KIND_ATTR/BTF_KIND_TAG/

> +       FEAT_BTF_TAG,
>         __FEAT_CNT,
>  };
>

[...]

>  static bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index bbc53bb25f68..9e649cf9e771 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -386,3 +386,8 @@ LIBBPF_0.5.0 {
>                 btf_dump__dump_type_data;
>                 libbpf_set_strict_mode;
>  } LIBBPF_0.4.0;
> +
> +LIBBPF_0.6.0 {
> +       global:
> +               btf__add_tag;
> +} LIBBPF_0.5.0;

you'll need a rebase for this due to my patch for libbpf_version.h, sorry

> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index 4f6ff5c23695..ceb0c98979bc 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -69,6 +69,8 @@
>  #define BTF_VAR_SECINFO_ENC(type, offset, size) (type), (offset), (size)
>  #define BTF_TYPE_FLOAT_ENC(name, sz) \
>         BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 0), sz)
> +#define BTF_TYPE_TAG_ENC(value, type, component_idx) \
> +       BTF_TYPE_ENC(value, BTF_INFO_ENC(BTF_KIND_TAG, 0, 0), type), (component_idx)
>
>  #ifndef likely
>  #define likely(x) __builtin_expect(!!(x), 1)
> --
> 2.30.2
>
