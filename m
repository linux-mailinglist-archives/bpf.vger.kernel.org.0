Return-Path: <bpf+bounces-58007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38780AB368F
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 14:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B111742FB
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 12:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AF329293E;
	Mon, 12 May 2025 12:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h/driVAb"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2FB266B6F
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747051484; cv=none; b=sufNyDJfYUy4ryid/WtNg4Mgr6tYwsrLDpNinpviOPD4G5fOc3GKYWJAiTiRSCmsLtnFX7kdEoyse13JrNGKjWsIbqQeFgUeDK2EY01Nr1KeaX8+teHAtEP9b4BOzcqqAXGL7e9KEpSNDSXrf19FxXdKkPV5bskml+SwJatqk4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747051484; c=relaxed/simple;
	bh=oJ1oCFBuNC5sbmX9Qnlw2EQfdmKj6oypBdfP5iwUyHc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PMuQx8LKxx/vr/umOT+AlAGsAj/umV3gmP7xAmOobziQWuBArYe3Erpsd/UNGDpUhD/JEg6/UYwzpeM0MW3jfmqkHjuu9SSgdiV83Xm9ltJ/mJ+VwIwQA1LDoAmJWJO5B1LkxHAti4ElGwhMpjWmlezpOzG7RNzAW0bFbA3rn1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h/driVAb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CAUMMx019052;
	Mon, 12 May 2025 12:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oJ1oCF
	BuNC5sbmX9Qnlw2EQfdmKj6oypBdfP5iwUyHc=; b=h/driVAbw++05Cx44enYUT
	4BcCatynqMYL/Yn38Yer9M6htcx068RcQmosjo2bJSInWK4KyMFdRCeY4Hsa8b6V
	PJeiwJoTbFz//+uJgQar9JxgqiRdxbiWwK4GhuAUJuhIt9GM/hHMpuSkv7CaQn/k
	TPRHAtqotNF2L5bNXveffL4inWQHKWJ2bwhEc/4Hdd6zF3w7HgjcXaxWHZb7KhQe
	BaPSHTtiZ6BMPrGAnjT1p2Bf5Aj7FooaT3Sj+aVTEaJjP9u9WHiveY+Bhyj0XNxX
	2OfiZnKz2oR1sMKP4jo0Lx05uSpdj3pKGdmT8igjRC+fiO9lKgg27QKTodHEE6Vw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46k1h8b524-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 12:03:16 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54CBtnSb032690;
	Mon, 12 May 2025 12:03:15 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46k1h8b51s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 12:03:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54C8sY0Q016937;
	Mon, 12 May 2025 12:03:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46jhgywxw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 12:03:14 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54CC3CkX57934098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 12:03:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CCE32018D;
	Mon, 12 May 2025 12:03:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFAD720188;
	Mon, 12 May 2025 12:03:11 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 May 2025 12:03:11 +0000 (GMT)
Message-ID: <bde230fc4444a3d8bb07172042b5392a3f04d1e3.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Do not include r10 in precision
 backtracking bookkeeping
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song
	 <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii
 Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Date: Mon, 12 May 2025 14:03:11 +0200
