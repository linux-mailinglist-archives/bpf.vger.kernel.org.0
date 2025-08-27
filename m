Return-Path: <bpf+bounces-66725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEDDB38B28
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 22:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663001B2287D
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 20:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAC13093DB;
	Wed, 27 Aug 2025 20:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zl7SNLI0"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D37A3093A7
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 20:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756328090; cv=none; b=YlxFSSfnKuNc/bZWsGcj87lNMvdDpImziSwJVF0+R1D9Xr41nodouJAT0jYIgaLUvwfe7XWii4odRwbT7YJjuymE6BYkU9t3tb3tuBeZ+42AUFrQ1E9GUghTRDali28+VTUAv++aKfY+KrWwFA+1a1zJgUL2FNAhywMoejOE9cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756328090; c=relaxed/simple;
	bh=enOLSMcvqQFqc4wggtW0c2Xafnx8M5YKbvAVgogzV3w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BX4kUCG+8IEIDJzJQtcveewGznYrQQbK4kL2kVbwceOqdylYkTMLn0LlRrCrrH5vUucY9rf//8rSW6enqmv0QWCi1WsWahd5t0zn02PiZeiaihp03Q8zqn+W527ZwXyNVsASluClIZGip8+ZW773MJHWVYERRvx+9P/wTkNzR5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zl7SNLI0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57REnOVt008960;
	Wed, 27 Aug 2025 20:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RO5IXF
	oER3OSECj+051AGevDkN11ogBxyyq54GD+3cE=; b=Zl7SNLI0BtbqVz67WFjKw5
	c7DSgR9fg2G4Eyya1odzW7MwPHy9/SkZox2zZifNURuxlndRekQrQAFHD83vU/Pl
	sUM6EWgsp06Pi7ajRY6cAWHoF2l+yJJYsyOjHw2cAIeeSeAWn5uUGrgtwwJfhIJw
	uxFWcPn4odMh5/mrJsgFSmCB47OOIcb8dZQiGsWDwfRsrdi6ISKzFz+HN9BPpaV8
	6DaYerzI2/0I0FB6Q1UUjplwidgToVfpypjXD+HZ/cUWm8yh1preAkXso1JPl+oq
	NUKCHYfC16/VGaDKLy3lyLzvos3KEYstWvATLQLAH5ug4iaMxh6NGJcILiCUHWvQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5586chf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 20:54:35 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57RKoiPA003109;
	Wed, 27 Aug 2025 20:54:34 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5586che-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 20:54:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57RH9X8C018006;
	Wed, 27 Aug 2025 20:54:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qtp3hh6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 20:54:33 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57RKsTsG58589620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 20:54:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBEB220040;
	Wed, 27 Aug 2025 20:54:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B7AF20043;
	Wed, 27 Aug 2025 20:54:29 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Aug 2025 20:54:29 +0000 (GMT)
Message-ID: <f1b6178d73d242c20ac2345d2da9293dd3d1906f.camel@linux.ibm.com>
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
Date: Wed, 27 Aug 2025 22:54:28 +0200
In-Reply-To: <CAEf4BzYaZJ-TH_T32QpuxdeXOa4yt1dqrExbV6xrsXvs+kp6kQ@mail.gmail.com>
References: <20250827130519.411700-1-iii@linux.ibm.com>
	 <20250827130519.411700-2-iii@linux.ibm.com>
	 <CAEf4BzZgf4vRWnse6N1X_h4X6XPuax_iMxiJ5x=kwLyJzz8x-w@mail.gmail.com>
	 <1c796beb8e6d864f6c7498b8a31e2085986e2d60.camel@linux.ibm.com>
	 <CAEf4BzYaZJ-TH_T32QpuxdeXOa4yt1dqrExbV6xrsXvs+kp6kQ@mail.gmail.com>
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
X-Proofpoint-GUID: X07_5cXZPJ0Ppa7Z1MER4u7Az7txtJkR
X-Proofpoint-ORIG-GUID: y3mGMOT5wVu7kkuBK3NYCxEqzxDQ6pnw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfX9FCUtlh7Scff
 2tG0CtDPv3fEfGkKZOSPKjChxoL3NAVW22kgPGzCxcwnseSspOvrZ98s1Avvs+vS8jg/spwiuBB
 OoD3Ksnk59l5Piy/GMse+/SP8YF4GvuC7sOSGLCVvSQ7ANiKAwOLtNvIGFXtA2Q4FltamfDPAwx
 ozEPoJ58P+HgmPYUIHxd21XmxNVyUKnNzDiYo0fn+v7LuV/WmdyEcZGPFQHbopzxpJk9zB1JuOr
 zivHe/oWCetN9xxF0giN3WXZaLBC9SpGdAGzzeREAl2MeGHcRSqiFbQICMYMxjkk3QrK90SHWvu
 MLWGFVyOP6VcRhQvmp3JrQqO+FkBNeHwXsvlBoz0YjpbUe4fnOaVZuhhnlKKuJKAVrSWKvwSHe9
 5J7B0RcC
