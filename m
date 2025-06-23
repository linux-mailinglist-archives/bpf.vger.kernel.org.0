Return-Path: <bpf+bounces-61306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2499AE4C37
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 19:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B59217DF29
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 17:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BDA2D320D;
	Mon, 23 Jun 2025 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aj2cmgln"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B581B4242;
	Mon, 23 Jun 2025 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750701374; cv=none; b=Dx/MfZon4ZXOFduRCai3TC0wuYVAz8AutILCd8bwEni9lRHA7WCkkqelopPgTzChZOuvDaGv7e0ZOdOUXbAAFH0ox3GhJCgZ/jPwYv5PiIEVhgP9KUcqQa4xWxNykC3F2mK3JgiWkHuQqktxQxU5bOv8bpV1RChpLiDzu2Jql7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750701374; c=relaxed/simple;
	bh=Ll/x1chm5F7UxlRy42ZY60Cj2nEs3fNt5t2+xtPtQhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NS4zlrl0pvQzxRo6pScmqrXhblKeAZ1MN7cuK+2gsEqjKl++b8MErC07OJTQQttOY59sI/3Bpk6U3hfvxmR+9Qwjhf3/UYg5kseTp+OOhalpDFanXg9gqN29jEA303HAA2yf5ThDyq2vN2hSu95VMDiSlGBoreBFk9TlSFbr0ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aj2cmgln; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a528243636so2739336f8f.3;
        Mon, 23 Jun 2025 10:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750701370; x=1751306170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qI3eQpnoFXgqAHTjXuxKxeTwCRPSlsi+V0f79JbjYk=;
        b=Aj2cmglnP3w6mju2JhNunB8fJ71xOT4bjyHExBX8tghGf8F7vRaR+5fftsFAEwsuE9
         2OXgy63pcr/uI9Xjtur5OTM2XUVl49dmHl7xQvy9HlCPlUOlrNuiBGO6Q1QEVvrLnLML
         mU2S3ahXoFIBUjmVPL5MxLWNlhk55i2hssKVSCicLwbkpxiF+Uz87Jab+I5MOI0kroUa
         WMueCfmzsfBmQnXB8WlL+ObMKKVgcu9VXHOXKwIS7NSBRnBPm7mf4hR7A0Om3KmzL/2t
         OdPEeDA7fuT0iizjzCiiKI2QpJs2uDanuN9yUB+gALtwTer0EbFbvMbS5dBZ4ioi1W2D
         P4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750701370; x=1751306170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qI3eQpnoFXgqAHTjXuxKxeTwCRPSlsi+V0f79JbjYk=;
        b=xOb9Y2+H2NjmWl1fhupgbs4XSdG6Y3wxlREcWOEwO+AQfVgSVE1u35Jc9SJe3Kvv80
         KfJ24kfR+rs40LvfYS3movI9MIqqti0qV9pL0pXI3rGzb2qJ6JijFrJCDWVHfZPb0ymP
         QSQjX90sTo0sbUMKh9mONSFxie8rJ49E3eLWpkcpHb0NZi2bVsRU/EUaiwY+KqDw1LtO
         iEuId/i8VpYlHw79lDu6knAPkZGnYDdx9pCiWznZnaw8Py5UW9WCOEhnaaccAjKOhndJ
         LMMJuiGxuVKoJJLwGDC50ymeUn+3c8LJ9fDYHh1GzVRhJdhP1evz5P6Dw6OQWkuf0IK7
         8s4g==
X-Forwarded-Encrypted: i=1; AJvYcCVYchBBFvvd7pXjif4sgugbNQsdYz6p4qBN+ydlIi3P+yj4s28hl8kEYQTLfDzBfAS8t/ib3gntZBFNmPMCwdI876de@vger.kernel.org, AJvYcCWroHWPyNk9bnrQPwN12S1lpNId/VlVvUYU3iH7XniaQimrtyIYYsDPV/4VGwQ0HxCxY4I=@vger.kernel.org, AJvYcCXpt+xD5d2tpfGAJjg9zgMNRq2MQtPUEXDDT853gxLXgMAQv8k2/TxcKAsXJ0F0lxTXWAD678QXZTDZQ7Jf@vger.kernel.org
X-Gm-Message-State: AOJu0YwvL53phCYzhNwNz/0xIYMcAprOiNF2RwNH8kHybKQFqVnZELLh
	neT1TfSrsSbwE/J8XqFGhh3xcHH6mzn9Mo6nqM/LFl12RRQfV8zdHoLkGKIYSzPspHHNSYMArJO
	Fj6DRXV3q2f7k4pdWXFqRf9FzR9XUYrVHDlJz
X-Gm-Gg: ASbGncvqqS9IsqEr3eQYOqucSFzBmonxSrf5RFC4rMQYxoETeEYKHJcQpfC8rQk+1Jl
	Bn2/IkY334xfaz9Yy1pVsfYvnQ9mVl6BumOk1odoMlP0+M8EuZaVcQ88H9o1teCJLrL5s846Ltn
	GY9J2SJJ4Zt0h+v+RpyxEKNxSAzRBLZC+Sb+oRpnHl1gl4VrROxttHzOZ/C0U=
X-Google-Smtp-Source: AGHT+IG7+ryO847wR7CflOrR7fWuOaAh5fPfjkLiXBZ+gM0i3/ba068W0Sr8nBSD7bw86Ok5rZYXfomI76o71YMKjGQ=
X-Received: by 2002:a05:6000:4021:b0:3a5:51a3:3a2 with SMTP id
 ffacd0b85a97d-3a6d12e62dcmr10839281f8f.45.1750701370270; Mon, 23 Jun 2025
 10:56:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623134342.227347-1-chen.dylane@linux.dev>
