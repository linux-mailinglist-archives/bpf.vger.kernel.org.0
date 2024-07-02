Return-Path: <bpf+bounces-33685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A97F79249F2
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 23:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBE41C228D5
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 21:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1026120125A;
	Tue,  2 Jul 2024 21:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpCP9nK8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F82C7EEE7;
	Tue,  2 Jul 2024 21:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719955817; cv=none; b=a1OfC9BpHlOuwTK72BWFo76+Lz8jWFuC8eJDGkF3gbAbs8URG4HewyNVp8j3aaBvqx1JsrzUX1hdCNuDgdYY2JdiFZCyBhHJQAELIyulpxTT7mWW6QN/m+nuD1gTz2tn3jywv0ACCTZeFvXFld/JH4AldrLkMo1FL1dSShstYqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719955817; c=relaxed/simple;
	bh=8IgXhWjbLNsju5hQj9G/eJNfVAUk2Am0Iq8Jm7KYAqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ev/3riZbEg7lxvG5T9E4jx3udiVjBJAQddqrzWetb183GrBS2ZZPOeq+P0goIDdtjMbZpHkZPv2vrX/WkgSmEqTj+VXBhjsaP+Dyl1pl+QXbtb+L0P3qhkq60pKWTbUUAdtwWnfUAdbBfElo6GMn7ahMFGsRbJRKvvZIZFhov48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpCP9nK8; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7180e5f735bso2410a12.0;
        Tue, 02 Jul 2024 14:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719955815; x=1720560615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vn+rMMB8RfgEefj7RNp7RZyCPdwcdpzknlkgaqe/62U=;
        b=RpCP9nK8KJpmYIaDu8ErW/DzcRewwgoOkD1Wsb7prStFnIUyEXw6GZqj77bV4dneSR
         Tjuj1b357Z7VdkN3I7PPpscHk4Fl9vRiS4WNn8vdF4dSYrsvw3fFt29YZh8NNBqXeMdU
         D4Dx8PF9uycyuXOly2X/jY3u8WNMlHlscnUJYEKq7jrc2qyHynLH+K2rzL3PVvidOUjO
         CBVEoUZxD8FDayuPnUkTidItyvW174+Wpz9lOVK6ZXiOXmW1QI2FmNcbRbsL0JR6dMAf
         IsWfsG7dVmNaWYIRrsbPDABh/8Gp7NrQsKKeNjL5r6rrQ3BK0K7l7wF7fCeMhSSHhAvl
         cnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719955815; x=1720560615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vn+rMMB8RfgEefj7RNp7RZyCPdwcdpzknlkgaqe/62U=;
        b=g95ukHQ29eJjuXqhmW0oEwpGXTaG4iOumB4qhlT9qbjVknG0ONcTlaR/S/LySNHD5U
         GWj+nf+2Yhh2FzFVYJ+6hZAxslAroin4Bsedacn3eqYmMJRSd0FH/hqZE5/rDsUMyPtJ
         AOM/RxNdw7Yx5ex2Q6tpssXFVTM3b0udJgJgGripsgP/GTQnnKBXln/FRncWPwFdCR6w
         nGLhJFDXRqybiQVupK1YXzGp5frK2nFuyRG+9y17Xq0HS+mRDjoVl8zk2gBcYymOFBk5
         +q1dXt1NZQGPBZgq+pVrgTkroO+89EpVR8/bNBqf60dDuc08iUUH9SBzsQaYicjU1cqv
         DmXw==
X-Forwarded-Encrypted: i=1; AJvYcCWGL2q0v30sQAItyW4ks/pVsTTEmDtHr6kB8hv0TPijJWXfmkk8XzRBn1xBFm/upw3Veu6dH0GuxAZxtRJ2vZztOcwhtrWzAdbFNle1NSIOsPtvyS1XX6dtWpB4ZIfgHlii1rmY+jLNw8k9hMKWUoHSU1QmeDM7e4h6kdiSSrYdrIE54scP
X-Gm-Message-State: AOJu0Yyq+vgnX/XnCav2lmyRi1ZPVdh3KnQOVpjutnsJZ71n5Rx7zJ02
	kAkWmTk8lUYo3B11LAlJGMENCBY1S0PVkVURkXwU5Y8RhiiNc0fpETjD4mFc96PZzqwbjkee3j3
	3ztimUImxKHNCPDRPNOYM6JoCSX+jg4MC
X-Google-Smtp-Source: AGHT+IGI0SogHYb405nMd/lUROty/z2+x9HzIMLhkKktFL+kEX9GoxYJltyt8vE/VlkAqOlW2KnwgGtU0MR/YR526n8=
X-Received: by 2002:a05:6a00:1256:b0:704:151d:dcce with SMTP id
 d2e1a72fcca58-70aaab17887mr16466284b3a.5.1719955815452; Tue, 02 Jul 2024
 14:30:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701164115.723677-1-jolsa@kernel.org> <20240701164115.723677-3-jolsa@kernel.org>
In-Reply-To: <20240701164115.723677-3-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 14:30:03 -0700
Message-ID: <CAEf4BzbR35PvRpyPgiA3oLsh4BUWuSMS+DQK4AArA0fTNq=n7g@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 2/9] bpf: Add support for uprobe multi session attach
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 9:42=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to attach bpf program for entry and return probe
> of the same function. This is common use case which at the moment
> requires to create two uprobe multi links.
>
> Adding new BPF_TRACE_UPROBE_SESSION attach type that instructs
> kernel to attach single link program to both entry and exit probe.
>
> It's possible to control execution of the bpf program on return
> probe simply by returning zero or non zero from the entry bpf
> program execution to execute or not the bpf program on return
> probe respectively.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/bpf/syscall.c           |  9 +++++++--
>  kernel/trace/bpf_trace.c       | 25 +++++++++++++++++++------
>  tools/include/uapi/linux/bpf.h |  1 +
>  4 files changed, 28 insertions(+), 8 deletions(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 35bcf52dbc65..1d93cb014884 100644
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
> index 869265852d51..2a63a528fa3c 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4049,10 +4049,14 @@ static int bpf_prog_attach_check_attach_type(cons=
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
> @@ -5315,7 +5319,8 @@ static int link_create(union bpf_attr *attr, bpfptr=
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
> index 02d052639dfe..1b19c1cdb5e1 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1645,6 +1645,17 @@ static inline bool is_kprobe_session(const struct =
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
> @@ -1662,13 +1673,13 @@ kprobe_prog_func_proto(enum bpf_func_id func_id, =
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
> @@ -3387,7 +3398,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_at=
tr *attr, struct bpf_prog *pr
>         if (sizeof(u64) !=3D sizeof(void *))
>                 return -EOPNOTSUPP;
>
> -       if (prog->expected_attach_type !=3D BPF_TRACE_UPROBE_MULTI)
> +       if (!is_uprobe_multi(prog))
>                 return -EINVAL;
>
>         flags =3D attr->link_create.uprobe_multi.flags;
> @@ -3463,10 +3474,12 @@ int bpf_uprobe_multi_link_attach(const union bpf_=
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
> +               if (flags & BPF_F_UPROBE_MULTI_RETURN || is_uprobe_sessio=
n(prog))
> +                       uprobes[i].consumer.ret_handler =3D uprobe_multi_=
link_ret_handler;
> +               if (is_uprobe_session(prog))
> +                       uprobes[i].consumer.session =3D true;
>
>                 if (pid)
>                         uprobes[i].consumer.filter =3D uprobe_multi_link_=
filter;
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 35bcf52dbc65..1d93cb014884 100644
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
> --
> 2.45.2
>

