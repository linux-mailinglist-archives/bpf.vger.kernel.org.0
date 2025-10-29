Return-Path: <bpf+bounces-72915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E522CC1D866
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 22:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ABAE423AEC
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 21:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590B42ED871;
	Wed, 29 Oct 2025 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clERfNQr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B5F2EB876
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 21:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761774864; cv=none; b=lfXKzpX5Xww8IP1J8z0FMVdM6jOw9r1+JiGWIIf3kKx2CWJ4LCZcy+dg1uLRZ+yBMWGUO/85lcMQU+242Q6lUOA5gceTzaEKiRMYmBp+tD3a7YKg8lnHwrBYVUv1Ws0gWCrK93WgNhIAH1iH1GlxawsLwk4rWIuLzRrHfeMPkio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761774864; c=relaxed/simple;
	bh=bFsGipifmOAlOATBM0GiPjT7XElOo9Q8O4cc40lg7UQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YABgGTkhXRJm6dsmtCCWUs73UamACG4OZqR86OHhnscwqNjjNSFD7irbej+dZtK4HPaNmLwP/sSeF2ieh5OYIRYa3JmUIBuQpf7QTtZII6KpySSf+7xRcPwGPbfFVKJs1qSwYyZWbpqlYHU0yMy4/jwvDsSumomkFa3pxKx96WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clERfNQr; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-290b48e09a7so3984625ad.0
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 14:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761774863; x=1762379663; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5S7Csn06evKlEBZcNhMcpM7zqLNVS1pqfkCMO4xnN4=;
        b=clERfNQryn25CzV4YmTUM46BdK+N+SwK0t1OyIzmiTaSJXQWrijZ0aUYQGF2VQP1pW
         x9ueaTfKHWzGWo4wHfryJrtpLbVNbIYkY4WMx4QcaqXL2MjL+BjycSAcf1Yvk5hs5xUF
         FQI++5O213TsAfqFc/pXuMohVTlSLNOK7VwEHzGMpp8VmE4Yz1u1SxHWKCe5JvlthziV
         1Fe155j7x4JjSAwRxf3RTofo4jJbHSfzqXXl4MEg3rKc7Oy7T0Ua7QHei2w2hlEgzLJS
         ZUDe1FqAH4Xa5f+1osog7+PvlXd9t7oOzfv6zKMJvSqXlZ4mpsidLEKaQ9jt19y+7e12
         ZAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761774863; x=1762379663;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t5S7Csn06evKlEBZcNhMcpM7zqLNVS1pqfkCMO4xnN4=;
        b=HeM5wLSCJGNb39GxN6vwnnFPPTrAYkM1QWG0ZtYoZV4IODKNw74omjYpucsCRrncg2
         Eg/oZqCmEFGtsdMI4sqlSBKbdsCy/0KC1Lo9TTMyFXPm4SBzlSeUVWYKYBvLKTfLZnP+
         Dpp9l43fzLs/EZPjNyYkREW8pGz+09emLasmc5oRFllIVjmrHFUG8UFihCl6n8lAPSJ+
         gdhfkb2pTZhuJLAE7vR1y+wqqoLGe63YMQ/BJl0jcgi/zT8WXNmCcGoCnmdxI9y0uXMv
         LhIZuFJ7S70FHXJQqVWZ9UGVSxtTh403yd7HQvUV/Ene1L6RI+8+OHDi8duVJ1yyorMX
         hlLA==
X-Forwarded-Encrypted: i=1; AJvYcCUR2aYiOrKX9ixLVrRm/wgypQBniOvPSsGbtHA3j0D06z3RqYZ+jm6G/ZYwr6Ft2rOuoMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz21lbFdKSKq7XMw449eN0GUwgT02oLLgG9vv4OOapSsbc18MCL
	Jq4qteJXqQ3LvpVjElQQebXw3in+80qiROQxUfZwCVLZgC852DKmabyS
X-Gm-Gg: ASbGnctIKXXNmZv84fFQ4jnk93MJS1Y4FlpMQyp1A4BT2VF/ilicXsBpZCD1+wYXbg7
	fXfpl4oW//aawOjMyWUcmQOw0o0b+y9MThp6cjrvIcJgdV0WWD81yydY/h4V0AMQpMEFTc62W5c
	Pn2LHCkQg5pSrfrDlFtphimHEPLIgxBk9EvM5CcS28vUG9889mxNHWkXVDhVhUW99uf9/bwSvMP
	rvQKrcSejgGhmdwXNg1dwFwELnwytorfxkOG35pcThMaDSzfB5bIbwus1jgq6996mPEkEMsRzmS
	M7062rV2df7y3HYJXkSHuo1noIBWnQh41TKiLAkZOEIdaIRhB5ma1XQW1YEhgSEKxiJmWXoDNyG
	lW7NjHI7Vr76nM4WHZkMNVyy0rIFvWE/yYKSFDyz5bb0yPGYv/iJfs1Assam4S5UWq2Yar3Zz31
	cJ2Fl4zeg50XJ35YZes6o0ujlwBQ==
