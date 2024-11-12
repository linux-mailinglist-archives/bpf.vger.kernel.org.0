Return-Path: <bpf+bounces-44675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 794789C642C
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 23:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37467282A75
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 22:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8959218335;
	Tue, 12 Nov 2024 22:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eq2QI9Gd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B0F1531C4
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 22:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731450004; cv=none; b=Zj4gY3xdVVNOfC/NiU+vM+6mMSK7XKd2A27wJCnT6+L7AmsC9D6bHZFKsmpIyvunhkr92MUcBGkl00CNuQnUZOkLlGqGNr9FshYic3bCtME0YKMbt8r6IDrQ2WQ+1XJoHP3W4mmE1r0Z3tWC9JkGuEX5WOQjMp/TmETMhzb1lt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731450004; c=relaxed/simple;
	bh=hBcTCligV1yHljNXuGF9mBQaWOWqvNVdgDNfELYhk7k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mScRVtQQ4ajfry4fbIbGCU+RVlX6p6pByDnmDesVmUWMDWOgOsa72X4001561C4gziQCy7urgOiGygmzAhEHvsH6ZRmO9MOfn9pH65GDfb+gOIhz7wpvjtfyj8QN/mGkw+bKuq+E+8YC+ddoUWO9GMillA6iV0KaCcvG8P/qZh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eq2QI9Gd; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e52582cf8so4968041b3a.2
        for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 14:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731450002; x=1732054802; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CnMfWf1nT6Jxz7NWORldAbmaSG1pkEBboPt9ygYeN50=;
        b=Eq2QI9GdUKt3JXvHRiLgqrLOpuOOdHKJslGWbUpnH6niA2ne3LlR20aS9qjxAf7CF8
         v0AwTPgnDlV1j2n7P/UuzKqYn+xb1xO88hFYxYaGa1i38pXhGyjOrJvjLddg8dMNHdEu
         StHoPoEBweFFbDSoV57Zp3w80370wXLyRFKEq2spkrkb2gHJAmlrk3yozWS1CKfiwgAG
         1dt3QalJ+ZMYcdymNPPkneqXr5on/E+Vw+9yV3C00uKVtpQWyQZ2BjMmK1C9N9ZBzcXi
         kN6WJc8m9sHiExQZucH8EpaNH77EY6QroeYSsVIbvc1Zi1GH6wlVXmzJAihhsNsKHkd9
         Ikeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731450002; x=1732054802;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CnMfWf1nT6Jxz7NWORldAbmaSG1pkEBboPt9ygYeN50=;
        b=nkpDT7mxZavO2g7/eYSBOuKQRhrMfkvCtd96nmfKRDvH9LX5ciCjg5zOKAd5/VQfBo
         qJV9i4VJm2EwUpfPUWGqeTw5lcV2D/nZGChGaah2F5Z9mY8QiVO9Ck1YiQBCnlVEVsi0
         BRi/FY3pBPkGjISNrCznJ0w2+SohVA+zARDRK5qQegHnCcOLWaUMDCCokyRKKmVkNmlP
         RicyM8RzICisi8Jda/H8dN3r7N987Mn/Tfz4LQMHIDK4ybaptDIX65wuI6ZOrra8XvWh
         E/0R/iw/VF9hisjC+XMx+zDTESFu+7OvTGKoVBn6uQ/2iJqqBp3iE6vq/yRj4iC7qn1f
         sx0w==
X-Forwarded-Encrypted: i=1; AJvYcCWZQB0WSGqU+jFG7Ti5KNP0md33rJKhCSNamcNF7/ymK3qIICrTloqwjsIXwBB99i+msmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS1dT/lFi2g7TGch2gJO85nTyg91+QiS0hy6wMzJa/EbqecuvK
	ltAU9HKTZBPJZ4b7a4AT/t8NuPQFkEY4WkcBPOBrqC0gkq4A/hul
X-Google-Smtp-Source: AGHT+IFaAbuztNMHjS1LpnnEWtwmi1Hr84bB+M86uuZa+ZVQFc9D0zLIjKpPTIrQD0eclwWEJKUxLA==
X-Received: by 2002:a05:6a00:3988:b0:71e:ed6:1cab with SMTP id d2e1a72fcca58-724133b25e5mr21839987b3a.26.1731450002188;
        Tue, 12 Nov 2024 14:20:02 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a56a3esm11711894b3a.176.2024.11.12.14.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 14:20:01 -0800 (PST)
Message-ID: <4d2ee96cc12bf4bd84aa3e9716ce84793800f2f6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 1/4] bpf: add bpf_get_cpu_cycles kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Vadim Fedorenko
 <vadfed@meta.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Mykola Lysenko <mykolal@fb.com>, Jakub
 Kicinski <kuba@kernel.org>
