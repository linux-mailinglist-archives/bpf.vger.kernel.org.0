Return-Path: <bpf+bounces-59961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F4AAD09C3
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF913B40A1
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692A723FC6B;
	Fri,  6 Jun 2025 21:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vTQqpHtw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6B223FC74
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 21:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749246782; cv=none; b=miLTzdU4Z1SDPGfh/yII2/Yp7oWc93f3V3Z3wUe0Tee7ieSmYJf6SaG6Y4GHjI3P9Ci4+pg36aiw1IFDwfnguElFluSsYt3d4Zz/MJhDNyfIaYTHLnmnFf8lBG8l4RRIzzGa8MkWOeFv5WQkXk9qrXPqHxyZYGnh3chC7jvjRg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749246782; c=relaxed/simple;
	bh=b5qIz6P3lrcv3sGS7KxAxKzdqooPdqfn8oztpbwmp10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cJto53BDWW7PnlklSj0+TOjPovwV6uiD3NXExg4hcHlkudck8Cn/ljpLr6Uoik9OAUj1tGS/Gc+7kEjCF3i2WwjV5Nj9JPu82ADaNE5qY6+407YzW9pPZWaaNSr2csBzK1VMPqAbhFaup2IPXG/yEJMDlTGAgSfiJvRwRQenSF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vTQqpHtw; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b00e4358a34so1427230a12.0
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 14:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749246780; x=1749851580; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8iFfeaMcLuzx3qT6HoU1lCQOc9APQy0cingwV7epWcY=;
        b=vTQqpHtwu0I2MBWW74Kg8c1dRSl/Hks2f3rIoPlcGVaQPIDicU5R2YMjvLRuYqpjUE
         Mc43D/+XV2EV/7XwdH7uswZTHcQDqI8sGYyW4yyrImlZofkNO2A5vQFSvPuoabIrRQwS
         ggEqqUL/avBfJ9vfKuASpCNmuD/WUdmgC6Yi80KpubFSv/V0Y7zG1MrFl7Gf2F+7nJ/y
         2k4lGWkhUP7Hcu/ycoGoFBs+Uj1asmwkqJvAKx6fAV8JgOhAmrz36CHTxicv3Sw6Mikb
         h+OqkURj4pwXOFW3zWL5Sw4CiewZwcm7f96I9G014iMWPEO8BNGyYZGjJc/HotEd2rqD
         Ov2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749246780; x=1749851580;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8iFfeaMcLuzx3qT6HoU1lCQOc9APQy0cingwV7epWcY=;
        b=rE9KT68nEwuKfogxdA8TnpNOoWkVCNSelt3v1evUkRD8bhO30EqRR27BXboaWUUnjQ
         FxxxZsG4F5UALq5aGGXFNvMM+SfroIupI8JA5wI/H/mi7vDv9SVwjsBD9T5lInTxQGRS
         9SKZDK4Gjw1/G6C9zpSPLUeTCpz27gW0a/LDbnFDcQlTf3wJe4OTAgLc9rq6aw10MNV7
         Q8L9vP4bXE32TkR9LQKR1B4u0BTh+qRxc3Lctt0nkavy+8+n73H3S8f+F8xz2PStt+5y
         sN7ANQ89igLUp6kTvB5qiyqMKIQ2LolXIP+j2S1V4NMox4p8n1gl5+jx14CSHWzYvUU+
         CNJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWERGIql3/L9NB5qsBMP8X3utcAIUNDoSUMPthB2hhXvsJV+kKgJDDIeddOqa/reY91fbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9SagdgDf0gbdZbE6NxX/1cWfXkZkEeCrpCi23sXQXE/eXfGWB
	P1lS4dlkTqDoOcXM3NmpY3UQH10QRF2ArSZlQlmKDJJ22L7EIKPGb+uf/N/seBu5fLB6MhBxYuo
	l36Ao2SRAb5q3BzcmC89NDA==
X-Google-Smtp-Source: AGHT+IFWSsiTLCA9zysSvmxqFq5C2iXTQ62Am4lukNek4+xAO1R68sTOy8bTcsuDDhcx31/Pe7r+yAxD6oKYSLrH
X-Received: from pgbfq11.prod.google.com ([2002:a05:6a02:298b:b0:b2c:4fb0:bc64])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6009:b0:218:c22:e3e6 with SMTP id adf61e73a8af0-21ee2555021mr6431282637.12.1749246779784;
 Fri, 06 Jun 2025 14:52:59 -0700 (PDT)
Date: Fri,  6 Jun 2025 14:52:46 -0700
In-Reply-To: <20250606215246.2419387-1-blakejones@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250606215246.2419387-1-blakejones@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250606215246.2419387-6-blakejones@google.com>
Subject: [PATCH v3 5/5] perf: add test for PERF_RECORD_BPF_METADATA collection
From: Blake Jones <blakejones@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yujie Liu <yujie.liu@intel.com>, 
	Graham Woodward <graham.woodward@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"

