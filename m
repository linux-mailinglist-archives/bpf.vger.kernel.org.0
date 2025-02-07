Return-Path: <bpf+bounces-50757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 930E0A2C17C
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 12:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84CD61887842
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 11:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DBB1DED48;
	Fri,  7 Feb 2025 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mxl3GauP"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1926F154C05;
	Fri,  7 Feb 2025 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738927793; cv=none; b=F7ck61Ff32PsTnFjcdFGDqPj4RzxLF5nww3Z34yGMaJJ5V9pP90L1K/99GjOBJ7M7cqaihaQgDxYW2vNvHkzDkcDHldcRv9Rp9IeZ9YlBdp5RweSUSGyqnJHcK1/Jam7+LW9MP00NkN+oPk4Pn/F88ECy1a+ujXX3m54e8QdP7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738927793; c=relaxed/simple;
	bh=H2y5D/PM5tYq3BpNaRBiJG8iQwkDq/AIoKQCoGOFvkI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UdFUjnsmrMZD94t7WFtUpRvPFMbkoqVRwadAPzuaJJNR85pdobSkAGio07lxA6JZpgLljHByVh1PAV+Jf6aEpLLBuEV3DWDL5jouZfLCmgCzD3EQwWHbksAwkTssAsr4MMSwtdpXcMo+RqdO/fc7tylExFYkv1ZSKUCjvnbiPTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mxl3GauP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5175OffB030394;
	Fri, 7 Feb 2025 11:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=H2y5D/
	PM5tYq3BpNaRBiJG8iQwkDq/AIoKQCoGOFvkI=; b=mxl3GauPqUZLJtd+33HcpY
	s4iWRKsCSYfQ99QxbBGgs/gB5WFyQ6qED06APzMm3S+vUuZ2YbKHwEojQeeQl+JL
	Y35MfyBIbdsbGAAF2++5s9t4y92SbG3llXF5Omh5n9k1UGUGQR58t0PYVMUdXwj6
	x/RhouZJA9BfSbnoejLLFnVTFgnwx7HjjgmNBRZAF4nnsFK1JfHWvR6j/k7HyviJ
	om6eOsE2sSc1EE+0BuFC0BpdWdKuJoytBGRsMkTWKh3+DSBS74rzoQqaqWWT6UAI
	hceCK4H9qqXvhMDsq3bwwifsmzDQJzuF8Z5BDbaJ85cuV0If4FOms4FVmReR+kiA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44nc08hndc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 11:29:08 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 517BT77s016888;
	Fri, 7 Feb 2025 11:29:07 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44nc08hncm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 11:29:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5179oG8g016391;
	Fri, 7 Feb 2025 11:28:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44hwxsugjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 11:28:49 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 517BSkqZ60031420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Feb 2025 11:28:46 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 032A720169;
	Fri,  7 Feb 2025 11:28:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20C1520165;
	Fri,  7 Feb 2025 11:28:44 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Feb 2025 11:28:44 +0000 (GMT)
Message-ID: <cff3dc9eaa592dbe634e336eb83f9bb47dd9705a.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v2 4/9] bpf: Introduce load-acquire and
 store-release instructions
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Peilin Ye <yepeilin@google.com>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>,
        Eduard Zingerman
 <eddyz87@gmail.com>,
        David Vernet <void@manifault.com>,
        Alexei Starovoitov
 <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko
 <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend
 <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Paul E. McKenney"
 <paulmck@kernel.org>,
        Puranjay Mohan <puranjay@kernel.org>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Catalin Marinas
 <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Quentin Monnet
 <qmo@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>,
        Ihor Solodrai <ihor.solodrai@linux.dev>,
        Yingchi Long
 <longyingchi24s@ict.ac.cn>,
        Josh Don <joshdon@google.com>, Barret Rhoden
 <brho@google.com>,
        Neel Natu <neelnatu@google.com>, Benjamin Segall
 <bsegall@google.com>,
        linux-kernel@vger.kernel.org
Date: Fri, 07 Feb 2025 12:28:43 +0100
In-Reply-To: <d03d8c3305e311c6cb29924119b5eecae8370bbc.1738888641.git.yepeilin@google.com>
References: <cover.1738888641.git.yepeilin@google.com>
	 <d03d8c3305e311c6cb29924119b5eecae8370bbc.1738888641.git.yepeilin@google.com>
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
X-Proofpoint-ORIG-GUID: 2vqE_S-ZCmh4StDB4kvU9q_CRNjPQL4t
X-Proofpoint-GUID: o5rg8snT-IXIrJ5LScYMNJP6aBEmf57u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_05,2025-02-07_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=884 bulkscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070088

