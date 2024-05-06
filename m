Return-Path: <bpf+bounces-28732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1B08BD806
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 01:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1932B1F21E4F
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 23:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4202B15B11F;
	Mon,  6 May 2024 23:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UHIGa0AW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EBE13D2A7
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715036409; cv=none; b=RWBlvg0ZZRy1R4jxZ7NOp5jrKVSHVYMMXGMwdPtpnHIuVbTJxUPfvziEH2CS2VfuiaIMLPZmHWxxpL2tHlY+2Q/1tbVq4LcADkozMU6lrbA/U4hi4STNu4ErggjBOfyIsNDzB+k0NylJmfxiVbbPHTDlVKFQnfifGOfthvGEhBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715036409; c=relaxed/simple;
	bh=6dizyx8ZuxDooU+pvdME/CAA4uuDxUfQl34rMuixqtM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pX3DWUZZXwF97mzpsfOg23e7JAoj/ob4a7B81WKNlByXPniE9EfMFKidhWdFsrJG/XPSsy/phPjbopmsPqzjqh3JHukCtErYsQSArUjP1J7VwtUnHo8rEyPTl1RooBhvZV1hJXcdJX6LRgKYTg6OKbZ+wPUQlI1hy7ydfpMgHYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UHIGa0AW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446MlJZK006356;
	Mon, 6 May 2024 22:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=6dizyx8ZuxDooU+pvdME/CAA4uuDxUfQl34rMuixqtM=;
 b=UHIGa0AW1rZoihiKNWlNDgT16tbBMUERu31Iv5zoyFyIr6MFmSHcGNFd8xEX9kQUNuai
 /NwOFVWPGh5n1/hdftl9YNClSBBv2sMWo39Q6udQpZ2mWt0bSLcCrYsbpW//ycXak51x
 6rG1JVcihSS++TA3+7iCtB3yfOnmuBdoOcS+RZ95xel/n3Wi7tvciKCObnllJZJ6cYcU
 678SL8XE7crD4bhKJmXMKMd6i8jaaZ/udfo+cX3yE7GekSuUAbktyjuv29jb5q950RdN
 iZGEx7ekUoBkeokI7DXE5g8EkoJ5DLgb8XX8uU7XL6ruXHjVmRG46M7Pl3WhcaogXoqA gg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xy8a5r0eq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 22:59:41 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 446MxeeO021422;
	Mon, 6 May 2024 22:59:40 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xy8a5r0cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 22:59:40 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 446Ks497005549;
	Mon, 6 May 2024 22:56:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xx5yh19eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 22:56:33 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 446MuR5c57475420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 May 2024 22:56:29 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 660D320043;
	Mon,  6 May 2024 22:56:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C7B520040;
	Mon,  6 May 2024 22:56:26 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 May 2024 22:56:26 +0000 (GMT)
Message-ID: <7cdc423edbcdd8155c8a3f0fce7913f707c8c146.camel@linux.ibm.com>
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
Date: Tue, 07 May 2024 00:56:25 +0200
In-Reply-To: <mb61pcypz0zhe.fsf@kernel.org>
References: <20240505201633.123115-1-puranjay@kernel.org>
	 <mb61p34qvq3wf.fsf@kernel.org>
	 <a5de8fa22c021c2df5f37f285c8d2247f1c6c1b0.camel@linux.ibm.com>
	 <mb61pcypz0zhe.fsf@kernel.org>
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
X-Proofpoint-GUID: 0JADB8xcB6WJsB4NsgfXXg96ep1Zbl7o
X-Proofpoint-ORIG-GUID: JoCZTrJHKEmMhDwES0m9XcnMq2rWv7dU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_17,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060167

