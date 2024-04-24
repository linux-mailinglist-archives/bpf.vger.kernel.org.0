Return-Path: <bpf+bounces-27602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B90EC8AFD4F
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 02:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449F21F22D97
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 00:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790F17EF;
	Wed, 24 Apr 2024 00:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaQ4Jn2v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E6D4C6D
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 00:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713918435; cv=none; b=m8W2PrHBaPnJivDpeTrkkYujUajkc4QFgPacwYqNxFoY9uCQCcP1rrL+aTySn+8dFQhybTBUi1m3U9H+3hJEMx4FBq3GDRRaPOJpNkpRnPcn8/lnWglNKDdyTPnwTcMxrNQf8eo0lS/OZf6W1ZebU56to72hZUbrgFrHwroa1K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713918435; c=relaxed/simple;
	bh=NUIVi2Tu5YDJ9BcHhiXvvg5RFdkvtkUGdOTrdvBwbjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l66/lnU2N8jKcHMOzBf6rjxyAFRK7vQQnfNZjG4XDBzQbltWWZ6LJAT4uFdd5puHUtT+QuW8J08yEZ/NXhGfoZWhdGotOZE/jrxs5yTkyPJUfvVCUs6NrB3xx0YVTwy5/fIyKULN9Ahz3BQWknL7koeWxOrprgcmkzFwLtHrh4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaQ4Jn2v; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d8b519e438so4910450a12.1
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 17:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713918433; x=1714523233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keGiDKL1HQP1jda3Bb52O5NxsazT1uJ59/a1+8k2rDw=;
        b=WaQ4Jn2vKKbg0CEbXs/xfQ4jmopAuIy2XJW5COzkGLB/e727jo5z9pbeuj2UJNdLh6
         BV5mhESmeNcjwPPpKFvYfgrQCsd8vvRn43slRY1mcPSnN6apE5B4NGZkYKYai1WIMA18
         mUjZsqYLzjoA/VfyzRcD9a+OXCLGWHshW+6hb0dZZ/+QaXs7w0WextLJGc6e1fx5M388
         WoTlNhlcy+LMBYA4Mp3GCY3bRTEkK/z39TGND2FFL49a5dfgpZ06HOILCl1GkDY8fm6W
         e436yBSxeSCw9tes2vaxkYFAOaSy834AxehOO2vd42EUypA9YVs7qEn6+rOLOhnx10kC
         +1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713918433; x=1714523233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=keGiDKL1HQP1jda3Bb52O5NxsazT1uJ59/a1+8k2rDw=;
        b=NcRp946forqQCp4wfTAJKWF2Q9MQRS4BOJ6Lrgwm/NJGzRTeTDMG9LtX8aWMZ+Hxce
         lSDdMH+91KGB/HTg6fPS5P1HtqnJyZzpraYSLDJdXlIgtgVlICcKjl8F9BQd8qKx3oUi
         RdAI/3NoWaTQHHnze36Jl0t938i82J0YMrwEm46PhOJPMkGRJI4Yz39+TbVM2CM/flab
         NJOXhlWFqUi7y0phOTXgdSKlgcOhbh3V7HsET4TgpWlGoDaqW64W4+Jzi3pC9+AtoYxX
         G6M8d/vDTITgqQs9pEQ+KBiGDF/Imq8T64TWMNZSzYTLf3XLQFWFaw/KpdUX4pLevNQj
         OQrA==
X-Forwarded-Encrypted: i=1; AJvYcCX4kFdh9bFkfSj9dySpO7Ht7dyuJqgVDIAZnPdwy67cwJzkXaZO8BBqsYsIxcgNxp4KfCRHSvNpYucx2U2NR/ffDXCj
X-Gm-Message-State: AOJu0Yxc/y8UBQ3459jMTM2yse5kxID4yqg6QYOgSVA01jR9fBODjjQL
	PTF8FzXuSlN2LS14DZkxdf4W0m/Bhwb91QHNw2+fyMLFpUuLsBj3abLP94ISEDVPrFuPVuPFn6N
	ZFytZ2NNlugoMf66rz67YCHTqYeY=
