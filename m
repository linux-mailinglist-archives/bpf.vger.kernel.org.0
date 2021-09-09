Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70899404484
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 06:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbhIIEkG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 00:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhIIEkG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 00:40:06 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B246DC061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 21:38:57 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id k65so1283710yba.13
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 21:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C+gJbvGpLo3aqOdtP0tHPSQh1WxL2DvJBKBn7KS0HpI=;
        b=ZLO0QBaMJ6skcc2jMP+hZKgJ2b/WaAxt1SRXzQz5FJhsv9uvqOr1X8WImMzzYjBL8d
         bd/ZaSQnS+C2PwTE6fB9Mka8Hk9WHpoLgn8JEQKMWLRrhlHr2Bu2g+2Z4Hp6ovHM4B0N
         x0HunoP+I2X1USK+G0jozr+9knTZ5mu1MLdEmHYIcje0LFsl3FhVmdX5KeYR11DeaPcY
         3Fd8olFY4E+3jfDgU2Ov2rPKvsAhQGeAgi+gumLa4FtzMgMQ8iDlHR9AfHEmB/j0KK5A
         gRIEFZIlrKRPx6hBbvZqZW32+gXl5cRCy/WFKFHNseBNtgQr5hxnkSthaPETi10Jemzw
         0Elw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C+gJbvGpLo3aqOdtP0tHPSQh1WxL2DvJBKBn7KS0HpI=;
        b=vGKe4NjIpiRnPcHkn1t04b5w7hF43YficbNQOY8Ru9YQUY+HkR3Ogd+uq8aD39LmEy
         3PGjSe6EVZmc5KySUFHmfMZwHgmXOviUDMvzNEBba3kdPvZ5O7ku0xp805f4dwYFe1sO
         5DtpAe7UVXaS/Jd80YJ1HePt9i0Wmm7eVYDv8WmMH9bwXVXPGSpe/asR5f71PXlbLLyf
         aLux7nagQLPcPxx7vcWwZkNMz7abCCm66AqkfU5Hhk6GzJMFcMnT6IJPWe0ME5KdI+dH
         qpYdDuzFUKaQJwFOHblypyjq6eNBcjDMcxVrvtIujxFp//w7QgA+j4Vel+dszxkJTKiR
         ThYQ==
X-Gm-Message-State: AOAM533WIaLo/EglwI0QDpNzQTogQ16TG4JzG3cy0PZAwF44Ee/770S0
        BgzVBljP/X4kw0tMEzBCh+XIsjHvg3icH8lg7bU=
X-Google-Smtp-Source: ABdhPJz2RlKpDqivvNwh+sKeg5FiT9LxYVuDHA3mLxjwO5prMpgPg2TnC6v3Ij0/af+2S0dGFHDeRGFpge+lfOJ/ikY=
X-Received: by 2002:a25:3604:: with SMTP id d4mr1261690yba.4.1631162336689;
 Wed, 08 Sep 2021 21:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210908153544.749101-1-hengqi.chen@gmail.com>
In-Reply-To: <20210908153544.749101-1-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Sep 2021 21:38:45 -0700
Message-ID: <CAEf4BzYhYcyVOJ84REys1nyF8eMaDa0JgAinjgwU_EMvMqOo-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: deprecate bpf_object__unload() API
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 8, 2021 at 8:35 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> BPF objects are not re-loadable after unload. User are expected to use
> bpf_object__close() to unload and free up resources in one operation.
> No need to expose bpf_object__unload() as a public API, deprecate it.[0]
> Remove bpf_object__unload() inside bpf_object__load_xattr(), it is the
> caller's responsibility to free up resources, otherwise, the following
> code path will cause double-free problem when loading failed:
>
>     bpf_prog_load
>         bpf_prog_load_xattr
>             bpf_object__load
>                 bpf_object__load_xattr
>

Did you see this double-free ever happen? I'm looking at the code and
not seeing it. Seems like bpf_object__unload() is idempotent, so no
mater how many times we call it, it doesn't do any harm. Look at how
zclose and zfree are implemented, they zero-out fields and also check
for non-zero values before doing something. So unless I'm missing
something, there is no problem.


> Replace bpf_object__unload() inside bpf_object__close() with the necessary
> cleanup operations to avoid compilation error.
>
>   [0] Closes: https://github.com/libbpf/libbpf/issues/290
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 8 +++++---
>  tools/lib/bpf/libbpf.h | 3 ++-
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 8f579c6666b2..c56b466c5461 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -6931,7 +6931,6 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
>                 if (obj->maps[i].pinned && !obj->maps[i].reused)
>                         bpf_map__unpin(&obj->maps[i], NULL);
>
> -       bpf_object__unload(obj);

I think unloading already loaded bpf programs is bpf_object__load()'s
responsibility, so please don't remove this.

>         pr_warn("failed to load object '%s'\n", obj->path);
>         return libbpf_err(err);
>  }
> @@ -7540,12 +7539,15 @@ void bpf_object__close(struct bpf_object *obj)
>
>         bpf_gen__free(obj->gen_loader);
>         bpf_object__elf_finish(obj);
> -       bpf_object__unload(obj);

same, this is fine, don't remove it

>         btf__free(obj->btf);
>         btf_ext__free(obj->btf_ext);
>
> -       for (i = 0; i < obj->nr_maps; i++)
> +       for (i = 0; i < obj->nr_maps; i++) {
> +               zclose(obj->maps[i].fd);
> +               if (obj->maps[i].st_ops)
> +                       zfree(&obj->maps[i].st_ops->kern_vdata);
>                 bpf_map__destroy(&obj->maps[i]);
> +       }

and no changes should be necessary here either

>
>         zfree(&obj->btf_custom_path);
>         zfree(&obj->kconfig);
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 2f6f0e15d1e7..748f7dabe4c7 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -147,7 +147,8 @@ struct bpf_object_load_attr {
>  /* Load/unload object into/from kernel */
>  LIBBPF_API int bpf_object__load(struct bpf_object *obj);
>  LIBBPF_API int bpf_object__load_xattr(struct bpf_object_load_attr *attr);
> -LIBBPF_API int bpf_object__unload(struct bpf_object *obj);
> +LIBBPF_API LIBBPF_DEPRECATED("bpf_object__unload() is deprecated, use bpf_object__close() instead")
> +int bpf_object__unload(struct bpf_object *obj);
>

This is the right change, but let's also keep original
bpf_object__unload() logic. I'd recommend renaming
bpf_object__unload() into bpf_object_unload() (so that's naming is
more clearly showing it's an internal function) and make it static.
Then have a small shim of bpf_object__unload() calling into
bpf_object_unload() until we remove that in libbpf 1.0.

>  LIBBPF_API const char *bpf_object__name(const struct bpf_object *obj);
>  LIBBPF_API unsigned int bpf_object__kversion(const struct bpf_object *obj);
> --
> 2.25.1
>
