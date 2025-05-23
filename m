Return-Path: <bpf+bounces-58829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44934AC21F4
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 13:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EACFE5067C8
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 11:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DC022D7AA;
	Fri, 23 May 2025 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E6sFwf78"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639F422422E
	for <bpf@vger.kernel.org>; Fri, 23 May 2025 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747999551; cv=none; b=p9Gh2K+JiYB7cwYl8dveG0tFpA8B13Fbp9jhn/S/Ds3ZqphYjo/WZejKh501vgg8kVDc2giVh8icAEdZH50ueQevWMtj/UswIOoU3YV5rLQ3sk7ttV4KBg1ZVnjdYJe6UCvCiIOqkT2Sx/7zG1EfVmJ8oRJPvhkIa6VH1OQOX3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747999551; c=relaxed/simple;
	bh=p8w2tRkEqvevKx4vW7DGJ03RzRtCTsXjUFJc1BYVX5M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BLTm/VQhx+96ImbkYRU6+S10IEYEq/bzaznbqxupKOugRgZyVEYlmMGVBg7oP3HXBKaW59LwdY/KhEq3HGMgDVxX/XMvyk0rytxlztUSnTMmmndABb4fYrm7cNj07dT3tsPLsujLd1mGggO66BI0N2b2cg8Cyh6RSOVdLR0oLug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E6sFwf78; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N9Iuk0024643;
	Fri, 23 May 2025 11:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p8w2tR
	kEqvevKx4vW7DGJ03RzRtCTsXjUFJc1BYVX5M=; b=E6sFwf78VR1vci5Q1X0arr
	67OUXHHrlGmyj9Tp4VXOHw8Nm/TSWDPnNgjduzDGXzkaCIMndhkinmy4P0mtDNZX
	+Xq+Y+JessLmvDu1013SBXOerEa9sf7eGPY9ZJAYOLSe+kzaZ6BMYsiNu5iE1XpI
	3ZbalY8gZZJomG0FN38zFx+dwR42STOUyevfhABrBfF6gk8MWXQyHGioWt74Iu80
	wJGJywdkQnMvP1i15oMPorbq5K5NFF07SBXeYeiMM37/33484I0oQ6nyE48ikSZL
	QH+O6gFjIcLxqOYA+hrAdmxIMQFQhdgkIXIZndaGo5R99wCk2yrWQg17MYbs11XA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46sxhwfd3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 11:25:35 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54NBOcYP022204;
	Fri, 23 May 2025 11:25:34 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46sxhwfd3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 11:25:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54NAKJBR031973;
	Fri, 23 May 2025 11:25:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46rwmqea6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 11:25:33 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54NBPRvR35127846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 May 2025 11:25:27 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D047320043;
	Fri, 23 May 2025 11:25:27 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1ED9520040;
	Fri, 23 May 2025 11:25:27 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 May 2025 11:25:27 +0000 (GMT)
Message-ID: <a8b8b4c9b5485a605437448bd1c548a38dfd1d55.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix "expression result unused"
 warnings
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
 <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf
 <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Date: Fri, 23 May 2025 12:25:26 +0100