This is an end-to-end test for the PERF_RECORD_BPF_METADATA support.
It adds a new "bpf_metadata_perf_version" variable to perf's BPF programs,
so that when they are loaded, there will be at least one BPF program with
some metadata to parse. The test invokes "perf record" in a way that loads
one of those BPF programs, and then sifts through the output to find its
BPF metadata.

Signed-off-by: Blake Jones <blakejones@google.com>
---
 tools/perf/Makefile.perf                    |  3 +-
 tools/perf/tests/shell/test_bpf_metadata.sh | 76 +++++++++++++++++++++
 tools/perf/util/bpf_skel/perf_version.h     | 17 +++++
 3 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100755 tools/perf/tests/shell/test_bpf_metadata.sh
 create mode 100644 tools/perf/util/bpf_skel/perf_version.h

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d4c7031b01a7..4f292edeca5a 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1250,8 +1250,9 @@ else
 	$(Q)cp "$(VMLINUX_H)" $@
 endif
 
-$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h | $(SKEL_TMP_OUT)
+$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(OUTPUT)PERF-VERSION-FILE util/bpf_skel/perf_version.h $(LIBBPF) $(SKEL_OUT)/vmlinux.h | $(SKEL_TMP_OUT)
 	$(QUIET_CLANG)$(CLANG) -g -O2 --target=bpf $(CLANG_OPTIONS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
+	  -include $(OUTPUT)PERF-VERSION-FILE -include util/bpf_skel/perf_version.h \
 	  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@
 
 $(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)
diff --git a/tools/perf/tests/shell/test_bpf_metadata.sh b/tools/perf/tests/shell/test_bpf_metadata.sh
new file mode 100755
index 000000000000..11df592fb661
--- /dev/null
+++ b/tools/perf/tests/shell/test_bpf_metadata.sh
@@ -0,0 +1,76 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# BPF metadata collection test.
+
+set -e
+
+err=0
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+
+cleanup() {
+	rm -f "${perfdata}"
+	rm -f "${perfdata}".old
+	trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+	cleanup
+	exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+test_bpf_metadata() {
+	echo "Checking BPF metadata collection"
+
+	if ! perf check -q feature libbpf-strings ; then
+		echo "Basic BPF metadata test [skipping - not supported]"
+		err=0
+		return
+	fi
+
+	# This is a basic invocation of perf record
+	# that invokes the perf_sample_filter BPF program.
+	if ! perf record -e task-clock --filter 'ip > 0' \
+			 -o "${perfdata}" sleep 1 2> /dev/null
+	then
+		echo "Basic BPF metadata test [Failed record]"
+		err=1
+		return
+	fi
+
+	# The BPF programs that ship with "perf" all have the following
+	# variable defined at compile time:
+	#
+	#   const char bpf_metadata_perf_version[] SEC(".rodata") = <...>;
+	#
+	# This invocation looks for a PERF_RECORD_BPF_METADATA event,
+	# and checks that its content contains the string given by
+	# "perf version".
+	VERS=$(perf version | awk '{print $NF}')
+	if ! perf script --show-bpf-events -i "${perfdata}" | awk '
+		/PERF_RECORD_BPF_METADATA.*perf_sample_filter/ {
+			header = 1;
+		}
+		/^ *entry/ {
+			if (header) { header = 0; entry = 1; }
+		}
+		$0 !~ /^ *entry/ {
+			entry = 0;
+		}
+		/perf_version/ {
+			if (entry) print $NF;
+		}
+	' | egrep "$VERS" > /dev/null
+	then
+		echo "Basic BPF metadata test [Failed invalid output]"
+		err=1
+		return
+	fi
+	echo "Basic BPF metadata test [Success]"
+}
+
+test_bpf_metadata
+
+cleanup
+exit $err
diff --git a/tools/perf/util/bpf_skel/perf_version.h b/tools/perf/util/bpf_skel/perf_version.h
new file mode 100644
index 000000000000..1ed5b2e59bf5
--- /dev/null
+++ b/tools/perf/util/bpf_skel/perf_version.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef __PERF_VERSION_H__
+#define __PERF_VERSION_H__
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+/*
+ * This is used by tests/shell/record_bpf_metadata.sh
+ * to verify that BPF metadata generation works.
+ *
+ * PERF_VERSION is defined by a build rule at compile time.
+ */
+const char bpf_metadata_perf_version[] SEC(".rodata") = PERF_VERSION;
+
+#endif /* __PERF_VERSION_H__ */
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog


