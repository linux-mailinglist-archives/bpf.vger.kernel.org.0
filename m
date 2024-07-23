Return-Path: <bpf+bounces-35380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0363D939C0F
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 09:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC6C282FE7
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 07:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D4314B955;
	Tue, 23 Jul 2024 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MEe1+AID"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1DB14AD3E
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721721454; cv=none; b=GGvyTu5nhpeSTBT8m6WJWavsKltKxRyOd6No22D3HYyRUBy+1TPWP/FO+3wepN7Vh2Bkx5bN08zN2gQT5QYRU9vXE12wkrSa08H/HYPKDMdkw6Oomf5/WF4Z8Z4+vNGmLiPOSPNKfkJA/dxTqT3MrEwzv4aIkqDZ/lB0mKhFzOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721721454; c=relaxed/simple;
	bh=1hsct9KrMLlqaOPaYqbehCTabXk2OgmflaH/ilNEKBg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kMPUegRZhEtg1Gi7+B6fvOoWMI5boXXB/OBsBe5rCs/sEWDpj4ulMPcglxhvpDLwYkkS+PsJBWMybWzkIV+sbIe597V4SZb6zhqu5qlHtHu+PTbLX2JBstyajs1zEmvFkUsh48o6Fm57wOSVmLenuQOJTJMilBI3NbmVyh+JyWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MEe1+AID; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N7eF4d026490;
	Tue, 23 Jul 2024 07:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	DpYDN1ECmIn9hlgfjn4NL/mov1BSRbKRIoNIKEVhTz8=; b=MEe1+AID1GibP/zX
	M+baWJtuz5PxnLJ3iryg9Oks5UVvCafKxDH1MXLfero0ZDYczJG7mgxuzGdTMCYC
	91QltR1GnooEYLo29cWOrMhg6XQ5tiYdxBbIP5rg17N8X0GwmGFPZnI5aJHsuT1T
	nCoPZABMjQmFNx2dI75JK2avmAEZJ6zpvryzDv6SXyRE20/qT51fI6KZN1G7y7HH
	wPjNBKGrh3NLdj+HS+GJHzeZH/ceqHKGnXN30folNncXoD+SmR/2SZBzepUzibzX
	GFRS2eILhiqq3tJkR5Dx0f7IIMe4XHmSQG0N5CL9vbIBRzHgD/YPyeYlySpST3no
	i8F9XQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j3rv0jh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 07:57:03 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46N7v3Vs017495;
	Tue, 23 Jul 2024 07:57:03 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j3rv0jh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 07:57:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46N5GToc007979;
	Tue, 23 Jul 2024 07:57:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gxn9sdbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 07:57:01 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46N7uvxb55116212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 07:57:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC98E20043;
	Tue, 23 Jul 2024 07:56:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22EEB20040;
	Tue, 23 Jul 2024 07:56:57 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jul 2024 07:56:57 +0000 (GMT)
Message-ID: <f81c1c05642980981d82fbeef1e0f2afe30c993b.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v2] tools/runqslower: Fix LDFLAGS and add
 LDLIBS support
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Tony Ambardar <tony.ambardar@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
 <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai
 Lau <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend
 <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>
Date: Tue, 23 Jul 2024 09:56:56 +0200
In-Reply-To: <20240723003045.2273499-1-tony.ambardar@gmail.com>
References: <20240723003045.2273499-1-tony.ambardar@gmail.com>
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
X-Proofpoint-ORIG-GUID: llanMZpZvylcQl89RlA5ijQGxj7PnhQl
X-Proofpoint-GUID: 8tQkKOzsLn4YRCgYuhUdKmiYkMiWefHj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 clxscore=1011 mlxlogscore=673 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230057

On Mon, 2024-07-22 at 17:30 -0700, Tony Ambardar wrote:
> Actually use previously defined LDFLAGS during build and add support
> for
> LDLIBS to link extra standalone libraries e.g. 'argp' which is not
> provided
> by musl libc.
>=20
> Fixes: 585bf4640ebe ("tools: runqslower: Add EXTRA_CFLAGS and
> EXTRA_LDFLAGS support")
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---
> v1-v2:
> =C2=A0- add missing CC for Ilya
>=20
> ---
> =C2=A0tools/bpf/runqslower/Makefile | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/bpf/runqslower/Makefile
> b/tools/bpf/runqslower/Makefile
> index d8288936c912..c4f1f1735af6 100644
> --- a/tools/bpf/runqslower/Makefile
> +++ b/tools/bpf/runqslower/Makefile
> @@ -15,6 +15,7 @@ INCLUDES :=3D -I$(OUTPUT) -I$(BPF_INCLUDE) -
> I$(abspath ../../include/uapi)
> =C2=A0CFLAGS :=3D -g -Wall $(CLANG_CROSS_FLAGS)
> =C2=A0CFLAGS +=3D $(EXTRA_CFLAGS)
> =C2=A0LDFLAGS +=3D $(EXTRA_LDFLAGS)
> +LDLIBS +=3D -lelf -lz
> =C2=A0
> =C2=A0# Try to detect best kernel BTF source
> =C2=A0KERNEL_REL :=3D $(shell uname -r)
> @@ -51,7 +52,7 @@ clean:
> =C2=A0libbpf_hdrs: $(BPFOBJ)
> =C2=A0
> =C2=A0$(OUTPUT)/runqslower: $(OUTPUT)/runqslower.o $(BPFOBJ)
> -	$(QUIET_LINK)$(CC) $(CFLAGS) $^ -lelf -lz -o $@
> +	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
> =C2=A0
> =C2=A0$(OUTPUT)/runqslower.o: runqslower.h
> $(OUTPUT)/runqslower.skel.h	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0			$(OUTPUT)/runqslower.bpf.o | libbpf_hdrs

Looks reasonable to me, but I don't quite get what exactly did
585bf4640ebe break? In any case:

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

