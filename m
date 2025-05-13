Return-Path: <bpf+bounces-58108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54F9AB4E7C
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 10:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE48D7A470D
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 08:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB4D202C49;
	Tue, 13 May 2025 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9HAwp/n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CB31DB12E
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 08:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747126156; cv=none; b=JjUvXrpfJkSULVsTHflPU0T0iFxEhbPJJl6lI03JVCklPLRvh0xXsSFBgu35r/AOqbIBO1Xwq0OFVC8LCkKXhKeTUcgz2d5jOYuLy5QTWqa9wyi6mq5qi334AFVU5fckkk07U6bMdtvJUgDmXBoFnY2niaBXNbq3jJijKrPSxDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747126156; c=relaxed/simple;
	bh=yOfB79sDprPHAwUK6UJ3LX7cQU73V4Ro2gmRaLjvihQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AwUghZrnJOzb2NO1S808mejMAGktnCvYuoTftd1DZW9fdlIbm9+8hsA9kKQrrP/wDctXQYxzUZDL9S2DKJ+8WgiG2LHvfbxTPXJT8zLtRcWs5lC9/A7f8/CglTSfO6TBXZ3YsZkAziB5RllLR3k7jpJJzHOv990WBxptxSH5/4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9HAwp/n; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22e3b069f23so50142215ad.2
        for <bpf@vger.kernel.org>; Tue, 13 May 2025 01:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747126154; x=1747730954; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j+g3Goe7O6wlji67BrYdNSK3t1DsqzEmCBB4cfkoLbg=;
        b=F9HAwp/nP+L79Bfj9CqDwxQ031BAKBF3YCNspSEe5t5sP012QbG8ETY+/cR8dp9jnQ
         fFhO4UxIZbvkUVzoC3MxqhoUulkuxGRLmDkUw/ENOTFgkpMjxp/rQrhWlgQwUkcDHMbY
         nl2oz9ZRJZuXbC69TfsArvj/CeklP25kvXq7HmLlXDw8Kod+XLb6RGcS1EiKTfnErqYX
         wwNyHnTdfCREwiTA0CRtV0btBP2VcLQyI4DOv+blXZNf/aI/FJiZE9L3nF0/hW0HrkTH
         pdr2N/TO+Jc6fxKA89+nFjw8qS4f/SwSUvpos3DoIa1Ycqm0iXojgOzRgFtLTRm68BHi
         rr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747126154; x=1747730954;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j+g3Goe7O6wlji67BrYdNSK3t1DsqzEmCBB4cfkoLbg=;
        b=D5XoZC06/MbPV8jn0JZ+ABP3NvkXEAZ8f2/VAkvjPjE1Fnaeo86blK1bWxxe6G6sNu
         poq9SvP6ExZ9XQYYEffJwklHjpo4izfrR132EZQKvpj9tOaP9VZdFytbCtM4GLspwYV1
         TICYxAW+rgm5kP0Gk2eqUs1iKCYl4+ZdHNeQr+N55Jw0Td0R0CdMx/nrEae4dS6Ds+0y
         jAU3JeQQSw4hsy7Z4Cu6eizZGeEY7TYLbrTLiAC029wp4hxHJWFxBXJ1XOb+0d5of01C
         FU3RhWzdTjQD8/ghsQiLdLvCY60fJ17ujSZnhwmmzpnMEkyst1R7IxU2wBrLRh6J8NDM
         uSmw==
X-Forwarded-Encrypted: i=1; AJvYcCV/4wzSyEuJg8iGmtUOSjYF8h6lRcybpj0u3pVxCfoLjHYtjp2qqARFXMvFko8ziNm0Dsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWK088TTtrLADbi6cL/VRd2uH95AXuTHNtBX9VCqYhOomyC4ce
	V6yW/I3LMQoxh4uEk60Km4SL2lpepxjoPZgTg7fR6Kcu5kMsuPKo
X-Gm-Gg: ASbGnctuUnBUNCcR5HqP1OTqTsj1j4DDWi+YbNaHsZRAX+tjHM9694j86qr2M42m5c0
	DtxYxyDTQHdhzKbitOaYs2GSL/YEq/BOcabsQ02t9HBSwQyYSpWnQcpcZfqqP+O0cmU5Prlm7gv
	G8fp9Eh70siu/il2uonKDYxH76A8/GdvvBdnCPKO4nPkQ3FGMr7rvVGQGLrzgJ3WzT7kwFFwg0E
	CF1ng8AGLZXxnoe0KtUWB3nWOsg+8cxvmSQ5CNwphMD0i+DBQbjnfsYoqSnXKP+qpcbkwNKEnCk
	qDReNCxMLnJAHYh+iZjWvvibSW6SBJYNCdbzgdqnxMLY2Q8=