X-Google-Smtp-Source: AGHT+IEt+6udKY9sHvs7QKtRq48wClN7Tu8FNlVD71w1bjBsX+0CkKWtWucxe/ba4qb0Lgw5/a0s6F3qEH7TxphT3uE=
X-Received: by 2002:a17:902:e84f:b0:1e2:a162:6f7a with SMTP id
 t15-20020a170902e84f00b001e2a1626f7amr1298871plg.43.1713918432867; Tue, 23
 Apr 2024 17:27:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422121241.1307168-1-jolsa@kernel.org> <20240422121241.1307168-5-jolsa@kernel.org>
In-Reply-To: <20240422121241.1307168-5-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Apr 2024 17:26:59 -0700
Message-ID: <CAEf4BzZEwjGndOZWe8aLD3Atzde2M5gqnwbh28HZsXrSTS9gvA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/7] libbpf: Add support for kprobe multi session attach
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Viktor Malik <vmalik@redhat.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 5:13=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to attach program in kprobe multi session mode
> with bpf_program__attach_kprobe_multi_opts function.
>
> Adding session bool to bpf_kprobe_multi_opts struct that allows
> to load and attach the bpf program via kprobe multi session.
> the attachment to create kprobe multi session.
>
> Also adding new program loader section that allows:
>  SEC("kprobe.session/bpf_fentry_test*")
>
> and loads/attaches kprobe program as kprobe multi session.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/bpf.c    |  1 +
>  tools/lib/bpf/libbpf.c | 40 ++++++++++++++++++++++++++++++++++++++--
>  tools/lib/bpf/libbpf.h |  4 +++-
>  3 files changed, 42 insertions(+), 3 deletions(-)
>

