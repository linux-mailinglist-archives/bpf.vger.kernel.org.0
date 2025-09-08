Return-Path: <bpf+bounces-67741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F08B496E0
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBD5B1C21DFB
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 17:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D1331328A;
	Mon,  8 Sep 2025 17:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMFYSnHb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E0722256F;
	Mon,  8 Sep 2025 17:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352071; cv=none; b=TqxNweDLvsOzn2ti/YpIadxvPeNkkFmrq5OTTNsQssY7tRMWwLz6SOxQHJl+kesC5xGfylDotp+HK0vcWo6EH2MDT0t8T98coS03H/fpywbz7TRQaaRKxlTTAAXs2IhOIE2QxOBUlapf+4lHMFdsy+a2Q8Cm8BJOSnpzE9nZ2tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352071; c=relaxed/simple;
	bh=aQqasewGij2DipD9dXOUbTnfRUlRgPlsl7xxR3FbsaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEvUeVNTeY1Y6CW4i2/VPxFuukzQZuC4erqagzNlrQAslCKT11p6fvP7f9i9Q+vz2Orj2u6LwwVWs3hWD81lBbePgT/flsHP4lEetaEoX8FkML1k2zwtdGzc/9yvXj7TL5NJs/iT5Ksm6bYkxUaQpz2ZueyRSuKiZ3BZObYBY28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMFYSnHb; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3e2055ce973so2481547f8f.0;
        Mon, 08 Sep 2025 10:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757352068; x=1757956868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xf8/kK0KX4VQm3mTeKF/yjGFhXksUE4qlFpvzV+PiEY=;
        b=GMFYSnHbeHwg8ehnImwqOsZagyWLLN2PdtFF8b+FvAaNfO5Rpx0wGh3PH0ZeJR7USP
         QOw11xTJ1N1u9T4E0L69Kws10yx7U+7mTK952DXIg0BHVy0Ae0pEHcSyMrMvS9vxjj5q
         ac2oI2RnHr52oZ0klFWNNAusUocTE6INw1SoJh9SzgAMQ6n6CBQxeIQEvuqQ/aTFDtPf
         sn+wOAqk0X4CDZ9bee8YUPvI6ioHvbYFU3v57GrfVI4yWoA8PdoRAuGIqZA7SI61dlAa
         zEklbJwVfyBXqc+eHrCZfDDBp/kLg+KtOFefqYRfyyR8UYaa6WN0e8qBrsO1AruJPBeR
         chMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757352068; x=1757956868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xf8/kK0KX4VQm3mTeKF/yjGFhXksUE4qlFpvzV+PiEY=;
        b=ucwCjNY7O5QM9skO8PVexQVkXJ/7b5CU+Pb8fKFM4OstXPMkulsc2TVLAZgpW1cWf/
         0ErDPF3qOcDYdU15huQbxYPqAPNcmGpf62rslh/KR751M7HfasqRdJLBc3wW/mfGW9kz
         1cPVItqTbcO3KRv5Z/vzaLtaJ1iKK/ujEn6/gUU51oobLT+Ai14lO54OYQongmoz+L6w
         JqttlezGAeqw06OTpD5IuOn4K/lthcqStZEgSCPo2Nn2kgfdfOwkjhJUzLC1cVUVMbab
         0m9k1YzErJy7iXgKZASdPXgkU9RLP1zRFSzTvqCQA7HAHhfQgfpsnjyEOuwGBhqCBlTe
         pUrw==
X-Forwarded-Encrypted: i=1; AJvYcCUZKqBg1drDh7m4h0+ZoPbjNV1Q1adEeLiPCF4AvJ7K90NyHeqKFr/WKv2hOaE7vMiMZ7o=@vger.kernel.org, AJvYcCX1yEZOX/JAxEnCdCQ/trCl/ib5qXtiKeWZdq3eL+B310Eyk89Lf1qVrRK2XuBnDUrjj5iAAV+6UfkdiGcB@vger.kernel.org, AJvYcCXc9tvnSVVuEbgp/tQg0qczX7fk1jnuk58x+roA8jlfYUk2mI/J+6FYLTNpPgC/x5S+1PyLb7HL9mZRk33gcLJUqMLv@vger.kernel.org
X-Gm-Message-State: AOJu0YywByguaKNMlFk/TIPjwaGmpeAbU5rMuPOkqkunwkUK7P9yNtfZ
	kUdJVQGUa1ZCn+4+ich46b1axL+7u6WR4LRBUQQJ9zPajl69CV+6de8p75rTDN54R1Zzs2uKDzx
	PML9aR8KTOweDjhyyVqrkyzZkYmWQ3Qk=
