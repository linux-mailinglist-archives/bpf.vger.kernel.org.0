Return-Path: <bpf+bounces-20287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D68CF83B698
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 02:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8575A285D04
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 01:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636D653AC;
	Thu, 25 Jan 2024 01:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cG8hWv7h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00804A3D;
	Thu, 25 Jan 2024 01:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706146539; cv=none; b=a1hP3VtEJdKdp9q3/ZKk2eJJmJ3G5wnEMJp3JmXLeGDxokOE3BsPtBWdcPOGKtCNIqmce1m23RWiXC4v4zcFqAAz+YSH4dUGc9N57gwnLGdsgjesgmnpTpAUlb4PNyhEqj57SCJZ7K84WH8TLcvny8G2XcsOmjpvXP8B6VsYz8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706146539; c=relaxed/simple;
	bh=ti+MsVvJt249QMQp+AxVc59KZSJRPncqlxj1TUqcMdw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fTLVM6DiNzGz1FyqU/qVpDpDeU2O5/XZDWVPz+d33if/N7z+g/uNxUcJd4NDkg2kbKODfph6WzcJXKYhcyngM58aggMsyi9THdA0Lm/bEpJXnBguhWtJSxx+pyuekWdOLO0E5ntjf6FYgCZRr98bjPU0rR0Y3i+MwT1xwukWtKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cG8hWv7h; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-339261a6ec2so4273958f8f.0;
        Wed, 24 Jan 2024 17:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706146536; x=1706751336; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KkO/ck26OLRnLoZIZ+7eWYjPj2Yp+ZFu8jKv4kgRV5k=;
        b=cG8hWv7hdaIvKm7UgiXS1sTsm4Zi1wVR2+I5QcdQJZLjZLZbfufkqO/I9VBNk129em
         Oll7aN0yR9pstsZpBydM30LM9bSW0c7JmUf4z3qqnemb5FJwpAMEnX+Awh/TDIY5ku1x
         qEmZU0SPMKH51QgKy3RdhWYmEyCoKTNJY19z6BjZUvtK59EBYHRre1M8rhTGwX2IKFlY
         Em1vTUgkSUvoimQVe6KuwGSbI2JfgafvLrlwVwZV/qss6mzl4SoIT4ALUV1KgB3nDL3r
         Mx1F42DLLnZUNXJuESOdN5zJSOs200i7kusrXi85A9VPOMSQvD1b9a0gZNFxTtm2lsYE
         s9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706146536; x=1706751336;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KkO/ck26OLRnLoZIZ+7eWYjPj2Yp+ZFu8jKv4kgRV5k=;
        b=ezJEzM/eV/enOLEX0nKfRgf05qeDsgVmmQJjO+nxhlfNdp00Zu8MhkYSzehPPgPVOA
         VX/VK/5WSkk5MILVeo5aLmuQa0mP/nquyCEsUtGlbmwGpExcXf74vAnbAJrn0JXascaT
         nebRLOZVfOnu8lDtgQpFwv55FFrOMC0Raprq90fUnrYeCXAwGiWuVT8gq9PuPks2acNV
         5X5XOEE7L6rd9Xm/FBCaf9Qv13Zim5qb5ncJIjLl58gTKoE1/Ct2U8tWWoTI2TPkT0Nc
         IKWramVunKor0FZ5zyexn8XI9pMEEo0unxbRKyApUWaK4IEiLqmqYFAwnQhMoJkzjTDu
         FkHQ==
X-Gm-Message-State: AOJu0YyyFWHdNyjjqWga9Y2Wqw178yEaVcsZ1pq35ncgwkJ35CbuN6GO
	JfmlFobdQm2HvtbGUSrs1ZZ1gwUejRl+5Qn7Szw1XSTYClx3LymwWosPe5tt
X-Google-Smtp-Source: AGHT+IF/vTV666cJR3Y5BCnfmvFzWS6ROs77gy6fYU9FDDi7N1tKYT9jAnoZQmuBMCWJe6CSa/l8Tg==
X-Received: by 2002:a5d:4b49:0:b0:339:358c:9f93 with SMTP id w9-20020a5d4b49000000b00339358c9f93mr101568wrs.7.1706146535890;
        Wed, 24 Jan 2024 17:35:35 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id g4-20020a1709061c8400b00a2cfb31290fsm453865ejh.191.2024.01.24.17.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 17:35:35 -0800 (PST)
