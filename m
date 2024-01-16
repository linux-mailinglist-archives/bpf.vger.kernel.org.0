Return-Path: <bpf+bounces-19638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6DC82F6C8
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 21:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2E91C24225
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 20:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976AB20DC5;
	Tue, 16 Jan 2024 19:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOPA56Lo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC415A117;
	Tue, 16 Jan 2024 19:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434375; cv=none; b=cAJ+b58BTWORvwHLUIjuykzauYBGMmjSXDuYkeGFUiDUpbec2AkH1cJ0o331q+1NpvFJR8SHe2SNdbado3xNy0aI1ZXUbsGkIl1pyOUZbkaAxbN9FGbFLN542mdPxOijwwj/E2l2+wBCVSta0DyTcuf0Z94Miac/0HdZsDl1+no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434375; c=relaxed/simple;
	bh=sYqHj/g/hGOcyRV/HzldY/1TW+mLt3VMGVd8gETUa0c=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=mb3IMPl3/IeQ4Xd70xYndAJc05u8Jd7dyR4j9PeRhnvLR2UiwwKkY6yhTaPFUOT/975z7o/RO69RksfrjOZSAMxtqy/zHLxcVCZ/nkS5dmGzULQpr7arvKuzViwZUaX3wjp9WDAYyyEk3jVX9hWw2nRB4DigPtJw+KRVVrrSGYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOPA56Lo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E3FC433B1;
	Tue, 16 Jan 2024 19:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434374;
	bh=sYqHj/g/hGOcyRV/HzldY/1TW+mLt3VMGVd8gETUa0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oOPA56Lo369S/HDQTNq6GfOPzsqBGte4G4CqNGmX9hR06ul0YRV10TxrHi3Rl9IP+
	 arMr0ZrwJE1h8Twc2gw9cqPwR2i98XLwtgmQOHiqSgUeR7UWKWoT0z/Zni9SzaPwAl
	 2YsFqswVE0VHd0o1EUp35bCZcilIpCRq7iVWQ2CU5EhGxuZS6CV6sPAkqMiEhMghZB
	 obFx6x3QMxN6JklJtlnXAlXqrtvPlpuAsJRjB3lZ18eh1V3kc2Uv04Re8y1fjPkshs
	 wDMY0oItQX67w37wzcvTlAtmkg4RxUEoa190l+bSJ7jsdmyx3mlvefcJ5PYslcOR9+
	 2/3COFuPD42Bg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 083/108] x86/cfi,bpf: Fix bpf_exception_cb() signature
Date: Tue, 16 Jan 2024 14:39:49 -0500
Message-ID: <20240116194225.250921-83-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <alexei.starovoitov@gmail.com>

[ Upstream commit 852486b35f344887786d63250946dd921a05d7e8 ]

As per the earlier patches, BPF sub-programs have bpf_callback_t
signature and CFI expects callers to have matching signature. This is
violated by bpf_prog_aux::bpf_exception_cb().

[peterz: Changelog]
Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/CAADnVQ+Z7UcXXBBhMubhcMM=R-dExk-uHtfOLtoLxQ1XxEpqEA@mail.gmail.com
Link: https://lore.kernel.org/r/20231215092707.910319166@infradead.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf.h  | 2 +-
 kernel/bpf/helpers.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 741af9e5cb9d..8ebaaab5fdb5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1442,7 +1442,7 @@ struct bpf_prog_aux {
 	int cgroup_atype; /* enum cgroup_bpf_attach_type */
 	struct bpf_map *cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE];
 	char name[BPF_OBJ_NAME_LEN];
-	unsigned int (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp);
+	u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64, u64);
 #ifdef CONFIG_SECURITY
 	void *security;
 #endif
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index f43038931935..666e452230ed 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2509,7 +2509,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	 * which skips compiler generated instrumentation to do the same.
 	 */
 	kasan_unpoison_task_stack_below((void *)(long)ctx.sp);
-	ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp);
+	ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp, 0, 0);
 	WARN(1, "A call to BPF exception callback should never return\n");
 }
 
-- 
2.43.0


