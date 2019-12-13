Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC9AF11DE5A
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2019 07:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbfLMG6P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Dec 2019 01:58:15 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45746 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfLMG6P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Dec 2019 01:58:15 -0500
Received: by mail-qk1-f196.google.com with SMTP id x1so895511qkl.12
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2019 22:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t1QCDa5OHvvB0Z+OZwtYsNcKnprN7g3cyeb/F970LcE=;
        b=kwQdbmVr5Dmp4x/5XPrbW7ExMLE4jTDoFCwNum02gGPpUkltiVfNaGCRRClnGSdfMu
         dJkqoFYfrOSnryj0xhEC4BK3oL/F6k7MxikBx0wfTlUoB89Df/RlXd6sGkvUw7GKHMWj
         j1K0TX5IXi+KMdsg2G8JwNb7qluy3gWxk12dzDlu6/db76TBQHZDlnJ0n3XXNKYqDN2b
         2A0ho6m7mD4pG0xTU5N3Fs98v9/h2bmXL7kqFosDOimqGLKL+JxHX5nCaWBKDEMu3btZ
         yQkcAK3nSvZHHTB9bWEO1ZPGBVcPkC6KVpLdVhcoOsqi9Wgkhxr33Ank10c4JRyxy2ru
         ndEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t1QCDa5OHvvB0Z+OZwtYsNcKnprN7g3cyeb/F970LcE=;
        b=YGB3ZMQgkSG63wz1nGSREjj8c0wnli5knn4s/l1r5K+BQXayKU1wB/wrHgOuDzbONc
         rVi6JyB0sYRDJiA0ymhBENx7x8J3i5zRBxv+4/tU35KiPbDTCHELiHiDoft2a3Fg3lRo
         2fLtCDLZfKU/78cGCgB/+2wJYXDyFcBhPildlroUY4tO6AaF9tLEnw/NBhRti8TPR8GO
         rjMux9MFtYElez10uTXa0kDDuUb7CaiHEPSErYNiWdj7EOUplYbPPeLkF2vd56TLUsFe
         htoND/UuK9SwYi5J+/S6BEPc2F8JgB67nAYtLltCqUtXf5AbiAhx6vp2n0XpZB3SBmui
         fSRQ==
X-Gm-Message-State: APjAAAV9YxjsX9eTiNC4gRmyLxDMSMTq+tjcyTYTUzHweJGTMxusZCtD
        c/86K3BxoH9+a3hwQ0GWGgSbt5kEspQSFre9clc=
X-Google-Smtp-Source: APXvYqwR7l2+RH5cq4sQgowdIQxOYd9Z8WhwFjWvAOkZJscAJhFM+RgqlzvAgL7j397CQhDPt3c/lUH4Ijhj2NDwfWI=
X-Received: by 2002:a05:620a:14a2:: with SMTP id x2mr12330612qkj.36.1576220293691;
 Thu, 12 Dec 2019 22:58:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576193131.git.rdna@fb.com> <364944f93a1d77eab769eeba79bb74122a688338.1576193131.git.rdna@fb.com>
