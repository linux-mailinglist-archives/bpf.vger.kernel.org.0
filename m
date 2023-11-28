Return-Path: <bpf+bounces-16080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9095E7FC9CD
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 23:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63AF283108
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 22:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8EC46BB6;
	Tue, 28 Nov 2023 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lh3oWazs"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F11283
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 14:45:01 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASLgIti016473;
	Tue, 28 Nov 2023 22:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=i6f3RD5YHwVIVeGb7Q9LWFeOr2a+LKHu59RI9M7ld9g=;
 b=Lh3oWazswbBqW1ffGQ8eGspT2MS9vMQD2Y0dxXFfptvYMPoBcYUYufZ4XIur6YfvbCpA
 lMrAhzyBpBMTtdQzGrxy3fboRUNXLsNc2bctM7Q1mc1FDgHZftCsAQt9eVQFu8ccQdte
 qD+bxJLztHUne2gxKEXaQCQ8Lx7rrSrlHG5Dx+n4frUBobHTAWKSxt4MGPT9l5KREtSQ
 y7jbgqdqNtVi8AZtGKbCOYz4SCOSPvY2tpC5Sh9zT2hcd+aAQYxOsVW9OvUxQF/oz9sc
 Cs/vhBSze5F/oTH9k3zHSGwMWc/IYZZ3qrDxgaSPDxu57kQFCC+5wuVt7z8I4H8rbpWS sA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unrbq9m9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 22:44:38 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ASLgqLZ017659;
	Tue, 28 Nov 2023 22:44:37 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unrbq9m8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 22:44:37 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASJvgPD012226;
	Tue, 28 Nov 2023 22:44:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukvrkk70a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 22:44:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ASMiYqx18023042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 22:44:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C1E520043;
	Tue, 28 Nov 2023 22:44:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5225020040;
	Tue, 28 Nov 2023 22:44:33 +0000 (GMT)
Received: from [9.171.93.155] (unknown [9.171.93.155])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Nov 2023 22:44:33 +0000 (GMT)
Message-ID: <22e3824bce10a895b1c9ce33ed7473561d288e69.camel@linux.ibm.com>
Subject: Re: [PATCHv2 bpf 0/2] bpf: Fix prog_array_map_poke_run map poke
 update
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu
 <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend
 <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Stanislav
 Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Xu Kuohai
 <xukuohai@huawei.com>,
        Will Deacon <will@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>,
        Pu Lehui <pulehui@huawei.com>,
        =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Lee Jones
 <lee@kernel.org>
Date: Tue, 28 Nov 2023 23:44:33 +0100
In-Reply-To: <20231128092850.1545199-1-jolsa@kernel.org>
References: <20231128092850.1545199-1-jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: moP4c7jPsMZpMQg-S5IHGNGlviCio8H8
X-Proofpoint-ORIG-GUID: 6Lf-vkzMX3gdKUqpBNd76oUvNDuA5X0j
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_24,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=602 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280179

On Tue, 2023-11-28 at 10:28 +0100, Jiri Olsa wrote:
> hi,
> this patchset fixes the issue reported in [0].
>=20
> For the actual fix in patch 2 I'm changing bpf_arch_text_poke to
> allow to skip
> ip address check in patch 1. I considered adding separate function
> for that,
> but because each arch implementation is bit different, adding extra
> arg seemed
> like better option.
>=20
> v2 changes:
> =C2=A0 - make it work for other archs
>=20
> thanks,
> jirka
>=20
>=20
> [0] https://syzkaller.appspot.com/bug?extid=3D97a4fe20470e9bc30810
> ---
> Jiri Olsa (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf: Add checkip argument to bpf_arch_text=
_poke
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf, x64: Fix prog_array_map_poke_run map =
poke update
>=20
> =C2=A0arch/arm64/net/bpf_jit_comp.c=C2=A0=C2=A0 |=C2=A0 3 ++-
> =C2=A0arch/riscv/net/bpf_jit_comp64.c |=C2=A0 5 +++--
> =C2=A0arch/s390/net/bpf_jit_comp.c=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
> =C2=A0arch/x86/net/bpf_jit_comp.c=C2=A0=C2=A0=C2=A0=C2=A0 | 24 ++++++++++=
+++-----------
> =C2=A0include/linux/bpf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0kernel/bpf/arraymap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 31 +++++++++++--------------------
> =C2=A0kernel/bpf/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0kernel/bpf/trampoline.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 12 ++++++------
> =C2=A08 files changed, 39 insertions(+), 43 deletions(-)

Would it be possible to add a minimized version of the reproducer as a
testcase?

