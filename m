Return-Path: <bpf+bounces-36953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2088194F91D
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 23:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44AAA1C2110A
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 21:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129BD194AE6;
	Mon, 12 Aug 2024 21:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5dmvrOV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8CE170A0F;
	Mon, 12 Aug 2024 21:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723499353; cv=none; b=jvc/QP1J5+8eLUbv0E3qaPP5KcQ5wbbw8poCjrhnIP8Pwh9AovIYy8n+u7iYiWKjzwAcxwxWgBnCXcUd4k970I4eI250TetfLo8oFYgWW/CWBulQyGD8toJtqUI8Lmh87vDo+IF5HEK6huM3+37d8GE3nujmqyyuogJ+mwIZRxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723499353; c=relaxed/simple;
	bh=9uVulOEMr9LodJCHTYEdKXXyHout8mwRFuQN+Zhom1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vq6ic4/Zjko+h4RQz8himtWOaXUVTOwit5WFAZjn6ukD0umtr83N/AxdTzWwvcW/sfTtHDTxIBSD+ZZpGOx2qM+qh8cBJqoBV4AaAkq+p0sYPMIg4YphXA2btZ4RpYNTADBSJxP6J575QxQs+sj56bgL4zRTlMA/co8OgS0rihU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5dmvrOV; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cdadce1a57so3745678a91.2;
        Mon, 12 Aug 2024 14:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723499351; x=1724104151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiqUCLx0Px9nEA6ezZXCyC9UdSf8Ot8v0J1DWNyXIA8=;
        b=S5dmvrOVAS1F3HCC5KISdaWhT6El1rhBt1rUf0JGp5p3aM2nH3Lg7fyRgB4lWQaEuQ
         wvLt5iE7ANZBc67eUPz/aFhK/8P6SjCU1x79hZvqg6PrBAGmSoE4AczGvQ6SceYsSYlF
         7maQcYUZHazWC9zEwgr5dvQNez+GprHXX9jqy3kjkY4tBO6F1aGUoLIJ792uTpzwzQmB
         q3GzkMEB8VHBogygVIKhCirlbAdxGePo8tJ7A7FFgvdZ0Bwx0ZesL5hjl4znRArAYkEJ
         1k7GrMUcFk+8Ym/MkgQIGY97l7+g90d7Ad79Uw6bvw+5jDEdYvot1NZp7dnLacwXVdPg
         r5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723499351; x=1724104151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LiqUCLx0Px9nEA6ezZXCyC9UdSf8Ot8v0J1DWNyXIA8=;
        b=jMze2NfIDY56bbCpL/VwamlPnimjSY4f655W1SDbLwN9+yXK2bhuHHXkOHCD3OWi6A
         VxOmk5nhyIHJNAF2IQ0Kae61aHbqoKh6kr3VQNpduUQVMueHzFJPL6bKl6Kj57i8n9n7
         bAXKcvZul73R9W7cycZvt40xw9envGRCtoEMrJLR7VCOxBLD/ny4k11XPrqLk0sThBPk
         aF/7bXfJ9MZNQuOc4EbjGW59gH2uGNzvMDIROLEAOdtZ0JEiuoNNxO8UMaPBECU7a5cL
         RoN1gWEoYoNsoBYe6jmURCBhOXdT8VsQJ++Jfg/nkNGdvJRGpYbvyVSh3uraDXQxFhTm
         ZINw==
X-Forwarded-Encrypted: i=1; AJvYcCW+8Z0fUeA/0tEfr0wN1XJc3AEQ0nLE/vTCWB8yNPHDAjwcQT/hurY0nyYJPQLswTv1/qqu1NKGWOw1Zru4GpNVVRZz0yLkFA4JMzsJ0iHsVDJ00PvITr12eO/0QglWqqckJTg/vEFxKqpBXmq78cbLWyO1FtgnMrey2GLjpnxM2Ebf32Xk
X-Gm-Message-State: AOJu0YxULxcerOgALIWL7skuvsWfgx3WVTeaWgZCy8AP8duWAKcICymW
	iOM9Z13DzwIzjFQ2lptufxbVo2UK4cVDbqOBztKo/9tn646MsZohH5OIcDJ3XFkTiDdCRS61T4c
	XkLqAdZl0PxyuhMs5lwTAab8MSVU=
