Return-Path: <bpf+bounces-65436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9C7B22CB6
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 18:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2747C7BBDD6
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 16:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7B030AACF;
	Tue, 12 Aug 2025 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L1S57dMb"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11ED2FD1B8
	for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014448; cv=none; b=SvFYV7f6Wu2cLPtFCU5PFElbyzhGpS82G7c+pHzTO8QOBi6ohorn0x0bzP8tZMtRAD4ga9ovTqtSVIXcQMIN9gpmQ/JZ8Xc7+tGuYx381uMd03L52myLV34yhI/FrW+of8RsxmKmEG9ld2k5Y3HPvvBe6W27DDN1N5yP2+yDfqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014448; c=relaxed/simple;
	bh=q0P8Qb31UkTC+68OcLaChFRX3bXMDJY2tgp8uMQY0GA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E6FveVdOrUPTa++0ge2oPbiNzYpQosP9u0EChdk5XYZLxG7pEUickRPn+EdsjiQFbZFgKvH9fz/LgTuT4Vhh8oSNJh1YCVySyuMmSMuf+y3ethFkjDTGhIgbsUOlF92L6hlChhKNhBqokxLdoPBg6WWwKLoYAO/fjYsisa3rRuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L1S57dMb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CB1buB015330;
	Tue, 12 Aug 2025 16:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WSUUyL
	RRNKaNbUtoqwhovb5biAFUObgeOoBOMztIH1w=; b=L1S57dMb22QDTyLZTskkDh
	4WO21ZF8+UaiZwlOUGlaIlM0e9j++oh/OktE9hPd8i0ohpayoFgQs9EqMghwzOPh
	2iobZljb9vcihMF+i6dz5E2tifttcPC+M0arYeLyfJABZxqVvo7kQZXSJwjlM1mL
	lNAY4o8wD4veXO4UpYaab1trzQHEwQIiO9H27LaP42ABTQ9Dd1lZch1Fo2lfT/JS
	FQai6q8gtjNnYwargU4vcpc8Jthu57rD60N4WO0CLINsO5l7oOcT8nl9HMrX8b9A
	4riZilqX8J+IoFb4ydXILF2vH0xzflfO2BwuN83Qum7sZFr3QixZapXSD50onaqQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx14fb2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 16:00:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57CEJv9m020795;
	Tue, 12 Aug 2025 16:00:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ehnpu2ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 16:00:30 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57CG0RpS28902132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 16:00:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 158802004F;
	Tue, 12 Aug 2025 16:00:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BC6720043;
	Tue, 12 Aug 2025 16:00:26 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Aug 2025 16:00:26 +0000 (GMT)
Message-ID: <c5ba6c4a7cd7cdbf869fc5ea88be1302018d7e21.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 1/2] s390/bpf: Write back the tail call counter
 for BPF_CALL
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
 <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik
	 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Date: Tue, 12 Aug 2025 18:00:26 +0200
In-Reply-To: <20250812141217.144551-2-iii@linux.ibm.com>
References: <20250812141217.144551-1-iii@linux.ibm.com>
	 <20250812141217.144551-2-iii@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: ME-wsjdZcofj5RIbQbR3ECHaoAuy7GGo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE1MiBTYWx0ZWRfX7dmJfGe4GgEc
 GmrThItVtof8BNY0lwKE9IjXXmNrJh68B8sFgpojkA0eIx3DXZ8kvCrvjF5zqQrhVonm7fmp+oP
 mjaARa2w/kZB3tRJLbWw/YAY65DO2Nb4MZ4Br1CttEgdguelhkE/0o1rGGipOfMqlmQ6dOl24kV
 yGZlM1kJH7puL0ZzZOiy7NFKSR7ctjeCBkbuz3OB9TPe7JiFRtBPLrrFPTnMRB7XcsODPmn80M3
 DPOscP6p9Xu89SPIeem1SWmRGtRTizpdM1bbTdd7J4Sv45vQTOlEtxM0ITJfkB2rG/7e4A8BNpo
 k/khIkikEkkTrVk0YA2cZacxVbGPtCABeuaq0Gd+awWU1nFeCds4scvziszoMkpjKfzstuMbEZY
 HKEMlAQ15xurxWkiUeWn0HAdHyXy9w4YrZ3GU+1Vn1v2vBnnzTZldFBI6gYWgsI9oMuWZt9s
