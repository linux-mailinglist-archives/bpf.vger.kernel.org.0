Return-Path: <bpf+bounces-66042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A1CB2CE4A
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 22:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 384891BC8214
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 20:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51727246BB3;
	Tue, 19 Aug 2025 20:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbgHNHXY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6CE34321E
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 20:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755636678; cv=none; b=O4LhYtIgCqtHVUsp9Z8957G6UEN5oFem7bcaAeCg/qctAqS4afzTcThwicspRCiv6Q8vk/bKJrBPOGmqIBYcmxeymbVDxH77rFk67KuG3pedXWUfETR0F3357n6ShLSRMTmSTTTesMtPz9YlgiTTczSJ41a9bvegb9GSc/bqL7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755636678; c=relaxed/simple;
	bh=Qr/2ldeSWhw5vU5sQVQApF7M097yUzhZMzDmNUefcLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AW3q7L7r4jo/UAu3vMrmRJD5TWhoklpzWStIoO3KeBmlK5JJiIc5GMD0COCAjvcB2ChP1t+bMuUR2Oao4RspxAo6dEbpMDWKmIEpoyhjmQfjqpUb8WljZh13RjnhLQ3LqZoVvX6LsPkMrnskhK8C0abBxit7SzCHvCkTMCGKmM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbgHNHXY; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32326e20aadso6542162a91.2
        for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 13:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755636676; x=1756241476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ma0UGZB9wi0PGfA8CUS0xUeCMM2kwHmneSNtxrqCjCs=;
        b=VbgHNHXYTor8uDMYmEKS9uu4rjZRJ4BROISubv6Wjros3OCrynZeXP3pxoMrUtPvoC
         edx5x41C9zFjGVp/Bz66t281AV7H2QJtIRdpUtfHHPylAC/8jFRWopBhVR7NnpdlHNb9
         0QQdYxqTItFZmuM8PvIfEbh1Z3XBTE9AO+AOvygBlDVeZmR/bLQF/fL3ZRX9JEADOa7Y
         YoAasM47mUPF/rN+Qw3/h80Zn40m1PxGkEQw5QCNNdmWDbGdRkD9rPjaNUuz4VF4KV8k
         +1asULhtLVdFF3E9CaAim7+w+D63YRJoNNoYkcXMigG55t/4pWFB1Zj87sAtO4Qjizxa
         +H+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755636676; x=1756241476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ma0UGZB9wi0PGfA8CUS0xUeCMM2kwHmneSNtxrqCjCs=;
        b=c6pvJaOFo4lNwXvRxSGHBI7x7SnzbNy1A7GtK8GE2iobxv5xMA/KR2r4aneKyYeg9Y
         vSLnRERnYsZJxmYfhEqd25wPSGbspiv58+kynz5PrMN/Ecu/2niiqZhD3Nsx4od4P7+k
         JI8GSyOUx5OFVZVnaL5B7ODKO0hwhb3XJcTxxoa/IUQXKKcsTezAemKzYBkAeFdHNER/
         ewQ1+Ytq2pmDMXftMGluQr87/aaIqYTgXQGMPr4+Kz5LjN4b+cYDPoWRtnihXfsc/hMN
         2sleRnzIvY9QxN0Jlbx/KzznBFi3X96P2zyoqZ4dnfu44gW3YpyP2lrNZohp5njmrwMf
         elRA==
X-Gm-Message-State: AOJu0YzwBTm8cG69Qhdxic4j0I+KIJ3olWherasPVqO+ZWZ5lz8dM+Gw
	YYFf66oRqvqpyjmZHHTZ+JbC4gui3PQOKTnda8QU0Y0ZoIILnpHfDc6jIjI0NmhN25Mk6V55to+
	kQYwX21a/2TP8u2cX07mKYE71DTS51pc=
