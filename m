Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F86436904
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 19:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhJURbR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 13:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhJURbF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 13:31:05 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B78EC061764
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 10:28:49 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id g6so1050757ybb.3
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 10:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VS3h1vRtqkyeSB/iB9wI1waoxC8ckNSgzyk5CmamOJg=;
        b=QugUynadvPL6Vp8Qb+u+J+yheX8JL1V+XX1v7ZgE61PJXi+9wi6YhtzNWQJ5qteAus
         /ZkXzV4upZPs286MvUfn7MWQHKeUPWtWTyDOaciINqabB+7dA0aUPECPX2indOGngc2c
         ReGQqyiBAjn1PYt5uLmrtc5FeIVNbRNzygXqOih29u9YZ4TZz846jXOGt9i3PvvwREAj
         6E+PIzld7zv9U4GZ504u9IFv6hgnYvhvXPqGsPi9I2dGF7HncwWVUVo9LX/i5ohffE0R
         h00/via1PdM83e2UmFQtzlcG/BsXNT9f+QH/GsfS0GJcJs8BlcXSw8QoDkwyQrOHPQL9
         kLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VS3h1vRtqkyeSB/iB9wI1waoxC8ckNSgzyk5CmamOJg=;
        b=mGhNGfRxxJnhjwmRkXApCscI0cPAc/Ea4WO8KhFvVpz/rZN0+A0dTdbIkeyiIKzBC3
         XdMJBgA6MQ8mXWYbGh8txyuNXpmsq6c+ychc8VcpjRggYXzAD42caixVMo085gZXeiBu
         99XEhb5VBqunp8GsFWy6zLJuo27ewnFHFd9fLkEXFwbMh8C4imz4m9oNSv4JYl9y2GQW
         dhYiSR/QujtzcQKrOrYtJMyvuwS24cZQMiTQ4TkDLEeCtFECJ0OcAVKNM2yn8Y32qI9+
         ATlxLRaTzD+PO9ZRXMVBNxwGRu21V5WeB/WvBBVky3sGV1MC0f7kbiTBKcK9LKJmAFAg
         x4og==
X-Gm-Message-State: AOAM533bO6CuFrjos7BEWwaq/YO5mNjIdGjNMrhM7PW6tGQjdTAt2Svt
        TwHyvzZvfcYK8m0JRwStxi0ExgsXEaA6s2HNPa5Ctv+wcbE=
X-Google-Smtp-Source: ABdhPJw678zuv2RzrHk1L/92c/s+K/jTzr1Wg/u+gxpClVuij3wVYYDB4X+841FqueCxDwDac+dpB5N3VMCeWgJ4Uec=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr7778188ybj.504.1634837328419;
 Thu, 21 Oct 2021 10:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211021170858.446660-1-irogers@google.com>
In-Reply-To: <20211021170858.446660-1-irogers@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 21 Oct 2021 10:28:37 -0700
Message-ID: <CAEf4BzYsmYGsUCopYRxK6eRe0wud6RSJTuCq9972ic60syRGAg@mail.gmail.com>
Subject: Re: [PATCH v2] btf_encoder: Make BTF_KIND_TAG conditional
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

On Thu, Oct 21, 2021 at 10:09 AM Ian Rogers <irogers@google.com> wrote:
>
> BTF_KIND_TAG is present in libbtf 6.0 but not libbtf in 5.15rc4. Make
> the code requiring it conditionally compiled in.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  btf_encoder.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index c341f95..1694679 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -31,6 +31,15 @@
>  #include <errno.h>
>  #include <stdint.h>
>
> +#ifndef LIBBPF_MINOR_VERSION
> +/*
> + * The libbpf version is not defined in older versions, workaround by assuming
> + * version 0.5.
> + */
> +#define LIBBPF_MAJOR_VERSION 0
> +#define LIBBPF_MINOR_VERSION 5
> +#endif
> +
>  struct elf_function {
>         const char      *name;
>         bool             generated;
> @@ -141,7 +150,9 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
>         [BTF_KIND_VAR]          = "VAR",
>         [BTF_KIND_DATASEC]      = "DATASEC",
>         [BTF_KIND_FLOAT]        = "FLOAT",
> +#if LIBBPF_MINOR_VERSION > 5

this will break on 1.0

>         [BTF_KIND_TAG]          = "TAG",
> +#endif
>  };
>
>  static const char *btf__printable_name(const struct btf *btf, uint32_t offset)
> @@ -648,6 +659,7 @@ static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, const char
>  static int32_t btf_encoder__add_tag(struct btf_encoder *encoder, const char *value, uint32_t type,
>                                     int component_idx)
>  {
> +#if LIBBPF_MINOR_VERSION > 5
>         struct btf *btf = encoder->btf;
>         const struct btf_type *t;
>         int32_t id;
> @@ -663,6 +675,10 @@ static int32_t btf_encoder__add_tag(struct btf_encoder *encoder, const char *val
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
> --
> 2.33.0.1079.g6e70778dc9-goog
>
