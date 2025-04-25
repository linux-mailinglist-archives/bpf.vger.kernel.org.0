Return-Path: <bpf+bounces-56741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00884A9D44C
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 23:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79B41BC76AD
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 21:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C270A22FF4E;
	Fri, 25 Apr 2025 21:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KSc9L5nf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB3A22DF91
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 21:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617234; cv=none; b=sNQU5sPgzZBHQOu/c43k2o/ubDeXHYCQB2X5yWbsxB232FfqDeWcti1D8cVmKBEZeMF3Xj6XDDq/651wGtKe6QTY6LdqfIZ6mLnb2OfORmPK5g2KI4xn1n008piM8SmCsqGIjarnaZs08v7KPisS6LUL3a9vZ+O0PpSSgLvU+5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617234; c=relaxed/simple;
	bh=KFCTNZByuOLUewbevYxsI1Ho0Fb2f3tRKqRks+3kA+E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ieIKqNSlWzX/46dZBrrdOCXvVhxm+HHTllTL4dnDSLyzINLi3Eusd6G3Xiqme1ti/3aTEcht95fwCLEcLID81UsG+bUzM0YSqWwMK7BDwqNd1J8/5pijAqsV0h+DON8MFaMA6FWlL2OfzrZ492MR6sIkQLTCg/tLz1boT7VCS2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KSc9L5nf; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b1415cba951so1687227a12.2
        for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 14:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745617232; x=1746222032; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KqL5aSRe7NRip5o9p1kJq/fQhTkPb+WAWnf5Z1SdLc0=;
        b=KSc9L5nfRwsf/6gS1THcmVMrPlZr1yr1p6ArcYu4cqna1oOczgtIVlGS2Tg2OU5veu
         vmB/9z7bae7zXFHaQWgYGhz0Ldz7l+HE/cvxAv3ScyEygKEx3jC4YE1QV1xkL4JVTLBG
         9MUw8fGAenXJ8/hfJKTdLLxQy9OohonjSmnFKWihNgH1pcAohROm/xcSio8UC3ZroVPK
         M3TRM2OWdpahV25kwq/uerNbyrcOT/PhVOaCeHqdRgjVHB+XFQ0pb78o0/fz2KrE6Azh
         A6XMcY4jQLBH431DVM4iSuB9PgTCBrjBSzaEdi55PpctbRvohP6xvIqckj+S+pm4gfTm
         Pwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745617232; x=1746222032;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KqL5aSRe7NRip5o9p1kJq/fQhTkPb+WAWnf5Z1SdLc0=;
        b=NXwAFo/E3fFOqvI7DCNWaPyztZ2DSF2DSx9aH/GTnYspqCbacE3TPmiBL8LyI1zzbP
         QyNNb25hwyKhZDL+Dw8iZrxSkUGR4APrRLQkeIZowRn5qiBKuj3glPS3oe8oBY6/83eJ
         38uoBp7rmW0ybMYcuyIjVL4Zeeq98v4QhJrZVFRhBTc7kAOH10grT+x7imqY2gBlLPhr
         Y2ruy75d2XO31KAzzuzWuT68jJYENlYD/gZaS2oKAy42FSMBBtBeGL80nMkMC+5zeku+
         v6ZqmFwP1lhoeE4P/tttFF/KkQoRSVkl9bl9kUcX1c+NmOqgqPnpi97KX4n7PRfPOQk3
         86ag==
X-Forwarded-Encrypted: i=1; AJvYcCVHbvNzCSmG5Z63jFxIrR4PGEVWilSKviBKBg9eJHKmzGmaoJWCX79KXCUutK7tnSvwUvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo2n0khEnCQYbBQUWTVTK+3MNUTHc1Fp0QqdlLXQg+Ksny4WyN
	pyFqd+yKhQTpyZ0lPy1sMl2JR0LgoWjGzAeyl2QcpT12JTDPdtptrVdlUQ3IiIM+x7prDPDGXou
	Pg7XPQw==
X-Google-Smtp-Source: AGHT+IFxmTwnav32Ao3wqFAMsFqZ8W3YUDMM4pQmneQ1C4rKRrx4+lyrHc7kj6jkvl5z0GDO6WD92smF7xbj
X-Received: from pgbcs12.prod.google.com ([2002:a05:6a02:418c:b0:af9:5717:cfbb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2d0c:b0:1f5:5ca4:2744
 with SMTP id adf61e73a8af0-2045b70317fmr5325258637.17.1745617231848; Fri, 25
 Apr 2025 14:40:31 -0700 (PDT)
Date: Fri, 25 Apr 2025 14:40:03 -0700
In-Reply-To: <20250425214008.176100-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250425214008.176100-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250425214008.176100-6-irogers@google.com>
Subject: [PATCH v3 05/10] perf tests record: Add basic uid filtering test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Now the uid option doesn't race and fail, add a test of it.  The test
is based on the system-wide test with changes around how failure is
handled - BPF permissions are a bigger issue than perf event paranoia.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/record.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 05d91a663fda..308916f9c292 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -231,6 +231,31 @@ test_cgroup() {
   echo "Cgroup sampling test [Success]"
 }
 
+test_uid() {
+  echo "Uid sampling test"
+  if ! perf record -aB --synth=no --uid "$(id -u)" -o "${perfdata}" ${testprog} \
+    > "${script_output}" 2>&1
+  then
+    if grep -q "libbpf.*EPERM" "${script_output}"
+    then
+      echo "Uid sampling [Skipped permissions]"
+      return
+    else
+      echo "Uid sampling [Failed to record]"
+      err=1
+      # cat "${script_output}"
+      return
+    fi
+  fi
+  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
+  then
+    echo "Uid sampling [Failed missing output]"
+    err=1
+    return
+  fi
+  echo "Uid sampling test [Success]"
+}
+
 test_leader_sampling() {
   echo "Basic leader sampling test"
   if ! perf record -o "${perfdata}" -e "{cycles,cycles}:Su" -- \
@@ -324,6 +349,7 @@ test_system_wide
 test_workload
 test_branch_counter
 test_cgroup
+test_uid
 test_leader_sampling
 test_topdown_leader_sampling
 test_precise_max
-- 
2.49.0.850.g28803427d3-goog


