Return-Path: <bpf+bounces-61269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E6BAE394D
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 11:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175543B7C47
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 09:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F88238C1D;
	Mon, 23 Jun 2025 09:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HT0fo/NU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A29231845
	for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 09:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669236; cv=none; b=lJXnOmSImV75HQ9gONaSfjhj7XleKFHSUZa5A/YivT1A4IeSf3P154NqK6DPMlw5AJnPx8AEHPz4ipow5seZzqVxO/PbG8F0TFUBP9S3r7icmoK3I60QWkbUldCYcYijRAHGGO0b3ksLnvx2b5RtdEN3s1E5RPajc6RvsnHex5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669236; c=relaxed/simple;
	bh=sKEyaUZmUkObwo5iwjKAMuOhw4ilxlNF2nGwyekACr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q1jvfW7aHWzdp48XYjMIxPrSpBiLJO0807QBT61JLRtt/S6Gh1VzX5fGW0U9fwv63ySgy7z3Sk09aMYr19Lh9bGsXubrv4mWp5UwZVh0YP+zls0aMSpQe3wRnaJvTa067kBF6AwjRCiSnskpXu3WpeX2Cvu83guQhTf0UW5+aIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HT0fo/NU; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so2906225f8f.0
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 02:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750669232; x=1751274032; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=siFLzwIAOMTOqClC7suVWWbB5nxNFCIXsyRndF3ikEw=;
        b=HT0fo/NUa/AeU5BYVJseXGqlmwT+SqH+G9mc7fygCnu2lY4JEeN+B48DelE/maltbU
         fLMHMlcF7aB+noJkcSH+uSviCUbAvIRmAtRaJEDYRhna8kvUZdV8Z9hQrZQtxtn+piX/
         9Bfl+gpG33jqIk19EPqSyewsT+8T5hx2WPTW63Fjixg3MuubZwfyhz96/P6xYXHGUHZQ
         JDFO5O7r2SIGv219NH5E0rTBM5tRZUFQjHFqPT6XrtLa+S3zjcq+q32Rlh2HY45k1gmj
         j9K7qawSK+cF2IXuY1puzB50zhP4uBG5YoJi96QAI8qK/LZ3rYP4FPgd43/sg179sP8n
         UJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750669232; x=1751274032;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=siFLzwIAOMTOqClC7suVWWbB5nxNFCIXsyRndF3ikEw=;
        b=eyIfj/msVpYh+8sXPDtTDQG/hyPreLb2HjAPNtRYhpvAxluDzbfWtPzhoJgmQ8PtgE
         8FWqn7ci8bZzuPBeu7OkhSBi3tzjHhsNi1LEbRABK09M9xVvepZ8L6VXvvLC1L/tBnWF
         awoKw8DUec1phyCzCoWBsW1DwMYy0UOJVumWdzqTaUroO2UXnQK04po3STEMUUMSF/0k
         PVh3aYVS0i+gdB3C2gIekY0/2tcXTldgnS/eK7ZJZQ0NmD9S5ZKJAyXJExWZ20sFNFMU
         QfFkNsPsVfW8WZVWhXWGYVBbRvX37HS+3hq/2g+VDPOY1J2KFkRmJgdX/VMSXJ9CAnOP
         Cx1g==
X-Forwarded-Encrypted: i=1; AJvYcCVpxW8E7LQMOzouoxm/bzup3R5uJTQw69GNXlxKBTb5RLCb/68CHweXEnslun+IxA0UpC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGfdkYChi1600wh1yz3ZcLB9r9vj6q/BjssSwbJtuIdaZ1Pjbt
	esWq2RODklIolYx59drNQba/t1Ae9gecUjaq6KJJEKiMkY1shzrMFqrTHDKV+e6CSOk=
