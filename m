Return-Path: <bpf+bounces-69693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77802B9EA1F
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 12:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA80F7B3B61
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 10:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352972EAB84;
	Thu, 25 Sep 2025 10:26:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531E22EB85F;
	Thu, 25 Sep 2025 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796004; cv=none; b=PrVNnQcpW5TrYqXGHnJzkzEfKeMxkVCbEhjDgkcbFs+50bZTQSwmrEJIV00iTsEZsl/7gy3eUlMxQrfYFGtLFOCCk3z8ku9tharlFn2cjKIkqzDR4er+75waJV0hnuvKZlb8D5Oy4HL1cS+f4pP0yPbY2OTiqVJkKJe1i9ZBA6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796004; c=relaxed/simple;
	bh=H3wg4rcmLVUVzF6Navqmshn4de5zeGYk8fBYI7vbo5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rjbC0QeEaiKQPNoUFyzqZ1qDAso7H8qdzXZ0uzOHWR5Z7G+er6ChB/7z6JMbjT+Xj+wqVcjSAtsLWt3pTAJwdDzYlR0BixC2X/Mwmc7ayOw2QU+GvtIJMy+uMC401MDvxM9Jh5+iovMeCMjPTSj1xkZaDICvskZlkgOu89vWvh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0BCE2934;
	Thu, 25 Sep 2025 03:26:34 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C35C3F694;
	Thu, 25 Sep 2025 03:26:39 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 25 Sep 2025 11:26:26 +0100
Subject: [PATCH 2/8] perf python: split Clang options when invoking Popen
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-perf_build_android_ndk-v1-2-8b35aadde3dc@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758795991; l=2000;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=H3wg4rcmLVUVzF6Navqmshn4de5zeGYk8fBYI7vbo5o=;
 b=mivZ7IFeiPpzpIcuPit02dmW5nDXt0G4ItotnnkmhISWhuuBbHQKDGbS6h5R22myI5K3HQpqy
 o4FSTP4K3/wD6P7AsczSZeRjnP3d0kbFEiLoi0+edOWQs5xq9FNwAW2
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

When passing a list to subprocess.Popen, each element maps to one argv
token. Current code bundles multiple Clang flags into a single element,
something like:

  cmd = ['clang',
         '--target=x86_64-linux-gnu -fintegrated-as -Wno-cast-function-type-mismatch',
	 'test-hello.c']

So Clang only sees one long, invalid option instead of separate flags,
as a result, the script cannot capture any log via PIPE.

Fix this by using shlex.split() to separate the string so each option
becomes its own argv element. The fixed list will be:

  cmd = ['clang',
         '--target=x86_64-linux-gnu',
	 '-fintegrated-as',
	 '-Wno-cast-function-type-mismatch',
	 'test-hello.c']

Fixes: 09e6f9f98370 ("perf python: Fix splitting CC into compiler and options")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/setup.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index dd289d15acfd62ff058bbaed7e565bb958e3a3c8..9cae2c472f4ad4d9579e8528b8bb0152df6fe20e 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -1,6 +1,7 @@
 from os import getenv, path
 from subprocess import Popen, PIPE
 from re import sub
+import shlex
 
 cc = getenv("CC")
 assert cc, "Environment variable CC not set"
@@ -22,7 +23,9 @@ assert srctree, "Environment variable srctree, for the Linux sources, not set"
 src_feature_tests  = f'{srctree}/tools/build/feature'
 
 def clang_has_option(option):
-    cc_output = Popen([cc, cc_options + option, path.join(src_feature_tests, "test-hello.c") ], stderr=PIPE).stderr.readlines()
+    cmd = shlex.split(f"{cc} {cc_options} {option}")
+    cmd.append(path.join(src_feature_tests, "test-hello.c"))
+    cc_output = Popen(cmd, stderr=PIPE).stderr.readlines()
     return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o) or (b"unknown warning option" in o))] == [ ]
 
 if cc_is_clang:

-- 
2.34.1


