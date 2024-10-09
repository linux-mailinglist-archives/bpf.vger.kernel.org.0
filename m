Return-Path: <bpf+bounces-41450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371199971C7
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 18:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EADA8280A70
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 16:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616CD1E376F;
	Wed,  9 Oct 2024 16:32:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B101E32C7;
	Wed,  9 Oct 2024 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491552; cv=none; b=CPqo+j4k9mxQYE669fsmmtYMyaOhMKkewquSwO8UOIw1lYKrpwconOKCbJJqSOFL8Cb58J+x8w1M3epvPL8bU/lAyKkyJrTunPQf1/zNPJA3soKLYF4IyegxnYy39LJcKPtgXveDrB5onu013WXlGkNTuiAA0ArmCkur/Mlh+H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491552; c=relaxed/simple;
	bh=XsqPqyDRIUZtsOsZNo/NYq7wEUNAvNic6hAxHdnTasE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q/hqtoaGkc8Pkj7Ku+syV6eu4H/25HeJ4sKmy4UD8LUFPDx9vFuIjbtMnC4x5YO+WMXkhYCpwvEv+zybu2Xv/l6aOm+hvimhK0sNzGA8F6aaAZ1c27hJDGvX032jwwvIW5RSFiyoxtCAAM4ZrxdCT7MP/xClBOsU8QjFAcaOT50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4XNyZt43gpz9v7Hq;
	Thu, 10 Oct 2024 00:12:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 9F0B1140393;
	Thu, 10 Oct 2024 00:32:18 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwB3JscKsAZnHceLAg--.4147S2;
	Wed, 09 Oct 2024 17:32:18 +0100 (CET)
Message-ID: <b5f9059326d184fa16269c666256b481339c689d.camel@huaweicloud.com>
Subject: Re: [PATCH 1/3] ima: Remove inode lock
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: bpf@vger.kernel.org, kpsingh@kernel.org
Cc: Paul Moore <paul@paul-moore.com>, zohar@linux.ibm.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	serge@hallyn.com, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ebpqwerty472123@gmail.com, Roberto Sassu <roberto.sassu@huawei.com>
Date: Wed, 09 Oct 2024 18:32:07 +0200
In-Reply-To: <7358f12d852964d9209492e337d33b8880234b74.camel@huaweicloud.com>
References: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com>
	 <CAHC9VhSyWNKqustrTjA1uUaZa_jA-KjtzpKdJ4ikSUKoi7iV0Q@mail.gmail.com>
	 <CAHC9VhQR2JbB7ni2yX_U8TWE0PcQQkm_pBCuG3nYN7qO15nNjg@mail.gmail.com>
	 <7358f12d852964d9209492e337d33b8880234b74.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwB3JscKsAZnHceLAg--.4147S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw18AFy7KrW7JF18AF43ZFb_yoW8KFy7pa
	y3K3WYkr1ktrW3CryftFZruaySk3yfWFZrXwn7Jr1qvas2vr1jqr1rJw1Uury5GryxAw1I
	qF17WwnxCw1UArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUrsqXDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQALBGcF5ngMbAAAsS

On Wed, 2024-10-09 at 18:25 +0200, Roberto Sassu wrote:
> On Wed, 2024-10-09 at 11:37 -0400, Paul Moore wrote:
> > On Wed, Oct 9, 2024 at 11:36=E2=80=AFAM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Tue, Oct 8, 2024 at 12:57=E2=80=AFPM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > >=20
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > >=20
> > > > Move out the mutex in the ima_iint_cache structure to a new structu=
re
> > > > called ima_iint_cache_lock, so that a lock can be taken regardless =
of
> > > > whether or not inode integrity metadata are stored in the inode.
> > > >=20
> > > > Introduce ima_inode_security() to simplify accessing the new struct=
ure in
> > > > the inode security blob.
> > > >=20
> > > > Move the mutex initialization and annotation in the new function
> > > > ima_inode_alloc_security() and introduce ima_iint_lock() and
> > > > ima_iint_unlock() to respectively lock and unlock the mutex.
> > > >=20
> > > > Finally, expand the critical region in process_measurement() guarde=
d by
> > > > iint->mutex up to where the inode was locked, use only one iint loc=
k in
> > > > __ima_inode_hash(), since the mutex is now in the inode security bl=
ob, and
> > > > replace the inode_lock()/inode_unlock() calls in ima_check_last_wri=
ter().
> > > >=20
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > ---
> > > >  security/integrity/ima/ima.h      | 26 ++++++++---
> > > >  security/integrity/ima/ima_api.c  |  4 +-
> > > >  security/integrity/ima/ima_iint.c | 77 ++++++++++++++++++++++++++-=
----
> > > >  security/integrity/ima/ima_main.c | 39 +++++++---------
> > > >  4 files changed, 104 insertions(+), 42 deletions(-)
> > >=20
> > > I'm not an IMA expert, but it looks reasonable to me, although
> > > shouldn't this carry a stable CC in the patch metadata?
> > >=20
> > > Reviewed-by: Paul Moore <paul@paul-moore.com>
> >=20
> > Sorry, one more thing ... did you verify this patchset resolves the
> > syzbot problem?  I saw at least one reproducer.
>=20
> Uhm, could not reproduce the deadlock with the reproducer. However,
> without the patch I have a lockdep warning, and with I don't.
>=20
> I asked syzbot to try the patches. Let's see.

@bpf: could you please manually trigger the tests in a PR? Next time
will add the bpf-next tag (or I can send a PR directly from Github).

This patch affects the BPF LSM, the bpf_ima_file_hash() and
bpf_ima_inode_hash() helpers.

Thanks

Roberto


