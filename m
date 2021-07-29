Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5723DAE65
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 23:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbhG2Vfg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 17:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhG2Vff (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 17:35:35 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E91C061765
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 14:35:31 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id k65so12399900yba.13
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 14:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IlQ3SgdW1hgQbs1zpScaeWXEwpdcn0JO0BSqidkq+l0=;
        b=Lx8nZzydwZVX6Dr9BfYXNuukBhE68ntDmTPuH3Z7SrUgEAjjZbgdzKtcXuO1O1M7E/
         rOwcJQrtzrG/i6doLMlEGFyJqRR+57oGHXa+LSWHQybknuRg4BCH/5nJoMzoNW0nwBza
         M5LOi1YkV0t0wlYvYmabCVJtmqoltv+TNcEAg2kyiSRrFWMFVnkzHI2xN807hq3p2igc
         VOjhpv9TnNGJOxCw7J6IqtNhAKvc1iHqgNXXhqw/oG7aGVwnma4uVSnxBTet4I7cF8Ve
         1cBeP8pqWisxAoH5yEgMqq07Q9UXMDT2zEcZzrgW8jOaNUp8gGgqytfblpQ/+3I5iGeV
         4ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IlQ3SgdW1hgQbs1zpScaeWXEwpdcn0JO0BSqidkq+l0=;
        b=sOwONzQviiDcfZoU7vT+1V1SJ3mVEm6hyOyNvMLWUpiAiZiPUI20EObywSymN6mxo2
         lViNQTV5FIhNAO1/NVx5xWOv8SWGne+zOvVTupXf6Av7+1uMwapy7h9IgZibuieIrqRK
         RwtPAblU3KMXbFyQFe/CuYNgHdPL7tC34uLAhFR6rkPxf4SdZDs4CJZTO4sU+Y6sput1
         qJbQJBxfJFqLvx/XF1Vuwt6d4j40YgtSM9fa1N6cnrZJc669nco/CDa1jzoeG14kDIKR
         1ePGkdRRy9FEs+ZqHB5gxYnd7aSE7ScVCJBxPBWk5sB1S0R3bKiTtSAnPHBot2tacjqY
         s4Dg==
X-Gm-Message-State: AOAM530seEZF9QtJsth1e9Pg4phsk8pw0oS6GJXCFNqbt6UP9jIxT0OU
        G1/cA+ILk55jNzf6YeALz94HpYeoACYtMHjsW6M=
X-Google-Smtp-Source: ABdhPJx3JGCZ1mw2H7V3cVqFKiKuiWEqnSpz9fbna8qytKoWJuqaKeK1jkQR2g279aZlGvfCfUhyIFUYFyWBTlvRZmU=
X-Received: by 2002:a25:b741:: with SMTP id e1mr9451835ybm.347.1627594530646;
 Thu, 29 Jul 2021 14:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210728165525.19104-1-hengqi.chen@gmail.com>
In-Reply-To: <20210728165525.19104-1-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 29 Jul 2021 14:35:19 -0700
Message-ID: <CAEf4BzaejZHivWPPrWAEEDAiTM_HUDuB3v10HqsnYUUj+CshFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: add libbpf_load_vmlinux_btf/libbpf_load_module_btf
 APIs
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 28, 2021 at 9:55 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Add two new APIs: libbpf_load_vmlinux_btf/libbpf_load_module_btf.
> libbpf_load_vmlinux_btf is just an alias to the existing API named
> libbpf_find_kernel_btf, rename it to be more precisely.
> libbpf_load_module_btf can be used to load module BTF, add it for
> completeness. These two APIs are useful for implementing tracing
> tools and introspection tools.
> This is part of the efforts towards libbpf 1.0. [1]
>
> [1] https://github.com/libbpf/libbpf/issues/280
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/lib/bpf/btf.c      | 15 ++++++++++++++-
>  tools/lib/bpf/btf.h      |  2 ++
>  tools/lib/bpf/libbpf.c   |  4 ++--
>  tools/lib/bpf/libbpf.map |  2 ++
>  4 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index b46760b93bb4..5f801739a1a2 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -4021,7 +4021,7 @@ static void btf_dedup_merge_hypot_map(struct btf_dedup *d)
>                  */
>                 if (d->hypot_adjust_canon)
>                         continue;
> -
> +
>                 if (t_kind == BTF_KIND_FWD && c_kind != BTF_KIND_FWD)
>                         d->map[t_id] = c_id;
>
> @@ -4395,6 +4395,11 @@ static int btf_dedup_remap_types(struct btf_dedup *d)
>   * data out of it to use for target BTF.
>   */
>  struct btf *libbpf_find_kernel_btf(void)
> +{
> +       return libbpf_load_vmlinux_btf();
> +}
> +
> +struct btf *libbpf_load_vmlinux_btf(void)
>  {
>         struct {
>                 const char *path_fmt;
> @@ -4440,6 +4445,14 @@ struct btf *libbpf_find_kernel_btf(void)
>         return libbpf_err_ptr(-ESRCH);
>  }
>
> +struct btf *libbpf_load_module_btf(const char *module_name, struct btf *vmlinux_btf)

In the light of Quentin's btf__load_from_kernel_by_id(), I'm now
wondering if it's better to keep the naming consistent as
btf__load_vmlinux_btf() and btf__load_module_btf()? And we should put
them after btf__parse() family of constructors, as just another set of
(special, but still) constructors. WDYT?

Sorry for a bit of back and forth...

Otherwise everything looks good, thanks.

> +{
> +       char path[80];
> +
> +       snprintf(path, sizeof(path), "/sys/kernel/btf/%s", module_name);
> +       return btf__parse_split(path, vmlinux_btf);
> +}
> +
>  int btf_type_visit_type_ids(struct btf_type *t, type_id_visit_fn visit, void *ctx)
>  {
>         int i, n, err;
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 374e9f15de2e..1abf94e3bd9e 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -90,6 +90,8 @@ LIBBPF_API __u32 btf_ext__func_info_rec_size(const struct btf_ext *btf_ext);
>  LIBBPF_API __u32 btf_ext__line_info_rec_size(const struct btf_ext *btf_ext);
>
>  LIBBPF_API struct btf *libbpf_find_kernel_btf(void);
> +LIBBPF_API struct btf *libbpf_load_vmlinux_btf(void);
> +LIBBPF_API struct btf *libbpf_load_module_btf(const char *module_name, struct btf *vmlinux_btf);

as mentioned above, let's move these right after btf__parse() family,
so that all BTF constructor APIs are listed first.

>
>  LIBBPF_API int btf__find_str(struct btf *btf, const char *s);
>  LIBBPF_API int btf__add_str(struct btf *btf, const char *s);
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index a1ca6fb0c6d8..321d8f4889af 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2680,7 +2680,7 @@ static int bpf_object__load_vmlinux_btf(struct bpf_object *obj, bool force)
>         if (!force && !obj_needs_vmlinux_btf(obj))
>                 return 0;
>
> -       obj->btf_vmlinux = libbpf_find_kernel_btf();
> +       obj->btf_vmlinux = libbpf_load_vmlinux_btf();
>         err = libbpf_get_error(obj->btf_vmlinux);
>         if (err) {
>                 pr_warn("Error loading vmlinux BTF: %d\n", err);
> @@ -8297,7 +8297,7 @@ int libbpf_find_vmlinux_btf_id(const char *name,
>         struct btf *btf;
>         int err;
>
> -       btf = libbpf_find_kernel_btf();
> +       btf = libbpf_load_vmlinux_btf();
>         err = libbpf_get_error(btf);
>         if (err) {
>                 pr_warn("vmlinux BTF is not found\n");
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index c240d488eb5e..2088bdbc0f50 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -377,4 +377,6 @@ LIBBPF_0.5.0 {
>                 bpf_object__gen_loader;
>                 btf_dump__dump_type_data;
>                 libbpf_set_strict_mode;
> +               libbpf_load_vmlinux_btf;
> +               libbpf_load_module_btf;
>  } LIBBPF_0.4.0;
> --
> 2.25.1
>
