Return-Path: <bpf+bounces-33352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BD291BB2C
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 11:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD8AAB212D1
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 09:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870691509AB;
	Fri, 28 Jun 2024 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r7Dr7Fit"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0889152E02
	for <bpf@vger.kernel.org>; Fri, 28 Jun 2024 09:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565785; cv=none; b=apZsjdYhkqorMLjlwFfVZqG57it/+mgnHEsd+3dazqid3sgnCd4S1szbMz/S9fY9YX4y64Lx640hVLcgwPsfX8QGPKY1kgiVK4roBJq24jRKmF/hRYZhBnIs2hCFccYFLNderFT1hsY51+J4vzX91YF82GFJT4FZAX6HgtENkws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565785; c=relaxed/simple;
	bh=1tLivv3Xrh2nKgC0LNLtWdg4E7sdBst8uDj/8AlTYHY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JWlvoXiGtISeqQXl6R6dCGPPg1dFzHFRLkNAeI3i4sXM31TPgP62zfXn0icB8ejQW9cdJ6aZv+1886yTLT3OZ7lU2Wxx3gM+K7fECOaK4m+IJSN6uRTHxV2VdBrX90YKHBNSoDTpaD5aPSNf3yiDzPHETxJ7UWI/6pUdOhkGVUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r7Dr7Fit; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S8vYDV028335;
	Fri, 28 Jun 2024 09:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	CFNH06zvAk93qdcIisYXPfSBLAv6soOFkgc/+LxLacQ=; b=r7Dr7FitFAxKLetr
	aIFUOdJMMXaz5XXBlYUmwchRhJiZyuGdJBBipfKWprnaTUUhP1+rhBwd5/kpMEsx
	W6dwKUQdpwEXcXRMLeToCl0EI3aDIi5mb0NkHtVF0jpI4OJHqLLV4WDK3poqMTMx
	TCt5ryMfR2SZNxY2g5re7+sL2EJmp6v5igUKgrYKOfDQf0yioQJEHH5WPTP9is0Z
	+Fy/wu8v+Ej9DxYpgePKAf/Gs58b+5Wu8Q0/BXWBbHFres3p+ipkNnun8DiAEKQC
	uo6p77i6Sy5HoDj6aQQ0DNnhr0KE236owvNAI3jUm+rPPZSNT8pq73CFmZlGaG0J
	o0wCIw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 401spn02rk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 09:09:26 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45S99Pet015713;
	Fri, 28 Jun 2024 09:09:25 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 401spn02rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 09:09:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45S73B7I000685;
	Fri, 28 Jun 2024 09:09:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yxaenffv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 09:09:24 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45S99I6w55705976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 09:09:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96C432005A;
	Fri, 28 Jun 2024 09:09:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1391920040;
	Fri, 28 Jun 2024 09:09:18 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Jun 2024 09:09:17 +0000 (GMT)
Message-ID: <dbf2a9f87eea35af2e1e3101d00833e67cc069db.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 08/10] s390/bpf: Support arena atomics
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
 <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf
 <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Date: Fri, 28 Jun 2024 11:09:17 +0200
In-Reply-To: <CAADnVQJu6Aci=MGZ2P18=6fydDP+QMiu++PxJ+2aHrnxksg1ag@mail.gmail.com>
References: <20240627090900.20017-1-iii@linux.ibm.com>
	 <20240627090900.20017-9-iii@linux.ibm.com>
	 <CAADnVQJu6Aci=MGZ2P18=6fydDP+QMiu++PxJ+2aHrnxksg1ag@mail.gmail.com>
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
X-Proofpoint-GUID: mefxOEFuZBRHHgeousL49cbXweGv_DfB
X-Proofpoint-ORIG-GUID: e39Mf4cBHxqIbCtKW6KkSBWOcOSiE3P8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_05,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=786 mlxscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406280065

On Thu, 2024-06-27 at 17:43 -0700, Alexei Starovoitov wrote:
> On Thu, Jun 27, 2024 at 2:09=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.c=
om>
> wrote:
> >=20
> > s390x supports most BPF atomics using single instructions, which
> > makes implementing arena support a matter of adding arena address
> > to
> > the base register (unfortunately atomics do not support index
> > registers), and wrapping the respective native instruction in
> > probing
> > sequences.
> >=20
> > An exception is BPF_XCHG, which is implemented using two different
> > memory accesses and a loop. Make sure there is enough extable
> > entries
> > for both instructions. Compute the base address once for both
> > memory
> > accesses. Since on exception we need to land after the loop, emit
> > the
> > nops manually.
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0arch/s390/net/bpf_jit_comp.c | 100
> > +++++++++++++++++++++++++++++++----
> > =C2=A01 file changed, 91 insertions(+), 9 deletions(-)

[...]

> > +
> > +bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Currently the verifier us=
es this function only to check
> > which
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * atomic stores to arena ar=
e supported, and they all are.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>=20
> Including all the multi insn instructions that are implemented as
> loops?
> On x86 I left out atomic+fetch+[and|or|xor],
> because they're tricky with looping.
> Just checking that when an exception happens
> the loop is not going to become infinite ?
> If I'm reading the code correctly the exception handling will not
> only
> skip one insn, but will skip the whole loop?

On s390x only BPF_XCHG needs to be implemented as a loop, the rest
are single instructions. For example, there is LOAD AND EXCLUSIVE OR,
which is atomic, updates memory, and puts the original value into a
register.

For BPF_XCHG the exception handler will skip the entire loop after
an exception. BPF_XCHG has two memory accesses: the initial LOAD, and
then the COMPARE AND SWAP loop. I wasn't able to test the exception
handling for COMPARE AND SWAP, because I would have to inject a race
that would free the arena page after the initial LOAD.

Now that you asked, I added the following temporary patch to skip the
LOAD:

--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1598,10 +1598,8 @@ static noinline int bpf_jit_insn(struct bpf_jit
*jit, struct bpf_prog *fp,
                        struct bpf_jit_probe load_probe =3D probe;
=20
                        bpf_jit_probe_atomic_pre(jit, insn,
&load_probe);
-                       /* {ly|lg} %w0,off(%arena) */
-                       EMIT6_DISP_LH(0xe3000000,
-                                     is32 ? 0x0058 : 0x0004, REG_W0,
REG_0,
-                                     load_probe.arena_reg, off);
+                       /* bcr 0,%0 (nop) */
+                       _EMIT2(0x0700);
                        bpf_jit_probe_emit_nop(jit, &load_probe);
                        /* Reuse {ly|lg}'s arena_reg for {csy|csg}. */
                        if (load_probe.prg !=3D -1) {

This is still a valid BPF_XCHG implementation, just less efficient in
the non-contended case. The exception handling works, but I found a
bug: the hard-coded offset in

			/* brc 4,0b */
			EMIT4_PCREL_RIC(0xa7040000, 4, jit->prg - 6);

is no longer valid due to the extra nop added by this patch.

I will fix this and resend.