In-Reply-To: <20250623134342.227347-1-chen.dylane@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 23 Jun 2025 10:55:59 -0700
X-Gm-Features: Ac12FXwWaUNZMEbGmacMDUWjc5eSpDSNSUWSkn5pVat_WWvAYAeqbEYKvJtahIo
Message-ID: <CAADnVQ+aZw4-3Ab9nLWrZUg78sc-SXuEGYnPrdOChw8m9sRLvw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Show precise link_type for
 {uprobe,kprobe}_multi fdinfo
To: Tao Chen <chen.dylane@linux.dev>
Cc: KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 6:44=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> Alexei suggested, 'link_type' can be more precise and differentiate
> for human in fdinfo. In fact BPF_LINK_TYPE_KPROBE_MULTI includes
> kretprobe_multi type, the same as BPF_LINK_TYPE_UPROBE_MULTI, so we
> can show it more concretely.
>
> link_type:      kprobe_multi
> link_id:        1
> prog_tag:       d2b307e915f0dd37
> ...
> link_type:      kretprobe_multi
> link_id:        2
> prog_tag:       ab9ea0545870781d
> ...
> link_type:      uprobe_multi
> link_id:        9
> prog_tag:       e729f789e34a8eca
> ...
> link_type:      uretprobe_multi
> link_id:        10
> prog_tag:       7db356c03e61a4d4
>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  include/linux/trace_events.h | 10 ++++++++++
>  kernel/bpf/syscall.c         |  9 ++++++++-
>  kernel/trace/bpf_trace.c     | 28 ++++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+), 1 deletion(-)
>
> Change list:
>   v4 -> v5:
>     - Add patch1 to show precise link_type for
>       {uprobe,kprobe}_multi.(Alexei)
>     - patch2,3 just remove type field, which will be showed in
>       link_type
>   v4:
>   https://lore.kernel.org/bpf/20250619034257.70520-1-chen.dylane@linux.de=
v
>
>   v3 -> v4:
>     - use %pS to print func info.(Alexei)
>   v3:
>   https://lore.kernel.org/bpf/20250616130233.451439-1-chen.dylane@linux.d=
ev
>
>   v2 -> v3:
>     - show info in one line for multi events.(Jiri)
>   v2:
>   https://lore.kernel.org/bpf/20250615150514.418581-1-chen.dylane@linux.d=
ev
>
>   v1 -> v2:
>     - replace 'func_cnt' with 'uprobe_cnt'.(Andrii)
>     - print func name is more readable and security for kprobe_multi.(Ale=
xei)
>   v1:
>   https://lore.kernel.org/bpf/20250612115556.295103-1-chen.dylane@linux.d=
ev
>
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index fa9cf4292df..951c91babbc 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -780,6 +780,8 @@ int bpf_get_perf_event_info(const struct perf_event *=
event, u32 *prog_id,
>                             unsigned long *missed);
>  int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_=
prog *prog);
>  int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_=
prog *prog);
> +void bpf_kprobe_multi_link_type_show(const struct bpf_link *link, char *=
link_type, int len);
> +void bpf_uprobe_multi_link_type_show(const struct bpf_link *link, char *=
link_type, int len);
>  #else
>  static inline unsigned int trace_call_bpf(struct trace_event_call *call,=
 void *ctx)
>  {
> @@ -832,6 +834,14 @@ bpf_uprobe_multi_link_attach(const union bpf_attr *a=
ttr, struct bpf_prog *prog)
>  {
>         return -EOPNOTSUPP;
>  }
> +static inline void
> +bpf_kprobe_multi_link_type_show(const struct bpf_link *link, char *link_=
type, int len)
> +{
> +}
> +static inline void
> +bpf_uprobe_multi_link_type_show(const struct bpf_link *link, char *link_=
type, int len)
> +{
> +}
>  #endif
>
>  enum {
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 51ba1a7aa43..43b821b37bc 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3226,9 +3226,16 @@ static void bpf_link_show_fdinfo(struct seq_file *=
m, struct file *filp)
>         const struct bpf_prog *prog =3D link->prog;
>         enum bpf_link_type type =3D link->type;
>         char prog_tag[sizeof(prog->tag) * 2 + 1] =3D { };
> +       char link_type[64] =3D {};
>
>         if (type < ARRAY_SIZE(bpf_link_type_strs) && bpf_link_type_strs[t=
ype]) {
> -               seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[type=
]);
> +               if (link->type =3D=3D BPF_LINK_TYPE_KPROBE_MULTI)
> +                       bpf_kprobe_multi_link_type_show(link, link_type, =
sizeof(link_type));
> +               else if (link->type =3D=3D BPF_LINK_TYPE_UPROBE_MULTI)
> +                       bpf_uprobe_multi_link_type_show(link, link_type, =
sizeof(link_type));
> +               else
> +                       strscpy(link_type, bpf_link_type_strs[type], size=
of(link_type));
> +               seq_printf(m, "link_type:\t%s\n", link_type);

New callbacks just to print a string?
Let's find a different way.

How about moving 'flags' from bpf_[ku]probe_multi_link into bpf_link ?
(There is a 7 byte hole there anyway)
and checking flags inline.

Jiri, Andrii,

better ideas?

