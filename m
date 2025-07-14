Return-Path: <bpf+bounces-63265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECD9B04A0A
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 00:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAE917AEEB7
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 22:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E4227603C;
	Mon, 14 Jul 2025 22:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJKfHh1q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB80224679C;
	Mon, 14 Jul 2025 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752530866; cv=none; b=jgGU+sRoUv73MuLNtA6EzC2iWqplFyV2h0/+/Sl0sOOTI3E9sntRJuczgK+fdxV1CdAP9dP0OTZb8AYhgG8cyxU8EvSqIgH0oDHgPgxxgHGu+BpG6E32T7OGPucs1E355JNwdzGsHu1ZHCp9vPybRVqj/Ng2bpk+xbH/eEU0Vu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752530866; c=relaxed/simple;
	bh=YZ6ORRsXxMBwaTa2eyIymdH4I0yWt6FNj75Oc5MNk0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzVeIFlvQpLQ+Oz3+oKhU49ACMPPuahDYkgnl99kFTssSLGwH01/S35DtZpOiJ2t+NiqEty09w88RFFij1HKh3pYxvRTSqFKQyDcUwdQKAMWr+8xyUkHrwYi7laiRcKRMbEvP/H+HbmxBrFyiVnQsppjbsgrdvQbyZZ+eDglQB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJKfHh1q; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-235e1d710d8so62001965ad.1;
        Mon, 14 Jul 2025 15:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752530864; x=1753135664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTM+lG2n/POmab/g9zATtrLMzbbUFyYb3LsQj+6epJQ=;
        b=XJKfHh1qiRvhTp6tMeeMGphPinWiFgVsf8m2Hz4BeBdPBj+bi2ja++1xxpIEcsipOH
         BHbb3Z17e8AarhXNvMlb9MrtWl08pmTQWErfNIrmnpqA3/rc8/FPY2q0N6QtCY4Z2Xyd
         vLguZIA8PZyaPoPaQdYK/vwVviL5PrwPKHh7Lzo7jA6XdLtqpH/fPd58e4SGCgnuZKFD
         3w9EAT6el1LZ+1V/64adRGp/AU+uXLZ/ASxSJUETkIrFGfUxLj7SxvGq9Zi2JMhZ2ImH
         jubTOIX6PVcCsZQ6j+TKanKfvVOGTT9bhLm9eQ1kTKBQa+vF7oJhFCG7A9lwaiHM9NTq
         y1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752530864; x=1753135664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTM+lG2n/POmab/g9zATtrLMzbbUFyYb3LsQj+6epJQ=;
        b=FI3WH74Q34i5CUPMLfiAOXhl5r1ZJgIt1TuROQtrw0nprLSzKLLX2wCkr2VsSDnb49
         ptWRMQXIqnnOwV+cKx8CgE1reMiiLWTThH3Oqv6oawNPc56s+5vFoW9lpwAVguo0IsGu
         wZkKShAlB9snlarNChGBzsaSNj+QjRi6IMyjAqhj1KYix2THzpvU217xsCMSpP78XR2L
         nudtzch08fDD1bXQW09Iqhomr+1pRhgsAUAfEbdg9IhGOZnlhPC44RP8h+jMPC84Mier
         NJVtrQ0OR8vBTiIZ1v1NbxMb7ponGerzL6wAjzKa7NZ73tGFn2eA7888rFTH7yZiCzYl
         RPcA==
X-Forwarded-Encrypted: i=1; AJvYcCVc9Mj+j+k5KDcHWTi5q8PSQyMhYn2kRFNn2k2gHwz+X5RfqI+V3jg2B1k5rawY3qF3Pd8=@vger.kernel.org, AJvYcCXZfyQzrnS8gorjNfiCJ5BZ+iE3OSNhgOJHleLoyqkEc1W9O4b4gG3ooRtsibc+aBU7y4/iKZAIw9K/kg7d@vger.kernel.org
X-Gm-Message-State: AOJu0YzjEzYbgfdNNEjQfuTFKP0F9eDch3fua/WIoWf9aSQ/+wgc6EGE
	4860/whpS7NBsVxytr7GF/Kppgvs9G8Hh5gysYWN1jnQ4MDfj220CHTP+zENmgXd+sI9J0/jXFH
	jFQj+PHgWAr+muscsUnx3DLLpdMUnAHo=
X-Gm-Gg: ASbGnctdgr8nQ/37Z5kdH3LE4KS3lZ38dsuXG0uELatcsyKa06iocMaYT4gCCYtewHL
	LkiO6TwLo69MA6HiBYwr9kU6AXk5DMzoI6MyLNdNYYuP8/Wn9m3LOiwBj8nirx1c33XI2JM26rN
	U3PGX+CE6U1Zs6y5ioczwagWQSrvIzk5FqD9m9Ss8EQlyR/0z6PgeVKTRWXYVG7aBdJ79QlOJqS
	kylQ35INFiYWJzVDTMQU8IbBwdSwlXEOw==
