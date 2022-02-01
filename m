Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1DD4A575A
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 07:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiBAGrG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 01:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbiBAGrG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 01:47:06 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5A5C061714
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 22:47:05 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id r144so19944027iod.9
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 22:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4VzB8zgAlMmNuY0f+WXMhUNNVF011pTzhJydN5nGHJc=;
        b=VZ84nmBPq49Dgfy49CpTJtN1v84V84+E8dUP+kw2EbUWYoqkwucgznAN2yhzIsVgKF
         K0V6EjJL0rI+C3S5godAao5X5K+EFkpKYV3sNsJKwJgeHL1vnhDkbQv40CHcjKyvJPGt
         Di5qjN0FmoPCLy2TcA3r0Yiqkf0R4LPQMgILWMldw5zfCosp5m12/no4MOHAHJ5ywRRI
         fIb9a65CnekqP/K/HPIPiW7j4OTGWuTj77P6UUYY2kYM49pPcUJKnKpXZ6slByNsrSRS
         LN6qd8yJOE+dId8fw04ONukDky1jhPeCKkoDnXcocQG6qJocaMJP2IjQMxD4ANuf1PeI
         y2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4VzB8zgAlMmNuY0f+WXMhUNNVF011pTzhJydN5nGHJc=;
        b=t2oLWrETSdtoB20sibA8jE/SYhgHaoRigKW0VbC3UrIO3XRG+hjnrKBXWjZAprFoMQ
         yyPfiLeX3gYhwVZrrCjn4dbhy/lIdv9pVrNRo6zYQlECCedZ4ACZgWK2P3wmCYOke13E
         NA92iL9H9cq4kjjwMopFIUwzSQnBr/UG89VV/pny7RgNs44nGzBEHMYDKehuZrXAOpR2
         Fq+50C4oo9Hhk5ubfJnasPDdPiiel09rHTrSzaXN9/cGgXsrX1j52oRgfUhXKtpGZRk6
         BqjU+3vNCRj5zvoekN/5N6ZwegA3RZ6Llv94PL94znZ5t8UH6HYYvrpw6mp/38zyXbtI
         2htw==
X-Gm-Message-State: AOAM5318IIRY+iQEWWQGVzLm/KX0aHopPZRmKx83N3y4Bt426w4UnNMT
        DYexhhazakylpNEg27JjIrOXizeWpt/MNuwdB7Xo2H99
X-Google-Smtp-Source: ABdhPJwSUINqVTG6fWq34OM44qwzh5rU2keJEfCdBrVPzaNpWOmlqMOjDDkL4M5f6Yp5YUJP4YUM3lhzSgzdZEMycTw=
X-Received: by 2002:a02:2422:: with SMTP id f34mr12306872jaa.237.1643698025286;
 Mon, 31 Jan 2022 22:47:05 -0800 (PST)
MIME-Version: 1.0
References: <20220126214809.3868787-1-kuifeng@fb.com> <20220126214809.3868787-5-kuifeng@fb.com>
In-Reply-To: <20220126214809.3868787-5-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 31 Jan 2022 22:46:54 -0800
Message-ID: <CAEf4BzaLaPfnYTQppVq1ixACLQJcDWYyjMRD42YuQFMUb4rLDA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/5] bpf: Attach a cookie to a BPF program.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 26, 2022 at 1:48 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Extend bpf() to attach a tracing program with a cookie by adding a
> bpf_cookie field to bpf_attr for raw tracepoints.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>  include/linux/bpf.h            |  1 +
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/bpf/syscall.c           | 12 ++++++++----
>  tools/include/uapi/linux/bpf.h |  1 +
>  tools/lib/bpf/bpf.c            | 14 ++++++++++++++
>  tools/lib/bpf/bpf.h            |  1 +
>  tools/lib/bpf/libbpf.map       |  1 +
>  7 files changed, 27 insertions(+), 4 deletions(-)
>

