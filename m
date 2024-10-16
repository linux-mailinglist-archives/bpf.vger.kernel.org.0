Return-Path: <bpf+bounces-42245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1803F9A15B0
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 00:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6CD1F2192E
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 22:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51551D3560;
	Wed, 16 Oct 2024 22:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fti2FxJf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C50125B9
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 22:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729116766; cv=none; b=PcZdeD6wko+KGPlMcVlwcUNAJUjRUBNdUFVRBOJ+21SRVu3iHJll8t4tRElK/8uTBXcH8ikN2ABiLBEvDLAmtEeNca/cQvJ3jF05rIxm63K+V8+a0TQ/y0wVXWdVut9v/LFgs1YliRwsdqGA45TEjolzHMq8DArRbG5La2KDCKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729116766; c=relaxed/simple;
	bh=1e9E6lBHiQccR29YAXhzm/q1UXX7SJHpX21jSIc/2Ms=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R9uAEHjA9nrl5lPw3QJ7Z9Wq2UW7sFls/dE6gwX6Fgtwp+UnBdOHE0HUeGllPGNqRZIt5uE63KjoZOQlrFYuHqKtgZm5uJjgxPBjI5eB1F+X+z/bizBan02EtpIEOngtJfxgBKVGPuHmp+gPH7pxcwqkh7Amu1DIDsCBs4VuDIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fti2FxJf; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20ca7fc4484so2057315ad.3
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 15:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729116764; x=1729721564; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VQXePvjMfONFhXE7rlOVHDiSQT68oEfCgStSi5Uo09Y=;
        b=fti2FxJfKa7kFaIYxlhEmEKkU4vhqfm1qMFXAi1a76tOD/g5oWtu9fcHJKWMmh68PQ
         GsRxBMnVs8o/t7ufyJGJCeXsLo5VprvoHLdkkVlQDaKJj2SL9EWLO7CAGWAsCnxPFkWi
         LK+aZP29YK3qTA/9s1MNB+cNhMHvKWKAVRxxMZ7rKzNbSZjNBxkCt2zi/Vdsl6jJOZ5I
         BIO1KLPo87wSFjonmQaKd3/Cs+NzoJaAl+CqvS4RelT1BdmZbPEfpPfmN+pjXj90ix9w
         qlA/oTkMu1Us0spUjU74kaTpfgtanet6Ov+h2u/sk8hjZapQsMSTCmu91iJDrlTexRb0
         yyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729116764; x=1729721564;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VQXePvjMfONFhXE7rlOVHDiSQT68oEfCgStSi5Uo09Y=;
        b=SLx7NrJxJr/EufETXQRnQnVW0ujpRnZSQ2kjcXqtF5kHb7qIJvj0D5x+tP4l9A1HLt
         iAr1bQNjFnpGpdjBEZGrJ4LoJO36GRLKR3NAU5+ImlcDQUG5R4SaimsI4CyH7ruPUMAL
         QgWgDCjhNowHqUz36N3tWevc7TJjzwFeNQSFts6SLgDnZSbPzp7a1u0116kXBD0S8ydy
         Qx4lAjKEZEV/vw06zKRFcRP0y5+0K0053IDshIWxgK/G1OlnG50iDhx9SzfBL/QyF4B/
         SVzeCeiO80Sn29bonScj5406bSRq0L/dS0AKBW7mQLrEvsVH0OSMx0nyO036670gnQS2
         HX5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUM1POv25L1JFxIcBIb+1zkCJNjU+r5Rx+OzR3Uj3qi3HVKcvosQiS6ByfHspGxrYQY81Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZzphsb0zQq96kuadnKDylBbPxmwfE3wZtMwsUC5NsBlH6H7qt
	iCZma0adLCDUx30RpkksNZABc6OGBbNrevBqSDhP1XzjDRPxzgY2
X-Google-Smtp-Source: AGHT+IHXmwXxZUtjzMhJO0Aa4YZNusmOSGE9Loc+S4q8NE3Nv2kqEIvKBETawrHPvWS5m+gP2T4tqA==
X-Received: by 2002:a17:903:244e:b0:205:2a59:a28c with SMTP id d9443c01a7336-20cbb17d4bdmr234687675ad.1.1729116764100;
        Wed, 16 Oct 2024 15:12:44 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d18036606sm33276955ad.150.2024.10.16.15.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 15:12:43 -0700 (PDT)
Message-ID: <23c731fc96ef8c1d6f21983afa4aee593849e428.camel@gmail.com>
Subject: Re: [PATCH bpf 1/3] bpf: Fix incorrect delta propagation between
 linked registers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: nathaniel.theis@nccgroup.com, ast@kernel.org, andrii@kernel.org, 
	john.fastabend@gmail.com
Date: Wed, 16 Oct 2024 15:12:38 -0700
In-Reply-To: <20241016134913.32249-1-daniel@iogearbox.net>
References: <20241016134913.32249-1-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-16 at 15:49 +0200, Daniel Borkmann wrote:
> Nathaniel reported a bug in the linked scalar delta tracking, which can l=
ead
> to accepting a program with OOB access. The specific code is related to t=
he
> sync_linked_regs() function and the BPF_ADD_CONST flag, which signifies a
> constant offset between two scalar registers tracked by the same register=
 id.