Cc: x86@kernel.org, bpf@vger.kernel.org, Martin KaFai Lau
 <martin.lau@linux.dev>
Date: Tue, 12 Nov 2024 14:19:56 -0800
In-Reply-To: <c2936ebf75e76c77b04dc88aed9dacf8e784214a.camel@gmail.com>
References: <20241109004158.2259301-1-vadfed@meta.com>
	 <cd904b908d0d84c4f8454683495977f64d081004.camel@gmail.com>
	 <03bcf4ca-5e6f-4523-9661-46102b4f02b0@linux.dev>
	 <c2936ebf75e76c77b04dc88aed9dacf8e784214a.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-11-12 at 13:53 -0800, Eduard Zingerman wrote:
> On Tue, 2024-11-12 at 21:39 +0000, Vadim Fedorenko wrote:
>=20
> [...]
>=20
> > > > +			if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&
> > > > +			    imm32 =3D=3D BPF_CALL_IMM(bpf_get_cpu_cycles)) {
> > > > +				/* Save RDX because RDTSC will use EDX:EAX to return u64 */
> > > > +				emit_mov_reg(&prog, true, AUX_REG, BPF_REG_3);
> > > > +				if (boot_cpu_has(X86_FEATURE_LFENCE_RDTSC))
> > > > +					EMIT_LFENCE();
> > > > +				EMIT2(0x0F, 0x31);
> > > > +
> > > > +				/* shl RDX, 32 */
> > > > +				maybe_emit_1mod(&prog, BPF_REG_3, true);
> > > > +				EMIT3(0xC1, add_1reg(0xE0, BPF_REG_3), 32);
> > > > +				/* or RAX, RDX */
> > > > +				maybe_emit_mod(&prog, BPF_REG_0, BPF_REG_3, true);
> > > > +				EMIT2(0x09, add_2reg(0xC0, BPF_REG_0, BPF_REG_3));
> > > > +				/* restore RDX from R11 */
> > > > +				emit_mov_reg(&prog, true, BPF_REG_3, AUX_REG);
> > >=20
> > > Note: The default implementation of this kfunc uses __arch_get_hw_cou=
nter(),
> > >        which is implemented as `(u64)rdtsc_ordered() & S64_MAX`.
> > >        Here we don't do `& S64_MAX`.
> > >        The masking in __arch_get_hw_counter() was added by this commi=
t:
> > >        77750f78b0b3 ("x86/vdso: Fix gettimeofday masking").
> >=20
> > I think we already discussed it with Alexey in v1, we don't really need
> > any masking here for BPF case. We can use values provided by CPU
> > directly. It will never happen that within one BPF program we will have
> > inlined and non-inlined implementation of this helper, hence the values
> > to compare will be of the same source.
> >=20
> > >        Also, the default implementation does not issue `lfence`.
> > >        Not sure if this makes any real-world difference.
> >=20
> > Well, it actually does. rdtsc_ordered is translated into `lfence; rdtsc=
`
> > or `rdtscp` (which is rdtsc + lfence + u32 cookie) depending on the cpu
> > features.
>=20
> I see the following disassembly:
>=20
> 0000000000008980 <bpf_get_cpu_cycles>:
> ; {
>     8980: f3 0f 1e fa                   endbr64
>     8984: e8 00 00 00 00                callq   0x8989 <bpf_get_cpu_cycle=
s+0x9>
>                 0000000000008985:  R_X86_64_PLT32       __fentry__-0x4
> ;       asm volatile(ALTERNATIVE_2("rdtsc",
>     8989: 0f 31                         rdtsc
>     898b: 90                            nop
>     898c: 90                            nop
>     898d: 90                            nop
> ;       return EAX_EDX_VAL(val, low, high);
>     898e: 48 c1 e2 20                   shlq    $0x20, %rdx
>     8992: 48 09 d0                      orq     %rdx, %rax
>     8995: 48 b9 ff ff ff ff ff ff ff 7f movabsq $0x7fffffffffffffff, %rcx=
 # imm =3D 0x7FFFFFFFFFFFFFFF
> ;               return (u64)rdtsc_ordered() & S64_MAX;
>     899f: 48 21 c8                      andq    %rcx, %rax
> ;       return __arch_get_hw_counter(1, NULL);
>     89a2: 2e e9 00 00 00 00             jmp     0x89a8 <bpf_get_cpu_cycle=
s+0x28>
>=20
> Is it patched when kernel is loaded to replace nops with lfence?
> By real-world difference I meant difference between default
> implementation and inlined assembly.

Talked with Vadim off-list, he explained that 'rttsc nop nop nop' is
indeed patched at kernel load. Regarding S64_MAX patching we just hope
this should never be an issue for BPF use-case.
So, no more questions from my side.

[...]


