Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2B4116B9F4
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2020 07:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgBYGpN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Feb 2020 01:45:13 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41771 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgBYGpN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Feb 2020 01:45:13 -0500
Received: by mail-qk1-f196.google.com with SMTP id b5so3901274qkh.8;
        Mon, 24 Feb 2020 22:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k4mGpa6lFJ+xLU/GYHvEyHr6PhkA8euhkcKvRvI1CFE=;
        b=SUfwnzKGRBWN9dBz04mZbE1kA9I2smWFfhGGhtCGI7bx9U1TJrh4wIDfy94gtU2PqW
         I5T8VGD730Yjx6tnmPKO59Y4C2sF0a7ICWdfawRVFz+nASRJka3tieW6DgjB/BnKh+9L
         yGQ24u0rCtpwDr5gKclYT7D900LmQ9PYCbx77hK2GLfBm/Cqeol6RoxMIHB0uZSbIaHK
         57o1Abk4jNY2jY4J47SOX9uP4jobmzNRZ8QuXaxV5oPpiKUiAYU0uljxrKS6B8Tmyc/g
         J3ycM5SkFpxRxG/FH+0anfyMqb42RCY4DOFhjuJtfLUqv7RbpMylTyXPokTu/8KA7r2w
         yTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k4mGpa6lFJ+xLU/GYHvEyHr6PhkA8euhkcKvRvI1CFE=;
        b=kFkZpr2o+zpWHO+RjHlg+U77ncB/K5viiUQ7if3gYX95yccE2z/SOjdjPMIdLKKaoX
         6Up4Kf8ZeJf1Ny55i4KWnBY9/PDmdtQwP1f5lP/yAaEPDiieiHCW/Np5wf4olQPgTmRJ
         snT/16zog2w3hUSjyoOFx6F7QUFFqCrrirhTg6IZopcaXlL3v/abunHExkY11CyaIeEn
         z22ysVBO0CZW90Z1i49//OM+MHr0O+m+LZSx4Uu538pyVMLAVd3Kr6SR683PsFq9T7AZ
         jEWR4Yh4jpx3VdZM3Tw3igXAG+TnHEfWXH7F0LlDRv4JjauLbObSW1CpCiNjiPuuVZdJ
         5EPg==
X-Gm-Message-State: APjAAAV9ui82M6cVBopdj5LLcZq5VtryYBku/ewzVfWK5InvlN4w5ssu
        ZXYwpNHLPO807BiVogxRxjfmN2iPamwWWq1Lfgw=
X-Google-Smtp-Source: APXvYqy+xFYP0hh/mm9EffLEWXZeT4lA4WEk9ac5Jjq/spDLvGwzsSosqDqOkDeylj0SW9Ox2x3/jc7TGmwky8RmBm8=
X-Received: by 2002:a37:9104:: with SMTP id t4mr58093431qkd.449.1582613111335;
 Mon, 24 Feb 2020 22:45:11 -0800 (PST)