In-Reply-To: <364944f93a1d77eab769eeba79bb74122a688338.1576193131.git.rdna@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 12 Dec 2019 22:58:02 -0800
Message-ID: <CAEf4BzavGP6Aug4Jeg_MsxtgKyVDMGH6omoyMK=BvaAeW1QP3Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 5/6] libbpf: Introduce bpf_prog_attach_xattr
To:     Andrey Ignatov <rdna@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 12, 2019 at 3:34 PM Andrey Ignatov <rdna@fb.com> wrote:
>
> Introduce a new bpf_prog_attach_xattr function that accepts an
> extendable struct bpf_prog_attach_opts and supports passing a new
> attribute to BPF_PROG_ATTACH command: replace_prog_fd that is fd of
> previously attached cgroup-bpf program to replace if recently introduced
> BPF_F_REPLACE flag is used.
>
> The new function is named to be consistent with other xattr-functions
> (bpf_prog_test_run_xattr, bpf_create_map_xattr, bpf_load_program_xattr).
>
> The struct bpf_prog_attach_opts is supposed to be used with
> DECLARE_LIBBPF_OPTS framework.
>
> The opts argument is used directly in bpf_prog_attach_xattr
> implementation since at the time of adding all fields already exist in
> the kernel. New fields, if added, will need to be used via OPTS_* macros
> from libbpf_internal.h.
>
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
> ---
>  tools/lib/bpf/bpf.c      | 21 +++++++++++++++++----
>  tools/lib/bpf/bpf.h      | 12 ++++++++++++
>  tools/lib/bpf/libbpf.map |  2 ++
>  3 files changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 98596e15390f..9f4e42abd185 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -466,14 +466,27 @@ int bpf_obj_get(const char *pathname)
>
>  int bpf_prog_attach(int prog_fd, int target_fd, enum bpf_attach_type type,
>                     unsigned int flags)
> +{
> +       DECLARE_LIBBPF_OPTS(bpf_prog_attach_opts, opts,
> +               .target_fd = target_fd,
> +               .prog_fd = prog_fd,
> +               .type = type,
> +               .flags = flags,
> +       );
> +
> +       return bpf_prog_attach_xattr(&opts);
> +}
> +
> +int bpf_prog_attach_xattr(const struct bpf_prog_attach_opts *opts)

When we discussed this whole OPTS idea, we agreed that specifying
mandatory arguments as is makes for better usability. All the optional
stuff then is moved into opts (and then extended indefinitely, because
all the newly added stuff has to be optional, at least for some subset
of arguments).

So if we were to follow those unofficial "guidelines",
bpf_prog_attach_xattr would be defined as:

int bpf_prog_attach_xattr(int prog_fd, int target_fd, enum bpf_attach_type type,
                          const struct bpf_prog_attach_opts *opts);

, where opts has flags and replace_bpf_fd right now.

Naming wise, it's quite departure from xattr approach, so I'd probably
would go with bpf_prog_attach_opts, but I won't insist.

WDYT?

>  {
>         union bpf_attr attr;
>
>         memset(&attr, 0, sizeof(attr));
> -       attr.target_fd     = target_fd;
> -       attr.attach_bpf_fd = prog_fd;
> -       attr.attach_type   = type;
> -       attr.attach_flags  = flags;
> +       attr.target_fd     = opts->target_fd;
> +       attr.attach_bpf_fd = opts->prog_fd;
> +       attr.attach_type   = opts->type;
> +       attr.attach_flags  = opts->flags;
> +       attr.replace_bpf_fd = opts->replace_prog_fd;
>
>         return sys_bpf(BPF_PROG_ATTACH, &attr, sizeof(attr));
>  }
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 5cfe6e0a1aef..5b5f9b374074 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -150,8 +150,20 @@ LIBBPF_API int bpf_map_get_next_key(int fd, const void *key, void *next_key);
>  LIBBPF_API int bpf_map_freeze(int fd);
>  LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
>  LIBBPF_API int bpf_obj_get(const char *pathname);
> +
> +struct bpf_prog_attach_opts {
> +       size_t sz; /* size of this struct for forward/backward compatibility */
> +       int target_fd;
> +       int prog_fd;
> +       enum bpf_attach_type type;
> +       unsigned int flags;
> +       int replace_prog_fd;
> +};
> +#define bpf_prog_attach_opts__last_field replace_prog_fd
> +
>  LIBBPF_API int bpf_prog_attach(int prog_fd, int attachable_fd,
>                                enum bpf_attach_type type, unsigned int flags);
> +LIBBPF_API int bpf_prog_attach_xattr(const struct bpf_prog_attach_opts *opts);
>  LIBBPF_API int bpf_prog_detach(int attachable_fd, enum bpf_attach_type type);
>  LIBBPF_API int bpf_prog_detach2(int prog_fd, int attachable_fd,
>                                 enum bpf_attach_type type);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 495df575f87f..42b065454031 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -210,4 +210,6 @@ LIBBPF_0.0.6 {
>  } LIBBPF_0.0.5;
>
>  LIBBPF_0.0.7 {
> +       global:
> +               bpf_prog_attach_xattr;
>  } LIBBPF_0.0.6;
> --
> 2.17.1
>
