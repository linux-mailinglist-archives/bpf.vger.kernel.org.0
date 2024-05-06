Return-Path: <bpf+bounces-28670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 725C98BCDEC
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 14:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27316281011
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 12:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ECB143C50;
	Mon,  6 May 2024 12:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Nla/JYKw"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6FA143878
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 12:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714998540; cv=none; b=UC4bHoYe/0U06C1nXUnk/07KL93VtjbMR9TjffR6UgnZ2kcS3dD9l2D+/Fg+vMpA//vwVV67NqGdnTdjoEmSgqMhuO9cB9kyWO5K44qe12tGsF4UxrbeiWZIUtMUxSZxw3I3giYaAK+7HSSpcwRfYBfMEFxBTyqaHwWw9Evm+IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714998540; c=relaxed/simple;
	bh=Jw6Yfh0lVZSYZukBJVRLc+6yJKUWGmyjLANQ4Uwz3RU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mesQMGwmG4QshW8POetHDwWY19qGMSfeOSbBrJOVz9F5XaiFSEsksEZWsTRDY1kmB7YnDPrcZPaPDUqhuhCsVxdbnqfdDW9ktHyQZKHxjx3QvFbOH5IgJQ9LKpBkjNK0f3ClB1t5O6QQcHmFglHH1Fb1t9jQFGoHtTlFvPFgvCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Nla/JYKw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446BlCXp011170;
	Mon, 6 May 2024 12:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Vml9acb56QlbDhtLKie+EnhqpxtdU780f+fTkyusmGU=;
 b=Nla/JYKwdaHb0CNmN3YQpPylDKxgmlQ44ohWNotJ7xxb8SR5QHL9dBIhmACIGIRoE+dy
 G4CRYP7iYfOgN0+oeyg8VzhtZlljqETNCyOz5dly5ktlsmHPIP53c8uMeZPX9WJJeQur
 qi9NAz4y9B+DsakMTtsAq/oxIHs6IfdU+CNS4h2wDbQ+Ffyn0PnwFHFu0cz1nzmSMfeO
 /tyUoOjzibsyQ6LyjrHtEgwK8F3zKKLfXDgusqB7DRJ8wtzLYzJQgWo22eJYo8rCjJa9
 2Xv7bocKiSITIoTFVwV6fgiIQkHi/PybutAdL8qSDaoUGFxoXeQPBKZd+tJ/F0N4TyJF Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xxxmt83kn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 12:28:27 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 446CSRSp020326;
	Mon, 6 May 2024 12:28:27 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xxxmt83kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 12:28:27 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 446BAIY5030885;
	Mon, 6 May 2024 12:28:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xwybtr39g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 12:28:25 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 446CSK9r51904948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 May 2024 12:28:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD0FA20049;
	Mon,  6 May 2024 12:28:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3315F20040;
	Mon,  6 May 2024 12:28:20 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 May 2024 12:28:20 +0000 (GMT)
Message-ID: <a5de8fa22c021c2df5f37f285c8d2247f1c6c1b0.camel@linux.ibm.com>
Subject: Re: [PATCH bpf] riscv, bpf: make some atomic operations fully
 ordered
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko
 <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song
 <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Pu Lehui
 <pulehui@huawei.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, bpf@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Tiezhu
 Yang <yangtiezhu@loongson.cn>,
        Heiko Carstens <hca@linux.ibm.com>
Date: Mon, 06 May 2024 14:28:20 +0200
In-Reply-To: <mb61p34qvq3wf.fsf@kernel.org>
References: <20240505201633.123115-1-puranjay@kernel.org>
	 <mb61p34qvq3wf.fsf@kernel.org>
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
X-Proofpoint-ORIG-GUID: HSoYpPk50-4-j201uqVvzdNpNP749s22
X-Proofpoint-GUID: AYVLe5xWev8qJ1VBXBcGFmkCI6_9Z2y1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_07,2024-05-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 clxscore=1011 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060086

> Puranjay Mohan <puranjay@kernel.org> writes:
>=20
> > The BPF atomic operations with the BPF_FETCH modifier along with
> > BPF_XCHG and BPF_CMPXCHG are fully ordered but the RISC-V JIT
> > implements
> > all atomic operations except BPF_CMPXCHG with relaxed ordering.
>=20
> I know that the BPF memory model is in the works and we currently
> don't
> have a way to make all the JITs consistent. But as far as atomic
> operations are concerned here are my observations:

[...]

> 4. S390
> =C2=A0=C2=A0 ----
>=20
> Ilya, can you help with this?
>=20
> I see that the kernel is emitting "bcr 14,0" after "laal|laalg" but
> the
> JIT is not.

Hi,

Here are two relevant paragraphs from the Principles of Operation:

  Relation between Operand Accesses
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
  As observed by other CPUs and by channel pro-
  grams, storage-operand fetches associated with one
  instruction execution appear to precede all storage-
  operand references for conceptually subsequent
  instructions. A storage-operand store specified by
  one instruction appears to precede all storage-oper-
  and stores specified by conceptually subsequent
  instructions, but it does not necessarily precede stor-
  age-operand fetches specified by conceptually sub-
  sequent instructions. However, a storage-operand
  store appears to precede a conceptually subsequent
  storage-operand fetch from the same main-storage
  location.

In short, all memory accesses are fully ordered except for
stores followed by fetches from different addresses.

  LAALG R1,R3,D2(B2)
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  [...]
  All accesses to the second-operand location appear
  to be a block-concurrent interlocked-update refer-
  ence as observed by other CPUs and the I/O subsys-
  tem. A specific-operand-serialization operation is
  performed.

Specific-operand-serialization is weaker than full serialization,
which means that, even though s390x=C2=A0provides very strong ordering
guarantees, strictly speaking, as architected, s390x atomics are not
fully ordered.

I have a hard time thinking of a situation where a store-fetch
reordering=C2=A0for different addresses could matter, but to be on the safe
side we should probably just do what the kernel does and add a
"bcr 14,0". I will send a patch.

[...]

> Thanks,
> Puranjay


