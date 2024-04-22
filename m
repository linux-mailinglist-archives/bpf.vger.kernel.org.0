Return-Path: <bpf+bounces-27365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A088AC73E
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 10:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00F21C2087E
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 08:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6D05101A;
	Mon, 22 Apr 2024 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgNzRLhQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BD344C84;
	Mon, 22 Apr 2024 08:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775189; cv=none; b=EjjpFzLSLxtw69BKJsjgwU9TzqO4EAGv1uwFYeuKy7stMCmVDJ2LXUo3T5pEqB1ZiJl3KpmqNkL5hqg+LfUNeRpV5LmxQTcIxjPpXT+iE0wqODP2VtrRWae/vJnlOdgmFlYT91G9LmKRFwmTayaxuFdLAaJiqdzkq05lD3psOZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775189; c=relaxed/simple;
	bh=T2+6PFWukw8gJlL0s+pqeN9FU08ArUTh/EMbsg7hIcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ujen+0fl18rD6pXLBZ0ZAtSN8odxReRE2rYN5yv305GEA6Gw1bS3gDgYfCiuKzKiKJB1ezSQUPDetcfjGxoO8YBBfWysvAbdR4JAoinA5u81DI7pzGI1yFIxBvZQHajNLtvreNjlQoDBSIVB5WZIuRENrXe1dxxVaKcevH8Kx7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgNzRLhQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e4f341330fso33473525ad.0;
        Mon, 22 Apr 2024 01:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713775188; x=1714379988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yMjn7Vnjo3uWqMMcIWhkRSYL+xmtvTZqOgcQc3dm7tg=;
        b=ZgNzRLhQhUB23ujVTUfxkJcRONIcooj4q8hEYZBIg5s/BZO2K8KxCC/A2bG34fAlrf
         qkBqJM8Ri7YgivZjeIa+3yNMhc8uFuhGmhDJEL6mflqBhNQP4pRB9AT07mI+SP2Tt06w
         iWprGt/ihcQ7oFM+Nw+uxDpsYhQdHCtPWZK4ZuhZkVGaSrboTOkDj6CQi2K3qdnEh8ke
         WHbKhbmnPxCNnvo1X0FBi84VG548LMB7bOoX9FRIWU3eMvvSeSKWao2DQ0/XEBEmHSwY
         9ITHtQ91Srl2aOiI/+KIQLaWFv4crNO86fUD3XsOMEuML/UBFEWwoprJ5hOSicgLNxXH
         3OQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713775188; x=1714379988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMjn7Vnjo3uWqMMcIWhkRSYL+xmtvTZqOgcQc3dm7tg=;
        b=B8XzWhTQ+D7GzIf6m9Vab7CA3qT3mOUDl/Tm4r//e2hfmyz1TaQop1lr3a6XefA8Wq
         0c9KrX59I6/ayOeq/yD3UyhAhAYc4MM+KTT8MTLLxrIbcGbZ2x4fRJCjFUtrm04gtswx
         Ugqr3F/0KfaRzQQjpnzrIyUGIwY7oXLVPvxJzrfpIG/ABscJuNHPZS4LSlImMYmo3QYi
         0L2NwGWhJjEMu5hoQcPAoYBxoraqEnK0MH3kMmrChC0FxCtWDTC0hWyzwsSQ9lvHTFWe
         I6re8SRNJKDvA6AqB+YT4D3lIGlf8CWsKzryYl3xtzBPo7t5/1+lheZnBBYLnP2Mt1iZ
         W1uA==
X-Forwarded-Encrypted: i=1; AJvYcCUFkxrO5VzgB4IjmTXk6m0OfFSiJKORpNO7ljF6el5tjjJrBw+ssgx1DWWb1tKmpv/DMp+Wl2qrvq4ZBA+QLbk4T3+M6IqD2RV42zkV+piHwfIsdd1vIJOqBDAyYrSMan1ovb7Z++pXmuoDuHLGUbeh2YwF4sVKEoQMwZQcpiIgix6KOw==
X-Gm-Message-State: AOJu0YyktORSbIzdO8CXCiGHPolu0y6DTTTqO8mpddot4GbVp1DQ7kH5
	v9yFUKK332YXO+/osrNPiz2Gi75eq0Z6NWFK2nwXu4ETjhzsV2j0uPytOw9Tvo4YiQ==
X-Google-Smtp-Source: AGHT+IGdP/IVvSV7VZi0h19tvkVn1oOjoAy2QAc3BQcuZcGj7HN4U4gKSH68nI7KLbP+2jbfoiZPkA==
X-Received: by 2002:a17:902:ce85:b0:1e2:3e7f:3b08 with SMTP id f5-20020a170902ce8500b001e23e7f3b08mr11188088plg.38.1713775187689;
        Mon, 22 Apr 2024 01:39:47 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.236])
        by smtp.gmail.com with ESMTPSA id o8-20020a170902d4c800b001e4458831afsm7557514plg.227.2024.04.22.01.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 01:39:47 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	zegao2021@gmail.com,
	leo.yan@linux.dev,
	ravi.bangoria@amd.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v1 4/4] perf record: Dump off-cpu samples directly
Date: Mon, 22 Apr 2024 16:40:00 +0800
Message-ID: <20240422084000.1934854-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since `--off-cpu` uses the same ring buffer as hardware samples, and `perf
record --off-cpu -e dummy sleep 1` does not enable evlist, off-cpu samples
cannot be read.`test_offcpu_basic` fails and is no longer necessary.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/tests/shell/record_offcpu.sh | 29 -------------------------
 1 file changed, 29 deletions(-)

diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index 67c925f3a15a..c446c0cdee4f 100755
--- a/tools/perf/tests/shell/record_offcpu.sh
+++ b/tools/perf/tests/shell/record_offcpu.sh
@@ -36,30 +36,6 @@ test_offcpu_priv() {
   fi
 }
 
-test_offcpu_basic() {
-  echo "Basic off-cpu test"
-
-  if ! perf record --off-cpu -e dummy -o ${perfdata} sleep 1 2> /dev/null
-  then
-    echo "Basic off-cpu test [Failed record]"
-    err=1
-    return
-  fi
-  if ! perf evlist -i ${perfdata} | grep -q "offcpu-time"
-  then
-    echo "Basic off-cpu test [Failed no event]"
-    err=1
-    return
-  fi
-  if ! perf report -i ${perfdata} -q --percent-limit=90 | grep -E -q sleep
-  then
-    echo "Basic off-cpu test [Failed missing output]"
-    err=1
-    return
-  fi
-  echo "Basic off-cpu test [Success]"
-}
-
 test_offcpu_child() {
   echo "Child task off-cpu test"
 
@@ -88,13 +64,8 @@ test_offcpu_child() {
   echo "Child task off-cpu test [Success]"
 }
 
-
 test_offcpu_priv
 
-if [ $err = 0 ]; then
-  test_offcpu_basic
-fi
-
 if [ $err = 0 ]; then
   test_offcpu_child
 fi
-- 
2.44.0


