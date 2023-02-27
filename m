Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6576A4D89
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 22:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjB0VsI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 16:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjB0VsH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 16:48:07 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F73EA5F1;
        Mon, 27 Feb 2023 13:48:06 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id cy6so31747774edb.5;
        Mon, 27 Feb 2023 13:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Cv/Lb4w9p6irhqIQaqxAsCMYZeCfxJpk48Sv40qvTo=;
        b=lrEfonxkVCowaFYhGRjDO++QWCQzREZWmVj6eIXXLt4h79AWFvvOvAA33lCsR4Jvvi
         +gxPKNkCl0Jkx1MLKtqDcItqij5c2no1iHZFb7E4LcA/csxXPxsj0R5Z92pc7RByjCxD
         5d8G+uM9fI0/Zd7wgRl/Ok6gFjHeOSLyGUeHurNj3Wz2ZaW4gbUAoiSrTinC4f82TwnD
         rlQed1MIqsWrBAizuhjo4ObgipOwk7Q09gvCWlxy2cjHtmOHcSHkWoFX0Ai+5WIt4gBD
         WShgME2mYwnOinQPkJ0gSjlNpYbRTcI+7eQZ9W/K8paalw3LbFyioW77c1ihyqAbNbJ6
         GyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Cv/Lb4w9p6irhqIQaqxAsCMYZeCfxJpk48Sv40qvTo=;
        b=ry9irub1g85zyIkjdK9HKUEefZkLMdK3oawsLSlEB3s8nhjk/kNLWw/NqcdEtfxb+L
         Mdujrc3M5Eofajg1nF/xgE6W9UD0mso9ZaNjHi+RidxGMhCDOu54yC/4qUSNZtjAsDck
         t3mA9Swywk9ZvKepwncAjjk9FFNqog8l2aTih0fqhfHtYqSyAVOzCkhoODDk2UP3WU4b
         RhabJjk8YvFrhNbBJuqQD4I715v5jbSsGSt9qzehRlEBKP7xvnda2DCjkDahkV3wM+RN
         Ae3f8FeUG8H/pbPtyBPnQWaucp6jPOf8TtrVZEDOvkOe/1WBWfZgqxdsDsCKap+e4bg8
         Z77g==
X-Gm-Message-State: AO0yUKU1c0VDGad1LIA3HNoakXIa6jOS2iJT8GNA1tNqj9CwzJE46+7w
        4/EFTBEnr95v+RUwJxjnc+H7FU5ofHAHwmkNlYE=
X-Google-Smtp-Source: AK7set+7KdkKK8FpV3GLIOG/Y7MzwgKAY01tbG4w3lqpC4hs9Nbw1hJoRtGbMJ8eXlsGy8t83akWVP46fEyi4LH1epM=
X-Received: by 2002:a17:906:720e:b0:8de:c6a6:5134 with SMTP id
 m14-20020a170906720e00b008dec6a65134mr70864ejk.15.1677534484602; Mon, 27 Feb
 2023 13:48:04 -0800 (PST)
MIME-Version: 1.0
References: <20230221025347.389047-1-imagedong@tencent.com> <20230221025347.389047-2-imagedong@tencent.com>
In-Reply-To: <20230221025347.389047-2-imagedong@tencent.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Feb 2023 13:47:52 -0800
Message-ID: <CAEf4BzY7piCAZ=QDunS-Nmdjojsk37T8Fp-XRfKoTtYcFmsyPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] libbpf: add support to set kprobe/uprobe
 attach mode
