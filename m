Return-Path: <bpf+bounces-71669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C8CBFA136
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 07:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23806480617
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 05:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC892EC09A;
	Wed, 22 Oct 2025 05:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="UNktbWJm"
X-Original-To: bpf@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67772EC081;
	Wed, 22 Oct 2025 05:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111520; cv=none; b=m4epSCHvgM7Dm71hBIY77k9ZhZ8jfq382zkR4CzBueWNMnatI+m31042PiGo/1CbP/KD3PpFrtTwRh/RkdXHcYaU5zt1gPjg4gtEYLarbH920/ZT4gvCJnmbswoKQqeGUcdRKz9hzgtWUVw5eb7/WUr9AEIyPJLn2Q2qShbrfVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111520; c=relaxed/simple;
	bh=UCQR+aT3yopHWQ+fBkDsxTQA8UU1mrskcwvqVTuyKt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNN5tHNhRHvVj640LUagYORrsjgISyi909bngDf8yKOyu1uFcW5BMAkxYWAxjbx/nE2mntTh4dkH3VO3oUX+zyF6crortxP0eZ//rTne72ARHQxmGlWIPPubVOLOu3gnD5S8koB5wqD/sG8NoXNP0WzLYYh3xFPQoYBpOjyHczg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=UNktbWJm; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 4081C14C2D3;
	Wed, 22 Oct 2025 07:38:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1761111514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OPgNsOT2ZO9umiexmnUVC6FxF44CE2Et1XNZVAkmI3Y=;
	b=UNktbWJmMVmAiO6elXuW5rxb14r0OOg3jKIKPHPdDxEWWFmJjwL/eFilcCtA+xSPBuTcCa
	DtIrAC4MA4vLPrETboYsfb/3FCuML+eAORUmnO9uQc275gbR5oAEvVxI2Fxa9ZSSdGA0pB
	U+HYZiiYdYF4she1+Ls5WUcuh43HcXjYtV/r593e0yLzcsua3dOqX3+LkuuoSHB56uCzbO
	C3wGgXxdbge8bp8RRH2r1C2fG+m4THEjlNhKznhAj5Fs6u79b3/s2WQVCImyn1jzS7tEWn
	eQC/MSpOirheEGIwvCDNFNo1NulIPeUuOcDrDKlK87yyIPqT8syQCCU1/AWhOA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 1b0779e1;
	Wed, 22 Oct 2025 05:38:29 +0000 (UTC)
Date: Wed, 22 Oct 2025 14:38:14 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Tingmao Wang <m@maowtm.org>
Cc: Song Liu <song@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org,
	v9fs@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [GIT PULL] 9p cache=mmap regression fix (for 6.18-rc3)
Message-ID: <aPhtxt7qEWY5FjPQ@codewreck.org>
References: <20251022-mmap-regression-v1-1-980365ee524e@codewreck.org>
 <CAHzjS_s5EzJkvTqi73XS_9bBsaGuXu1zQ4jOLgcpC9vmJ7FoaA@mail.gmail.com>
 <aPgUaFE1oUq8e1F-@codewreck.org>
 <39116c81-1798-4cc1-945c-a05d0ac7d8d9@maowtm.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39116c81-1798-4cc1-945c-a05d0ac7d8d9@maowtm.org>

Tingmao Wang wrote on Wed, Oct 22, 2025 at 12:34:13AM +0100:
> On 10/22/25 00:16, Dominique Martinet wrote:
> > We had a regression with cache=mmap that impacted quite a few people so
> > I'm sending a fix less than a couple of hours after making the commit.
> > 
> > If it turns out there are other side effects I'd suggest just reverting
> > commit 290434474c33 ("fs/9p: Refresh metadata in d_revalidate for
> > uncached mode too") first, but the fix is rather minimal so I think it's
> > ok to try falling forward -- let me know if you prefer a revert and I'll
> > send one instead (there's a minor conflict)
> 
> See the reply to the original patch [1] (posted right after, and before
> seeing, this message) - there is indeed more side effects, and I wouldn't
> mind a revert for now.  0172a934747f ("fs/9p: Invalidate dentry if inode
> type change detected in cached mode") will need to be reverted too.

(yeah, and even that conflicts due to the added debug message in the
next commit, but I went the heavy-handed way and removed the conflicting
hunk so that commit's also implicitly been removed. In hindsight it
would have been cleaner to revert the three commits
290434474c33^..c667c54c5875 -- ohwell)

> [1]: https://lore.kernel.org/v9fs/6c74ad63-3afc-4549-9ac6-494b9a63e839@maowtm.org/

OK, so let's go with the revert for now as I don't have time to look for
more corner cases immediately.

Linus, here's the new PR:
---------
The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-6.18-rc3-v2

for you to fetch changes up to 43c36a56ccf6d9b07b4b3f4f614756e687dcdc01:

  Revert "fs/9p: Refresh metadata in d_revalidate for uncached mode too" (2025-10-22 14:25:27 +0900)

----------------------------------------------------------------
Fix 9p cache=mmap regression by revert

This reverts the problematic commit instead of trying to fix it in a
rush

----------------------------------------------------------------
Dominique Martinet (1):
      Revert "fs/9p: Refresh metadata in d_revalidate for uncached mode too"

 fs/9p/vfs_dentry.c     | 10 ++--------
 fs/9p/vfs_inode.c      |  8 +-------
 fs/9p/vfs_inode_dotl.c |  8 +-------
 3 files changed, 4 insertions(+), 22 deletions(-)

-- 
Dominique Martinet | Asmadeus

