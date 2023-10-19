Return-Path: <bpf+bounces-12751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2815C7D0397
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 23:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C89AF2822C7
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 21:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9447239861;
	Thu, 19 Oct 2023 21:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQy4c/qS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCC73550A;
	Thu, 19 Oct 2023 21:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1613BC433C8;
	Thu, 19 Oct 2023 21:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697750261;
	bh=UbRSZc6crtgCeY0MRdsWT/KJ2XCs7EiHnMiSLAyYy50=;
	h=Date:From:To:Cc:Subject:From;
	b=DQy4c/qS73NJUZKGInjpVlY45mpKWBWu/lp8LDxM6/JBOKM4vAt/1U6wu2d7ez6Z/
	 +9Bwgeju4qEt/0xwW4HpV2yAvEBSkzRXDB/88sj3lI+f3gF/KMq1qwI0rwzrA8oxBp
	 Aic3meb9N7VfTpGj4Fe3mMgttZLbbziRTBBDz/2VgWjadletAP0KNkgtk/sq3MIQub
	 k+IfR4NOoUAUvOdbZVfPYp2DxEDUpZ3j5WBOzwpPTdmz09UXQjtae2AQaRKvxSkKyQ
	 T6pilfQW4bPVhntuHZV1Kta/jSMEnoWNjOY0cb5QKFTF2TMTaW/rxu7epJXMbb3yEh
	 i5IgmlP5tz0Aw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 976C140016; Thu, 19 Oct 2023 18:17:37 -0300 (-03)
Date: Thu, 19 Oct 2023 18:17:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org, Manu Bretelle <chantr4@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Carsten Haitzler <carsten.haitzler@arm.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Fangrui Song <maskray@google.com>, He Kuang <hekuang@huawei.com>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
	llvm@lists.linux.dev, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Quentin Monnet <quentin@isovalent.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Rob Herring <robh@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>,
	Tom Rix <trix@redhat.com>, Wang Nan <wangnan0@huawei.com>,
	Wang ShaoBo <bobo.shaobowang@huawei.com>,
	Yang Jihong <yangjihong1@huawei.com>, Yonghong Song <yhs@fb.com>,
	YueHaibing <yuehaibing@huawei.com>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 1/1] tools build: Fix llvm feature detection, still used by
 bpftool
Message-ID: <ZTGc8S293uaTqHja@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When removing the BPF event for perf a feature test that checks if the
llvm devel files are availabe was removed but that is also used by
bpftool.

bpftool uses it to decide what kind of disassembly it will use: llvm or
binutils based.

Removing the tools/build/feature/test-llvm.cpp file made bpftool to
always fallback to binutils disassembly, even with the llvm devel files
installed, fix it by restoring just that small test-llvm.cpp test file.

Fixes: 56b11a2126bf2f42 ("perf bpf: Remove support for embedding clang for compiling BPF events (-e foo.c)")
Reported-by: Manu Bretelle <chantr4@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Carsten Haitzler <carsten.haitzler@arm.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Fangrui Song <maskray@google.com>
Cc: He Kuang <hekuang@huawei.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: llvm@lists.linux.dev
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Monnet <quentin@isovalent.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Tom Rix <trix@redhat.com>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc: Yang Jihong <yangjihong1@huawei.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/lkml/ZTGa0Ukt7QyxWcVy@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/test-llvm.cpp | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 tools/build/feature/test-llvm.cpp

diff --git a/tools/build/feature/test-llvm.cpp b/tools/build/feature/test-llvm.cpp
new file mode 100644
index 0000000000000000..88a3d1bdd9f6978e
--- /dev/null
+++ b/tools/build/feature/test-llvm.cpp
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "llvm/Support/ManagedStatic.h"
+#include "llvm/Support/raw_ostream.h"
+#define NUM_VERSION (((LLVM_VERSION_MAJOR) << 16) + (LLVM_VERSION_MINOR << 8) + LLVM_VERSION_PATCH)
+
+#if NUM_VERSION < 0x030900
+# error "LLVM version too low"
+#endif
+int main()
+{
+	llvm::errs() << "Hello World!\n";
+	llvm::llvm_shutdown();
+	return 0;
+}
-- 
2.41.0


