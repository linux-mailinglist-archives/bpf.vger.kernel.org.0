Return-Path: <bpf+bounces-71649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B0DBF939E
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 01:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C9EB4F1899
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 23:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD242BE05B;
	Tue, 21 Oct 2025 23:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/XLlyIy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828EE27CB04
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761089184; cv=none; b=ooEbWJ5MRD285fFeN5DEu5fJ12h5B7omQTSQvJaDXLgE56fzkllTwKuZY3qggUtBwiJeE/qFZDzBfIUuTaq86y+qM0RcTKVh6KkppswwCenC3rOPU19n34HNVRALzls4bMOtr8M3zn3Cuy+i6IqbzQrPQTDYyKl0fQJu+AXgxso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761089184; c=relaxed/simple;
	bh=KtndXwzK4OF13NFflWUEsfk3ITLOlkA0WZSwlTnac10=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lfyJhIirBkRPzHniqZHQiCyKGhZykUYkkZb0yF5zoGERAYnX3OHMaJuexFySIiczHRZcz63krI3HmjZaOtZKzT9ygaE+qLH1tThKC3G/MXDzfS9BTamYIsVsghnsWTnOSon4CRqfzkmqcf4jXqO04M8jmWE50kJPkVsTLfDvYFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/XLlyIy; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so4030388a12.1
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 16:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761089182; x=1761693982; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUTpt+J5tH+uwSUsM8nuh99M7Jm5vNWWqEhfwwJoQrI=;
        b=H/XLlyIydAfAqx3oobVoF/cNsfp70TOM2ukvBDnJIJh9tHq4fAbp3SU7pwHsnrsI/g
         TswH6oTWS/GR4m81x8CCEKdu1/mzmYzwI4sMcKy0xKAjHqu+dZLmPTelcEvcB8bZnO8f
         4kjxcuhp88u77WqclNZDF+PT4sppEz0UQ0327auBh3jOZT7zViUKoHH3Qjwq0EFvEN8S
         4TmM2Osh0ZyxXhB1XUQktYjgGERZb95Or6P2m4cuUGuIyqEp97TH6kLjJfReZ8DhToS8
         zpRbZ89bDGXRoHJUOTAnU0So+8kzVnwP2vdkBgAykSfRVqBh8ebeSvNj+qG+7DWkcD/g
         93wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761089182; x=1761693982;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JUTpt+J5tH+uwSUsM8nuh99M7Jm5vNWWqEhfwwJoQrI=;
        b=Bvi41OuWU9oL0fpBUKxPsVDLQmj4+EWs7Md/fJWsEEHGUd353uqtMcZiLDvWGXebGh
         zk5xZWNoxU7dYCMVuaGavQSVA0GaiJDu/5pKsniSoF3U0TB5pXkZb/MNOw3gZMIU0CPy
         PT30vxnn5aIQgj5k0HyxN4HOsTkIl7yZDUHqOYZqh7wKWvR1QkaNsEhPnkW2TOCfw3g3
         z6c/csLzmlHAk+n/D6WfK5eOkzlxvv6DCe/ZjWedKOEwB5D16N69F9LHjTIsRA06x6/Z
         eX5E5WNjnKUgO7lsFLlM2RwoEnHyG3BnYgJRdiWW47n+Pqx7smIlX0dgE1FgTBCe7Ef5
         E50Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwrXqwBVaNxy4Wwa5I1AOeju+4AjHvCHANo39xxT8EArcTT1Q1P660r2ICuFjpGrUzyik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUoRAtOz15WDN1YR9LJGQ1YFlAQsR/lkmUaPP1PcE5L8mn2MEz
	T66w1sux276M7rdixh7JLvm4giBvEHEh1EjvSw2k1+QlrtWhfo6v48ya
X-Gm-Gg: ASbGnctAwBJCERqoXEmcVsA4YY4WfMKK0pIinVpH+zde0zKgZtepfMqwNQN5IcZYfW7
	J88goZA6nGFiiK9OfCY1ZSBJ5X/qCD++iRe/CrZhEIuY/Fn3CvBUm7bMMd4SZ6w/zfmacySdT5s
	tbVYazrglOLjlu6b6AzT39K77u8RKeKVVq4MMJh//j3TAIZfMT3+vEFxJzwxJOoCO9DhEkuLs1y
	XddK0b2nM3MRAW2zlN7bfUxF5aR0nB2DeS6NNGBcPsC0NV20R0NJ6l+K9r89tsnjpVWTO6MRUIA
	Fn7L2p6Ltr1PTp1JTMygMQ71P618XhIGKdJP3Boebh3mR7j1AmnHpY9I35mH6WoIHXD8XtnL5hu
	bJo4ZMEr3GoVx6uQRoHeXq9CiKWVVNYOKmZQlgYg0sD+P/vHkp8FsGF+/5dbp0hBm01ge03eUsL
	jsg9X7f2iVczCwM8mRNUcYEltQdPA2o9nrmbM=