Minor nits below, but LGTM overall:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index c9f4e04f38fe..5f556e38910f 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -766,6 +766,7 @@ int bpf_link_create(int prog_fd, int target_fd,
>                         return libbpf_err(-EINVAL);
>                 break;
>         case BPF_TRACE_KPROBE_MULTI:
> +       case BPF_TRACE_KPROBE_MULTI_SESSION:
>                 attr.link_create.kprobe_multi.flags =3D OPTS_GET(opts, kp=
robe_multi.flags, 0);
>                 attr.link_create.kprobe_multi.cnt =3D OPTS_GET(opts, kpro=
be_multi.cnt, 0);
>                 attr.link_create.kprobe_multi.syms =3D ptr_to_u64(OPTS_GE=
T(opts, kprobe_multi.syms, 0));
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 97eb6e5dd7c8..ca605240205f 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9272,6 +9272,7 @@ static int attach_tp(const struct bpf_program *prog=
, long cookie, struct bpf_lin
>  static int attach_raw_tp(const struct bpf_program *prog, long cookie, st=
ruct bpf_link **link);
>  static int attach_trace(const struct bpf_program *prog, long cookie, str=
uct bpf_link **link);
>  static int attach_kprobe_multi(const struct bpf_program *prog, long cook=
ie, struct bpf_link **link);
> +static int attach_kprobe_session(const struct bpf_program *prog, long co=
okie, struct bpf_link **link);
>  static int attach_uprobe_multi(const struct bpf_program *prog, long cook=
ie, struct bpf_link **link);
>  static int attach_lsm(const struct bpf_program *prog, long cookie, struc=
t bpf_link **link);
>  static int attach_iter(const struct bpf_program *prog, long cookie, stru=
ct bpf_link **link);
> @@ -9288,6 +9289,7 @@ static const struct bpf_sec_def section_defs[] =3D =
{
>         SEC_DEF("uretprobe.s+",         KPROBE, 0, SEC_SLEEPABLE, attach_=
uprobe),
>         SEC_DEF("kprobe.multi+",        KPROBE, BPF_TRACE_KPROBE_MULTI, S=
EC_NONE, attach_kprobe_multi),
>         SEC_DEF("kretprobe.multi+",     KPROBE, BPF_TRACE_KPROBE_MULTI, S=
EC_NONE, attach_kprobe_multi),
> +       SEC_DEF("kprobe.session+",      KPROBE, BPF_TRACE_KPROBE_MULTI_SE=
SSION, SEC_NONE, attach_kprobe_session),
>         SEC_DEF("uprobe.multi+",        KPROBE, BPF_TRACE_UPROBE_MULTI, S=
EC_NONE, attach_uprobe_multi),
>         SEC_DEF("uretprobe.multi+",     KPROBE, BPF_TRACE_UPROBE_MULTI, S=
EC_NONE, attach_uprobe_multi),
>         SEC_DEF("uprobe.multi.s+",      KPROBE, BPF_TRACE_UPROBE_MULTI, S=
EC_SLEEPABLE, attach_uprobe_multi),
> @@ -11380,13 +11382,14 @@ bpf_program__attach_kprobe_multi_opts(const str=
uct bpf_program *prog,
>         struct kprobe_multi_resolve res =3D {
>                 .pattern =3D pattern,
>         };
> +       enum bpf_attach_type attach_type;
>         struct bpf_link *link =3D NULL;
>         char errmsg[STRERR_BUFSIZE];
>         const unsigned long *addrs;
>         int err, link_fd, prog_fd;
> +       bool retprobe, session;
>         const __u64 *cookies;
>         const char **syms;
> -       bool retprobe;
>         size_t cnt;
>
>         if (!OPTS_VALID(opts, bpf_kprobe_multi_opts))
> @@ -11425,6 +11428,13 @@ bpf_program__attach_kprobe_multi_opts(const stru=
ct bpf_program *prog,
>         }
>
>         retprobe =3D OPTS_GET(opts, retprobe, false);
> +       session  =3D OPTS_GET(opts, session, false);
> +
> +       if (retprobe && session)
> +               return libbpf_err_ptr(-EINVAL);
> +
> +       attach_type =3D session ? BPF_TRACE_KPROBE_MULTI_SESSION :
> +                               BPF_TRACE_KPROBE_MULTI;

doesn't fit under 100?

>
>         lopts.kprobe_multi.syms =3D syms;
>         lopts.kprobe_multi.addrs =3D addrs;
> @@ -11439,7 +11449,7 @@ bpf_program__attach_kprobe_multi_opts(const struc=
t bpf_program *prog,
>         }
>         link->detach =3D &bpf_link__detach_fd;
>
> -       link_fd =3D bpf_link_create(prog_fd, 0, BPF_TRACE_KPROBE_MULTI, &=
lopts);
> +       link_fd =3D bpf_link_create(prog_fd, 0, attach_type, &lopts);
>         if (link_fd < 0) {
>                 err =3D -errno;
>                 pr_warn("prog '%s': failed to attach: %s\n",
> @@ -11545,6 +11555,32 @@ static int attach_kprobe_multi(const struct bpf_=
program *prog, long cookie, stru
>         return libbpf_get_error(*link);
>  }
>
> +static int attach_kprobe_session(const struct bpf_program *prog, long co=
okie,
> +                                struct bpf_link **link)
> +{
> +       LIBBPF_OPTS(bpf_kprobe_multi_opts, opts, .session =3D true);
> +       const char *spec;
> +       char *pattern;
> +       int n;
> +
> +       *link =3D NULL;
> +
> +       /* no auto-attach for SEC("kprobe.session") */
> +       if (strcmp(prog->sec_name, "kprobe.session") =3D=3D 0)
> +               return 0;
> +
> +       spec =3D prog->sec_name + sizeof("kprobe.session/") - 1;
> +       n =3D sscanf(spec, "%m[a-zA-Z0-9_.*?]", &pattern);
> +       if (n < 1) {
> +               pr_warn("kprobe session pattern is invalid: %s\n", patter=
n);
> +               return -EINVAL;
> +       }
> +
> +       *link =3D bpf_program__attach_kprobe_multi_opts(prog, pattern, &o=
pts);
> +       free(pattern);
> +       return libbpf_get_error(*link);

let's try not to add new uses of libbpf_get_error? Would this work:

return *link ? 0 : -errno;

?


> +}
> +
>  static int attach_uprobe_multi(const struct bpf_program *prog, long cook=
ie, struct bpf_link **link)
>  {
>         char *probe_type =3D NULL, *binary_path =3D NULL, *func_name =3D =
NULL;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 1333ae20ebe6..c3f77d9260fe 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -539,10 +539,12 @@ struct bpf_kprobe_multi_opts {
>         size_t cnt;
>         /* create return kprobes */
>         bool retprobe;
> +       /* create session kprobes */
> +       bool session;
>         size_t :0;
>  };
>
> -#define bpf_kprobe_multi_opts__last_field retprobe
> +#define bpf_kprobe_multi_opts__last_field session
>
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
> --
> 2.44.0
>

