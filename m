Return-Path: <bpf+bounces-44926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B23E9CD60C
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 05:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556F9282C47
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 04:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE203170A23;
	Fri, 15 Nov 2024 04:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g41F7QQG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C697C169397;
	Fri, 15 Nov 2024 04:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731643204; cv=none; b=AFKD3jjXMspymYN7yqq4UIpTOaPo//rTKuAO/pAwS5SJy0wyywxjm54U0uMDrzb+D0naabehG2T0q8xmmqzNY639i3svo6A36IyWw1x8GClt13MHYBQkGEoFy5B1jkYLyXkcQac6+Pkmi8UK4t5QoXDxG/lCV0uM5ufZ9ywOHd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731643204; c=relaxed/simple;
	bh=eAi4DbmyHLXBDLzm1hsvossAoSttqcFoLkQWKY5fonE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ov+fqUVnf6UuvgNbOwPUPd3eD3l1uzX39Bzk1UPeZfSyV8Pgm/pPrYiNrTTvbffvkPDihaJZxpb8404e0L12lPAb6fSptfE8HpNBAFHtwZ5veZBp4mwD/bZOHBYx0xZ/Viqr5/U6hPM/sjLPAHPeBZjMkD0cw9IgqXAmj41/1q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g41F7QQG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cd76c513cso12486275ad.3;
        Thu, 14 Nov 2024 20:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731643202; x=1732248002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LnvZ3hqmBnYkSAC5XVtuDGDYx0CeZ7Njswdlq+6/Ow=;
        b=g41F7QQGCtFLTtbsWfvtvZt6ACI0vxQcmodOPhq/IkeW5yKylyo1jxhExyF3o95W0Q
         +c8PnyyNVWkF3UzYiHPxtyZOUFhR6WM/PyyVIYq0Sp/dcSX0ph4wtmPZy+ZGPQH8INmy
         pxE6yJw6MU0BpNdpOCYu2WFLasJ/3CX8lYcLD4NEMxsJj23i1cW3q3L5NuHp+/F4Lgvk
         Uz8+J97mCjd1/zEOYoDw7L9WA4IuJRG57xq6AYAvZEpjB6FyPMMxUafa465zMuumui2L
         qk8Id6PFXfZu9aYWRo3otOhRx6KTNvO46noRn2jYD6Cqx9sPrZu7/eU3vZbXfIJiS/l4
         OATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731643202; x=1732248002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LnvZ3hqmBnYkSAC5XVtuDGDYx0CeZ7Njswdlq+6/Ow=;
        b=Gcx7gjctdTcibCJariEKW4w5l9z74P2F/O2+m5a3pm1W2iH6Cy1A+zNLv0x8FFlGp3
         iUeT/WBHpE784BAs90URrDX/kXkfro/37nEngDqCTwnchKl03eEeFD3XNdhQqYg7peKT
         srgTq2vDcoHRaBDirgG452feo7M9Nw6eTHQcVcnLQyAuB2p6LQsLu3mbarnFj7RTA2DO
         VPdKxAr7hpYlw8GuI733pHSRDmOMiOagERhhbBA6oec13nOSo5073rZBisk29zxmMI1r
         k7e92NmRgpdE8JE3v/JcxLBSly/185b+3Io+OZh9giDHXFjxz5QsHaLCyJ/ckIKsJsSh
         gXFA==
X-Forwarded-Encrypted: i=1; AJvYcCU+FwlcRZfCf6ndQ4BW+1xa+3ASPrVuDvxb+C4MAZTdZnfcKRQTrozC1EQHaENn0bw6vD4XoEmymLIMz5SxJqgubn+x@vger.kernel.org, AJvYcCV/f4YCpW31KKQfr2HesnRnerSHn6zkP7T0t+CPTvlHIHTV89Fx5ccO3U2QRFobXCTOxZ/ZbH9uv2fd/9Yl@vger.kernel.org, AJvYcCXjWyLid8h8pKciL0BFUrCw6Wrqx914WMFrZneigjZxUPVDuf2ZIlr4ilPTsnyA32xJ33g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz+OgBIr2HA5PTe/ejYuI21Ws2mxbqMH8TgiREguWQuH8C9szv
	H9Cy0Rkd44LO8eCMXVs9O95PKYx/S37D2G9+OEfZ6+1dbn0uhDiqFBCk/XJVcXWi7rCa6aL2wLB
	Tzznz8oOSRun9ndxE7CHpJfRMbng=
