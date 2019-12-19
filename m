Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56BBE125AE6
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 06:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfLSFuH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 00:50:07 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41184 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfLSFuH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Dec 2019 00:50:07 -0500
Received: by mail-qk1-f195.google.com with SMTP id x129so3694235qke.8
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 21:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cMc8aC7HzuZVioRjqR6o3KygIqAra8nMZPyY0R3yvVo=;
        b=MRlIKFrQy90yKT+jQtub+MokC6L6K0h0WHRckJNUIm65WrCpfnJh+WSB3pIgbNkHPZ
         wgf8d1QbBXzoBnVg66ESHfPr5eO0Adi1ORxNW+C4A6L8imnUdp1TRIfMi86ZDIh6BX4v
         YU7ZBkBxN6Zg6p14flEvpxvOQkaa8brEiS3KoYyj58qPI5FpBsn/NeFGR8ZsZdbFCImk
         AESo7DXosqsV1FUeTiA8/sTV7EL2NpBowyifx5yzwINVZcLNxDsrR15+/hPgXv0r1Vz5
         FTTcfoCd0ocWarmHydvd8g2n3yKclN8FLfXHpCQdE5ONh0tWbozPz03U4L68u/spo1oZ
         Io6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cMc8aC7HzuZVioRjqR6o3KygIqAra8nMZPyY0R3yvVo=;
        b=Gd6uVd7rSE6aY0YpepvWh03HgVvusqa5d7IjKIOFs2+yb3voV/zwaoNXXjXJr3BwJ+
         cAlQCsmBDpZUsCQinyfxTNTMSN+b29ItL06UO7XfDwEYJbOmNrkRUjdyZYScFMB1eav+
         0xARGt+FkGR4/pQVFSCUkdmrGeVVQfyqjnXddMoBlvNUJcnN62Z50iNVn1He36AlqIJF
         1g5MA5kudJGG3+0Fzdt44veztlcEq+kh/4b4khriY62FPSYO1B6UbxybGNMhdX2eJbFC
         cC4eWOLWy1xpCiop6kvrZqk0WgVS9ZqTnNgGD4BdnU7ZZkXIz2ijdo8Mbzp6tYa+4wQr
         SDFQ==
X-Gm-Message-State: APjAAAWxWHQAF8+TUeGhLeKe/iNarCu28fUqj1r6O6YQq4V+Voy53sZZ
        sjGgcOufpr+DvXDAa3vd7nElkK9CY0qjZ+CbOoA=
X-Google-Smtp-Source: APXvYqxY2S7ueqBXoPAOJLKcQgtVOgh6+mwybwCp5Oa+pOvEJfZThVtlJzhPY9hDwpebpzhqcn8HHlGFPuu2ZabVH3M=
X-Received: by 2002:ae9:e809:: with SMTP id a9mr6553637qkg.92.1576734606351;
 Wed, 18 Dec 2019 21:50:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576720240.git.rdna@fb.com> <a47ee7676254d3e94d3ff61afe20477eb8ace561.1576720240.git.rdna@fb.com>
In-Reply-To: <a47ee7676254d3e94d3ff61afe20477eb8ace561.1576720240.git.rdna@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 18 Dec 2019 21:49:55 -0800
Message-ID: <CAEf4BzZEmnmQm=JEVyq4G=DfAvZY3M9NK+gwkGgQmgTrhizNvw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 4/6] libbpf: Introduce bpf_prog_attach_xattr
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

On Wed, Dec 18, 2019 at 6:56 PM Andrey Ignatov <rdna@fb.com> wrote:
>
> Introduce a new bpf_prog_attach_xattr function that, in addition to
> program fd, target fd and attach type, accepts an extendable struct
> bpf_prog_attach_opts.
>
> bpf_prog_attach_opts relies on DECLARE_LIBBPF_OPTS macro to maintain
> backward and forward compatibility and has the following "optional"
> attach attributes:
>
> * existing attach_flags, since it's not required when attaching in NONE
>   mode. Even though it's quite often used in MULTI and OVERRIDE mode it
>   seems to be a good idea to reduce number of arguments to
>   bpf_prog_attach_xattr;
>
> * newly introduced attribute of BPF_PROG_ATTACH command: replace_prog_fd
>   that is fd of previously attached cgroup-bpf program to replace if
>   BPF_F_REPLACE flag is used.
>
> The new function is named to be consistent with other xattr-functions
> (bpf_prog_test_run_xattr, bpf_create_map_xattr, bpf_load_program_xattr).
>
> The struct bpf_prog_attach_opts is supposed to be used with
> DECLARE_LIBBPF_OPTS macro.
>
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
> ---
>  tools/lib/bpf/bpf.c      | 16 +++++++++++++++-
>  tools/lib/bpf/bpf.h      | 11 +++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 98596e15390f..ebb4f8d71bdb 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -466,6 +466,17 @@ int bpf_obj_get(const char *pathname)
>
>  int bpf_prog_attach(int prog_fd, int target_fd, enum bpf_attach_type type,
>                     unsigned int flags)
> +{
> +       DECLARE_LIBBPF_OPTS(bpf_prog_attach_opts, opts,
> +               .flags = flags,
> +       );
> +
> +       return bpf_prog_attach_xattr(prog_fd, target_fd, type, &opts);
> +}
> +
> +int bpf_prog_attach_xattr(int prog_fd, int target_fd,
> +                         enum bpf_attach_type type,
> +                         const struct bpf_prog_attach_opts *opts)
>  {
>         union bpf_attr attr;
>

You need to validate opts with OPTS_VALID macro (see
btf_dump__emit_type_decl() for simple example).

> @@ -473,7 +484,10 @@ int bpf_prog_attach(int prog_fd, int target_fd, enum bpf_attach_type type,
>         attr.target_fd     = target_fd;
>         attr.attach_bpf_fd = prog_fd;
>         attr.attach_type   = type;
> -       attr.attach_flags  = flags;
> +       if (opts) {
> +               attr.attach_flags = opts->flags;
> +               attr.replace_bpf_fd = opts->replace_prog_fd;
> +       }

Please use OPTS_GET() macro to fetch values from opts struct and
provide default value if they are not specified.


>
>         return sys_bpf(BPF_PROG_ATTACH, &attr, sizeof(attr));
>  }

[...]
