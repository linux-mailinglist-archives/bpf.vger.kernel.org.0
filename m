Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6CC44DBAB
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 19:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbhKKSo1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 13:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbhKKSo1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Nov 2021 13:44:27 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1FEC061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 10:41:37 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id q74so17308854ybq.11
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 10:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+tJwjX+70KBRPnge4aoT8eIL044ukX1ICfPq2dCp8Zc=;
        b=ldbkJKykvqsuVCDSFOdf9E+cJwjkjW1gTL7cl0UvOiyEBBR9loPf54eyBJxUrKfYDW
         AbzdMiiwMs1epOXXxdzwOQNm9dF3b5wRPw6XbEBoTkc/TllRqqK9FWGQt/dpzzzP9cdK
         S57UbvRzBNWK5A9LsHFSkd5Lb39RIkhYE1qb2XCCuBp3imD899Qv/PReOil3ix27IwNX
         H1YKKzlJg9gsuUXiUDmp5fMXNu5gGfYmekQ4wVb0sL5F5IL4qcehPzxs4DFViG10D5kW
         EOBYJGCx5AZ6U0IqdWRYNlzZYGsLzY7PjmWCYxh+p1/wnRn+Y4I1BtKcN68INIgU/jcP
         P+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+tJwjX+70KBRPnge4aoT8eIL044ukX1ICfPq2dCp8Zc=;
        b=wl7oqBpSwa5s5SKFBWM04Z87HrA+f3x/RdjdIr91NOgcDWBaa/gKMWXoRSmhlm9cJ+
         4IExMdXUIh93zXDGl8v1nTUe8lCMScY58C/w8a2GEQDyTfNp/Qj4s7TopsHK+iyccizD
         MVqubduXmjV0N2G25Y2Qa33JTF/stagpOQ2vfxPfCtVF9eLILLTukHleNMd17sWYovW5
         gUvD/sDDBbbyMQ2dlbbJsmGF51sZNbqy0g2BNeEtEk76Jstm7YDTk5Cun+itZ7TX1xAn
         qStt6PVeGzmJ9wUHLCfskqPocYpz0zpa5H5me16QXiTlGaWgCbAqjItBN4z9bkHcj+wr
         lApg==
X-Gm-Message-State: AOAM531LbvzUvMpE33jOx64PMMANeF9IjprxpVRkJSfMeSaF1+l0R3KG
        pslAXA5/ylaNyy+JudMxHF4YNNbWKA4MRXediT0=
X-Google-Smtp-Source: ABdhPJxnpiPu9xtMSl6qcYk1VBi1uBYybAkRFp74c43DplHrHTIzRACNzCtyiC5X+2Ew86/AWKCQrfxATAH60oCks6k=
X-Received: by 2002:a25:cec1:: with SMTP id x184mr10450018ybe.455.1636656097196;
 Thu, 11 Nov 2021 10:41:37 -0800 (PST)
MIME-Version: 1.0
References: <20211110051940.367472-1-yhs@fb.com> <20211110051951.369416-1-yhs@fb.com>
In-Reply-To: <20211110051951.369416-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 11 Nov 2021 10:41:26 -0800
Message-ID: <CAEf4BzZHPM=i4DaOZE=Z945xB5a68FwbFGkTf0dW+OsmMYujcQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 02/10] libbpf: Support BTF_KIND_TYPE_TAG
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 9, 2021 at 9:20 PM Yonghong Song <yhs@fb.com> wrote:
>
> Add libbpf support for BTF_KIND_TYPE_TAG.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Few nits below.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/btf.c             | 23 +++++++++++++++++++++++
>  tools/lib/bpf/btf.h             |  9 ++++++++-
>  tools/lib/bpf/btf_dump.c        |  9 +++++++++
>  tools/lib/bpf/libbpf.c          | 31 ++++++++++++++++++++++++++++++-
>  tools/lib/bpf/libbpf.map        |  1 +
>  tools/lib/bpf/libbpf_internal.h |  2 ++
>  6 files changed, 73 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 7e4c5586bd87..4d9883bef330 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -299,6 +299,7 @@ static int btf_type_size(const struct btf_type *t)
>         case BTF_KIND_TYPEDEF:
>         case BTF_KIND_FUNC:
>         case BTF_KIND_FLOAT:
> +       case BTF_KIND_TYPE_TAG:
>                 return base_size;
>         case BTF_KIND_INT:
>                 return base_size + sizeof(__u32);
> @@ -349,6 +350,7 @@ static int btf_bswap_type_rest(struct btf_type *t)
>         case BTF_KIND_TYPEDEF:
>         case BTF_KIND_FUNC:
>         case BTF_KIND_FLOAT:
> +       case BTF_KIND_TYPE_TAG:
>                 return 0;
>         case BTF_KIND_INT:
>                 *(__u32 *)(t + 1) = bswap_32(*(__u32 *)(t + 1));
> @@ -649,6 +651,7 @@ int btf__align_of(const struct btf *btf, __u32 id)
>         case BTF_KIND_VOLATILE:
>         case BTF_KIND_CONST:
>         case BTF_KIND_RESTRICT:
> +       case BTF_KIND_TYPE_TAG:
>                 return btf__align_of(btf, t->type);
>         case BTF_KIND_ARRAY:
>                 return btf__align_of(btf, btf_array(t)->type);
> @@ -2235,6 +2238,22 @@ int btf__add_restrict(struct btf *btf, int ref_type_id)
>         return btf_add_ref_kind(btf, BTF_KIND_RESTRICT, NULL, ref_type_id);
>  }
>
> +/*
> + * Append new BTF_KIND_TYPE_TAGtype with:

missing space

> + *   - *value*, non-empty/non-NULL name;

s/name/tag value/ ? It's not just a name, some tags can have
"parameters", right?

> + *   - *ref_type_id* - referenced type ID, it might not exist yet;
> + * Returns:
> + *   - >0, type ID of newly added BTF type;
> + *   - <0, on error.
> + */
> +int btf__add_type_tag(struct btf *btf, const char *value, int ref_type_id)
> +{
> +       if (!value|| !value[0])
> +               return libbpf_err(-EINVAL);
> +
> +       return btf_add_ref_kind(btf, BTF_KIND_TYPE_TAG, value, ref_type_id);
> +}
> +

[...]
