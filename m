Return-Path: <bpf+bounces-44329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5969C165E
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 07:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E62F1C229D8
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 06:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B7F1D0F5C;
	Fri,  8 Nov 2024 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/oE7xcu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAFB1D0E01;
	Fri,  8 Nov 2024 06:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731046502; cv=none; b=oxhwNBfr3H3xzNeioW1S/BenXjLZVx9G0Ke3h9teE9Pqe7+8A9/Cxrae00K91r3AgN/ZTH/7BvLlVFzwVLjap3FvShEubcCAfvgMMY6Y1tdS9qLQUHog5kuVwospi5EvGK0CCTsisar/zlEB6zaSjyyZrpaGhH6U+I6KNZ6ftWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731046502; c=relaxed/simple;
	bh=uSi1ucr/BU3tlJexGgZTuphEMdYpAICnVnpVw4mRJBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0K0DnCTKHn1671w6gvdBTEhSPMMfxDpqxPIPmj+5smv1b/DXwDfJy5kSarvfLiIwdhPlaSTJibpimTq1BgKiqtMadp9EywtXBokrjTGnP0MujeGbVZhyf4Oc50YFNQPgeG7cSqyBvAmUgOmGSl+ZYyHlgsLQfba6FdNqF+qscU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/oE7xcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B762C4CED4;
	Fri,  8 Nov 2024 06:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731046502;
	bh=uSi1ucr/BU3tlJexGgZTuphEMdYpAICnVnpVw4mRJBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i/oE7xcuoWpeE6sjhYeqO8PemYJsoDFi+3OU8Va/3pmJja6OmHwVsjedu1CO0Q/pf
	 CCO6mK7N7V34n10DrOJol8FNtB8DPGelaIN0HLuA20ur1jCWa9DXQW1CvU3YSP0lOv
	 LMgYaZWbE3EQLgtJ0KKOp+yLLpFRtCTP5g0Cps7ve9M173WC/yyRJHcqNmIvYDLwXy
	 5fzRkdX6edpKHWRa1HLkSUTtXTrbwfcTgygNwcOeuNQtJiAxC9tgT7Q33TRDYqQafW
	 b6RilTIRVzKEKR2qBanDi7FGjCV+D5HydX3x8bTBLWZrhD7RzPIkbHvZQoPOkwfNIk
	 h6w4f90ndqycQ==
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
	Kees Cook <kees@kernel.org>
Subject: [PATCH v2 1/4] perf lock contention: Add and use LCB_F_TYPE_MASK
Date: Thu,  7 Nov 2024 22:14:56 -0800
Message-ID: <20241108061500.2698340-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
In-Reply-To: <20241108061500.2698340-1-namhyung@kernel.org>
References: <20241108061500.2698340-1-namhyung@kernel.org>
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
2.47.0.277.g8800431eea-goog


