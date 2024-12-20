Return-Path: <bpf+bounces-47399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A3D9F8C45
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 07:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C7767A317C
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 06:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3231A8411;
	Fri, 20 Dec 2024 06:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnrKPND8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C4C1A3A8A;
	Fri, 20 Dec 2024 06:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734674412; cv=none; b=HaxAlejp67rl3zEH+H9fJWimfCnIMD/7e8a4wXRx7FTd/9AQ8ZyoWrFGeJ0/p7c5Vr8vaqh+qasXG4y5KfjtXwm5rylhDgsAtZ4u66ZuW5VvYFP4osd6D7BhM8gUCt0SJDwBjZWsrEh9/9C1NdVF48Wn+r+UV29JHYdDstKjmis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734674412; c=relaxed/simple;
	bh=KphjkqE7tdLhrmc6I2NBr7SiRf8Q2rvdMP3Dit0D2rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLIh+P541cFJvMF9g2z89XwcwIIlLys49V7JSByBgvczAwx14PVAlyQDm44xeAuh+i8vQMJSg0kn76pRIj3SYmiqF3qkquQZ0QMz8DSXuFkpSzqPvRBn2DmPxvdjCkW3B0yCpTBZglpGM+WjnvnEOKeTpkg142GxwLPKhsao8f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnrKPND8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C8BC4CEDF;
	Fri, 20 Dec 2024 06:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734674412;
	bh=KphjkqE7tdLhrmc6I2NBr7SiRf8Q2rvdMP3Dit0D2rY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZnrKPND8n0R9Y3pJP8Dl6gPh7Ttmdzas5tAbPgzwMyi9ZddLb3uR5bnRnuNEkuvXC
	 VKdIm+K4C72Mwzu3pWcxrHqIxbaAvwGHT2onQpwrtHY4pz1syM9oj84Yo3iUydBim7
	 F+xQBqZMJek0yTtQni4rgCFgGpSYw4tukcvN2Flv5AiPzGAL7LrSmOxXw89AMCTaYD
	 +EImfwfZHQR7Pea4TeDuk0oGho7/LIpWvWuwgjw5AADFSmUHKLAVPLRiFojO4fevuM
	 bzTUOVw4CnvIVYKt7OQ+4DHP9TXd0Q6SApkcdhcPAAinRMFrbPemeLPC20BcGOvDnT
	 b05YWdwdyo5TA==
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
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Stephane Eranian <eranian@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Chun-Tse Shao <ctshao@google.com>
Subject: [PATCH v3 1/4] perf lock contention: Add and use LCB_F_TYPE_MASK
Date: Thu, 19 Dec 2024 22:00:06 -0800
Message-ID: <20241220060009.507297-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241220060009.507297-1-namhyung@kernel.org>
References: <20241220060009.507297-1-namhyung@kernel.org>
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

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c            | 4 ++--
 tools/perf/util/bpf_skel/lock_data.h | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index f66948b1fbed96de..d9f3477d2b02b612 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1490,7 +1490,7 @@ static const struct {
 
 static const char *get_type_str(unsigned int flags)
 {
-	flags &= LCB_F_MAX_FLAGS - 1;
+	flags &= LCB_F_TYPE_MASK;
 
 	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
 		if (lock_type_table[i].flags == flags)
@@ -1501,7 +1501,7 @@ static const char *get_type_str(unsigned int flags)
 
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
2.47.1.613.gc27f4b7a9f-goog


