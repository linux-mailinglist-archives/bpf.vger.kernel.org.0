Return-Path: <bpf+bounces-54061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDBEA6184A
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 18:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B41189CD7F
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 17:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710342046AA;
	Fri, 14 Mar 2025 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4W0qntG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647D0202C55
	for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 17:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974083; cv=none; b=J1wzoqlExSLFU094+/QOWnWMHbSMndiTWaczyFDXeAntSOpclwxc9+kXMFGOKyE21MsFzPPpt+rw/2q9Ta2nrRNqzKmNYSH7ezdp07ZBAeXcr2m1jgTt5x/igOy1W5KC9cuArsqYzih0GpsfN8odabaNkK5IhSZ/oBvOVYat8jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974083; c=relaxed/simple;
	bh=jiFeCGclhdJ5VJaDDGmBaF3PfAqdO06la6OW5xDtvkE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CoZAegnikp/XWdHCSkEpVIXMoaMemquwzI1qCHdR54IeFBPEN2XoODrudLXWcBTAzsZ8XSwQi2Ul1CEdM24Fh+nLE8IxbmNrf7Wz2EArGBW0Ovf/NDWmIxcgaGCQHgZF8v0nrBTZk35yZOH4TIzDXl6/2CoKc2PdBIa1VIZ/r7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4W0qntG; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff80290debso4798667a91.3
        for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 10:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741974081; x=1742578881; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3TK7giTXev3oenDNdR62ku6P9bUYV7Ut/UdRtROTETA=;
        b=A4W0qntGwhm6AA6U016ESjcQ3LpQAkh8S8nRz/l1WhUnp8b15WZNlw6McNa9wGQ/m0
         DrW1puQFsr/4+/Sy0Nmd3Tk0HgdxSIQXotlxaaa7OfryVn38AY/WMjIUvLBT0Dr1lSq0
         g3GMgDkjJXvavHPEHTQLHyYpuOhuEhDexn0bUfG/yOvrGMl1ox+lJwqryqRAe5Q4UfHl
         GnYwkUy0ct+cN42E0vvlAPWPmVYa48526goe40yCrBwDsHmhb4K39TyJaUf4Y21iZQM9
         D2EKKbI+FwFRgD6sOH6lSc9/Kh0dXwD2MTatCLD1i7Tx6lpoFr6codGkWCrilugTUjEm
         zLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741974081; x=1742578881;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3TK7giTXev3oenDNdR62ku6P9bUYV7Ut/UdRtROTETA=;
        b=fKdFo8PDlhwtAfs1gn04PGfTaQX4IdlW7CSCd4DwDqvrvZXomMaQATOLmfM/5iS6US
         8k32WGf4YxVHHJGHitmUP1WTxt0VIpuYsTBJh447l/dOYmq1DMv9X3NUx8hFuOS0PS+I
         AHLT4ZRftC5Q3uvsxoXHISGyvcnqcQcUknry33rgS6sWmRlYiOqGdpegU7VlwUTyb7OA
         6acTsjYsVltPXwNSB8MTdxNQNGnCSiA9va5KDA2FVH/A+20G+AOZRRS0jXvaUOHUDo9p
         /jAr5fKhCsWWyXCH7mm5rtngP2JYbdQuXxGJEc8U3xoJTmEOb5gJDI8b0SZS1XxNtOJp
         voZw==
X-Gm-Message-State: AOJu0YxK/rcQgfutMxOAALpgV8dIAxN2NdbQmW8X/4h6ZhVInEYO3gt4
	4lYDlPQX++6Fjz3N7mX6469chlXZ35nH8g329HldMPO1uR4YP3q6oN5Nww==
X-Gm-Gg: ASbGncvaK39J4El2Hr4pbnIc4APZW8MGGu2PTDmBJbctJK55ycntoNgIUeW8/XGvfqz
	vv0RRmKrPOh5wdTy+W6CpGQUvKLINcpe8Awew9+A08OeIfAuP2V6ZveyXNmvLMrZ7G2ZezhF8+y
	IdkxLOF5xmN+xjvXsPQXskcnnuxpfHdHxX3kBxeg9d99zk5w4ewMl/kjhr3OM+9kR1ZT2G6o97k
	NRLbTSEtU0oSWiQnTiLwSDen99tGCVTOYQOpXZ1HBLHzP8Vfos8W1Q4YXd50fMktIWCJI7IY2fY
	JWz/WTuENPdcyziS6PW1FMp3etOI70foJI8ml4Pv
