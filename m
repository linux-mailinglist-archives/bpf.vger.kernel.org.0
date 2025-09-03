Return-Path: <bpf+bounces-67243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1333B41115
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 02:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313BC1A877E3
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 00:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21949475;
	Wed,  3 Sep 2025 00:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJ22iuAd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0818110942
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 00:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756857700; cv=none; b=EERwAgAFwpHUxkGS1xf8tlN6zLrX/5jFE2BtrayyU/uNmCOg0oLfBt5cGiv8/BHyMB8YrpCNH2vcDH/H4slFJG4N/By2Rwn2Q1gCivU1ombq0haYqRtq8bjxCCccePOZG+f8et+S4YBa0eodyQgzjRhhZR/L/iTReyUZzneFrlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756857700; c=relaxed/simple;
	bh=VSW/bS72bvM+KbfttMQOiHzkGfWfpN8er+vWDm7hvyk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dQ8KZ2Ea9E53uDATjbDptrX/5x2I47uA9Ozrq7c7u66w5XqIGK9a6D1yibnrFzxY//LLJPHV0/9yJXlruN11lahvjJOXsnvWeB+38wyLkwKC6nBkGwus6/ftLXi0h/40xXiz0F66e03TtnA4WFPlwu9mcvLgNJSdnWjFIuMFkLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJ22iuAd; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7722f8cf9adso4693629b3a.0
        for <bpf@vger.kernel.org>; Tue, 02 Sep 2025 17:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756857698; x=1757462498; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNt9Hx58aiHlDNkMoGnP94NMrCDmHPdVfPwHcmPR/V0=;
        b=RJ22iuAdRsXtQuk+E7DIMjUAKHi+6mV8NRv4x0mSCWUY79XZfyk/Qmwi7fIycNmf2I
         vhmripjsFp+AbYZlaesu6j7ssbvsAJAdKHE6oecRnqLfleJGUMNT33tVW7YbOssoBro2
         3TZxDIiaggOS/1eNDwgKn5wAxb0NGIRN+JUOT9c/d7fqgzBAX0Z8WtNdnSNPjARQZcr7
         DkgyHtfD4wEt3hOi2lD+Q3cHMy9wk7A0Mu65/v33lsfP6Wbci4jxZI09+xrmin+b17lq
         gvs69LK9kV6d4O4dOtkCs6q/C8W6YyJMtsndEsGG7H7E/1JgxdC6n1Fs1N8Iln8xbdWb
         ZfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756857698; x=1757462498;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pNt9Hx58aiHlDNkMoGnP94NMrCDmHPdVfPwHcmPR/V0=;
        b=lvPmcwgekB2DQXflrmcJ6kW9tUngZeatfbTMtQyNfeG9BT99q6IO/smUKCHJXm7W7N
         Zcm7G5Sr4ccacVyX/zSHSqcqtf/qx3aIqc/HE8TXuwDsgWxpliOB5obnuI+oCWgiW5Cw
         dyyKt7CKDjkIHxEyCWILy3Tpd7dCqrMTfv+z0LrX26ScHf6MV+jN0qpUbLt1OyyiAr+W
         rJYQQeLVelBPPZPaYAaKqSmTfk5QDgSvNrOTQ1IzUkl0X4jNhfqQEea2Li1JepGHI+nD
         DEd57cC9srt2L+iMJ5trdfqTFplc2Ka6/Mp/3/UyFKop0SMVFJYWJHvTbQqfEbanJ00B
         lxqg==
X-Forwarded-Encrypted: i=1; AJvYcCXBIZfQF5ZvvuooBHJO1wmmjD3lQ8qUhB5f2HoM071YEkYdpNw8R36JykHd3IuJ5yFdE1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO9SJAmmINgyFQvRlkwoaFXXg1Iv8Fc9W+hiXBuYPgRWyh2PJx
	2+t8GkjWVtkdOiDp+iLyMzXoTlMpfbJw+IPLJmT5QRBuB61JyiqJMFIa
