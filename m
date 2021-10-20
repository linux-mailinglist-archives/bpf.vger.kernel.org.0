Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6EE435502
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 23:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhJTVOR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 17:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhJTVOQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 17:14:16 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A361C06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 14:12:02 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id r184so15322827ybc.10
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 14:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3mMsJPBjARkjHV9DOmxHo9EFp1yBI8EFQu5VBHAsSdg=;
        b=LVa08R6aY1QoM6NpEvVq3nbp+yyUHrDSBLS09MgFs3FCQ9PUl6qHgVHOcda2VSNbvT
         3p+ml+UUE+0QWLpooWcZ3GdkCJ5Ruy16XREIyZTS+4dLJ4UD5CFp9yO2bqPPkVrzpEJE
         CtURi5iyRBNlXSLY3xyKnhFVVHvi6F0xQfQMba0X0XDdcTVMwG6mMl0mTgfbWdus2bC+
         i5/EJ3bLZdqqPD6AKcSWMnQk0I34WuIm9oV5CWhqDFM6/o2/52n+VGYb0u930mPKqjVI
         PRoQkCvDEpif5aYz7SQx4RqiUqC25oIwVD+9loZXtYDd8cYERf+oJq3kQYv0+IlJwvSA
         fdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3mMsJPBjARkjHV9DOmxHo9EFp1yBI8EFQu5VBHAsSdg=;
        b=DWhntsmFDhhoC4t/CFCuQ35hWp0Z/RZMrrRd8SErEQKssiHHxcsEuERxHKyw3/io56
         SkNrMINqIXLo5EpPC5WCvAqRoeFBKprWWWmuI1OJ0psST+MRJqCYAhxSWhbqByEGcnVD
         E1a7eVWmFSAoI/jJ7I19x4hmuug/u9QKvurrMjTNX/QRYsJCrkZ4f4LGuYh/9xocc/MI
         WH8Ul2JOpSjjS/JaBk+MjNU0vV2TdtqpGpC9dsitg3u+snGJZYq06KsmlJz/9aTrqArT
         QFF9PF5sBsYo25AstqilEMCEOOySxYHgzPpwBBEw8OpZv0MSw9wR6CJCRR2uU7U7LaOO
         hZjA==
X-Gm-Message-State: AOAM530sGESfUlYr7CiGc1wIurnHxmIF768w/mpanS8pnqNMLpB7Xpqs
        cQTIt6i+6Y2x+NipJPN5OerP8t7u/Cq8MoXAtvA=
X-Google-Smtp-Source: ABdhPJwrwoKcI9F5VQiWmgwImslO3VjxcKPadNbfARGYHbVYdFZ/e+U9LgwQuyMckyC0bIQ8btTpTReyKT3rLMe/oxg=
X-Received: by 2002:a25:24c1:: with SMTP id k184mr1709804ybk.2.1634764321287;
 Wed, 20 Oct 2021 14:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211014212049.1010192-1-irogers@google.com>
In-Reply-To: <20211014212049.1010192-1-irogers@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Oct 2021 14:11:50 -0700
Message-ID: <CAEf4BzYiG36y0XWVfjXti-qb=gOdGkhzB6R5Ny3kvUbTRyeHUA@mail.gmail.com>
Subject: Re: [PATCH] btf_encoder: Make BTF_KIND_TAG conditional
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Petar Penkov <ppenkov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 14, 2021 at 2:20 PM Ian Rogers <irogers@google.com> wrote:
>
> BTF_KIND_TAG is present in libbtf 6.0 but not libbtf in 5.15rc4. Make
> the code requiring it conditionally compiled in.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  btf_encoder.c | 7 +++++++
>  lib/bpf       | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index c341f95..400d64b 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -141,7 +141,9 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
>         [BTF_KIND_VAR]          = "VAR",
>         [BTF_KIND_DATASEC]      = "DATASEC",
>         [BTF_KIND_FLOAT]        = "FLOAT",
> +#ifdef BTF_KIND_TAG /* BTF_KIND_TAG was added in 6.0 */
>         [BTF_KIND_TAG]          = "TAG",
> +#endif
>  };
>
>  static const char *btf__printable_name(const struct btf *btf, uint32_t offset)
> @@ -648,6 +650,7 @@ static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, const char
>  static int32_t btf_encoder__add_tag(struct btf_encoder *encoder, const char *value, uint32_t type,
>                                     int component_idx)
>  {
> +#ifdef BTF_KIND_TAG /* Proxy for libbtf 6.0 */

How will this work when libbpf is loaded dynamically? I believe pahole
has this mode as well.

Also, note that libbpf now provides LIBBPF_MAJOR_VERSION and
LIBBPF_MINOR_VERSION macros, starting from 0.5, so no need for
guessing the version

>         struct btf *btf = encoder->btf;
>         const struct btf_type *t;
>         int32_t id;
> @@ -663,6 +666,10 @@ static int32_t btf_encoder__add_tag(struct btf_encoder *encoder, const char *val
>         }
>
>         return id;
> +#else
> +        fprintf(stderr, "error: unable to encode BTF_KIND_TAG due to old libbtf\n");
> +        return -ENOTSUP;
> +#endif
>  }
>
>  /*
> diff --git a/lib/bpf b/lib/bpf
> index 980777c..986962f 160000
> --- a/lib/bpf
> +++ b/lib/bpf
> @@ -1 +1 @@
> -Subproject commit 980777cc16db75d5628a537c892aefc2640bb242
> +Subproject commit 986962fade5dfa89c2890f3854eb040d2a64ab38
> --
> 2.33.0.1079.g6e70778dc9-goog
>
