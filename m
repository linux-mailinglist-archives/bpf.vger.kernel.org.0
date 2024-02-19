Return-Path: <bpf+bounces-22261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988E385A77C
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 16:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1C41C22397
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 15:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D7239FF8;
	Mon, 19 Feb 2024 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OWVBcK7j"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E321383A6;
	Mon, 19 Feb 2024 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708356903; cv=none; b=bPaqxiJFt80oRb1zKOxz/+7xqzWun5x6Do+NOhxUk35NB35brqMXdt8A1sAWs/MqAnVwfMgCeusUBDAr7fSqCBfWEpw5LDPxUxmxasepX3EzgIJ+nJhG3Vnlnh1eiiwYmCR4RFz/wKJtxljVOaxGOQza4LT0R4e/WPfW2ZndoGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708356903; c=relaxed/simple;
	bh=wx8UZpkWB55VrmVZn+PIeRREueg/WVQO+NB1kQsXNLg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qznhUnVMIQIzD6dNxp+aPLxdB9YnUdrid9x7ebGNaNUwlMI4DpX33wO8XvOyxarqKdhPSpvCzU6PzLmNLeqk0/v+DBn19OmDmVOp+cf/sk85IJibIz3q7nEk3IvPTOaJORn1o2HEVAGEVuzdTNodXmv++y4//wnGEFwDN+Km94Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OWVBcK7j; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JFKlbC006461;
	Mon, 19 Feb 2024 15:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=T0e8ZFc3HV5eBAy00h0ivxaRla4eT9eTAKF3wMIZvmY=;
 b=OWVBcK7j66OefOnldfIzP7QCMhMkvfXX49U1qwWLHciyoAtt5yG3w15/ro32CjhNzuv/
 561kb8L6+7SvjndVy3Zik1AfLwnLeK435nzfAU8pLAYOuxF43kkaXdzv6fhb7ZCcKO+p
 nG+qYTQ7fJKL/vcBNDFEevXTP/7lyRp71FcnBD8Sy2F0UDN5WZz+J/ocf7QYcfud6UFv
 ah5LG7QyuhDw9/52rtceHNlCyZBrsSQusd21pzOEVjA5B7RCSGUJexCj2m+ikRd0+U2E
 kJmLaQRWUywfuCw3ucDmtcyeIV2BP6wVIwJWuKyzatYNNuefQfe+B8x9tCy9LOi8qr4L Hg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wbdgwnbjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 15:33:49 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41JFLb8F008437;
	Mon, 19 Feb 2024 15:33:47 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wbdgwnb6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 15:33:47 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41JEjmF0017278;
	Mon, 19 Feb 2024 15:33:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb8mm1vb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 15:33:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41JFXYuB11534896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 15:33:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 929232004B;
	Mon, 19 Feb 2024 15:33:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E93220049;
	Mon, 19 Feb 2024 15:33:33 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Feb 2024 15:33:33 +0000 (GMT)
Message-ID: <ddd5157cc9e61c218edff5cae572119d67b2717d.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: Take return from set_memory_rox()
 into account with bpf_jit_binary_lock_ro()
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexei Starovoitov
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
        Russell King
 <linux@armlinux.org.uk>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Zi Shen Lim
 <zlim.lnx@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will
 Deacon <will@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Hengqi Chen
 <hengqi.chen@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David
 S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Wang YanQing <udknight@gmail.com>, David Ahern <dsahern@kernel.org>,
        Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav
 Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        netdev@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "linux-hardening @ vger . kernel . org" <linux-hardening@vger.kernel.org>
Date: Mon, 19 Feb 2024 16:33:33 +0100
In-Reply-To: <ec35e06dbe8672a36415ebe2b9273277c2921977.1708253445.git.christophe.leroy@csgroup.eu>
References: 
	<135feeafe6fe8d412e90865622e9601403c42be5.1708253445.git.christophe.leroy@csgroup.eu>
	 <ec35e06dbe8672a36415ebe2b9273277c2921977.1708253445.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oAChKg23BdNBTZrcSP06tgBD6BxLsz0g
X-Proofpoint-ORIG-GUID: pcDzFPwvseJ0VbrYr5hrpvU0P_mie-dV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_11,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 mlxlogscore=767 lowpriorityscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190116

On Sun, 2024-02-18 at 11:55 +0100, Christophe Leroy wrote:
> set_memory_rox() can fail, leaving memory unprotected.
>=20
> Check return and bail out when bpf_jit_binary_lock_ro() returns
> and error.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> Previous patch introduces a dependency on this patch because it
> modifies bpf_prog_lock_ro(), but they are independant.
> It is possible to apply this patch as standalone by handling trivial
> conflict with unmodified bpf_prog_lock_ro().
> ---
> =C2=A0arch/arm/net/bpf_jit_32.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 25 ++++++++++++-------------
> =C2=A0arch/arm64/net/bpf_jit_comp.c=C2=A0=C2=A0=C2=A0 | 21 ++++++++++++++=
+------
> =C2=A0arch/loongarch/net/bpf_jit.c=C2=A0=C2=A0=C2=A0=C2=A0 | 21 +++++++++=
++++++------
> =C2=A0arch/mips/net/bpf_jit_comp.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
> =C2=A0arch/parisc/net/bpf_jit_core.c=C2=A0=C2=A0 |=C2=A0 8 +++++++-
> =C2=A0arch/s390/net/bpf_jit_comp.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++++=
+-
> =C2=A0arch/sparc/net/bpf_jit_comp_64.c |=C2=A0 6 +++++-
> =C2=A0arch/x86/net/bpf_jit_comp32.c=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +--
> =C2=A0include/linux/filter.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> =C2=A09 files changed, 64 insertions(+), 33 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>  # s390x

