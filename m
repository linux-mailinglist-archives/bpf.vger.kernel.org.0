Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2A8486BD8
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 22:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244188AbiAFVY3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 16:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244183AbiAFVY2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jan 2022 16:24:28 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A101C061245;
        Thu,  6 Jan 2022 13:24:28 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id c4so3099210iln.7;
        Thu, 06 Jan 2022 13:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AHNjHhJNA6K9i0SnEMUnzbbgZ5bVUcNEQvH0wqh3K9E=;
        b=e5WVPOaNdGE6/i0mx3dlUWUo/207G0Ivnb5NWYR2PIU5Ows0HORFH/jl5qkL6d0KoL
         dY+RMCBQ2nZcn+tAA2duvDwOYfWx4JeipuZ8fvDYDIk7DP7ScEST/ZVzKrZTdh4XBaaw
         XjwNOxmOfpzhrcMlR0PKLt1MdoflVPd+EL3jvQpsFpnCnCoDAfqyKGXNDSYY5GA4LQNE
         czC92f6VNEv5e5AWtSWWVmiIQTN2o4B2Q78GN4FWZIme9Pnc3y0rWkskKmwk344a92Oo
         P4BJ13jA7yFqad91oT2wfOeD6Bx+1EA3iL8CxoaOT2felW8/034nDHCfB1dPRTkRUY7/
         cqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AHNjHhJNA6K9i0SnEMUnzbbgZ5bVUcNEQvH0wqh3K9E=;
        b=jWik8gWoz+3hxRzzKI+fELd+DeiDpIR2d6oE4xM9u5vdhC56oOYp59eAsHig4f1QwR
         JuFe7EJwvVIO8alwxhmzihV/oOHJ2iHCs77akfhPVy6cN/R6Dn6SFW8pa4AV9lA0T+Lp
         siYZDcTt5kXwfcom0ZS2xpUd64Rrdf6vOWVYozJTeVUw7ZxaRZS12OOkEM4OlheOASun
         IQzcIi7V5dzoOgSKJ7WgQhioBoF1Uxwmlp55rk6cjV68xUOp3XmsysftJRTGmKdLxLHw
         raJMB10dlbVMI/fGJOb1SHbNc8w5ipuFdO7YmexGesyV1wYXQCE8sUgUdXhyolOnjU1D
         yeIQ==
X-Gm-Message-State: AOAM5322PuBZts6AE4nufdJV/Srd0AK/5Ik24GlTOVXNcW15HjBgzge8
        r/utTFraSuAHkFuEx57Jwm4NOqnxaOpnXaA2hfo=
X-Google-Smtp-Source: ABdhPJwahFu67nQkVi/3aEoJVgFaQTkWv49uJOEbaY2Fs9hE6iK+/VL67lRQ20zz9Iu8DtxU+48ZU1bPQREXF5VunWc=
X-Received: by 2002:a05:6e02:b4c:: with SMTP id f12mr27101949ilu.252.1641504267973;
 Thu, 06 Jan 2022 13:24:27 -0800 (PST)
MIME-Version: 1.0
References: <20220106200032.3067127-1-christylee@fb.com> <20220106200032.3067127-2-christylee@fb.com>
In-Reply-To: <20220106200032.3067127-2-christylee@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 6 Jan 2022 13:24:16 -0800
Message-ID: <CAEf4Bzad6-Pf51Gez2hA4orvuR90YyB_eqYzVLG1H229jkn8uw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] perf: stop using deprecated
 bpf_prog_load() API
To:     Christy Lee <christylee@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Christy Lee <christyc.y.lee@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Wang Nan <wangnan0@huawei.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 6, 2022 at 12:03 PM Christy Lee <christylee@fb.com> wrote:
>
> bpf_prog_load() API is deprecated, remove perf's usage of the deprecated
> function.
>
> Signed-off-by: Christy Lee <christylee@fb.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/perf/tests/bpf.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
> index 573490530194..57b9591f7cbb 100644
> --- a/tools/perf/tests/bpf.c
> +++ b/tools/perf/tests/bpf.c
> @@ -281,8 +281,8 @@ static int __test__bpf(int idx)
>
>  static int check_env(void)
>  {
> +       LIBBPF_OPTS(bpf_prog_load_opts, opts);
>         int err;
> -       unsigned int kver_int;
>         char license[] = "GPL";
>
>         struct bpf_insn insns[] = {
> @@ -290,19 +290,13 @@ static int check_env(void)
>                 BPF_EXIT_INSN(),
>         };
>
> -       err = fetch_kernel_version(&kver_int, NULL, 0);
> +       err = fetch_kernel_version(&opts.kern_version, NULL, 0);
>         if (err) {
>                 pr_debug("Unable to get kernel version\n");
>                 return err;
>         }
> -
> -/* temporarily disable libbpf deprecation warnings */
> -#pragma GCC diagnostic push
> -#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> -       err = bpf_load_program(BPF_PROG_TYPE_KPROBE, insns,
> -                              ARRAY_SIZE(insns),
> -                              license, kver_int, NULL, 0);
> -#pragma GCC diagnostic pop
> +       err = bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, license, insns,
> +                           ARRAY_SIZE(insns), &opts);

Christy, you should probably define __weak bpf_prog_load
implementation that will re-route to bpf_load_program? See how it was
done for other APIs (e.g., btf__load_from_kernel_by_id).

Arnaldo, more generally, what would be the plan for libbpf 1.0 at
which point those deprecated APIs (e.g., bpf_load_program) are going
to be removed completely? Do you have some control over the minimal
libbpf version for cases when you'd like to use libbpf as a shared
library?


>         if (err < 0) {
>                 pr_err("Missing basic BPF support, skip this test: %s\n",
>                        strerror(errno));
> --
> 2.30.2
>
