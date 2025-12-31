Return-Path: <bpf+bounces-77588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 642D0CEC115
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 15:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCC823014A12
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 14:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB3123E334;
	Wed, 31 Dec 2025 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnUpSf6N"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7B3239E7E
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767190480; cv=none; b=j7m1CGjysYMHMB4IihZoUx5Gcu/VW0HcgSo2XpDca0ojV2UWUjTo/kSjL9+mPRuMMHzV5S4NcrBrnjiiqaKz1p5lE5OADIuBTdGWG/N2YTcXJwctWDibUfF9+0AyFW01vZlvieukDNvxbLbQpINwyvwSbmU0BZ7HqY5H7tgya1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767190480; c=relaxed/simple;
	bh=pX8a16Xyxnwd09667g5i8D8Jk68h+Po6SvBUToVTuPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mLqNam4Gn+ITIC8MJzOBlJ29ljj52pgypj+1Wtb8yRK1IlzYoJ8jMnakpg3XEPQRM6oim2aTaGeIUSHusQzZd/xtzXDyEk/8r3es3cqI+3Z3da7lkOodOiYfLvUZK2TRia7NY/AVw6hVPWYKvmgoySUILC69pF7hTz/U/PjSzcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnUpSf6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FDDC113D0;
	Wed, 31 Dec 2025 14:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767190480;
	bh=pX8a16Xyxnwd09667g5i8D8Jk68h+Po6SvBUToVTuPk=;
	h=From:To:Cc:Subject:Date:From;
	b=qnUpSf6NSJ9QmGEjKT7EZxzaP0zUEM3BTOjIL/3n82Rd8xhzij0C/QQUwjR3zMoHI
	 OmeWE8KYcpc/wvdl/z/F3Z3kX8q4395eKhdBZu2TUD0aBJMra1RJt56guWIBzNbdsy
	 QoxVwcf54HG/Vtqwgr6FGEr0yT/jLlaE8Qgtgiv0MU6VoEEcBS68wzWm5x/rReK9+p
	 g5QMQtIH+rLEAHVaIbYkCUHVujvQezzTmpkGoXjS2E3j1xhGxfBCLZpKT3eEu6bgiJ
	 q4urteCp/GE+36A2fXwMKJBYbTcucHMPZtMZh18tu/Ba564UQkfzk2/HNzNEkbFeQv
	 unCN4O9L4RaMg==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/2] memcg accounting for BPF arena
Date: Wed, 31 Dec 2025 06:14:31 -0800
Message-ID: <20251231141434.3416822-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/all/20251230153006.1347742-1-puranjay@kernel.org/
Changes in v1->v2:
- Return both pointers through arguments from bpf_map_memcg_enter and
  make it return void. (Alexei)
- Add memcg accounting in arena_free_worker (AI)

This set adds memcg accounting logic into arena kfuncs and other places
that do allocations in arena.c.

Puranjay Mohan (2):
  bpf: syscall: Introduce memcg enter/exit helpers
  bpf: arena: Reintroduce memcg accounting

 include/linux/bpf.h     | 15 +++++++++++++
 kernel/bpf/arena.c      | 44 +++++++++++++++++++++++++++++++-----
 kernel/bpf/range_tree.c |  5 +++--
 kernel/bpf/syscall.c    | 50 +++++++++++++++++++++--------------------
 4 files changed, 83 insertions(+), 31 deletions(-)


base-commit: ccaa6d2c9635a8db06a494d67ef123b56b967a78
-- 
2.47.3


