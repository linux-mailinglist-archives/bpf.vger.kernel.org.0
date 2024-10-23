Return-Path: <bpf+bounces-42966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AD79AD865
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 01:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D776B228DF
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 23:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25C41FF7DC;
	Wed, 23 Oct 2024 23:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="3MzUIK6V"
X-Original-To: bpf@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAE21FF7AE;
	Wed, 23 Oct 2024 23:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729725862; cv=none; b=VyuuQvMLHCmZh/5Uj71ay71K70c7RFlzNg12kTKT58S3juQAuwy7rsgAIZoqmZxJwQKHcH4q4axPXGMS7fhJ0yXMRQ8sJlRLJvNcz77rdV+AtePvmYWqf48Z+GtCwNRXO5EyDRqSqydpltoYuoFDRwki3QwEqZbXL8uTQs5zc9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729725862; c=relaxed/simple;
	bh=n+FFpXv4PJFw+9a/Ezyh5AocFqAzwBRGyQcwXWz5jBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQm52+CUHWKSqq4yrisJWwMngYnPqvp8LfI1LHlI6rfBGNC0LwWG6bjMe9aN4mzBeugGUmOwIPHwL3FRadFW+QmM7tZjCk0J2KzMzM2uFOAc4AYcTswuILy1nQfprdui5ZyebsvMqaQUcN3y1kju1Xmemidx/qMPwbrih/a4+nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=3MzUIK6V; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 1566E14C1E1;
	Thu, 24 Oct 2024 01:24:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1729725850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uq4pgfK90LTAqbpoUp/Bzs/qyX4xLUiGN0J61hu/6cw=;
	b=3MzUIK6VCbNBeTYCdYVdRvsWmdsRr1ZvZDNLTZyfXjoiIMgTVd7XXIbNa25DxcVmCrGIIw
	7YWFC5Mbm6cm8MRoGvfnfDwraSvAWoePCkNNfJcmclcNjphRiAeCtAYALXWxAqDEt+zLHB
	cvvSAv6JwOGVZvjhChlE4zaLHzNXISi/jc/nxMD/R+FioG+OGFHmAin+YQoTdZKDrJr0O+
	p1MUbVMcIfDpLovxe92+8UAMyCPmz301B07kMQ2WWAemE1MMLCfMi/l7cZsMA6QSN5cHgk
	+5rXylelAoZONZXT5/ENmOxvBQMQ6P3yTd0Kj3UebsU8IfYyzXCd2MPGpYR+Sw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 0e53634f;
	Wed, 23 Oct 2024 23:24:05 +0000 (UTC)
Date: Thu, 24 Oct 2024 08:23:50 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: ericvh@kernel.org, linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com, pedro.falcato@gmail.com,
	regressions@leemhuis.info, torvalds@linux-foundation.org,
	v9fs@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [GIT PULL] 9p fixes for 6.12-rc4
Message-ID: <ZxmFhiAL-ImjKe7Y@codewreck.org>
References: <ZxL0kMXLDng3Kw_V@codewreck.org>
 <20241023165606.3051029-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241023165606.3051029-1-andrii@kernel.org>

Adding David/Willy to recpients as I'm not 100% up to date on folios

Andrii Nakryiko wrote on Wed, Oct 23, 2024 at 09:56:06AM -0700:
> > The following changes since commit 98f7e32f20d28ec452afb208f9cffc08448a2652:
> >
> >   Linux 6.11 (2024-09-15 16:57:56 +0200)
> >
> > are available in the Git repository at:
> > 
> >   https://github.com/martinetd/linux tags/9p-for-6.12-rc4
> > 
> > for you to fetch changes up to 79efebae4afc2221fa814c3cae001bede66ab259:
> >
> >   9p: Avoid creating multiple slab caches with the same name (2024-09-23 05:51:27 +0900)
> >
> > ----------------------------------------------------------------
> > Mashed-up update that I sat on too long:
> > 
> > - fix for multiple slabs created with the same name
> > - enable multipage folios
> > - theorical fix to also look for opened fids by inode if none
> > was found by dentry
> > 
> > ----------------------------------------------------------------
> > David Howells (1):
> >      9p: Enable multipage folios
> 
> Are there any known implications of this change on madvise()'s MADV_PAGEOUT
> behavior? After most recent pull from Linus's tree, one of BPF selftests
> started failing. Bisection points to:
> 
>   9197b73fd7bb ("Merge tag '9p-for-6.12-rc4' of https://github.com/martinetd/linux")
> 
> ... which is just an empty merge commit. So the "9p: Enable multipage folios"
> by itself doesn't cause any regression, but when merged with the rest of the
> code it does. I confirmed by reverting
> 1325e4a91a40 ("9p: Enable multipage folios"), after which the test in question
> is succeeding again.

(looks like 3c217a182018 ("selftests/bpf: add build ID tests") wasn't in
yet on the 9p multipage folios commit)

> The test in question itself is a bit involved, but what it ultimately tries to
> do is to ensure that part of ELF file containing build ID is paged out to cause
> BPF helper to fail to retrieve said build ID (due to non-faulable context).
> 
> For that, we use the following sequence in target binary and process:
> 
> madvise(addr, page_sz, MADV_POPULATE_READ);
> madvise(addr, page_sz, MADV_PAGEOUT);
> 
> First making sure page is paged in, then paged out. We make sure that build ID
> is memory mapped in a separate segment with its own single-page memory mapping.
> No changes or regressions there. No huge pages seem to be involved.

That's probably obvious but I guess the selftest runs the binary
directly from a 9p mount?

> It used to work reliably, now it doesn't work. Any clue why or what should we
> do differently to make sure that memory page with build ID information is not
> paged in (reliably)?

Unless David/Willy has a solution immediately I'd say let's take the time to
sort this out and revert that commit for now -- I'll send a revert patch
immediately and submit it to Linus on Saturday.

Conceptually I guess something is broken with MADV_PAGEOUT on >1 page
folio, perhaps it's only evicting folios if the whole folio is in range
but it should evict any folio that touches the range or something?

Sorry I don't have time to dig further here, hopefully that's not too
difficult to handle and we can try again in rc1 proper of another cycle,
I shouldn't have sent that this late.


(leaving full text below for new recipients)
> Thanks!
> 
> P.S. The target binary and madvise() manipulations are at:
> 
>   tools/testing/selftests/bpf/uprobe_multi.c, see trigger_uprobe()
> The test itself in BPF selftest is at:
> 
>   tools/testing/selftests/bpf/prog_tests/build_id.c, see subtest_nofault(),
>   build_id_resident is false in this case.
> 
> >
> > Dominique Martinet (1):
> >       9p: v9fs_fid_find: also lookup by inode if not found dentry
> > 
> > Pedro Falcato (1):
> >       9p: Avoid creating multiple slab caches with the same name
> > 
> >  fs/9p/fid.c       |  5 ++---
> >  fs/9p/vfs_inode.c |  1 +
> >  net/9p/client.c   | 10 +++++++++-
> >  3 files changed, 12 insertions(+), 4 deletions(-)
> > 
> 

Thanks,
-- 
Dominique Martinet | Asmadeus

