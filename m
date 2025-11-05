Return-Path: <bpf+bounces-73695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75DEC377FB
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 20:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481CE3AE1DD
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 19:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30FA33F389;
	Wed,  5 Nov 2025 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oZwVT0eg"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF5D30FC3A;
	Wed,  5 Nov 2025 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762371196; cv=none; b=Y0YMz3qnwxF2LDqmxc4iqEcD/1d1PhIrU6qcLYdH2ZptaDUQ4V+2pdtMZa/1zsGIW3dTahGnJvqJBztFqEs7uGrM927iQQIEKH3XC44zmUI3av3x0x3Crl5i6tDMcOqqUCq+vB8MxnCqwCSwEXXQJBygflf4h0siwntQR9XzL1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762371196; c=relaxed/simple;
	bh=sC4pVjz5nexJHLhCwpKv2mgis9nGW809FMorwmcxnfI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VbduDwSuq5rwpgovGKQuok3HsrM8pTyHS4NkiCfH8em+XJX5vv5txhCoSx+rAVWGLVguqihPe/MAIvuPt8cH+VbqaRkjOLvTGiq9l8aDvwHXnFb+uEeXFAKoS05nLHLBud3vD2g5Nlcf6k1FN9l6plrcRUElrw5zYZzsJXRDNzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oZwVT0eg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5GMWtn019236;
	Wed, 5 Nov 2025 19:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sC4pVj
	z5nexJHLhCwpKv2mgis9nGW809FMorwmcxnfI=; b=oZwVT0egwC9sgC493PcA9Q
	3pDsGkrTmTjcVwDEN28XXR78dhbZ8uUv8bR4nDLcHz9g/EniZFjIQjIh7FlSY2st
	EhFoItQng0VG6Lo378/bTb3fuY6gKSBp6+f9c8g+O9Y16KaYlyBHipR117egAuXE
	6HLgXzgk2ap8mOXHlO6dvfpyJy7luKPHPgSlVKwYynsP/cTez1qsfiSBimPOualy
	0EnEBjwdo7oJt7YIOhoVXVToJVGLZ0hoeSbKNw79Nn/pCOKr0yPo2sdT5Z4yYj1c
	/bi3CDbm25eu9S6jVpQyubxZEKalDctguLU5o1tYwRp2oJt2tCGtXiJ1xWT2+mxQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a57mrb0f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 19:32:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5IkThu009903;
	Wed, 5 Nov 2025 19:32:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5x1khsxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 19:32:55 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A5JWphZ51446220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 19:32:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8E3920043;
	Wed,  5 Nov 2025 19:32:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E909220040;
	Wed,  5 Nov 2025 19:32:50 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.87.135.254])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Nov 2025 19:32:50 +0000 (GMT)
Message-ID: <ea1f1fd23d1bf4937c91be3bd45744b07b000b1e.camel@linux.ibm.com>
Subject: Re: [PATCH 0/2] scripts/gdb/symbols: make BPF debug info available
 to GDB
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Alexei Starovoitov
 <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko
 <andrii@kernel.org>,
        Kieran Bingham <kbingham@kernel.org>,
        Andrew Morton
 <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Heiko Carstens
	 <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
	 <agordeev@linux.ibm.com>
Date: Wed, 05 Nov 2025 20:32:50 +0100
In-Reply-To: <1eec0bc4-dc4a-4fe1-affa-3b8620dfc79d@siemens.com>
References: <20250710115920.47740-1-iii@linux.ibm.com>
	 <1eec0bc4-dc4a-4fe1-affa-3b8620dfc79d@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jW2hN8RnbASfzr0LffOBskEKbt18VvdI
X-Authority-Analysis: v=2.4 cv=MKhtWcZl c=1 sm=1 tr=0 ts=690ba668 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ypKVNuHTik4TnLp-rxMA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=HhbK4dLum7pmb74im6QT:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-ORIG-GUID: jW2hN8RnbASfzr0LffOBskEKbt18VvdI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAwMSBTYWx0ZWRfX0p3soDq5jouE
 H/ZaoJ+OJE3TWU78OnGj+nNItXTTEWbZUBlc4xt8MqAe0eiI1ikFKpumu+5jkCnYEFL2YiGAHe6
 dGkcmgG1sSQrWZQ9hvQWn/hIlU2cldtolsZAi2w4uOj9baIg8k8YfMXmsFwhFp2SiVpHqclVbTM
 ZF3f6sRdw07kj4WFHIAzoE396/NFi9YwqrlIBU4bV9GLxw+lMi++oP67FcE+o87MiTQxhUKo0+O
 N8z9gbPSUWD4EBB4TFAiMIY/ceGCTThDW7G5YW9qhPLeMYPpJYTD6iH1Kfh6VpIqfGKrEEsib2O
 GWovwWaN7M3WF2mO4Ad/FSY4hqoI2H5KsiKpnohumHMP3Sw+qYUMmaMhOpWWQ7IlDhNWH7RlDgb
 HbU4Alq6mNvA38vz+xMCFJFX1VRoMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_07,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010001

On Thu, 2025-10-30 at 17:47 +0100, Jan Kiszka wrote:
> On 10.07.25 13:53, Ilya Leoshkevich wrote:
> > Hi,
> >=20
> > This series greatly simplifies debugging BPF progs when using QEMU
> > gdbstub by providing symbol names, sizes, and line numbers to GDB.
> >=20
> > Patch 1 adds radix tree iteration, which is necessary for parsing
> > prog_idr. Patch 2 is the actual implementation; its description
> > contains some details on how to use this.
> >=20
> > Best regards,
> > Ilya
> >=20
> > Ilya Leoshkevich (2):
> > =C2=A0 scripts/gdb/radix-tree: add lx-radix-tree-command
> > =C2=A0 scripts/gdb/symbols: make BPF debug info available to GDB
> >=20
> > =C2=A0scripts/gdb/linux/bpf.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 253
> > ++++++++++++++++++++++++++++++
> > =C2=A0scripts/gdb/linux/constants.py.in |=C2=A0=C2=A0 3 +
> > =C2=A0scripts/gdb/linux/radixtree.py=C2=A0=C2=A0=C2=A0 | 139 ++++++++++=
+++++-
> > =C2=A0scripts/gdb/linux/symbols.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 77 ++++++++-
> > =C2=A04 files changed, 462 insertions(+), 10 deletions(-)
> > =C2=A0create mode 100644 scripts/gdb/linux/bpf.py
> >=20
>=20
> This wasn't picked up yet, right? Sorry for the late reply, my part
> of
> the "maintenance" here is best effort based.
>=20
> Looks good to me regarding integration. I haven't tried it out, I'm
> just
> wondering if it has notable performance impact on starting gdb or
> interacting or when that could be the case. BPF programs are not
> uncommon in common setups today. But if you don't want to debug them,
> does this add unneeded overhead?
>=20
> Otherwise, I think it could move forward if it still applies (which
> it
> likely does).
>=20
> Jan

Thanks for taking a look!

I have to admit the performance implications are noticeable due to
having to spawn an external process for each BPF prog.

What do you think about hiding this behind `lx-symbols --bpf` flag?