Message-ID: <5d33819c5f752755614882e30d971488731d97e0.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: Reject pointer spill with var offset
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hao Sun <sunhao.th@gmail.com>, bpf@vger.kernel.org
Cc: andreimatei1@gmail.com, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org
Date: Thu, 25 Jan 2024 03:35:34 +0200
In-Reply-To: <20240124103010.51408-1-sunhao.th@gmail.com>
References: <20240124103010.51408-1-sunhao.th@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-24 at 11:30 +0100, Hao Sun wrote:
> check_stack_write_var_off() does not reject pointer reg, this can lead
> to pointer leak. When cpu_mitigation_off(), unprivileged users can add
> var off to stack pointer, and loading the following prog enable them
> leak kernel address:
>=20
> func#0 @0
> 0: R1=3Dctx() R10=3Dfp0
> 0: (7a) *(u64 *)(r10 -8) =3D 0          ; R10=3Dfp0 fp-8_w=3D00000000
> 1: (7a) *(u64 *)(r10 -16) =3D 0         ; R10=3Dfp0 fp-16_w=3D00000000
> 2: (7a) *(u64 *)(r10 -24) =3D 0         ; R10=3Dfp0 fp-24_w=3D00000000
> 3: (bf) r6 =3D r1                       ; R1=3Dctx() R6_w=3Dctx()
> 4: (b7) r1 =3D 8                        ; R1_w=3DP8
> 5: (37) r1 /=3D 1                       ; R1_w=3DPscalar()
> 6: (57) r1 &=3D 8                       ; R1_w=3DPscalar(smin=3Dsmin32=3D=
0,smax=3Dumax=3Dsmax32=3Dumax32=3D8,var_off=3D(0x0; 0x8))
> 7: (bf) r2 =3D r10                      ; R2_w=3Dfp0 R10=3Dfp0
> 8: (07) r2 +=3D -16                     ; R2_w=3Dfp-16
> 9: (0f) r2 +=3D r1                      ; R1_w=3DPscalar(smin=3Dsmin32=3D=
0,smax=3Dumax=3Dsmax32=3Dumax32=3D8,var_off=3D(0x0; 0x8)) R2_w=3Dfp(off=3D-=
16,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D8,var_off=3D(0x0; 0x8)=
)
> 10: (7b) *(u64 *)(r2 +0) =3D r6         ; R2_w=3Dfp(off=3D-16,smin=3Dsmin=
32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D8,var_off=3D(0x0; 0x8)) R6_w=3Dctx()=
 fp-8_w=3Dmmmmmmmm fp-16_w=3Dmmmmmmmm
> 11: (18) r1 =3D 0x0                     ; R1_w=3Dmap_ptr(ks=3D4,vs=3D8)
> 13: (bf) r2 =3D r10                     ; R2_w=3Dfp0 R10=3Dfp0
> 14: (07) r2 +=3D -16                    ; R2_w=3Dfp-16
> 15: (bf) r3 =3D r10                     ; R3_w=3Dfp0 R10=3Dfp0
> 16: (07) r3 +=3D -8                     ; R3_w=3Dfp-8
> 17: (b7) r4 =3D 0                       ; R4_w=3DP0
> 18: (85) call bpf_map_update_elem#2   ; R0_w=3DPscalar()
> 19: (79) r0 =3D *(u64 *)(r10 -8)        ; R0_w=3DPscalar() R10=3Dfp0 fp-8=
_w=3Dmmmmmmmm
> 20: (95) exit
> processed 20 insns (limit 1000000) max_states_per_insn 0 total_states 0 p=
eak_states 0 mark_read 0

I tried this example as a part of selftest
(If put to tools/testing/selftests/bpf/progs/verifier_map_ptr.c
 could be executed using command:
 ./test_progs -vvv -a 'verifier_map_ptr/ctx_addr_leak @unpriv'):

SEC("socket")
__failure_unpriv
__msg_unpriv("spilling pointer with var-offset is disallowed")
__naked void ctx_addr_leak(void)
{
	asm volatile (
		"r0 =3D 0;"
		"*(u64 *)(r10 -8) =3D r0;"
		"*(u64 *)(r10 -16) =3D r0;"
		"*(u64 *)(r10 -24) =3D r0;"
		"r6 =3D r1;"
		"r1 =3D 8;"
		"r1 /=3D 1;"
		"r1 &=3D 8;"
		"r2 =3D r10;"
		"r2 +=3D -16;"
		"r2 +=3D r1;"
		"*(u64 *)(r2 +0) =3D r6;"
		"r1 =3D %[map_hash_16b] ll;"
		"r2 =3D r10;"
		"r2 +=3D -16;"
		"r3 =3D r10;"
		"r3 +=3D -8;"
		"r4 =3D 0;"
		"call %[bpf_map_update_elem];"
		"r0 =3D *(u64 *)(r10 -8);"
		"exit;"
	:
	: __imm(bpf_map_update_elem),
	  __imm_addr(map_hash_16b)
	: __clobber_all);
}

And see the following error message:

...
r1 &=3D 8                       ; R1_w=3DPscalar(smin=3Dsmin32=3D0,smax=3Du=
max=3Dsmax32=3Dumax32=3D8,var_off=3D(0x0; 0x8))
r2 =3D r10                      ; R2_w=3Dfp0 R10=3Dfp0
r2 +=3D -16                     ; R2_w=3Dfp-16
r2 +=3D r1
R2 variable stack access prohibited for !root, var_off=3D(0x0; 0x8) off=3D-=
16

Could you please craft a selftest that checks for expected message?
Overall the change makes sense to me.