On Mon, 2024-05-06 at 14:46 +0000, Puranjay Mohan wrote:
> Ilya Leoshkevich <iii@linux.ibm.com> writes:
>=20
> > > Puranjay Mohan <puranjay@kernel.org> writes:
> > >=20
> > > > The BPF atomic operations with the BPF_FETCH modifier along
> > > > with
> > > > BPF_XCHG and BPF_CMPXCHG are fully ordered but the RISC-V JIT
> > > > implements
> > > > all atomic operations except BPF_CMPXCHG with relaxed ordering.
> > >=20
> > > I know that the BPF memory model is in the works and we currently
> > > don't
> > > have a way to make all the JITs consistent. But as far as atomic
> > > operations are concerned here are my observations:
> >=20
> > [...]
> >=20
> > > 4. S390
> > > =C2=A0=C2=A0 ----
> > >=20
> > > Ilya, can you help with this?
> > >=20
> > > I see that the kernel is emitting "bcr 14,0" after "laal|laalg"
> > > but
> > > the
> > > JIT is not.
> >=20
> > Hi,
> >=20
> > Here are two relevant paragraphs from the Principles of Operation:
> >=20
> > =C2=A0 Relation between Operand Accesses
> > =C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0 As observed by other CPUs and by channel pro-
> > =C2=A0 grams, storage-operand fetches associated with one
> > =C2=A0 instruction execution appear to precede all storage-
> > =C2=A0 operand references for conceptually subsequent
> > =C2=A0 instructions. A storage-operand store specified by
> > =C2=A0 one instruction appears to precede all storage-oper-
> > =C2=A0 and stores specified by conceptually subsequent
> > =C2=A0 instructions, but it does not necessarily precede stor-
> > =C2=A0 age-operand fetches specified by conceptually sub-
> > =C2=A0 sequent instructions. However, a storage-operand
> > =C2=A0 store appears to precede a conceptually subsequent
> > =C2=A0 storage-operand fetch from the same main-storage
> > =C2=A0 location.
> >=20
> > In short, all memory accesses are fully ordered except for
> > stores followed by fetches from different addresses.
>=20
> Thanks for sharing the details.
>=20
> So, this is TSO like x86
>=20
> > =C2=A0 LAALG R1,R3,D2(B2)
> > =C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0 [...]
> > =C2=A0 All accesses to the second-operand location appear
> > =C2=A0 to be a block-concurrent interlocked-update refer-
> > =C2=A0 ence as observed by other CPUs and the I/O subsys-
> > =C2=A0 tem. A specific-operand-serialization operation is
> > =C2=A0 performed.
> >=20
> > Specific-operand-serialization is weaker than full serialization,
> > which means that, even though s390x=C2=A0provides very strong ordering
> > guarantees, strictly speaking, as architected, s390x atomics are
> > not
> > fully ordered.
> >=20
> > I have a hard time thinking of a situation where a store-fetch
> > reordering=C2=A0for different addresses could matter, but to be on the
> > safe
> > side we should probably just do what the kernel does and add a
> > "bcr 14,0". I will send a patch.
>=20
> Thanks,
>=20
> IMO, bcr 14,0 would be needed because, s390x has both
>=20
> =C2=A0 int __atomic_add(int i, int *v);
>=20
> and
>=20
> =C2=A0 int __atomic_add_barrier(int i, int *v);
>=20
> both of these do the fetch operation but the second one adds a
> barrier
> (bcr 14, 0)
>=20
> JIT was using the first one (without barrier) to implement the
> arch_atomic_fetch_add
>=20
> So, assuming that without this barrier, store->fetch reordering would
> be
> allowed as you said.
>=20
> It would mean:
> This litmus test would fail for the s390 JIT:
>=20
> =C2=A0 C SB+atomic_fetch
> =C2=A0=20
> =C2=A0 (*
> =C2=A0=C2=A0 * Result: Never
> =C2=A0=C2=A0 *
> =C2=A0=C2=A0 * This litmus test demonstrates that LKMM expects total orde=
ring
> from
> =C2=A0=C2=A0 * atomic_*() operations with fetch or return.
> =C2=A0=C2=A0 *)
> =C2=A0=20
> =C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_t dummy1 =
=3D ATOMIC_INIT(1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_t dummy2 =
=3D ATOMIC_INIT(1);
> =C2=A0 }
> =C2=A0=20
> =C2=A0 P0(int *x, int *y, atomic_t *dummy1)
> =C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WRITE_ONCE(*x, 1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rd =3D atomic_fetc=
h_add(1, dummy1);=C2=A0=C2=A0=C2=A0=C2=A0 /* assuming this is
> implemented without barrier */=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r0 =3D READ_ONCE(*=
y);
> =C2=A0 }
> =C2=A0=20
> =C2=A0 P1(int *x, int *y, atomic_t *dummy2)
> =C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WRITE_ONCE(*y, 1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rd =3D atomic_fetc=
h_add(1, dummy2);=C2=A0=C2=A0=C2=A0 /* assuming this is
> implemented without barrier */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r1 =3D READ_ONCE(*=
x);
> =C2=A0 }
> =C2=A0=20
> =C2=A0 exists (0:r0=3D0 /\ 1:r1=3D0)
>=20
>=20
> P.S. - It would be nice to have a tool that can convert litmus tests
> into BPF assembly programs and then we can test them on hardware
> after JITing.
>=20
> Thanks,
> Puranjay

Thanks for providing an example! So unrelated memory accesses may rely
on atomics being barriers.

I will adjust my commit message, since now I claim that we are doing
the change "just in case", but apparently, if the hardware chooses to
exercise all the freedoms allowed by the architecture, there can occur
real problems.