We normally split out kernel, libbpf, samples/bpf, selftests/bpf,
bpftool, etc changes into separate patches, if possible. Please do
that in the next revision.

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 37353745fee5..d5196514e9bd 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1004,6 +1004,7 @@ struct bpf_prog_aux {
>                 struct work_struct work;
>                 struct rcu_head rcu;
>         };
> +       u64 cookie;
>  };
>
>  struct bpf_array_aux {
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 16a7574292a5..3fa27346ab4b 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1425,6 +1425,7 @@ union bpf_attr {
>         struct { /* anonymous struct used by BPF_RAW_TRACEPOINT_OPEN command */
>                 __u64 name;
>                 __u32 prog_fd;
> +               __u64 bpf_cookie;
>         } raw_tracepoint;
>

As an aside, Alexei, should we bite a bullet and allow attaching
raw_tp, fentry/fexit, and other tracing prog attachment through the
LINK_CREATE command? BPF_RAW_TRACEPOINT_OPEN makes little sense for
anything but raw_tp programs. Libbpf can do feature detection and
route between RAW_TRACEPOINT_OPEN and LINK_CREATE commands depending
on whether bpf_cookie and whatever other newer things we add, so that
it's compatible with old kernels. As we also add multi-attach
fentry/fexit, it would be nice to keep everything in LINK_CREATE
section of bpf_attr, similar to multi-attach kprobe case. WDYT?


>         struct { /* anonymous struct for BPF_BTF_LOAD */
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 72ce1edde950..79d057918c76 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2696,7 +2696,8 @@ static const struct bpf_link_ops bpf_tracing_link_lops = {
>
>  static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>                                    int tgt_prog_fd,
> -                                  u32 btf_id)
> +                                  u32 btf_id,
> +                                  u64 bpf_cookie)
>  {
>         struct bpf_link_primer link_primer;
>         struct bpf_prog *tgt_prog = NULL;
> @@ -2832,6 +2833,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>         if (err)
>                 goto out_unlock;
>
> +       prog->aux->cookie = bpf_cookie;
> +
>         err = bpf_trampoline_link_prog(prog, tr);
>         if (err) {
>                 bpf_link_cleanup(&link_primer);
> @@ -3017,7 +3020,7 @@ static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *pro
>  }
>  #endif /* CONFIG_PERF_EVENTS */
>
> -#define BPF_RAW_TRACEPOINT_OPEN_LAST_FIELD raw_tracepoint.prog_fd
> +#define BPF_RAW_TRACEPOINT_OPEN_LAST_FIELD raw_tracepoint.bpf_cookie
>
>  static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
>  {
> @@ -3052,7 +3055,7 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
>                         tp_name = prog->aux->attach_func_name;
>                         break;
>                 }
> -               err = bpf_tracing_prog_attach(prog, 0, 0);
> +               err = bpf_tracing_prog_attach(prog, 0, 0, attr->raw_tracepoint.bpf_cookie);
>                 if (err >= 0)
>                         return err;
>                 goto out_put_prog;
> @@ -4244,7 +4247,8 @@ static int tracing_bpf_link_attach(const union bpf_attr *attr, bpfptr_t uattr,
>         else if (prog->type == BPF_PROG_TYPE_EXT)
>                 return bpf_tracing_prog_attach(prog,
>                                                attr->link_create.target_fd,
> -                                              attr->link_create.target_btf_id);
> +                                              attr->link_create.target_btf_id,
> +                                              0);
>         return -EINVAL;
>  }
>
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 16a7574292a5..3fa27346ab4b 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1425,6 +1425,7 @@ union bpf_attr {
>         struct { /* anonymous struct used by BPF_RAW_TRACEPOINT_OPEN command */
>                 __u64 name;
>                 __u32 prog_fd;
> +               __u64 bpf_cookie;
>         } raw_tracepoint;
>
>         struct { /* anonymous struct for BPF_BTF_LOAD */
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 418b259166f8..c28b017de515 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -1131,6 +1131,20 @@ int bpf_raw_tracepoint_open(const char *name, int prog_fd)
>         return libbpf_err_errno(fd);
>  }
>
> +int bpf_raw_tracepoint_cookie_open(const char *name, int prog_fd, __u64 bpf_cookie)
> +{
> +       union bpf_attr attr;
> +       int fd;
> +
> +       memset(&attr, 0, sizeof(attr));
> +       attr.raw_tracepoint.name = ptr_to_u64(name);
> +       attr.raw_tracepoint.prog_fd = prog_fd;
> +       attr.raw_tracepoint.bpf_cookie = bpf_cookie;
> +
> +       fd = sys_bpf_fd(BPF_RAW_TRACEPOINT_OPEN, &attr, sizeof(attr));
> +       return libbpf_err_errno(fd);
> +}
> +
>  int bpf_btf_load(const void *btf_data, size_t btf_size, const struct bpf_btf_load_opts *opts)
>  {
>         const size_t attr_sz = offsetofend(union bpf_attr, btf_log_level);
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index c2e8327010f9..c3d2c6a4cb15 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -475,6 +475,7 @@ LIBBPF_API int bpf_prog_query(int target_fd, enum bpf_attach_type type,
>                               __u32 query_flags, __u32 *attach_flags,
>                               __u32 *prog_ids, __u32 *prog_cnt);
>  LIBBPF_API int bpf_raw_tracepoint_open(const char *name, int prog_fd);
> +LIBBPF_API int bpf_raw_tracepoint_cookie_open(const char *name, int prog_fd, __u64 bpf_cookie);
>  LIBBPF_API int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf,
>                                  __u32 *buf_len, __u32 *prog_id, __u32 *fd_type,
>                                  __u64 *probe_offset, __u64 *probe_addr);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index e10f0822845a..05af5bb8de92 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -432,6 +432,7 @@ LIBBPF_0.7.0 {
>                 bpf_xdp_detach;
>                 bpf_xdp_query;
>                 bpf_xdp_query_id;
> +               bpf_raw_tracepoint_cookie_open;
>                 libbpf_probe_bpf_helper;
>                 libbpf_probe_bpf_map_type;
>                 libbpf_probe_bpf_prog_type;
> --
> 2.30.2
>
