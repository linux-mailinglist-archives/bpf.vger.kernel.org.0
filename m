Return-Path: <bpf+bounces-41782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C1C99ACA9
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 21:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2BE7282869
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 19:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EC31CFEC8;
	Fri, 11 Oct 2024 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FODmMc0x"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE778BE5;
	Fri, 11 Oct 2024 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675073; cv=none; b=fbPEv2zLCL2Xwy6g33TkjLpsAeIutSMV0nGakgtAg1nCX8e8aYNrq4xFAuglGo2IW5drK2lgUd1NETOO/mW/NCx+7gGxtgmjCaSETgdB6tJidrm3UttK5rjA4HbD1Nzc2tFfEajMq0B0deeswKd1DKMkenmEDw3v0wDsogQMBIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675073; c=relaxed/simple;
	bh=IwlxQ2sJ1Qhcz7dsBEssEsmbqqW/oITaZu+mKURma8M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P5DbXkq+rVdkgSjtjk0NgVC/8WlOvYREInqdCeSLDS5l6YCM5XBPezZUzhnsA9WF2RNYu5SbIXFS/aGewUDMrq1aaMVHqo4aHyrQoCdnJpChx1ME44ob/HRUGRRJKKDsbyyGZOWOzmLQvjLon8PxWgR5m4JByYMGJxZ2f662pOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FODmMc0x; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BITfCd010597;
	Fri, 11 Oct 2024 19:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	zQJWf5VdzOpF2EYAGjsfIFpAdx/RWd5wbhX21JW8MXE=; b=FODmMc0xS+voq/fK
	meBquyIn0m69IwgC2GeULzgM22MQHFpM3aoS3kPrc2IRMQstUDHne4RUksEt3VnQ
	vKZjhOPZyOPenBPJ/zKgMnZ0fUDbsErjV7F+Gwfc4CrBYweoYeMABKWwvOs3s13r
	Y10gZOIQPtA3w+t/NQMITkZpxZ+wPWB4wJlHGrK6goAGQj6aoonb9TKiCH5EV5Sl
	iKyy2UUEIhwJGT8siOjN3GaOr3euCmbyfuyjLMQXyYWvzoz/akl0ahO8XzUoriMA
	+WU90vlcEjWUgX0hzg+KOgMimAi/+ztA2j+7VAG1dAqtpWDUaezJsfn2c+r31I3/
	4+cPIg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4279bm88jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 19:30:42 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49BJUffb006524;
	Fri, 11 Oct 2024 19:30:42 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4279bm88j6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 19:30:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49BHECnT011512;
	Fri, 11 Oct 2024 19:30:40 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423g5y7ehc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 19:30:40 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49BJUeoj15401476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 19:30:40 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E803158061;
	Fri, 11 Oct 2024 19:30:39 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 276FA58056;
	Fri, 11 Oct 2024 19:30:39 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.41.228])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Oct 2024 19:30:39 +0000 (GMT)
Message-ID: <92c528d8848f78869888a746643e1cf2969df62a.camel@linux.ibm.com>
Subject: Re: [PATCH 2/3] ima: Ensure lock is held when setting iint pointer
 in inode security blob
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Paul Moore
	 <paul@paul-moore.com>
Cc: dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, ebpqwerty472123@gmail.com,
        Roberto Sassu
	 <roberto.sassu@huawei.com>
Date: Fri, 11 Oct 2024 15:30:38 -0400
In-Reply-To: <69ed92fde951b20a9b976d48803fe9b5daaa9eea.camel@huaweicloud.com>
References: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com>
	 <20241008165732.2603647-2-roberto.sassu@huaweicloud.com>
	 <CAHC9VhRkMwLqVFfWMvMOJ6x4UNUK=C_cMVW7Op9icz28MMDYdQ@mail.gmail.com>
	 <69ed92fde951b20a9b976d48803fe9b5daaa9eea.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DZxyYUTIR8LDQnwha_3KegIQQZdtiSaE
X-Proofpoint-GUID: 1T-MaBMKiaPGlCnU0zovXnFAFQ1k5Ai9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_16,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1011 mlxscore=0
 spamscore=0 mlxlogscore=518 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410110132

On Wed, 2024-10-09 at 17:43 +0200, Roberto Sassu wrote:
> On Wed, 2024-10-09 at 11:41 -0400, Paul Moore wrote:
> > On Tue, Oct 8, 2024 at 12:57=E2=80=AFPM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > >=20
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >=20
> > > IMA stores a pointer of the ima_iint_cache structure, containing inte=
grity
> > > metadata, in the inode security blob. However, check and assignment o=
f this
> > > pointer is not atomic, and it might happen that two tasks both see th=
at the
> > > iint pointer is NULL and try to set it, causing a memory leak.
> > >=20
> > > Ensure that the iint check and assignment is guarded, by adding a loc=
kdep
> > > assertion in ima_inode_get().
> > >=20
> > > Consequently, guard the remaining ima_inode_get() calls, in
> > > ima_post_create_tmpfile() and ima_post_path_mknod(), to avoid the loc=
kdep
> > > warnings.
> > >=20
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > ---
> > >  security/integrity/ima/ima_iint.c |  5 +++++
> > >  security/integrity/ima/ima_main.c | 14 ++++++++++++--
> > >  2 files changed, 17 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/i=
ma/ima_iint.c
> > > index c176fd0faae7..fe676ccec32f 100644
> > > --- a/security/integrity/ima/ima_iint.c
> > > +++ b/security/integrity/ima/ima_iint.c
> > > @@ -87,8 +87,13 @@ static void ima_iint_free(struct ima_iint_cache *i=
int)
> > >   */
> > >  struct ima_iint_cache *ima_inode_get(struct inode *inode)
> > >  {
> > > +       struct ima_iint_cache_lock *iint_lock;
> > >         struct ima_iint_cache *iint;
> > >=20
> > > +       iint_lock =3D ima_inode_security(inode->i_security);
> > > +       if (iint_lock)
> > > +               lockdep_assert_held(&iint_lock->mutex);
> > > +
> > >         iint =3D ima_iint_find(inode);
> > >         if (iint)
> > >                 return iint;
> >=20
> > Can you avoid the ima_iint_find() call here and just do the following?
> >=20
> >   /* not sure if you need to check !iint_lock or not? */
> >   if (!iint_lock)
> >     return NULL;
> >   iint =3D iint_lock->iint;
> >   if (!iint)
> >     return NULL;
>=20
> Yes, I also like it much more.

Yes, testing iint_lock and then iint_lock->iint should be fine, but the log=
ic
needs to be inverted.  ima_inode_get() should return the existing iint, if =
it
exists, or allocate the memory.

Mimi