MIME-Version: 1.0
References: <20200220175250.10795-1-kpsingh@chromium.org> <20200220175250.10795-7-kpsingh@chromium.org>
In-Reply-To: <20200220175250.10795-7-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 24 Feb 2020 22:45:00 -0800
Message-ID: <CAEf4BzbSBBPx9Z728aV6pu8R0mtwumq-zbX=u7hxjQuvtQqPww@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 6/8] tools/libbpf: Add support for BPF_PROG_TYPE_LSM
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 20, 2020 at 9:53 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> Since BPF_PROG_TYPE_LSM uses the same attaching mechanism as
> BPF_PROG_TYPE_TRACING, the common logic is refactored into a static
> function bpf_program__attach_btf.
>
> A new API call bpf_program__attach_lsm is still added to avoid userspace
> conflicts if this ever changes in the future.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  tools/lib/bpf/bpf.c      |  3 ++-
>  tools/lib/bpf/libbpf.c   | 46 ++++++++++++++++++++++++++++++++--------
>  tools/lib/bpf/libbpf.h   |  4 ++++
>  tools/lib/bpf/libbpf.map |  3 +++
>  4 files changed, 46 insertions(+), 10 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index c6dafe563176..73220176728d 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -235,7 +235,8 @@ int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
>         memset(&attr, 0, sizeof(attr));
>         attr.prog_type = load_attr->prog_type;
>         attr.expected_attach_type = load_attr->expected_attach_type;
> -       if (attr.prog_type == BPF_PROG_TYPE_STRUCT_OPS) {
> +       if (attr.prog_type == BPF_PROG_TYPE_STRUCT_OPS ||
> +           attr.prog_type == BPF_PROG_TYPE_LSM) {
>                 attr.attach_btf_id = load_attr->attach_btf_id;
>         } else if (attr.prog_type == BPF_PROG_TYPE_TRACING ||
>                    attr.prog_type == BPF_PROG_TYPE_EXT) {
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 514b1a524abb..d11139d5e76b 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2351,16 +2351,14 @@ static int bpf_object__finalize_btf(struct bpf_object *obj)
>
>  static inline bool libbpf_prog_needs_vmlinux_btf(struct bpf_program *prog)
>  {
> -       if (prog->type == BPF_PROG_TYPE_STRUCT_OPS)
> +       if (prog->type == BPF_PROG_TYPE_STRUCT_OPS ||
> +           prog->type == BPF_PROG_TYPE_LSM)
>                 return true;
>
>         /* BPF_PROG_TYPE_TRACING programs which do not attach to other programs
>          * also need vmlinux BTF
>          */
> -       if (prog->type == BPF_PROG_TYPE_TRACING && !prog->attach_prog_fd)
> -               return true;
> -
> -       return false;
> +       return prog->type == BPF_PROG_TYPE_TRACING && !prog->attach_prog_fd;


please keep this as is, it allows to add more logic easily, if necessary

>  }
>
>  static int bpf_object__load_vmlinux_btf(struct bpf_object *obj)
> @@ -4855,7 +4853,8 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
>         load_attr.insns = insns;
>         load_attr.insns_cnt = insns_cnt;
>         load_attr.license = license;

[...]

> -struct bpf_link *bpf_program__attach_trace(struct bpf_program *prog)
> +/* Common logic for all BPF program types that attach to a btf_id */
> +static struct bpf_link *bpf_program__attach_btf(struct bpf_program *prog)
>  {
>         char errmsg[STRERR_BUFSIZE];
>         struct bpf_link_fd *link;
> @@ -7376,7 +7388,7 @@ struct bpf_link *bpf_program__attach_trace(struct bpf_program *prog)
>         if (pfd < 0) {
>                 pfd = -errno;
>                 free(link);
> -               pr_warn("program '%s': failed to attach to trace: %s\n",
> +               pr_warn("program '%s': failed to attach to: %s\n",

to attach to ... what?.. %s at the end is just an error message

>                         bpf_program__title(prog, false),
>                         libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
>                 return ERR_PTR(pfd);
> @@ -7385,10 +7397,26 @@ struct bpf_link *bpf_program__attach_trace(struct bpf_program *prog)
>         return (struct bpf_link *)link;
>  }
>

[...]

> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -227,10 +227,13 @@ LIBBPF_0.0.7 {
>                 bpf_probe_large_insn_limit;
>                 bpf_prog_attach_xattr;
>                 bpf_program__attach;
> +               bpf_program__attach_lsm;
>                 bpf_program__name;
>                 bpf_program__is_extension;
> +               bpf_program__is_lsm;
>                 bpf_program__is_struct_ops;
>                 bpf_program__set_extension;
> +               bpf_program__set_lsm;

please make sure to add to 0.0.8 version for new revision

>                 bpf_program__set_struct_ops;
>                 btf__align_of;
>                 libbpf_find_kernel_btf;
> --
> 2.20.1
>
