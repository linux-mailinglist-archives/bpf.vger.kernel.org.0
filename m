Return-Path: <bpf+bounces-66727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF01B38B37
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 23:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959131883412
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 21:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D0B30C35D;
	Wed, 27 Aug 2025 21:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hkt1HEM8"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79732FDC5D
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 21:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756328675; cv=none; b=KgoDEFjnjT5S2KZmQwFQ/Ks0VxECtW8B9BNPExEH831+tfRCt/kYhGt4j07wRPzu22c8h41MvYUlml+HBk7nQBhYL5Z6E8iD1kHcuZoml4iJbaZ41YyignewgF3wwBYDmUQP6v8LIr4vh5A3Nq3upBOIQmKfAvtwwaAsEzaGMeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756328675; c=relaxed/simple;
	bh=p7k21Q1g8XD+FZ6BsUB+CgbhUrEsZOoo8hkwLJDfRFE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TMghJsZU1DRD9X0AYmf+6tUgEBBAjrhtqKp3QznVyQ+uWg+wQHIomjgZQyFwUTEUxI/UzbgiUPydzOEJgU40rh3Tw7JBEIVQiSNrgugfuBM+SUuCy9Ufj8a+YzqvFFg8sd0T2eSgSMrI05XSacD0T94ylVuuaeMiEduUVG2PPTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hkt1HEM8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RFRx0Z012568;
	Wed, 27 Aug 2025 21:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p7k21Q
	1g8XD+FZ6BsUB+CgbhUrEsZOoo8hkwLJDfRFE=; b=hkt1HEM8s3einLNx+beile
	BfSctW/c9L+dy119bdbp1U+SonJB8DE81LGtECKRkK3FGLydjJIpD8HuoQ0P3K5v
	IdFOoAT4g2juu8FTmGibDSsjlv2LTZVzrBWpMgxNgmJ5eFpSY6ab2w0UxHgeyYBU
	SgwYex7ZZRQsqVW6afCYKr91XdH7G2t6YE1tSomfODO96d10K1anNfqtCz+anJsC
	nj43U+8QuAF7X9xpbL0msAhPkEpwPd6BAJjAk0axk3lpZsJDIAS0PXveYdK2so6F
	d4QZ2p8BPMGrAxIyY2XReJ9SXR3XQ7zEsB1D41u58c00aKGZ/qq3shWD9AaF0CXw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5hq63f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 21:04:19 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57RKuZN4011057;
	Wed, 27 Aug 2025 21:04:19 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5hq63f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 21:04:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57RJjOnY002502;
	Wed, 27 Aug 2025 21:04:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48qrypsuyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 21:04:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57RL4ERA49348870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 21:04:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 423EF20043;
	Wed, 27 Aug 2025 21:04:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A822220040;
	Wed, 27 Aug 2025 21:04:13 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Aug 2025 21:04:13 +0000 (GMT)
Message-ID: <b1b7ffb001712eca27cfafb71365920833eafcd9.camel@linux.ibm.com>
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
Date: Wed, 27 Aug 2025 23:04:13 +0200
In-Reply-To: <f1b6178d73d242c20ac2345d2da9293dd3d1906f.camel@linux.ibm.com>
References: <20250827130519.411700-1-iii@linux.ibm.com>
		 <20250827130519.411700-2-iii@linux.ibm.com>
		 <CAEf4BzZgf4vRWnse6N1X_h4X6XPuax_iMxiJ5x=kwLyJzz8x-w@mail.gmail.com>
		 <1c796beb8e6d864f6c7498b8a31e2085986e2d60.camel@linux.ibm.com>
		 <CAEf4BzYaZJ-TH_T32QpuxdeXOa4yt1dqrExbV6xrsXvs+kp6kQ@mail.gmail.com>
	 <f1b6178d73d242c20ac2345d2da9293dd3d1906f.camel@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfX+t3p+LVpmBJ5
 t3VLQNRT8rNXWzdqbsGhUyLys6X9z9gTKce84mVSx7SbhdZZZc1BIeBHKspvfy8GviTvrNeitSa
 W1cpnYjZTg3L0oNJiEzj7cs/wOAJQpbJbZxS03swkyOHMqXpCpzRp5ZOPf91FpnIRkk0qaFQNEf
 Jp6suiwemzUUGnCeZ4M7Z6gB397F154ywBG0bY/uOhc1iF7MbYMAuB9/fJipIzFYqIQxf3Acjq5
 LDA3l0YBaJJAJumCWghAXTGZaYK/gDS3WPkOyFruw8jehSkAlG9b4w6k96P93A0X5VvQklVqcqr
 q34kK/yawj59ozOgnxZb9NGzMo7DFY2yRnUS6CzHECI1HegbDFQqa0AZoNQj81xf1yvxe56dYqZ
 mzZ6z6/9
X-Proofpoint-ORIG-GUID: LxDrbveNHav3Mgsf088uaaRaSIZg8VoU
X-Proofpoint-GUID: yn0WlnssQScxaZUMoNlXnCRdsiBHq1ow
X-Authority-Analysis: v=2.4 cv=Ndbm13D4 c=1 sm=1 tr=0 ts=68af72d3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=mDV3o1hIAAAA:8 a=VnNF1IyMAAAA:8 a=7DLYDM9hzJxKqEZNRl4A:9 a=QEXdDO2ut3YA:10
 a=oo2sN6aoFaAA:10 a=dKuBx9SDB9gA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230021