X-Proofpoint-GUID: ME-wsjdZcofj5RIbQbR3ECHaoAuy7GGo
X-Authority-Analysis: v=2.4 cv=fLg53Yae c=1 sm=1 tr=0 ts=689b6520 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=fS5JUT22qfAsMNZXEtIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508120152

On Tue, 2025-08-12 at 16:07 +0200, Ilya Leoshkevich wrote:
> The tailcall_bpf2bpf_hierarchy_1 test hangs on s390. Its call graph
> is
> as follows:
>=20
> =C2=A0 entry()
> =C2=A0=C2=A0=C2=A0 subprog_tail()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_tail_call_static(0) -> entry + tail_ca=
ll_start
> =C2=A0=C2=A0=C2=A0 subprog_tail()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_tail_call_static(0) -> entry + tail_ca=
ll_start
>=20
> entry() copies its tail call counter to the subprog_tail()'s frame,
> which then increments it. However, the incremented result is
> discarded,
> leading to an astronomically large number of tail calls.
>=20
> Fix by writing the incremented counter back to the entry()'s frame.
>=20
> Fixes: dd691e847d28 ("s390/bpf: Implement
> bpf_jit_supports_subprog_tailcalls()")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
> =C2=A0arch/s390/net/bpf_jit_comp.c | 20 +++++++++++++-------
> =C2=A01 file changed, 13 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/s390/net/bpf_jit_comp.c
> b/arch/s390/net/bpf_jit_comp.c
> index bb17efe29d65..85695576df6c 100644
> --- a/arch/s390/net/bpf_jit_comp.c
> +++ b/arch/s390/net/bpf_jit_comp.c
> @@ -1790,16 +1790,11 @@ static noinline int bpf_jit_insn(struct
> bpf_jit *jit, struct bpf_prog *fp,
> =C2=A0
> =C2=A0		REG_SET_SEEN(BPF_REG_5);
> =C2=A0		jit->seen |=3D SEEN_FUNC;
> +
> =C2=A0		/*
> =C2=A0		 * Copy the tail call counter to where the callee
> expects it.
> -		 *
> -		 * Note 1: The callee can increment the tail call
> counter, but
> -		 * we do not load it back, since the x86 JIT does
> not do this
> -		 * either.
> -		 *
> -		 * Note 2: We assume that the verifier does not let
> us call the
> -		 * main program, which clears the tail call counter
> on entry.
> =C2=A0		 */
> +
> =C2=A0		/* mvc
> tail_call_cnt(4,%r15),frame_off+tail_call_cnt(%r15) */
> =C2=A0		_EMIT6(0xd203f000 | offsetof(struct prog_frame,
> tail_call_cnt),
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xf000 | (jit->frame_off +
> @@ -1825,6 +1820,17 @@ static noinline int bpf_jit_insn(struct
> bpf_jit *jit, struct bpf_prog *fp,
> =C2=A0		call_r1(jit);
> =C2=A0		/* lgr %b0,%r2: load return value into %b0 */
> =C2=A0		EMIT4(0xb9040000, BPF_REG_0, REG_2);
> +
> +		/*
> +		 * Copy the potentially updated tail call counter
> back.
> +		 */
> +
> +		/* mvc
> frame_off+tail_call_cnt(%r15),tail_call_cnt(4,%r15) */
> +		_EMIT6(0xd203f000 | (jit->frame_off +
> +				=C2=A0=C2=A0=C2=A0=C2=A0 offsetof(struct prog_frame,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tail_call_cnt)),
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xf000 | offsetof(struct prog_fra=
me,
> tail_call_cnt));
> +
> =C2=A0		break;
> =C2=A0	}
> =C2=A0	case BPF_JMP | BPF_TAIL_CALL: {

Hmm, we need to do this only for BPF_PSEUDO_CALLs, otherwise a helper
or a kfunc, which is unaware of the tail call counter convention, will
clobber it with something random, potentially causing a kernel stack
overflow.

I will send a v2 and also provide a test that catches this issue.