X-Google-Smtp-Source: AGHT+IHLzKtlKS/utCgfTs0OwsyWhroUFytvxxF04xTgdGIe1uuEozLjXAPaHGgXIvYAZ7R/crrh40L3H07Zi1DdRxQ=
X-Received: by 2002:a05:6a21:6d9e:b0:1db:db2f:f3a5 with SMTP id
 adf61e73a8af0-1dc90b4dd10mr1400538637.21.1731643202009; Thu, 14 Nov 2024
 20:00:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108134544.480660-1-jolsa@kernel.org> <20241108134544.480660-6-jolsa@kernel.org>
In-Reply-To: <20241108134544.480660-6-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Nov 2024 19:59:50 -0800
Message-ID: <CAEf4BzZS4BJj1b-Fa6v9=0sRyXncmtGN_R0oymOF24bheE7Shg@mail.gmail.com>
Subject: Re: [PATCHv9 bpf-next 05/13] libbpf: Add support for uprobe multi
 session attach
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 5:47=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to attach program in uprobe session mode
> with bpf_program__attach_uprobe_multi function.
>
> Adding session bool to bpf_uprobe_multi_opts struct that allows
> to load and attach the bpf program via uprobe session.
> the attachment to create uprobe multi session.
>
> Also adding new program loader section that allows:
>   SEC("uprobe.session/bpf_fentry_test*")
>
> and loads/attaches uprobe program as uprobe session.
>
> Adding sleepable hook (uprobe.session.s) as well.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/bpf.c    |  1 +
>  tools/lib/bpf/libbpf.c | 18 ++++++++++++++++--
>  tools/lib/bpf/libbpf.h |  4 +++-
>  3 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 2a4c71501a17..becdfa701c75 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -776,6 +776,7 @@ int bpf_link_create(int prog_fd, int target_fd,
>                         return libbpf_err(-EINVAL);
>                 break;
>         case BPF_TRACE_UPROBE_MULTI:
> +       case BPF_TRACE_UPROBE_SESSION:
>                 attr.link_create.uprobe_multi.flags =3D OPTS_GET(opts, up=
robe_multi.flags, 0);
>                 attr.link_create.uprobe_multi.cnt =3D OPTS_GET(opts, upro=
be_multi.cnt, 0);
>                 attr.link_create.uprobe_multi.path =3D ptr_to_u64(OPTS_GE=
T(opts, uprobe_multi.path, 0));
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index faac1c79840d..a2bc5bea7ea3 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9442,8 +9442,10 @@ static const struct bpf_sec_def section_defs[] =3D=
 {
>         SEC_DEF("kprobe.session+",      KPROBE, BPF_TRACE_KPROBE_SESSION,=
 SEC_NONE, attach_kprobe_session),
>         SEC_DEF("uprobe.multi+",        KPROBE, BPF_TRACE_UPROBE_MULTI, S=
EC_NONE, attach_uprobe_multi),
>         SEC_DEF("uretprobe.multi+",     KPROBE, BPF_TRACE_UPROBE_MULTI, S=
EC_NONE, attach_uprobe_multi),
> +       SEC_DEF("uprobe.session+",      KPROBE, BPF_TRACE_UPROBE_SESSION,=
 SEC_NONE, attach_uprobe_multi),
>         SEC_DEF("uprobe.multi.s+",      KPROBE, BPF_TRACE_UPROBE_MULTI, S=
EC_SLEEPABLE, attach_uprobe_multi),
>         SEC_DEF("uretprobe.multi.s+",   KPROBE, BPF_TRACE_UPROBE_MULTI, S=
EC_SLEEPABLE, attach_uprobe_multi),
> +       SEC_DEF("uprobe.session.s+",    KPROBE, BPF_TRACE_UPROBE_SESSION,=
 SEC_SLEEPABLE, attach_uprobe_multi),
>         SEC_DEF("ksyscall+",            KPROBE, 0, SEC_NONE, attach_ksysc=
all),
>         SEC_DEF("kretsyscall+",         KPROBE, 0, SEC_NONE, attach_ksysc=
all),
>         SEC_DEF("usdt+",                KPROBE, 0, SEC_USDT, attach_usdt)=
,
> @@ -11765,7 +11767,9 @@ static int attach_uprobe_multi(const struct bpf_p=
rogram *prog, long cookie, stru
>                 ret =3D 0;
>                 break;
>         case 3:
> +               opts.session =3D str_has_pfx(probe_type, "uprobe.session"=
);
>                 opts.retprobe =3D str_has_pfx(probe_type, "uretprobe.mult=
i");
> +
>                 *link =3D bpf_program__attach_uprobe_multi(prog, -1, bina=
ry_path, func_name, &opts);
>                 ret =3D libbpf_get_error(*link);
>                 break;
> @@ -12014,10 +12018,12 @@ bpf_program__attach_uprobe_multi(const struct b=
pf_program *prog,
>         const unsigned long *ref_ctr_offsets =3D NULL, *offsets =3D NULL;
>         LIBBPF_OPTS(bpf_link_create_opts, lopts);
>         unsigned long *resolved_offsets =3D NULL;
> +       enum bpf_attach_type attach_type;
>         int err =3D 0, link_fd, prog_fd;
>         struct bpf_link *link =3D NULL;
>         char errmsg[STRERR_BUFSIZE];
>         char full_path[PATH_MAX];
> +       bool retprobe, session;
>         const __u64 *cookies;
>         const char **syms;
>         size_t cnt;
> @@ -12088,12 +12094,20 @@ bpf_program__attach_uprobe_multi(const struct b=
pf_program *prog,
>                 offsets =3D resolved_offsets;
>         }
>
> +       retprobe =3D OPTS_GET(opts, retprobe, false);
> +       session  =3D OPTS_GET(opts, session, false);
> +
> +       if (retprobe && session)
> +               return libbpf_err_ptr(-EINVAL);

Hey Jiri,

Coverity says that we are leaking offsets (resolved_offsets) here.
Please send a fix, thanks.

> +
> +       attach_type =3D session ? BPF_TRACE_UPROBE_SESSION : BPF_TRACE_UP=
ROBE_MULTI;
> +
>         lopts.uprobe_multi.path =3D path;
>         lopts.uprobe_multi.offsets =3D offsets;
>         lopts.uprobe_multi.ref_ctr_offsets =3D ref_ctr_offsets;
>         lopts.uprobe_multi.cookies =3D cookies;
>         lopts.uprobe_multi.cnt =3D cnt;
> -       lopts.uprobe_multi.flags =3D OPTS_GET(opts, retprobe, false) ? BP=
F_F_UPROBE_MULTI_RETURN : 0;
> +       lopts.uprobe_multi.flags =3D retprobe ? BPF_F_UPROBE_MULTI_RETURN=
 : 0;
>
>         if (pid =3D=3D 0)
>                 pid =3D getpid();
> @@ -12107,7 +12121,7 @@ bpf_program__attach_uprobe_multi(const struct bpf=
_program *prog,
>         }
>         link->detach =3D &bpf_link__detach_fd;
>
> -       link_fd =3D bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &=
lopts);
> +       link_fd =3D bpf_link_create(prog_fd, 0, attach_type, &lopts);
>         if (link_fd < 0) {
>                 err =3D -errno;
>                 pr_warn("prog '%s': failed to attach multi-uprobe: %s\n",
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 91484303849c..b2ce3a72b11d 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -577,10 +577,12 @@ struct bpf_uprobe_multi_opts {
>         size_t cnt;
>         /* create return uprobes */
>         bool retprobe;
> +       /* create session kprobes */
> +       bool session;
>         size_t :0;
>  };
>
> -#define bpf_uprobe_multi_opts__last_field retprobe
> +#define bpf_uprobe_multi_opts__last_field session
>
>  /**
>   * @brief **bpf_program__attach_uprobe_multi()** attaches a BPF program
> --
> 2.47.0
>

