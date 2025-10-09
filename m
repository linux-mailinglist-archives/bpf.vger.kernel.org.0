Return-Path: <bpf+bounces-70673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB61BC9EF8
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 18:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EC6C2354676
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 16:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C3A2ED15A;
	Thu,  9 Oct 2025 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfOhxeha"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA3321FF4D;
	Thu,  9 Oct 2025 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025510; cv=none; b=mVbqTozcYD65tAXbANcbcR+bxDGM92HkIPo+M9lnH9791A2y1/NcUgrxGgBVgSL8LXQCaTQAcnY2W+sDQn9newKwb44yUrXWXJpUYIOAW+dUbYftA0Pkdzt5Zv2hcbLuX7oT4+VU+W/r6XgyoE9P9E/2/vc/pa2pCzaxU+k5UyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025510; c=relaxed/simple;
	bh=mUN5N/B1CSvDp7aGuj6QjGRBzzB6ttHKUVwLowOXa9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rdVBMjmBBQaMWt1cGlXfCb+Weq9WHJa2QKusWyFIK6GHDHaGFAYBT9ep+4UkUWaROXzUIPSIiUlQ6E0+VEoTS+g/RNhxZAxm0VTB98e4jrtu8C2CUxlpcqBP+O+zpSox8GWg61B5te/R5yoySUHIu1cnRKVa9AO1g+CZsTAMt6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfOhxeha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CDDC4CEF7;
	Thu,  9 Oct 2025 15:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025510;
	bh=mUN5N/B1CSvDp7aGuj6QjGRBzzB6ttHKUVwLowOXa9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bfOhxehaeJjLwuAK/zulOjjvopJwxxbLQLaMmBENsyjMzCi+QWQCqmNak/42sytAu
	 Cf07QpVxCPQA2sue0mVlqgjf19/WDU9kF//Djfm+z1FeGDYIjPTmAI1iveM4W4Xrbt
	 pBx/o7b/rMyNILKl0XnOwm4p3DjzPYmsHnz3BM+0jYqLWOH4/ADh03HFudNc/04PoZ
	 Y6N36MePzTYbzck6r2Efx96N2moEKPiZSBDo9RYnIjMQ3ZW2da9XCSA4C/es+Cvar6
	 4UpAlvsZjlKUge4E8bX+GrrOybYOln8gejQPdEJQ/skVAExqaJjumDROM4x6rB9fG6
	 Ix+jspuaslcEQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	martin.lau@kernel.org,
	jiapeng.chong@linux.alibaba.com,
	ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.16] selftests/bpf: Fix incorrect array size calculation
Date: Thu,  9 Oct 2025 11:54:48 -0400
Message-ID: <20251009155752.773732-22-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155752.773732-1-sashal@kernel.org>
References: <20251009155752.773732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jiayuan Chen <jiayuan.chen@linux.dev>

[ Upstream commit f85981327a90c51e76f60e073cb6648b2f167226 ]

The loop in bench_sockmap_prog_destroy() has two issues:

1. Using 'sizeof(ctx.fds)' as the loop bound results in the number of
   bytes, not the number of file descriptors, causing the loop to iterate
   far more times than intended.

2. The condition 'ctx.fds[0] > 0' incorrectly checks only the first fd for
   all iterations, potentially leaving file descriptors unclosed. Change
   it to 'ctx.fds[i] > 0' to check each fd properly.

These fixes ensure correct cleanup of all file descriptors when the
benchmark exits.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20250909124721.191555-1-jiayuan.chen@linux.dev

Closes: https://lore.kernel.org/bpf/aLqfWuRR9R_KTe5e@stanley.mountain/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES
- `tools/testing/selftests/bpf/benchs/bench_sockmap.c:13` now pulls in
  `bpf_util.h`, matching the pattern already used by other BPF bench
  tests so the new `ARRAY_SIZE()` usage compiles on every branch that
  carries this benchmark (introduced in `7b2fa44de5e71`, tagged around
  v6.16-rc1).
- `tools/testing/selftests/bpf/benchs/bench_sockmap.c:129` replaces the
  byte-counted `sizeof(ctx.fds)` loop bound with `ARRAY_SIZE(ctx.fds)`,
  stopping the loop after the five real descriptors instead of wandering
  into the struct’s counters and repeatedly closing fd 0 or large
  garbage values. That out-of-bounds iteration currently kills the
  test’s own stdin and can hand later socket allocations fd 0, so the
  cleanup path leaks every other socket.
- `tools/testing/selftests/bpf/benchs/bench_sockmap.c:130` now checks
  `ctx.fds[i] > 0` per element instead of reusing `ctx.fds[0]`, which
  fixes real leak scenarios when the first slot is zero (either after
  the stray `close(0)` above or when `create_pair()` fails before
  assigning `c1` but other sockets were opened).
- Fix stays confined to the selftest helper and mirrors existing bench
  code practices, so regression risk is negligible while restoring
  reliable cleanup for the new sockmap benchmark—exactly the sort of
  correctness fix stable trees keep so their shipped selftests actually
  work.

Natural next step: queue this for the stable branches that already
picked up `bench_sockmap.c` (v6.16+).

 tools/testing/selftests/bpf/benchs/bench_sockmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_sockmap.c b/tools/testing/selftests/bpf/benchs/bench_sockmap.c
index 8ebf563a67a2b..cfc072aa7fff7 100644
--- a/tools/testing/selftests/bpf/benchs/bench_sockmap.c
+++ b/tools/testing/selftests/bpf/benchs/bench_sockmap.c
@@ -10,6 +10,7 @@
 #include <argp.h>
 #include "bench.h"
 #include "bench_sockmap_prog.skel.h"
+#include "bpf_util.h"
 
 #define FILE_SIZE (128 * 1024)
 #define DATA_REPEAT_SIZE 10
@@ -124,8 +125,8 @@ static void bench_sockmap_prog_destroy(void)
 {
 	int i;
 
-	for (i = 0; i < sizeof(ctx.fds); i++) {
-		if (ctx.fds[0] > 0)
+	for (i = 0; i < ARRAY_SIZE(ctx.fds); i++) {
+		if (ctx.fds[i] > 0)
 			close(ctx.fds[i]);
 	}
 
-- 
2.51.0


