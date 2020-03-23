Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C987C18FF6A
	for <lists+bpf@lfdr.de>; Mon, 23 Mar 2020 21:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgCWUZw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Mar 2020 16:25:52 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38080 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgCWUZn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Mar 2020 16:25:43 -0400
Received: by mail-qk1-f193.google.com with SMTP id h14so16878788qke.5;
        Mon, 23 Mar 2020 13:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QlTyxMWvSNbxfRsyEmBDMdt2GlT2RJ5IDWmnYWWfRmM=;
        b=psskmkw01jKfZz8jy9sBxHNn8ffqQ1CkLMqAt06F1bXqYoM1syXvfDImA9A62bbb81
         spLK5yqbPUx3frRjOoJ5VzMy/Q0Q2rkSIGx9Di91V6zJtBK+zGYwAAUMfI87bWmI9HVJ
         ZX7L18o0c7ojyj4i5jdNYfBT0sdmwkl1EEbayPi71aj6PntVy76JLkIwBjLurKZJqdPo
         PIMnV3qelnodT4VtD/tYg0J0vKe6naA3G+ePZLOb4POoyjWqvZ5cj/kBLBIek4sa0AKy
         TMXHr3XW+lSaUzS0iLJCpTcllMf3N0EeGP60qbgpUTsGrjptSHyLmvmE69psb9qImAoK
         YUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QlTyxMWvSNbxfRsyEmBDMdt2GlT2RJ5IDWmnYWWfRmM=;
        b=smTsO+o9F+Z/jqRsFOqDwLYzkayR7DVXXX7LD1X6ndG8vNDjXUMyygl72iYZEOOgK1
         +GzAkSLVm7USi6ykLWGMPVUa7Rwzjhia2bdRrutimxjcl4bo2ALJxZk5/JclHneIMoiL
         2XDOLuNxfsALgj1MroBA1ZsfV6hGfdEOAnAwnTZYKGEhLUeYVWfRUFqNNhv/soXkiLqJ
         WThopYHunMFvCbUWzhyrThYyUoKEdVpJTY5QWtedv2FMqtX1DtR66iLB0T85qD6WvP8O
         ZlVHaFNK/F9D7lP7d8By2gqNHiXQGEcz1Zxy+M+fwsT5S1Bk/s6nPmkuhSKJ/yzBcJsm
         4abA==
X-Gm-Message-State: ANhLgQ1ovxKbWvh89ema6irUgE2ULaX0WVfczRGZh0s+dvdxYuRFELr8
        2ATs/1R2mEGVdTflENcHH7tvSLGbsx923nJ3rls=
X-Google-Smtp-Source: ADFU+vtSFi11sRgyoZHOpJyMI6AFtlBCOGh0OvRl2KI5FU3wu4gd1/1eyPUP0LLZ4kPsNBv6uIveVmqQreo91mufXd8=
X-Received: by 2002:a05:620a:88e:: with SMTP id b14mr12033793qka.449.1584995142140;
 Mon, 23 Mar 2020 13:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200323164415.12943-1-kpsingh@chromium.org> <20200323164415.12943-7-kpsingh@chromium.org>