X-Google-Smtp-Source: AGHT+IERh+nGlSMxB2vmGQvEm5TMoeATPxY/+oKBXTHHMWVbIopfiaW0TqWgMQZXDsGcI1qwG70rpZ831Zplc79lJbY=
X-Received: by 2002:a17:90b:4c12:b0:2c8:538d:95b7 with SMTP id
 98e67ed59e1d1-2d39263415fmr1690708a91.32.1723499351336; Mon, 12 Aug 2024
 14:49:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725001411.39614-1-technoboy85@gmail.com> <20240725001411.39614-2-technoboy85@gmail.com>
 <CAFnufp1jxnjL2apUwxWKkNzS5QKpDXYTWPnVLn-VQyZazFujCg@mail.gmail.com>
In-Reply-To: <CAFnufp1jxnjL2apUwxWKkNzS5QKpDXYTWPnVLn-VQyZazFujCg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Aug 2024 14:48:59 -0700
Message-ID: <CAEf4BzZCxtUV66LG_1F_v7iFm=_1X-Hs9i9houEvMiQW=hdOTA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: enable generic kfuncs for
 BPF_CGROUP_* programs
To: Matteo Croce <technoboy85@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matteo Croce <teknoraver@meta.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 9:49=E2=80=AFAM Matteo Croce <technoboy85@gmail.com=
> wrote:
>
> Il giorno gio 25 lug 2024 alle ore 02:14 <technoboy85@gmail.com> ha scrit=
to:
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -3052,6 +3052,12 @@ static int __init kfunc_init(void)
> >         ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &ge=
neric_kfunc_set);
> >         ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_O=
PS, &generic_kfunc_set);
> >         ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,=
 &generic_kfunc_set);
> > +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_S=
KB, &generic_kfunc_set);
> > +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_S=
OCK, &generic_kfunc_set);
> > +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_D=
EVICE, &generic_kfunc_set);
> > +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_S=
OCK_ADDR, &generic_kfunc_set);
> > +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_S=
YSCTL, &generic_kfunc_set);
> > +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_S=
OCKOPT, &generic_kfunc_set);
> >         ret =3D ret ?: register_btf_id_dtor_kfuncs(generic_dtors,
> >                                                   ARRAY_SIZE(generic_dt=
ors),
> >                                                   THIS_MODULE);
>
> This seems not enough, some kfuncs like bpf_cgroup_from_id are still reje=
cted.
> To fix this we need also this chunk:
>
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8309,7 +8319,11 @@ static int bpf_prog_type_to_kfunc_hook(enum
> bpf_prog_type prog_type)
>         case BPF_PROG_TYPE_SYSCALL:
>                 return BTF_KFUNC_HOOK_SYSCALL;
>         case BPF_PROG_TYPE_CGROUP_SKB:
> +       case BPF_PROG_TYPE_CGROUP_SOCK:
> +       case BPF_PROG_TYPE_CGROUP_DEVICE:
>         case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
> +       case BPF_PROG_TYPE_CGROUP_SYSCTL:
> +       case BPF_PROG_TYPE_CGROUP_SOCKOPT:
>                 return BTF_KFUNC_HOOK_CGROUP_SKB;
>         case BPF_PROG_TYPE_SCHED_ACT:
>                 return BTF_KFUNC_HOOK_SCHED_ACT;
>
> but even with this it won't work, because
> bpf_prog_type_to_kfunc_hook() aliases many program types with a single
> hook, and btf_kfunc_id_set_contains() will fail to check if the kfunc
> is in the set.
>
> One solution could be to extend the btf_kfunc_hook enum with an entry
> for every CGROUP program type, but a thing I wanted to avoid is to let
> this enum proliferate in this way.
> I wish to group all the CGROUP_ program types into a single hook, and
> perhaps drop the "SKB" in "BTF_KFUNC_HOOK_CGROUP_SKB" which will have
> no meaning anymore.
>
> Ideas?

Given BPF_PROG_TYPE_CGROUP_SKB and BPF_PROG_TYPE_CGROUP_SOCK_ADDR are
already grouped into the same hook type, and
bpf_sock_addr_set_sun_path() is meant to be enabled for
BPF_PROG_TYPE_CGROUP_SOCK_ADDR (but really it's enabled for
BPF_PROG_TYPE_CGROUP_SKB as well), I guess it's fine to just have one
CGROUP hook type for all those cgroup-related program types and just
rely on BTF type matching logic.

I'd say that register_btf_kfunc_id_set() should just accept enum
bpf_kfunc_hook instead of enum bpf_prog_type (I don't see where we
remember or use prog_type beyond just translating that to
bpf_kfunc_hook), but that can be left for follow up clean ups.

>
> --
> Matteo Croce
>
> perl -e 'for($t=3D0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay

