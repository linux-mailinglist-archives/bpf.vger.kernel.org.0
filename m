Return-Path: <bpf+bounces-38517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32509657D2
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 08:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5AF71C21EE4
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 06:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E699F1534E6;
	Fri, 30 Aug 2024 06:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CG2SaVt+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4231531DC;
	Fri, 30 Aug 2024 06:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725000712; cv=none; b=TWZoJMBlFEPfSKskbdgjkpCMrG5MF4IfcFZAqQXws2deV4mqz/31cIwdY/wMsWTdWYvn034da0SXbnokUyK2u5N9+eQ/s0yEiAAlnEDAUneJ3GJ33VbuJsWU5EvorGEX/QAFdh8hHuBVY6ZMZNjKiNtJ2rJHNqRlXxkFIVnf+cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725000712; c=relaxed/simple;
	bh=q4/3jfLknydUp8HCEo8sK+b+5kXMu3szQ6Mw0K+Tp88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3fmpL/le4ShE/GoPakAd3VgMF+KWrD7jfb89TV1vP2/nLFumc14bbeAhLrmeQJ2tlSYfoeimOEuRv4lJbGWBlFwLgxgpfcKfstPsMyn2c6s6AteC6F9VMIp4hIdKI5rLt4Y6enWfsiDvIzupEmZGByJd8/y6a7Zzhp9WIZh8OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CG2SaVt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1ACC4CECA;
	Fri, 30 Aug 2024 06:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725000711;
	bh=q4/3jfLknydUp8HCEo8sK+b+5kXMu3szQ6Mw0K+Tp88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CG2SaVt+pytwgzo19CuFRkT6ZlwILs1M5j1P5aWhvNnN26M7+EO6cn3XeR1+sB6WR
	 C8ZwgYvI0NlWqw/oY/ThuAeElfdqGpf1gffkvdnVle3niOvxUxw2e8l+kS1kzk2dth
	 tIFdaF8VfzAmndElUz+M7H6ewNcfFelUkCZe6EwJlyI9lrjk+XBYe64/CySmVkujkk
	 e9UlPKnXQHueVOOKG5FhPI2j/SoxYyuECHWb8RGxnRyuqU/JSp/mVUqB2BAnM8hIl8
	 SHZVw2RZ63Q0NZR1X6B7yAgScWIQzRR4QJoZY8DaBS/hGy66nSnfE67St0gpqaFfiV
	 eCpzXKspWPrrw==
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
	bpf@vger.kernel.org
Subject: [PATCH 2/3] perf lock contention: Simplify spinlock check
Date: Thu, 29 Aug 2024 23:51:49 -0700
Message-ID: <20240830065150.1758962-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240830065150.1758962-1-namhyung@kernel.org>
References: <20240830065150.1758962-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LCB_F_SPIN bit is used for spinlock, rwlock and optimistic spinning
in mutex.  In get_tstamp_elem() it needs to check spinlock and rwlock
only.  As mutex sets the LCB_F_MUTEX, it can check those two bits and
reduce the number of operations.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_skel/lock_contention.bpf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index e8a6f6463019..4b7237e178bd 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -323,8 +323,7 @@ static inline struct tstamp_data *get_tstamp_elem(__u32 flags)
 	struct tstamp_data *pelem;
 
 	/* Use per-cpu array map for spinlock and rwlock */
-	if (flags == (LCB_F_SPIN | LCB_F_READ) || flags == LCB_F_SPIN ||
-	    flags == (LCB_F_SPIN | LCB_F_WRITE)) {
+	if ((flags & (LCB_F_SPIN | LCB_F_MUTEX)) == LCB_F_SPIN) {
 		__u32 idx = 0;
 
 		pelem = bpf_map_lookup_elem(&tstamp_cpu, &idx);
-- 
2.46.0.469.g59c65b2a67-goog


