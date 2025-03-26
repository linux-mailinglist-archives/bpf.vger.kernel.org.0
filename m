Return-Path: <bpf+bounces-54731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469E8A70FEC
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 05:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3547178D92
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 04:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB5D17A31C;
	Wed, 26 Mar 2025 04:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2pdFxL3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8042F17A2F1;
	Wed, 26 Mar 2025 04:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742964003; cv=none; b=Bjd405tTa9rQwJ0Y7vmL8gBTs2TptwN8d3EqWjsEGSQowjyvkVPVR9u8L/XK/IeYP6RqyYV/zplRk7ObOo7JogpzRBzZ+bSOa8sW0gcZlPk+eKXjToumweRMH9JTzY7F7Xj0S/PeFrJNkRIO1BmZYPdJdy25IIAqbAvniTghsbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742964003; c=relaxed/simple;
	bh=upsD70LPNN2yPXKSeT2E0dGUq2NzcC5mUkscKaqKeRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m77B1gQXigdrGKYvKYpAMBBfqZQ3YYirr9OlOUzb3lwFReqSIRH9Pte08tbkE7Rs/bK26O/CdARsS6RycK8ieH3KqGe3LDDZrc6OuonD7SehEDyWyPfklDvi2DCtSoGMKNqeQ0ezX0+S8tBaAqKZglbK+3gXVBRWEPdhAoGZigc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2pdFxL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9122BC4AF09;
	Wed, 26 Mar 2025 04:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742964003;
	bh=upsD70LPNN2yPXKSeT2E0dGUq2NzcC5mUkscKaqKeRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m2pdFxL301HQ1EkJ5vFBsNcjHEr7ku37P1x96bK1RCKU327xfd5WwPsp3ipoCMTTF
	 EWN9V0fqNv8A4EK6a49VneIQVm+FhoRBz9n1lfQ/SzB7INg4fkqX8LpDtSQbc3fbth
	 t0ZKs+2X8y2usZWA/e1+amgBiIciJ9ek6351MLAsJKhGEs0j3lMkRIs1rxIbQy4F7y
	 gjyZvtPGBQ6R6REcuJ1SPwGBRt5mg+q+4EBNzevyZoMYGRw8t3PcHxpzI6BzWhIJYZ
	 dIkbYgP88wYSPhMNPfwOa2mCO31eQDATx/zU8lWYR3RDQvuGLngtjr5+5rLoqjeG4Q
	 AtoLJ6hGpxkVw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v4 2/2] perf test: Add perf trace summary test
Date: Tue, 25 Mar 2025 21:40:01 -0700
Message-ID: <20250326044001.3503432-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
In-Reply-To: <20250326044001.3503432-1-namhyung@kernel.org>
References: <20250326044001.3503432-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  $ sudo ./perf test -vv 'trace summary'
  109: perf trace summary:
  --- start ---
  test child forked, pid 3501572
  testing: perf trace -s -- true
  testing: perf trace -S -- true
  testing: perf trace -s --summary-mode=thread -- true
  testing: perf trace -S --summary-mode=total -- true
  testing: perf trace -as --summary-mode=thread --no-bpf-summary -- true
  testing: perf trace -as --summary-mode=total --no-bpf-summary -- true
  testing: perf trace -as --summary-mode=thread --bpf-summary -- true
  testing: perf trace -as --summary-mode=total --bpf-summary -- true
  testing: perf trace -aS --summary-mode=total --bpf-summary -- true
  ---- end(0) ----
  109: perf trace summary                                              : Ok

Cc: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/trace_summary.sh | 65 +++++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100755 tools/perf/tests/shell/trace_summary.sh

diff --git a/tools/perf/tests/shell/trace_summary.sh b/tools/perf/tests/shell/trace_summary.sh
new file mode 100755
index 0000000000000000..4d98cb212dd9de0b
--- /dev/null
+++ b/tools/perf/tests/shell/trace_summary.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+# perf trace summary
+# SPDX-License-Identifier: GPL-2.0
+
+# Check that perf trace works with various summary mode
+
+# shellcheck source=lib/probe.sh
+. "$(dirname $0)"/lib/probe.sh
+
+skip_if_no_perf_trace || exit 2
+[ "$(id -u)" = 0 ] || exit 2
+
+OUTPUT=$(mktemp /tmp/perf_trace_test.XXXXX)
+
+test_perf_trace() {
+    args=$1
+    workload="true"
+    search="^\s*(open|read|close).*[0-9]+%$"
+
+    echo "testing: perf trace ${args} -- ${workload}"
+    perf trace ${args} -- ${workload} >${OUTPUT} 2>&1
+    if [ $? -ne 0 ]; then
+        echo "Error: perf trace ${args} failed unexpectedly"
+        cat ${OUTPUT}
+        rm -f ${OUTPUT}
+        exit 1
+    fi
+
+    count=$(grep -E -c -m 3 "${search}" ${OUTPUT})
+    if [ "${count}" != "3" ]; then
+	echo "Error: cannot find enough pattern ${search} in the output"
+	cat ${OUTPUT}
+	rm -f ${OUTPUT}
+	exit 1
+    fi
+}
+
+# summary only for a process
+test_perf_trace "-s"
+
+# normal output with summary at the end
+test_perf_trace "-S"
+
+# summary only with an explicit summary mode
+test_perf_trace "-s --summary-mode=thread"
+
+# summary with normal output - total summary mode
+test_perf_trace "-S --summary-mode=total"
+
+# summary only for system wide - per-thread summary
+test_perf_trace "-as --summary-mode=thread --no-bpf-summary"
+
+# summary only for system wide - total summary mode
+test_perf_trace "-as --summary-mode=total --no-bpf-summary"
+
+# summary only for system wide - per-thread summary with BPF
+test_perf_trace "-as --summary-mode=thread --bpf-summary"
+
+# summary only for system wide - total summary mode with BPF
+test_perf_trace "-as --summary-mode=total --bpf-summary"
+
+# summary with normal output for system wide - total summary mode with BPF
+test_perf_trace "-aS --summary-mode=total --bpf-summary"
+
+rm -f ${OUTPUT}
-- 
2.49.0.395.g12beb8f557-goog


