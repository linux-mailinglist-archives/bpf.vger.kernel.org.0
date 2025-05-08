Return-Path: <bpf+bounces-57795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D4DAB0387
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 21:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF213AC655
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 19:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E8928A1C3;
	Thu,  8 May 2025 19:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aIf1kNyH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30BE1F582E
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746732090; cv=none; b=buMU8WTbr4TQahgTrSu92E1LAEJNOroS+BWMYQZhiMuiPAen9P4yyUXVts0GnnST0lTOMfFcAIEKucbKY1K9/3j8cNOXAy6L/Jc8zrvstx8x036We79PrfTHpdi5rcYY2G1s5j7IXlTgCS6dS3uZ+WsExAgpkCS+MwYthgs4kTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746732090; c=relaxed/simple;
	bh=W2iFX3Av9KQD5aiI2ARQ6fhbMZSfxEdyjZMKu0lB0bk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WNMUKWJ6VIHk/UPGLLzfUVRRw0rtLZXCZkI7fZR7T2oTqjSimBPlIfwGz6bNnDjFemziPEzokJTaODugOR5Q1dyYNatB4Y82trQUDYj0451F9rTm104pwn1M7MZfrtbbHsYG9OjI2WaFvAF/gFY5YaxJi1Nr8hm75toWhhr+8iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aIf1kNyH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548AegHq011671;
	Thu, 8 May 2025 19:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=txr4EW
	A0m5vGciJahZMimVw8zPxoEGBdSLXANTmtJbg=; b=aIf1kNyHG8P0QJSVvgrUup
	iLAsfCiSmGVJomS5lo0p2prTJUZpFjw6Y7u81BMqjt5zOfZUCM6pevVax9rt+sLt
	nG2he8Q0Ujla6vJrXsv//H+NqUUMeOqIJUYXgMeouWTq7lvfnHCtx6QiiQ46snj8
	4P4Ft71/V1MZ9wtEhPNed+j2SVGjAehJAVJeXLQ325rWTuXnqUDZPYIf+fLe1Jzl
	DBmbU5Kk8TDzd7kWRwWVxXm9PZPvP+VoI4Qn9EDQcbe5Wki0AbKhA3Nm+vPmnm5h
	mmqbieU6dMg2vFGW24nWkwI9rtI5LXsM0rVsjjzcVtuE/SNcHTciUJRbQnHKtK0A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46gu2t2fhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 19:21:14 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 548JF2N1020070;
	Thu, 8 May 2025 19:21:13 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46gu2t2fhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 19:21:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 548GYEQu025783;
	Thu, 8 May 2025 19:21:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dwv07ec5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 19:21:12 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 548JL9kF32899832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 May 2025 19:21:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 019422004B;
	Thu,  8 May 2025 19:21:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40DA220040;
	Thu,  8 May 2025 19:21:08 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 May 2025 19:21:08 +0000 (GMT)
Message-ID: <15bf9a71b8185006c8d19a3aefb331a2765629c5.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix "expression result unused"
 warnings
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
 <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf
 <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Date: Thu, 08 May 2025 21:21:07 +0200
In-Reply-To: <CAADnVQ+kGcRrLOaA5ic6cYG+1vHJm0bBD1GRfUaYpaOGa3Vx0g@mail.gmail.com>
References: <20250508113804.304665-1-iii@linux.ibm.com>
	 <CAADnVQ+kGcRrLOaA5ic6cYG+1vHJm0bBD1GRfUaYpaOGa3Vx0g@mail.gmail.com>
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
X-Authority-Analysis: v=2.4 cv=NLnV+16g c=1 sm=1 tr=0 ts=681d042a cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=xKKioOc97a1CM_68BB0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _RooUDHxsLioQV17eB3A9zycnEGQ3IWB
X-Proofpoint-GUID: NUD7uCAeocPrSy9qYcP7hgktgJ6CHz85
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDE3MCBTYWx0ZWRfX6XonOwNZY0d8 M9GiE4/7r/Vbjqabavn9edb/TZxg34KiQL2UGJybt6AVoTL8JwrcLp61YG40ljZL03Pv7vrEMa4 Cq4HJMQEOTvgdnEfmXJw5r2hdmj7ZZsmq6HzshYtceBRaIaPb2ScTxKFs0E7OwSzUSJo8ioEyq2
 OYNxRLrl8802kgv5PcD4cWz6eOY2r6+CBwinZpjC9tMLg6t5pEe68GjsQ8Tj9Z0RyxoUavPt4ny CvPAfbME7g2Embj/Dl2NMKZVBb1MpyIsoy4ma9o1vffEcm3t6ns/oFCrY79DBtHUhkqT3fHnL2G z6XoqlP6ARz0/NFOCslx9ZYMikO0YY2+ZJUyW82EMxPG9/IjyNmcR6clMQto0VeH5gcxkoea2YJ
 l3dd4AfUOSUQroQpzzbY5856054GB0M0OyHAfwT5U2V+Q7tZ5wUt7Q60JFYXVYN78lceGnlG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_06,2025-05-08_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 mlxlogscore=856 phishscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080170

