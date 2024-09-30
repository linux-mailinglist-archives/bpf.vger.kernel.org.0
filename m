Return-Path: <bpf+bounces-40611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF8698AF3F
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 23:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90FED281DDC
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 21:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10289184529;
	Mon, 30 Sep 2024 21:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuBhm3pK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003E3184520;
	Mon, 30 Sep 2024 21:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727732182; cv=none; b=jrBSiMJgMvZnru2OR1VGXVALhXD27b9gvcMkxzaXUGDjvW106OCgrOAVwpX1hlUZDq0EKWK63tS2wpP97Rzc8gn5ocgHXd/GOqNzJR1xzt0yZDH9rdchWMueexaRCmbhQkCqAUs6Ednlzl2ZHxdrsfnWA3SzXyDn/kJ32OmVAcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727732182; c=relaxed/simple;
	bh=Tx38fsTZkeQnIQ4nijJYVYxHMjVl3L4YPqv5o9RpvsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iafZ2Y01VCIrbycjZD75a+vXmXrX1nL7loHcvaX8e6tSioS7QCY3F20HHgdpCuo15eQEqItTadJ2Arqs2uyApEErVWXsaIKryQkdFzRj5q0FogEtOnpztKZhM/AwzVprlPhnk71IfNy8MLsqAdet81FdusBNxc7dzaZMeooPjJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuBhm3pK; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7db238d07b3so4079126a12.2;
        Mon, 30 Sep 2024 14:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727732180; x=1728336980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZiDx8x0r0JS69Y4oX6mKcnN2YOB2jv1s3wY0uVi2Eb0=;
        b=fuBhm3pKQwfp2Zz52FhkQSx4peoFvlgVnYEli3z4zkC6UpMF4sSC/9lbzqbULQ3RdF
         FU936qEhL+Ojv1qePj9CtM0VeEV97N4G5o7BublO/Jocw1W7Ks0RWdp3vPheMuDpO63m
         gv2zuxOXRrxQvp6KL8y7EcndaIgO9dY43LzC7NS/sWtS0x608c9ZovSi4+62rl4XtaXk
         NjQyb1L0EbycXo7pVL4fW5mX40viu9hRvxKUslELTjHRmsAaoNVBW799TCLIoeYEBDFg
         V0Dg2IbCZGrEOuSga8vb2zXciqKCtwIwbre0qRxIMQhceMRDIw4cBWVVtiODZyQ/UxR1
         9Tsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727732180; x=1728336980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZiDx8x0r0JS69Y4oX6mKcnN2YOB2jv1s3wY0uVi2Eb0=;
        b=aduY/jnCWIhwtBI6P29Sy7MAvekFv2GoNgP95UjnEyUWDlNgHmCIw2yd84IDY34exm
         +O56+G3y4EWGFmOGKuaTpIJol3v7Lbc9SDuOtfab7WU/h2C/EaBWXk4G19InT1VmBeds
         5WXP91f6ieOoZh+DolfDC1mt9v2SAOTWPz+X3c2bAoKTQpGVN2Ns8W+WCdrTSa6VRJfl
         x4/lHYHfcsrPI0TEYzekyy/FnuW4idg0pgn547rA/b81YnhNlD/dSnSAM/CxMMBH30S0
         ZvT2S5RT075vMh6HN4EJQ7yNFYe34Z09H9zgqqGZNcRsMZ17FTexwOJ9x9jolIb5ekm7
         F/fw==
X-Forwarded-Encrypted: i=1; AJvYcCW2O9Qqi4uK510iyCxcwsrlLOu2S6zzAPMcBqxdTCNwxzVnw3EuZrA/Nknk3Q60Fnv4qmU=@vger.kernel.org, AJvYcCWtPET+fa7QFB04mjwuIZkoMkNtHpuojpyLzb2SgJ8fo4rIYVTWdjlTIrtXEzZVe2cBzwNFjXcfpXSPtpYxD9JWxsYH@vger.kernel.org, AJvYcCXgI4wa7adZLH4mup5LRn7VghLYM6X75NAm9M21aIlZyJsVrN4tGDmK7jwPvevde8Kf+VGfpg6uug1hmVuS@vger.kernel.org
X-Gm-Message-State: AOJu0YwT3kB/DldGx1zT3Z30mgUSYgBaYjvLaPzGRtojLjhw+Kiv4j45
	Ikv5+0zK3tr5k++yL/eAqcX2wdolQdhnIIMXqF+cpb2wQSakbfakZMNU2GCVqLUVjql8XtxHBQZ
	87YaJM8gZD9twIx7rFOUJ94TNSgE=
X-Google-Smtp-Source: AGHT+IEMTYl/igoVs6ywfH7BBV97pCLxqoYW19UOY2cMtCJYqiuzvQBK67d2wPjCyrsQfZA0TzgY8opg1HrjQX6SxKU=
X-Received: by 2002:a17:90b:3587:b0:2d8:ca33:42a5 with SMTP id
 98e67ed59e1d1-2e0b8ee5895mr13061302a91.40.1727732180132; Mon, 30 Sep 2024
 14:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929205717.3813648-1-jolsa@kernel.org> <20240929205717.3813648-4-jolsa@kernel.org>
