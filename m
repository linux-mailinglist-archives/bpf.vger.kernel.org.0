Return-Path: <bpf+bounces-44059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DBD9BD356
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 18:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24FB21C22704
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 17:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F791E282C;
	Tue,  5 Nov 2024 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYUuRW9/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C141E2018;
	Tue,  5 Nov 2024 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730827600; cv=none; b=LqvAI1hhUWm/nAknN8BqVzkOp/QjxFeE7TInqqcImYJudLfJcVFcrRzUeef62YW8cjWyBCIcMs8JamOoxdwHt6Rc3yx34/chZ9wVNS6dt7CNxl8TI5lZPB3pChjmIjhBaOwNBizzfcEiPV6Yke0hjnz/OaVghJS+0feOIrjAY2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730827600; c=relaxed/simple;
	bh=pyZ5l6v8C0oJhH7ls8q9xbjc6qgfiX0PBuXO5xZ4WWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNzRIaKZNxmWHNP0Jrtzb31H/donbtYKpLc/LwIyGSLF3ezD0wXhTqKRA1Nib2FuHw50apU73tWshE0aaC9kW6bq2yWk0TFCrvEYwQ7I5v+lG6VR7Nwcsq7kddqF8zrlw4YAMPwokiXpKechhteDdIkanHuppxF9je4gOpCO0uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYUuRW9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F346C4CED5;
	Tue,  5 Nov 2024 17:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730827599;
	bh=pyZ5l6v8C0oJhH7ls8q9xbjc6qgfiX0PBuXO5xZ4WWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gYUuRW9/4pzD90KTibV861Zu0JILvmD5bPZtre9llO3oIG3850sVymQEILRb0JFU2
	 7RTEYbj5VXSmAThObrJubApbalYiVF+Y0uNFkr0tNPs5bXXWIJtJkx5HZIH30OTrhN
	 wJe6n+kTW3A3uYmvdbtFyBtdacEnBV8puQvbhRioipJ8DQGkMJWVfLfxx7ZXlskksq
	 BPdFNoo9GPzlLBv2rbKq7KL3bXKnzROOoA/+7t887LdMvYRqXGV6U7bcRqYuv3/1qY
	 JCEWLdVJSi4uKjaX5+0ITL2SXAHEhXe4WP0Wkxg6yLcpxPQNC8a7G/+DbbUygcFvN6
	 MXXMcUxGFXvTw==
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
	Stephane Eranian <eranian@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Kees Cook <kees@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH 1/4] perf lock contention: Add and use LCB_F_TYPE_MASK
Date: Tue,  5 Nov 2024 09:26:32 -0800
Message-ID: <20241105172635.2463800-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
In-Reply-To: <20241105172635.2463800-1-namhyung@kernel.org>
References: <20241105172635.2463800-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a preparation for the later change.  It'll use more bits in the
flags so let's rename the type part and use the mask to extract the
type.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c            | 4 ++--
 tools/perf/util/bpf_skel/lock_data.h | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 062e2b56a2ab570e..89ee2a2f78603906 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1597,7 +1597,7 @@ static const struct {
 
 static const char *get_type_str(unsigned int flags)
 {
-	flags &= LCB_F_MAX_FLAGS - 1;
+	flags &= LCB_F_TYPE_MASK;
 
 	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
 		if (lock_type_table[i].flags == flags)
@@ -1608,7 +1608,7 @@ static const char *get_type_str(unsigned int flags)
 
 static const char *get_type_name(unsigned int flags)
 {
-	flags &= LCB_F_MAX_FLAGS - 1;
+	flags &= LCB_F_TYPE_MASK;
 
 	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
 		if (lock_type_table[i].flags == flags)
diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
index de12892f992f8d43..4f0aae5483745dfa 100644
--- a/tools/perf/util/bpf_skel/lock_data.h
+++ b/tools/perf/util/bpf_skel/lock_data.h
@@ -32,7 +32,8 @@ struct contention_task_data {
 #define LCD_F_MMAP_LOCK		(1U << 31)
 #define LCD_F_SIGHAND_LOCK	(1U << 30)
 
-#define LCB_F_MAX_FLAGS		(1U << 7)
+#define LCB_F_TYPE_MAX		(1U << 7)
+#define LCB_F_TYPE_MASK		0x0000007FU
 
 struct contention_data {
 	u64 total_time;
-- 
2.47.0.199.ga7371fff76-goog


