Return-Path: <bpf+bounces-22989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E904786BE37
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 02:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1908D1C20FD2
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 01:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EBD2D046;
	Thu, 29 Feb 2024 01:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMw9j/o/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28740168B8
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 01:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709169853; cv=none; b=R0HdKw3TXAzEhuFmU1ZLm97bPS/bU36St9AUVRIMc19ZfFxDmm2ms24hDB0kEU5jHGDmOLY7HFDXxB25rY6FACm58ilyxDemaVLexWBIBajC1ntgJPCtGQin242cdeepcI76H7s4+eKhSZDqr+YTwZmJcwBxSvPRh2mI7fI8aRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709169853; c=relaxed/simple;
	bh=GFvjPK9yAYx8j1WixN8y9zOoIOn2PPc4nWg/LuIuCgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGHeRx8h8Zv5MZ6IN7/EuwvTIyEcQ/mc1uk/hoxE6/lEgWrEfWzk+9VYMbLANIkqfgdGogBi51ZeYbXe8zehbxAjVCKtExn8g1toHFG0lBIl3tzf0xcwqFJ5r0mWgbUoEfrr/N2uBygbw+yS8cdA7NMFBU21tFtzEhxIc4VsNVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMw9j/o/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dcd6a3da83so2082115ad.3
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 17:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709169851; x=1709774651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svlUR5w/GD84bR3sTkZ3pcpq71mvhRbpKo14jk4378k=;
        b=FMw9j/o/9wHEs2iw7/rkd5Dvqaoz/E+CzdGGSk/yZ0yXF7IMQJhPoKry8oG6CqB/Tb
         4I5Kf+fzy9kcHJ+kqW9aLx7IhyVVScH4/b7ZK+c8+8ooO3TwM2igG6MUM0mgssMLgTW/
         fuh4OEKTTv1bhZwZU7XgkH0gK0CeNcD7R1wVeJixw8oWrB/cbRiLokXmT2IQHpDx3m2k
         w4J75zS+RJAFIkdxYEE8p2pcvGg/xkkNWzpC8uMF4qK9JABhP6M1ukCycdb045bnZc9u
         INfrjPf0Whp5e67so0YuAAjyl4DMgA7FfSdNfxm78yZjVcLBcE6tRszqGModQxBylScF
         tUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709169851; x=1709774651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svlUR5w/GD84bR3sTkZ3pcpq71mvhRbpKo14jk4378k=;
        b=gNPpLYdfEFMjNOhTx2mQR8Os7DCJVLsrtOEEkie1hIxJmZY1QcdxcvasoqeU42GSaE
         c+TJX2+JrJ/STIRlZVcfk4S83dhaYQzOLAeXQitY+2vvdIHUF0ODtn8pBnQtgVziH5wg
         +LCsCN+QRqghyv8NsquibpDi7dDS/s/o6ZPlQu13Pnq9UnkmCZ/s+uINVwL6+qxamRQR
         MEYR/cYkZKd1swihlRMcekZjZqGPCvVxBhcaUR85sXV5MFhzm24Q4QA+C5zbOFbFPNjM
         XAE+rv+1hfRr5L8P+SK1l8sUTpeV5is9pv0jTXHr4UdUrq0HXz2rSsxdjzQaRGVm0cNL
         Gmcg==
X-Forwarded-Encrypted: i=1; AJvYcCXdsORGGsWp0liV724Q9qBbX/GjcOeXiJv8FvkiVDAdqnx1CH42hSYmiIeN9uA9tmJL1rU9WZlOYqGMMASqGDEmSR7E
X-Gm-Message-State: AOJu0YybU6YrjSQwjlPrnkeNrR5nb2NSVEBGjwv3fNRUlXffQDUihdIg
	bvYE7yqEPyr9NWC50smMeUhNy6hhIIt4Mio1qL8zXbftoIHQv528yXtg+KJnK8u9MTojBETZ1er
	ULwcEu5DbNHD231icNP2bKu2VwFc=
X-Google-Smtp-Source: AGHT+IFqRik1te8vEpAPtN+rNjqYvRSbofDrUbUbkJH3uIGwFPNISEJmV6chpp9KUGJtbHp9BUX9QSZUw/yXMuANgZg=
X-Received: by 2002:a17:903:2444:b0:1db:7181:c5ba with SMTP id
 l4-20020a170903244400b001db7181c5bamr779295pls.62.1709169851458; Wed, 28 Feb
 2024 17:24:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228090242.4040210-1-jolsa@kernel.org> <20240228090242.4040210-4-jolsa@kernel.org>