X-Google-Smtp-Source: AGHT+IEalK0K03FscDagMDpX2UPf5wcJwVuIcY5/DVgsFqY+xWZ5RvuQCz97bWcx+jTvnQ3k8BFkuw==
X-Received: by 2002:a17:902:e944:b0:26d:d860:3db1 with SMTP id d9443c01a7336-290c9ce22d6mr194063235ad.24.1761089181720;
        Tue, 21 Oct 2025 16:26:21 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:84fc:875:6946:cc56? ([2620:10d:c090:500::7:6bbb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2924721980bsm120048115ad.110.2025.10.21.16.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:26:21 -0700 (PDT)
Message-ID: <fb8a2c83a6041cb8b2285d91dba87b1c860e948c.camel@gmail.com>
Subject: Re: [PATCH v6 bpf-next 04/17] bpf, x86: add new map type:
 instructions array
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Tue, 21 Oct 2025 16:26:20 -0700
In-Reply-To: <20251019202145.3944697-5-a.s.protopopov@gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
	 <20251019202145.3944697-5-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-10-19 at 20:21 +0000, Anton Protopopov wrote:

[...]

> The functionality provided by this patch will be extended in consequent
> patches to implement BPF Static Keys, indirect jumps, and indirect calls.
>=20
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---

Aside from what Alexei pointed out, I only have a nit regarding jitted_ip.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index e53cda0aabb6..363355628d2e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3789,4 +3789,40 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, =
unsigned long ip, const char *
>  			   const char **linep, int *nump);

[...]

> +/*
> + * The struct bpf_insn_ptr structure describes a pointer to a
> + * particular instruction in a loaded BPF program. Initially
> + * it is initialised from userspace via user_value.xlated_off.
> + * During the program verification all other fields are populated
> + * accordingly:
> + *
> + *   jitted_ip:       address of the instruction in the jitted image
> + *   user_value:      user-visible original, xlated, and jitted offsets
> + */
> +struct bpf_insn_ptr {
> +	void *jitted_ip;

I think this one is no longer used anywhere.
I see it set in bpf_prog_update_insn_ptr() but it is not read anywhere.

> +	struct bpf_insn_array_value user_value;
> +};
> +

[...]

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 6829936d33f5..805d441363cd 100644

[...]

> @@ -7645,4 +7646,24 @@ enum bpf_kfunc_flags {
>  	BPF_F_PAD_ZEROS =3D (1ULL << 0),
>  };
> =20
> +/*
> + * Values of a BPF_MAP_TYPE_INSN_ARRAY entry must be of this type.
> + *
> + * Before the map is used the orig_off field should point to an
> + * instruction inside the program being loaded. The other fields
> + * must be set to 0.
> + *
> + * After the program is loaded, the xlated_off will be adjusted
> + * by the verifier to point to the index of the original instruction
> + * in the xlated program. If the instruction is deleted, it will
> + * be set to (u32)-1. The jitted_off will be set to the corresponding
> + * offset in the jitted image of the program.
> + */
> +struct bpf_insn_array_value {
> +	__u32 orig_off;
> +	__u32 xlated_off;
> +	__u32 jitted_off;
> +	__u32 :32;

This :u32, is it for alignment or for future extensibility?

> +};
> +

[...]

> diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
> new file mode 100644

[...]

> @@ -0,0 +1,288 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2025 Isovalent */
> +
> +#include <linux/bpf.h>
> +
> +#define MAX_INSN_ARRAY_ENTRIES 256
> +
> +struct bpf_insn_array {
> +	struct bpf_map map;
> +	atomic_t used;
> +	long *ips;
> +	DECLARE_FLEX_ARRAY(struct bpf_insn_ptr, ptrs);
> +};

[...]

> +static inline u32 insn_array_alloc_size(u32 max_entries)
> +{
> +	const u32 base_size =3D sizeof(struct bpf_insn_array);
> +	const u32 entry_size =3D sizeof(struct bpf_insn_ptr);
> +
> +	return base_size + entry_size * max_entries;
> +}

Since this is doing a flexible array thing anyway, maybe also include
size for `ips` here? And in insn_array_alloc() point it at the tail
area.

[...]

