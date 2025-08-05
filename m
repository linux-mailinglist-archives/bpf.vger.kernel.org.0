Return-Path: <bpf+bounces-65060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F27DB1B4D3
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 15:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF573ADE59
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 13:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F32B275113;
	Tue,  5 Aug 2025 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U2lNUL9v"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5892E274B29;
	Tue,  5 Aug 2025 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754400201; cv=none; b=G4a51Y3hcNhuw+kY6sbiud2QzI1aXYSFdxYBrmLd0Pybo074goUDZ6pjzc1IrpjE8j/VQ25c0oZiYgBGwAUD1KP8bHu9r+JQ6NeYZhzmVtSJyVDdaSh7SP6HNgqN1eRH4trtNJZmc5Bk5e7e8YMcm/88kIVbWUqtqS8nUn05A3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754400201; c=relaxed/simple;
	bh=Zk5egdCsb360flUD1N8NGncqCRIR4Mj9JAMrkJp+34o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VJL8N98u4fd7PNhGlHMHTXOPST5oqvrAalq+0Sj09fu1J617QahCXpQ5FCaOIgyr8McO3BApSCmH3Q0Z/Sgb7S0pVyvJclfXk7+U39+g2b+rSTXFL6x+N1wPAYPDy3bPH27b4YXm3cqPeBXVVPJsWFzxQdGHCK02EFFv0IC0vIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U2lNUL9v; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575CwNM8030778;
	Tue, 5 Aug 2025 13:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Zk5egd
	Csb360flUD1N8NGncqCRIR4Mj9JAMrkJp+34o=; b=U2lNUL9veAHJhvCpSNnkE4
	/8hkplRF1DvEX/l6M/buR7UKGqQ9UV3oLL0HJ0oN4/M7+FjMByjC6lnS1BIkkDKN
	Q4gwXd8cluYl7Le0eDo/qRpaDGfehGKyiBVr7oNSGg8nCzJibFzp6vTmlBIC5A3i
	xOa88XE8SDjxjKmxZ/gJ56hd3fZMulDfNmc1TUKBxh9vhzx610Y0q7nI5PsFq4JD
	QY2XSxmNcAfHlHvLepX6Lyi/vHgBYfFdquGyikHbARTwNP/L/jecqPq9VqRhkbXr
	GX4AmRjVKq5uyVsFRw1QtM2dbMAQaAfKhbGdAuX3N5peawvdRL8fgHLCE5Q2f1Fw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48b6keb3r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 13:23:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 575Ct3bZ001890;
	Tue, 5 Aug 2025 13:23:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 489wd02ngb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 13:23:03 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 575DMxga54133052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 13:22:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACDF02004E;
	Tue,  5 Aug 2025 13:22:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E408F2004B;
	Tue,  5 Aug 2025 13:22:58 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Aug 2025 13:22:58 +0000 (GMT)
Message-ID: <8a20f7ba33426bb6ced600f97f5f67e9d67ea503.camel@linux.ibm.com>
Subject: Re: [PATCH 0/2] scripts/gdb/symbols: make BPF debug info available
 to GDB
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
 <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jan Kiszka
 <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Heiko Carstens
	 <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
	 <agordeev@linux.ibm.com>
Date: Tue, 05 Aug 2025 15:22:58 +0200
In-Reply-To: <20250710115920.47740-1-iii@linux.ibm.com>
References: <20250710115920.47740-1-iii@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: mN_RglAhD4otnhK8CcEMfIj8drI5NE98
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA5OCBTYWx0ZWRfX/YPWw9KDd4bm
 f+eEsye8/Gp/CTmjQSGAIeTZXohSu3WxAufqx7uJCzRSFiERTLOdvuZrw7VLKOYwsSsqPfNgCKP
 oz4TgxrOKSxaOWbHNdDCxJILaaXz9g0H8pmQ2PWrt+95WAY0RsVJak6RFaPHjQij8O7D/QxUQPv
 vvLXU62AEcx+PMlx9ztz/BLODd19jX69tVDH4RlQriabLQ4be5P48wXi86G/P//4ENQVttvnQDb
 VTQjW8TbDMe75WiJJxbottsVm+jEZ7130a0yOaNTj1sGyl8WRIePOe8zeysEj/Zstsw3CXZO2pA
 nulmXmKgz0uDDKalXS89P6bGn4OKt1m/HE7oi/iJkSvg/hF2xYe6yZ/TZqIyztDC6QGvb8zgufj
 mNvxE0bRBSTmK0IgTGToQ9hKcmi+RpzL7548fIrcRKHI9yJ8KFVUPULYh2wDkSdbmxPlduv+
X-Authority-Analysis: v=2.4 cv=eLATjGp1 c=1 sm=1 tr=0 ts=689205b9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=NR5_5KzkQmZuu3-uLU0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mN_RglAhD4otnhK8CcEMfIj8drI5NE98
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=517 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050098

On Thu, 2025-07-10 at 13:53 +0200, Ilya Leoshkevich wrote:
> Hi,
>=20
> This series greatly simplifies debugging BPF progs when using QEMU
> gdbstub by providing symbol names, sizes, and line numbers to GDB.
>=20
> Patch 1 adds radix tree iteration, which is necessary for parsing
> prog_idr. Patch 2 is the actual implementation; its description
> contains some details on how to use this.
>=20
> Best regards,
> Ilya
>=20
> Ilya Leoshkevich (2):
> =C2=A0 scripts/gdb/radix-tree: add lx-radix-tree-command
> =C2=A0 scripts/gdb/symbols: make BPF debug info available to GDB
>=20
> =C2=A0scripts/gdb/linux/bpf.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 253
> ++++++++++++++++++++++++++++++
> =C2=A0scripts/gdb/linux/constants.py.in |=C2=A0=C2=A0 3 +
> =C2=A0scripts/gdb/linux/radixtree.py=C2=A0=C2=A0=C2=A0 | 139 ++++++++++++=
+++-
> =C2=A0scripts/gdb/linux/symbols.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
77 ++++++++-
> =C2=A04 files changed, 462 insertions(+), 10 deletions(-)
> =C2=A0create mode 100644 scripts/gdb/linux/bpf.py

Gentle ping. Any opinions on whether this is valuable? Personally I've
been using this for quite some time, and having source level debugging
for BPF progs (even if variables can't be inspected) feels really nice.

