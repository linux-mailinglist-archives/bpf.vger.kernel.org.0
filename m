Return-Path: <bpf+bounces-67759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF5DB49743
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EDF1179EBE
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 17:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EFE314A9F;
	Mon,  8 Sep 2025 17:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDvYYktB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269811F0E58
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352924; cv=none; b=d+ErSLph4mNPOqK6o1ijYS4cIOjkTs5uUsuSi2EjQs4b/q3RBgOT5EGBTCkE0LKCrTOHyRRYST+sMU7/l1/N9Yip4CmgLf2m9Z1c3YP2woXAITCbOU0TxNFEfl6cVhS27HYheu+/GvwXyLGm3n6NZSVIxywc9zl5r96bj69Dw9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352924; c=relaxed/simple;
	bh=4tfFdcm5eSUJFpeer0Sbj+8SWh3eWbjQW537e2UioWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bOFc0WV4KBnQkzLQ4uSX54CV66WZq9qO3RlazSYNBfOP1ts/xfF1RPQOXgBTPrI49ehkohFrvt1Z617mCpVz8HG+OAvbDWglR81s1qWuhAzINuGbcFIHO16faXCSVkOr6NH0ba9Q8JGrnZPR5zQuLmTMrjQRg+tYDJSYc2tkvcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDvYYktB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45decc9e83eso879015e9.3
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 10:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757352921; x=1757957721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8LJyieb2TXLYNgMBSTfipj7w1t+I2tbKypPhIFeBxE=;
        b=nDvYYktBhu/jezgA7Ps4YvriT63aYtMc2QvyYPfcUOnqcHYPv5Yr0rw82QvjYd3eK9
         UShXM64dG7kAbP3U1lEI6nExjLgoq9VwsTyUBrJaJ1AGTuJDTh3q0z/NswuL5rB2ekwh
         WViizSYpvktXk9Wj0xxOpC5sAopP5zvdbdtuGNsANP31OJqSGtO3byhoyCsdWA2yYHT2
         8z9MM9JtV0emGiqzswXe7muGOI9XalYxO8jEnCU+0EyF30RyymQdA3kD0AnPC/Q/jDVL
         mMcr3/YxN1IRHEOQmxDkraWCrmpDrZjITUqLbvthmioaZ8SGLqloH1yHkOZn+7XhgKvS
         Kwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757352921; x=1757957721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8LJyieb2TXLYNgMBSTfipj7w1t+I2tbKypPhIFeBxE=;
        b=Dr3wHitAovgztJyaQgZ9USNus9hFmPtsJUduw2mIZ7jXmKEXaZ10rq0cAELJk6XzR6
         DR0dEdb0ugcldge2GxshIk9LtOnUQqaYiT4S/KPIJb8oCzQmpMhuGWim13+rQ/5zZuqB
         DtL+3VYswl3iEs7hHVGKxnKE9jLeoM9nMgGSRXJbYBJV5dvq4eZAgCa1/CMJGx9hBcrH
         7QIZmibtKYmsCXnX4krRarq77B41kjddXBBRlsPKHn+p2reaAk+5DT4JJDdmj4xZJ3Uf
         BHQqDcELuTdQDD4/4kxfQQcit2EVaYP8MDD1pK9NXDqsd8eFERZyWk5XVZeV8BQfQ1kH
         7L6Q==
X-Gm-Message-State: AOJu0Yx0PIpnM0eJ61KiEWW7zKVskEK3fdCZqcvLlvvJF1HXsNh2swU2
	QCvOX3xX76UG2hFcwCpWj0uwOFQTsIF/j3ZRv1vdvsUzYKjMpElucHBv9IZq1xYMQeTOujRDNr8
	JTALoalx76yuEf3VyK/T41szXUJa5gSiWiA==
