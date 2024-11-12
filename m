Return-Path: <bpf+bounces-44672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51FA9C63D0
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 22:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A97EE28608A
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 21:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662CE218D6B;
	Tue, 12 Nov 2024 21:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVDrmUfh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834AF218594
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 21:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731448398; cv=none; b=jYZwcEO1+Yf+dnNPcGGMWMHVCbz7b9KfBDSmxAjBTjRFjizw+Haz3kwnFURUIWo+Qu9au3b3HNPwDwLbCLnCgaq+sa2ekhNqEGseYu7k4tjNFWZkM/nvZHeqmshYUIViiLDE7mFNgrtRgvDZMjY4fsafui8uJVHt7Nwr9lB/SAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731448398; c=relaxed/simple;
	bh=jYyB/j8VbEEQKZQ0YNRpScbe3o+liHhRiMy733K6re4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DKC8QzBw9uk9AJR9u4igj44pZ3KmltlzBKI9hksp+NrZxB18z9Fj/xDkcU2j8DwghQj27G4/7/i9X2SGh3YvKMayQ28k3fxSTbmt1DcFx3nNR0du4HFjvrsSybYWZHD0ZNgEgtNa46+vGBXoBJ+77ekJslA2u2xazI+HLiYfyZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVDrmUfh; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-724455f40a0so1477648b3a.0
        for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 13:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731448396; x=1732053196; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JmDSPaVv4LtDiwHraqQ+SB2rCXteTHzo7WWaKcb06qI=;
        b=EVDrmUfhbvb0fuIYN33e4KlV7v4My+uiZV2K19AQlDuFlIiDkjngSw/GZ4rQpBlshA
         Z8nBGczaE7EtpfwoUQcxEEA5EKYK1/ykXXq1/lxQB8boWJmpjyfGHHcJEK7sVS8ZjUoD
         07N2F21mHBNZuANNQUZ3a0iMBGtb1YWXTiP15JFWpJ5625qh77h+wDw1trm4610qCE3u
         kwTDHxNdcFRe9LbVxr8m/+4Us6iNrfF/+OqYyRbr4+V+9s9oICDmGwxMvzLXJyXNx8lJ
         TwNEnk1bRDcP6v3mAPBybd0nq7Xsyk23OMivlhXM1EuSOnfR+DIlHT0W19LH0Wp7BFFm
         vLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731448396; x=1732053196;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JmDSPaVv4LtDiwHraqQ+SB2rCXteTHzo7WWaKcb06qI=;
        b=SWA0/A31wXjIpvfuTMThuzjeNJBb7w031XYgIQBD8Qtcny1amrvXUa3tsIE0Idv7WH
         TVCjW/Lqmp1sE7EzkBz/N/a8ilaHD8xabzZbvS4KQ/6g67MMZ55pEByspf6TKd/7BcpR
         c0KDRWwawR8+rOHUhSb2qDs9vz9vPICb39YJAsUJMRc02Kan44jF9UJ3KgXHp7dHy4sw
         BxfZJeVpc0VuIeHAvXZ63ruhOoQLRA0kmIK/6C2EPToS8bZwoxcrRiC1FxNipnJXAzuq
         tTRj1RXDU8pzlHrjYxebqTV7Pti2p3+P/OS+/cReZ+DNEGZvTfW0okuy+dA+aKlu/MLG
         kkFA==
X-Forwarded-Encrypted: i=1; AJvYcCUx44heD9sXJCdBpJvitXMSoAanprEGHLrKCctBEywosNONDrOJKvOB2IKolxcTcqmI1xc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr/PNjkEzkFeurBjHOtuzdyQSSkzTg7wSMglblpn82bZWGcgOT
	NCvJ3FGdZtPN9Ilo9B6+zHoL+M7QUT6J6Hx0bwRSOI/zPhX/HWAB
X-Google-Smtp-Source: AGHT+IHI8xz0IGIMDydznMO86Y7pv7dt/opx33F169fg6wkvC4zYyZ48NSNSCBZNmmJkz5qEMIHuBA==
X-Received: by 2002:a05:6a00:2ea8:b0:71e:6046:87c2 with SMTP id d2e1a72fcca58-724133b7d62mr21282678b3a.26.1731448395643;
        Tue, 12 Nov 2024 13:53:15 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a17ebcsm11699462b3a.138.2024.11.12.13.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 13:53:14 -0800 (PST)
Message-ID: <c2936ebf75e76c77b04dc88aed9dacf8e784214a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 1/4] bpf: add bpf_get_cpu_cycles kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Vadim Fedorenko
 <vadfed@meta.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Mykola Lysenko <mykolal@fb.com>, Jakub
 Kicinski <kuba@kernel.org>
Cc: x86@kernel.org, bpf@vger.kernel.org, Martin KaFai Lau
 <martin.lau@linux.dev>
