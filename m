Return-Path: <bpf+bounces-78757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6ECD1B770
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 22:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 690E43032703
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 21:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9807E34E74B;
	Tue, 13 Jan 2026 21:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XX5fxWYo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DA9245008
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 21:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768340637; cv=none; b=OnJDq52GNcs7EsgTXaCFi2dC43j4JpP1+QTVo7SrO5WC3OvmfJpLIzlFTIZnIPjFlC4LpVFXoj4iBTUqUw9MNeh86e0lFmKMDyFDFrgBRspK79OC5B8EfuByZqIAhouLsn3cDKeyYf0uHoM//rClmT6ESXnuucJ6N0Nkq/xQxR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768340637; c=relaxed/simple;
	bh=7bsUtiUgKGUde2s0C0zgl5rK6a734yalkgEEbvzprU8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dM7LKexbZnFo+kRvlPi4DRQxcqlathMbhXpIYm8ZHyF32VxjbuvtufcWsNVN5EqTRxu/M7C3JYM4NHw45OrT9ZMQ6GtTRqjWKX2+//Xxc3DQSXXKrpFSHFa0XJhfFJTSj85AMQud+e4jPdQPigDNfWQAr5g/nLOzlsFyt8AuB3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XX5fxWYo; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34c213f7690so5339566a91.2
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 13:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768340635; x=1768945435; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PYn6o6R3QSwAggtOWvfLgCyBT+NI/AbWRIt35aBXUGU=;
        b=XX5fxWYoh2zuqsT9qzsPCHUujkkeQZyAzxHK+I2nP09zSGwNtSLXyx712YM1O+R0GS
         nq53ErMS8IL9xqWq4SQWyECVwrJvBcJHP4tDYi86PsuSbLwalkjuEcmFZIbD6F93iI+M
         RPPvZlFNl5lQZjmV1j7EugBLknfHTh3mi1MRzesiXdO6sRKkT/cV4Yypr6wRfenOqIw/
         SD0oWFN0rN1L77mHgc+ZUvRSecUN9GD/szZ8ZlKfwBvZuIvbXVHbk77VnllE5k2EiCSa
         /TrLMO08tV1mdktmTlI0Ak4ZN4MlhVQCMtdVUH2O+QtWhGYc8A2rl/N3ZZzMzxdMgD9P
         bX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768340635; x=1768945435;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYn6o6R3QSwAggtOWvfLgCyBT+NI/AbWRIt35aBXUGU=;
        b=jQ0/kb1Qc297wiM4EcrQSK3Ddx+xH218MZAnL6lXO76YonIoFWXz71HQWHcq9Nod/w
         9lgCwwsbPRcAFa/rkzOJrFlaMm2M2IO0cLLcQREj2nTm4FJ1u3GyDlErZw24achD8Y4V
         jVolWMSLyQmAHKvxDBHy5Nsv/NTk1N1KiGtvJ7O6xIP89AR1ykMo+t9y2mjcJd0jhk30
         FoPncL49YEGg2/UqyJBTQ9HqpJMRjTzE8WgiX7n7sGhMAejCnPahWzkQnVyeGL6b6Jm2
         lM8xFDIR31x5dZg+F6k4ZNOMcW4QZ0DDR0DVqaYecHdoGlnz08/rP2QizC5toVCTZ2G3
         fFfA==
X-Forwarded-Encrypted: i=1; AJvYcCVaIFTCe0JBKDP5eluIABH49kGZWSn5vctPG2lYKXK4yDvR9+UHUCkibzbM884hQqwhn6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqMUE6VT10NvVKNj7kf4Fu3dchWmwh13bbejFlfnUVJ8R3xV+5
	KjYYEb/hWoGtK/2jWpZzTKV42sRJ/mY0gyOWRugBzEU0NSq0GrEC7Zrp
X-Gm-Gg: AY/fxX7V22vzFUSUip/a5Q5Czc0NMKcHkqR00YNGeKkmUPFrK9OXClaT9CYe6Wz9uwU
	qAAWQVML3jQGQMHrlay2Z6Npc6NjVxs9wTGUoS8nX1RLEpeaAcNncrQ6ZBTrr95NSBwtyb9Nbck
	4W1l9IGlhwRRXOSVBgehHrlDm3H3dKUoK9zFfntWRCnU5mWCL+0ACdmKoBeDaw21d4UJuNrU/B7
	cpPK23HLDZfOYMzYfYJX5PXqbKXBVGiO6T8Iq4dvGzmnCSZ5jedF6jziMusl3aYXXDka5lwYStS
	kvFhkbzg1Em8CGrqQUQJYxx8yN6Dz8hnnjfOqaOGQCBX+S1O/DfgR/9C5geTLNWEBHcsZRaC4SX
	JH2JMWl+Phk+t3xT+hxEHVu+5/ZyRFpD5tkby4jNeTKPmYJgYWvWmaUD2nN7Tv6ZLdWoX/ExuJB
	6dNRXNWURpgB2LdX2U8YL0qBkDmMgeSVtgw8bNomK4
