Return-Path: <bpf+bounces-74102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 673F3C4942E
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 21:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 744094EA915
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 20:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E53B2F069E;
	Mon, 10 Nov 2025 20:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQQUlKc2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BFF2EF662
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 20:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806976; cv=none; b=E8ZNNfi2caOT2zJlvi0z34n6MfMhvc1/NC7fgSmgkuXdebeRTxVwHkwE2v6U+a+gd0/D1HVg9YwNxNQqIUSfxEvYcgiWoLvl8vv/7z6p20FPQ76Nzw3aDrmLnio1vtygSltG/7poFuSyUyqxyIr1KJkPz+PWW89U2xn5pyswkxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806976; c=relaxed/simple;
	bh=RCe9ghHYriRY4OGs9GstKBzLP7BBe0ijz6IOUCcDgKg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J9WwXO4OVufEcJRZ6Qkix8E+V/OI0dl/IH2UMgSpZ2kz8i1roOcTFiwjfzfGSZGx+agR4n00wdoCxi9Ll0X8J3xOgm1ffOt0hlqGBiG5R8G0DDX0l2arCZubU/CIKMvTsnYSalmL9mPzYjWcJn8XQpon16I8nUXiwW8LfAxtEE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQQUlKc2; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b55517e74e3so3043420a12.2
        for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 12:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762806975; x=1763411775; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fdW94pbkRdOwe2jA8pItfkO2oVchwyib+YCLYUN3HF8=;
        b=aQQUlKc2+cthQfTaLOVRIKpT4ZV0ctrc9ehUYKGIq6U5X6U7/YNgWWCOInS2GZ5zI4
         7wqbUzlXWgMvzEGxVnpLUkhC5DU3+ztOo2hRWwaTJ7zdRssYY8osDmBK73hjSscoEzFv
         nWVOcCsbxCxNcF66wf4KK7Ttt6gJVe8jUFaECJKV7hdvf17u7pSeO1cG2n5lYoD56zU4
         ZCtDBdlWiPBJcHWsEDH0KcYhhW9EbKKQvPCZPKivE5CbdnZ4MX9Wgbu+IvCDrHwHfPa/
         pb3fmresOgEh+oBeHghlEX6dcGJxaE3Ibsq0G6FjF0chV3/ys1HABLgzMiqlg8aTfE6O
         tyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762806975; x=1763411775;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fdW94pbkRdOwe2jA8pItfkO2oVchwyib+YCLYUN3HF8=;
        b=To4X+HTqZHRV6XHVcWW3FC47J9mXPvp6Fd4idTfFHVQ61eUDgCKSrzPHoa17yCtoQe
         R3vXz7vHIxEYvp7nPftqa0YMRjOtslfwa3wmSloF85GSMPAgFvS10+1YsRgCrViR3QAI
         0wByoMN4SheHH4ykRBBKCN8E0D3LOQ2ZlFIJ+1M1sP1AfYXASEQUqzFhE0xjNh6fUszk
         lTDwuvycWBqbIesYGfTQyvGEFAXAtzDfN4tdZ7aoxe9S3Oin9qLFwCFKMdXZ6y8R4JjU
         xFwMJ2b/E77t8H9xc5w6GZAxWjerMSg/3TSaWriFZo3b+SosDzT57n6LDwh0QeInkXTP
         aLAw==
X-Forwarded-Encrypted: i=1; AJvYcCWuw9rws/Q7IgeWj3w7o3OxPPtWbqEaweZH4Fje1Qz0+2vx770vLeb4a9EB61cH9oQ8S6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvswqgi/4r00LAu3q4fk/AaTevsuT3mJGm6fuDD4TmADD5Rjik
	P2HHkNojTPRU2Hftyrjpw51TEu+1sGbhtrJsVbcyKGd6vpHjQ8Ehy/Hk
