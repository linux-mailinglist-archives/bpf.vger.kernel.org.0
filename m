Return-Path: <bpf+bounces-48628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E6FA0A48C
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 17:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0331675DC
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 16:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A1414F9C4;
	Sat, 11 Jan 2025 16:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqATFy2C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCEDEC0
	for <bpf@vger.kernel.org>; Sat, 11 Jan 2025 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736611441; cv=none; b=WHmHMiuJBV5SQH3FvsopwMxOrzgALc8JXpEH2QpmUmod9N68/Ps936+Qy+I/M02WJiZ1+YEkSciwriLoRAE4zURCvdbLoKvp8WD3lPDQhzQiLlEskPSAr46TPrhG/Phm5nR6uV3Nf4LjU9Kq9XB/f86gzUFnBLzMBlE7MvQISL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736611441; c=relaxed/simple;
	bh=nfC4BmaxMLsXDUP2KSfA5nPq6ITSKLF3sgw97NVBZs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMPSIVir/Lpvh62BtG2Crn9clXZS7ifJKNvVHEwMH4V+VuL1wlIhI1cwM+Q22za3kbhXN5h6cZrYOBn6U7ndahzX1/JDVXELRw3qnBx63ti30gLCatz12t6xjPdT9AdaX49pe5vMhs6A1jg2xLRogko/ZUHvY7NCI4uSW5RYMAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqATFy2C; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so1854585f8f.0
        for <bpf@vger.kernel.org>; Sat, 11 Jan 2025 08:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736611438; x=1737216238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhRfvGHbnJ737QwoUrKheHHYZce1C2lFhsVw79P3A0U=;
        b=AqATFy2CHK8/8FWmgpsz1z9q31AD1sKwrC/3zWiLz+tFhyMfZNTJcELacM8Q3pufGy
         JwgYKFepz87y5aCi+bnxlH9FvMo49t6uCKH6vdJmVBLFDwC5QKHE0plQyBAyXMx1iPY8
         WFDC7LVDwV5KgSAyZQK1WVazWyWQ2vIgaiSvZ6CHfqWFOgfb/O0p/EzoFoFZ0wXzIe3m
         UY2KxLecdNSPLZe1AzodezYZr0u2YYv+WZD3FvVLdJI+Sca/3teTOYsN/A21d3r3bgx5
         5A7Ez0WnfEeJKg20TNIS+nikevjj6IRAUVH1gWOpIRoOzRvf4+Tlgog47r+Z1pgJFN1Q
         YFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736611438; x=1737216238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhRfvGHbnJ737QwoUrKheHHYZce1C2lFhsVw79P3A0U=;
        b=HGNpSxuQFfcq+UNpzEP4MAhYVj+vmJIhTxrv70KKS4cTlpGbsDY3bIfFj7Gd0jHqvO
         25eg3nAJJsf+xzpqxAx3myvz6ESV7LojAi9mAGWVzzBPFxEmpRz7XQ/xiIfxFTk8Es+E
         wLrpc5Hjkq6+T4GJNEmFpZuwxkcKZ0fvtExpqUfUw4p2nXooBaCTHx22BtqGQg0+2Dis
         8UY61+WXG3kar6KNgOOd99NEugb+HMc1pNRQarSqyV6qupAXk0ySigItsJPHyt54yGVX
         seLHGP0n8hnQWSGco4yYtPl2QEO10g7Xx5r42NJAyZJ2D+6klsh5EK3Dko+5KDZXBSMR
         vz4Q==
X-Gm-Message-State: AOJu0YxxzBHAh4sFvmnlY1zS9nxfWRFmBS618Eg9NcYH90er/D+bFRO5
	fRoK2y9Y5TtxtOIiJGGvyG6yuL+JridZANAZMRHhsWaYcaiMsF4PpSvzmyfrTekpvlrA9sV/vOG
	sF5sNvenS1z8pKdYSsu8tQ0bLU0I=
X-Gm-Gg: ASbGncvODfNxOuP3/halZNgmy5rYPdVAUN4nP5+jhNKAU+2tdH9AGcQOA5LvAIjQtsV
	sVlRoeSTUU/daZg0czlbZq0ZbD6L2D/jZAsb9q935CrQGQG9ADiepuw==
X-Google-Smtp-Source: AGHT+IEjw16MHKrAvtHPqkgLfT/WlhhULY2kgOPfGOiM7XwNwwJG7BgSv6ami+esUnt0opD1VK0pTE5MBDD+QCPK+m4=
X-Received: by 2002:a05:6000:186e:b0:38a:8d32:272d with SMTP id
 ffacd0b85a97d-38a8d3229edmr9657408f8f.28.1736611437740; Sat, 11 Jan 2025
 08:03:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111105445.3830433-1-ariel.otilibili-anieli@eurecom.fr> <20250111105445.3830433-2-ariel.otilibili-anieli@eurecom.fr>
In-Reply-To: <20250111105445.3830433-2-ariel.otilibili-anieli@eurecom.fr>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 11 Jan 2025 08:03:44 -0800
X-Gm-Features: AbW1kvbFszWNnUPzVRYpoYFk-yBkRGUYQ04m_J1nq_eY8fK0oqmYGkGQsDDR8Pg
Message-ID: <CAADnVQLuuLeUY7KLYwou8t7BevJQUSxRe2obP1TAF8A7svmt7w@mail.gmail.com>
Subject: Re: [PATCH 1/1] net/core: kernel/bpf: Remove unused values
To: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
Cc: bpf <bpf@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2025 at 2:55=E2=80=AFAM Ariel Otilibili
<ariel.otilibili-anieli@eurecom.fr> wrote:
>
> b gets assigned a value, but is overwritten before being used.
>
> Coverity IDs: 1497121, 1496886
> Fixes: 5ce6e77c7edf ("bpf: Implement bpf iterator for sock local storage =
map")
> Fixes: d6c4503cc296 ("bpf: Implement bpf iterator for hash maps")
> Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
> ---
>  kernel/bpf/hashtab.c      | 1 -
>  net/core/bpf_sk_storage.c | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 40095dda891d..23b457536105 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2039,7 +2039,6 @@ bpf_hash_map_seq_find_next(struct bpf_iter_seq_hash=
_map_info *info,
>                         return elem;
>
>                 /* not found, unlock and go to the next bucket */
> -               b =3D &htab->buckets[bucket_id++];
>                 rcu_read_unlock();
>                 skip_elems =3D 0;
>         }
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index 7d41cde1bcca..7c1b79dcd996 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -729,7 +729,6 @@ bpf_sk_storage_map_seq_find_next(struct bpf_iter_seq_=
sk_storage_map_info *info,
>                                          struct bpf_local_storage_elem, m=
ap_node);
>                 if (!selem) {
>                         /* not found, unlock and go to the next bucket */
> -                       b =3D &smap->buckets[bucket_id++];

'b' is reassigned indeed,
but the patch is broken.
Look at the line you're deleting more carefully.
And run selftests before posting patches.
Error: #19 bpf_iter
Error: #19/26 bpf_iter/bpf_percpu_hash_map
Error: #19/30 bpf_iter/bpf_sk_storage_map

pw-bot: cr