X-Google-Smtp-Source: AGHT+IGCAI3WsaKrvbP0XPcSqUikJ1y4aczvcddofFadfhV5LLIKsz7EAmdRsN7e+kelD3QzRfM4FmFsBAHVbw6BRAI=
X-Received: by 2002:a17:903:2b0b:b0:23c:863d:2989 with SMTP id
 d9443c01a7336-23dede2cc82mr219378625ad.3.1752530863831; Mon, 14 Jul 2025
 15:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn> <20250703121521.1874196-13-dongml2@chinatelecom.cn>
In-Reply-To: <20250703121521.1874196-13-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 14 Jul 2025 15:07:27 -0700
X-Gm-Features: Ac12FXx0Mn5RaT5uFnPxZhR3zZiVVAuzO2W7eg7Gxs62ckeAP-kmHA1DTxhtW0Y
Message-ID: <CAEf4Bza9mRvjwXU5gbOmOg_Ns=5OAX7-ybE=_wh79i7dwL=ZEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 12/18] libbpf: don't free btf if tracing_multi
 progs existing
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: alexei.starovoitov@gmail.com, rostedt@goodmis.org, jolsa@kernel.org, 
	bpf@vger.kernel.org, Menglong Dong <dongml2@chinatelecom.cn>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 5:21=E2=80=AFAM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> By default, the kernel btf that we load during loading program will be
> freed after the programs are loaded in bpf_object_load(). However, we
> still need to use these btf for tracing of multi-link during attaching.
> Therefore, we don't free the btfs until the bpf object is closed if any
> bpf programs of the type multi-link tracing exist.
>
> Meanwhile, introduce the new api bpf_object__free_btf() to manually free
> the btfs after attaching.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  tools/lib/bpf/libbpf.c   | 24 +++++++++++++++++++++++-
>  tools/lib/bpf/libbpf.h   |  2 ++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index aee36402f0a3..530c29f2f5fc 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8583,6 +8583,28 @@ static void bpf_object_post_load_cleanup(struct bp=
f_object *obj)
>         obj->btf_vmlinux =3D NULL;
>  }
>
> +void bpf_object__free_btfs(struct bpf_object *obj)

let's not add this as a new API. We'll keep BTF fds open, if
necessary, but not (yet) give user full control of when those FDs will
be closed, I'm not convinced yet we need that much user control over
this


> +{
> +       if (!obj->btf_vmlinux || obj->state !=3D OBJ_LOADED)
> +               return;
> +
> +       bpf_object_post_load_cleanup(obj);
> +}
> +
> +static void bpf_object_early_free_btf(struct bpf_object *obj)
> +{
> +       struct bpf_program *prog;
> +
> +       bpf_object__for_each_program(prog, obj) {
> +               if (prog->expected_attach_type =3D=3D BPF_TRACE_FENTRY_MU=
LTI ||
> +                   prog->expected_attach_type =3D=3D BPF_TRACE_FEXIT_MUL=
TI ||
> +                   prog->expected_attach_type =3D=3D BPF_MODIFY_RETURN_M=
ULTI)
> +                       return;
> +       }
> +
> +       bpf_object_post_load_cleanup(obj);
> +}
> +
>  static int bpf_object_prepare(struct bpf_object *obj, const char *target=
_btf_path)
>  {
>         int err;
> @@ -8654,7 +8676,7 @@ static int bpf_object_load(struct bpf_object *obj, =
int extra_log_level, const ch
>                         err =3D bpf_gen__finish(obj->gen_loader, obj->nr_=
programs, obj->nr_maps);
>         }
>
> -       bpf_object_post_load_cleanup(obj);
> +       bpf_object_early_free_btf(obj);
>         obj->state =3D OBJ_LOADED; /* doesn't matter if successfully or n=
ot */
>
>         if (err) {
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index d1cf813a057b..7cc810aa7967 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -323,6 +323,8 @@ LIBBPF_API struct bpf_program *
>  bpf_object__find_program_by_name(const struct bpf_object *obj,
>                                  const char *name);
>
> +LIBBPF_API void bpf_object__free_btfs(struct bpf_object *obj);
> +
>  LIBBPF_API int
>  libbpf_prog_type_by_name(const char *name, enum bpf_prog_type *prog_type=
,
>                          enum bpf_attach_type *expected_attach_type);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index c7fc0bde5648..4a0c993221a5 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -444,4 +444,5 @@ LIBBPF_1.6.0 {
>                 bpf_program__line_info_cnt;
>                 btf__add_decl_attr;
>                 btf__add_type_attr;
> +               bpf_object__free_btfs;
>  } LIBBPF_1.5.0;
> --
> 2.39.5
>
>

