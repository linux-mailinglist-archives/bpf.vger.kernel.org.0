Return-Path: <bpf+bounces-33522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC0691E627
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 19:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0FCA1F22870
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 17:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C6916DEA2;
	Mon,  1 Jul 2024 17:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tf5w4BNm"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABD314AD25
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719853400; cv=none; b=PTwoZI5QRSsUubpVpevkEAuOy5h0gd4X3AcDe3zqr7+LWobmOO1PDlBUA6mQY9Lh52XWPWUGa45vj7JW/GRb5qQe+yXxRtDsV89QmaPFj4Pbl0sHN/4z3xN7R3ZPeX2r454yG2dPDZGTOdK8VdEj/2jrN7fQ5STE0n0GnGRlnIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719853400; c=relaxed/simple;
	bh=A9xFQOkIFItsEl2sLhAmte4/BvJzMcKydN9wVFu81bA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Iix0X8q/RNIi5bk3fpvCnMjAq9FQQFhICPxjq07TYEckA1WhG+yKSZaPLppj+qF24F0nj7TkGRWBz2ZmuGnYq7JUXOt78fE+ByYGJafoCrJFsma/D4FWOLzF/HA8aBB9sw6thVxyJxMNf2Au2AJ8fdy4Xeh77/XTuPWmnf4dmJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tf5w4BNm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461Fv9uV017407;
	Mon, 1 Jul 2024 17:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	nDsBQKe4ZHIoZOMJi64nTX+lHRp0YZlGWrriQ+LLlWI=; b=tf5w4BNmzdF+Jx6l
	D0z32ocQ8bcW2Rh0K1+pwmQla3D9XyOw5b0iSnm0FyFQFWZ6Cz1WJnxvQ2bWMc7O
	Uz52erJGWh7yN9tEdqcj60poaCraZ2syE++bpPiLM7bwyVXhYfSZPJfK7EO/nOr6
	2VD8m2Zes9wnUCtog1CVgnKThzLcjv33qjXSET/T9e59hIzDA8hwDaGlhkc/PNYc
	KOYmX+IsX8UhAMInJScmFOinYDDfJ/eqgDgItzwQ1q6fpz02qynB5e/UgZ32QwtB
	PZ48rLDtTpOBifw20IqzsnV3R57wVp5x20TpuzpdSs4gTA1v9CxOttXGHjecc9J7
	kn3JWw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403xpf0dm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 17:03:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 461G7E7J009477;
	Mon, 1 Jul 2024 17:03:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 402xtmg42r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 17:03:01 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 461H2uRT55968150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 17:02:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4980C20067;
	Mon,  1 Jul 2024 17:02:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B96E720063;
	Mon,  1 Jul 2024 17:02:55 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 17:02:55 +0000 (GMT)
Message-ID: <bf43ee29b4203e52360b9618b0412b1b4acec594.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v2 10/11] selftests/bpf: Add UAF tests for
 arena atomics
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov
 <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik
	 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Date: Mon, 01 Jul 2024 19:02:55 +0200
In-Reply-To: <b38240c0-2b33-bfc2-62af-b6a31a816fc5@iogearbox.net>
References: <20240701133432.3883-1-iii@linux.ibm.com>
	 <20240701133432.3883-11-iii@linux.ibm.com>
	 <b38240c0-2b33-bfc2-62af-b6a31a816fc5@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: R61lCTbokRi3zIcMQigluZrCUHXNuakn
X-Proofpoint-GUID: R61lCTbokRi3zIcMQigluZrCUHXNuakn
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_17,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxscore=0 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010127

