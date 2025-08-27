Return-Path: <bpf+bounces-66698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 402F6B389A6
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 20:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57AFE1BA5D98
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 18:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0D72750E6;
	Wed, 27 Aug 2025 18:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UvUeWBPp"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA0C24CEE8
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 18:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756319698; cv=none; b=Ufbhp7NYyoO7lXjPMF3/aYOO3fFvLuLp6GRtx9u005i7lMlMv0cLjYIm34HI5XRixnopUY1kps+p8lt6Cz6AHnVXpeYvGIjyk5dsUETo13kKWUo7jnjj9RGk/WrnD8sKEiU1m9NSESIr9UWzTaExhks8pE78w6epKyXp4Kt6nKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756319698; c=relaxed/simple;
	bh=NunAVvRkZ8/kzr6wjC/+6zeiCowVQ0QkOaqYjtTaqts=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GQyITmLy6Yc4BN3wSp+BQQVOiwPIpBLWsZhkUInArQnUjorAQpA+XW06f4HyqbbULrA7+3Hy2OH1ls9RYP7VrAFkEcEKdxjZZgDmaoWTjKYMhIeZtVKGii0VaXPCVQVDTGjDUHNTMUF6gg9blind2A62qF3j9VtXpC488Gv2Eu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UvUeWBPp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RHkqqC006043;
	Wed, 27 Aug 2025 18:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NunAVv
	RkZ8/kzr6wjC/+6zeiCowVQ0QkOaqYjtTaqts=; b=UvUeWBPpVefbq94KHSc7Cj
	6YIqtRfUkS+PxYCwqJbmxwcowBe5UyqIKpnYtVJu6ygaV+5P/afoWzaB1VoFcjlC
	ATQSpz1RiauvAyeFLA3cETy0OqufoXwI0znPE2XK9LHWDpPps9cWVLQK/HPbJpqW
	me7EPD8jLc0T3J5V1+Zn7JeJI4ZTsmJ4sQK/ESbqbvITJO7+6wh/+ZULTXyAlMzO
	Ck2lAOILTKiY12fhIe5nwenp3XESREQUgKS06A3/2vfD4surzM+LCXRz2Yz4LXIE
	vDBF/5UgNmNAiWHii2f5bnaZX/MTxpjXnaMkJzguvQs5DG6XlJAg1tEhtE7o0QEg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q975d320-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 18:34:43 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57RIYh8I006622;
	Wed, 27 Aug 2025 18:34:43 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q975d31y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 18:34:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57RG1PWd002520;
	Wed, 27 Aug 2025 18:34:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48qrypsc2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 18:34:41 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57RIYb4U55247174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 18:34:38 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE41920043;
	Wed, 27 Aug 2025 18:34:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 621B520040;
	Wed, 27 Aug 2025 18:34:37 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Aug 2025 18:34:37 +0000 (GMT)
Message-ID: <1c796beb8e6d864f6c7498b8a31e2085986e2d60.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: Annotate
 bpf_obj_new_impl() with __must_check
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
 <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik	
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Date: Wed, 27 Aug 2025 20:34:37 +0200
In-Reply-To: <CAEf4BzZgf4vRWnse6N1X_h4X6XPuax_iMxiJ5x=kwLyJzz8x-w@mail.gmail.com>
References: <20250827130519.411700-1-iii@linux.ibm.com>
	 <20250827130519.411700-2-iii@linux.ibm.com>
	 <CAEf4BzZgf4vRWnse6N1X_h4X6XPuax_iMxiJ5x=kwLyJzz8x-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qgdEbdy7uGEMyKa9gSiFR6aXMQLlDvek
X-Proofpoint-ORIG-GUID: BqDUl0CuzzKk3vm3hDwXMcf-Xi_schVg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA3MSBTYWx0ZWRfX8Q6f/J8H3grA
 dC7OwL+YqLSd+H+f0liWHIbglms/PtQ14hnka3xOfQQG9Z/+SAIt2MEHv3aio/p2q1IuntWFeht
 UMQaCjPQvHR9fM5CEBPYv+JZemPczKNrtJhI5hPaTmAHZRWyHZ4Kq/doKV6iAaYQA8wO81oIsnU
 i1eukoXYuXauA12NvTaHqsh99rphnNhS2Uxj3USKGUz1UzSIz9gGwV5+TC8PP8EjfiMBAmWONhb
 edlzxC/ZokC1qqTkub30nAm0k9qe5N87LYH6By5h963otdSKouvZ4PCINUwmn1g1oWlJIfBUVCj
 TpcyX0kcZqtEy3xhxn39SB/CGJXJR3zU4HuF/2lkYa5CEw3q3wMbD1mDwRo5VheODao2sYg874e
 zqLHMiO8
