Return-Path: <bpf+bounces-59669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E88ACE3E9
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 19:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A42317596F
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 17:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD6920F098;
	Wed,  4 Jun 2025 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MRXAODZN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1873E20D4EB
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749059169; cv=none; b=jV75vHcE04/XPAmqv9idNxU4WJiC5IV2XDCwcDPNY7KDViUuxYzpqLB6FzO/bYZ/sb/FNMcxGpK/8MpekKEjulIpvfnL1wnY1LT1MRQ/SKPF+BUanFaHczH4xU6QhPAwaKrgbJ9f3TjZyEOFvs1Cu2F1R43GkDYHbTgXVpkLY0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749059169; c=relaxed/simple;
	bh=w7mIdHYnZOGol/D2dFdzxKVsmI/XyoD3LHHc9aNTcAU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=EW4uQkJa9gDvYWcPxQJQ04PYFNcSQ23QSf3n37lIAaJ2YJhB1j5iQrO+Kl5D1ZUY5yWg3zr+3+R5K/xkAyXqMKWiia5q8pccFo5PataG4RZiiBsM1NRNM/lup4Gqzb6/KZZKLRCgKnWBO9O8QpRA0cCwt74/AVGsu2Vjhi1dT10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MRXAODZN; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b26e33ae9d5so44078a12.1
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 10:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749059167; x=1749663967; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q4nC0yFLc46sxQrP9IOJa66NsAsdDZBCoBLNutFpXGQ=;
        b=MRXAODZNjSP7X1Saah4zSrAk2kbb3GuAAwQoPdDYWXHGmWLtWq+swdJdhXWpKUlMMS
         32T6p/ZZQ5Gagr7CsfCYiQOLlr4DBMxRXwjAzqnW3/jRKl8gk0HpuZ+khXvb3fjmoqA3
         l6aHHyv4Uif14BFDPWltlsM3arznHDLfEgrxGTapDrmcuyoK4wKz8/U2nfQCHQV+Sc8w
         nBZ92doOqWMXUb7zl8U9QNP9PDqpKIdleNTdT1c9zlm7wpT4t9GIuYj2oLOv6rR5h1zV
         RsMabPHYF+13wLk/bDV2LBeqq3Foju5nHFQjPbQNHR9pAGfCKxoTVRCZ9gKp9/zZIoWq
         cVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749059167; x=1749663967;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4nC0yFLc46sxQrP9IOJa66NsAsdDZBCoBLNutFpXGQ=;
        b=QqFjvbXanijXgKf4S9A30jc+H/OQcnjQPh3RsN67C7E6C4xPzzNyi8UXtmujtz9ilx
         V08blBs+I7mM8uq1+ukSVdMUSNGTZpnFsNf+M58y+K3ubNd79SspMQAcl0fS3dPJOrfu
         V0FO9aKijJ+F0HNi0iSIdNH+OokAfetWOiWSIngUoNaAoT4tuIvB4zDVdo62fm6M74sz
         +dfzJIKHgCjLgN925UPGKCpHnTUXtZKnyCqQ2Vbc/zdhq0W3hIAg703XanL6NzVy4S5E
         lxuaQFHQybpVEmiDTgHZz3JeMOf8vJHcrzrK8VAY+QcmZSczH2nI3L0IUzxEs5lLp6Ys
         GDzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYGwQIm2+/M3ftkjQp02Jx3vuRlyyyD9enEnwQie3WKaOwu11Pbiyu1Vp7Ov+G2l+eli0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5S7ILlhuGJ9RNzuDJvw5Ln7vskspR4DfMyAvmR63plcy2E3gi
	sD5OgaJk1CTnO/i5SiDBPh9V7SSyNJ+Oa8gkqk3TJhgNeB/S9gaTCXl43M8K9GCjqm3nS92Hsfk
	yKRi+PpRxjg==
X-Google-Smtp-Source: AGHT+IHezvR+eTPfCS3Vq8TwC31u+IqeQ3bdfYHNH41ei/61+xbUnxM56xS7y/HR/6GQ10xXZnPrjjh9vTUm
X-Received: from pgbfe26.prod.google.com ([2002:a05:6a02:289a:b0:b2c:40c4:8bb4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:328b:b0:20b:9774:ac6c
 with SMTP id adf61e73a8af0-21d22aa2f8bmr5219599637.5.1749059167416; Wed, 04
 Jun 2025 10:46:07 -0700 (PDT)
Date: Wed,  4 Jun 2025 10:45:39 -0700
In-Reply-To: <20250604174545.2853620-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250604174545.2853620-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250604174545.2853620-6-irogers@google.com>
Subject: [PATCH v4 05/10] perf tests record: Add basic uid filtering test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Chun-Tse Shao <ctshao@google.com>, Leo Yan <leo.yan@arm.com>, 
	Hao Ge <gehao@kylinos.cn>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Gautam Menghani <gautam@linux.ibm.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Based on the system-wide test with changes around how failure is
handled as BPF permissions are a bigger issue than perf event
paranoia.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/record.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 587f62e34414..2022a4f739be 100755
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
@@ -345,6 +370,7 @@ test_system_wide
 test_workload
 test_branch_counter
 test_cgroup
+test_uid
 test_leader_sampling
 test_topdown_leader_sampling
 test_precise_max
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog


