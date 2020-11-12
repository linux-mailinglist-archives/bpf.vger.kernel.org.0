Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4792B0E36
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 20:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgKLTjz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 14:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgKLTjy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 14:39:54 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B70C0613D1;
        Thu, 12 Nov 2020 11:39:53 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id i186so6451322ybc.11;
        Thu, 12 Nov 2020 11:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UO9DPotWn4by22yehpshPhN+vxo3lDtaNuirFdoJhWo=;
        b=Sppq0ZOvoAMlmqvODnBlbdaF4xnhLLtRjZ2dPnI1I2fbLczUEktxRbDAQcaOYXzddw
         yVcfc8HTceLl/XU9eydxBF5Ij5LUj4HtoxKq5T8agwif26OBkaWuumyXTO6I33pYY9VK
         nLJqNRe13LCKJbs+f25fJHdpDaX/C4uE8z16hJs9rqTbm/NqUA6ewNOgy646T7SpGJp9
         Rj+ykyqRhzy83dMI46n7wkmHDj9V9zeGX+2tbwoFmM3C2RDxbXR02fEL2nH3qxxmh5Q0
         MXtsE9HYXsy0ODu3hpcdxHkiF3ULIx7q7CsFpkPi9+xF3T8HMmWAYNDW8jG9eopHgHB2
         uewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UO9DPotWn4by22yehpshPhN+vxo3lDtaNuirFdoJhWo=;
        b=Hg048LMqVK2oojtD+11qYroBahOtj6flpQxyxPH73S/bccMqaatk3iGc9hPvKDx0rV
         3OZTSBf/sUxdFF2ADPIZC9I3yo4rnSPNWpKL4yv8816vvUlrl2ekqyUTxZ/Cz86+VfQJ
         xqMOf4/esOYA6phuCMrXDdYqlNyzPttyr1fVU/AAGRfo4CwD7xWaOCu4I5EtyfnxOLyK
         XYPZtCpVha1G4kwSP/3eopB2Sm+KmMWD6iJ1oMiMTRJSlWb3eMBUQjJ01JF+9oiLKyP+
         bPbMIXb+jeMZ5gvKWg/8o07wMrnewXvy/R9uPjtGbGt6bKfx6tmjhRE3fE+4RAkGBM23
         HH7Q==
X-Gm-Message-State: AOAM532Dv0OP27WnEeo70AR/d7LhNE3kTtgX/t/9+vAVeZ4bNVY4TDdH
        r2rQHBrCmE+9QA4k80WoQs+ulxMHE/6YQzew8Nw=
X-Google-Smtp-Source: ABdhPJyg3HXI4g2sbcdTWzEXGHsKcgRYsLw921xwoC8N4P3eAPZ7arw5LfQ9S5SkB+u0p9bYEtMBmgfS4P8cBIW2g6I=
X-Received: by 2002:a25:3d7:: with SMTP id 206mr1656516ybd.27.1605209993100;
 Thu, 12 Nov 2020 11:39:53 -0800 (PST)
MIME-Version: 1.0
References: <20201112150506.705430-1-jolsa@kernel.org> <20201112150506.705430-3-jolsa@kernel.org>
In-Reply-To: <20201112150506.705430-3-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 12 Nov 2020 11:39:42 -0800
Message-ID: <CAEf4BzavQiEAQyeUU3kxHQ5tmwRJev6N_jbqNe=xhJpWyTAQ8Q@mail.gmail.com>
Subject: Re: [RFC/PATCH 2/3] btf_encoder: Put function generation code to generate_func
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 12, 2020 at 7:05 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> We will use generate_func from another place in following change.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  btf_encoder.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index d531651b1e9e..efc4f48dbc5a 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -351,6 +351,23 @@ static struct btf_elf *btfe;
>  static uint32_t array_index_id;
>  static bool has_index_type;
>
> +static int generate_func(struct btf_elf *btfe, struct cu *cu,
> +                        struct function *fn, uint32_t type_id_off)
> +{
> +       int btf_fnproto_id, btf_fn_id, err = 0;

btf_ prefix for these variables don't contribute anything, I'd just
drop them here

> +       const char *name;
> +
> +       btf_fnproto_id = btf_elf__add_func_proto(btfe, cu, &fn->proto, type_id_off);
> +       name = dwarves__active_loader->strings__ptr(cu, fn->name);
> +       btf_fn_id = btf_elf__add_ref_type(btfe, BTF_KIND_FUNC, btf_fnproto_id, name, false);
> +       if (btf_fnproto_id < 0 || btf_fn_id < 0) {
> +               err = -1;
> +               printf("error: failed to encode function '%s'\n", function__name(fn, cu));

return -1;

> +       }
> +
> +       return err;

return 0; drop err variable.

> +}
> +
>  int btf_encoder__encode()
>  {
>         int err;
> @@ -608,9 +625,6 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>         }
>
>         cu__for_each_function(cu, core_id, fn) {
> -               int btf_fnproto_id, btf_fn_id;
> -               const char *name;
> -
>                 /*
>                  * The functions_cnt != 0 means we parsed all necessary
>                  * kernel symbols and we are using ftrace location filter
> @@ -634,14 +648,8 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>                                 continue;
>                 }
>
> -               btf_fnproto_id = btf_elf__add_func_proto(btfe, cu, &fn->proto, type_id_off);
> -               name = dwarves__active_loader->strings__ptr(cu, fn->name);
> -               btf_fn_id = btf_elf__add_ref_type(btfe, BTF_KIND_FUNC, btf_fnproto_id, name, false);
> -               if (btf_fnproto_id < 0 || btf_fn_id < 0) {
> -                       err = -1;
> -                       printf("error: failed to encode function '%s'\n", function__name(fn, cu));
> +               if (generate_func(btfe, cu, fn, type_id_off))
>                         goto out;
> -               }
>         }
>
>         if (skip_encoding_vars)
> --
> 2.26.2
>