On Thu, 2025-05-08 at 11:38 -0700, Alexei Starovoitov wrote:
> On Thu, May 8, 2025 at 4:38=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.co=
m>
> wrote:
> >=20
> > clang-21 complains about unused expressions in a few progs.
> > Fix by explicitly casting the respective expressions to void.
>=20
> ...
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val & _Q_LOCKED_MASK)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 smp_cond_load_acquire_label(&lock->locked, !VAL,
> > release_err);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (void)smp_cond_load_acquire_label(&lock->locked,
> > !VAL, release_err);
>=20
> Hmm. I'm on clang-21 too and I don't see them.
> What warnings do you see ?

In file included from progs/arena_spin_lock.c:7:
progs/bpf_arena_spin_lock.h:305:1756: error: expression result unused
[-Werror,-Wunused-value]
  305 |   ({ typeof(_Generic((*&lock->locked), char: (char)0, unsigned
char : (unsigned char)0, signed char : (signed char)0, unsigned short :
(unsigned short)0, signed short : (signed short)0, unsigned int :
(unsigned int)0, signed int : (signed int)0, unsigned long : (unsigned
long)0, signed long : (signed long)0, unsigned long long : (unsigned
long long)0, signed long long : (signed long long)0, default:
(typeof(*&lock->locked))0)) __val =3D ({ typeof(&lock->locked) __ptr =3D
(&lock->locked); typeof(_Generic((*(&lock->locked)), char: (char)0,
unsigned char : (unsigned char)0, signed char : (signed char)0,
unsigned short : (unsigned short)0, signed short : (signed short)0,
unsigned int : (unsigned int)0, signed int : (signed int)0, unsigned
long : (unsigned long)0, signed long : (signed long)0, unsigned long
long : (unsigned long long)0, signed long long : (signed long long)0,
default: (typeof(*(&lock->locked)))0)) VAL; for (;;) { VAL =3D
(typeof(_Generic((*(&lock->locked)), char: (char)0, unsigned char :
(unsigned char)0, signed char : (signed char)0, unsigned short :
(unsigned short)0, signed short : (signed short)0, unsigned int :
(unsigned int)0, signed int : (signed int)0, unsigned long : (unsigned
long)0, signed long : (signed long)0, unsigned long long : (unsigned
long long)0, signed long long : (signed long long)0, default:
(typeof(*(&lock->locked)))0)))(*(volatile typeof(*__ptr) *)&(*__ptr));
if (!VAL) break; ({ __label__ l_break, l_continue; asm volatile
goto("may_goto %l[l_break]" :::: l_break); goto l_continue; l_break:
goto release_err; l_continue:; }); ({}); } (typeof(*(&lock-
>locked)))VAL; }); ({ ({ if (!CONFIG_X86_64) ({ unsigned long __val;
__sync_fetch_and_add(&__val, 0); }); else asm volatile("" :::
"memory"); }); }); (typeof(*(&lock->locked)))__val; });
      |                                                              =20
^                         ~~~~~
1 error generated.

It started today.
Here is the full compiler version:

$ clang-21 --version
Debian clang version 21.0.0 (++20250501112544+75d1cceb9486-
1~exp1~20250501112558.1422)
Target: s390x-unknown-linux-gnu
Thread model: posix
InstalledDir: /usr/lib/llvm-21/bin

Best regards,
Ilya