In-Reply-To: <CAP01T74iix8HvmVYowFyrG98tDRw8JMOck7HQLD57nuo7SyuoA@mail.gmail.com>
References: <20250508113804.304665-1-iii@linux.ibm.com>
	 <CAADnVQ+kGcRrLOaA5ic6cYG+1vHJm0bBD1GRfUaYpaOGa3Vx0g@mail.gmail.com>
	 <15bf9a71b8185006c8d19a3aefb331a2765629c5.camel@linux.ibm.com>
	 <CAADnVQL6Q+QRv3_JwEd26biwGpFYcwD_=BjBJWLAtpgOP9CKRw@mail.gmail.com>
	 <7a242102eecdd17b4d35c1e4f7d01ea15cb8066a.camel@linux.ibm.com>
	 <CAADnVQ+5h9UESAgNA58HEQ-0zwxn=c0+ibH++NF9farR5-JB8g@mail.gmail.com>
	 <CAP01T74iix8HvmVYowFyrG98tDRw8JMOck7HQLD57nuo7SyuoA@mail.gmail.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDA5NyBTYWx0ZWRfX/fZL/WLuN52R OrGm3/N8lTPwXyaBX30Q/fvZd2BJn3zE8zXEHvhBYYHPgGZUMCA6vTK5QaVAoClAv689s9v/5sp V1lQFP+YRuuk41vR4RAyGgvAoBOf7y5/VRLFXgj/wK5TRSmi4iU8SeA4vKKlY4sVPB2BUp4H2vy
 UuVs4uEnuZLMEwt235ttAR9PVrsGhjeaS2aQkiVEEVwuWATj3Kj4qP2nKFQy8iWtmk+pj0kpS50 WQvFzP5sZC6QGPhv4C4iLf3uvvboXG5hcVEcmTquvEQBJ4RFIsYhyzAxgs8gsVg36Zfpshj94Eg EPW/GV2d82ZvdIp0S+BLGBG9RwRN1FvmlFMVCJGsXy8MlikN2Zytqz2CkTwIVerZXYeA3FnndW3
 yzrTsrwj0MB+oirfkZECQ6sQSkyVYklLNQkdVKP8dQKYzQmxwQikum1cGUbFVobLC7U45I47
X-Proofpoint-GUID: 5Cf7h-nOXiMTyujDDtBU95pk6PU2xExS
X-Authority-Analysis: v=2.4 cv=O685vA9W c=1 sm=1 tr=0 ts=68305b2f cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=PX-7xi24AYDY-sIWrJIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: DpWY7f0INbtbPSB0zYbYVEUcKgdVjUav
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_03,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230097

