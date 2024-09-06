Return-Path: <bpf+bounces-39099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AD396E901
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 07:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E5BB229EB
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 05:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A97877112;
	Fri,  6 Sep 2024 05:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVGFLIE4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7BA54FB5;
	Fri,  6 Sep 2024 05:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725599535; cv=none; b=D/TeG35J4KcgV3NRTuhVkwxY8kotVsV0gaAf8wuXfHZv0ozTzxeDhSiGzjpqEFCBOd8VT/VJMb4OGZTc5dLsxgzC3F4P1nNW37o/7Yeg/+7LM8SpNVs8WR/9i95+cjZsHVHdX0SbXdLNbp0s3QbDmAU8DLqfkhrnAuz8ARGC6Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725599535; c=relaxed/simple;
	bh=LZZWxcMxT163bv4rhTf6ukqGVdnUPsJwkRVsmldznFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cFggNstBGGS3mvNT5e5QRdY0Pu+P8FicLMqq9IHMmaDBKUDfcVVER7Cu0rH6DE7Tf5qG97jOAFABb7KUObSQ9KoqELUzy2EKdKYDq32bhKS2fESp/3GH7X8xkmIiKqSnQ4YMoFJTU7A4nXt3kif9OuBUf5pTW2UkAhY0nnBzm14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVGFLIE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B52C4CEC6;
	Fri,  6 Sep 2024 05:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725599535;
	bh=LZZWxcMxT163bv4rhTf6ukqGVdnUPsJwkRVsmldznFU=;
	h=From:To:Cc:Subject:Date:From;
	b=KVGFLIE4NNT2z2HPWj+onSPv+4W63UgxRtZYbA9/4wN7mWEtPIA13IFFsE3Jap9wk
	 WCrU0CorabroVWe2HzB3NLQVzjguncFkU8SHgU1+l0ocQBpWPSuImDeYvAGnBM4WYA
	 LDMLONQuFvzccUpz2HaW2X8Stl+jobAQgBj/p1xBsew7qUAcYuKd33vl22hNKlVTMC
	 4waoFgvVHA7deDCOcHyDYkHIYFbNmuWze2OFKNU2Gkz39ymwuhd8V6zzxs7uwgWaP/
	 KX7ScbrpFyIVW588Q3aJPDkXqAZAuLJe6ja1PWZyXzasVH/zvC8ijRuF/9j5hlDb1i
	 0KBtC0zAegBfA==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	oleg@redhat.com
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	willy@infradead.org,
	surenb@google.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	mjguzik@gmail.com,
	brauner@kernel.org,
	jannh@google.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 0/2] uprobes,mm: speculative lockless VMA-to-uprobe lookup
Date: Thu,  5 Sep 2024 22:12:03 -0700
Message-ID: <20240906051205.530219-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement speculative (lockless) resolution of VMA to inode to uprobe,
bypassing the need to take mmap_lock for reads, if possible. Patch #1 by Suren
adds mm_struct helpers that help detect whether mm_struct were changed, which
is used by uprobe logic to validate that speculative results can be trusted
after all the lookup logic results in a valid uprobe instance.

I ran a few will-it-scale benchmarks to sanity check that patch #1 doesn't
introduce any noticeable regressions. Which it seems it doesn't.

Andrii Nakryiko (1):
  uprobes: add speculative lockless VMA-to-inode-to-uprobe resolution

Suren Baghdasaryan (1):
  mm: introduce mmap_lock_speculation_{start|end}

 include/linux/mm_types.h  |  3 +++
 include/linux/mmap_lock.h | 53 +++++++++++++++++++++++++++++++--------
 kernel/events/uprobes.c   | 51 +++++++++++++++++++++++++++++++++++++
 kernel/fork.c             |  3 ---
 4 files changed, 97 insertions(+), 13 deletions(-)

-- 
2.43.5


