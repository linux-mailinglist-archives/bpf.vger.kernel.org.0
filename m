Return-Path: <bpf+bounces-58008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC07AB36E0
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 14:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2341672D2
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 12:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684A728E5FD;
	Mon, 12 May 2025 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aMU5Gclh"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875CE2920A2
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 12:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747052564; cv=none; b=R+wj7gSXMzwPhM539q19w/uMTTzaGdg849JFum8kjrdrr1F6lNAaQ89ti/C2jar7A6CXi0NuM8Z6/VpgyjZXr45XxZvYVhpwTyD8L5hGpjcz6+hk4uj7lOCFM8bJnkvShIhStjMF5te0X3+aHjpvopoaqE0KimZovxQm+nfmaAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747052564; c=relaxed/simple;
	bh=imwOLvMDqMWwAoqiSAef0gr50K138ifTEshsJZXRFnY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C7Ex8j27u6ytl98GbiplTInBrOEOcp8vqB3BEM7ZoSXqwQtEf1qzr1EM/RFV6BY3a18BbOHtpcE+pZCe2/C+5PKMMuM/SHOoip8Bn6CW5vkR1xvTvYDfAkwKc85U9TB86K6kIAUcV8ovNpHq5oP/bYSXrvwALOaF2b3vEG8DH1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aMU5Gclh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C6Ibtf024354;
	Mon, 12 May 2025 12:22:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=imwOLv
	MDqMWwAoqiSAef0gr50K138ifTEshsJZXRFnY=; b=aMU5GclhVgDdHP3ivDc4Mb
	mYH1xHNJKQpGTZfWAzxiGrqyMRN9Gv0hILRWibHUAZ2u+9QfdwC7WbaMnWxUjmqf
	Ysh5+dqnov4XkRrlphp+KOUPTmlJssu3IaQUJlrBf/azqnOeqDuw1gbqIMN9RgSk
	+Qa5ZRTVJTManYFNkGAFRDwq47Bzp7332AavalR+KHq2HFrlPSYz8VWhPgyFwOCt
	y2fzdRJDAxXCpWzjKNuHwiDob4mPypV081GIUyyYW4zfvigqJ9eqMr85EY5hB0tU
	3hjGnMHg8HgTAU03bS3oVcc+av40aYpjmJ1Ip6qkIrVfamOi4W9iQo42itlD0WiA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46kbksshcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 12:22:27 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54CCFNsH025963;
	Mon, 12 May 2025 12:22:27 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46kbksshc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 12:22:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54C8sotV016916;
	Mon, 12 May 2025 12:22:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46jhgyx0tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 12:22:26 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54CCMKjd58589446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 12:22:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2495420111;
	Mon, 12 May 2025 12:22:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A83F20110;
	Mon, 12 May 2025 12:22:19 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 May 2025 12:22:19 +0000 (GMT)
Message-ID: <7a242102eecdd17b4d35c1e4f7d01ea15cb8066a.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix "expression result unused"
 warnings
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kumar Kartikeya
 Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
 <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf
 <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Date: Mon, 12 May 2025 14:22:19 +0200
In-Reply-To: <CAADnVQL6Q+QRv3_JwEd26biwGpFYcwD_=BjBJWLAtpgOP9CKRw@mail.gmail.com>
References: <20250508113804.304665-1-iii@linux.ibm.com>
	 <CAADnVQ+kGcRrLOaA5ic6cYG+1vHJm0bBD1GRfUaYpaOGa3Vx0g@mail.gmail.com>
	 <15bf9a71b8185006c8d19a3aefb331a2765629c5.camel@linux.ibm.com>
	 <CAADnVQL6Q+QRv3_JwEd26biwGpFYcwD_=BjBJWLAtpgOP9CKRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=DrhW+H/+ c=1 sm=1 tr=0 ts=6821e804 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=fa-z0Ns97vmBIItqzjYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDEyNyBTYWx0ZWRfX+7pp9smNxJaD Dz51POJ4kQXAzXTa/nAglLPdZmKyFDPSB5X2ksZ38wflcJRo8bHGQZlKmWrnjwb05TyXpNEBUxR dSBYxHQa6tVIK/gVTFIoOcNJr71mLdz8JEWab9qyprqp3zA/hDVUKmyGjJQqXFjt3wZttJvmG8G
 IgMCeTq1t94uzIrBymW//maEbIifXSymCJgxEv0EknUhkoeK8K80+DK21RfobwIeGUh7MaJwBhx n8j7c9c6aFLKHp6jFEZd1uwFKXunqCdFB/grrr1+kmrH24Iw7kzmKebjUu27TNh3yCmJips92rN 1rgbEog6vqq3vBW/HPk0ePCD0re8bCcNOtoyGt+ZDhnWwHeYfSQDRqM4y1sMI6+sCwrBeyPW4MT
 HahdR2Bh2uDT3TbYmi36NnR1my7zuYpKkHTrteVlkwlz6VmG+ZQaQYw53abArTcau4aW1r2W
