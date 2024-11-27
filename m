Return-Path: <bpf+bounces-45769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480609DAF5A
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 23:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CCFEB21C0D
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 22:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE932036FF;
	Wed, 27 Nov 2024 22:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TS4Z8JP5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B0313BC35;
	Wed, 27 Nov 2024 22:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732747995; cv=none; b=kpbCslYV0xqSMqeliGs+4vlbv9wpC7DPqUx2fpHjgbEOATPDr/Cbr5dstZmptuMioZ/HPanL7MohQ/XtMgDGRxuEjV/6a//ux6Gql0SddbRmxnI06CdSockE0bFDzowjMMvVRpoECyXZ2xVTnhXtBgJAjJh6bY12mdZMUH3F3nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732747995; c=relaxed/simple;
	bh=KhwCd3IKHfen4pEV3oZ77ru65g6TB8/ZX48UXCDfP60=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U+ijNHqfx5Ompd224BxaoCwy3DKFrPtqZqdUmsJHf9oNXWNLCFRVnIzw0TANY6UgVTfyTs6oQ+WPl9VNp/gSBl9EgLTb5RpLGrBcgngxhjaBmpg34HHsNuVLrL+Pr2uRtGlFCbZyA+AZJBSM6nK9M69kxI7UqPWchITH0qohUMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TS4Z8JP5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-212008b0d6eso1411725ad.3;
        Wed, 27 Nov 2024 14:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732747993; x=1733352793; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U9rV1Gt6plqmR74C5PRsPjYQOCf8xGzWD3B8ZT/AbzY=;
        b=TS4Z8JP5NDHHW9FUrd6g/7ejSwdYmMbvdZOXsIk0DnvTYyplD9gjHiJjo9u2U4soL3
         yOD4eVMtbN3DGUbZRjklSonDUZyMqn9q4HUWg/UiFH4CxOPcn/4eweaay9Ze0gNWS7nU
         FGniqf39LRA/dSkt15I/b0fQZzzuxOWeFEZzH1FNN5JXEPo005qahgGFInFAnFzDlsSP
         QFnXRpfg+UKnwrVo69Ar7l7tvARGSz4X43nhPjZMZpBdNlUao6u8PbslaPuHmhDPj+rq
         hTy0srkbWEmaBx802sF0fEbdpC/HLWIomzImp1gC/rgmdqI7l+GyX9MWZA8nZjUagHL4
         vAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732747993; x=1733352793;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U9rV1Gt6plqmR74C5PRsPjYQOCf8xGzWD3B8ZT/AbzY=;
        b=hTNctsI70yERiRCqdc6ATkKWnDvntPPPc5R5LcGAysDOR6mlKEKEaiIaBglKzWdFWg
         Re3LiKbynCtvdqs+tcecvpAA9Qm09QLoUd0NwKgggm+HiMgLTm5Z8MmOkSeypqIcCchi
         HoksmOWCGjEVFWOOmB25kneE1C+APFHRXI3AQ2biim3mYFA/haCG9mminUHqzrQMl9rL
         MFERo+1UO5pdrVAQU6xWN0ihm5bWvdJuHldmGq4KSToSYk6+xYsABWXWMMix/dQVylq0
         ePWw/VVid4hwHU3KXeRcuBEVPaxzEeDBeB9gdQiK4i0qG2ntu7SWnaeceR45n2X4XuPG
         /GWg==
X-Forwarded-Encrypted: i=1; AJvYcCV26BCQ/VUR5JRyAAlmDuMVpPAXZBqWkqGVtvaCm4gsWaKGYPb/uKCvpRGNx5+CmaCHLfo=@vger.kernel.org, AJvYcCX+TKMk/fdQeNvqb8W4+TcOhuTt5Au9IlNV6CLAbBhUSpm2q+WkqyyKB+xdOkT1pYFjSKDSqPIdsK+Tj9Df@vger.kernel.org
X-Gm-Message-State: AOJu0YxTYpLt3MWp2HHS1qRIt80xsc1V1ChgeO6HbRpJNvR63kIwL2Zq
	tx2fNp1+Mf62jR+C2nDVy135FKadnYisvv4zb1D/uNOubqU3Z/5S