X-Authority-Analysis: v=2.4 cv=A8ZsP7WG c=1 sm=1 tr=0 ts=68af708b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=mDV3o1hIAAAA:8 a=VnNF1IyMAAAA:8 a=w6ymiwjzJMe31lApeFsA:9 a=QEXdDO2ut3YA:10
 a=oo2sN6aoFaAA:10 a=dKuBx9SDB9gA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230021

On Wed, 2025-08-27 at 13:05 -0700, Andrii Nakryiko wrote:
> On Wed, Aug 27, 2025 at 11:34=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.=
com>
> wrote:
> >=20
> > On Wed, 2025-08-27 at 10:32 -0700, Andrii Nakryiko wrote:
> > > On Wed, Aug 27, 2025 at 6:05=E2=80=AFAM Ilya Leoshkevich
> > > <iii@linux.ibm.com>
> > > wrote:
> > > >=20
> > > > The verifier requires that pointers returned by
> > > > bpf_obj_new_impl()
> > > > are
> > > > either dropped or stored in a map. Therefore programs that do
> > > > not
> > > > use
> > > > its return values will fail to load. Make the compiler point
> > > > out
> > > > these
> > > > issues. Adjust selftests that check that the verifier does
> > > > indeed
> > > > spot
> > > > these bugs.
> > > >=20
> > > > Link:
> > > > https://lore.kernel.org/bpf/CAADnVQL6Q+QRv3_JwEd26biwGpFYcwD_=3DBjB=
JWLAtpgOP9CKRw@mail.gmail.com/
> > > > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > ---
> > > > =C2=A0tools/lib/bpf/bpf_helpers.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++++
> > > > =C2=A0tools/testing/selftests/bpf/bpf_experimental.h=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> > > > =C2=A0tools/testing/selftests/bpf/progs/linked_list_fail.c | 8 ++++=
-
> > > > ---
> > > > =C2=A03 files changed, 9 insertions(+), 5 deletions(-)

[...]

> > > > =C2=A0/* When utilizing vmlinux.h with BPF CO-RE, user BPF programs
> > > > can't include
> > > > =C2=A0 * any system-level headers (such as stddef.h,
> > > > linux/version.h,
> > > > etc), and
> > > > =C2=A0 * commonly-used macros like NULL and KERNEL_VERSION aren't
> > > > available through
> > > > diff --git a/tools/testing/selftests/bpf/bpf_experimental.h
> > > > b/tools/testing/selftests/bpf/bpf_experimental.h
> > > > index da7e230f2781..e5ef4792da42 100644
> > > > --- a/tools/testing/selftests/bpf/bpf_experimental.h
> > > > +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> > > > @@ -20,7 +20,7 @@
> > > > =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 A pointer to an object of the type=
 corresponding to the
> > > > passed in
> > > > =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 'local_type_id', or NULL on failur=
e.
> > > > =C2=A0 */
> > > > -extern void *bpf_obj_new_impl(__u64 local_type_id, void *meta)
> > > > __ksym;
> > > > +extern __must_check void *bpf_obj_new_impl(__u64
> > > > local_type_id,
> > > > void *meta) __ksym;
> > >=20
> > > bpf_obj_new_impl will generally come from vmlinux.h nowadays, and
> > > that
> > > one won't have __must_check annotation, is that a problem?
> >=20
> > It should be fine according to [1]:
> >=20
> > Compatible attribute specifications on distinct declarations of the
> > same function are merged.
> >=20
> > I will add this to the commit message in v3.
>=20
> Sure, for BPF selftests it will work. My question was broader, for
> anyone using bpf_obj_new in the wild, they won't have __must_check
> annotation from vmlinux.h (and I doubt they will manually add it like
> we do here for BPF selftests), so if that's important, I guess we
> need
> to think how to wire that up so that it happens automatically through
> vmlinux.h.
>=20
> "It's not that important to bother" is a fine answer as well :)

I see. Seems like it's tough:

- The attribute is not available in DWARF
- But we could introduce KF_MUST_CHECK flag
- Which pahole would extract from .BTF_ids and convert to=C2=A0
  a=C2=A0btf_decl_tag
  - This will make pahole depend on .BTF_ids format though, which might
    be undesirable
- Then bpftool would convert this btf_decl_tag to __must_check

Seems like they are attempting to upstream the new
DW_TAG_GNU_annotation right now [1], if that lands and is available
for non-BPF targets, we could put=C2=A0
__attribute((btf_decl_tag("must_check"))) on kernel's
bpf_obj_new_impl() and directly access it from bpftool.

So for now I would propose to limit the solution to selftests.

[1] https://gcc.gnu.org/pipermail/gcc-patches/2025-August/692445.html

> > [1]
> > https://gcc.gnu.org/onlinedocs/gcc-12.4.0/gcc/Function-Attributes.html
> >=20
> > [...]

