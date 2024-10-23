Return-Path: <bpf+bounces-42930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CD19AD206
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 19:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860AA1C25F24
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 17:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D688B1CF2A1;
	Wed, 23 Oct 2024 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2p77taZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545D41CF5CF;
	Wed, 23 Oct 2024 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702573; cv=none; b=BAL4wnAMzqIwrNsQC5yUXIoDelUOSa3CVI7EwBAd4ZHSdhHDR5fYAkJtDjKUvxR0IgKQAv100POV8mAUYBRzL0efnE6gYcOs3IFOIRzATfmzRmwg9zJNTgYYfbhbnJdNzCqnDcP+KQEdOAnC5x1nKjCqvu6vu2oC6hYQFYUS1r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702573; c=relaxed/simple;
	bh=9FQMpnUuD/q0UYsx9FcXZS3U5Eb/ILV6G0JOybEs5S8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=mvjOND2ApiLBZ5HkMmn4ASh9dKzsjGLplLtXx8KCEQdQN3b9XJg7uSWvzSC8AGZ3sbH9BRJe6yoLqbkwf0GNZmIQMIcHurhZ8uMqU68VPmzKGZQy5F5XCUvSZay3MYL7kUXUFgAvnJO/qH0wKCcBtQUoL3v0/YHEAZyKdVaXAXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2p77taZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB988C4CEC7;
	Wed, 23 Oct 2024 16:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729702572;
	bh=9FQMpnUuD/q0UYsx9FcXZS3U5Eb/ILV6G0JOybEs5S8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J2p77taZ93Bj9iJwzNRpltWv0zl/EBXHjf+PlYgBMw56Ebj7DP8CSXCAZ8P55Prr0
	 9yrZBrOzCZPk3bL8bbgKhSRN3fO6Q4e9i1Ho+hWj6aUm8MS4ffPD3UQVuNfdXYtPeX
	 W47So/g4KxFjXNtT01nIJ4uJEWejQ3695DQjtD0ome742uZ5ZDZIPDvngYUxHfppZu
	 039vvSD+JWkb3nvQHR3CEBaUDM0X5s1+blJhk701dWiU3Ib41Y+ZmFnIblvU8jmQxH
	 wyyGUm47aKBG3nXkpBtqTaIW1ae54tCAFqkraFeCEdkrVMIy/LVi0qnfSaCe5xVbZA
	 v4H29uYZpnqGw==
From: Andrii Nakryiko <andrii@kernel.org>
To: asmadeus@codewreck.org
Cc: ericvh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com,
	pedro.falcato@gmail.com,
	regressions@leemhuis.info,
	torvalds@linux-foundation.org,
	v9fs@lists.linux.dev,
	bpf@vger.kernel.org
Subject: Re: [GIT PULL] 9p fixes for 6.12-rc4
Date: Wed, 23 Oct 2024 09:56:06 -0700
Message-ID: <20241023165606.3051029-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <ZxL0kMXLDng3Kw_V@codewreck.org>
References: <ZxL0kMXLDng3Kw_V@codewreck.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

> The following changes since commit 98f7e32f20d28ec452afb208f9cffc08448a2652:
>
>   Linux 6.11 (2024-09-15 16:57:56 +0200)
>
> are available in the Git repository at:
> 
>   https://github.com/martinetd/linux tags/9p-for-6.12-rc4
> 
> for you to fetch changes up to 79efebae4afc2221fa814c3cae001bede66ab259:
>
>   9p: Avoid creating multiple slab caches with the same name (2024-09-23 05:51:27 +0900)
>
> ----------------------------------------------------------------
> Mashed-up update that I sat on too long:
> 
> - fix for multiple slabs created with the same name
> - enable multipage folios
> - theorical fix to also look for opened fids by inode if none
> was found by dentry
> 
> ----------------------------------------------------------------
> David Howells (1):
>      9p: Enable multipage folios

Are there any known implications of this change on madvise()'s MADV_PAGEOUT
behavior? After most recent pull from Linus's tree, one of BPF selftests
started failing. Bisection points to:

  9197b73fd7bb ("Merge tag '9p-for-6.12-rc4' of https://github.com/martinetd/linux")

... which is just an empty merge commit. So the "9p: Enable multipage folios"
by itself doesn't cause any regression, but when merged with the rest of the
code it does. I confirmed by reverting
1325e4a91a40 ("9p: Enable multipage folios"), after which the test in question
is succeeding again.

The test in question itself is a bit involved, but what it ultimately tries to
do is to ensure that part of ELF file containing build ID is paged out to cause
BPF helper to fail to retrieve said build ID (due to non-faulable context).

For that, we use the following sequence in target binary and process:

madvise(addr, page_sz, MADV_POPULATE_READ);
madvise(addr, page_sz, MADV_PAGEOUT);

First making sure page is paged in, then paged out. We make sure that build ID
is memory mapped in a separate segment with its own single-page memory mapping.
No changes or regressions there. No huge pages seem to be involved.

It used to work reliably, now it doesn't work. Any clue why or what should we
do differently to make sure that memory page with build ID information is not
paged in (reliably)?

Thanks!

P.S. The target binary and madvise() manipulations are at:

  tools/testing/selftests/bpf/uprobe_multi.c, see trigger_uprobe()

The test itself in BPF selftest is at:

  tools/testing/selftests/bpf/prog_tests/build_id.c, see subtest_nofault(),
  build_id_resident is false in this case.

>
> Dominique Martinet (1):
>       9p: v9fs_fid_find: also lookup by inode if not found dentry
> 
> Pedro Falcato (1):
>       9p: Avoid creating multiple slab caches with the same name
> 
>  fs/9p/fid.c       |  5 ++---
>  fs/9p/vfs_inode.c |  1 +
>  net/9p/client.c   | 10 +++++++++-
>  3 files changed, 12 insertions(+), 4 deletions(-)
> 
> -- 
> Dominique Martinet | Asmadeus

