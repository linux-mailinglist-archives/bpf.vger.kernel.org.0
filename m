Return-Path: <bpf+bounces-33353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E852891BB3E
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 11:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70CB01F22A3A
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 09:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AD714F9FF;
	Fri, 28 Jun 2024 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rSn8Kmoo"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA34314F98
	for <bpf@vger.kernel.org>; Fri, 28 Jun 2024 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719566047; cv=none; b=NItPpU8JE/5ODGdKdZkcY74a1rB8OBHYlmbAnztUSxw4xp2CHEhKCsCZ2A3Ov758XZlauK8yeIq/Ap+SqOEmXy7e4qgME2Ca64zVquxqB040EALBUe5hG2Rk8L3nExdo34HntLBat6qLfGjfJ6fUASqwpf5iQYHtPW4TvTUGjek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719566047; c=relaxed/simple;
	bh=9JlORDBBoKF0FszMx/9vus7+IWabDeVC1LPONy5ht7o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mH4zoDLVLzpP79tOOI1BFItKI4m8AQyk2lza0j73OoahGSg9RAvItmUNuDj6uoWenlGt7TEi66AYVlL0VLHJyIyB1bipo/yGV+LntFdDgVIT6MP37074N1I149KNge9jh3B2ZNkOhYoARnC4Tm8CN6wU1xK72FbclaipX5PL8S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rSn8Kmoo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S8v0oC012134;
	Fri, 28 Jun 2024 09:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	9JlORDBBoKF0FszMx/9vus7+IWabDeVC1LPONy5ht7o=; b=rSn8KmooCgO8ncLR
	xglfb5xY+rD/WZECsimjj8cL9QnMO7BUptbMSnV4GVfsxiTG363VSvikTfguqirW
	781ylOJJ4Ew/4srDLYQfm8z9XT1arORZoyitXaKJtz0f6d6NjEMx23bKFyc1R34l
	C9BLkhrLtFpqr9TKAoYjq+4khyhT8ejXUZ2PvVVqANkniFKP0u6EeZ2je/G2O6Yt
	5NRYBdw9yJFoL6bWNs49+7WCGmDt3gZ9aNcRLB1IC13FfuMFyTNVNpSFFrrk76+v
	i84s0Ir0EcI2EI+0IttaoS61ixpz5iyuCA2E+Ja0sRKK45mt9x0QdpPowJHzvbmU
	UeSO0g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 401spm03gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 09:13:52 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45S9DpYj005545;
	Fri, 28 Jun 2024 09:13:51 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 401spm03gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 09:13:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45S6WLsj000674;
	Fri, 28 Jun 2024 09:13:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yxaenfg9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 09:13:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45S9DiCj37814704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 09:13:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41BA820063;
	Fri, 28 Jun 2024 09:13:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE3572004B;
	Fri, 28 Jun 2024 09:13:43 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Jun 2024 09:13:43 +0000 (GMT)
Message-ID: <e41b791e4d03a7750127e834bff1b136926cdb16.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 09/10] selftests/bpf: Add UAF tests for arena
 atomics
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
Date: Fri, 28 Jun 2024 11:13:43 +0200
In-Reply-To: <CAADnVQ+FZMehV4-=SR-V7cZyGdKrnxBj64+7UL0br+jXMNPxFA@mail.gmail.com>
References: <20240627090900.20017-1-iii@linux.ibm.com>
	 <20240627090900.20017-10-iii@linux.ibm.com>
	 <CAADnVQ+FZMehV4-=SR-V7cZyGdKrnxBj64+7UL0br+jXMNPxFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Cm7pLSvWtLgQY-LaFlbgeZgsLaMM2ooB
X-Proofpoint-ORIG-GUID: R8tsQZPYBB7UEcOdYLgmtnxssM7DZ701
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_05,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=866
 impostorscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406280065

On Thu, 2024-06-27 at 17:45 -0700, Alexei Starovoitov wrote:
> On Thu, Jun 27, 2024 at 2:09=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.c=
om>
> wrote:
> >=20
> > Check that __sync_*() functions don't cause kernel panics when
> > handling
> > freed arena pages.
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0.../selftests/bpf/prog_tests/arena_atomics.c=C2=A0 | 16 +++++++
> > =C2=A0.../selftests/bpf/progs/arena_atomics.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 43
> > +++++++++++++++++++
> > =C2=A02 files changed, 59 insertions(+)
> >=20
> > diff --git a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
> > b/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
> > index 0807a48a58ee..38eef4cc5c80 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
> > @@ -146,6 +146,20 @@ static void test_xchg(struct arena_atomics
> > *skel)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT_EQ(skel->arena->xchg3=
2_result, 1, "xchg32_result");
> > =C2=A0}
> >=20
> > +static void test_uaf(struct arena_atomics *skel)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LIBBPF_OPTS(bpf_test_run_opts, to=
pts);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err, prog_fd;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* No need to attach it, just run=
 it directly */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prog_fd =3D bpf_program__fd(skel-=
>progs.uaf);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D bpf_prog_test_run_opts(pr=
og_fd, &topts);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ASSERT_OK(err, "test_run_opt=
s err"))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ASSERT_OK(topts.retval, "tes=
t_run_opts retval"))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return;
> > +}
> > +
> > =C2=A0void test_arena_atomics(void)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct arena_atomics *skel;
> > @@ -180,6 +194,8 @@ void test_arena_atomics(void)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 test_cmpxchg(skel);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (test__start_subtest("xch=
g"))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 test_xchg(skel);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (test__start_subtest("uaf"))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 test_uaf(skel);
> >=20
> > =C2=A0cleanup:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arena_atomics__destroy(skel)=
;
> > diff --git a/tools/testing/selftests/bpf/progs/arena_atomics.c
> > b/tools/testing/selftests/bpf/progs/arena_atomics.c
> > index 55f10563208d..a86c8cdf1a30 100644
> > --- a/tools/testing/selftests/bpf/progs/arena_atomics.c
> > +++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
> > @@ -176,3 +176,46 @@ int xchg(const void *ctx)
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > =C2=A0}
> > +
> > +SEC("syscall")
> > +int uaf(const void *ctx)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pid !=3D (bpf_get_current_pid=
_tgid() >> 32))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return 0;
> > +#ifdef ENABLE_ATOMICS_TESTS
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void __arena *page;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page =3D bpf_arena_alloc_pages(&a=
rena, NULL, 1, NUMA_NO_NODE,
> > 0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_arena_free_pages(&arena, page=
, 1);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __sync_fetch_and_add((__u32 __are=
na *)page, 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __sync_add_and_fetch((__u32 __are=
na *)page, 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __sync_fetch_and_sub((__u32 __are=
na *)page, 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __sync_sub_and_fetch((__u32 __are=
na *)page, 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __sync_fetch_and_and((__u32 __are=
na *)page, 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __sync_and_and_fetch((__u32 __are=
na *)page, 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __sync_fetch_and_or((__u32 __aren=
a *)page, 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __sync_or_and_fetch((__u32 __aren=
a *)page, 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __sync_fetch_and_xor((__u32 __are=
na *)page, 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __sync_xor_and_fetch((__u32 __are=
na *)page, 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __sync_val_compare_and_swap((__u3=
2 __arena *)page, 0, 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __sync_lock_test_and_set((__u32 _=
_arena *)page, 1);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __sync_fetch_and_add((__u64 __are=
na *)page, 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __sync_add_and_fetch((__u64 __are=
na *)page, 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __sync_fetch_and_sub((__u64 __are=
na *)page, 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __sync_sub_and_fetch((__u64 __are=
na *)page, 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __sync_fetch_and_and((__u64 __are=
na *)page, 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __sync_and_and_fetch((__u64 __are=
na *)page, 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __sync_fetch_and_or((__u64 __aren=
a *)page, 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __sync_or_and_fetch((__u64 __aren=
a *)page, 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __sync_fetch_and_xor((__u64 __are=
na *)page, 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __sync_xor_and_fetch((__u64 __are=
na *)page, 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __sync_val_compare_and_swap((__u6=
4 __arena *)page, 0, 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __sync_lock_test_and_set((__u64 _=
_arena *)page, 1);
> > +#endif
>=20
> Needs to be gated to exclude x86.
> Not sure about arm64.

I ran this test on x86, and it passed. But you are right, as you
mentioned in the other mail, x86 does not support certain atomics.
This means that the test is not testing what I want it to test. I'll
have to debug this.

