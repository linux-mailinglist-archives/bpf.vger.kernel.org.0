Return-Path: <bpf+bounces-41449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A03997192
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 18:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948321F27F20
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 16:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FBD1EABA1;
	Wed,  9 Oct 2024 16:26:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B208A1E9077;
	Wed,  9 Oct 2024 16:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491161; cv=none; b=BT09vHid1i96jJm80Jq+D+pZLXef+7OgruGY5Xqx0XsTuU9eF8nqmc1P57NcXEfqxya+MdO+gwJre2ZxnXjCBo2gyvWPoSTdO8uzOh8RoNyLZFImWBZ5cZlxjYxR0TeJUOnwwvzgFUZf4rBeXktVYGHZkHjKaKrbzaePR9murTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491161; c=relaxed/simple;
	bh=h8/ahP4xmd8XMO+JEsxeM006YnQkw2gH0McVP4Kprq0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hUGgCL4q+B98Ai9bv74Z6gCL4ChkGfm59HTBacd2veUZAO0zpZIuEqVh8RYNruzolTWisonpQZrDXXA508wXTlfwqFnGsmrpHCd7soKqC7K7NKQju4jXDGqTiVxp4UPnz2WXT+bkFrL7UqZb8VBYTC+E/ejDarmOrGYbu40hxl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4XNyRQ1Dt4z9v7HK;
	Thu, 10 Oct 2024 00:05:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id A3B69140203;
	Thu, 10 Oct 2024 00:25:55 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDndy+LrgZnl_KFAg--.57862S2;
	Wed, 09 Oct 2024 17:25:55 +0100 (CET)
Message-ID: <7358f12d852964d9209492e337d33b8880234b74.camel@huaweicloud.com>
Subject: Re: [PATCH 1/3] ima: Remove inode lock
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com,  jmorris@namei.org, serge@hallyn.com,
 linux-integrity@vger.kernel.org,  linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org,  bpf@vger.kernel.org,
 ebpqwerty472123@gmail.com, Roberto Sassu <roberto.sassu@huawei.com>
Date: Wed, 09 Oct 2024 18:25:45 +0200
In-Reply-To: <CAHC9VhQR2JbB7ni2yX_U8TWE0PcQQkm_pBCuG3nYN7qO15nNjg@mail.gmail.com>
References: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com>
	 <CAHC9VhSyWNKqustrTjA1uUaZa_jA-KjtzpKdJ4ikSUKoi7iV0Q@mail.gmail.com>
	 <CAHC9VhQR2JbB7ni2yX_U8TWE0PcQQkm_pBCuG3nYN7qO15nNjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDndy+LrgZnl_KFAg--.57862S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw47AF1xXF4rZr4DCw1rJFb_yoW8Zw17pa
	y2g3WYkr1ktry29rWftFZruaySk3yrWFZrX3Z7Jr1kZas7Zr1jqr1fG345uFy5GryxAw1I
	qF1UWwn8Cw1DA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrs
	qXDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgALBGcF5v4MbwAAsU

On Wed, 2024-10-09 at 11:37 -0400, Paul Moore wrote:
> On Wed, Oct 9, 2024 at 11:36=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Tue, Oct 8, 2024 at 12:57=E2=80=AFPM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > >=20
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >=20
> > > Move out the mutex in the ima_iint_cache structure to a new structure
> > > called ima_iint_cache_lock, so that a lock can be taken regardless of
> > > whether or not inode integrity metadata are stored in the inode.
> > >=20
> > > Introduce ima_inode_security() to simplify accessing the new structur=
e in
> > > the inode security blob.
> > >=20
> > > Move the mutex initialization and annotation in the new function
> > > ima_inode_alloc_security() and introduce ima_iint_lock() and
> > > ima_iint_unlock() to respectively lock and unlock the mutex.
> > >=20
> > > Finally, expand the critical region in process_measurement() guarded =
by
> > > iint->mutex up to where the inode was locked, use only one iint lock =
in
> > > __ima_inode_hash(), since the mutex is now in the inode security blob=
, and
> > > replace the inode_lock()/inode_unlock() calls in ima_check_last_write=
r().
> > >=20
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > ---
> > >  security/integrity/ima/ima.h      | 26 ++++++++---
> > >  security/integrity/ima/ima_api.c  |  4 +-
> > >  security/integrity/ima/ima_iint.c | 77 ++++++++++++++++++++++++++---=
--
> > >  security/integrity/ima/ima_main.c | 39 +++++++---------
> > >  4 files changed, 104 insertions(+), 42 deletions(-)
> >=20
> > I'm not an IMA expert, but it looks reasonable to me, although
> > shouldn't this carry a stable CC in the patch metadata?
> >=20
> > Reviewed-by: Paul Moore <paul@paul-moore.com>
>=20
> Sorry, one more thing ... did you verify this patchset resolves the
> syzbot problem?  I saw at least one reproducer.

Uhm, could not reproduce the deadlock with the reproducer. However,
without the patch I have a lockdep warning, and with I don't.

I asked syzbot to try the patches. Let's see.

Thanks

Roberto