X-Gm-Gg: ASbGnctCxIxXlHpFcCNoEwEJO2M4TmB42Tp74QbUp+p9UK4aIFjvM9NGb6io1wmNNZb
	NY/ddloQJ66Gz6v/AL8l/WCM2zkAE3+BhEshStsYwyTVYonWRIQDm6E0Q5/vmvz39K+eu8EPJsh
	gDUJr7Iq40Zd09gj8GyyMd0Gd5R4emqPaU0864HY15fyn/HT9hNvx7yrHXW8t9Eh9jd0ksLTnIr
	2MB84Kx56X3WOlJ2yfmShULrqUf9jTf0qyN
X-Google-Smtp-Source: AGHT+IE7nzcMuhcbyflAdA3MKfKZobpKkQZdHgFuiVq9VqEsOlRhnU2bkWjn0sGkuC4rTZBWKOkXNtM7uRblD3/l0r0=
X-Received: by 2002:a05:6000:22c7:b0:3da:936b:95cf with SMTP id
 ffacd0b85a97d-3e6429cce12mr7087277f8f.28.1757352067482; Mon, 08 Sep 2025
 10:21:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908121310.46824-1-jolsa@kernel.org> <20250908121310.46824-2-jolsa@kernel.org>
In-Reply-To: <20250908121310.46824-2-jolsa@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Sep 2025 10:20:55 -0700
X-Gm-Features: AS18NWC4lsE-p9NZJPk6PVDXniaZKrSY1PpcJkmXviaoFheT98MsxNohnkWJYyk
Message-ID: <CAADnVQKC4tNCLrS6_1zLOtF7MUWiXUWnLXCnQBp_UDLQZj3rrg@mail.gmail.com>
Subject: Re: [PATCHv2 perf/core 1/4] bpf: Allow uprobe program to change
 context registers
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 5:13=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Currently uprobe (BPF_PROG_TYPE_KPROBE) program can't write to the
> context registers data. While this makes sense for kprobe attachments,
> for uprobe attachment it might make sense to be able to change user
> space registers to alter application execution.
>
> Since uprobe and kprobe programs share the same type (BPF_PROG_TYPE_KPROB=
E),
> we can't deny write access to context during the program load. We need
> to check on it during program attachment to see if it's going to be
> kprobe or uprobe.
>
> Storing the program's write attempt to context and checking on it
> during the attachment.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/bpf.h      | 1 +
>  kernel/events/core.c     | 4 ++++
>  kernel/trace/bpf_trace.c | 3 +--
>  3 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index cc700925b802..404a30cde84e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1619,6 +1619,7 @@ struct bpf_prog_aux {
>         bool priv_stack_requested;
>         bool changes_pkt_data;
>         bool might_sleep;
> +       bool kprobe_write_ctx;
>         u64 prog_array_member_cnt; /* counts how many times as member of =
prog_array */
>         struct mutex ext_mutex; /* mutex for is_extended and prog_array_m=
ember_cnt */
>         struct bpf_arena *arena;
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 28de3baff792..c3f37b266fc4 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11238,6 +11238,10 @@ static int __perf_event_set_bpf_prog(struct perf=
_event *event,
>         if (prog->kprobe_override && !is_kprobe)
>                 return -EINVAL;
>
> +       /* Writing to context allowed only for uprobes. */
> +       if (prog->aux->kprobe_write_ctx && !is_uprobe)
> +               return -EINVAL;
> +
>         if (is_tracepoint || is_syscall_tp) {
>                 int off =3D trace_event_get_offsets(event->tp_event);
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 3ae52978cae6..467fd5ab4b79 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1521,8 +1521,6 @@ static bool kprobe_prog_is_valid_access(int off, in=
t size, enum bpf_access_type
>  {
>         if (off < 0 || off >=3D sizeof(struct pt_regs))
>                 return false;
> -       if (type !=3D BPF_READ)
> -               return false;
>         if (off % size !=3D 0)
>                 return false;
>         /*
> @@ -1532,6 +1530,7 @@ static bool kprobe_prog_is_valid_access(int off, in=
t size, enum bpf_access_type
>         if (off + size > sizeof(struct pt_regs))
>                 return false;
>
> +       prog->aux->kprobe_write_ctx |=3D type =3D=3D BPF_WRITE;

iirc the same function is used to validate [ku]probe.multi ctx access,
but attaching is not done via __perf_event_set_bpf_prog().
The check at attach time is missing?