X-Gm-Gg: ASbGnctdCliPPNYPZ0sJY/LM4AAKyLyrZroklFVA/PiubHLQ+8w9nWyk7sf1sUB9v/H
	Jy0/pZYfxItHOaLOwmVf2JjjAhj7UqzQpaNM583Yjp3rdD0g9hs5icSd2GCLtjhhIyWkdDv2alv
	Cr7eJE20uGrSmv7GT8czTJUzhwZyu1zUEt/aSIvOK0PMEJFST0IGe7MU2qauzmX52fXdA+H+GoI
	+Sl5ohdgpy41s/RTAr4wtT7dRQ+PoETPEmzmTTyKrbrbmTiz8EYEPnvYzDLPxQImARaNrvuYLAR
	wZyiMGT/WRMhm8L44RsuS1oTtJ3DHItEgjEH4MGnpzJuTSBKduxrUGFewmX+w/P7EGlGQpD9Z0A
	V1CrOi7DSccuIS800E1js1vAlQI6GcaBSKNizEUG+cCGQ+SY+
X-Google-Smtp-Source: AGHT+IEXyi8hvPpxI2kcdFkTwkr3eI+NuZ5hy2TR0+von1WpSNeEmU/OjahL6eiL9oBFPn+5Km6XJw==
X-Received: by 2002:a05:6a20:6a09:b0:246:6d1:de50 with SMTP id adf61e73a8af0-24606d1e0f9mr1936059637.35.1756857697913;
        Tue, 02 Sep 2025 17:01:37 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:8bb9:7ccc:ab52:ac92? ([2620:10d:c090:500::6:ea99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77241f08b45sm10843219b3a.22.2025.09.02.17.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 17:01:37 -0700 (PDT)
Message-ID: <f41d83899f6d2dda1b55fe7f91f0816b9e23361a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 3/4] bpf: Report arena faults to BPF stderr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon	 <will@kernel.org>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, 	bpf@vger.kernel.org
Date: Tue, 02 Sep 2025 17:01:35 -0700
In-Reply-To: <20250901193730.43543-4-puranjay@kernel.org>
References: <20250901193730.43543-1-puranjay@kernel.org>
	 <20250901193730.43543-4-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-01 at 19:37 +0000, Puranjay Mohan wrote:
> Begin reporting arena page faults and the faulting address to BPF
> program's stderr, this patch adds support in the arm64 and x86-64 JITs,
> support for other archs can be added later.
>=20
> The fault handlers receive the 32 bit address in the arena region so
> the upper 32 bits of user_vm_start is added to it before printing the
> address. This is what the user would expect to see as this is what is
> printed by bpf_printk() is you pass it an address returned by
> bpf_arena_alloc_pages();
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Fwiw, aside from a nit below the patch looks good to me.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 7e3fca1646203..644424ae5e5d2 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[...]

> @@ -2089,8 +2143,25 @@ st:			if (is_imm8(insn->off))
> =20
>  				ex->data =3D EX_TYPE_BPF;
> =20
> -				ex->fixup =3D (prog - start_of_ldx) |
> -					((BPF_CLASS(insn->code) =3D=3D BPF_LDX ? reg2pt_regs[dst_reg] : DON=
T_CLEAR) << 8);
> +				is_arena =3D (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM32) ||
> +					   (BPF_MODE(insn->code) =3D=3D BPF_PROBE_ATOMIC);

Nit:
It looks like label `populate_extable` is always reachable from either
BPF_PROB_MEM32 or BPF_PROBE_ATOMIC instruction. Non-arena use cases
for BPF_PROBE_MEM{,SX} are handled separately. So, it appears that
this condition is always true.

> +
> +				fixup_reg =3D (BPF_CLASS(insn->code) =3D=3D BPF_LDX) ?
> +					    reg2pt_regs[dst_reg] : DONT_CLEAR;
> +
> +				ex->fixup =3D FIELD_PREP(FIXUP_INSN_LEN_MASK, prog - start_of_ldx) |
> +					    FIELD_PREP(FIXUP_REG_MASK, fixup_reg);
> +
> +				if (is_arena) {
> +					ex->fixup |=3D FIXUP_ARENA_ACCESS;
> +					if (BPF_CLASS(insn->code) =3D=3D BPF_LDX)
> +						arena_reg =3D reg2pt_regs[src_reg];
> +					else
> +						arena_reg =3D reg2pt_regs[dst_reg];
> +
> +					ex->fixup |=3D FIELD_PREP(FIXUP_ARENA_REG_MASK, arena_reg);
> +					ex->data |=3D FIELD_PREP(DATA_ARENA_OFFSET_MASK, insn->off);
> +				}
>  			}
>  			break;
> =20

[...]