X-Google-Smtp-Source: AGHT+IELNtHVtozGQQui/yKQffrhwglIaets7Jl64sVWFsZBzX8UcLQ64EWTU06T+o4HZkA0C8e5ww==
X-Received: by 2002:a17:902:dac5:b0:223:f9a4:3fb6 with SMTP id d9443c01a7336-22fc8b107abmr256240205ad.11.1747126153889;
        Tue, 13 May 2025 01:49:13 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc755596csm76778175ad.58.2025.05.13.01.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 01:49:13 -0700 (PDT)
Message-ID: <32b9c10381d7f0fe358f955437febf96e5d2f58a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Add __prog tag to pass in prog->aux
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@kernel.org>, kkd@meta.com,
 kernel-team@meta.com
Date: Tue, 13 May 2025 01:49:11 -0700
In-Reply-To: <20250513025747.1519365-1-memxor@gmail.com>
References: <20250513025747.1519365-1-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-05-12 at 19:57 -0700, Kumar Kartikeya Dwivedi wrote:

[...]

In Documentation/bpf/kfuncs.rst there are descriptions for several
suffixes that are supported, "__prog" should be added there.

Do we want to add a separate test case for this feature?
It looks like there are no tests for other suffixes,
so relying on wq tests passing is probably fine.

Implementation lgtm, a few nits below.

>  include/linux/bpf_verifier.h |  1 +
>  kernel/bpf/helpers.c         |  4 ++--
>  kernel/bpf/verifier.c        | 33 +++++++++++++++++++++++++++------
>  3 files changed, 30 insertions(+), 8 deletions(-)
>=20
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 9734544b6957..7dd85ed6059e 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -606,6 +606,7 @@ struct bpf_insn_aux_data {
>  	bool calls_callback;
>  	/* registers alive before this instruction. */
>  	u16 live_regs_before;
> +	u16 arg_prog;

Nit: there is a 4-bit hole after `fastcall_spills_num`,
     `arg_prog` field could be put there and 2 bytes at the tail
     would be remain for future extension.

>  };
>=20
>  #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF prog=
ram */
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index fed53da75025..43cbf439b9fb 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3012,9 +3012,9 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, uns=
igned int flags)
>  __bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
>  					 int (callback_fn)(void *map, int *key, void *value),
>  					 unsigned int flags,
> -					 void *aux__ign)
> +					 void *aux__prog)
>  {
> -	struct bpf_prog_aux *aux =3D (struct bpf_prog_aux *)aux__ign;
> +	struct bpf_prog_aux *aux =3D (struct bpf_prog_aux *)aux__prog;
>  	struct bpf_async_kern *async =3D (struct bpf_async_kern *)wq;
>=20
>  	if (flags)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 28f5a7899bd6..f409a06099f6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -343,6 +343,7 @@ struct bpf_kfunc_call_arg_meta {
>  		int uid;
>  	} map;
>  	u64 mem_size;
> +	u32 arg_prog;

Nit: this is a boolean flag, I'd put it after `bool arg_owning_ref`,
     as there is a 3 bytes hole there.

>  };
>=20
>  struct btf *btf_vmlinux;

[...]

@@ -12906,6 +12912,17 @@ static int check_kfunc_args(struct bpf_verifier_en=
v *env, struct bpf_kfunc_call_
 		if (is_kfunc_arg_ignore(btf, &args[i]))
 			continue;
=20
+		if (is_kfunc_arg_prog(btf, &args[i])) {
+			/* Used to reject repeated use of __aux. */
                                                          ^^^^^^
                                               Nit: should be __prog.

+			if (meta->arg_prog) {
+				verbose(env, "Only 1 prog->aux argument supported per-kfunc\n");
+				return -EFAULT;
+			}
+			meta->arg_prog =3D regno;
+			cur_aux(env)->arg_prog =3D regno;
+			continue;
+		}
+
 		if (btf_type_is_scalar(t)) {
 			if (reg->type !=3D SCALAR_VALUE) {
 				verbose(env, "R%d is not a scalar\n", regno);


