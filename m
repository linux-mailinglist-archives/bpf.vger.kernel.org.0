Return-Path: <bpf+bounces-71647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C48BF9320
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 01:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F29FA4F9A57
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 23:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6A629E109;
	Tue, 21 Oct 2025 23:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="jwn/V6Ii"
X-Original-To: bpf@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC0D1B7F4;
	Tue, 21 Oct 2025 23:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761088643; cv=none; b=oBLZnSxzXjbtTlRTLdGNf9Hiz5AkGNnVxZW3sSWmvMbCxY1NJ8Tdwhuu16hhYIFg2xcFdFc/C/8rLFK6h7V1EYhPAXNrfp1DUdzE56KxYnO9Xjuk4ngM9ahpU4uacu7whHJVwGNPDh4Zss2xfCXaJwOcPm7xIVRO/n4VnTV846A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761088643; c=relaxed/simple;
	bh=TA9Z2xjXmSPik79pd2nczCKbtFRPJOsg1yrzP0azcSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrCagGIEmLwrfOhzjRr76zcW/cmNm+iywbScWrzkMi1zEMO0w4MHKN6jA0kTR9ZGdek1NdimqikPJaqTb1N2RHaY/1EAiMLTZsPFTJOBFFUXKK6U/Em0m8YRIFzslz7OSvegJzwvoxO11JYw9nnjRy133VsNuuAnl2ZVgFzhLK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=jwn/V6Ii; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id C8C9714C2D3;
	Wed, 22 Oct 2025 01:17:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1761088635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WvdSOJwgRRDHWmISrEiJpRZTFo/MJ+TFfDsA9nuP/9Y=;
	b=jwn/V6Ii+on6aH/1miOeIiq0m1L3XX0jqMPiKZ+zTpSjH5aD3yRayNilm/4UIMKjlYP7dF
	zoOz+v0GrJ05h7I8SppFbiQpeyLssfgTHjZ8FtO4lk7MP8fykqRX2dg3lJEuE0ZEzUebif
	gR+jgU0xci9klWEuZnGFi+sUYtmfviiKj3sUi2OYxwa5hB71B26VKaZyDKXrwCmYn10gZx
	iJYmJmBuNb6+bFojVZ7vADN4auWx8tM5cGWPObQCeIlltxQ4/9HjGxUtLjySHbCfbaVsTV
	Hf/r9S9LKG4XRQPNZwbLh/Pev+o8HLa0MPQO5APw926IK3BRKDTBJ7pQN1A5DA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 4ac624d5;
	Tue, 21 Oct 2025 23:17:11 +0000 (UTC)
Date: Wed, 22 Oct 2025 08:16:56 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Song Liu <song@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Tingmao Wang <m@maowtm.org>, Alexei Starovoitov <ast@kernel.org>,
	linux-kernel@vger.kernel.org, v9fs@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [GIT PULL] 9p cache=mmap regression fix (for 6.18-rc3)
Message-ID: <aPgUaFE1oUq8e1F-@codewreck.org>
References: <20251022-mmap-regression-v1-1-980365ee524e@codewreck.org>
 <CAHzjS_s5EzJkvTqi73XS_9bBsaGuXu1zQ4jOLgcpC9vmJ7FoaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHzjS_s5EzJkvTqi73XS_9bBsaGuXu1zQ4jOLgcpC9vmJ7FoaA@mail.gmail.com>

Hi Linus,

We had a regression with cache=mmap that impacted quite a few people so
I'm sending a fix less than a couple of hours after making the commit.

If it turns out there are other side effects I'd suggest just reverting
commit 290434474c33 ("fs/9p: Refresh metadata in d_revalidate for
uncached mode too") first, but the fix is rather minimal so I think it's
ok to try falling forward -- let me know if you prefer a revert and I'll
send one instead (there's a minor conflict)

Thanks to Sung Liu for the minimal reproducer and testing, as well as
Alexei/Andrii and everyone else who looked at it.



The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-6.18-rc3

for you to fetch changes up to 2776e27d404684bc43acf023d7ca15255e96b3e3:

  fs/9p: don't use cached metadata in revalidate for cache=mmap (2025-10-22 08:04:05 +0900)

----------------------------------------------------------------
Fix regression with cache=mmap in 6.18-rc1

Will do some more testing as time allows but this fixes the immediate
issue minimally (only impacts cache=mmap), and is therefore an
improvement good enough to send right away.

----------------------------------------------------------------
Dominique Martinet (1):
      fs/9p: don't use cached metadata in revalidate for cache=mmap

 fs/9p/vfs_dentry.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
Dominique Martinet | Asmadeus

