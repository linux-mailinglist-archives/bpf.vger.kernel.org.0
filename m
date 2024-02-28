Return-Path: <bpf+bounces-22931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085AE86B9D0
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 22:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE681C23288
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 21:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045555E077;
	Wed, 28 Feb 2024 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaRXH+22"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A5486250;
	Wed, 28 Feb 2024 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709155596; cv=none; b=Bo87kbE3EEZjca/Gyh3KibBn1Zzcds4OURcaTkbuRRUTLab4xdcRuyZV143H2d01DHgMAkvDu99OvTnsJ8Mdo9+FzorzZ3gAvWgHazFbZ717InBmSWQky4sXXLh/2QgK4YwDHyo9wToeu54SCsRuwQCt3K5/c1lj7WKYLUA5Hwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709155596; c=relaxed/simple;
	bh=v94QBitZpa1c7Sm8gy43hV8ENkYjnYfbL2IWGe2j45I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AX74Ku6dVMRzsUzuqoHolOWfkTXEscBpPkwxdTH4XEqtJ+nC+khMq9HPsPDZrhW8i2sAgf0pD34cpRLVHNp8dSRCyYJgcrvb5lzNv0kD7lpLiJeaiQ9JUbQwwJdwB3FiAprTk4tOSq7ompXBDd+nRUSU+1qZsT5XoOG0+/oC8Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaRXH+22; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29ab7073dd2so123716a91.0;
        Wed, 28 Feb 2024 13:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709155594; x=1709760394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXVaBRQsSxqdO9erylxq2DHr1iSShOnpq3FsNyMGfGk=;
        b=NaRXH+226ruihAr4lMnZXO9q1At19rCwKvdqkdwErAwU2FwFYe1kgC58THktnrWQCy
         9Mob4XVtuyVSO75C3+h4Omh2YYe6F3f46VEdyTQlkjp8zUaQpIhGO41PSj1yxbiUeN5y
         //Vd8U74En1ml3fcI2y3VGbQRJ/AoPI7ikiK+3ua/ylFBinZCJWNYDBLWqvayGL9MiLm
         jDQnga13JISOsK+I9ZIKgNhk/mYK1RtLRchiYR4j9jYzvAt686Bult6GIorZznR5dCxH
         3ZZX3wV/1TqxNrI6MtMjfKzT8BMY7NP3tepiK3y7yKkwqf6QhPWmROD+O42hawfTkHId
         +bJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709155594; x=1709760394;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NXVaBRQsSxqdO9erylxq2DHr1iSShOnpq3FsNyMGfGk=;
        b=dIOm7EN+HqKvyvR8OpD36ojrNWln6xIts/WsswvC7qEJ9bVAl16GP/MUlSuQKPHlLl
         iYPfWtrNsKuPHmNPMPvAcfaQQjwJ/QRt/3+khcn9yLNqjLY13Uf3FIJkZiYWz+og0rWM
         eRSfo4IuA1W+E+LgYupU6MEe4AfwPeNr0k2iwSnzK1Pl7w7m2+rvZN2aKC3UMyDKchNQ
         9wImugo2LyYHFu4+Tbpdod6waKF3AheYLyc0nlDF6D3Q/EOTYl4EYYBex4K+eXQ9l/ls
         fq6FjBeE3hnbM91zUx8yvSSdaZV5OTtRu/BYy1SQR+4FmVIkYil8wDOpfev+rCT9s0Gr
         ZBAA==
X-Forwarded-Encrypted: i=1; AJvYcCVigna7cEku9wCnucvkEBPyI8hRNJOcyaIQATsiwnP1VEsyOYrbV3kxziZaevV1GYg5vN97Z4JqUqjZ9GsLJO6EqMPzO3UNfYhQITLjjToXKspR6Rg6Egjltzx/
X-Gm-Message-State: AOJu0YzD2ONaVSGvyePA7/RbtgK5D3IfSbHy+DELetmxhVq2FHupjqLM
	3SVDoYnzsT08KlYRKjQNTuCnkBm9pxwftrHmis4GrfNbnU2Jc6ym