>=20
> The verifier attempts to track "similar" scalars in order to propagate bo=
unds
> information learned about one scalar to others. For instance, if r1 and r=
2
> are known to contain the same value, then upon encountering 'if (r1 !=3D =
0x1234)
> goto xyz', not only does it know that r1 is equal to 0x1234 on the path w=
here
> that conditional jump is not taken, it also knows that r2 is.
>=20
> Additionally, with env->bpf_capable set, the verifier will track scalars
> which should be a constant delta apart (if r1 is known to be one greater =
than
> r2, then if r1 is known to be equal to 0x1234, r2 must be equal to 0x1233=
.)
> The code path for the latter in adjust_reg_min_max_vals() is reached when
> processing both 32 and 64-bit addition operations. While adjust_reg_min_m=
ax_vals()
> knows whether dst_reg was produced by a 32 or a 64-bit addition (based on=
 the
> alu32 bool), the only information saved in dst_reg is the id of the sourc=
e
> register (reg->id, or'ed by BPF_ADD_CONST) and the value of the constant
> offset (reg->off).
>=20
> Later, the function sync_linked_regs() will attempt to use this informati=
on
> to propagate bounds information from one register (known_reg) to others,
> meaning, for all R in linked_regs, it copies known_reg range (and possibl=
y
> adjusting delta) into R for the case of R->id =3D=3D known_reg->id.
>=20
> For the delta adjustment, meaning, matching reg->id with BPF_ADD_CONST, t=
he
> verifier adjusts the register as reg =3D known_reg; reg +=3D delta where =
delta
> is computed as (s32)reg->off - (s32)known_reg->off and placed as a scalar
> into a fake_reg to then simulate the addition of reg +=3D fake_reg. This =
is
> only correct, however, if the value in reg was created by a 64-bit additi=
on.
> When reg contains the result of a 32-bit addition operation, its upper 32
> bits will always be zero. sync_linked_regs() on the other hand, may cause
> the verifier to believe that the addition between fake_reg and reg overfl=
ows
> into those upper bits. For example, if reg was generated by adding the
> constant 1 to known_reg using a 32-bit alu operation, then reg->off is 1
> and known_reg->off is 0. If known_reg is known to be the constant 0xFFFFF=
FFF,
> sync_linked_regs() will tell the verifier that reg is equal to the consta=
nt
> 0x100000000. This is incorrect as the actual value of reg will be 0, as t=
he
> 32-bit addition will wrap around.
>=20
> Example:
>=20
>   0: (b7) r0 =3D 0;             R0_w=3D0
>   1: (18) r1 =3D 0x80000001;    R1_w=3D0x80000001
>   3: (37) r1 /=3D 1;            R1_w=3Dscalar()
>   4: (bf) r2 =3D r1;            R1_w=3Dscalar(id=3D1) R2_w=3Dscalar(id=3D=
1)
>   5: (bf) r4 =3D r1;            R1_w=3Dscalar(id=3D1) R4_w=3Dscalar(id=3D=
1)
>   6: (04) w2 +=3D 2147483647;   R2_w=3Dscalar(id=3D1+2147483647,smin=3D0,=
smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff))
>   7: (04) w4 +=3D 0 ;           R4_w=3Dscalar(id=3D1+0,smin=3D0,smax=3Dum=
ax=3D0xffffffff,var_off=3D(0x0; 0xffffffff))
>   8: (15) if r2 =3D=3D 0x0 goto pc+1
>  10: R0=3D0 R1=3D0xffffffff80000001 R2=3D0x7fffffff R4=3D0xffffffff800000=
01 R10=3Dfp0
>=20
> What can be seen here is that r1 is copied to r2 and r4, such that {r1,r2=
,r4}.id
> are all the same which later lets sync_linked_regs() to be invoked. Then,=
 in
> a next step constants are added with alu32 to r2 and r4, setting their ->=
off,
> as well as id |=3D BPF_ADD_CONST. Next, the conditional will bind r2 and
> propagate ranges to its linked registers. The verifier now believes the u=
pper
> 32 bits of r4 are r4=3D0xffffffff80000001, while actually r4=3Dr1=3D0x800=
00001.
>=20
> One approach for a simple fix suitable also for stable is to limit the co=
nstant
> delta tracking to only 64-bit alu addition. If necessary at some later po=
int,
> BPF_ADD_CONST could be split into BPF_ADD_CONST64 and BPF_ADD_CONST32 to =
avoid
> mixing the two under the tradeoff to further complicate sync_linked_regs(=
).
> However, none of the added tests from dedf56d775c0 ("selftests/bpf: Add t=
ests
> for add_const") make this necessary at this point, meaning, BPF CI also p=
asses
> with just limiting tracking to 64-bit alu addition.
>=20
> Fixes: 98d7ca374ba4 ("bpf: Track delta between "linked" registers.")
> Reported-by: Nathaniel Theis <nathaniel.theis@nccgroup.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---

Thank you for the fix, missed this on the code review :(

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


