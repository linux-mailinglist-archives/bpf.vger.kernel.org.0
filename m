Return-Path: <bpf+bounces-69697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6646FB9EA2C
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 12:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2278B4C55EB
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 10:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC30D2ED15D;
	Thu, 25 Sep 2025 10:27:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20712ECEA5;
	Thu, 25 Sep 2025 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796020; cv=none; b=XXXKcGjziBUJEj2ELEVAdvmjSLlF8n5bWgMttOaWJ16fsosljfl0YYjkj81POWrpCwSPxlipqIxtpTYXgBccPO9Wsv/9eAxE+ON2wX2NIW+dPqhJaCQSLzajJVrVuevQauqouec5nO9dLkrAy0WWWwyazUSblqrW6IzoRY3Rbzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796020; c=relaxed/simple;
	bh=6JaO7UUmiEVn7pKrHNGJDEz9BYZJxL1KrwbjcRDT7O4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xu691AurdfKnp/0i2A9s340W6p3wyVLQhzxwnrkCETHtWrOtoCVt2eW1AjorGScQgn7wQG3PWOAaEdrGPXeZgf0Y9u3nDx07WeK7UgURGNjp63Gh9HTJtus/2Km+1Z18KYtiGU16HCxEm961sivdBHGrNdzp6rKrcJuHTW+PbhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 184692934;
	Thu, 25 Sep 2025 03:26:50 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7AC73F694;
	Thu, 25 Sep 2025 03:26:54 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 25 Sep 2025 11:26:30 +0100
Subject: [PATCH 6/8] perf test coresight: Dismiss clang warning for unroll
 loop thread
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-perf_build_android_ndk-v1-6-8b35aadde3dc@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758795991; l=1677;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=6JaO7UUmiEVn7pKrHNGJDEz9BYZJxL1KrwbjcRDT7O4=;
 b=bdEAG5XlwLci4V9cBjKYqYJa6glCIWeBSC5wF1POAcnDjpTV2J8Li6biCciADkgXA8D7NTzRR
 BPXM2iXxKhFCaAV//YpXgSMFEvr+zYpW9fj7k8m4W6K7Kozj8D5yYLx
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

clang-18.1.3 on Ubuntu 24.04.2 reports warning:

  unroll_loop_thread.c:35:25: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
     35 |                         : /* in */ [in] "r" (in)
        |                                              ^
  unroll_loop_thread.c:39:1: warning: non-void function does not return a value [-Wreturn-type]
     39 | }
        | ^

Use the modifier "w" for 32-bit register access and return NULL at the
end of thread function.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 .../tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c     | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c b/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c
index 0fc7bf1a25af3607b40f091f62176134ddb7f9f6..8f4e1c985ca38ab545a05189432a14a6d888d34c 100644
--- a/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c
+++ b/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c
@@ -20,7 +20,7 @@ static void *thrfn(void *arg)
 	for (i = 0; i < 10000; i++) {
 		asm volatile (
 // force an unroll of thia add instruction so we can test long runs of code
-#define SNIP1 "add %[in], %[in], #1\n"
+#define SNIP1 "add %w[in], %w[in], #1\n"
 // 10
 #define SNIP2 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1
 // 100
@@ -36,6 +36,8 @@ static void *thrfn(void *arg)
 			: /* clobber */
 		);
 	}
+
+	return NULL;
 }
 
 static pthread_t new_thr(void *(*fn) (void *arg), void *arg)

-- 
2.34.1