X-Proofpoint-GUID: Cexz7vZSTlrG0-WHcrTXfeTKMX_sGZ5J
X-Proofpoint-ORIG-GUID: 2GLyC5BOVQPAOVY9d7q90Sggp4sqd1aJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_04,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 bulkscore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120127

On Fri, 2025-05-09 at 09:51 -0700, Alexei Starovoitov wrote:
> On Thu, May 8, 2025 at 12:21=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.c=
om>
> wrote:
> >=20
> > On Thu, 2025-05-08 at 11:38 -0700, Alexei Starovoitov wrote:
> > > On Thu, May 8, 2025 at 4:38=E2=80=AFAM Ilya Leoshkevich
> > > <iii@linux.ibm.com>
> > > wrote:
> > > >=20
> > > > clang-21 complains about unused expressions in a few progs.
> > > > Fix by explicitly casting the respective expressions to void.
> > >=20
> > > ...
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val & _Q_LOCKED_MASK=
)
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 smp_cond_load_acquire_label(&lock->locked,
> > > > !VAL,
> > > > release_err);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (void)smp_cond_load_acquire_label(&lock-
> > > > >locked,
> > > > !VAL, release_err);
> > >=20
> > > Hmm. I'm on clang-21 too and I don't see them.
> > > What warnings do you see ?
> >=20
> > In file included from progs/arena_spin_lock.c:7:
> > progs/bpf_arena_spin_lock.h:305:1756: error: expression result
> > unused
> > [-Werror,-Wunused-value]
> > =C2=A0 305 |=C2=A0=C2=A0 ({ typeof(_Generic((*&lock->locked), char: (ch=
ar)0,
> > unsigned
> > char : (unsigned char)0, signed char : (signed char)0, unsigned
> > short :
> > (unsigned short)0, signed short : (signed short)0, unsigned int :
> > (unsigned int)0, signed int : (signed int)0, unsigned long :
> > (unsigned
> > long)0, signed long : (signed long)0, unsigned long long :
> > (unsigned
> > long long)0, signed long long : (signed long long)0, default:
> > (typeof(*&lock->locked))0)) __val =3D ({ typeof(&lock->locked) __ptr
> > =3D
> > (&lock->locked); typeof(_Generic((*(&lock->locked)), char: (char)0,
> > unsigned char : (unsigned char)0, signed char : (signed char)0,
> > unsigned short : (unsigned short)0, signed short : (signed short)0,
> > unsigned int : (unsigned int)0, signed int : (signed int)0,
> > unsigned
> > long : (unsigned long)0, signed long : (signed long)0, unsigned
> > long
> > long : (unsigned long long)0, signed long long : (signed long
> > long)0,
> > default: (typeof(*(&lock->locked)))0)) VAL; for (;;) { VAL =3D
> > (typeof(_Generic((*(&lock->locked)), char: (char)0, unsigned char :
> > (unsigned char)0, signed char : (signed char)0, unsigned short :
> > (unsigned short)0, signed short : (signed short)0, unsigned int :
> > (unsigned int)0, signed int : (signed int)0, unsigned long :
> > (unsigned
> > long)0, signed long : (signed long)0, unsigned long long :
> > (unsigned
> > long long)0, signed long long : (signed long long)0, default:
> > (typeof(*(&lock->locked)))0)))(*(volatile typeof(*__ptr)
> > *)&(*__ptr));
> > if (!VAL) break; ({ __label__ l_break, l_continue; asm volatile
> > goto("may_goto %l[l_break]" :::: l_break); goto l_continue;
> > l_break:
> > goto release_err; l_continue:; }); ({}); } (typeof(*(&lock-
> > > locked)))VAL; }); ({ ({ if (!CONFIG_X86_64) ({ unsigned long
> > > __val;
> > __sync_fetch_and_add(&__val, 0); }); else asm volatile("" :::
> > "memory"); }); }); (typeof(*(&lock->locked)))__val; });
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > ^=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ~~~~~
> > 1 error generated.
>=20
> hmm. The error is impossible to read.
>=20
> Kumar,
>=20
> Do you see a way to silence it differently ?
>=20
> Without adding (void)...
>=20
> Things like:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_obj_new(..
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (void)bpf_obj_new(..
>=20
> are good to fix, and if we could annotate
> bpf_obj_new_impl kfunc with __must_check we would have done it,
>=20
> but
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 arch_mcs_spin_lock...
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 (void)arch_mcs_spin_lock...
>=20
> is odd.

What do you think about moving (void) to the definition of
arch_mcs_spin_lock_contended_label()? I can send a v2 if this is
better.

> > It started today.
> > Here is the full compiler version:
> >=20
> > $ clang-21 --version
> > Debian clang version 21.0.0 (++20250501112544+75d1cceb9486-
> > 1~exp1~20250501112558.1422)
> > Target: s390x-unknown-linux-gnu
> > Thread model: posix
> > InstalledDir: /usr/lib/llvm-21/bin
> >=20
> > Best regards,
> > Ilya


