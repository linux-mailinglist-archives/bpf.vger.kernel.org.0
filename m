Return-Path: <bpf+bounces-41443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 670E999707E
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 18:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E5E91F22BA6
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 16:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F248A1E0E07;
	Wed,  9 Oct 2024 15:43:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE28A1E04BC;
	Wed,  9 Oct 2024 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488624; cv=none; b=u/WLD+8V1SSprcpGESOd7TDhT/U+pKxVexDLJCm9tVbJ9wRNkbhXIZAlDHkxxWs8nKktfqoAujwFvXmGyNerVpRojRgpp+VPVAlSjbifSLRxdhwNPzKn1xSwC960m58Xe37iGvhJvoQjjFVxmKBMKwqVXyU+r39sLjeolZLT9c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488624; c=relaxed/simple;
	bh=T6nSVu7xD4TeDzmBtg2Zjb6z+8tFfEDQAmFE9kob5+4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G11j21z+Lo2grjI+DhB7NjZeSlGZhdtR0hNmUY31H4NDCyKJceYHVENhPZduEn76g7lO+vm7A9WfRUtaeeyB+RDJeXFhILscHA5x98ZJJIGIs5Q9FVg2V01KFUWaZxREuzilj6VRjs9kSBUkWxS3x7rcQc7xYjDMU6O69BFVyAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4XNxVT1Fjfz9v7JS;
	Wed,  9 Oct 2024 23:23:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 9B4291400CA;
	Wed,  9 Oct 2024 23:43:30 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwA35saapAZnBzaLAg--.4531S2;
	Wed, 09 Oct 2024 16:43:30 +0100 (CET)
Message-ID: <69ed92fde951b20a9b976d48803fe9b5daaa9eea.camel@huaweicloud.com>
Subject: Re: [PATCH 2/3] ima: Ensure lock is held when setting iint pointer
 in inode security blob
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com,  jmorris@namei.org, serge@hallyn.com,
 linux-integrity@vger.kernel.org,  linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org,  bpf@vger.kernel.org,
 ebpqwerty472123@gmail.com, Roberto Sassu <roberto.sassu@huawei.com>
Date: Wed, 09 Oct 2024 17:43:20 +0200
In-Reply-To: <CAHC9VhRkMwLqVFfWMvMOJ6x4UNUK=C_cMVW7Op9icz28MMDYdQ@mail.gmail.com>
References: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com>
	 <20241008165732.2603647-2-roberto.sassu@huaweicloud.com>
	 <CAHC9VhRkMwLqVFfWMvMOJ6x4UNUK=C_cMVW7Op9icz28MMDYdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwA35saapAZnBzaLAg--.4531S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFy7ZF13XryxWw43AFykuFg_yoW8ZryfpF
	Wqga4UJ34UXFW7uF43tF9xZFWSg3ySgFW8Gw45Jw1qyFyDZr1jqr48tr17ury5Cr40y3WI
	vw1ag3Z8uw1qyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOB
	MKDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQALBGcF5ngMAgAAs8

On Wed, 2024-10-09 at 11:41 -0400, Paul Moore wrote:
> On Tue, Oct 8, 2024 at 12:57=E2=80=AFPM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> >=20
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > IMA stores a pointer of the ima_iint_cache structure, containing integr=
ity
> > metadata, in the inode security blob. However, check and assignment of =
this
> > pointer is not atomic, and it might happen that two tasks both see that=
 the
> > iint pointer is NULL and try to set it, causing a memory leak.
> >=20
> > Ensure that the iint check and assignment is guarded, by adding a lockd=
ep
> > assertion in ima_inode_get().
> >=20
> > Consequently, guard the remaining ima_inode_get() calls, in
> > ima_post_create_tmpfile() and ima_post_path_mknod(), to avoid the lockd=
ep
> > warnings.
> >=20
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  security/integrity/ima/ima_iint.c |  5 +++++
> >  security/integrity/ima/ima_main.c | 14 ++++++++++++--
> >  2 files changed, 17 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima=
/ima_iint.c
> > index c176fd0faae7..fe676ccec32f 100644
> > --- a/security/integrity/ima/ima_iint.c
> > +++ b/security/integrity/ima/ima_iint.c
> > @@ -87,8 +87,13 @@ static void ima_iint_free(struct ima_iint_cache *iin=
t)
> >   */
> >  struct ima_iint_cache *ima_inode_get(struct inode *inode)
> >  {
> > +       struct ima_iint_cache_lock *iint_lock;
> >         struct ima_iint_cache *iint;
> >=20
> > +       iint_lock =3D ima_inode_security(inode->i_security);
> > +       if (iint_lock)
> > +               lockdep_assert_held(&iint_lock->mutex);
> > +
> >         iint =3D ima_iint_find(inode);
> >         if (iint)
> >                 return iint;
>=20
> Can you avoid the ima_iint_find() call here and just do the following?
>=20
>   /* not sure if you need to check !iint_lock or not? */
>   if (!iint_lock)
>     return NULL;
>   iint =3D iint_lock->iint;
>   if (!iint)
>     return NULL;

Yes, I also like it much more.

Thanks

Roberto