X-Authority-Analysis: v=2.4 cv=RtDFLDmK c=1 sm=1 tr=0 ts=68af4fc3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=mDV3o1hIAAAA:8 a=VnNF1IyMAAAA:8 a=PzmpnUmidr67t8GuaDMA:9 a=QEXdDO2ut3YA:10
 a=dKuBx9SDB9gA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230071

On Wed, 2025-08-27 at 10:32 -0700, Andrii Nakryiko wrote:
> On Wed, Aug 27, 2025 at 6:05=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.c=
om>
> wrote:
> >=20
> > The verifier requires that pointers returned by bpf_obj_new_impl()
> > are
> > either dropped or stored in a map. Therefore programs that do not
> > use
> > its return values will fail to load. Make the compiler point out
> > these
> > issues. Adjust selftests that check that the verifier does indeed
> > spot
> > these bugs.
> >=20
> > Link:
> > https://lore.kernel.org/bpf/CAADnVQL6Q+QRv3_JwEd26biwGpFYcwD_=3DBjBJWLA=
tpgOP9CKRw@mail.gmail.com/
> > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0tools/lib/bpf/bpf_helpers.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++++
> > =C2=A0tools/testing/selftests/bpf/bpf_experimental.h=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 2 +-
> > =C2=A0tools/testing/selftests/bpf/progs/linked_list_fail.c | 8 ++++----
> > =C2=A03 files changed, 9 insertions(+), 5 deletions(-)

The CI found an issue with bpf-gcc in the meantime, I will fix this in
v3.

> > diff --git a/tools/lib/bpf/bpf_helpers.h
> > b/tools/lib/bpf/bpf_helpers.h
> > index 80c028540656..e1496a328e3f 100644
> > --- a/tools/lib/bpf/bpf_helpers.h
> > +++ b/tools/lib/bpf/bpf_helpers.h
> > @@ -69,6 +69,10 @@
> > =C2=A0 */
> > =C2=A0#define __hidden __attribute__((visibility("hidden")))
> >=20
> > +#ifndef __must_check
> > +#define __must_check __attribute__((__warn_unused_result__))
> > +#endif
> > +
>=20
> do we need to add this to libbpf UAPI? let's put it in selftests
> header somewhere instead?

Will do.

>=20
> > =C2=A0/* When utilizing vmlinux.h with BPF CO-RE, user BPF programs
> > can't include
> > =C2=A0 * any system-level headers (such as stddef.h, linux/version.h,
> > etc), and
> > =C2=A0 * commonly-used macros like NULL and KERNEL_VERSION aren't
> > available through
> > diff --git a/tools/testing/selftests/bpf/bpf_experimental.h
> > b/tools/testing/selftests/bpf/bpf_experimental.h
> > index da7e230f2781..e5ef4792da42 100644
> > --- a/tools/testing/selftests/bpf/bpf_experimental.h
> > +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> > @@ -20,7 +20,7 @@
> > =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 A pointer to an object of the type cor=
responding to the
> > passed in
> > =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 'local_type_id', or NULL on failure.
> > =C2=A0 */
> > -extern void *bpf_obj_new_impl(__u64 local_type_id, void *meta)
> > __ksym;
> > +extern __must_check void *bpf_obj_new_impl(__u64 local_type_id,
> > void *meta) __ksym;
>=20
> bpf_obj_new_impl will generally come from vmlinux.h nowadays, and
> that
> one won't have __must_check annotation, is that a problem?

It should be fine according to [1]:

Compatible attribute specifications on distinct declarations of the
same function are merged.

I will add this to the commit message in v3.

[1]
https://gcc.gnu.org/onlinedocs/gcc-12.4.0/gcc/Function-Attributes.html

[...]

