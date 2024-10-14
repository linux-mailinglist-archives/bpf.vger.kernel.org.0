Return-Path: <bpf+bounces-41859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B010399C938
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 13:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578281F22B2F
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 11:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C9D19D09E;
	Mon, 14 Oct 2024 11:45:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4F58F64;
	Mon, 14 Oct 2024 11:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906334; cv=none; b=DB0z9SM7MGKTi+qdr7DVdmiHc4EYAKxDM7WLkF3NVT2ksb7vWQqS3OSRWreNt9V5ocsXKmjIEgfYncNeT10tDJHvJf+fvKxpEXyyxOjNwEe6i7Wu83aoNW2qPxtKyoFzlLZYvZMX+2JLlrAwmLLSq6NzrE1C6URzCibs4LCN2+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906334; c=relaxed/simple;
	bh=VoLnJvOlLRHecuqbnEsmCdzipd3c3Z0TDF+JCNNRUn8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ELtZ2XsxA/Tj7pqNWueYlOY4tKyqtAH9u13SG9wIrwU1KaoopvKiK2P6pogoTyabt2XN7dJ8/gDi6rLy+nPRco7FGdPAh5thQW1ffTYy/X9xetjaUm6+N7s4CXi7EYIPwV6Y8ShR/6MomX9co1ygRYmgcIOfmKw5mwPMKe3A8VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4XRvrK36g8z9v7JM;
	Mon, 14 Oct 2024 19:19:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id B168C1405A1;
	Mon, 14 Oct 2024 19:45:15 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXZy9CBA1n8ArVAg--.16371S2;
	Mon, 14 Oct 2024 12:45:15 +0100 (CET)
Message-ID: <3ab95195af7db9d2bd482f46a69305f2f386cc32.camel@huaweicloud.com>
Subject: Re: [PATCH 2/3] ima: Ensure lock is held when setting iint pointer
 in inode security blob
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>
Cc: dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	serge@hallyn.com, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, ebpqwerty472123@gmail.com, Roberto Sassu
	 <roberto.sassu@huawei.com>
Date: Mon, 14 Oct 2024 13:45:02 +0200
In-Reply-To: <92c528d8848f78869888a746643e1cf2969df62a.camel@linux.ibm.com>
References: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com>
	 <20241008165732.2603647-2-roberto.sassu@huaweicloud.com>
	 <CAHC9VhRkMwLqVFfWMvMOJ6x4UNUK=C_cMVW7Op9icz28MMDYdQ@mail.gmail.com>
	 <69ed92fde951b20a9b976d48803fe9b5daaa9eea.camel@huaweicloud.com>
	 <92c528d8848f78869888a746643e1cf2969df62a.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDXZy9CBA1n8ArVAg--.16371S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWDuw4DJr1xur45XrWUArb_yoW5JrWfpF
	Wvg3WUGayUXFW7ur4SqasxZFWSg3yfWFWkWw45Jw1qvFyqvF1jqr48Jr1Uury5Cr4xKw1I
	vr42ga13uw1qyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAQBGcMffgJKQADsY

On Fri, 2024-10-11 at 15:30 -0400, Mimi Zohar wrote:
> On Wed, 2024-10-09 at 17:43 +0200, Roberto Sassu wrote:
> > On Wed, 2024-10-09 at 11:41 -0400, Paul Moore wrote:
> > > On Tue, Oct 8, 2024 at 12:57=E2=80=AFPM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > >=20
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > >=20
> > > > IMA stores a pointer of the ima_iint_cache structure, containing in=
tegrity
> > > > metadata, in the inode security blob. However, check and assignment=
 of this
> > > > pointer is not atomic, and it might happen that two tasks both see =
that the
> > > > iint pointer is NULL and try to set it, causing a memory leak.
> > > >=20
> > > > Ensure that the iint check and assignment is guarded, by adding a l=
ockdep
> > > > assertion in ima_inode_get().
> > > >=20
> > > > Consequently, guard the remaining ima_inode_get() calls, in
> > > > ima_post_create_tmpfile() and ima_post_path_mknod(), to avoid the l=
ockdep
> > > > warnings.
> > > >=20
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > ---
> > > >  security/integrity/ima/ima_iint.c |  5 +++++
> > > >  security/integrity/ima/ima_main.c | 14 ++++++++++++--
> > > >  2 files changed, 17 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/security/integrity/ima/ima_iint.c b/security/integrity=
/ima/ima_iint.c
> > > > index c176fd0faae7..fe676ccec32f 100644
> > > > --- a/security/integrity/ima/ima_iint.c
> > > > +++ b/security/integrity/ima/ima_iint.c
> > > > @@ -87,8 +87,13 @@ static void ima_iint_free(struct ima_iint_cache =
*iint)
> > > >   */
> > > >  struct ima_iint_cache *ima_inode_get(struct inode *inode)
> > > >  {
> > > > +       struct ima_iint_cache_lock *iint_lock;
> > > >         struct ima_iint_cache *iint;
> > > >=20
> > > > +       iint_lock =3D ima_inode_security(inode->i_security);
> > > > +       if (iint_lock)
> > > > +               lockdep_assert_held(&iint_lock->mutex);
> > > > +
> > > >         iint =3D ima_iint_find(inode);
> > > >         if (iint)
> > > >                 return iint;
> > >=20
> > > Can you avoid the ima_iint_find() call here and just do the following=
?
> > >=20
> > >   /* not sure if you need to check !iint_lock or not? */
> > >   if (!iint_lock)
> > >     return NULL;
> > >   iint =3D iint_lock->iint;
> > >   if (!iint)
> > >     return NULL;
> >=20
> > Yes, I also like it much more.
>=20
> Yes, testing iint_lock and then iint_lock->iint should be fine, but the l=
ogic
> needs to be inverted.  ima_inode_get() should return the existing iint, i=
f it
> exists, or allocate the memory.

Right, I checked the patches I'm about to send, they do that.

Thanks

Roberto


