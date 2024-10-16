Return-Path: <bpf+bounces-42190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6699A0B07
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 15:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C45841F26723
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 13:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05368209687;
	Wed, 16 Oct 2024 13:08:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7192E208D88;
	Wed, 16 Oct 2024 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729084125; cv=none; b=ARI3kgF1HEjryEw8Q7bqZjhC6h3gEnyBLt3DwE05ODcuVk4dEHfI1g/MNvs+xLJ36H4edEMFINgRsU9ua3yVDJhlJh8xxRhUiPmNYgKuSzQtOTsGKaBCx8MGohAYbMOZV7qFTSCJzyBynObE3hadW1s7c+P3wWo2odJltO+UDNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729084125; c=relaxed/simple;
	bh=p6qrzMsv92J2BKqZn/+oJpMYE2tiMW03Q9j+yCiO0f4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uudo1FJj+8nnIAX83xXlROHxK1NmOxDcEcBqNbx18i/VA/CPqsDqyYcHz8saq6MMXyHTSKeSkKOYXuHAvrzM/tuMt/ukne15fQkicFv9Q2FVeMtGgbcQWp0Xm7q2lumT5hcysH9ww481bvFmMLq4Kqc+Nm6/eZOi/2u7B4BaaZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4XT9kL507yz9v7NL;
	Wed, 16 Oct 2024 20:48:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 4A5EA14075E;
	Wed, 16 Oct 2024 21:08:28 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAniMjDug9nyd39Ag--.38782S2;
	Wed, 16 Oct 2024 14:08:27 +0100 (CET)
Message-ID: <33fefedfbdc44ea9c58a14030d58bff20b2c7d86.camel@huaweicloud.com>
Subject: Re: [PATCH 2/3] ima: Ensure lock is held when setting iint pointer
 in inode security blob
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>
Cc: dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	serge@hallyn.com, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, ebpqwerty472123@gmail.com, Roberto Sassu
	 <roberto.sassu@huawei.com>
Date: Wed, 16 Oct 2024 15:08:16 +0200
In-Reply-To: <3ab95195af7db9d2bd482f46a69305f2f386cc32.camel@huaweicloud.com>
References: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com>
	 <20241008165732.2603647-2-roberto.sassu@huaweicloud.com>
	 <CAHC9VhRkMwLqVFfWMvMOJ6x4UNUK=C_cMVW7Op9icz28MMDYdQ@mail.gmail.com>
	 <69ed92fde951b20a9b976d48803fe9b5daaa9eea.camel@huaweicloud.com>
	 <92c528d8848f78869888a746643e1cf2969df62a.camel@linux.ibm.com>
	 <3ab95195af7db9d2bd482f46a69305f2f386cc32.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwAniMjDug9nyd39Ag--.38782S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFW3Zr13Zr1fuw4UKF1ftFb_yoW5XF4fpF
	Wvg3WUAayUXFW7urs0qasIvrWfK3yfGFWkWw15Jw1DZFyvvr1Yqr48Jr1Uury5Gr4xJw10
	vr47Ka13uw1qyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQASBGcPIPkKdAAAsY

On Mon, 2024-10-14 at 13:45 +0200, Roberto Sassu wrote:
> On Fri, 2024-10-11 at 15:30 -0400, Mimi Zohar wrote:
> > On Wed, 2024-10-09 at 17:43 +0200, Roberto Sassu wrote:
> > > On Wed, 2024-10-09 at 11:41 -0400, Paul Moore wrote:
> > > > On Tue, Oct 8, 2024 at 12:57=E2=80=AFPM Roberto Sassu
> > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > >=20
> > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > >=20
> > > > > IMA stores a pointer of the ima_iint_cache structure, containing =
integrity
> > > > > metadata, in the inode security blob. However, check and assignme=
nt of this
> > > > > pointer is not atomic, and it might happen that two tasks both se=
e that the
> > > > > iint pointer is NULL and try to set it, causing a memory leak.
> > > > >=20
> > > > > Ensure that the iint check and assignment is guarded, by adding a=
 lockdep
> > > > > assertion in ima_inode_get().
> > > > >=20
> > > > > Consequently, guard the remaining ima_inode_get() calls, in
> > > > > ima_post_create_tmpfile() and ima_post_path_mknod(), to avoid the=
 lockdep
> > > > > warnings.
> > > > >=20
> > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > ---
> > > > >  security/integrity/ima/ima_iint.c |  5 +++++
> > > > >  security/integrity/ima/ima_main.c | 14 ++++++++++++--
> > > > >  2 files changed, 17 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/security/integrity/ima/ima_iint.c b/security/integri=
ty/ima/ima_iint.c
> > > > > index c176fd0faae7..fe676ccec32f 100644
> > > > > --- a/security/integrity/ima/ima_iint.c
> > > > > +++ b/security/integrity/ima/ima_iint.c
> > > > > @@ -87,8 +87,13 @@ static void ima_iint_free(struct ima_iint_cach=
e *iint)
> > > > >   */
> > > > >  struct ima_iint_cache *ima_inode_get(struct inode *inode)
> > > > >  {
> > > > > +       struct ima_iint_cache_lock *iint_lock;
> > > > >         struct ima_iint_cache *iint;
> > > > >=20
> > > > > +       iint_lock =3D ima_inode_security(inode->i_security);
> > > > > +       if (iint_lock)
> > > > > +               lockdep_assert_held(&iint_lock->mutex);
> > > > > +
> > > > >         iint =3D ima_iint_find(inode);
> > > > >         if (iint)
> > > > >                 return iint;
> > > >=20
> > > > Can you avoid the ima_iint_find() call here and just do the followi=
ng?
> > > >=20
> > > >   /* not sure if you need to check !iint_lock or not? */
> > > >   if (!iint_lock)
> > > >     return NULL;
> > > >   iint =3D iint_lock->iint;
> > > >   if (!iint)
> > > >     return NULL;
> > >=20
> > > Yes, I also like it much more.
> >=20
> > Yes, testing iint_lock and then iint_lock->iint should be fine, but the=
 logic
> > needs to be inverted.  ima_inode_get() should return the existing iint,=
 if it
> > exists, or allocate the memory.
>=20
> Right, I checked the patches I'm about to send, they do that.

I think Paul's point was that we should not create a iint anyway, if
the inode does not have a security blob. That check I think it is fine
to keep.

Roberto