X-Gm-Gg: ASbGncsdPO2yTi+H9bKBAE1DixseIHoeFu8KCGa5DCQpe/I6MsD2vmluOUBhPFIcQql
	ScLa/gAEu8HSQarV6t8UqUDe1BsiOXisMi8t5GgVTWHbZxTvTPWAfcXhR8DNqUgE3tqr8Mmd/Fw
	ut1AuQ2TWIs7BT6U0H/5Z7p7XR2Gi2Tw0paBd3kBHwmJ5S4qF9SM0B4ge7pAzy1yd2qGylb9bNr
	gFNqOgAf3/XxVw8seShc37x/PyrqjBr7EGmrNPZYeq7+F8=
X-Google-Smtp-Source: AGHT+IFyPFxcETgDyHI0Y1gQB3FUFLe3LPkscJBvYyFQtJK2eeZExiTDHHEEUteFfn/RMa5pPDLQqA==
X-Received: by 2002:a17:902:f681:b0:20c:b485:eda3 with SMTP id d9443c01a7336-2150128c646mr47273085ad.20.1732747991601;
        Wed, 27 Nov 2024 14:53:11 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f52bfsm841105ad.51.2024.11.27.14.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 14:53:10 -0800 (PST)
Message-ID: <bada6a6b9ab67da9a51a73d3cae36f650c2d48e0.camel@gmail.com>
Subject: Re: [PATCH v2] bpf, verifier: Improve precision of BPF_MUL
From: Eduard Zingerman <eddyz87@gmail.com>
To: Matan Shachnai <m.shachnai@gmail.com>, ast@kernel.org
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,  Srinivas
 Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko	
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu	
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh	
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 27 Nov 2024 14:53:06 -0800
In-Reply-To: <20241127074156.17567-1-m.shachnai@gmail.com>
References: <20241127074156.17567-1-m.shachnai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-27 at 02:41 -0500, Matan Shachnai wrote:

[...]

> In conclusion, with this patch,
>=20
> 1. We were able to show that we can improve the overall precision of
>    BPF_MUL. We proved (using an SMT solver) that this new version of
>    BPF_MUL is at least as precise as the current version for all inputs.
>=20
> 2. We are able to prove the soundness of the new scalar_min_max_mul() and
>    scalar32_min_max_mul(). By leveraging the existing proof of tnum_mul
>    [1], we can say that the composition of these three functions within
>    BPF_MUL is sound.

Hi Matan,

I think this is a nice simplification of the existing code.
Could you please also add a few canary tests in the
tools/testing/selftests/bpf/progs/verifier_bounds.c ?
(e.g. simple case plus possible edge cases).
Something like:

    SEC("tc")
    __success __log_level(2)
    __msg("r6 *=3D r7 {{.*}}; R6_w=3Dsome-range-here")
    __naked void mult_mixed_sign(void)
    {
    	asm volatile (
    	"call %[bpf_get_prandom_u32];"
    	"r6 =3D r0;"
    	"call %[bpf_get_prandom_u32];"
    	"r7 =3D r0;"
    	"r6 &=3D 0xf;"
    	"r6 -=3D 1000000000;"
    	"r7 &=3D 0xf;"
    	"r7 -=3D 2000000000;"
    	"r6 *=3D r7;"
    	"exit"
    	:
    	: __imm(bpf_get_prandom_u32),
    	  __imm(bpf_skb_store_bytes)
    	: __clobber_all);
    }

We usually do this as a separate patch in a patch-set.

Also, it looks like this has limited applicability in practice,
because small negative values denote huge unsigned values,
hence overflow check kicks in for such values.
E.g. no range inferred for [-10,5] * [-20,-5]:

  0: (85) call bpf_get_prandom_u32#7    ; R0_w=3Dscalar()
  1: (bf) r6 =3D r0                       ; R0_w=3Dscalar(id=3D1) R6_w=3Dsc=
alar(id=3D1)
  2: (85) call bpf_get_prandom_u32#7    ; R0_w=3Dscalar()
  3: (bf) r7 =3D r0                       ; R0_w=3Dscalar(id=3D2) R7_w=3Dsc=