X-Gm-Gg: ASbGnct2gb675IPJfKsYO/pB/lEx2hK/Y4ENhBiWT3tylZPet27SIPOhh3HlZZODVjb
	AgJTq4/APaeWmFFVK7abySkMYBxRFKnzA/P7YjHVwfK9/fUsu0zqB3p/Li8mW98ObCcTZafRr6y
	avGwU3TYnYHnv1W/EMF8AiAslwN6dJmHbIGDC23FJjE7OJGD4Wfeol20S5n9YgSbXtC+iB/v6wi
	tIV7k6RxKFfbG0VEuRP5F967Qyb6ZNtymHrViavEgeLd+T3GYFWnk+Q8yHo6Z9j3KIoOm8VNJ7h
	wQarpfAZL8XWaSPCvgc1V5NqUtxXFPfRGJNFnryla54yNg1o7814JnCujVg64bvvTy+/DGA=
X-Google-Smtp-Source: AGHT+IGkyqpAd4PKjweiZIrNYoNuQtSQVAILSe9BTXOL6u/AcWrW0AzZFAdpnr/1NYC99Pz/ubfMDw==
X-Received: by 2002:a05:6000:26c8:b0:3a5:8977:e0f8 with SMTP id ffacd0b85a97d-3a6d27e16f5mr9070564f8f.19.1750669231601;
        Mon, 23 Jun 2025 02:00:31 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f104d4sm9040043f8f.11.2025.06.23.02.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 02:00:31 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 23 Jun 2025 10:00:12 +0100
Subject: [PATCH] perf test: Change all remaining #!/bin/sh to #!/bin/bash
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-james-perf-bash-tests-v1-1-f572f54d4559@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJsXWWgC/x3M3QpAQBBA4VfRXJtiWDavIheLwSg/7WxS8u42l
 9/FOQ8oe2GFJnnA8yUqxx6RpwkMi9tnRhmjgTIyWUUFrm5jxZP9hL3TBQNrULSWqtzZsjaGILa
 n50nu/9t27/sBbwDWF2cAAAA=
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, Nick Terrell <terrelln@fb.com>, 
 David Sterba <dsterba@suse.com>, Collin Funk <collin.funk1@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 bpf@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

There are 43 instances of posix shell tests and 35 instances of bash. To
give us a single consistent language for testing in, replace
all #!/bin/sh to #!/bin/bash. Common sources that are included in both
different shells will now work as expected. And we no longer have to fix
up bashisms that appear to work when someone's system has sh symlinked
to bash, but don't work on other systems that have both shells
installed.

Although we could have chosen sh, it's not backwards compatible so it
wouldn't be possible to bulk convert without re-writing the existing
bash tests.

Choosing bash also gives us some nicer features including 'local'
variable definitions and regexes in if statements that are already
widely used in the tests.

It's not expected that there are any users with only sh available due to
the large number of bash tests that exist.

