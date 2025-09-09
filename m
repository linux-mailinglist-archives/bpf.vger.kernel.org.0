Return-Path: <bpf+bounces-67864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0EBB4FB9C
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 14:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295084E57E7
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 12:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ECE338F2F;
	Tue,  9 Sep 2025 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KG/sKjTM"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C154227380C
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 12:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757422070; cv=none; b=HS1VeKHZ0NagA7frUs2eOxuiwazxjz+nHn0bwstuI1kSPJQSxxgyRnbhzgTdYGRlrcJ2BFcf1cjZxzALd74XM62F+QYrsiOlc/QFcYfBVSu/7kc20hVy8LBETBpTEkA9dbKkFrnIdSgZO1JdH03bsVkO1XfY+4/MCWBOmDSqJUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757422070; c=relaxed/simple;
	bh=C/o3+QkdyajagqcWpvpUtf/kbpe5Cr0u7uLUZDwXD6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hfSWOtA6Q9HOMX42LStI5/CDmhDPBHJE0kgVqaElpUibtqONbONtZdh6qqFqw8xDmR4WXfJc3niKm+bc9rDsuwcLHGGJweFc8z+TJHq4hLqSwCzd2ratKOwFOZSLC6QuLNKdCBNMtriFQ1TQq+kYZjLBf3/s1rV8/9v0l8pgwJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KG/sKjTM; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757422056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Civ3v7++W+FLuwnLZNUaxx6xIkTNDQTvDlA6SdwcjAQ=;
	b=KG/sKjTMufw82dzqQfGVZtHmIKPFQHjuko4gDGm2VJ8PiUkf/cdXrcsWVNTTRI0/e158e7
	vA1IZjtT5F2Ib8aSgAXpjckrO5n7N9Cp53SXyOkPTcvGNW3IavPzg4XB68O7GjhVMY0lAs
	jNytsDhuBxLvL89RZdlSy706tA7kG78=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: jiayuan.chen@linux.dev
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2] selftests/bpf: Fix incorrect array size calculation
Date: Tue,  9 Sep 2025 20:47:04 +0800
Message-ID: <20250909124721.191555-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The loop in bench_sockmap_prog_destroy() has two issues:

1. Using 'sizeof(ctx.fds)' as the loop bound results in the number of
   bytes, not the number of file descriptors, causing the loop to iterate
   far more times than intended.

2. The condition 'ctx.fds[0] > 0' incorrectly checks only the first fd for
   all iterations, potentially leaving file descriptors unclosed. Change
   it to 'ctx.fds[i] > 0' to check each fd properly.

These fixes ensure correct cleanup of all file descriptors when the
benchmark exits.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/bpf/aLqfWuRR9R_KTe5e@stanley.mountain/
---
 tools/testing/selftests/bpf/benchs/bench_sockmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_sockmap.c b/tools/testing/selftests/bpf/benchs/bench_sockmap.c
index 8ebf563a67a2..cfc072aa7fff 100644
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
2.43.0