X-Gm-Gg: ASbGncteAZTZ4dij9rI2ZZF7/R53UDju6VZi3GricPDNCZVAByVt8emzUEJROHE65PP
	YKKxPAhSvqhNefWyOBM0ghp7UjbEzMmiJGmIDO8iY7/UIO6IZ+5qhqDaNWzNiTJO6l+fr4B6tCD
	yrVoWXNkihd7mT7mtgJH9DdVeSmIoqAhko/2AhuVNw1B6FdxsHsql6VtgXnjCsYNqKvO1Mrf1YH
	yt6ANTsvSh5I9HzhXccTDk2PTkpD6gURpEnfHjT4n5X1btSD96Z8kEMnwdtbj6OBmEOXoOCeBAP
	LQ6EZEHoh5Vk/50JEvy3w1z/OZR8WfC/k0UcIzQ2aYdR+3E5zfFUNe39Kpr/WLEH+pICe8BYDiw
	g2KNtAMOGbUikd8Jvn+dUDFFMkCE2XCqwQFbC6+JkGSr9Cob6aRyDExIsuTPZdztoELo8BAYqEz
	NT3HRfFQFMLKBKV2Y//eBXbQFb
X-Google-Smtp-Source: AGHT+IG5FsvYqOiL8dLwOS1VEeS41ABkv99P3qnf6jkgeRdwW81L8bVYBq0MYEPYlPhTK5gGmKhKqQ==
X-Received: by 2002:a17:903:110f:b0:298:2afd:c4c1 with SMTP id d9443c01a7336-2982afdc5acmr48309695ad.50.1762806974669;
        Mon, 10 Nov 2025 12:36:14 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:5ff:e0da:7503:b2a7? ([2620:10d:c090:500::7:ecb1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297dacd1e93sm99771625ad.2.2025.11.10.12.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 12:36:14 -0800 (PST)
Message-ID: <92ba87bbc6b11234be1925a4dc7262e11cd07305.camel@gmail.com>
Subject: Re: [PATCH bpf v3] bpf: Fix invalid mem access when
 update_effective_progs fails in __cgroup_bpf_detach
From: Eduard Zingerman <eddyz87@gmail.com>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh	 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Alan Maguire	
 <alan.maguire@oracle.com>, Pu Lehui <pulehui@huawei.com>
Date: Mon, 10 Nov 2025 12:36:12 -0800
In-Reply-To: <20251110092536.4082324-1-pulehui@huaweicloud.com>
References: <20251110092536.4082324-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-10 at 09:25 +0000, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
>=20
> Syzkaller triggers an invalid memory access issue following fault
> injection in update_effective_progs. The issue can be described as
> follows:
>=20
> __cgroup_bpf_detach
>   update_effective_progs
>     compute_effective_progs
>       bpf_prog_array_alloc <-- fault inject
>   purge_effective_progs
>     /* change to dummy_bpf_prog */
>     array->items[index] =3D &dummy_bpf_prog.prog
>=20
> ---softirq start---
> __do_softirq
>   ...
>     __cgroup_bpf_run_filter_skb
>       __bpf_prog_run_save_cb
>         bpf_prog_run
>           stats =3D this_cpu_ptr(prog->stats)
>           /* invalid memory access */
>           flags =3D u64_stats_update_begin_irqsave(&stats->syncp)
> ---softirq end---
>=20
>   static_branch_dec(&cgroup_bpf_enabled_key[atype])
>=20
> The reason is that fault injection caused update_effective_progs to fail
> and then changed the original prog into dummy_bpf_prog.prog in
> purge_effective_progs. Then a softirq came, and accessing the stats of
> dummy_bpf_prog.prog in the softirq triggers invalid mem access.
>=20
> To fix it, we can use static per-cpu variable to initialize the stats
> of dummy_bpf_prog.prog.
>=20
> Fixes: 4c46091ee985 ("bpf: Fix KASAN use-after-free Read in compute_effec=
tive_progs")
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---

Hi Pu,

Sorry for the delayed response. This patch looks good to me, but I
think that your argument about memory consumption makes total sense.
It might be the case that v1 is a better fix. Let's hear from Alexei.

Thanks,
Eduard.

> v3:
> - add static for the per-cpu variable.
>=20
> v2:
> - Use static per-cpu variables to initialize the stats of
>   dummy_bpf_prog.prog suggested by Eduard.
>=20
>  kernel/bpf/core.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index d595fe512498..14c15275b424 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2536,11 +2536,14 @@ static unsigned int __bpf_prog_ret1(const void *c=
tx,
>  	return 1;
>  }
> =20
> +static DEFINE_PER_CPU(struct bpf_prog_stats, __dummy_stats);
> +
>  static struct bpf_prog_dummy {
>  	struct bpf_prog prog;
>  } dummy_bpf_prog =3D {
>  	.prog =3D {
>  		.bpf_func =3D __bpf_prog_ret1,
> +		.stats =3D &__dummy_stats,
>  	},
>  };
> =20