On Mon, 2025-05-12 at 15:29 -0400, Kumar Kartikeya Dwivedi wrote:
> On Mon, 12 May 2025 at 12:41, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >=20
> > On Mon, May 12, 2025 at 5:22=E2=80=AFAM Ilya Leoshkevich
> > <iii@linux.ibm.com> wrote:
> > >=20
> > > On Fri, 2025-05-09 at 09:51 -0700, Alexei Starovoitov wrote:
> > > > On Thu, May 8, 2025 at 12:21=E2=80=AFPM Ilya Leoshkevich
> > > > <iii@linux.ibm.com>
> > > > wrote:
> > > > >=20
> > > > > On Thu, 2025-05-08 at 11:38 -0700, Alexei Starovoitov wrote:
> > > > > > On Thu, May 8, 2025 at 4:38=E2=80=AFAM Ilya Leoshkevich
> > > > > > <iii@linux.ibm.com>
> > > > > > wrote:
> > > > > > >=20
> > > > > > > clang-21 complains about unused expressions in a few
> > > > > > > progs.
> > > > > > > Fix by explicitly casting the respective expressions to
> > > > > > > void.
> > > > > >=20
> > > > > > ...
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val & _Q_LOCKE=
D_MASK)
> > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 smp_cond_load_acquire_label(&lock-
> > > > > > > >locked,
> > > > > > > !VAL,
> > > > > > > release_err);
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (void)smp_cond_load_acquire_label(&lock-
> > > > > > > > locked,
> > > > > > > !VAL, release_err);
> > > > > >=20
> > > > > > Hmm. I'm on clang-21 too and I don't see them.
> > > > > > What warnings do you see ?
> > > > >=20
> > > > > In file included from progs/arena_spin_lock.c:7:
> > > > > progs/bpf_arena_spin_lock.h:305:1756: error: expression
> > > > > result
> > > > > unused
> > > > > [-Werror,-Wunused-value]
> > > > > =C2=A0 305 |=C2=A0=C2=A0 ({ typeof(_Generic((*&lock->locked), cha=
r: (char)0,
> > > > > unsigned
> > > > > char : (unsigned char)0, signed char : (signed char)0,
> > > > > unsigned
> > > > > short :
> > > > > (unsigned short)0, signed short : (signed short)0, unsigned
> > > > > int :
> > > > > (unsigned int)0, signed int : (signed int)0, unsigned long :
> > > > > (unsigned
> > > > > long)0, signed long : (signed long)0, unsigned long long :
> > > > > (unsigned
> > > > > long long)0, signed long long : (signed long long)0, default:
> > > > > (typeof(*&lock->locked))0)) __val =3D ({ typeof(&lock->locked)
> > > > > __ptr
> > > > > =3D
> > > > > (&lock->locked); typeof(_Generic((*(&lock->locked)), char:
> > > > > (char)0,
> > > > > unsigned char : (unsigned char)0, signed char : (signed
> > > > > char)0,
> > > > > unsigned short : (unsigned short)0, signed short : (signed
> > > > > short)0,
> > > > > unsigned int : (unsigned int)0, signed int : (signed int)0,
> > > > > unsigned
> > > > > long : (unsigned long)0, signed long : (signed long)0,
> > > > > unsigned
> > > > > long
> > > > > long : (unsigned long long)0, signed long long : (signed long
> > > > > long)0,
> > > > > default: (typeof(*(&lock->locked)))0)) VAL; for (;;) { VAL =3D
> > > > > (typeof(_Generic((*(&lock->locked)), char: (char)0, unsigned
> > > > > char :
> > > > > (unsigned char)0, signed char : (signed char)0, unsigned
> > > > > short :
> > > > > (unsigned short)0, signed short : (signed short)0, unsigned
> > > > > int :
> > > > > (unsigned int)0, signed int : (signed int)0, unsigned long :
> > > > > (unsigned
> > > > > long)0, signed long : (signed long)0, unsigned long long :
> > > > > (unsigned
> > > > > long long)0, signed long long : (signed long long)0, default:
> > > > > (typeof(*(&lock->locked)))0)))(*(volatile typeof(*__ptr)
> > > > > *)&(*__ptr));
> > > > > if (!VAL) break; ({ __label__ l_break, l_continue; asm
> > > > > volatile
> > > > > goto("may_goto %l[l_break]" :::: l_break); goto l_continue;
> > > > > l_break:
> > > > > goto release_err; l_continue:; }); ({}); } (typeof(*(&lock-
> > > > > > locked)))VAL; }); ({ ({ if (!CONFIG_X86_64) ({ unsigned
> > > > > > long
> > > > > > __val;
> > > > > __sync_fetch_and_add(&__val, 0); }); else asm volatile("" :::
> > > > > "memory"); }); }); (typeof(*(&lock->locked)))__val; });
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > > > ^=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ~~~~~
> > > > > 1 error generated.
> > > >=20
> > > > hmm. The error is impossible to read.
> > > >=20
> > > > Kumar,
> > > >=20
> > > > Do you see a way to silence it differently ?
> > > >=20
> > > > Without adding (void)...
> > > >=20
> > > > Things like:
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_obj_new(..
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (void)bpf_obj_new(..
> > > >=20
> > > > are good to fix, and if we could annotate
> > > > bpf_obj_new_impl kfunc with __must_check we would have done it,
> > > >=20
> > > > but
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 arch_mcs_spin_lock...
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (void)arch_mcs_spin_lock...
> > > >=20
> > > > is odd.
> > >=20
> > > What do you think about moving (void) to the definition of
> > > arch_mcs_spin_lock_contended_label()? I can send a v2 if this is
> > > better.
> >=20
> > Kumar,
> >=20
> > thoughts?
>=20
> Sorry for the delay, I was afk.
>=20
> The warning seems a bit aggressive, in the kernel we have users which
> do and do not use the value and it's fine.
> I think moving (void) inside the macro is a problem since at least
> rqspinlock like algorithm would want to inspect the result of the
> locked bit.
> No such users exist for now, of course. So maybe we can silence it
> until we do end up depending on the value.
>=20
> I will give a try with clang-21, but I think probably (void) in the
> source is better if we do need to silence it.

Gentle ping.

This is still an issue with clang version 21.0.0
(++20250522112647+491619a25003-1~exp1~20250522112819.1465).