On Mon, 2024-07-01 at 17:22 +0200, Daniel Borkmann wrote:
> On 7/1/24 3:24 PM, Ilya Leoshkevich wrote:
> > Check that __sync_*() functions don't cause kernel panics when
> > handling
> > freed arena pages.
> >=20
> > x86_64 does not support some arena atomics yet, and aarch64 may or
> > may
> > not support them, based on the availability of LSE atomics at run
> > time.
> > Do not enable this test for these architectures for simplicity.
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0 .../selftests/bpf/prog_tests/arena_atomics.c=C2=A0 | 18 +++++
> > =C2=A0 .../selftests/bpf/progs/arena_atomics.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 76
> > +++++++++++++++++++
> > =C2=A0 2 files changed, 94 insertions(+)
> >=20
> > diff --git a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
> > b/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
> > index 0807a48a58ee..26e7c06c6cb4 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
> > @@ -146,6 +146,22 @@ static void test_xchg(struct arena_atomics
> > *skel)
> > =C2=A0=C2=A0	ASSERT_EQ(skel->arena->xchg32_result, 1, "xchg32_result");
> > =C2=A0 }
> > =C2=A0=20
> > +static void test_uaf(struct arena_atomics *skel)
> > +{
> > +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> > +	int err, prog_fd;
> > +
> > +	/* No need to attach it, just run it directly */
> > +	prog_fd =3D bpf_program__fd(skel->progs.uaf);
> > +	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> > +	if (!ASSERT_OK(err, "test_run_opts err"))
> > +		return;
> > +	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
> > +		return;
> > +
> > +	ASSERT_EQ(skel->arena->uaf_recovery_fails, 0,
> > "uaf_recovery_fails");
> > +}
> > +
> > =C2=A0 void test_arena_atomics(void)
> > =C2=A0 {
> > =C2=A0=C2=A0	struct arena_atomics *skel;
> > @@ -180,6 +196,8 @@ void test_arena_atomics(void)
> > =C2=A0=C2=A0		test_cmpxchg(skel);
> > =C2=A0=C2=A0	if (test__start_subtest("xchg"))
> > =C2=A0=C2=A0		test_xchg(skel);
> > +	if (test__start_subtest("uaf"))
> > +		test_uaf(skel);
> > =C2=A0=20
> > =C2=A0 cleanup:
> > =C2=A0=C2=A0	arena_atomics__destroy(skel);
> > diff --git a/tools/testing/selftests/bpf/progs/arena_atomics.c
> > b/tools/testing/selftests/bpf/progs/arena_atomics.c
> > index 55f10563208d..0ea310713fe6 100644
> > --- a/tools/testing/selftests/bpf/progs/arena_atomics.c
> > +++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
> > @@ -176,3 +176,79 @@ int xchg(const void *ctx)
> > =C2=A0=20
> > =C2=A0=C2=A0	return 0;
> > =C2=A0 }
> > +
> > +__u64 __arena uaf_sink;
> > +volatile __u64 __arena uaf_recovery_fails;
> > +
> > +SEC("syscall")
> > +int uaf(const void *ctx)
> > +{
> > +	if (pid !=3D (bpf_get_current_pid_tgid() >> 32))
> > +		return 0;
> > +#if defined(ENABLE_ATOMICS_TESTS) && !defined(__TARGET_ARCH_arm64)
> > && \
> > +=C2=A0=C2=A0=C2=A0 !defined(__TARGET_ARCH_x86)
> > +	__u32 __arena *page32;
> > +	__u64 __arena *page64;
> > +	void __arena *page;
> > +
>=20
> Looks like the selftest is failing s390x-gcc CI build, ptal :
>=20
> =C2=A0=C2=A0
> https://github.com/kernel-patches/bpf/actions/runs/9745362735/job/2689316=
5998
>=20
> =C2=A0=C2=A0 [...]
> =C2=A0=C2=A0=C2=A0=C2=A0 CLNG-BPF [test_maps] btf__core_reloc_size.bpf.o
> =C2=A0=C2=A0=C2=A0=C2=A0 CLNG-BPF [test_maps] bind6_prog.bpf.o
> =C2=A0=C2=A0 progs/arena_atomics.c:190:8: error: 'section' attribute only
> applies to functions, global variables, Objective-C methods, and
> Objective-C properties
> =C2=A0=C2=A0=C2=A0=C2=A0 190 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 __u32 __arena *page32;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> =C2=A0=C2=A0 progs/arena_atomics.c:32:17: note: expanded from macro '__ar=
ena'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32 | #define __arena SEC(".addr_space.1")
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ^
> =C2=A0=C2=A0
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/bpf/bpf_h
> elpers.h:40:17: note: expanded from macro 'SEC'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 40 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 __attribute__((section(name),
> used))=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> =C2=A0=C2=A0 progs/arena_atomics.c:191:8: error: 'section' attribute only
> applies to functions, global variables, Objective-C methods, and
> Objective-C properties
> =C2=A0=C2=A0=C2=A0=C2=A0 191 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 __u64 __arena *page64;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> =C2=A0=C2=A0 progs/arena_atomics.c:32:17: note: expanded from macro '__ar=
ena'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32 | #define __arena SEC(".addr_space.1")
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ^
> =C2=A0=C2=A0
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/bpf/bpf_h
> elpers.h:40:17: note: expanded from macro 'SEC'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 40 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 __attribute__((section(name),
> used))=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> =C2=A0=C2=A0 progs/arena_atomics.c:192:7: error: 'section' attribute only
> applies to functions, global variables, Objective-C methods, and
> Objective-C properties
> =C2=A0=C2=A0=C2=A0=C2=A0 192 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 void __arena *page;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> =C2=A0=C2=A0 progs/arena_atomics.c:32:17: note: expanded from macro '__ar=
ena'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32 | #define __arena SEC(".addr_space.1")
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ^
> =C2=A0=C2=A0
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/bpf/bpf_h
> elpers.h:40:17: note: expanded from macro 'SEC'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 40 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 __attribute__((section(name),
> used))=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> =C2=A0=C2=A0 3 errors generated.
> =C2=A0=C2=A0=C2=A0=C2=A0 CLNG-BPF [test_maps] cpumask_success.bpf.o
> =C2=A0=C2=A0 make: *** [Makefile:654:
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/arena_atomics.bpf.o]
> Error 1
> =C2=A0=C2=A0 make: *** Waiting for unfinished jobs....
> =C2=A0=C2=A0=C2=A0=C2=A0 CLNG-BPF [test_maps] fib_lookup.bpf.o
> =C2=A0=C2=A0 make: Leaving directory
> '/tmp/work/bpf/bpf/tools/testing/selftests/bpf'
> =C2=A0=C2=A0 Error: Process completed with exit code 2.

Apparently this particular test redefines the __arena macro.

The "common" definition is __attribute__((address_space(1))) for LLVM,
and nothing for GCC. I assume this doesn't work if one wants to have
globals inside the arena, hence the redefinition. Unfortunately the
redefinition breaks the usage of __arena in pointer types.

I think I will replace the redefinition with a separate __arena_global
macro.