In-Reply-To: <20240929205717.3813648-4-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Sep 2024 14:36:08 -0700
Message-ID: <CAEf4BzZfy1H2O-uY3x9X7ScsJTXHgqjZkcP7A0tMmhmvubF-nw@mail.gmail.com>
Subject: Re: [PATCHv5 bpf-next 03/13] bpf: Add support for uprobe multi
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
> Adding support to attach BPF program for entry and return probe
> of the same function. This is common use case which at the moment
> requires to create two uprobe multi links.
>
> Adding new BPF_TRACE_UPROBE_SESSION attach type that instructs
> kernel to attach single link program to both entry and exit probe.
>
> It's possible to control execution of the BPF program on return
> probe simply by returning zero or non zero from the entry BPF
> program execution to execute or not the BPF program on return
> probe respectively.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/bpf/syscall.c           |  9 ++++++--
>  kernel/trace/bpf_trace.c       | 39 +++++++++++++++++++++++++++-------
>  tools/include/uapi/linux/bpf.h |  1 +
>  tools/lib/bpf/libbpf.c         |  1 +
>  5 files changed, 41 insertions(+), 10 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 8ab4d8184b9d..77d0bc5fa986 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1116,6 +1116,7 @@ enum bpf_attach_type {
>         BPF_NETKIT_PRIMARY,
>         BPF_NETKIT_PEER,
>         BPF_TRACE_KPROBE_SESSION,
> +       BPF_TRACE_UPROBE_SESSION,
>         __MAX_BPF_ATTACH_TYPE
>  };
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index a8f1808a1ca5..0cf7617e6cb6 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3983,10 +3983,14 @@ static int bpf_prog_attach_check_attach_type(cons=
t struct bpf_prog *prog,
>                 if (prog->expected_attach_type =3D=3D BPF_TRACE_UPROBE_MU=
LTI &&
>                     attach_type !=3D BPF_TRACE_UPROBE_MULTI)
>                         return -EINVAL;
> +               if (prog->expected_attach_type =3D=3D BPF_TRACE_UPROBE_SE=
SSION &&
> +                   attach_type !=3D BPF_TRACE_UPROBE_SESSION)
> +                       return -EINVAL;
>                 if (attach_type !=3D BPF_PERF_EVENT &&
>                     attach_type !=3D BPF_TRACE_KPROBE_MULTI &&
>                     attach_type !=3D BPF_TRACE_KPROBE_SESSION &&
> -                   attach_type !=3D BPF_TRACE_UPROBE_MULTI)
> +                   attach_type !=3D BPF_TRACE_UPROBE_MULTI &&
> +                   attach_type !=3D BPF_TRACE_UPROBE_SESSION)
>                         return -EINVAL;
>                 return 0;
>         case BPF_PROG_TYPE_SCHED_CLS:
> @@ -5239,7 +5243,8 @@ static int link_create(union bpf_attr *attr, bpfptr=
_t uattr)
>                 else if (attr->link_create.attach_type =3D=3D BPF_TRACE_K=
PROBE_MULTI ||
>                          attr->link_create.attach_type =3D=3D BPF_TRACE_K=
PROBE_SESSION)
>                         ret =3D bpf_kprobe_multi_link_attach(attr, prog);
> -               else if (attr->link_create.attach_type =3D=3D BPF_TRACE_U=
PROBE_MULTI)
> +               else if (attr->link_create.attach_type =3D=3D BPF_TRACE_U=
PROBE_MULTI ||
> +                        attr->link_create.attach_type =3D=3D BPF_TRACE_U=
PROBE_SESSION)
>                         ret =3D bpf_uprobe_multi_link_attach(attr, prog);
>                 break;
>         default:
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index fdab7ecd8dfa..98e940ec184d 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1557,6 +1557,17 @@ static inline bool is_kprobe_session(const struct =
bpf_prog *prog)
>         return prog->expected_attach_type =3D=3D BPF_TRACE_KPROBE_SESSION=
;
>  }
>
> +static inline bool is_uprobe_multi(const struct bpf_prog *prog)
> +{
> +       return prog->expected_attach_type =3D=3D BPF_TRACE_UPROBE_MULTI |=
|
> +              prog->expected_attach_type =3D=3D BPF_TRACE_UPROBE_SESSION=
;
> +}
> +
> +static inline bool is_uprobe_session(const struct bpf_prog *prog)
> +{
> +       return prog->expected_attach_type =3D=3D BPF_TRACE_UPROBE_SESSION=
;
> +}
> +
>  static const struct bpf_func_proto *
>  kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *=
prog)
>  {
> @@ -1574,13 +1585,13 @@ kprobe_prog_func_proto(enum bpf_func_id func_id, =
const struct bpf_prog *prog)
>         case BPF_FUNC_get_func_ip:
>                 if (is_kprobe_multi(prog))
>                         return &bpf_get_func_ip_proto_kprobe_multi;
> -               if (prog->expected_attach_type =3D=3D BPF_TRACE_UPROBE_MU=
LTI)
> +               if (is_uprobe_multi(prog))
>                         return &bpf_get_func_ip_proto_uprobe_multi;
>                 return &bpf_get_func_ip_proto_kprobe;
>         case BPF_FUNC_get_attach_cookie:
>                 if (is_kprobe_multi(prog))
>                         return &bpf_get_attach_cookie_proto_kmulti;
> -               if (prog->expected_attach_type =3D=3D BPF_TRACE_UPROBE_MU=
LTI)
> +               if (is_uprobe_multi(prog))
>                         return &bpf_get_attach_cookie_proto_umulti;
>                 return &bpf_get_attach_cookie_proto_trace;
>         default:
> @@ -3074,6 +3085,7 @@ struct bpf_uprobe {
>         u64 cookie;
>         struct uprobe *uprobe;
>         struct uprobe_consumer consumer;
> +       bool session;
>  };
>
>  struct bpf_uprobe_multi_link {
> @@ -3248,9 +3260,13 @@ uprobe_multi_link_handler(struct uprobe_consumer *=
con, struct pt_regs *regs,
>                           __u64 *data)
>  {
>         struct bpf_uprobe *uprobe;
> +       int ret;
>
>         uprobe =3D container_of(con, struct bpf_uprobe, consumer);
> -       return uprobe_prog_run(uprobe, instruction_pointer(regs), regs);
> +       ret =3D uprobe_prog_run(uprobe, instruction_pointer(regs), regs);
> +       if (uprobe->session)
> +               return ret ? UPROBE_HANDLER_IGNORE : 0;
> +       return ret;

isn't this a bug that BPF program can return arbitrary value here and,
e.g., request uprobe unregistration?

Let's return 0, unless uprobe->session? (it would be good to move that
into a separate patch with Fixes)

>  }
>
>  static int
> @@ -3260,6 +3276,12 @@ uprobe_multi_link_ret_handler(struct uprobe_consum=
er *con, unsigned long func, s
>         struct bpf_uprobe *uprobe;
>
>         uprobe =3D container_of(con, struct bpf_uprobe, consumer);
> +       /*
> +        * There's chance we could get called with NULL data if we regist=
ered uprobe
> +        * after it hit entry but before it hit return probe, just ignore=
 it.
> +        */
> +       if (uprobe->session && !data)
> +               return 0;

why can't handle_uretprobe_chain() do this check instead? We know when
we are dealing with session uprobe/uretprobe, so we can filter out
these spurious calls, no?


>         return uprobe_prog_run(uprobe, func, regs);
>  }
>
> @@ -3299,7 +3321,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_at=
tr *attr, struct bpf_prog *pr
>         if (sizeof(u64) !=3D sizeof(void *))
>                 return -EOPNOTSUPP;
>
> -       if (prog->expected_attach_type !=3D BPF_TRACE_UPROBE_MULTI)
> +       if (!is_uprobe_multi(prog))
>                 return -EINVAL;
>
>         flags =3D attr->link_create.uprobe_multi.flags;
> @@ -3375,11 +3397,12 @@ int bpf_uprobe_multi_link_attach(const union bpf_=
attr *attr, struct bpf_prog *pr
>
>                 uprobes[i].link =3D link;
>
> -               if (flags & BPF_F_UPROBE_MULTI_RETURN)
> -                       uprobes[i].consumer.ret_handler =3D uprobe_multi_=
link_ret_handler;
> -               else
> +               if (!(flags & BPF_F_UPROBE_MULTI_RETURN))
>                         uprobes[i].consumer.handler =3D uprobe_multi_link=
_handler;
> -
> +               if (flags & BPF_F_UPROBE_MULTI_RETURN || is_uprobe_sessio=
n(prog))
> +                       uprobes[i].consumer.ret_handler =3D uprobe_multi_=
link_ret_handler;
> +               if (is_uprobe_session(prog))
> +                       uprobes[i].session =3D true;
>                 if (pid)
>                         uprobes[i].consumer.filter =3D uprobe_multi_link_=
filter;
>         }
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 7610883c8191..09bdb1867d4a 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1116,6 +1116,7 @@ enum bpf_attach_type {
>         BPF_NETKIT_PRIMARY,
>         BPF_NETKIT_PEER,
>         BPF_TRACE_KPROBE_SESSION,
> +       BPF_TRACE_UPROBE_SESSION,
>         __MAX_BPF_ATTACH_TYPE
>  };
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 712b95e8891b..3587ed7ec359 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -133,6 +133,7 @@ static const char * const attach_type_name[] =3D {
>         [BPF_NETKIT_PRIMARY]            =3D "netkit_primary",
>         [BPF_NETKIT_PEER]               =3D "netkit_peer",
>         [BPF_TRACE_KPROBE_SESSION]      =3D "trace_kprobe_session",
> +       [BPF_TRACE_UPROBE_SESSION]      =3D "trace_uprobe_session",
>  };
>
>  static const char * const link_type_name[] =3D {
> --
> 2.46.1
>