In-Reply-To: <CAADnVQLi8dP9uOTcs7qt_9Y42go9NVu4FSEk_eB_=egP3kCraA@mail.gmail.com>
References: <20250511162758.281071-1-yonghong.song@linux.dev>
	 <CAADnVQLi8dP9uOTcs7qt_9Y42go9NVu4FSEk_eB_=egP3kCraA@mail.gmail.com>
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
X-Authority-Analysis: v=2.4 cv=fq3cZE4f c=1 sm=1 tr=0 ts=6821e384 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=QyXUC8HyAAAA:8 a=U7VPO1jWWpv39uoOsucA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: h1ugEra7S4ygimPYNp1xGHq71T-X_DIj
X-Proofpoint-ORIG-GUID: rxQ1s6smRphn6c211wNh-ofcb9pENXbT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDEyMiBTYWx0ZWRfX+eOa1AMjVrN9 eWDHvCPRgvJMOgj9iKApiud5kHB+iaPQ25PQK7pFWN4lkhUVaxZPhi7pmerl2/CSX3HOAF8ZY3u Dpovz3y4atcXRLsYWpH/NOTG0gUybF7EBk7LOLsOJEJsRgVW3JB/FeqVN6HMgmdr2f4yZt/eOUP
 Cm74AOK8GdtiKKvwIeChOt6RB5Y+qxoaFZHGN/MdApEr8x9AoeeEo2pTzJPoJv2zRzW2SNGI54q 1oP3S7w4izLOwRt7F1kZw/xUsec7OznKcKc7tm4/YwHfbHWvd9eyLlsFYvE9F2Tz2r1kOzHQRXg 9/iV9rG9ZUvBDHqMWWY3if3bsEuqRO2sHhadYwiIpdFXBk3o48jVziSHiSPiEVwNB5qgUyfm51R
 6zxz4cMBBumkS+tPl+ctV0XLb4XYnPFe3pM1bXJcF59iFlfJ0xKAPVEd2Sb2SPe45QeDJOc1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_04,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 clxscore=1011 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120122

