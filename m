Return-Path: <bpf+bounces-42915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295C79ACF9D
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 18:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD254281C92
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 16:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045041CBE8F;
	Wed, 23 Oct 2024 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZiTuAjp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7B21C9DF9;
	Wed, 23 Oct 2024 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729699278; cv=none; b=jATjD7hVa0ZvTqRrp4aXrehf2teqN7jd6fuvwxQ8FOscykfqRsP4tfc+W68yrR5KLPOXYGbGQOC/z6CSui1b+jbEDfTVugdKPeXqstHbKXvwY9NA3W95tq6scvNtw0HQI90q+Awb6L5O1sRg5Ru+z92RSwO13R85rLHAHNpVbi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729699278; c=relaxed/simple;
	bh=Zb6Qmp1s5rtU9R/OULwvpV3AW/tgzdwsQY9D/IhK5/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lEU2IRDfsrN2PrY/k6MV6PL2PoQMGoS6wPtTPUg3JfuPySk7XD5uLiwiHDE7N2FCOYFSUtQ5oxoPoIn6aoUGNskDQHoWQStgnpB33dQc08gXnn90iFoITr9MJVCp2vUA07WbEM8NE85yhmCQsE629Ad8w6jld0kUY3kRzmCp8bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZiTuAjp; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e6d988ecfso5245579b3a.0;
        Wed, 23 Oct 2024 09:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729699276; x=1730304076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Thf9+FJVtqcrW/LzNPkTd9jnrUR7l8xiajzVExqKU5o=;
        b=LZiTuAjpb5F24ssIayOAsrBywrHIePIt3RGwY9e09H5Cw4qjAT4DuxrySb0ru4hIfH
         t22OOfkKBBAEkcuPK0zPmxuOK8U8gcaDw4skpd7LfQ/T3DVfMDzCpMcL9dctJSr6PgfR
         94MQ17Zl6AcNljD0vo8UCTHl4o0Vn0S48g49YSFVUQ9BSVIEm0w2zzJ/ShfUp6uiOCZ0
         PAho6+Jnu8Kp9fdwYYWiOwkFdlw3anEwuMKEOrL37yi+G1HrhKLG6U/rU69yRFDSKODy
         VwjDE4A3BPUUubWHPtPfqfVWjNY6rAQnmXWUDvwIzfyFftB8a5gJRn1FuWnJG+dI5jAl
         +zNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729699276; x=1730304076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Thf9+FJVtqcrW/LzNPkTd9jnrUR7l8xiajzVExqKU5o=;
        b=RHmVZPhyZJtzKTfNAtygQIPzFTILxPSrFObSPNs9mk2oDcEHF/jt16imQBxKDDyN6h
         pSagIPvDlulnvPgTatZx23qzrekZVx0eiXWvA5P/FPBwUC/GYTtn9iBCEUyxMfCQkQET
         YQiCWP+uP1ksmxsd9XlKgsBbyZ5HL9smDrX1SveqjtZsX7BqiBjLqZaqcCfHRPcBSu43
         xbwDcx2C7M8OVjszTAhUdVIhfgSOAll0R2r6ZOC0MiJ54JAvAqDlesIsl+MLQAxLR8XI
         p5vUEKQt4A/Ti8vPi99KtRO/g16rMrWU2ki5l84A5pG5fycj4MT/9m0QHmMpl2DjD0fu
         2LPg==
X-Forwarded-Encrypted: i=1; AJvYcCUJnBLJVBSewaUubmO63ssU5cUcGkSUoZUEMuyVJkLhzIwukYSGuLBUUKffgzMiqfyQKdpCflhKEg4qyr64AijxEw==@vger.kernel.org, AJvYcCULgAiE03zv9feGrGO/CzMKPXEpt/PTVU0DSY7yUv20kdYxmJSN8epu58uB0yv+owbQZ1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS7jn0eyM5weBGtgx6Xk7ctwLTNNPSJL+16jxue/jNb4tzpMro
	fgJwfDfxkGh/qRK/zzXmlKiIorllOepkPMH869NKrZnc6MgJXhQfRCktQczBjNHeMD7XteT22YT
	tWJdAoGZOOglxK1lWeLhWnW03Ba4=
X-Google-Smtp-Source: AGHT+IGj88yTf8u1so/Bm0JJL5mtSOckI73dfUg5YoUx6+5qgg4+x5D0ZTss6eeTExL8vLWGgg0NlLJ2xEXVul63sOY=
X-Received: by 2002:a05:6a00:148a:b0:71e:5f2c:c019 with SMTP id
 d2e1a72fcca58-72030a8a261mr4373559b3a.9.1729699275995; Wed, 23 Oct 2024
 09:01:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023100131.3400274-1-jolsa@kernel.org>
In-Reply-To: <20241023100131.3400274-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Oct 2024 09:01:02 -0700
Message-ID: <CAEf4BzbZdaPaspRAVP7=UcfpFzR4qhksJTRiEwiZ9RDQtdg0bQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf,perf: Fix perf_event_detach_bpf_prog error handling
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Sean Young <sean@mess.org>, Peter Zijlstra <peterz@infradead.org>, 
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 3:01=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Peter reported that perf_event_detach_bpf_prog might skip to release
> the bpf program for -ENOENT error from bpf_prog_array_copy.
>
> This can't happen because bpf program is stored in perf event and is
> detached and released only when perf event is freed.
>
> Let's make it obvious and add WARN_ON_ONCE on the -ENOENT check and
> make sure the bpf program is released in any case.
>
> Cc: Sean Young <sean@mess.org>
> Fixes: 170a7e3ea070 ("bpf: bpf_prog_array_copy() should return -ENOENT if=
 exclude_prog not found")
> Closes: https://lore.kernel.org/lkml/20241022111638.GC16066@noisy.program=
ming.kicks-ass.net/
> Reported-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/trace/bpf_trace.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 95b6b3b16bac..2c064ba7b0bd 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2216,8 +2216,8 @@ void perf_event_detach_bpf_prog(struct perf_event *=
event)
>
>         old_array =3D bpf_event_rcu_dereference(event->tp_event->prog_arr=
ay);
>         ret =3D bpf_prog_array_copy(old_array, event->prog, NULL, 0, &new=
_array);
> -       if (ret =3D=3D -ENOENT)
> -               goto unlock;
> +       if (WARN_ON_ONCE(ret =3D=3D -ENOENT))
> +               goto put;
>         if (ret < 0) {
>                 bpf_prog_array_delete_safe(old_array, event->prog);

seeing

if (ret < 0)
    bpf_prog_array_delete_safe(old_array, event->prog);

I think neither ret =3D=3D -ENOENT nor WARN_ON_ONCE is necessary,  tbh. So
now I feel like just dropping WARN_ON_ONCE() is better.

>         } else {
> @@ -2225,6 +2225,7 @@ void perf_event_detach_bpf_prog(struct perf_event *=
event)
>                 bpf_prog_array_free_sleepable(old_array);
>         }
>
> +put:
>         bpf_prog_put(event->prog);
>         event->prog =3D NULL;
>
> --
> 2.46.2
>