In-Reply-To: <20240228090242.4040210-4-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Feb 2024 17:23:57 -0800
Message-ID: <CAEf4Bzb28J0i_Xud+ZnBHM+urOf9T8HYp++JJghQKT3xfsfLcw@mail.gmail.com>
Subject: Re: [PATCH RFCv2 bpf-next 3/4] libbpf: Add support for kprobe multi
 wrapper attach
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Viktor Malik <vmalik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 1:03=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support for specify wrapper mode in bpf_kprobe_multi_opts
> struct object and new bpf program loader section:
>
>  SEC("kprobe.wrapper/bpf_fentry_test*")
>
> to load program as kprobe multi wrapper.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 38 +++++++++++++++++++++++++++++++++++---
>  tools/lib/bpf/libbpf.h |  4 +++-
>  2 files changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 01f407591a92..5416d784c857 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8944,6 +8944,7 @@ static int attach_tp(const struct bpf_program *prog=
, long cookie, struct bpf_lin
>  static int attach_raw_tp(const struct bpf_program *prog, long cookie, st=
ruct bpf_link **link);
>  static int attach_trace(const struct bpf_program *prog, long cookie, str=
uct bpf_link **link);
>  static int attach_kprobe_multi(const struct bpf_program *prog, long cook=
ie, struct bpf_link **link);
> +static int attach_kprobe_wrapper(const struct bpf_program *prog, long co=
okie, struct bpf_link **link);
>  static int attach_uprobe_multi(const struct bpf_program *prog, long cook=
ie, struct bpf_link **link);
>  static int attach_lsm(const struct bpf_program *prog, long cookie, struc=
t bpf_link **link);
>  static int attach_iter(const struct bpf_program *prog, long cookie, stru=
ct bpf_link **link);
> @@ -8960,6 +8961,7 @@ static const struct bpf_sec_def section_defs[] =3D =
{
>         SEC_DEF("uretprobe.s+",         KPROBE, 0, SEC_SLEEPABLE, attach_=
uprobe),
>         SEC_DEF("kprobe.multi+",        KPROBE, BPF_TRACE_KPROBE_MULTI, S=
EC_NONE, attach_kprobe_multi),
>         SEC_DEF("kretprobe.multi+",     KPROBE, BPF_TRACE_KPROBE_MULTI, S=
EC_NONE, attach_kprobe_multi),
> +       SEC_DEF("kprobe.wrapper+",      KPROBE, BPF_TRACE_KPROBE_MULTI, S=
EC_NONE, attach_kprobe_wrapper),
>         SEC_DEF("uprobe.multi+",        KPROBE, BPF_TRACE_UPROBE_MULTI, S=
EC_NONE, attach_uprobe_multi),
>         SEC_DEF("uretprobe.multi+",     KPROBE, BPF_TRACE_UPROBE_MULTI, S=
EC_NONE, attach_uprobe_multi),
>         SEC_DEF("uprobe.multi.s+",      KPROBE, BPF_TRACE_UPROBE_MULTI, S=
EC_SLEEPABLE, attach_uprobe_multi),
> @@ -11034,7 +11036,7 @@ bpf_program__attach_kprobe_multi_opts(const struc=
t bpf_program *prog,
>         int err, link_fd, prog_fd;
>         const __u64 *cookies;
>         const char **syms;
> -       bool retprobe;
> +       __u32 flags =3D 0;
>         size_t cnt;
>
>         if (!OPTS_VALID(opts, bpf_kprobe_multi_opts))
> @@ -11065,13 +11067,16 @@ bpf_program__attach_kprobe_multi_opts(const str=
uct bpf_program *prog,
>                 cnt =3D res.cnt;
>         }
>
> -       retprobe =3D OPTS_GET(opts, retprobe, false);
> +       if (OPTS_GET(opts, retprobe, false))
> +               flags |=3D BPF_F_KPROBE_MULTI_RETURN;
> +       if (OPTS_GET(opts, wrapper, false))
> +               flags |=3D BPF_F_KPROBE_MULTI_WRAPPER;

probably error out if both retprobe and wrapper are set?

>
>         lopts.kprobe_multi.syms =3D syms;
>         lopts.kprobe_multi.addrs =3D addrs;
>         lopts.kprobe_multi.cookies =3D cookies;
>         lopts.kprobe_multi.cnt =3D cnt;
> -       lopts.kprobe_multi.flags =3D retprobe ? BPF_F_KPROBE_MULTI_RETURN=
 : 0;
> +       lopts.kprobe_multi.flags =3D flags;
>
>         link =3D calloc(1, sizeof(*link));
>         if (!link) {
> @@ -11187,6 +11192,33 @@ static int attach_kprobe_multi(const struct bpf_=
program *prog, long cookie, stru
>         return libbpf_get_error(*link);
>  }
>
> +static int attach_kprobe_wrapper(const struct bpf_program *prog, long co=
okie, struct bpf_link **link)
> +{
> +       LIBBPF_OPTS(bpf_kprobe_multi_opts, opts,
> +               .wrapper =3D true,
> +       );

nit: keep on a single line?

> +       const char *spec;
> +       char *pattern;
> +       int n;
> +
> +       *link =3D NULL;
> +
> +       /* no auto-attach for SEC("kprobe.wrapper") */
> +       if (strcmp(prog->sec_name, "kprobe.wrapper") =3D=3D 0)
> +               return 0;
> +
> +       spec =3D prog->sec_name + sizeof("kprobe.wrapper/") - 1;
> +       n =3D sscanf(spec, "%m[a-zA-Z0-9_.*?]", &pattern);
> +       if (n < 1) {
> +               pr_warn("kprobe wrapper pattern is invalid: %s\n", patter=
n);
> +               return -EINVAL;
> +       }
> +
> +       *link =3D bpf_program__attach_kprobe_multi_opts(prog, pattern, &o=
pts);
> +       free(pattern);

is it guaranteed that free() won't clobber errno? or should we record
it right after attach call (and stop using libbpf_get_error())?


> +       return libbpf_get_error(*link);
> +}
> +
>  static int attach_uprobe_multi(const struct bpf_program *prog, long cook=
ie, struct bpf_link **link)
>  {
>         char *probe_type =3D NULL, *binary_path =3D NULL, *func_name =3D =
NULL;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 5723cbbfcc41..72f4e3ad295f 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -539,10 +539,12 @@ struct bpf_kprobe_multi_opts {
>         size_t cnt;
>         /* create return kprobes */
>         bool retprobe;
> +       /* create wrapper kprobes */
> +       bool wrapper;
>         size_t :0;
>  };
>
> -#define bpf_kprobe_multi_opts__last_field retprobe
> +#define bpf_kprobe_multi_opts__last_field wrapper
>
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
> --
> 2.43.2
>

