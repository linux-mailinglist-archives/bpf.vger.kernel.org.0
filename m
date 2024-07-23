Return-Path: <bpf+bounces-35386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAECD939E59
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 11:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77CD1C21F1C
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 09:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EF814D44E;
	Tue, 23 Jul 2024 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hmq/fOrw"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151CF14C59A
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 09:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721728672; cv=none; b=pBT75NcSLjfQMGeueFbA4glVIMJbyInaW6zlfsBEBIxmonsvuT3PlV7MyOeRs5+TgROuhHC6TsX2H2gEh/FAK3pcQmYefTGf3dD3x7uV5/a2WxsIoXAngMXbqy24BD8YyOwKWq3pYMNYE3xucbdKrW+tKLOVBKIHNE7/IOIH9j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721728672; c=relaxed/simple;
	bh=HugJsyWmt9FFfQ0jK11BJOE6Azc0OIA1/wg9X8OPkiU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=if/ofsXMA9K5er7MDHPvovCJPqwQPEuqlCq7d1lx8M1Xtr1xedf5p8Y1cOkrDpq+sEkZkSHfxG5VSARKuBBJDOMI76BsANRa/CWxukZQiMmWI2UFjrSlqq7VWUEJHw49Onxd/J0jpppAwlCXHUdLT/PS+hSs/Icc/K5YLQ6yxrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hmq/fOrw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N9urpN027225;
	Tue, 23 Jul 2024 09:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	5xgjTwtDABGTlusPuohnU+np8JSrW92XqZUNT879Sj4=; b=Hmq/fOrwr3FikgHT
	8UL9gMtebewNo/jjI68iGa9vlW3U3RAytCPkg2Ye4iFxI341AsFuPQMmlalHoSH6
	GRaVyRPK1j3dUzmhKVjU7Ti9J+TBQXyJtP4sQNxqbxzklXajlCRzLMWET3BbV8Bn
	SRjgmIx8Nf5KJmg02n4zgjDDdKv7vkX+svrJfJg0KucNBIAGsmf/NTpmbyq603w0
	uZn7Bw7v4BkzQFaRb6J8qRiZylNeUEonDyas/4zdZU/IRSW69fLCeQhM//1quRZD
	1lB9Hnx++SKrU81/epUt2MN2uvxjElmh7N+sKOT/kGTb1BkibLydigYHzfdFpwWz
	/MSLvw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j6uarfeu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:57:35 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46N9vY2u027791;
	Tue, 23 Jul 2024 09:57:34 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j6uarfes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:57:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46N6Fwbn006259;
	Tue, 23 Jul 2024 09:57:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gqjuba2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:57:33 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46N9vTWP53149984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 09:57:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1BC42004B;
	Tue, 23 Jul 2024 09:57:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E932320040;
	Tue, 23 Jul 2024 09:57:28 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jul 2024 09:57:28 +0000 (GMT)
Message-ID: <4ab4a294118ed51156e5114193cb0b1838c5dfa3.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v2] tools/runqslower: Fix LDFLAGS and add
 LDLIBS support
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel
 Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song
 <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Date: Tue, 23 Jul 2024 11:57:28 +0200
In-Reply-To: <Zp9wq1fRPdaU9/sE@kodidev-ubuntu>
References: <20240723003045.2273499-1-tony.ambardar@gmail.com>
	 <f81c1c05642980981d82fbeef1e0f2afe30c993b.camel@linux.ibm.com>
	 <Zp9wq1fRPdaU9/sE@kodidev-ubuntu>
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
X-Proofpoint-GUID: cIEzxoe1aNrekJBj5xnv9Vp-0zgj7JDJ
X-Proofpoint-ORIG-GUID: SWdu0UF-xejBbU9RLY6VmpNNUNBP7hxC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=716 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407230073

On Tue, 2024-07-23 at 01:58 -0700, Tony Ambardar wrote:
> On Tue, Jul 23, 2024 at 09:56:56AM +0200, Ilya Leoshkevich wrote:
> > On Mon, 2024-07-22 at 17:30 -0700, Tony Ambardar wrote:
> > > Actually use previously defined LDFLAGS during build and add
> > > support
> > > for
> > > LDLIBS to link extra standalone libraries e.g. 'argp' which is
> > > not
> > > provided
> > > by musl libc.
> > >=20
> > > Fixes: 585bf4640ebe ("tools: runqslower: Add EXTRA_CFLAGS and
> > > EXTRA_LDFLAGS support")
> > > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > > ---
> > > v1-v2:
> > > =C2=A0- add missing CC for Ilya
> > >=20
> > > ---
> > > =C2=A0tools/bpf/runqslower/Makefile | 3 ++-
> > > =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/tools/bpf/runqslower/Makefile
> > > b/tools/bpf/runqslower/Makefile
> > > index d8288936c912..c4f1f1735af6 100644
> > > --- a/tools/bpf/runqslower/Makefile
> > > +++ b/tools/bpf/runqslower/Makefile
> > > @@ -15,6 +15,7 @@ INCLUDES :=3D -I$(OUTPUT) -I$(BPF_INCLUDE) -
> > > I$(abspath ../../include/uapi)
> > > =C2=A0CFLAGS :=3D -g -Wall $(CLANG_CROSS_FLAGS)
> > > =C2=A0CFLAGS +=3D $(EXTRA_CFLAGS)
> > > =C2=A0LDFLAGS +=3D $(EXTRA_LDFLAGS)
> > > +LDLIBS +=3D -lelf -lz
> > > =C2=A0
> > > =C2=A0# Try to detect best kernel BTF source
> > > =C2=A0KERNEL_REL :=3D $(shell uname -r)
> > > @@ -51,7 +52,7 @@ clean:
> > > =C2=A0libbpf_hdrs: $(BPFOBJ)
> > > =C2=A0
> > > =C2=A0$(OUTPUT)/runqslower: $(OUTPUT)/runqslower.o $(BPFOBJ)
> > > -	$(QUIET_LINK)$(CC) $(CFLAGS) $^ -lelf -lz -o $@
> > > +	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o
> > > $@
> > > =C2=A0
> > > =C2=A0$(OUTPUT)/runqslower.o: runqslower.h
> > > $(OUTPUT)/runqslower.skel.h	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > > =C2=A0			$(OUTPUT)/runqslower.bpf.o | libbpf_hdrs
> >=20
> > Looks reasonable to me, but I don't quite get what exactly did
> > 585bf4640ebe break? In any case:
> >=20
> > Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
>=20
> I believe 585bf4640ebe added the LDFLAGS definition above but then
> didn't
> include it in the runqslower target's compile command. I only
> happened to
> notice while adding LDLIBS.
>=20
> Thanks for looking at this.

Ah, I see. Perhaps what I was passing in CFLAGS was already enough for
my use case, so I didn't notice back then. Thanks for the explanation.

