Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92603141161
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2020 20:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgAQTC7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jan 2020 14:02:59 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42916 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgAQTC7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jan 2020 14:02:59 -0500
Received: by mail-qk1-f195.google.com with SMTP id z14so23716021qkg.9;
        Fri, 17 Jan 2020 11:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xrZfy1ZBqaJdbFMC9RZOAyaik5031ymapErOhHW5tUU=;
        b=rZBWKz2O3flzi7dwrb24j34hQaubuEeF/RUd+oBNrOOc9vAeqMs3eyYWBJUhJYp3L0
         HL2+BVcoBtQ4gPfU4vkiAEyLWAgjw1JXz6LpB1sZpLeMu2a8K2pF4doC1f27U4kq3mx1
         DL+NbtRRqD/IptnlnJe1M2vRJOyQNNN+bUctRlFHWGv6kdKyb3aoQcP2yxaNPxQhXrYm
         9luUSGtWZlKnIDni4JSu3nvNsa6IDOKe8iZpqZOQKKWAiR3XokR46PGHZyyT2YLC7DWS
         gZHnKDYhY/1oEStlQnaeayouaNfNSjjWcfJcEx0cuDib26pBHcMDfv0bIPztPjbcvBBZ
         cnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xrZfy1ZBqaJdbFMC9RZOAyaik5031ymapErOhHW5tUU=;
        b=feMEm7gxbmcQfim3RREL1C949Y3EqTew81/UpOHvssDKaKZ8aLpY60blws+EXuESFT
         1mrTo1rRxjyre5c/YVJsISef+TDGwwMFW7z5wLVPVVyOQbJr2uElEMYqS1qUrGw6eCeK
         F3tdW7TC51LSFs329oxIYHqnMBeV09m/mVgKVb88beMGsJH/hXGhYN16FtPdGPs9RU8o
         zbRI+ht52XJMewqTYcDewHFiZ4KOzjPyuTKrw+lbx48h9hK1+908c5BwOVYPzY57wxkb
         RPk70NByWM2wGuqzWjPcgcR9aKrcPqvSRS3ush2w2lVUn7iXguX5X+sUVv0VUtDvExgw
         4oUg==
X-Gm-Message-State: APjAAAXKK8KAE4QIw1tS8snuMeDvs3ImO63ZAgiGu9Q8EZgvlZ9E27n8
        BWeKblIdgeVY4fr0uG9HAVf+n1jmrkozEynrc3I=
X-Google-Smtp-Source: APXvYqxOx2FE7TLlr7KTQQpchusztnw2u0N+XIYtSypkzClW8qymCD6PrQWis9AZVGh6y0V1tgBezAYFXNws/zGsyF4=
X-Received: by 2002:ae9:e809:: with SMTP id a9mr23331535qkg.92.1579287777873;
 Fri, 17 Jan 2020 11:02:57 -0800 (PST)
MIME-Version: 1.0
References: <20200117165821.21482-1-kpsingh@chromium.org>
In-Reply-To: <20200117165821.21482-1-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Jan 2020 11:02:46 -0800
Message-ID: <CAEf4Bzazg0HQt7dSXMBdGTePL+zrTxVP5v5WpSYKk8PFpF4iYg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Load btf_vmlinux only once per object.
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Anton Protopopov <a.s.protopopov@gmail.com>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 17, 2020 at 8:58 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> As more programs (TRACING, STRUCT_OPS, and upcoming LSM) use vmlinux
> BTF information, loading the BTF vmlinux information for every program
> in an object is sub-optimal. The fix was originally proposed in:
>
>    https://lore.kernel.org/bpf/CAEf4BzZodr3LKJuM7QwD38BiEH02Cc1UbtnGpVkCJ00Mf+V_Qg@mail.gmail.com/
>
> The btf_vmlinux is populated in the object if any of the programs in
> the object requires it just before the programs are loaded and freed
> after the programs finish loading.
>
> Reported-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Reviewed-by: Brendan Jackman <jackmanb@chromium.org>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---

Thanks for the clean up! Few issues, but overall I like this.

>  tools/lib/bpf/libbpf.c | 148 +++++++++++++++++++++++++++--------------
>  1 file changed, 97 insertions(+), 51 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 3afaca9bce1d..db0e93882a3b 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -385,6 +385,10 @@ struct bpf_object {

[...]

> @@ -2364,6 +2357,38 @@ static int bpf_object__finalize_btf(struct bpf_object *obj)
>         return 0;
>  }
>
> +static inline bool libbpf_prog_needs_vmlinux_btf(struct bpf_program *prog)
> +{

I suspect that at some point this approach won't be flexible enough,
but it simplifies error handling right now, so I'm ok with it.

> +       if (prog->type == BPF_PROG_TYPE_STRUCT_OPS)
> +               return true;
> +
> +       /* BPF_PROG_TYPE_TRACING programs which do not attach to other programs
> +        * also need vmlinux BTF
> +        */
> +       if (prog->type == BPF_PROG_TYPE_TRACING && !prog->attach_prog_fd)
> +               return true;
> +
> +       return false;
> +}
> +
> +static int bpf_object__load_vmlinux_btf(struct bpf_object *obj)
> +{
> +       struct bpf_program *prog;
> +
> +       bpf_object__for_each_program(prog, obj) {
> +               if (libbpf_prog_needs_vmlinux_btf(prog)) {
> +                       obj->btf_vmlinux = libbpf_find_kernel_btf();
> +                       if (IS_ERR(obj->btf_vmlinux)) {
> +                               pr_warn("vmlinux BTF is not found\n");

please, emit error code as well

also, clear out btf_vmlinux, otherwise your code will attempt to free
invalid pointer later on

> +                               return -EINVAL;
> +                       }
> +                       return 0;
> +               }
> +       }
> +
> +       return 0;
> +}