In-Reply-To: <20200323164415.12943-7-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 23 Mar 2020 13:25:31 -0700
Message-ID: <CAEf4BzYr+SMdGKGN-MCRzaS3e2MEQeQFSbuOZ55Vd-gK9RwDPA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 6/7] tools/libbpf: Add support for BPF_PROG_TYPE_LSM
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 23, 2020 at 9:45 AM KP Singh <kpsingh@chromium.org> wrote:
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
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> ---
>  tools/lib/bpf/bpf.c      |  3 ++-
>  tools/lib/bpf/libbpf.c   | 41 +++++++++++++++++++++++++++++++++++-----
>  tools/lib/bpf/libbpf.h   |  4 ++++
>  tools/lib/bpf/libbpf.map |  3 +++
>  4 files changed, 45 insertions(+), 6 deletions(-)
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
> index 085e41f9b68e..da8bee78e1ce 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2362,7 +2362,8 @@ static int bpf_object__finalize_btf(struct bpf_object *obj)
>
>  static inline bool libbpf_prog_needs_vmlinux_btf(struct bpf_program *prog)
>  {
> -       if (prog->type == BPF_PROG_TYPE_STRUCT_OPS)
> +       if (prog->type == BPF_PROG_TYPE_STRUCT_OPS ||
> +           prog->type == BPF_PROG_TYPE_LSM)
>                 return true;
>
>         /* BPF_PROG_TYPE_TRACING programs which do not attach to other programs
> @@ -4870,7 +4871,8 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
>         load_attr.insns = insns;
>         load_attr.insns_cnt = insns_cnt;
>         load_attr.license = license;
> -       if (prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
> +       if (prog->type == BPF_PROG_TYPE_STRUCT_OPS ||
> +           prog->type == BPF_PROG_TYPE_LSM) {
>                 load_attr.attach_btf_id = prog->attach_btf_id;
>         } else if (prog->type == BPF_PROG_TYPE_TRACING ||
>                    prog->type == BPF_PROG_TYPE_EXT) {
> @@ -4955,6 +4957,7 @@ int bpf_program__load(struct bpf_program *prog, char *license, __u32 kern_ver)
>         int err = 0, fd, i, btf_id;
>
>         if ((prog->type == BPF_PROG_TYPE_TRACING ||
> +            prog->type == BPF_PROG_TYPE_LSM ||
>              prog->type == BPF_PROG_TYPE_EXT) && !prog->attach_btf_id) {
>                 btf_id = libbpf_find_attach_btf_id(prog);
>                 if (btf_id <= 0)
> @@ -6194,6 +6197,7 @@ bool bpf_program__is_##NAME(const struct bpf_program *prog)       \
>  }                                                              \
>
>  BPF_PROG_TYPE_FNS(socket_filter, BPF_PROG_TYPE_SOCKET_FILTER);
> +BPF_PROG_TYPE_FNS(lsm, BPF_PROG_TYPE_LSM);
>  BPF_PROG_TYPE_FNS(kprobe, BPF_PROG_TYPE_KPROBE);
>  BPF_PROG_TYPE_FNS(sched_cls, BPF_PROG_TYPE_SCHED_CLS);
>  BPF_PROG_TYPE_FNS(sched_act, BPF_PROG_TYPE_SCHED_ACT);
> @@ -6260,6 +6264,8 @@ static struct bpf_link *attach_raw_tp(const struct bpf_sec_def *sec,
>                                       struct bpf_program *prog);
>  static struct bpf_link *attach_trace(const struct bpf_sec_def *sec,
>                                      struct bpf_program *prog);
> +static struct bpf_link *attach_lsm(const struct bpf_sec_def *sec,
> +                                  struct bpf_program *prog);
>
>  struct bpf_sec_def {
>         const char *sec;
> @@ -6310,6 +6316,10 @@ static const struct bpf_sec_def section_defs[] = {
>         SEC_DEF("freplace/", EXT,
>                 .is_attach_btf = true,
>                 .attach_fn = attach_trace),
> +       SEC_DEF("lsm/", LSM,
> +               .is_attach_btf = true,
> +               .expected_attach_type = BPF_LSM_MAC,
> +               .attach_fn = attach_lsm),
>         BPF_PROG_SEC("xdp",                     BPF_PROG_TYPE_XDP),
>         BPF_PROG_SEC("perf_event",              BPF_PROG_TYPE_PERF_EVENT),
>         BPF_PROG_SEC("lwt_in",                  BPF_PROG_TYPE_LWT_IN),
> @@ -6572,6 +6582,7 @@ static int bpf_object__collect_struct_ops_map_reloc(struct bpf_object *obj,
>  }
>
>  #define BTF_TRACE_PREFIX "btf_trace_"
> +#define BTF_LSM_PREFIX "bpf_lsm_"
>  #define BTF_MAX_NAME_SIZE 128
>
>  static int find_btf_by_prefix_kind(const struct btf *btf, const char *prefix,
> @@ -6599,6 +6610,9 @@ static inline int __find_vmlinux_btf_id(struct btf *btf, const char *name,
>         if (attach_type == BPF_TRACE_RAW_TP)
>                 err = find_btf_by_prefix_kind(btf, BTF_TRACE_PREFIX, name,
>                                               BTF_KIND_TYPEDEF);
> +       else if (attach_type == BPF_LSM_MAC)
> +               err = find_btf_by_prefix_kind(btf, BTF_LSM_PREFIX, name,
> +                                             BTF_KIND_FUNC);
>         else
>                 err = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
>
> @@ -7452,7 +7466,8 @@ static struct bpf_link *attach_raw_tp(const struct bpf_sec_def *sec,
>         return bpf_program__attach_raw_tracepoint(prog, tp_name);
>  }
>
> -struct bpf_link *bpf_program__attach_trace(struct bpf_program *prog)
> +/* Common logic for all BPF program types that attach to a btf_id */
> +static struct bpf_link *bpf_program__attach_btf(struct bpf_program *prog)

bpf_program__attach_btf_id() would be a bit more precise name

>  {
>         char errmsg[STRERR_BUFSIZE];
>         struct bpf_link *link;
> @@ -7474,7 +7489,7 @@ struct bpf_link *bpf_program__attach_trace(struct bpf_program *prog)
>         if (pfd < 0) {
>                 pfd = -errno;
>                 free(link);
> -               pr_warn("program '%s': failed to attach to trace: %s\n",
> +               pr_warn("program '%s': failed to attach: %s\n",
>                         bpf_program__title(prog, false),
>                         libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
>                 return ERR_PTR(pfd);
> @@ -7483,10 +7498,26 @@ struct bpf_link *bpf_program__attach_trace(struct bpf_program *prog)
>         return (struct bpf_link *)link;
>  }
>
> +struct bpf_link *bpf_program__attach_trace(struct bpf_program *prog)
> +{
> +       return bpf_program__attach_btf(prog);
> +}
> +
> +struct bpf_link *bpf_program__attach_lsm(struct bpf_program *prog)
> +{
> +       return bpf_program__attach_btf(prog);
> +}
> +
>  static struct bpf_link *attach_trace(const struct bpf_sec_def *sec,
>                                      struct bpf_program *prog)
>  {
> -       return bpf_program__attach_trace(prog);
> +       return bpf_program__attach_btf(prog);

well, no, it should call bpf_program__attach_trace()

> +}
> +
> +static struct bpf_link *attach_lsm(const struct bpf_sec_def *sec,
> +                                  struct bpf_program *prog)
> +{
> +       return bpf_program__attach_btf(prog);

and bpf_program__attach_lsm() here, don't shortcut invocation (you
argued yourself above, what if something about LSM changes, why
updating this invocation as well?)

>  }
>
>  struct bpf_link *bpf_program__attach(struct bpf_program *prog)
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index d38d7a629417..df1be44c8118 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -248,6 +248,8 @@ bpf_program__attach_raw_tracepoint(struct bpf_program *prog,
>
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_trace(struct bpf_program *prog);
> +LIBBPF_API struct bpf_link *
> +bpf_program__attach_lsm(struct bpf_program *prog);
>  struct bpf_map;
>  LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(struct bpf_map *map);
>  struct bpf_insn;
> @@ -321,6 +323,7 @@ LIBBPF_API int bpf_program__set_socket_filter(struct bpf_program *prog);
>  LIBBPF_API int bpf_program__set_tracepoint(struct bpf_program *prog);
>  LIBBPF_API int bpf_program__set_raw_tracepoint(struct bpf_program *prog);
>  LIBBPF_API int bpf_program__set_kprobe(struct bpf_program *prog);
> +LIBBPF_API int bpf_program__set_lsm(struct bpf_program *prog);
>  LIBBPF_API int bpf_program__set_sched_cls(struct bpf_program *prog);
>  LIBBPF_API int bpf_program__set_sched_act(struct bpf_program *prog);
>  LIBBPF_API int bpf_program__set_xdp(struct bpf_program *prog);
> @@ -347,6 +350,7 @@ LIBBPF_API bool bpf_program__is_socket_filter(const struct bpf_program *prog);
>  LIBBPF_API bool bpf_program__is_tracepoint(const struct bpf_program *prog);
>  LIBBPF_API bool bpf_program__is_raw_tracepoint(const struct bpf_program *prog);
>  LIBBPF_API bool bpf_program__is_kprobe(const struct bpf_program *prog);
> +LIBBPF_API bool bpf_program__is_lsm(const struct bpf_program *prog);
>  LIBBPF_API bool bpf_program__is_sched_cls(const struct bpf_program *prog);
>  LIBBPF_API bool bpf_program__is_sched_act(const struct bpf_program *prog);
>  LIBBPF_API bool bpf_program__is_xdp(const struct bpf_program *prog);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 5129283c0284..ec29d3aa2700 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -243,5 +243,8 @@ LIBBPF_0.0.8 {
>                 bpf_link__pin;
>                 bpf_link__pin_path;
>                 bpf_link__unpin;
> +               bpf_program__attach_lsm;
> +               bpf_program__is_lsm;
>                 bpf_program__set_attach_target;
> +               bpf_program__set_lsm;
>  } LIBBPF_0.0.7;
> --
> 2.20.1
>