To:     menglong8.dong@gmail.com
Cc:     alan.maguire@oracle.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        benbjiang@tencent.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 20, 2023 at 6:54=E2=80=AFPM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> By default, libbpf will attach the kprobe/uprobe eBPF program in the
> latest mode that supported by kernel. In this patch, we add the support
> to let users manually attach kprobe/uprobe in legacy or perf mode.
>
> There are 3 mode that supported by the kernel to attach kprobe/uprobe:
>
>   LEGACY: create perf event in legacy way and don't use bpf_link
>   PERF: create perf event with perf_event_open() and don't use bpf_link
>   LINK: create perf event with perf_event_open() and use bpf_link
>
> Users now can manually choose the mode with
> bpf_program__attach_uprobe_opts()/bpf_program__attach_kprobe_opts().
>
> Link: https://lore.kernel.org/bpf/20230113093427.1666466-1-imagedong@tenc=
ent.com/
> Reviewed-by: Biao Jiang <benbjiang@tencent.com>
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> ---
> v2:
> - rename no_link to force_ioctl_attach
> - rename probe_mode to probe_attach_mode
> - add more doc for probe_attach_mode
> - return -ENOTSUP when necessray in bpf_program__attach_uprobe_opts and
>   bpf_program__attach_kprobe_opts
> ---
>  tools/lib/bpf/libbpf.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>  tools/lib/bpf/libbpf.h | 31 ++++++++++++++++++++++++++++---
>  2 files changed, 69 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 05c4db355f28..d07a0d7b9edd 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9747,7 +9747,7 @@ struct bpf_link *bpf_program__attach_perf_event_opt=
s(const struct bpf_program *p
>         link->link.dealloc =3D &bpf_link_perf_dealloc;
>         link->perf_event_fd =3D pfd;
>
> -       if (kernel_supports(prog->obj, FEAT_PERF_LINK)) {
> +       if (kernel_supports(prog->obj, FEAT_PERF_LINK) && !opts->force_io=
ctl_attach) {

can't access ->force_ioctl_attach directly, please use OPTS_GET()
macro; it handles possibility of old user app passing smaller and
older version of opts struct

>                 DECLARE_LIBBPF_OPTS(bpf_link_create_opts, link_opts,
>                         .perf_event.bpf_cookie =3D OPTS_GET(opts, bpf_coo=
kie, 0));
>
> @@ -10106,6 +10106,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_=
program *prog,
>                                 const struct bpf_kprobe_opts *opts)
>  {
>         DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
> +       enum probe_attach_mode attach_mode;
>         char errmsg[STRERR_BUFSIZE];
>         char *legacy_probe =3D NULL;
>         struct bpf_link *link;
> @@ -10116,11 +10117,30 @@ bpf_program__attach_kprobe_opts(const struct bp=
f_program *prog,
>         if (!OPTS_VALID(opts, bpf_kprobe_opts))
>                 return libbpf_err_ptr(-EINVAL);
>
> +       attach_mode =3D OPTS_GET(opts, attach_mode, PROBE_ATTACH_MODE_DEF=
AULT);
>         retprobe =3D OPTS_GET(opts, retprobe, false);
>         offset =3D OPTS_GET(opts, offset, 0);
>         pe_opts.bpf_cookie =3D OPTS_GET(opts, bpf_cookie, 0);
>
>         legacy =3D determine_kprobe_perf_type() < 0;
> +       switch (attach_mode) {
> +       case PROBE_ATTACH_MODE_LEGACY:
> +               legacy =3D true;
> +               pe_opts.force_ioctl_attach =3D true;
> +               break;
> +       case PROBE_ATTACH_MODE_PERF:
> +               if (legacy)
> +                       return libbpf_err_ptr(-ENOTSUP);
> +               pe_opts.force_ioctl_attach =3D true;
> +               break;
> +       case PROBE_ATTACH_MODE_LINK:
> +               if (!kernel_supports(prog->obj, FEAT_PERF_LINK))

just to be on the safe side, let's also check that we are not in
legacy mode here?

> +                       return libbpf_err_ptr(-ENOTSUP);
> +               break;
> +       default:

let's add case PROBE_ATTACH_MODE_DEFAULT: break; explicitly, but for
all other unknown values error out

> +               break;
> +       }
> +
>         if (!legacy) {
>                 pfd =3D perf_event_open_probe(false /* uprobe */, retprob=
e,
>                                             func_name, offset,
> @@ -10774,6 +10794,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_=
program *prog, pid_t pid,
>  {
>         DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
>         char errmsg[STRERR_BUFSIZE], *legacy_probe =3D NULL;
> +       enum probe_attach_mode attach_mode;
>         char full_binary_path[PATH_MAX];
>         struct bpf_link *link;
>         size_t ref_ctr_off;
> @@ -10784,6 +10805,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_=
program *prog, pid_t pid,
>         if (!OPTS_VALID(opts, bpf_uprobe_opts))
>                 return libbpf_err_ptr(-EINVAL);
>
> +       attach_mode =3D OPTS_GET(opts, attach_mode, PROBE_ATTACH_MODE_DEF=
AULT);
>         retprobe =3D OPTS_GET(opts, retprobe, false);
>         ref_ctr_off =3D OPTS_GET(opts, ref_ctr_offset, 0);
>         pe_opts.bpf_cookie =3D OPTS_GET(opts, bpf_cookie, 0);
> @@ -10812,6 +10834,24 @@ bpf_program__attach_uprobe_opts(const struct bpf=
_program *prog, pid_t pid,
>         }
>
>         legacy =3D determine_uprobe_perf_type() < 0;
> +       switch (attach_mode) {
> +       case PROBE_ATTACH_MODE_LEGACY:
> +               legacy =3D true;
> +               pe_opts.force_ioctl_attach =3D true;
> +               break;
> +       case PROBE_ATTACH_MODE_PERF:
> +               if (legacy)
> +                       return libbpf_err_ptr(-ENOTSUP);
> +               pe_opts.force_ioctl_attach =3D true;
> +               break;
> +       case PROBE_ATTACH_MODE_LINK:
> +               if (!kernel_supports(prog->obj, FEAT_PERF_LINK))
> +                       return libbpf_err_ptr(-ENOTSUP);
> +               break;
> +       default:
> +               break;
> +       }

all the same points as above for kprobe_opts version

> +
>         if (!legacy) {
>                 pfd =3D perf_event_open_probe(true /* uprobe */, retprobe=
, binary_path,
>                                             func_offset, pid, ref_ctr_off=
);
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 2efd80f6f7b9..ef8f68da42f9 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -451,8 +451,11 @@ struct bpf_perf_event_opts {
>         size_t sz;
>         /* custom user-provided value fetchable through bpf_get_attach_co=
okie() */
>         __u64 bpf_cookie;
> +       /* don't use bpf_link when attach eBPF program */
> +       bool force_ioctl_attach;
> +       size_t :0;
>  };
> -#define bpf_perf_event_opts__last_field bpf_cookie
> +#define bpf_perf_event_opts__last_field force_ioctl_attach
>
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_perf_event(const struct bpf_program *prog, int pfd);
> @@ -461,6 +464,24 @@ LIBBPF_API struct bpf_link *
>  bpf_program__attach_perf_event_opts(const struct bpf_program *prog, int =
pfd,
>                                     const struct bpf_perf_event_opts *opt=
s);
>
> +
> +/**
> + * enum probe_attach_mode - the mode to attach kprobe/uprobe
> + *
> + * force libbpf to attach kprobe/uprobe in specific mode, -ENOTSUP will
> + * be returned if it is not supported by the kernel.
> + */
> +enum probe_attach_mode {
> +       /* attach probe in latest supported mode by kernel */
> +       PROBE_ATTACH_MODE_DEFAULT =3D 0,
> +       /* attach probe in legacy mode */

"in legacy mode, using debugfs/tracefs" ?

> +       PROBE_ATTACH_MODE_LEGACY,
> +       /* create perf event with perf_event_open() syscall */
> +       PROBE_ATTACH_MODE_PERF,
> +       /* attach probe with bpf_link */

nit: BPF link (it's a concept, not a struct name)

> +       PROBE_ATTACH_MODE_LINK,
> +};
> +
>  struct bpf_kprobe_opts {
>         /* size of this struct, for forward/backward compatiblity */
>         size_t sz;
> @@ -470,9 +491,11 @@ struct bpf_kprobe_opts {
>         size_t offset;
>         /* kprobe is return probe */
>         bool retprobe;
> +       /* kprobe attach mode */
> +       enum probe_attach_mode attach_mode;
>         size_t :0;
>  };
> -#define bpf_kprobe_opts__last_field retprobe
> +#define bpf_kprobe_opts__last_field attach_mode
>
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_kprobe(const struct bpf_program *prog, bool retprobe=
,
> @@ -570,9 +593,11 @@ struct bpf_uprobe_opts {
>          * binary_path.
>          */
>         const char *func_name;
> +       /* uprobe attach mode */
> +       enum probe_attach_mode attach_mode;
>         size_t :0;
>  };
> -#define bpf_uprobe_opts__last_field func_name
> +#define bpf_uprobe_opts__last_field attach_mode
>
>  /**
>   * @brief **bpf_program__attach_uprobe()** attaches a BPF program
> --
> 2.39.0
>
