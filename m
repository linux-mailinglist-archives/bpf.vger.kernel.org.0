Return-Path: <bpf+bounces-58971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D467FAC4A4B
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 10:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1854D16BBF1
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 08:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345BF248F73;
	Tue, 27 May 2025 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d4/G6R6r"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71D024A05D
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748334448; cv=none; b=gg3cW+RdnCrC86IoTy0gpgmRu3oxdkeyJFB04VhfSdA497Ol5+1VkSum+M8mQ5NAT7hCHKzjxSJ0LNplFKGeRou4asTfcl1ytM3FUV4p9n5y2ffzACnvs2XEqI0/GnApoQhbTLnI0uT629NEaU9++KYuLrzgrPZpP0QLnfpEVK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748334448; c=relaxed/simple;
	bh=ihHwXxYhZOP6cPjq+ZlfnKl5IxC6K9QLk/MQQUwhbxE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EqW2bwM7B/5ZiHzq3hD9GxZOJrqzVP2tc++JPQwPDGYCEMJyYieTpBqmt5xm8yDViO1CB4+DFoL/mTkY/uDr061Gw7Z98Jsd3ZmvRJds0cLb725tbKPLyTyutL2F/ShKD4B8H7UmmFJI89fUz6J46NT3h3HX7M9OPA4sogXbxQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d4/G6R6r; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R6mgrr006139;
	Tue, 27 May 2025 08:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ihHwXx
	YhZOP6cPjq+ZlfnKl5IxC6K9QLk/MQQUwhbxE=; b=d4/G6R6rkbIzYukkoFTK3a
	w65/XvtU24kpZMfNG5o3o+N2IEXIvAqWV4JqS91spRziHJ0NzP+JMICHrEJj+gJP
	oZBz+5tK/KE4vXZFFofzak4Anpb8jH2cW45JQbO1d+5pB/xwpbEcF6l9MBjJziU9
	Axj5oW6jpQ9TsvGaZ4Ac/uBdosvy3Wx0yFJaYrCa8cLo+54B+ehWFRekK44cRxne
	qGPrAVn2QQdVj5zZfzygRg1ZdmbeRakb2jHge0Z1ZdBsVbg2kvxCWTvNerGdxUkZ
	ferFRw3mIe/yYTLaz2cnL4SptSk+XO4nqz1OYyQK2+ZT9HaC5s3HkVqLEX2Lcktg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46u4hnd8bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 08:27:10 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54R8FMor007817;
	Tue, 27 May 2025 08:27:10 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46u4hnd8bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 08:27:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54R3srOH006366;
	Tue, 27 May 2025 08:27:09 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46utnmhmbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 08:27:09 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54R8R54l57606462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 08:27:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A1872004B;
	Tue, 27 May 2025 08:27:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E37F20043;
	Tue, 27 May 2025 08:27:04 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 May 2025 08:27:04 +0000 (GMT)
Message-ID: <15f2b0cb9fd8c106d1daac1c7e0c156c97e0ee04.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix "expression result unused"
 warnings
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Yonghong Song <yonghong.song@linux.dev>,
        Kumar Kartikeya Dwivedi
	 <memxor@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov
 <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko
 <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>
Date: Tue, 27 May 2025 10:27:04 +0200
In-Reply-To: <6192c51c-e800-4a89-a0b2-52abab33010a@linux.dev>
References: <20250508113804.304665-1-iii@linux.ibm.com>
	 <CAADnVQ+kGcRrLOaA5ic6cYG+1vHJm0bBD1GRfUaYpaOGa3Vx0g@mail.gmail.com>
	 <15bf9a71b8185006c8d19a3aefb331a2765629c5.camel@linux.ibm.com>
	 <CAADnVQL6Q+QRv3_JwEd26biwGpFYcwD_=BjBJWLAtpgOP9CKRw@mail.gmail.com>
	 <7a242102eecdd17b4d35c1e4f7d01ea15cb8066a.camel@linux.ibm.com>
	 <CAADnVQ+5h9UESAgNA58HEQ-0zwxn=c0+ibH++NF9farR5-JB8g@mail.gmail.com>
	 <CAP01T74iix8HvmVYowFyrG98tDRw8JMOck7HQLD57nuo7SyuoA@mail.gmail.com>
	 <a8b8b4c9b5485a605437448bd1c548a38dfd1d55.camel@linux.ibm.com>
	 <b7517bd4-3e6a-4a74-99c8-bca0969aeb01@linux.dev>
	 <CAP01T75hQ0SDAXY+w-nnRii_B9TkydCXahbC8ATrmuGAeQc+AQ@mail.gmail.com>
	 <195a1fd78ebf029eba204982f5bbe0ec6ef025fb.camel@linux.ibm.com>
	 <6192c51c-e800-4a89-a0b2-52abab33010a@linux.dev>
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
X-Authority-Analysis: v=2.4 cv=HvB2G1TS c=1 sm=1 tr=0 ts=6835775e cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=Twlkf-z8AAAA:8
 a=CckCpcDGUhSvZOO3l5sA:9 a=QEXdDO2ut3YA:10 a=-74SuR6ZdpOK_LpdRCUo:22