On Sun, 2025-05-11 at 15:33 -0700, Alexei Starovoitov wrote:
> On Sun, May 11, 2025 at 9:28=E2=80=AFAM Yonghong Song
> <yonghong.song@linux.dev> wrote:
> >=20
> > Reported by: Yi Lai <yi1.lai@linux.intel.com>
> > Fixes: 407958a0e980 ("bpf: encapsulate precision backtracking
> > bookkeeping")
> > Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> > ---
> > =C2=A0kernel/bpf/verifier.c | 6 ++++--
> > =C2=A01 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 28f5a7899bd6..1cb4d80d15c1 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -4413,8 +4413,10 @@ static int backtrack_insn(struct
> > bpf_verifier_env *env, int idx, int subseq_idx,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * before it would be equally necessary to
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * propagate it to dreg.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bt_set_reg(=
bt, dreg);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bt_set_reg(=
bt, sreg);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dreg !=
=3D BPF_REG_FP)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bt_set_reg(bt, dreg);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (sreg !=
=3D BPF_REG_FP)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bt_set_reg(bt, sreg);
>=20
> The fix makes sense to me.
>=20
> but it crashes on s390 according to CI:
>=20
> 2025-05-11T16:48:18.5929491Z #401=C2=A0=C2=A0=C2=A0=C2=A0 struct_ops_refc=
ounted:OK
> 2025-05-11T16:48:18.7330807Z ------------[ cut here ]------------
> 2025-05-11T16:48:18.7333824Z kernel BUG at kernel/bpf/core.c:533!
> 2025-05-11T16:48:18.7335154Z monitor event: 0040 ilc:2 [#1]SMP
> 2025-05-11T16:48:18.7336972Z Modules linked in: bpf_testmod(OE) [last
> unloaded: bpf_test_no_cfi(OE)]
> 2025-05-11T16:48:18.7341000Z CPU: 0 UID: 0 PID: 109 Comm: new_name
> Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OE=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.15.0-rc4-ga9827e5c6a13-dirty #13 NON=
E
> 2025-05-11T16:48:18.7343245Z Tainted: [O]=3DOOT_MODULE,
> [E]=3DUNSIGNED_MODULE
> 2025-05-11T16:48:18.7344697Z Hardware name: IBM 8561 LT1 400
> (KVM/Linux)
> 2025-05-11T16:48:18.7347056Z Krnl PSW : 0704d00180000000
> 000003320039d8ca (bpf_patch_insn_single+0x29a/0x2a0)
> 2025-05-11T16:48:18.7349372Z=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 R:0 T:1 IO:1 EX:1 Key:0 M:1
> W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
> 2025-05-11T16:48:18.7351910Z Krnl GPRS: 000002b200000016
> ffffffff7ffffffe ffffffffffffffde 00000000ffffffde
> 2025-05-11T16:48:18.7354602Z=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0000000000000003
> 0000000000000005 0000000000000000 000002b2000b5048
> 2025-05-11T16:48:18.7356934Z=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0000000000000018
> 000002b2000b5000 0000000000000003 0000000000000002
> 2025-05-11T16:48:18.7359164Z=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 000003ff81badf98
> 0000000000000002 000003320039d738 000002b200687840
> 2025-05-11T16:48:18.7361217Z Krnl Code: 000003320039d8bc:
> e3005ff0ff50
> sty %r0,-16(%r5)
> 2025-05-11T16:48:18.7363048Z=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 000003320039d8c2: a7f4ffc6
> brc
> 15,000003320039d84e
> 2025-05-11T16:48:18.7364611Z=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 #000003320039d8c6: af000000 mc
> 0,0
> 2025-05-11T16:48:18.7366106Z=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 >000003320039d8ca: 0707 bcr
> 0,%r7
> 2025-05-11T16:48:18.7367449Z=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 000003320039d8cc: 0707 bcr
> 0,%r7
> 2025-05-11T16:48:18.7368855Z=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 000003320039d8ce: 0707 bcr
> 0,%r7
> 2025-05-11T16:48:18.7403748Z=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 000003320039d8d0:
> c004004bdc60
> brcl 0,0000033200d19190
> 2025-05-11T16:48:18.7407899Z=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 000003320039d8d6:
> eb6ff0480024
> stmg %r6,%r15,72(%r15)
> 2025-05-11T16:48:18.7410576Z Call Trace:
> 2025-05-11T16:48:18.7411713Z=C2=A0 [<000003320039d8ca>]
> bpf_patch_insn_single+0x29a/0x2a0
> 2025-05-11T16:48:18.7413433Z ([<000003320039d738>]
> bpf_patch_insn_single+0x108/0x2a0)
> 2025-05-11T16:48:18.7415210Z=C2=A0 [<000003320039eb72>]
> bpf_jit_blind_constants+0xd2/0x1b0
> 2025-05-11T16:48:18.7416879Z=C2=A0 [<000003320020b5ee>]
> bpf_int_jit_compile+0x46/0x448
> 2025-05-11T16:48:18.7418417Z=C2=A0 [<00000332003c12d4>]
> jit_subprogs+0x594/0xbe0
> 2025-05-11T16:48:18.7419782Z=C2=A0 [<00000332003dacc8>]
> bpf_check+0xe28/0x14b0
> 2025-05-11T16:48:18.7421128Z=C2=A0 [<00000332003a9328>]
> bpf_prog_load+0x4d8/0xba0
> 2025-05-11T16:48:18.7422570Z=C2=A0 [<00000332003ab976>]
> __sys_bpf+0x98e/0xdd0
> 2025-05-11T16:48:18.7423887Z=C2=A0 [<00000332003abdfc>]
> __s390x_sys_bpf+0x44/0x50
> 2025-05-11T16:48:18.7425227Z=C2=A0 [<0000033200ce61b2>]
> __do_syscall+0x132/0x260
> 2025-05-11T16:48:18.7426522Z=C2=A0 [<0000033200cf162c>]
> system_call+0x74/0x98
>=20
>=20
> Ilya,
>=20
> Could you please verify whether the fix is related or not ?

I assume what crashes here is subprogs_and_jit_harden.
I could reproduce this neither using the build artifacts, nor in my
own development setup with this series applied.

subprogs_and_jit_harden is trying to induce a race condition by
constantly toggling bpf_jit_harden. Running it in a loop for a while
does not lead to any failures.

I also cannot see how this can create problems with the existing code
structure. bpf_jit_harden is used by bpf_jit_blinding_enabled() and
bpf_jit_kallsyms_enabled(), each of which has only one call site. When
these two see different values of bpf_jit_harden, nothing bad should
happen.

I suspect that this must an existing intermittently occurring issue.
Can we re-run the CI to see if the BUG() is reproducible in the GHA
environment?