X-Received: by 2002:a17:90b:2e8b:b0:343:7714:4caa with SMTP id 98e67ed59e1d1-35109086381mr473677a91.3.1768340635072;
        Tue, 13 Jan 2026 13:43:55 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-351068fe22esm364539a91.2.2026.01.13.13.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 13:43:54 -0800 (PST)
Message-ID: <6a9a60f292e3ce862accd782bd43f8dc2491bca4.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 01/10] bpf: Refactor
 btf_kfunc_id_set_contains
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-input@vger.kernel.org,
 sched-ext@lists.linux.dev
Date: Tue, 13 Jan 2026 13:43:51 -0800
In-Reply-To: <20260109184852.1089786-2-ihor.solodrai@linux.dev>
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
	 <20260109184852.1089786-2-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-01-09 at 10:48 -0800, Ihor Solodrai wrote:
> btf_kfunc_id_set_contains() is called by fetch_kfunc_meta() in the BPF
> verifier to get the kfunc flags stored in the .BTF_ids ELF section.
> If it returns NULL instead of a valid pointer, it's interpreted as an
> illegal kfunc usage failing the verification.
>=20
> There are two potential reasons for btf_kfunc_id_set_contains() to
> return NULL:
>=20
>   1. Provided kfunc BTF id is not present in relevant kfunc id sets.
>   2. The kfunc is not allowed, as determined by the program type
>      specific filter [1].
>=20
> The filter functions accept a pointer to `struct bpf_prog`, so they
> might implicitly depend on earlier stages of verification, when
> bpf_prog members are set.
>=20
> For example, bpf_qdisc_kfunc_filter() in linux/net/sched/bpf_qdisc.c
> inspects prog->aux->st_ops [2], which is initialized in:
>=20
>     check_attach_btf_id() -> check_struct_ops_btf_id()
>=20
> So far this hasn't been an issue, because fetch_kfunc_meta() is the
> only caller of btf_kfunc_id_set_contains().
>=20
> However in subsequent patches of this series it is necessary to
> inspect kfunc flags earlier in BPF verifier, in the add_kfunc_call().
>=20
> To resolve this, refactor btf_kfunc_id_set_contains() into two
> interface functions:
>   * btf_kfunc_flags() that simply returns pointer to kfunc_flags
>     without applying the filters
>   * btf_kfunc_is_allowed() that both checks for kfunc_flags existence
>     (which is a requirement for a kfunc to be allowed) and applies the
>     prog filters
>=20
> See [3] for the previous version of this patch.
>=20
> [1] https://lore.kernel.org/all/20230519225157.760788-7-aditi.ghag@isoval=
ent.com/
> [2] https://lore.kernel.org/all/20250409214606.2000194-4-ameryhung@gmail.=
com/
> [3] https://lore.kernel.org/bpf/20251029190113.3323406-3-ihor.solodrai@li=
nux.dev/
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

> @@ -8715,6 +8730,26 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_pr=
og_type prog_type)
>  	}
>  }
> =20
> +bool btf_kfunc_is_allowed(const struct btf *btf,
> +			  u32 kfunc_btf_id,
> +			  const struct bpf_prog *prog)
> +{

Nit: I'd just add hook parameter to btf_kfunc_flags():

     u32 *btf_kfunc_flags(const struct btf *btf, u32 kfunc_btf_id, const st=
ruct bpf_prog *prog,
                          enum btf_kfunc_hook *hook)

     and allow passing NULL there, thus avoiding duplicating logic for comm=
on hook.

> +	enum bpf_prog_type prog_type =3D resolve_prog_type(prog);
> +	enum btf_kfunc_hook hook;
> +	u32 *kfunc_flags;
> +
> +	kfunc_flags =3D btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_COMMON, k=
func_btf_id);
> +	if (kfunc_flags && __btf_kfunc_is_allowed(btf, BTF_KFUNC_HOOK_COMMON, k=
func_btf_id, prog))
> +		return true;
> +
> +	hook =3D bpf_prog_type_to_kfunc_hook(prog_type);
> +	kfunc_flags =3D btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
> +	if (kfunc_flags && __btf_kfunc_is_allowed(btf, hook, kfunc_btf_id, prog=
))
> +		return true;
> +
> +	return false;
> +}
> +
>  /* Caution:
>   * Reference to the module (obtained using btf_try_get_module) correspon=
ding to
>   * the struct btf *MUST* be held when calling this function from verifie=
r

[...]