X-Proofpoint-GUID: PonTatmEXcEAgDE1_GvIUEVXAr-aNkqR
X-Proofpoint-ORIG-GUID: Se01Y6hmJ8CqvAr2sudJJsZcQS9isfvz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA2NCBTYWx0ZWRfX90JmoNGWm+RE rDdjddUWDItrIklqXtUv94YUkSCRqSSAMvlepXJ+Ohg7RXiVaX6hKfRr8xdFEQ082mPKJ0ywTO0 nH2oPtcJoLVlZMAfzDII6J2C3fllORmD0oTotxCZHvfBvYsewa2n3UQblsXMHxT4U8ejejWIV8d
 BvMXtiVKY3s18gTdQBwyJupWuSzicTTwE26ynRaBqvCKdVCdd9chgFnVJ+/0MVE0kCyyN7M6E6L dZ0JtzQK0Jaus+KezvMJ23eR7/AtWLzt2VyzUa944ZguSq4iw5ggJvI1Fs0QSaRveSAfdDsc8hl KrLDS0McYZ0ToPcGurXCQAUdFD0x5pPtQxWnT06S9/G0/8VDHq88vDCPH3nI+/N6e7hDbhm8s/C
 nNXqk1K8S0NdKnGu1zF5bfitfQHLJVVkzEhEbK/nrfVb8H61CQz48voQDVwCnGjcXZAPwbqX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_04,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270064