Discussed in relation to running shellcheck here:
https://lore.kernel.org/linux-perf-users/e3751a74be34bbf3781c4644f518702a7270220b.1749785642.git.collin.funk1@gmail.com/

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/perf-targz-src-pkg                          | 2 +-
 tools/perf/tests/shell/amd-ibs-swfilt.sh                     | 2 +-
 tools/perf/tests/shell/buildid.sh                            | 2 +-
 tools/perf/tests/shell/coresight/asm_pure_loop.sh            | 2 +-
 tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh     | 2 +-
 tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh | 2 +-
 tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh  | 2 +-
 tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh    | 2 +-
 tools/perf/tests/shell/diff.sh                               | 2 +-
 tools/perf/tests/shell/ftrace.sh                             | 2 +-
 tools/perf/tests/shell/lib/perf_has_symbol.sh                | 2 +-
 tools/perf/tests/shell/lib/probe_vfs_getname.sh              | 2 +-
 tools/perf/tests/shell/lib/setup_python.sh                   | 2 +-
 tools/perf/tests/shell/lib/waiting.sh                        | 2 +-
 tools/perf/tests/shell/list.sh                               | 2 +-
 tools/perf/tests/shell/lock_contention.sh                    | 2 +-
 tools/perf/tests/shell/perf-report-hierarchy.sh              | 2 +-
 tools/perf/tests/shell/probe_vfs_getname.sh                  | 2 +-
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh        | 2 +-
 tools/perf/tests/shell/record+script_probe_vfs_getname.sh    | 2 +-
 tools/perf/tests/shell/record+zstd_comp_decomp.sh            | 2 +-
 tools/perf/tests/shell/record_bpf_filter.sh                  | 2 +-
 tools/perf/tests/shell/record_offcpu.sh                      | 2 +-
 tools/perf/tests/shell/record_sideband.sh                    | 2 +-
 tools/perf/tests/shell/script.sh                             | 2 +-
 tools/perf/tests/shell/stat+csv_summary.sh                   | 2 +-
 tools/perf/tests/shell/stat+shadow_stat.sh                   | 2 +-
 tools/perf/tests/shell/stat_all_pfm.sh                       | 2 +-
 tools/perf/tests/shell/stat_bpf_counters.sh                  | 2 +-
 tools/perf/tests/shell/stat_bpf_counters_cgrp.sh             | 2 +-
 tools/perf/tests/shell/test_arm_callgraph_fp.sh              | 2 +-
 tools/perf/tests/shell/test_arm_coresight.sh                 | 2 +-
 tools/perf/tests/shell/test_arm_coresight_disasm.sh          | 2 +-
 tools/perf/tests/shell/test_arm_spe.sh                       | 2 +-
 tools/perf/tests/shell/test_arm_spe_fork.sh                  | 2 +-
 tools/perf/tests/shell/test_bpf_metadata.sh                  | 2 +-
 tools/perf/tests/shell/test_intel_pt.sh                      | 2 +-
 tools/perf/tests/shell/trace+probe_vfs_getname.sh            | 2 +-
 tools/perf/tests/shell/trace_btf_enum.sh                     | 2 +-
 tools/perf/tests/shell/trace_exit_race.sh                    | 2 +-
 tools/perf/tests/shell/trace_record_replay.sh                | 2 +-
 tools/perf/tests/shell/trace_summary.sh                      | 2 +-
 tools/perf/tests/tests-scripts.c                             | 2 +-
 43 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/tools/perf/tests/perf-targz-src-pkg b/tools/perf/tests/perf-targz-src-pkg
index b3075c168cb2..52a90e6bd8af 100755
--- a/tools/perf/tests/perf-targz-src-pkg
+++ b/tools/perf/tests/perf-targz-src-pkg
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 # Test one of the main kernel Makefile targets to generate a perf sources tarball
 # suitable for build outside the full kernel sources.
diff --git a/tools/perf/tests/shell/amd-ibs-swfilt.sh b/tools/perf/tests/shell/amd-ibs-swfilt.sh
index 83937aa687cc..7045ec72ba4c 100755
--- a/tools/perf/tests/shell/amd-ibs-swfilt.sh
+++ b/tools/perf/tests/shell/amd-ibs-swfilt.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # AMD IBS software filtering
 
 echo "check availability of IBS swfilt"
diff --git a/tools/perf/tests/shell/buildid.sh b/tools/perf/tests/shell/buildid.sh
index 3383ca3399d4..d2eb213da01d 100755
--- a/tools/perf/tests/shell/buildid.sh
+++ b/tools/perf/tests/shell/buildid.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # build id cache operations
 # SPDX-License-Identifier: GPL-2.0
 
diff --git a/tools/perf/tests/shell/coresight/asm_pure_loop.sh b/tools/perf/tests/shell/coresight/asm_pure_loop.sh
index c63bc8c73e26..0301904b9637 100755
--- a/tools/perf/tests/shell/coresight/asm_pure_loop.sh
+++ b/tools/perf/tests/shell/coresight/asm_pure_loop.sh
@@ -1,4 +1,4 @@
-#!/bin/sh -e
+#!/bin/bash -e
 # CoreSight / ASM Pure Loop (exclusive)
 
 # SPDX-License-Identifier: GPL-2.0
diff --git a/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh b/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
index 8e29630957c8..1f765d69acc3 100755
--- a/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
+++ b/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
@@ -1,4 +1,4 @@
-#!/bin/sh -e
+#!/bin/bash -e
 # CoreSight / Memcpy 16k 10 Threads (exclusive)
 
 # SPDX-License-Identifier: GPL-2.0
diff --git a/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh b/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
index 0c4c82a1c8e1..7f43a93a2ac2 100755
--- a/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
+++ b/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
@@ -1,4 +1,4 @@
-#!/bin/sh -e
+#!/bin/bash -e
 # CoreSight / Thread Loop 10 Threads - Check TID (exclusive)
 
 # SPDX-License-Identifier: GPL-2.0
