Return-Path: <bpf+bounces-74324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F250C54363
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 20:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 06A8134B6C4
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 19:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC4F3538A0;
	Wed, 12 Nov 2025 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fj7x8n/e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA68E27B34E
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976138; cv=none; b=rtvwI4KViU37uo+SdGsBwDdVzCXyPT9G3JRdWw8ObJDepB0JdH53l/9qe/noxPRtfgyYTiJ7nfVLJ26XMP/YgNRCh+AM1Fe+dmOBI2Pxx7o/kpEW31ZgRudK7xl83LR/SFyGa8119FnEVeYPZoZ6lqK9p1klhrATp9tRGrQGegk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976138; c=relaxed/simple;
	bh=u3vP+1V++RPcKeq861ABhRpvKQacT/dp6yqLD0pJfU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPPehrQNUc8DLf+kyIQCPONIraAiBJ1HXG1L8TG1ENQZeueoJHE2DKqONn8EYSswStOi4voutzaQow/miXfodFRJ9PBYZ3SaakS7HpQ3zaSFKeOkb4/BGfzl/j84yFy1iBZ/XmMMw565s0gBW6XL26ESk85gbvlTxsx6rjUZ82A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fj7x8n/e; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso387175e9.1
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 11:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762976135; x=1763580935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovc76Z83NcUuR4lF7mtent9uAX4Ys7J9eQXpzf0/W3Q=;
        b=Fj7x8n/evak1N9YHPpiTbvsUvHExqSJP/5EtKtlS1qwLg4hAAkKOiIfcDOM1CCUDDj
         ktvjfJe90GmMWU9C442DEWBBnSVllvfLKF5S3gvSbi0ll7C9juBx0YUjlSfKqHseREL8
         YLMohecz9pU34QB+EATGzoS1n3R6pkFoHypBNXebVJ657BonTB/pU5rDDFDxFf90lm/Y
         y+5LuK//LKRTpFu0zzenkVVXFkOgaMY5cO/wGSwYS/e/xMj35p6elCngACMp1jNo6w3z
         wmf83Djo85nhM1Q2ba71WLCp5GPEZlidy7WJzEyZxGD1C1J5bh7YjTJoEaYguQHtVgFJ
         EZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762976135; x=1763580935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ovc76Z83NcUuR4lF7mtent9uAX4Ys7J9eQXpzf0/W3Q=;
        b=fbWCRNE1gYLorACdFsgN/IN6u2yLICCgbHzyzScoZQO2heDoESLfGnwcjkUJhjIroB
         xQJjNQ5q0DGmBS/On8D52uep4UeTwJNbb1agfcrIVhMW+j3NJ4cL9n/apyeJu1vICj2+
         lw/c8emc4Hzr3qCn6hPR5/IiJygyZ+IYArehwQaGx60rPWPXLbn63M71ObIha1xIFxMx
         KSdIfTsCsm5j28CZvMBjUlkHUgVZbZm1tV07fdTxNC7U2Hzo6wudRsnwfHf8w3ujDya8
         ZbToMlbY3fWKEB5V2gNGQf1GU/pEHo6WyAIHfLmWE9ZDpHt9LpzQu6UCxvpBn21xAq1Q
         N6bw==
X-Gm-Message-State: AOJu0YyEFOGFXnp2sytL5zqQJqOGKzBUrzMzWAZASi6139CQWu5RvDAx
	5VhIkmdH03pVRjLKH8H+tFdczzXDjiwhj0urO3srg7gjB7QoNcRUoB9DbYNW9qcx5E83J4jeHru
	FuC1IGCrvtC0fZ1tvrKQKkgUV6k3V/Sk=
X-Gm-Gg: ASbGnctOG3S4fV3PG6TzAcqI71fTOwOgz1i6IzTOBBjwNfyoA8+GTimOMoWLjMmgbgx
	NWtdlIY6kBNoYSnntx8uXsePbVRCXbwfjS/soLym3B3ysenF7zYAXKEM0ePgQD6n8yRCz5bYTfU
	9VVmuPZ34VnuOxWfdzCz0YJH4QJjfOXHQZka3UNxaw3TqucdJ5GGPMtxKhXnl4ERYiGr166IJSV
	8LejjI4m+vbCPbPfC78VLfE24f8ykNLS6lfb9Mx3jYnFXLo2HlIkkCEIPOBVuxkdjkUfg742ze4
	wXQ6ksw5NMfuDZo70g==
X-Google-Smtp-Source: AGHT+IGlyQ0QaEFrKxBFF96zByiUlKpiqv8/ugPXOnbVB+mrwb9tXtuiPq33A+5rz7IMdJ6AHF++ClxMYi84DSK32+U=
X-Received: by 2002:a05:600c:26d1:b0:477:8985:4039 with SMTP id
 5b1f17b1804b1-4778a01e47amr15400055e9.17.1762976135022; Wed, 12 Nov 2025
 11:35:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112175939.2365295-1-ameryhung@gmail.com> <20251112175939.2365295-3-ameryhung@gmail.com>
In-Reply-To: <20251112175939.2365295-3-ameryhung@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 12 Nov 2025 11:35:22 -0800
X-Gm-Features: AWmQ_bl7MLHWzyjVcuKM4hdvoIwlqldAKlytvr8F-mSBLUB1IB7_hX8Jsae4F6A
Message-ID: <CAADnVQ+2OXNo99B2krjwOb5XeFhi6GUagotcyf36xvLDoHqmjw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 2/2] bpf: Use kmalloc_nolock() in local
 storage unconditionally
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 9:59=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> @@ -80,23 +80,12 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, v=
oid *owner,
>         if (mem_charge(smap, owner, smap->elem_size))
>                 return NULL;
>
> -       if (smap->bpf_ma) {
> -               selem =3D bpf_mem_cache_alloc_flags(&smap->selem_ma, gfp_=
flags);
> -               if (selem)
> -                       /* Keep the original bpf_map_kzalloc behavior
> -                        * before started using the bpf_mem_cache_alloc.
> -                        *
> -                        * No need to use zero_map_value. The bpf_selem_f=
ree()
> -                        * only does bpf_mem_cache_free when there is
> -                        * no other bpf prog is using the selem.
> -                        */
> -                       memset(SDATA(selem)->data, 0, smap->map.value_siz=
e);
> -       } else {
> -               selem =3D bpf_map_kzalloc(&smap->map, smap->elem_size,
> -                                       gfp_flags | __GFP_NOWARN);
> -       }
> +       selem =3D bpf_map_kmalloc_nolock(&smap->map, smap->elem_size, gfp=
_flags, NUMA_NO_NODE);


Pls enable CONFIG_DEBUG_VM=3Dy then you'll see that the above triggers:
void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
{
        gfp_t alloc_gfp =3D __GFP_NOWARN | __GFP_NOMEMALLOC | gfp_flags;
...
        VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO |
                                      __GFP_NO_OBJ_EXT));

and benchmarking numbers have to be redone, since with
unsupported gfp flags kmalloc_nolock() is likely doing something wrong.