X-Google-Smtp-Source: AGHT+IFk8KeiGtMSnqpDA6XCVtCzz1SyNaqUd4vnU0pk10PiaioStEPoa6mHOy5kFM12jQmKUEoUKw==
X-Received: by 2002:a17:903:8d0:b0:27e:ec72:f50 with SMTP id d9443c01a7336-294deee4c0dmr50775125ad.51.1761774862668;
        Wed, 29 Oct 2025 14:54:22 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:3086:7e8a:8b32:fa24? ([2620:10d:c090:500::5:6b34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0a60fsm161780735ad.39.2025.10.29.14.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 14:54:22 -0700 (PDT)
Message-ID: <222f464289f2cf3ffff220967c51f8acebbeaec3.camel@gmail.com>
Subject: Re: [PATCH v7 bpf-next 01/12] bpf, x86: add new map type:
 instructions array
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Wed, 29 Oct 2025 14:54:21 -0700
In-Reply-To: <20251026192709.1964787-2-a.s.protopopov@gmail.com>
References: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
	 <20251026192709.1964787-2-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-10-26 at 19:26 +0000, Anton Protopopov wrote:
> On bpf(BPF_PROG_LOAD) syscall user-supplied BPF programs are
> translated by the verifier into "xlated" BPF programs. During this
> process the original instructions offsets might be adjusted and/or
> individual instructions might be replaced by new sets of instructions,
> or deleted.
>=20
> Add a new BPF map type which is aimed to keep track of how, for a
> given program, the original instructions were relocated during the
> verification. Also, besides keeping track of the original -> xlated
> mapping, make x86 JIT to build the xlated -> jitted mapping for every
> instruction listed in an instruction array. This is required for every
> future application of instruction arrays: static keys, indirect jumps
> and indirect calls.
>=20
> A map of the BPF_MAP_TYPE_INSN_ARRAY type must be created with a u32
> keys and value of size 8. The values have different semantics for
> userspace and for BPF space. For userspace a value consists of two
> u32 values =E2=80=93 xlated and jitted offsets. For BPF side the value is
> a real pointer to a jitted instruction.
>=20
> On map creation/initialization, before loading the program, each
> element of the map should be initialized to point to an instruction
> offset within the program. Before the program load such maps should
> be made frozen. After the program verification xlated and jitted
> offsets can be read via the bpf(2) syscall.
>=20
> If a tracked instruction is removed by the verifier, then the xlated
> offset is set to (u32)-1 which is considered to be too big for a valid
> BPF program offset.
>=20
> One such a map can, obviously, be used to track one and only one BPF
> program.  If the verification process was unsuccessful, then the same
> map can be re-used to verify the program with a different log level.
> However, if the program was loaded fine, then such a map, being
> frozen in any case, can't be reused by other programs even after the
> program release.
>=20
> Example. Consider the following original and xlated programs:
>=20
>     Original prog:                      Xlated prog:
>=20
>      0:  r1 =3D 0x0                        0: r1 =3D 0
>      1:  *(u32 *)(r10 - 0x4) =3D r1        1: *(u32 *)(r10 -4) =3D r1
>      2:  r2 =3D r10                        2: r2 =3D r10
>      3:  r2 +=3D -0x4                      3: r2 +=3D -4
>      4:  r1 =3D 0x0 ll                     4: r1 =3D map[id:88]
>      6:  call 0x1                        6: r1 +=3D 272
>                                          7: r0 =3D *(u32 *)(r2 +0)
>                                          8: if r0 >=3D 0x1 goto pc+3
>                                          9: r0 <<=3D 3
>                                         10: r0 +=3D r1
>                                         11: goto pc+1
>                                         12: r0 =3D 0
>      7:  r6 =3D r0                        13: r6 =3D r0
>      8:  if r6 =3D=3D 0x0 goto +0x2         14: if r6 =3D=3D 0x0 goto pc+=
4
>      9:  call 0x76                      15: r0 =3D 0xffffffff8d2079c0
>                                         17: r0 =3D *(u64 *)(r0 +0)
>     10:  *(u64 *)(r6 + 0x0) =3D r0        18: *(u64 *)(r6 +0) =3D r0
>     11:  r0 =3D 0x0                       19: r0 =3D 0x0
>     12:  exit                           20: exit
>=20
> An instruction array map, containing, e.g., instructions [0,4,7,12]
> will be translated by the verifier to [0,4,13,20]. A map with
> index 5 (the middle of 16-byte instruction) or indexes greater than 12
> (outside the program boundaries) would be rejected.
>=20
> The functionality provided by this patch will be extended in consequent
> patches to implement BPF Static Keys, indirect jumps, and indirect calls.
>=20
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

[...]

> +void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, void *jit_priv,
> +			       update_insn_ptr_func_t update_insn_ptr)
> +{
> +	struct bpf_insn_array *insn_array;
> +	struct bpf_map *map;
> +	u32 xlated_off;
> +	int i, j;
> +
> +	for (i =3D 0; i < prog->aux->used_map_cnt; i++) {
> +		map =3D prog->aux->used_maps[i];
> +		if (!is_insn_array(map))
> +			continue;
> +
> +		insn_array =3D cast_insn_array(map);
> +		for (j =3D 0; j < map->max_entries; j++) {
> +			xlated_off =3D insn_array->values[j].xlated_off;
> +			if (xlated_off =3D=3D INSN_DELETED)
> +				continue;
> +			if (xlated_off < prog->aux->subprog_start)
> +				continue;
> +			xlated_off -=3D prog->aux->subprog_start;
> +			if (xlated_off >=3D prog->len)
> +				continue;
> +
> +			update_insn_ptr(jit_priv, xlated_off,
> +					&insn_array->values[j].jitted_off,
> +					&insn_array->ips[j]);
> +		}
> +	}
> +}

Thank you for this update, I think it looks a tad simpler now.

[...]

