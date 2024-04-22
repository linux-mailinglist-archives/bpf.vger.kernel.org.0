Return-Path: <bpf+bounces-27358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DDD8AC659
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 10:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472D51F217B1
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 08:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42E150243;
	Mon, 22 Apr 2024 08:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6mWTDte"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2151D482EB;
	Mon, 22 Apr 2024 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773349; cv=none; b=sj6UDL/iUYMXotaRmxKksI0wkMG3q0drCrwwaVwv+yRZRXMWno0x2YSybecbW2ffZHKMWmW9YoWQQoHgi84/OyPfcCHuNlfVCCS2ZKViwRd6Z19dj6cwjEiso6yT8360ELrkDypidG/S9pb0cRSOt64h5db3yNpn95FRSTYIFdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773349; c=relaxed/simple;
	bh=T2+6PFWukw8gJlL0s+pqeN9FU08ArUTh/EMbsg7hIcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q91VwVKZRK4JruHeUnzgrAM/J3SFKddWoEBlN8G9HxG+19iTyrYBa8mkreuYr7VmohD4HJesvcDt1ehMIDfczBrT+jvqC6ZpuC51UalH9XPFmZLqSzKr6rJP3AHRWIea2FQBXIo7DtWPlzPZnpHcwWgeoGVaPPhoh7hk3ROkWWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6mWTDte; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e2bbc2048eso33811955ad.3;
        Mon, 22 Apr 2024 01:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713773347; x=1714378147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yMjn7Vnjo3uWqMMcIWhkRSYL+xmtvTZqOgcQc3dm7tg=;
        b=O6mWTDtevBKJ8hCNQ9x6uI9EFWUxdkgGcQz2VS9dktg45+xmsyavpGjs3/gwcxJA8R
         UhgthoshKlXpg/D7m4ORBz991u1GtSR3njl8bAXPRv+nPFuQ2RACr8HGu6jYxnRQTioZ
         6aAmfAkjCAAZStNcwl71gygAZuI/UeTdkOWWx6hOYsYB74Jnkg3P9Xu5kemjngajxqd0
         G7zJqg33NcS5/1uCoui8gumFdWt0NaBgYGrfBlzTC5urcIBSLpMzWreueXYPOeKpahlO
         A3pNU+r9iFIrrrt//vi40+hNLF33VUc+P4CKBykW+tLn3wU4tVHau0s8K2Iy2Pdv+YsM
         6qOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713773347; x=1714378147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMjn7Vnjo3uWqMMcIWhkRSYL+xmtvTZqOgcQc3dm7tg=;
        b=oZpF8eGvLiri9QlpUyol5dxO84Qd5zURFmJzk7iixrhhgvEmCeiICIqpa0bH1y36ve
         JiMKLy48GOFqzh80EPu1AtMwY4siVV/1TuXOL/FAo/XxkBANi+6FWijh0k/gsBxYvs+N
         rbuFd7JTbUeWZCyoGTcUpU0cEhq0q4BMZ0xii276MGBwBZqP6z1VUpB2FxowaytVXdiy
         CJNafMTpA0I8M5RUp17aKIo0WaIpfVnLzOCcUERVMt2399ozzZzpPYtNgyzAPDHz3w8e
         VwWW1qbpanEyP1KrHu5ahGUgngGeHaEEA9Kt7kjY7L4QJOTRbHn249bvRZBZ+ddCYDuu
         IaWw==
X-Forwarded-Encrypted: i=1; AJvYcCWGrAlg6+OSdhYzOQ+Ix2qiFgcbigzPt3JMLsvUY5hx+AQFmdG8BgqSUY+/FAuNO15U9LhM07RLAH6h2ObECPOGNMlfBeTO0Plv1ItadZCNbF9TARHL/AiQtSoGR1EhSlqRJk7drAw9082neBvMF4OPRkY02zm6o03YUe+IG66pQfAlmA==
X-Gm-Message-State: AOJu0YzZntH53ICaScQxtELHaDLCjx2Yef6jW6SujL1IMfgSm/Te4EDQ
	tjmc1TdilQZjGFCfUUpWR77cE2ws5M9QNTkubgEdq7h5E2H0Lt8A
X-Google-Smtp-Source: AGHT+IHKF8y46DVne2upxGaOtJCwPUsJ1t9aMP4ctxHXMofPraBr+EXw0uwvqWl8AQDvRSjrmgoInQ==
X-Received: by 2002:a17:902:784f:b0:1e0:b562:b229 with SMTP id e15-20020a170902784f00b001e0b562b229mr7703492pln.47.1713773347435;
        Mon, 22 Apr 2024 01:09:07 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.236])
        by smtp.gmail.com with ESMTPSA id r3-20020a170902be0300b001e27462b988sm7512268pls.61.2024.04.22.01.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 01:09:07 -0700 (PDT)
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
	yangjihong1@huawei.com,
	zegao2021@gmail.com,
	leo.yan@linux.dev,
	ravi.bangoria@amd.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v1 4/4] perf record: Dump off-cpu samples directly
Date: Mon, 22 Apr 2024 16:09:29 +0800
Message-ID: <20240422080929.1919319-1-howardchu95@gmail.com>
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