X-Google-Smtp-Source: AGHT+IFxVpk4GNzefxj7rv2iumrYwwC5M9ZZePsqVADhAPQE2+0NN0O9JVgIu9iP1PAmh4FFSZ8QNA==
X-Received: by 2002:a17:90a:8044:b0:299:5913:db15 with SMTP id e4-20020a17090a804400b002995913db15mr368957pjw.29.1709155594273;
        Wed, 28 Feb 2024 13:26:34 -0800 (PST)
Received: from localhost ([98.97.43.160])
        by smtp.gmail.com with ESMTPSA id md21-20020a17090b23d500b0029a78f22bd2sm16949pjb.33.2024.02.28.13.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 13:26:33 -0800 (PST)
Date: Wed, 28 Feb 2024 13:26:30 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org
Message-ID: <65dfa50679d0a_2beb3208c8@john.notmuch>
In-Reply-To: <20240227152740.35120-1-toke@redhat.com>
References: <20240227152740.35120-1-toke@redhat.com>
Subject: RE: [PATCH bpf] bpf: Fix DEVMAP_HASH overflow check on 32-bit arches
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> The devmap code allocates a number hash buckets equal to the next power=
 of two
> of the max_entries value provided when creating the map. When rounding =
up to the
> next power of two, the 32-bit variable storing the number of buckets ca=
n
> overflow, and the code checks for overflow by checking if the truncated=
 32-bit value
> is equal to 0. However, on 32-bit arches the rounding up itself can ove=
rflow
> mid-way through, because it ends up doing a left-shift of 32 bits on an=
 unsigned
> long value. If the size of an unsigned long is four bytes, this is unde=
fined
> behaviour, so there is no guarantee that we'll end up with a nice and t=
idy
> 0-value at the end.
> =

> Syzbot managed to turn this into a crash on arm32 by creating a DEVMAP_=
HASH with
> max_entries > 0x80000000 and then trying to update it. Fix this by movi=
ng the
> overflow check to before the rounding up operation.
> =

> Fixes: 6f9d451ab1a3 ("xdp: Add devmap_hash map type for looking up devi=
ces by hashed index")
> Link: https://lore.kernel.org/r/000000000000ed666a0611af6818@google.com=

> Reported-and-tested-by: syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotma=
il.com
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  kernel/bpf/devmap.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> =

> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index a936c704d4e7..9b2286f9c6da 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -130,13 +130,11 @@ static int dev_map_init_map(struct bpf_dtab *dtab=
, union bpf_attr *attr)
>  	bpf_map_init_from_attr(&dtab->map, attr);
>  =

>  	if (attr->map_type =3D=3D BPF_MAP_TYPE_DEVMAP_HASH) {
> -		dtab->n_buckets =3D roundup_pow_of_two(dtab->map.max_entries);
> -
> -		if (!dtab->n_buckets) /* Overflow check */
> +		if (dtab->map.max_entries > U32_MAX / 2)
>  			return -EINVAL;
> -	}
>  =

> -	if (attr->map_type =3D=3D BPF_MAP_TYPE_DEVMAP_HASH) {
> +		dtab->n_buckets =3D roundup_pow_of_two(dtab->map.max_entries);
> +
>  		dtab->dev_index_head =3D dev_map_create_hash(dtab->n_buckets,
>  							   dtab->map.numa_node);
>  		if (!dtab->dev_index_head)
> -- =

> 2.43.2
> =


I'm fairly sure this code was just taken from the hashtab implementation.=

Do we also need a fix there?

        /* hash table size must be power of 2 */
        htab->n_buckets =3D roundup_pow_of_two(htab->map.max_entries);

The u32 check in hashtab is,

        /* prevent zero size kmalloc and check for u32 overflow */
        if (htab->n_buckets =3D=3D 0 ||
            htab->n_buckets > U32_MAX / sizeof(struct bucket))
                goto free_htab;                 =

                                  =

Thanks,
John=