[...]

> @@ -5280,10 +5301,17 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
>         err = err ? : bpf_object__resolve_externs(obj, obj->kconfig);
>         err = err ? : bpf_object__sanitize_and_load_btf(obj);
>         err = err ? : bpf_object__sanitize_maps(obj);
> +       err = err ? : bpf_object__load_vmlinux_btf(obj);
>         err = err ? : bpf_object__init_kern_struct_ops_maps(obj);
>         err = err ? : bpf_object__create_maps(obj);
>         err = err ? : bpf_object__relocate(obj, attr->target_btf_path);
>         err = err ? : bpf_object__load_progs(obj, attr->log_level);
> +
> +       if (obj->btf_vmlinux) {

you can skip this check, btf__free(NULL) is handled properly as noop

> +               btf__free(obj->btf_vmlinux);
> +               obj->btf_vmlinux = NULL;
> +       }
> +
>         if (err)
>                 goto out;

[...]

> +
> +static inline int __find_vmlinux_btf_id(struct btf *btf, const char *name,
> +                                       enum bpf_attach_type attach_type)
> +{
> +       int err;
> +
> +       if (attach_type == BPF_TRACE_RAW_TP)
> +               err = find_btf_by_prefix_kind(btf, BTF_TRACE_PREFIX, name,
> +                                             BTF_KIND_TYPEDEF);
> +       else
> +               err = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
> +
> +       return err;
> +}
> +
>  int libbpf_find_vmlinux_btf_id(const char *name,
>                                enum bpf_attach_type attach_type)
>  {
>         struct btf *btf = libbpf_find_kernel_btf();

I had complaints previously about doing too much heavy-lifting in
variable assignment, not sure why this slipped through. Can you please
split this into variable declaration and separate assignment below?

> -       char raw_tp_btf[128] = BTF_PREFIX;
> -       char *dst = raw_tp_btf + sizeof(BTF_PREFIX) - 1;
> -       const char *btf_name;
> -       int err = -EINVAL;
> -       __u32 kind;
>
>         if (IS_ERR(btf)) {
>                 pr_warn("vmlinux BTF is not found\n");
>                 return -EINVAL;
>         }
>
> -       if (attach_type == BPF_TRACE_RAW_TP) {
> -               /* prepend "btf_trace_" prefix per kernel convention */
> -               strncat(dst, name, sizeof(raw_tp_btf) - sizeof(BTF_PREFIX));
> -               btf_name = raw_tp_btf;
> -               kind = BTF_KIND_TYPEDEF;
> -       } else {
> -               btf_name = name;
> -               kind = BTF_KIND_FUNC;
> -       }
> -       err = btf__find_by_name_kind(btf, btf_name, kind);
> -       btf__free(btf);
> -       return err;
> +       return __find_vmlinux_btf_id(btf, name, attach_type);
>  }
>
>  static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd)
> @@ -6567,10 +6612,11 @@ static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd)
>         return err;
>  }
>
> -static int libbpf_find_attach_btf_id(const char *name,
> -                                    enum bpf_attach_type attach_type,
> -                                    __u32 attach_prog_fd)
> +static int libbpf_find_attach_btf_id(struct bpf_program *prog)
>  {
> +       enum bpf_attach_type attach_type = prog->expected_attach_type;
> +       __u32 attach_prog_fd = prog->attach_prog_fd;
> +       const char *name = prog->section_name;
>         int i, err;
>
>         if (!name)
> @@ -6585,8 +6631,8 @@ static int libbpf_find_attach_btf_id(const char *name,
>                         err = libbpf_find_prog_btf_id(name + section_defs[i].len,
>                                                       attach_prog_fd);
>                 else
> -                       err = libbpf_find_vmlinux_btf_id(name + section_defs[i].len,
> -                                                        attach_type);
> +                       err = __find_vmlinux_btf_id(prog->obj->btf_vmlinux,
> +                               name + section_defs[i].len, attach_type);

argument indentation is off here, please fix

>                 if (err <= 0)
>                         pr_warn("%s is not found in vmlinux BTF\n", name);
>                 return err;
> --
> 2.20.1
>