On Fri, 2025-02-07 at 02:05 +0000, Peilin Ye wrote:
> Introduce BPF instructions with load-acquire and store-release
> semantics, as discussed in [1].=C2=A0 The following new flags are defined=
:
>=20
> =C2=A0 BPF_ATOMIC_LOAD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x=
10
> =C2=A0 BPF_ATOMIC_STORE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x20
> =C2=A0 BPF_ATOMIC_TYPE(imm)=C2=A0=C2=A0=C2=A0 ((imm) & 0xf0)
>=20
> =C2=A0 BPF_RELAXED=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0
> =C2=A0 BPF_ACQUIRE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1
> =C2=A0 BPF_RELEASE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x2
> =C2=A0 BPF_ACQ_REL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x3
> =C2=A0 BPF_SEQ_CST=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x4
>=20
> =C2=A0 BPF_LOAD_ACQ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (BPF_ATOMIC_LOAD =
| BPF_ACQUIRE)
> =C2=A0 BPF_STORE_REL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (BPF_ATOMIC_STORE | BP=
F_RELEASE)
>=20
> A "load-acquire" is a BPF_STX | BPF_ATOMIC instruction with the 'imm'
> field set to BPF_LOAD_ACQ (0x11).
>=20
> Similarly, a "store-release" is a BPF_STX | BPF_ATOMIC instruction
> with
> the 'imm' field set to BPF_STORE_REL (0x22).
>=20
> Unlike existing atomic operations that only support BPF_W (32-bit)
> and
> BPF_DW (64-bit) size modifiers, load-acquires and store-releases also
> support BPF_B (8-bit) and BPF_H (16-bit).=C2=A0 An 8- or 16-bit load-
> acquire
> zero-extends the value before writing it to a 32-bit register, just
> like
> ARM64 instruction LDARH and friends.
>=20
> As an example, consider the following 64-bit load-acquire BPF
> instruction:
>=20
> =C2=A0 db 10 00 00 11 00 00 00=C2=A0 r0 =3D load_acquire((u64 *)(r1 + 0x0=
))
>=20
> =C2=A0 opcode (0xdb): BPF_ATOMIC | BPF_DW | BPF_STX
> =C2=A0 imm (0x00000011): BPF_LOAD_ACQ
>=20
> Similarly, a 16-bit BPF store-release:
>=20
> =C2=A0 cb 21 00 00 22 00 00 00=C2=A0 store_release((u16 *)(r1 + 0x0), w2)
>=20
> =C2=A0 opcode (0xcb): BPF_ATOMIC | BPF_H | BPF_STX
> =C2=A0 imm (0x00000022): BPF_STORE_REL
>=20
> In arch/{arm64,s390,x86}/net/bpf_jit_comp.c, have
> bpf_jit_supports_insn(..., /*in_arena=3D*/true) return false for the
> new
> instructions, until the corresponding JIT compiler supports them.
>=20
> [1]
> https://lore.kernel.org/all/20240729183246.4110549-1-yepeilin@google.com/
>=20
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Peilin Ye <yepeilin@google.com>
> ---
> =C2=A0arch/arm64/net/bpf_jit_comp.c=C2=A0 |=C2=A0 4 +++
> =C2=A0arch/s390/net/bpf_jit_comp.c=C2=A0=C2=A0 | 14 +++++---
> =C2=A0arch/x86/net/bpf_jit_comp.c=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +++
> =C2=A0include/linux/bpf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 11 ++++++
> =C2=A0include/linux/filter.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 2 ++
> =C2=A0include/uapi/linux/bpf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 +=
++++++
> =C2=A0kernel/bpf/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 63 ++++++++++++++++++++++++++++++--
> --
> =C2=A0kernel/bpf/disasm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 12 +++++++
> =C2=A0kernel/bpf/verifier.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 45 ++++++++++++++++++++++--
> =C2=A0tools/include/uapi/linux/bpf.h | 13 +++++++
> =C2=A010 files changed, 168 insertions(+), 13 deletions(-)

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

s390x has a strong memory model, and the regular load and store
instructions are atomic as long as operand addresses are aligned.

IIUC the verifier already enforces this unless BPF_F_ANY_ALIGNMENT
is set, in which case whoever loaded the program is responsible for the
consequences: memory accesses that happen to be unaligned would
not trigger an exception, but they would not be atomic either.

So I can implement the new instructions as normal loads/stores after
this series is merged.

