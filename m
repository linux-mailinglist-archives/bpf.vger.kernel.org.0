Return-Path: <bpf+bounces-40613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D9D98AF43
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 23:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDFD81C2185F
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 21:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90B3186E59;
	Mon, 30 Sep 2024 21:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0IdNwHg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F60184527;
	Mon, 30 Sep 2024 21:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727732210; cv=none; b=ArSGUMhYaLi2c59+C/HBe1Qq9W0K+zFRMxgX6q6B+RusWP2a3zRsNznnVxtriE2FKYH7a0sJsR3vCFqXVLJpUvDvs37TPo3g/TKkMoE7o3OJ3jp9AkrMeywIabDSBmNzJ1N7SoGzsvFSGM5bk9JlHp9JipSMmvLXAPZQB21cqww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727732210; c=relaxed/simple;
	bh=GXmvbsvNEqoHGNrJu2SrieazMifYZhOquLiAVHxWLxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4wZrCkF87ITyfmXCBM5x/Hm4s356PuDjXHnlVZmW0uXeEB4qib+wwLtkJmwxmoXuMtL8Yp8ZpRTpAjp+Dj2jVS+xhZyqy4KK/iCIKxyyBZPyXy9YDiRPQyj85vBI3N49xOO1zQNmLR6DmcAIKMISgjUE4qi5tmJF+z9zdZPQ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0IdNwHg; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e0af6e5da9so3074305a91.2;
        Mon, 30 Sep 2024 14:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727732208; x=1728337008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLjmuJdgY04vPZgQ7wfu5wG7oZ0LAGRAYlcoftUXrC4=;
        b=T0IdNwHgdDyWPiTstBzBME6+glNC45vRAKdNfchySuGO94mtDoro+KvhHv4lTb+dpz
         OlnVT0mFwHeOvvXDyJ2Mt8VZYTs4KSCIuiZN3ruGWmKxW3ajnrquJLTuo/+guF/akeOT
         CI1FM8vWCX7cqj5JrQdbO5wQfgXYG/2N7qciaBgohFDNnnspxkDWcuo7y0mDCu0IyPgd
         OPo58r0lU2jJ+BJOK32J8VHvs3Bf/rjad4T2TFkQyWI6TFgsP5pczEh7b/mtv8WSB6Px
         YszJFwvyg0ApftyXut+I9zOKZrQU1YPeYVWEVduLcf3kukSZ+j239nVVqGD4WIsGpT2H
         Eu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727732208; x=1728337008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLjmuJdgY04vPZgQ7wfu5wG7oZ0LAGRAYlcoftUXrC4=;
        b=RKqyhlkfAUnH1kx26OV5pF95JWr3hf4m8VGGy+n+B+DDX2x3rJom3H/B66MK5PhrKF
         yKUPTYvrIoIONeMESmohI20AYYOipJGXi19T0A8SBaTiMAvR0OHrrIJia8PYtVbqPor5
         vfwxzLOQl0W1gL7HLM1jtIOopUrfPKIIDEe0sz54cx4ZkXBjljqXQQT7DSQ6H+hzpOGX
         atCFDmxFR8rgqSjSzwTd/fNOBSo43Bsazm1nFF+Jbbp2S7t6xSr6euiMcmp0DIuVuqoT
         TVU+Xs8nKqWiFEZWWWko1oHO5sWSZfS3+5l6o9CXYrj+TcV5C0VBmLiUMHAzafdRO5EN
         NHtg==
X-Forwarded-Encrypted: i=1; AJvYcCX8Z5rL2erkXLWgPu1cAYDbJDsJUodOKytNIHGPuN7ufa76Sff8kkEIqnqT/T+CobL9anKpHMl1gd9dT+uc2lY7ZGC3@vger.kernel.org, AJvYcCXiuKKd0amUgJAjBMn4qcdkD13F9YYAZsKrZzvjv/sT2zQ5ObeMyULo5A9/aC4vs2zfDMc=@vger.kernel.org, AJvYcCXma2IwElANNT/7vTH0UbPZSJihyK4tofUfuKQdm77VWnaBndgaB7mLgAQxT4wFyIvLGpGIRapd9kE/Trbh@vger.kernel.org
X-Gm-Message-State: AOJu0YzvFUCVBFJ3snwGyyQQcHa2FEOiQVyqVWyrinPpEqC/5CJthx0O
	UPF5jT16tLW4rekr33fZ8MV9s28fypmSPzxbMFjz6nNr3xLW8vuPYgN2/07W0bwba/wOzDNebfr
	bIjhMSF7GjpIk2GbFToSK6Sid4Us=
X-Google-Smtp-Source: AGHT+IGrecAdvHcSYgeuLmnKQSCfWKC9mn/PnT0z7da7XCLAC3HexVDjABjdU3yGwmAKJ+kqDL1ESJcquMJmDutfTto=
X-Received: by 2002:a17:90a:9ea:b0:2d3:c34e:2fda with SMTP id
 98e67ed59e1d1-2e0b89d961cmr15187610a91.14.1727732208036; Mon, 30 Sep 2024
 14:36:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929205717.3813648-1-jolsa@kernel.org> <20240929205717.3813648-7-jolsa@kernel.org>
In-Reply-To: <20240929205717.3813648-7-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Sep 2024 14:36:35 -0700
Message-ID: <CAEf4BzYQLo41DtTPpkZ-mMWx-34G4h2pFKY_mDrBfFibjGHjPA@mail.gmail.com>
Subject: Re: [PATCHv5 bpf-next 06/13] libbpf: Add support for uprobe multi
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

On Sun, Sep 29, 2024 at 1:58=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
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
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/bpf.c    |  1 +
>  tools/lib/bpf/libbpf.c | 21 ++++++++++++++++++---
>  tools/lib/bpf/libbpf.h |  4 +++-
>  3 files changed, 22 insertions(+), 4 deletions(-)
>

LGTM, though see the nit below

Acked-by: Andrii Nakryiko <andrii@kernel.org>

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
> index 3587ed7ec359..563ff5e64269 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9410,8 +9410,10 @@ static const struct bpf_sec_def section_defs[] =3D=
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
> @@ -11733,7 +11735,10 @@ static int attach_uprobe_multi(const struct bpf_=
program *prog, long cookie, stru
>                 ret =3D 0;
>                 break;
>         case 3:
> -               opts.retprobe =3D str_has_pfx(probe_type, "uretprobe.mult=
i");
> +               if (str_has_pfx(probe_type, "uprobe.session"))
> +                       opts.session =3D true;
> +               else
> +                       opts.retprobe =3D str_has_pfx(probe_type, "uretpr=
obe.multi");

nit: this is very non-uniform, can you please just do:

opts.session =3D str_has_pfx(probe_type, "uprobe.session");
opts.retprobe =3D str_has_pfx(probe_type, "uretprobe.multi");

There is no need to micro-optimize str_has_pfx() calls, IMO.

>                 *link =3D bpf_program__attach_uprobe_multi(prog, -1, bina=
ry_path, func_name, &opts);
>                 ret =3D libbpf_get_error(*link);
>                 break;

[...]