Date: Tue, 12 Nov 2024 13:53:09 -0800
In-Reply-To: <03bcf4ca-5e6f-4523-9661-46102b4f02b0@linux.dev>
References: <20241109004158.2259301-1-vadfed@meta.com>
	 <cd904b908d0d84c4f8454683495977f64d081004.camel@gmail.com>
	 <03bcf4ca-5e6f-4523-9661-46102b4f02b0@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-11-12 at 21:39 +0000, Vadim Fedorenko wrote:

[...]

> > > +			if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&
> > > +			    imm32 =3D=3D BPF_CALL_IMM(bpf_get_cpu_cycles)) {
> > > +				/* Save RDX because RDTSC will use EDX:EAX to return u64 */
> > > +				emit_mov_reg(&prog, true, AUX_REG, BPF_REG_3);
> > > +				if (boot_cpu_has(X86_FEATURE_LFENCE_RDTSC))
> > > +					EMIT_LFENCE();
> > > +				EMIT2(0x0F, 0x31);
> > > +
> > > +				/* shl RDX, 32 */
> > > +				maybe_emit_1mod(&prog, BPF_REG_3, true);
> > > +				EMIT3(0xC1, add_1reg(0xE0, BPF_REG_3), 32);
> > > +				/* or RAX, RDX */
> > > +				maybe_emit_mod(&prog, BPF_REG_0, BPF_REG_3, true);
> > > +				EMIT2(0x09, add_2reg(0xC0, BPF_REG_0, BPF_REG_3));
> > > +				/* restore RDX from R11 */
> > > +				emit_mov_reg(&prog, true, BPF_REG_3, AUX_REG);
> >=20
> > Note: The default implementation of this kfunc uses __arch_get_hw_count=
er(),
> >        which is implemented as `(u64)rdtsc_ordered() & S64_MAX`.
> >        Here we don't do `& S64_MAX`.
> >        The masking in __arch_get_hw_counter() was added by this commit:
> >        77750f78b0b3 ("x86/vdso: Fix gettimeofday masking").
>=20
> I think we already discussed it with Alexey in v1, we don't really need
> any masking here for BPF case. We can use values provided by CPU
> directly. It will never happen that within one BPF program we will have
> inlined and non-inlined implementation of this helper, hence the values
> to compare will be of the same source.
>=20
> >        Also, the default implementation does not issue `lfence`.
> >        Not sure if this makes any real-world difference.
>=20
> Well, it actually does. rdtsc_ordered is translated into `lfence; rdtsc`
> or `rdtscp` (which is rdtsc + lfence + u32 cookie) depending on the cpu
> features.

I see the following disassembly:

0000000000008980 <bpf_get_cpu_cycles>:
; {
    8980: f3 0f 1e fa                   endbr64
    8984: e8 00 00 00 00                callq   0x8989 <bpf_get_cpu_cycles+=
0x9>
                0000000000008985:  R_X86_64_PLT32       __fentry__-0x4
;       asm volatile(ALTERNATIVE_2("rdtsc",
    8989: 0f 31                         rdtsc
    898b: 90                            nop
    898c: 90                            nop
    898d: 90                            nop
;       return EAX_EDX_VAL(val, low, high);
    898e: 48 c1 e2 20                   shlq    $0x20, %rdx
    8992: 48 09 d0                      orq     %rdx, %rax
    8995: 48 b9 ff ff ff ff ff ff ff 7f movabsq $0x7fffffffffffffff, %rcx #=
 imm =3D 0x7FFFFFFFFFFFFFFF
;               return (u64)rdtsc_ordered() & S64_MAX;
    899f: 48 21 c8                      andq    %rcx, %rax
;       return __arch_get_hw_counter(1, NULL);
    89a2: 2e e9 00 00 00 00             jmp     0x89a8 <bpf_get_cpu_cycles+=
0x28>

Is it patched when kernel is loaded to replace nops with lfence?
By real-world difference I meant difference between default
implementation and inlined assembly.

[...]

> > > @@ -20488,6 +20510,12 @@ static int fixup_kfunc_call(struct bpf_verif=
ier_env *env, struct bpf_insn *insn,
> > >   						node_offset_reg, insn, insn_buf, cnt);
> > >   	} else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_=
kern_ctx] ||
> > >   		   desc->func_id =3D=3D special_kfunc_list[KF_bpf_rdonly_cast]) {
> > > +		if (!verifier_inlines_kfunc_call(env, imm)) {
> > > +			verbose(env, "verifier internal error: kfunc id %d is not defined=
 in checker\n",
> > > +				desc->func_id);
> > > +			return -EFAULT;
> > > +		}
> > > +
> >=20
> > Nit: still think that moving this check as the first conditional would
> >       have been better:
> >=20
> >       if (verifier_inlines_kfunc_call(env, imm)) {
> >          if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_ker=
n_ctx] ||
> >             desc->func_id =3D=3D special_kfunc_list[KF_bpf_rdonly_cast]=
) {
> >             // ...
> >          } else {
> >             // report error
> >          }
> >       } else if (...) {
> >         // ... rest of the cases
> >       }
>=20
> I can change it in the next iteration (if it's needed) if you insist

No need to change if there would be no next iteration.

[...]