X-Gm-Gg: ASbGncs9Ba5+XitF1i97NpHI7KVF7CfrgRPjEWfaTtdJurnFyfxwQkygh9RYYs6fw/A
	Goy4RHFFZ+VQM1umW3Hy9eKlB9o11dh2ByofcNBAfMSkFRioGK569x2dozRl3xM5fGsGTt3bO5L
	KYLw1w0XXPcfVHTCn/D4yBuIA0e+lsg4osGf9YueSYdUefnB/vaN8P0gumrpAPzUHwDMM97wgqc
	YOD9O7t37zs3vo/NdyW7sPgbR0ps0Jx2A==
X-Google-Smtp-Source: AGHT+IHopnbNy1LzGVDWwp5RE+yAHj8r7YWlPjvoC7oV2sU9uXkCMlYdCdFrJqiehe4nZGGGp6L74qWl5gf8g6PGkgU=
X-Received: by 2002:a17:90b:1ccd:b0:31f:104f:e4b1 with SMTP id
 98e67ed59e1d1-324e131c059mr676367a91.7.1755636675772; Tue, 19 Aug 2025
 13:51:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815192156.272445-1-mykyta.yatsenko5@gmail.com> <20250815192156.272445-3-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250815192156.272445-3-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Aug 2025 13:50:59 -0700
X-Gm-Features: Ac12FXz9UoRIwsYON5322KyaLNUyL3jP1rIrLMNQJQUfFfK4XD1qM8h78hnV9fo
Message-ID: <CAEf4BzaDdKFH4J10D+t74QWCJpPNvaumXTeMFd5Y7Y3SU=-0mw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] bpf: extract map key pointer calculation
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 12:22=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Calculation of the BPF map key, given the pointer to a value is
> duplicated in a couple of places in helpers already, in the next patch
> another use case is introduced as well.
> This patch extracts that functionality into a separate function.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/helpers.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 144877df6d02..d2f88a9bc47b 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1084,6 +1084,17 @@ const struct bpf_func_proto bpf_snprintf_proto =3D=
 {
>         .arg5_type      =3D ARG_CONST_SIZE_OR_ZERO,
>  };
>
> +static void *map_key_from_value(struct bpf_map *map, void *value, u32 *a=
rr_idx)
> +{
> +       if (map->map_type =3D=3D BPF_MAP_TYPE_ARRAY) {
> +               struct bpf_array *array =3D container_of(map, struct bpf_=
array, map);
> +
> +               *arr_idx =3D ((char *)value - array->value) / array->elem=
_size;
> +               return arr_idx;
> +       }

should we add BUG here if map is not hash or lru?


> +       return (void *)value - round_up(map->key_size, 8);
> +}
> +
>  struct bpf_async_cb {
>         struct bpf_map *map;
>         struct bpf_prog *prog;
> @@ -1166,15 +1177,8 @@ static enum hrtimer_restart bpf_timer_cb(struct hr=
timer *hrtimer)
>          * bpf_map_delete_elem() on the same timer.
>          */
>         this_cpu_write(hrtimer_running, t);
> -       if (map->map_type =3D=3D BPF_MAP_TYPE_ARRAY) {
> -               struct bpf_array *array =3D container_of(map, struct bpf_=
array, map);
>
> -               /* compute the key */
> -               idx =3D ((char *)value - array->value) / array->elem_size=
;
> -               key =3D &idx;
> -       } else { /* hash or lru */
> -               key =3D value - round_up(map->key_size, 8);
> -       }
> +       key =3D map_key_from_value(map, value, &idx);
>
>         callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, =
0);
>         /* The verifier checked that return value is zero. */
> @@ -1200,15 +1204,7 @@ static void bpf_wq_work(struct work_struct *work)
>         if (!callback_fn)
>                 return;
>
> -       if (map->map_type =3D=3D BPF_MAP_TYPE_ARRAY) {
> -               struct bpf_array *array =3D container_of(map, struct bpf_=
array, map);
> -
> -               /* compute the key */
> -               idx =3D ((char *)value - array->value) / array->elem_size=
;
> -               key =3D &idx;
> -       } else { /* hash or lru */
> -               key =3D value - round_up(map->key_size, 8);
> -       }
> +       key =3D map_key_from_value(map, value, &idx);
>
>          rcu_read_lock_trace();
>          migrate_disable();
> --
> 2.50.1
>

