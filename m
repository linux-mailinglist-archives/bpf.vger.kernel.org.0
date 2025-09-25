Return-Path: <bpf+bounces-69696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA6BB9EA28
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 12:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C964420963
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 10:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C06A2EB5B1;
	Thu, 25 Sep 2025 10:26:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB8A2EACFB;
	Thu, 25 Sep 2025 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796017; cv=none; b=hRHwl/a6dxpohykrXAhLc+dX2ctXVycmMrQjTP7mhlBUTKh6kNEIAhuhhVPyLFrDYjja/RA3HkYy61EGa2gfBzFtEAqO73RNpEaFnpIfD52gUQxrMBjQhJJsOBtOVU1OIcMmfE8n6J9F5Min32z+k900zMXDHRU5LM9pBkmW8Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796017; c=relaxed/simple;
	bh=a3IPmV5jlnePssZURERzGDN5YmfphWeM3ATbsnwKAQg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QtjMkboJNUGxJfswVfvByum/4WohfZv5mWVUvlPFQ0KyqLEOlXw/hWDorRZkD0FJ2RniDF1w6oSiCNLYRzZ6xIp4Cmflz4JzG6hWLVHJr9gqaUQqWv0EtCcxGGQwJreZM5tQxh+FPY3iC8ynIv9HD3ya50vSVEwxwRsrKDpGIe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49D301E5E;
	Thu, 25 Sep 2025 03:26:46 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D67AC3F694;
	Thu, 25 Sep 2025 03:26:50 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 25 Sep 2025 11:26:29 +0100
Subject: [PATCH 5/8] perf test coresight: Dismiss clang warning for thread
 loop
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-perf_build_android_ndk-v1-5-8b35aadde3dc@arm.com>
References: <20250925-perf_build_android_ndk-v1-0-8b35aadde3dc@arm.com>
In-Reply-To: <20250925-perf_build_android_ndk-v1-0-8b35aadde3dc@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Quentin Monnet <qmo@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 llvm@lists.linux.dev, bpf@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758795991; l=2703;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=a3IPmV5jlnePssZURERzGDN5YmfphWeM3ATbsnwKAQg=;
 b=nUhuDSkMrBlnNCBDLmMmvLHq8n8o8Gue5GV4rlCFtxC79zv/N/9PRB8pDjgRUeODCBPDWOYKJ
 m0+Tyux1ImmBCJKyav4UeclDc+OZcoAO9WrqqZN4hS/q0FCpgEVnocx
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

clang-18.1.3 on Ubuntu 24.04.2 reports warning:

  thread_loop.c:41:23: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
     41 |                 : /* in */ [i] "r" (i), [len] "r" (len)
        |                                     ^
  thread_loop.c:37:8: note: use constraint modifier "w"
     37 |                 "add %[i], %[i], #1\n"
        |                      ^~~~
        |                      %w[i]
  thread_loop.c:41:23: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
     41 |                 : /* in */ [i] "r" (i), [len] "r" (len)
        |                                     ^
  thread_loop.c:37:14: note: use constraint modifier "w"
     37 |                 "add %[i], %[i], #1\n"
        |                            ^~~~
        |                            %w[i]
  thread_loop.c:41:23: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
     41 |                 : /* in */ [i] "r" (i), [len] "r" (len)
        |                                     ^
  thread_loop.c:38:8: note: use constraint modifier "w"
     38 |                 "cmp %[i], %[len]\n"
        |                      ^~~~
        |                      %w[i]
  thread_loop.c:41:38: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
     41 |                 : /* in */ [i] "r" (i), [len] "r" (len)
        |                                                    ^
  thread_loop.c:38:14: note: use constraint modifier "w"
     38 |                 "cmp %[i], %[len]\n"
        |                            ^~~~~~
        |                            %w[len]

Use the modifier "w" for 32-bit register access.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/tests/shell/coresight/thread_loop/thread_loop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/coresight/thread_loop/thread_loop.c b/tools/perf/tests/shell/coresight/thread_loop/thread_loop.c
index e05a559253ca9d9366ad321d520349042fb07fca..86f3f548b00631682767665fc5e9d5b8551a3634 100644
--- a/tools/perf/tests/shell/coresight/thread_loop/thread_loop.c
+++ b/tools/perf/tests/shell/coresight/thread_loop/thread_loop.c
@@ -34,8 +34,8 @@ static void *thrfn(void *arg)
 	}
 	asm volatile(
 		"loop:\n"
-		"add %[i], %[i], #1\n"
-		"cmp %[i], %[len]\n"
+		"add %w[i], %w[i], #1\n"
+		"cmp %w[i], %w[len]\n"
 		"blt loop\n"
 		: /* out */
 		: /* in */ [i] "r" (i), [len] "r" (len)

-- 
2.34.1