alar(id=3D2)
  4: (57) r6 &=3D 15                      ; R6_w=3Dscalar(smin=3Dsmin32=3D0=
,smax=3Dumax=3Dsmax32=3Dumax32=3D15,var_off=3D(0x0; 0xf))
  5: (17) r6 -=3D 10                      ; R6_w=3Dscalar(smin=3Dsmin32=3D-=
10,smax=3Dsmax32=3D5)
  6: (57) r7 &=3D 15                      ; R7_w=3Dscalar(smin=3Dsmin32=3D0=
,smax=3Dumax=3Dsmax32=3Dumax32=3D15,var_off=3D(0x0; 0xf))
  7: (17) r7 -=3D 20                      ; R7_w=3Dscalar(smin=3Dsmin32=3D-=
20,smax=3Dsmax32=3D-5,umin=3D0xffffffffffffffec,umax=3D0xfffffffffffffffb,u=
min32=3D0xffffffec,umax32=3D0xfffffffb,var_off=3D(0xffffffffffffffe0; 0x1f)=
)
  8: (2f) r6 *=3D r7                      ; R6_w=3Dscalar() R7_w=3Dscalar(s=
min=3Dsmin32=3D-20,smax=3Dsmax32=3D-5,umin=3D0xffffffffffffffec,umax=3D0xff=
fffffffffffffb,umin32=3D0xffffffec,umax32=3D0xfffffffb,var_off=3D(0xfffffff=
fffffffe0; 0x1f))
  9: (95) exit

Compared to:

  0: R1=3Dctx() R10=3Dfp0
  ; asm volatile ( @ verifier_bounds.c:1208
  0: (85) call bpf_get_prandom_u32#7    ; R0_w=3Dscalar()
  1: (bf) r6 =3D r0                       ; R0_w=3Dscalar(id=3D1) R6_w=3Dsc=
alar(id=3D1)
  2: (85) call bpf_get_prandom_u32#7    ; R0_w=3Dscalar()
  3: (bf) r7 =3D r0                       ; R0_w=3Dscalar(id=3D2) R7_w=3Dsc=
alar(id=3D2)
  4: (57) r6 &=3D 15                      ; R6_w=3Dscalar(smin=3Dsmin32=3D0=
,smax=3Dumax=3Dsmax32=3Dumax32=3D15,var_off=3D(0x0; 0xf))
  5: (17) r6 -=3D 1000000000              ; R6_w=3Dscalar(smin=3D0xffffffff=
c4653600,smax=3D0xffffffffc465360f,umin=3D0xffffffffc4653600,umax=3D0xfffff=
fffc465360f,smin32=3Dumin32=3D0xc4653600,smax32=3Dumax32=3D0xc465360f,var_o=
ff=3D(0xffffffffc4653600; 0xf))
  6: (57) r7 &=3D 15                      ; R7_w=3Dscalar(smin=3Dsmin32=3D0=
,smax=3Dumax=3Dsmax32=3Dumax32=3D15,var_off=3D(0x0; 0xf))
  7: (17) r7 -=3D 2000000000              ; R7_w=3Dscalar(smin=3D0xffffffff=
88ca6c00,smax=3D0xffffffff88ca6c0f,umin=3D0xffffffff88ca6c00,umax=3D0xfffff=
fff88ca6c0f,smin32=3Dumin32=3D0x88ca6c00,smax32=3Dumax32=3D0x88ca6c0f,var_o=
ff=3D(0xffffffff88ca6c00; 0xf))
  8: (2f) r6 *=3D r7                      ; R6_w=3Dscalar(smax=3D0x7fffffff=
fffffeff,umax=3D0xfffffffffffffeff,smax32=3D0x7ffffeff,umax32=3D0xfffffeff,=
var_off=3D(0x0; 0xfffffffffffffeff)) R7_w=3Dscalar(smin=3D0xffffffff88ca6c0=
0,smax=3D0xffffffff88ca6c0f,umin=3D0xffffffff88ca6c00,umax=3D0xffffffff88ca=
6c0f,smin32=3Dumin32=3D0x88ca6c00,smax32=3Dumax32=3D0x88ca6c0f,var_off=3D(0=
xffffffff88ca6c00; 0xf))
  9: (95) exit

Is it possible to do check_mul_overflow() for signed bounds and
rely on reg_bounds_sync() for unsigned?

[...]