diff --git a/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh b/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
index d3aea9fc6ced..a94d2079ed06 100755
--- a/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
+++ b/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
@@ -1,4 +1,4 @@
-#!/bin/sh -e
+#!/bin/bash -e
 # CoreSight / Thread Loop 2 Threads - Check TID (exclusive)
 
 # SPDX-License-Identifier: GPL-2.0
diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh b/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
index 7429d3a2ae43..cb3e97a0a89f 100755
--- a/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
+++ b/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
@@ -1,4 +1,4 @@
-#!/bin/sh -e
+#!/bin/bash -e
 # CoreSight / Unroll Loop Thread 10 (exclusive)
 
 # SPDX-License-Identifier: GPL-2.0
diff --git a/tools/perf/tests/shell/diff.sh b/tools/perf/tests/shell/diff.sh
index e05a5dc49479..fe05fdebcab5 100755
--- a/tools/perf/tests/shell/diff.sh
+++ b/tools/perf/tests/shell/diff.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # perf diff tests
 # SPDX-License-Identifier: GPL-2.0
 
diff --git a/tools/perf/tests/shell/ftrace.sh b/tools/perf/tests/shell/ftrace.sh
index c243731d2fbf..7f8aafcbb761 100755
--- a/tools/perf/tests/shell/ftrace.sh
+++ b/tools/perf/tests/shell/ftrace.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # perf ftrace tests
 # SPDX-License-Identifier: GPL-2.0
 
diff --git a/tools/perf/tests/shell/lib/perf_has_symbol.sh b/tools/perf/tests/shell/lib/perf_has_symbol.sh
index 561c93b75d77..0b35cce0b13d 100644
--- a/tools/perf/tests/shell/lib/perf_has_symbol.sh
+++ b/tools/perf/tests/shell/lib/perf_has_symbol.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
 perf_has_symbol()
diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 58debce9ab42..88cd0e26d5f6 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
 perf probe -l 2>&1 | grep -q probe:vfs_getname
diff --git a/tools/perf/tests/shell/lib/setup_python.sh b/tools/perf/tests/shell/lib/setup_python.sh
index c2fce1793538..a58e5536f2ed 100644
--- a/tools/perf/tests/shell/lib/setup_python.sh
+++ b/tools/perf/tests/shell/lib/setup_python.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
 if [ "x$PYTHON" = "x" ]
diff --git a/tools/perf/tests/shell/lib/waiting.sh b/tools/perf/tests/shell/lib/waiting.sh
index bdd5a7c71591..3a152892e077 100644
--- a/tools/perf/tests/shell/lib/waiting.sh
+++ b/tools/perf/tests/shell/lib/waiting.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
 tenths=date\ +%s%1N
diff --git a/tools/perf/tests/shell/list.sh b/tools/perf/tests/shell/list.sh
index 76a9846cff22..0c04b3159cef 100755
--- a/tools/perf/tests/shell/list.sh
+++ b/tools/perf/tests/shell/list.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # perf list tests
 # SPDX-License-Identifier: GPL-2.0
 
diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
index 30d195d4c62f..dde5bc737eb2 100755
--- a/tools/perf/tests/shell/lock_contention.sh
+++ b/tools/perf/tests/shell/lock_contention.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # kernel lock contention analysis test
 # SPDX-License-Identifier: GPL-2.0
 
diff --git a/tools/perf/tests/shell/perf-report-hierarchy.sh b/tools/perf/tests/shell/perf-report-hierarchy.sh
index 02e3b6aee4ed..e3c6f9a24f33 100755
--- a/tools/perf/tests/shell/perf-report-hierarchy.sh
+++ b/tools/perf/tests/shell/perf-report-hierarchy.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # perf report --hierarchy
 # SPDX-License-Identifier: GPL-2.0
 # Arnaldo Carvalho de Melo <acme@redhat.com> 
diff --git a/tools/perf/tests/shell/probe_vfs_getname.sh b/tools/perf/tests/shell/probe_vfs_getname.sh
index 0f52654c914a..5fe5682c28ce 100755
--- a/tools/perf/tests/shell/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/probe_vfs_getname.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # Add vfs_getname probe to get syscall args filenames (exclusive)
 
 # SPDX-License-Identifier: GPL-2.0
diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index c4bab5b5cc59..cfad1bd7b780 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # probe libc's inet_pton & backtrace it with ping (exclusive)
 
 # Installs a probe on libc's inet_pton function, that will use uprobes,
diff --git a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
index 1ad252f0d36e..002f7037f182 100755
--- a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # Use vfs_getname probe to get syscall args filenames (exclusive)
 
 # Uses the 'perf test shell' library to add probe:vfs_getname to the system
diff --git a/tools/perf/tests/shell/record+zstd_comp_decomp.sh b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
index 8929046e9057..f6b82223834e 100755
--- a/tools/perf/tests/shell/record+zstd_comp_decomp.sh
+++ b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # Zstd perf.data compression/decompression
 
 # SPDX-License-Identifier: GPL-2.0
diff --git a/tools/perf/tests/shell/record_bpf_filter.sh b/tools/perf/tests/shell/record_bpf_filter.sh
index 4d6c3c1b7fb9..383574cb3bd3 100755
--- a/tools/perf/tests/shell/record_bpf_filter.sh
+++ b/tools/perf/tests/shell/record_bpf_filter.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # perf record sample filtering (by BPF) tests
 # SPDX-License-Identifier: GPL-2.0
 
diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index 21a22efe08f5..860a2d6f4b75 100755
--- a/tools/perf/tests/shell/record_offcpu.sh
+++ b/tools/perf/tests/shell/record_offcpu.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # perf record offcpu profiling tests (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
diff --git a/tools/perf/tests/shell/record_sideband.sh b/tools/perf/tests/shell/record_sideband.sh
index ac70ac27d590..2182551873be 100755
--- a/tools/perf/tests/shell/record_sideband.sh
+++ b/tools/perf/tests/shell/record_sideband.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # perf record sideband tests
 # SPDX-License-Identifier: GPL-2.0
 
diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/script.sh
index d3e2958d2242..7007f1cdf761 100755
--- a/tools/perf/tests/shell/script.sh
+++ b/tools/perf/tests/shell/script.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # perf script tests
 # SPDX-License-Identifier: GPL-2.0
 
diff --git a/tools/perf/tests/shell/stat+csv_summary.sh b/tools/perf/tests/shell/stat+csv_summary.sh
index 323123ff4d19..9a4353db3825 100755
--- a/tools/perf/tests/shell/stat+csv_summary.sh
+++ b/tools/perf/tests/shell/stat+csv_summary.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # perf stat csv summary test
 # SPDX-License-Identifier: GPL-2.0
 
diff --git a/tools/perf/tests/shell/stat+shadow_stat.sh b/tools/perf/tests/shell/stat+shadow_stat.sh
index 0c7d79a230ea..8824f445d343 100755
--- a/tools/perf/tests/shell/stat+shadow_stat.sh
+++ b/tools/perf/tests/shell/stat+shadow_stat.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # perf stat metrics (shadow stat) test
 # SPDX-License-Identifier: GPL-2.0
 
diff --git a/tools/perf/tests/shell/stat_all_pfm.sh b/tools/perf/tests/shell/stat_all_pfm.sh
index 4d004f777a6e..c08c186af2c4 100755
--- a/tools/perf/tests/shell/stat_all_pfm.sh
+++ b/tools/perf/tests/shell/stat_all_pfm.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # perf all libpfm4 events test
 # SPDX-License-Identifier: GPL-2.0
 
diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index 95d2ad5d17c6..f43e28a136d3 100755
--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # perf stat --bpf-counters test (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
diff --git a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
index 2ec69060c42f..ff2e06c408bc 100755
--- a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # perf stat --bpf-counters --for-each-cgroup test
 # SPDX-License-Identifier: GPL-2.0
 
diff --git a/tools/perf/tests/shell/test_arm_callgraph_fp.sh b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
index 9caa36130175..9172dd68a81d 100755
--- a/tools/perf/tests/shell/test_arm_callgraph_fp.sh
+++ b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # Check Arm64 callgraphs are complete in fp mode
 # SPDX-License-Identifier: GPL-2.0
 
diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index 573af9235b72..1c750b67d141 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # Check Arm CoreSight trace data recording and synthesized samples (exclusive)
 
 # Uses the 'perf record' to record trace data with Arm CoreSight sinks;
diff --git a/tools/perf/tests/shell/test_arm_coresight_disasm.sh b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
index be2d26303f94..0dfb4fadf531 100755
--- a/tools/perf/tests/shell/test_arm_coresight_disasm.sh
+++ b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # Check Arm CoreSight disassembly script completes without errors (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
diff --git a/tools/perf/tests/shell/test_arm_spe.sh b/tools/perf/tests/shell/test_arm_spe.sh
index a69aab70dd8a..bb76ea88aa14 100755
--- a/tools/perf/tests/shell/test_arm_spe.sh
+++ b/tools/perf/tests/shell/test_arm_spe.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # Check Arm SPE trace data recording and synthesized samples (exclusive)
 
 # Uses the 'perf record' to record trace data of Arm SPE events;
diff --git a/tools/perf/tests/shell/test_arm_spe_fork.sh b/tools/perf/tests/shell/test_arm_spe_fork.sh
index 8efeef9fb956..5bcca51c03ac 100755
--- a/tools/perf/tests/shell/test_arm_spe_fork.sh
+++ b/tools/perf/tests/shell/test_arm_spe_fork.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # Check Arm SPE doesn't hang when there are forks
 
 # SPDX-License-Identifier: GPL-2.0
diff --git a/tools/perf/tests/shell/test_bpf_metadata.sh b/tools/perf/tests/shell/test_bpf_metadata.sh
index 11df592fb661..bc9aef161664 100755
--- a/tools/perf/tests/shell/test_bpf_metadata.sh
+++ b/tools/perf/tests/shell/test_bpf_metadata.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 #
 # BPF metadata collection test.
diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index 32a9b8dcb200..8ee761f03c38 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # Miscellaneous Intel PT testing (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 5d5019988d61..7a0b1145d0cd 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # Check open filename arg using perf trace + vfs_getname (exclusive)
 
 # Uses the 'perf test shell' library to add probe:vfs_getname to the system
diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
index c37017bfeb5e..572001d75d78 100755
--- a/tools/perf/tests/shell/trace_btf_enum.sh
+++ b/tools/perf/tests/shell/trace_btf_enum.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # perf trace enum augmentation tests
 # SPDX-License-Identifier: GPL-2.0
 
diff --git a/tools/perf/tests/shell/trace_exit_race.sh b/tools/perf/tests/shell/trace_exit_race.sh
index 1e247693e756..db300cde94fb 100755
--- a/tools/perf/tests/shell/trace_exit_race.sh
+++ b/tools/perf/tests/shell/trace_exit_race.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # perf trace exit race
 # SPDX-License-Identifier: GPL-2.0
 
diff --git a/tools/perf/tests/shell/trace_record_replay.sh b/tools/perf/tests/shell/trace_record_replay.sh
index 6b4ed863c1ef..88d30a03dcec 100755
--- a/tools/perf/tests/shell/trace_record_replay.sh
+++ b/tools/perf/tests/shell/trace_record_replay.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # perf trace record and replay
 # SPDX-License-Identifier: GPL-2.0
 
diff --git a/tools/perf/tests/shell/trace_summary.sh b/tools/perf/tests/shell/trace_summary.sh
index f9bb7f9388be..22e2651d5919 100755
--- a/tools/perf/tests/shell/trace_summary.sh
+++ b/tools/perf/tests/shell/trace_summary.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # perf trace summary (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index 1d5759d08141..684feed58254 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -85,7 +85,7 @@ static char *shell_test__description(int dir_fd, const char *name)
 	if (io.fd < 0)
 		return NULL;
 
-	/* Skip first line - should be #!/bin/sh Shebang */
+	/* Skip first line - should be #!/bin/bash Shebang */
 	if (io__get_char(&io) != '#')
 		goto err_out;
 	if (io__get_char(&io) != '!')

---
base-commit: edf2cadf01e8f2620af25b337d15ebc584911b46
change-id: 20250623-james-perf-bash-tests-88261a847552

Best regards,
-- 
James Clark <james.clark@linaro.org>