On Wed, 2025-08-27 at 22:54 +0200, Ilya Leoshkevich wrote:
> On Wed, 2025-08-27 at 13:05 -0700, Andrii Nakryiko wrote:
> > On Wed, Aug 27, 2025 at 11:34=E2=80=AFAM Ilya Leoshkevich
> > <iii@linux.ibm.com>
> > wrote:
> > >=20
> > > On Wed, 2025-08-27 at 10:32 -0700, Andrii Nakryiko wrote:
> > > > On Wed, Aug 27, 2025 at 6:05=E2=80=AFAM Ilya Leoshkevich
> > > > <iii@linux.ibm.com>
> > > > wrote:
> > > > >=20
> > > > > The verifier requires that pointers returned by
> > > > > bpf_obj_new_impl()
> > > > > are
> > > > > either dropped or stored in a map. Therefore programs that do
> > > > > not
> > > > > use
> > > > > its return values will fail to load. Make the compiler point
> > > > > out
> > > > > these
> > > > > issues. Adjust selftests that check that the verifier does
> > > > > indeed
> > > > > spot
> > > > > these bugs.
> > > > >=20
> > > > > Link:
> > > > > https://lore.kernel.org/bpf/CAADnVQL6Q+QRv3_JwEd26biwGpFYcwD_=3DB=
jBJWLAtpgOP9CKRw@mail.gmail.com/
> > > > > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > > > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > > ---
> > > > > =C2=A0tools/lib/bpf/bpf_helpers.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4
> > > > > ++++
> > > > > =C2=A0tools/testing/selftests/bpf/bpf_experimental.h=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> > > > > =C2=A0tools/testing/selftests/bpf/progs/linked_list_fail.c | 8
> > > > > ++++-
> > > > > ---
> > > > > =C2=A03 files changed, 9 insertions(+), 5 deletions(-)
>=20
> [...]
>=20
> > > > > =C2=A0/* When utilizing vmlinux.h with BPF CO-RE, user BPF
> > > > > programs
> > > > > can't include
> > > > > =C2=A0 * any system-level headers (such as stddef.h,
> > > > > linux/version.h,
> > > > > etc), and
> > > > > =C2=A0 * commonly-used macros like NULL and KERNEL_VERSION aren't
> > > > > available through
> > > > > diff --git a/tools/testing/selftests/bpf/bpf_experimental.h
> > > > > b/tools/testing/selftests/bpf/bpf_experimental.h
> > > > > index da7e230f2781..e5ef4792da42 100644
> > > > > --- a/tools/testing/selftests/bpf/bpf_experimental.h
> > > > > +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> > > > > @@ -20,7 +20,7 @@
> > > > > =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 A pointer to an object of the ty=
pe corresponding to
> > > > > the
> > > > > passed in
> > > > > =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 'local_type_id', or NULL on fail=
ure.
> > > > > =C2=A0 */
> > > > > -extern void *bpf_obj_new_impl(__u64 local_type_id, void
> > > > > *meta)
> > > > > __ksym;
> > > > > +extern __must_check void *bpf_obj_new_impl(__u64
> > > > > local_type_id,
> > > > > void *meta) __ksym;
> > > >=20
> > > > bpf_obj_new_impl will generally come from vmlinux.h nowadays,
> > > > and
> > > > that
> > > > one won't have __must_check annotation, is that a problem?
> > >=20
> > > It should be fine according to [1]:
> > >=20
> > > Compatible attribute specifications on distinct declarations of
> > > the
> > > same function are merged.
> > >=20
> > > I will add this to the commit message in v3.
> >=20
> > Sure, for BPF selftests it will work. My question was broader, for
> > anyone using bpf_obj_new in the wild, they won't have __must_check
> > annotation from vmlinux.h (and I doubt they will manually add it
> > like
> > we do here for BPF selftests), so if that's important, I guess we
> > need
> > to think how to wire that up so that it happens automatically
> > through
> > vmlinux.h.
> >=20
> > "It's not that important to bother" is a fine answer as well :)
>=20
> I see. Seems like it's tough:
>=20
> - The attribute is not available in DWARF
> - But we could introduce KF_MUST_CHECK flag
> - Which pahole would extract from .BTF_ids and convert to=C2=A0
> =C2=A0 a=C2=A0btf_decl_tag
> =C2=A0 - This will make pahole depend on .BTF_ids format though, which
> might
> =C2=A0=C2=A0=C2=A0 be undesirable

Hm, I should have checked that before hitting "send": apparently pahole
already parses both .BTF_ids and __BTF_ID__set8__*.
Still, DW_TAG_GNU_annotation looks like a better long-term solution.

> - Then bpftool would convert this btf_decl_tag to __must_check
>=20
> Seems like they are attempting to upstream the new
> DW_TAG_GNU_annotation right now [1], if that lands and is available
> for non-BPF targets, we could put=C2=A0
> __attribute((btf_decl_tag("must_check"))) on kernel's
> bpf_obj_new_impl() and directly access it from bpftool.
>=20
> So for now I would propose to limit the solution to selftests.
>=20
> [1] https://gcc.gnu.org/pipermail/gcc-patches/2025-August/692445.html
>=20
> > > [1]
> > > https://gcc.gnu.org/onlinedocs/gcc-12.4.0/gcc/Function-Attributes.htm=
l
> > >=20
> > > [...]

