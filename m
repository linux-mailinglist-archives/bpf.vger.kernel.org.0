Return-Path: <bpf+bounces-41448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFAF99718B
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 18:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C5628507C
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 16:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486DB1E8831;
	Wed,  9 Oct 2024 16:24:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206DB1946C8;
	Wed,  9 Oct 2024 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491086; cv=none; b=mXUMuVPJAo0cAxki0s07V/rg0Ew+W8HnDNUHhsWHdpI9aIzmt4+WRoQ/bWOm5t1fU3Q8EzROtKKKuiKnQn4ta7fJK3vrWa2BxxHC6oCMlFrx53JBgGvs4t0/ihERiRT6gZZwatYViuKzznlnk/xYhR/nWwmz8GKbt5ZS+s+65MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491086; c=relaxed/simple;
	bh=cPDY6DRM/8+Jf0IhF/3ZWCf+7ZyeYPERaB2SfibvR7s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X2uF5lwa93iGHUxYZIUPvJgKMztysSRBl+K8lU4w+/b21AFCYmYSVf4Kb2egnLJSyzqG6MUdzWtAPZj7UtvWWq4AeLusvxPPdcJQnfqBbfSbCrN2jWKaw525qUQlZtjBvfMnxdtV3ZCcbAmI8Ceir2n5RGt755gy9VQl7tELC88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4XNyPw40bgz9v7Hs;
	Thu, 10 Oct 2024 00:04:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 51C761400CA;
	Thu, 10 Oct 2024 00:24:40 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAHSzJArgZn9+6FAg--.60142S2;
	Wed, 09 Oct 2024 17:24:39 +0100 (CET)
Message-ID: <aa987698a5b36713f5d85e1c4c2ce9b6e2abf06c.camel@huaweicloud.com>
Subject: Re: [PATCH 1/3] ima: Remove inode lock
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com,  jmorris@namei.org, serge@hallyn.com,
 linux-integrity@vger.kernel.org,  linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org,  bpf@vger.kernel.org,
 ebpqwerty472123@gmail.com, Roberto Sassu <roberto.sassu@huawei.com>
Date: Wed, 09 Oct 2024 18:24:29 +0200
In-Reply-To: <CAHC9VhSyWNKqustrTjA1uUaZa_jA-KjtzpKdJ4ikSUKoi7iV0Q@mail.gmail.com>
References: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com>
	 <CAHC9VhSyWNKqustrTjA1uUaZa_jA-KjtzpKdJ4ikSUKoi7iV0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAHSzJArgZn9+6FAg--.60142S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1UKry5AryDXF17JrW7CFg_yoW8WFyDpa
	yag3W5Gr1ktrZI9rWftFZruaySk3yxWF4DJwnrJw1vvas3ur1jqryrCw1ru345GryIy34I
	qF1agwn8Cw1qyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQALBGcF5ngMWwAAsl

On Wed, 2024-10-09 at 11:36 -0400, Paul Moore wrote:
> On Tue, Oct 8, 2024 at 12:57=E2=80=AFPM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> >=20
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Move out the mutex in the ima_iint_cache structure to a new structure
> > called ima_iint_cache_lock, so that a lock can be taken regardless of
> > whether or not inode integrity metadata are stored in the inode.
> >=20
> > Introduce ima_inode_security() to simplify accessing the new structure =
in
> > the inode security blob.
> >=20
> > Move the mutex initialization and annotation in the new function
> > ima_inode_alloc_security() and introduce ima_iint_lock() and
> > ima_iint_unlock() to respectively lock and unlock the mutex.
> >=20
> > Finally, expand the critical region in process_measurement() guarded by
> > iint->mutex up to where the inode was locked, use only one iint lock in
> > __ima_inode_hash(), since the mutex is now in the inode security blob, =
and
> > replace the inode_lock()/inode_unlock() calls in ima_check_last_writer(=
).
> >=20
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  security/integrity/ima/ima.h      | 26 ++++++++---
> >  security/integrity/ima/ima_api.c  |  4 +-
> >  security/integrity/ima/ima_iint.c | 77 ++++++++++++++++++++++++++-----
> >  security/integrity/ima/ima_main.c | 39 +++++++---------
> >  4 files changed, 104 insertions(+), 42 deletions(-)
>=20
> I'm not an IMA expert, but it looks reasonable to me, although
> shouldn't this carry a stable CC in the patch metadata?
>=20
> Reviewed-by: Paul Moore <paul@paul-moore.com>

Thanks, will add in the new version.

Roberto