X-Gm-Gg: ASbGncuQZMm2dhaD0TypdeoDgs72cHX3UDcjFIbE47pWPYSRABX5eEQhhhMHJmNfdpR
	JZEzHECfS/AGmru5cpXC2RYPsbdFd0vQoq5Nm9lj/k5HAObb4zN3ggQGyVsQVJ+vy9Eb9rfJsQb
	1w5iTrkiFpD+0HFIrZjr7MjVNzdQBiLTWsibEqaWjsDV+HScr0oT6VguhwDUdfKRVIQRBgX8cQJ
	eO40F+ULJV7qwnRasC0sU6oqjm+RGTacIUYDpl5oRfV0b8=
X-Google-Smtp-Source: AGHT+IHEu9ST9ieexhVzJqhO9oBDvcnUSpBSyRvXGF50+6Q8mQzzU/bXbOhSaeOpm+JgO6uVCD9v5TbZdcCqkcu+Cyo=
X-Received: by 2002:a05:6000:3103:b0:3dc:2912:15c0 with SMTP id
 ffacd0b85a97d-3e636d8f8e9mr8196580f8f.1.1757352921417; Mon, 08 Sep 2025
 10:35:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908143644.30993-1-leon.hwang@linux.dev> <20250908143644.30993-2-leon.hwang@linux.dev>
In-Reply-To: <20250908143644.30993-2-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Sep 2025 10:35:10 -0700
X-Gm-Features: AS18NWDn889uJ4sOz0oSATEQ3NMwfSji7SEoa1meg1Vf0wc8tVVKNgxBS2u4Idg
Message-ID: <CAADnVQLSYy6FNrgX82GPFypwm-LCqGs31QfzoXC=Yunhov-cyQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/9] bpf: Generalize data copying for percpu maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Daniel Xu <dxu@dxuuu.xyz>, =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 7:37=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> Refactor the data copying logic of the following percpu map types:
>
> * percpu_array
> * percpu_hash
> * lru_percpu_hash
> * percpu_cgroup_storage
>
> by introducing two helpers:
>
> * 'bpf_percpu_copy_data()'
> * 'bpf_percpu_update_data()'
>
> It is to introduce BPF_F_CPU and BPF_F_ALL_CPUS flags for these percpu
> maps with less code churn.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h        | 28 +++++++++++++++++++++++++++-
>  kernel/bpf/arraymap.c      | 14 ++------------
>  kernel/bpf/hashtab.c       | 27 ++++-----------------------
>  kernel/bpf/local_storage.c | 18 ++++++------------
>  4 files changed, 39 insertions(+), 48 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 8f6e87f0f3a89..ce523a49dc20c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -547,6 +547,33 @@ static inline void copy_map_value_long(struct bpf_ma=
p *map, void *dst, void *src
>         bpf_obj_memcpy(map->record, dst, src, map->value_size, true);
>  }
>
> +#ifdef CONFIG_BPF_SYSCALL
> +static inline void bpf_percpu_copy_data(struct bpf_map *map, void __perc=
pu *pptr, void *value,
> +                                       u32 size)
> +{
> +       int cpu, off =3D 0;
> +
> +       for_each_possible_cpu(cpu) {
> +               copy_map_value_long(map, value + off, per_cpu_ptr(pptr, c=
pu));
> +               off +=3D size;
> +       }
> +}

..

> @@ -313,11 +312,7 @@ int bpf_percpu_array_copy(struct bpf_map *map, void =
*key, void *value)
>         size =3D array->elem_size;
>         rcu_read_lock();
>         pptr =3D array->pptrs[index & array->index_mask];
> -       for_each_possible_cpu(cpu) {
> -               copy_map_value_long(map, value + off, per_cpu_ptr(pptr, c=
pu));
> -               check_and_init_map_value(map, value + off);
> -               off +=3D size;
> -       }
> +       bpf_percpu_copy_data(map, pptr, value, size);

Same issue as before. This is not equivalent.
Stop this "refactoring".

pw-bot: cr

