Return-Path: <bpf+bounces-66650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C17FB38108
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 13:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 080C37B4D1A
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 11:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F59034F465;
	Wed, 27 Aug 2025 11:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rI0/XwXV"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370E43164B0;
	Wed, 27 Aug 2025 11:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294005; cv=none; b=Hg9UDUk+VylWnmdaOLSzG4Q06KR4eI904h3v8c6wAV/vc8LZXqNqlLcWKL/bp65m3qa9btzxxVz2ZClzpk9SdfFI9g0N20q2/3+ZnbSRgki6BQc0jRmX1greFHElVtXaFwB3OsLghKy0KIHaN5tG/EIKIpEbv8FPVIpzsNx4zy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294005; c=relaxed/simple;
	bh=/3Sdl+9Hs4FydUTYom9e80aLYCOQA3AX9l4E0K1R1+E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oGJNwXSceT389IrXFaps5BxUhZNU7LdokVq5hRMExj0/BVQByH2uvgpi2tkghTJvbYhOm31/T7CSm94OaunHl+QrSELrWdXb+HgMK/6ULv9HDx66W0HuTHYkseY+fMWwih5Dx4jNn8fFVO1Er/aSd5cw6AqxJQK9xx1hiCxN+bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rI0/XwXV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R1GrTS021753;
	Wed, 27 Aug 2025 11:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/3Sdl+
	9Hs4FydUTYom9e80aLYCOQA3AX9l4E0K1R1+E=; b=rI0/XwXVuA9sb6aICiffPq
	3BTnQqYFWrMSJFajmzN/4tTIrx2Ts/V6fWatQFxBafZfGWPggB9maTHWZjfnQj6X
	8TReVuvt1Ut44XvIVwbHyaO5njX0thdfPLzmEHOD+apVE76KNazYW0H5LSOg64P2
	WgMZQULMASZw+7e5iTJim9ohrrHQVvZUckA2azFMwZLgd9g3c4qkffcUf+DkUgls
	4EWWehtmWt82feFeM0G5YVYuoLcosgluU4P2EyEQ8MhMBC4/fOAa06xB9XH3nWsJ
	xd2MDmAgq+r4hMT0E58XcCfL6Jo6WEo31jdl+V+h33eeVGs5J8OHLKMoDjm8twXA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5avkqc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 11:26:21 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57RBIm14017214;
	Wed, 27 Aug 2025 11:26:20 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5avkqc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 11:26:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57RAm7rk007514;
	Wed, 27 Aug 2025 11:26:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qqyufw92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 11:26:19 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57RBQGQH30343840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 11:26:16 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BFCF20043;
	Wed, 27 Aug 2025 11:26:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E64F20040;
	Wed, 27 Aug 2025 11:26:15 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Aug 2025 11:26:14 +0000 (GMT)
Message-ID: <304f8078d9f6d523f4e334503384d7decd6f205d.camel@linux.ibm.com>
Subject: Re: [PATCH 0/2] scripts/gdb/symbols: make BPF debug info available
 to GDB
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
 <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jan Kiszka
 <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        LKML
 <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens	
 <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev	
 <agordeev@linux.ibm.com>
Date: Wed, 27 Aug 2025 13:26:14 +0200
In-Reply-To: <CAADnVQ+MYKvqRNSHFkMPxENNaZfrvEN8npY2JfiO_izxk1gUFw@mail.gmail.com>
References: <20250710115920.47740-1-iii@linux.ibm.com>
	 <8a20f7ba33426bb6ced600f97f5f67e9d67ea503.camel@linux.ibm.com>
	 <CAADnVQ+MYKvqRNSHFkMPxENNaZfrvEN8npY2JfiO_izxk1gUFw@mail.gmail.com>
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
X-Proofpoint-GUID: vxJE-a3qq31fN7diTDv5cHvJtfx3I6tK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfX/DgCX+sBZ2Lw
 oPCXpGl/M0Nw5g+iJhxxyBPOIiVK0RGZssxM3+jQZ/JHAymt4opXf//a6/P/U1qe/Q0j8TzqkIJ
 xhk8/izkx3IYnJ9+CUxUb0aGh/bRPCBsJ3tMa9SZk8P7yhli5IlvyX17poYQsY7D5Cm7ebeRvYt
 m/jAeGPHnt3zixAZdLPvRENRmZcVokVd2MkAMgcuvMUv79Sa2PkuuuFwfYve5YwF7raRluKrUJV
 CEqCN4135G+kuztTYQOoVBpd3JbJArmhHpcHnLKoAMVDd6jadJoCHVL7s7Q1hJiipJj4YHf/q4V
 9fPQu6QmcXJI+y1WYjSLhfMaubfqbI7rLhc8QytDQPYb/NkfhA5ECXd3KqP8Bxou4IsIvVmsPxY
 ARtiuED0
X-Proofpoint-ORIG-GUID: -CFWS1NRaOp9G16fGYKIVH1tuyOhKRxR
X-Authority-Analysis: v=2.4 cv=SNNCVPvH c=1 sm=1 tr=0 ts=68aeeb5d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=Q-fNiiVtAAAA:8
 a=VnNF1IyMAAAA:8 a=HnuNM1E2Df1o6BHR4eQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230021

On Tue, 2025-08-05 at 09:48 -0700, Alexei Starovoitov wrote:
> On Tue, Aug 5, 2025 at 6:23=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.co=
m>
> wrote:
> >=20
> > On Thu, 2025-07-10 at 13:53 +0200, Ilya Leoshkevich wrote:
> > > Hi,
> > >=20
> > > This series greatly simplifies debugging BPF progs when using
> > > QEMU
> > > gdbstub by providing symbol names, sizes, and line numbers to
> > > GDB.
> > >=20
> > > Patch 1 adds radix tree iteration, which is necessary for parsing
> > > prog_idr. Patch 2 is the actual implementation; its description
> > > contains some details on how to use this.
> > >=20
> > > Best regards,
> > > Ilya
> > >=20
> > > Ilya Leoshkevich (2):
> > > =C2=A0 scripts/gdb/radix-tree: add lx-radix-tree-command
> > > =C2=A0 scripts/gdb/symbols: make BPF debug info available to GDB
> > >=20
> > > =C2=A0scripts/gdb/linux/bpf.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 253
> > > ++++++++++++++++++++++++++++++
> > > =C2=A0scripts/gdb/linux/constants.py.in |=C2=A0=C2=A0 3 +
> > > =C2=A0scripts/gdb/linux/radixtree.py=C2=A0=C2=A0=C2=A0 | 139 ++++++++=
+++++++-
> > > =C2=A0scripts/gdb/linux/symbols.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 77 ++++++++-
> > > =C2=A04 files changed, 462 insertions(+), 10 deletions(-)
> > > =C2=A0create mode 100644 scripts/gdb/linux/bpf.py
> >=20
> > Gentle ping. Any opinions on whether this is valuable? Personally
> > I've
> > been using this for quite some time, and having source level
> > debugging
> > for BPF progs (even if variables can't be inspected) feels really
> > nice.
>=20
> Looks very useful to me.
> Not sure which git tree it should be routed to.

Thanks, glad to hear that!

I think it makes sense to route it via the Andrew Morton's tree, like
all the other GDB patches. IIUC the proposal to ask subsystems to
maintain GDB scripts relevant to them [1] didn't go anywhere.

[1]
https://lore.kernel.org/all/20250625231053.1134589-1-florian.fainelli@broad=
com.com/

