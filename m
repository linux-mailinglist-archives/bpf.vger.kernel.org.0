Return-Path: <bpf+bounces-32086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DC79073E2
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 15:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8851C229BD
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 13:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39583145FED;
	Thu, 13 Jun 2024 13:36:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B884314430C;
	Thu, 13 Jun 2024 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285806; cv=none; b=PNuZZdpw2XSX/1bN8cPS206sm5yfe+MPfO/Yn0PvNSu73wFcM2sQrgQt1wL0qAea0qVaxeTKQAe0nFaFgDqvaTzO7O/GvgNIIUi0KZCZBX2EEfz/o6MTSsLvsvMthWxAfOasIGHmGGNKKTdxGeQaPqdxx+UazIM7e1d7Uqc6TK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285806; c=relaxed/simple;
	bh=e65AO8YkGqI6QNmDImUltk/oT8Th8lPKfyfsMwtaoc8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sgchlM9P2uJ9RhjZ/ewIcxoswEKhj6XCZB88RGMpbCTm0BRTGyJRaipOYC+5pUvkrJKinMfBC+qpdH5VeHac4Dpw9C5TKS7FbdyU7/zA3fKcw/BSizo1WW8h/LepIY28THZ28nmsA+F5GuihS59sXzLuE3EtmneK41GvWH6O438=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W0NcC6mT1zmb2t;
	Thu, 13 Jun 2024 21:31:55 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (unknown [7.185.36.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 761B1140258;
	Thu, 13 Jun 2024 21:36:41 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 21:36:41 +0800
From: Zheng Yejian <zhengyejian1@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <mark.rutland@arm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <christophe.leroy@csgroup.eu>,
	<naveen.n.rao@linux.ibm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <mcgrof@kernel.org>, <mathieu.desnoyers@efficios.com>,
	<masahiroy@kernel.org>, <nathan@kernel.org>, <nicolas@fjasle.eu>,
	<kees@kernel.org>, <james.clark@arm.com>, <kent.overstreet@linux.dev>,
	<yhs@fb.com>, <jpoimboe@kernel.org>, <peterz@infradead.org>
CC: <zhengyejian1@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-modules@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: [PATCH 5/6] ftrace: Fix possible out-of-bound issue in ftrace_process_locs()
Date: Thu, 13 Jun 2024 21:37:10 +0800
Message-ID: <20240613133711.2867745-6-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613133711.2867745-1-zhengyejian1@huawei.com>
References: <20240613133711.2867745-1-zhengyejian1@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500012.china.huawei.com (7.185.36.15)

In ftrace_process_locs(), a series pages are prepared and linked in
start_pg, then fentry records are skipped or added, then unused pages
are freed.

However, assume that all records are skipped, currently the start_pg
will still be in list of ftrace_pages_start but without any record.
Then in ftrace_free_mem() index record by (pg->index - 1) will be out
of bound.

To fix this issue, properly handle with unused start_pg and add
WARN_ON_ONCE() where the records need to be indexed.

Fixes: 26efd79c4624 ("ftrace: Fix possible warning on checking all pages used in ftrace_process_locs()")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/trace/ftrace.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 0e8628e4d296..c46c35ac9b42 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6575,10 +6575,22 @@ static int ftrace_process_locs(struct module *mod,
 		rec->ip = addr;
 	}
 
-	if (pg->next) {
+	if (pg->index == 0) {
+		/* No record is added on the current page, so it's unused */
+		pg_unuse = pg;
+	} else if (pg->next) {
+		/* Current page has records, so it's next page is unused */
 		pg_unuse = pg->next;
 		pg->next = NULL;
 	}
+	/*
+	 * Even the start_pg hasn't been used, that means, no record has
+	 * been added, so restore state of ftrace_pages and just go out.
+	 */
+	if (pg_unuse == start_pg) {
+		ftrace_pages->next = NULL;
+		goto out;
+	}
 
 	/* Assign the last page to ftrace_pages */
 	ftrace_pages = pg;
@@ -6794,6 +6806,8 @@ void ftrace_release_mod(struct module *mod)
 	 */
 	last_pg = &ftrace_pages_start;
 	for (pg = ftrace_pages_start; pg; pg = *last_pg) {
+		/* The page should have at lease one record */
+		WARN_ON_ONCE(!pg->index);
 		rec = &pg->records[0];
 		if (within_module(rec->ip, mod)) {
 			/*
@@ -7176,6 +7190,8 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 		mod_map = allocate_ftrace_mod_map(mod, start, end);
 
 	for (pg = ftrace_pages_start; pg; last_pg = &pg->next, pg = *last_pg) {
+		/* The page should have at lease one record */
+		WARN_ON_ONCE(!pg->index);
 		if (end < pg->records[0].ip ||
 		    start >= (pg->records[pg->index - 1].ip + MCOUNT_INSN_SIZE))
 			continue;
-- 
2.25.1