On Mon, 2025-05-26 at 22:15 -0700, Yonghong Song wrote:
>=20
>=20
> On 5/24/25 2:05 PM, Ilya Leoshkevich wrote:
> > On Sat, 2025-05-24 at 03:01 +0200, Kumar Kartikeya Dwivedi wrote:
> > > On Sat, 24 May 2025 at 02:06, Yonghong Song
> > > <yonghong.song@linux.dev>
> > > wrote:
> > > >=20
> > > >=20
> > > > On 5/23/25 4:25 AM, Ilya Leoshkevich wrote:
> > > > > On Mon, 2025-05-12 at 15:29 -0400, Kumar Kartikeya Dwivedi
> > > > > wrote:
> > > > > > On Mon, 12 May 2025 at 12:41, Alexei Starovoitov
> > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > > On Mon, May 12, 2025 at 5:22=E2=80=AFAM Ilya Leoshkevich
> > > > > > > <iii@linux.ibm.com> wrote:
> > > > > > > > On Fri, 2025-05-09 at 09:51 -0700, Alexei Starovoitov
> > > > > > > > wrote:
> > > > > > > > > On Thu, May 8, 2025 at 12:21=E2=80=AFPM Ilya Leoshkevich
> > > > > > > > > <iii@linux.ibm.com>
> > > > > > > > > wrote:
> > > > > > > > > > On Thu, 2025-05-08 at 11:38 -0700, Alexei
> > > > > > > > > > Starovoitov
> > > > > > > > > > wrote:
> > > > > > > > > > > On Thu, May 8, 2025 at 4:38=E2=80=AFAM Ilya Leoshkevi=
ch
> > > > > > > > > > > <iii@linux.ibm.com>
> > > > > > > > > > > wrote:
> > > > > > > > > > > > clang-21 complains about unused expressions in
> > > > > > > > > > > > a
> > > > > > > > > > > > few
> > > > > > > > > > > > progs.
> > > > > > > > > > > > Fix by explicitly casting the respective
> > > > > > > > > > > > expressions to
> > > > > > > > > > > > void.
> > > > > > > > > > > ...
> > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (val & _Q_LOCKED_MASK)
> > > > > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > > > > > > smp_cond_load_acquire_label(&lock-
> > > > > > > > > > > > > locked,
> > > > > > > > > > > > !VAL,
> > > > > > > > > > > > release_err);
> > > > > > > > > > > > +
> > > > > > > > > > > > (void)smp_cond_load_acquire_label(&lock-
> > > > > > > > > > > > > locked,
> > > > > > > > > > > > !VAL, release_err);
> > > > > > > > > > > Hmm. I'm on clang-21 too and I don't see them.
> > > > > > > > > > > What warnings do you see ?
> > > > > > > > > > In file included from progs/arena_spin_lock.c:7:
> > > > > > > > > > progs/bpf_arena_spin_lock.h:305:1756: error:
> > > > > > > > > > expression
> > > > > > > > > > result
> > > > > > > > > > unused
> > > > > > > > > > [-Werror,-Wunused-value]
> > > > > > > > > > =C2=A0=C2=A0=C2=A0 305 |=C2=A0=C2=A0 ({ typeof(_Generic=
((*&lock->locked),
> > > > > > > > > > char:
> > > > > > > > > > (char)0,
> > > > > > > > > > unsigned
> > > > > > > > > > char : (unsigned char)0, signed char : (signed
> > > > > > > > > > char)0,
> > > > > > > > > > unsigned
> > > > > > > > > > short :
> > > > > > > > > > (unsigned short)0, signed short : (signed short)0,
> > > > > > > > > > unsigned
> > > > > > > > > > int :
> > > > > > > > > > (unsigned int)0, signed int : (signed int)0,
> > > > > > > > > > unsigned
> > > > > > > > > > long :
> > > > > > > > > > (unsigned
> > > > > > > > > > long)0, signed long : (signed long)0, unsigned long
> > > > > > > > > > long :
> > > > > > > > > > (unsigned
> > > > > > > > > > long long)0, signed long long : (signed long
> > > > > > > > > > long)0,
> > > > > > > > > > default:
> > > > > > > > > > (typeof(*&lock->locked))0)) __val =3D ({
> > > > > > > > > > typeof(&lock-
> > > > > > > > > > > locked)
> > > > > > > > > > __ptr
> > > > > > > > > > =3D
> > > > > > > > > > (&lock->locked); typeof(_Generic((*(&lock-
> > > > > > > > > > >locked)),
> > > > > > > > > > char:
> > > > > > > > > > (char)0,
> > > > > > > > > > unsigned char : (unsigned char)0, signed char :
> > > > > > > > > > (signed
> > > > > > > > > > char)0,
> > > > > > > > > > unsigned short : (unsigned short)0, signed short :
> > > > > > > > > > (signed
> > > > > > > > > > short)0,
> > > > > > > > > > unsigned int : (unsigned int)0, signed int :
> > > > > > > > > > (signed
> > > > > > > > > > int)0,
> > > > > > > > > > unsigned
> > > > > > > > > > long : (unsigned long)0, signed long : (signed
> > > > > > > > > > long)0,
> > > > > > > > > > unsigned
> > > > > > > > > > long
> > > > > > > > > > long : (unsigned long long)0, signed long long :
> > > > > > > > > > (signed long
> > > > > > > > > > long)0,
> > > > > > > > > > default: (typeof(*(&lock->locked)))0)) VAL; for
> > > > > > > > > > (;;) {
> > > > > > > > > > VAL =3D
> > > > > > > > > > (typeof(_Generic((*(&lock->locked)), char: (char)0,
> > > > > > > > > > unsigned
> > > > > > > > > > char :
> > > > > > > > > > (unsigned char)0, signed char : (signed char)0,
> > > > > > > > > > unsigned
> > > > > > > > > > short :
> > > > > > > > > > (unsigned short)0, signed short : (signed short)0,
> > > > > > > > > > unsigned
> > > > > > > > > > int :
> > > > > > > > > > (unsigned int)0, signed int : (signed int)0,
> > > > > > > > > > unsigned
> > > > > > > > > > long :
> > > > > > > > > > (unsigned
> > > > > > > > > > long)0, signed long : (signed long)0, unsigned long
> > > > > > > > > > long :
> > > > > > > > > > (unsigned
> > > > > > > > > > long long)0, signed long long : (signed long
> > > > > > > > > > long)0,
> > > > > > > > > > default:
> > > > > > > > > > (typeof(*(&lock->locked)))0)))(*(volatile
> > > > > > > > > > typeof(*__ptr)
> > > > > > > > > > *)&(*__ptr));
> > > > > > > > > > if (!VAL) break; ({ __label__ l_break, l_continue;
> > > > > > > > > > asm
> > > > > > > > > > volatile
> > > > > > > > > > goto("may_goto %l[l_break]" :::: l_break); goto
> > > > > > > > > > l_continue;
> > > > > > > > > > l_break:
> > > > > > > > > > goto release_err; l_continue:; }); ({}); }
> > > > > > > > > > (typeof(*(&lock-
> > > > > > > > > > > locked)))VAL; }); ({ ({ if (!CONFIG_X86_64) ({
> > > > > > > > > > > unsigned
> > > > > > > > > > > long
> > > > > > > > > > > __val;
> > > > > > > > > > __sync_fetch_and_add(&__val, 0); }); else asm
> > > > > > > > > > volatile("" :::
> > > > > > > > > > "memory"); }); }); (typeof(*(&lock->locked)))__val;
> > > > > > > > > > });
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > > > > > > > > ^=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ~~~~~
> > > > > > > > > > 1 error generated.
> > > > > > > > > hmm. The error is impossible to read.
> > > > > > > > >=20
> > > > > > > > > Kumar,
> > > > > > > > >=20
> > > > > > > > > Do you see a way to silence it differently ?
> > > > > > > > >=20
> > > > > > > > > Without adding (void)...
> > > > > > > > >=20
> > > > > > > > > Things like:
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_obj_new(..
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (void)bpf_obj_new(.=
.
> > > > > > > > >=20
> > > > > > > > > are good to fix, and if we could annotate
> > > > > > > > > bpf_obj_new_impl kfunc with __must_check we would
> > > > > > > > > have
> > > > > > > > > done it,
> > > > > > > > >=20
> > > > > > > > > but
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arch_mcs_spin_lock...
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (void)arch_mcs_spin_lock...
> > > > > > > > >=20
> > > > > > > > > is odd.
> > > > > > > > What do you think about moving (void) to the definition
> > > > > > > > of
> > > > > > > > arch_mcs_spin_lock_contended_label()? I can send a v2
> > > > > > > > if
> > > > > > > > this is
> > > > > > > > better.
> > > > > > > Kumar,
> > > > > > >=20
> > > > > > > thoughts?
> > > > > > Sorry for the delay, I was afk.
> > > > > >=20
> > > > > > The warning seems a bit aggressive, in the kernel we have
> > > > > > users
> > > > > > which
> > > > > > do and do not use the value and it's fine.
> > > > > > I think moving (void) inside the macro is a problem since
> > > > > > at
> > > > > > least
> > > > > > rqspinlock like algorithm would want to inspect the result
> > > > > > of
> > > > > > the
> > > > > > locked bit.
> > > > > > No such users exist for now, of course. So maybe we can
> > > > > > silence
> > > > > > it
> > > > > > until we do end up depending on the value.
> > > > > >=20
> > > > > > I will give a try with clang-21, but I think probably
> > > > > > (void) in
> > > > > > the
> > > > > > source is better if we do need to silence it.
> > > > > Gentle ping.
> > > > >=20
> > > > > This is still an issue with clang version 21.0.0
> > > > > (++20250522112647+491619a25003-1~exp1~20250522112819.1465).
> > > > >=20
> > > > I cannot reproduce the "unused expressions" error. What is the
> > > > llvm cmake command line you are using?
> > > >=20
> > > Sorry for the delay. I tried just now with clang built from the
> > > latest
> > > git checkout but I don't see it either.
> > > I built it following the steps at
> > > https://www.kernel.org/doc/Documentation/bpf/bpf_devel_QA.rst.
> > I use the following make invocation:
> >=20
> > make CC=3D"ccache gcc" LD=3Dld.lld-21 O=3D"$PWD/../linux-build-s390x"
> > CLANG=3D"ccache clang-21" LLVM_STRIP=3Dllvm-strip-21 LLC=3Dllc-21
> > LLD=3Dlld-21
> > -j128 -C tools/testing/selftests/bpf BPF_GCC=3D V=3D1
> >=20
> > which results in the following clang invocation:
> >=20
> > ccache clang-21=C2=A0 -g -Wall -Werror -D__TARGET_ARCH_s390 -mbig-endia=
n
> > -
> > I"$PWD/../../../../.."/linux-build-s390x//tools/include -
> > I"$PWD/../../../../.."/linux/tools/testing/selftests/bpf -
> > I"$PWD/../../../../.."/linux/tools/include/uapi -
> > I"$PWD/../../../../.."/usr/include -std=3Dgnu11 -fno-strict-aliasing
> > -
> > Wno-compare-distinct-pointer-types -idirafter /usr/lib/llvm-
> > 21/lib/clang/21/include -idirafter /usr/local/include -idirafter
> > /usr/include/s390x-linux-gnu -idirafter /usr/include=C2=A0=C2=A0=C2=A0 =
-
> > DENABLE_ATOMICS_TESTS=C2=A0=C2=A0 -O2 --target=3Dbpfeb -c
> > progs/arena_spin_lock.c -
> > mcpu=3Dv3 -o "$PWD/../../../../.."/linux-build-
> > s390x//arena_spin_lock.bpf.o
> >=20
> > I tried dropping ccache, but it did not help.
>=20
> Thanks, Ilya. It could be great if you can find out the
> cmake command lines which eventually builds your clang-21.
> Once cmake command lines are available, I can build
> the compiler on x86_64 host and do some checking for it.

Hi Yonghong, I don't build it, I take it from apt.llvm.org.
It's surprising we don't see this in CI, because it also takes
clang from there. If you think this is a compiler and not a code
bug, I can debug this myself, because maybe it's reproducible only on
s390x.