X-Google-Smtp-Source: AGHT+IHzpAYzziq53ckoHij1XeT+4uKVlkCaOGL/f5zQfCbXxfFMH++d8NSspNXMNMPvuOh8VH9Qkw==
X-Received: by 2002:a05:6a21:9005:b0:1f5:8678:183d with SMTP id adf61e73a8af0-1f5c1178019mr5059799637.14.1741974081300;
        Fri, 14 Mar 2025 10:41:21 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711550752sm3136098b3a.48.2025.03.14.10.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 10:41:20 -0700 (PDT)
Message-ID: <9190c8821684a6c75c524c58c6d54f7d9b2366e3.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: states with loop entry have
 incomplete read/precision marks
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev
Date: Fri, 14 Mar 2025 10:41:16 -0700
In-Reply-To: <3c6ac16b7578406e2ddd9ba889ce955748fe636b.camel@gmail.com>
References: <20250312031344.3735498-1-eddyz87@gmail.com>
	 <3c6ac16b7578406e2ddd9ba889ce955748fe636b.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-03-13 at 12:28 -0700, Eduard Zingerman wrote:

[...]

> Which makes me wonder.
> If read/precision marks for B are not final and some state D outside
> of the loop becomes equal to B, the read/precision marks for that
> state would be incomplete as well:
>=20
>         D------.  // as some read/precision marks are missing from C
>                |  // propagate_liveness() won't copy all necessary
>     .-> A --.  |  // marks to D.
>     |   |   |  |
>     |   v   v  |
>     '-- B   C  |
>         ^      |
>         '------'
>=20
> This makes comparison with 'loop_entry' states contagious,
> propagating incomplete read/precision mark flag up to the root state.
> This will have verification performance implications.
>=20
> Alternatively read/precision marks need to be propagated in the state
> graph until fixed point is reached. Like with DFA analysis.
>=20
> =D0=A0=D0=B5=D1=88=D0=B5=D1=82=D0=BE.

And below is an example that verifier does not catch.
Another possibility is to forgo loop entries altogether and upon
states_equal(cached, cur, RANGE_WITHIN) mark all registers in the
`cached` state as read and precise, propagating this info in `cur`.
I'll try this as well.

--- 8< --------------------------------
SEC("?raw_tp")
__flag(BPF_F_TEST_STATE_FREQ)
__failure __msg("misaligned stack access off 0+-31+0 size 8")
__naked int absent_mark_in_the_middle_state2(void)
{
	asm volatile (
		"call %[bpf_get_prandom_u32];"
		"r8 =3D r0;"
		"r7 =3D 0;"
		"r6 =3D -32;"
		"r0 =3D 0;"
		"*(u64 *)(r10 - 16) =3D r0;"
		"r1 =3D r10;"
		"r1 +=3D -8;"
		"r2 =3D 0;"
		"r3 =3D 10;"
		"call %[bpf_iter_num_new];"
		"call %[bpf_get_prandom_u32];"
		"if r0 =3D=3D r8 goto change_r6_%=3D;"
		"call %[bpf_get_prandom_u32];"
	"before_loop_%=3D:"
		"if r0 =3D=3D r8 goto jump_into_loop_%=3D;"
	"loop_%=3D:"
		"r1 =3D r10;"
		"r1 +=3D -8;"
		"call %[bpf_iter_num_next];"
		"if r0 =3D=3D 0 goto loop_end_%=3D;"
		"call %[bpf_get_prandom_u32];"
		"if r0 =3D=3D r8 goto use_r6_%=3D;"
		"goto loop_%=3D;"
	"loop_end_%=3D:"
		"r1 =3D r10;"
		"r1 +=3D -8;"
		"call %[bpf_iter_num_destroy];"
		"r0 =3D 0;"
		"exit;"
	"use_r6_%=3D:"
		"r0 =3D r10;"
		"r0 +=3D r6;"
		"r1 =3D 7;"
		"*(u64 *)(r0 + 0) =3D r1;"
		"goto loop_%=3D;"
	"change_r6_%=3D:"
		"r6 =3D -31;"
	"jump_into_loop_%=3D: "
		"goto +0;"
		"goto loop_%=3D;"
		:
		: __imm(bpf_iter_num_new),
		  __imm(bpf_iter_num_next),
		  __imm(bpf_iter_num_destroy),
		  __imm(bpf_get_prandom_u32)
		: __clobber_all
	);
}
-------------------------------- >8 ---

[...]


