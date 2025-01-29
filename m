Return-Path: <bpf+bounces-50003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49704A2159F
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 01:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73FB11670D9
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 00:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E2A183098;
	Wed, 29 Jan 2025 00:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VBRmaTqG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0194155C8C
	for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 00:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738110391; cv=none; b=aSnqvgR9ZarQaD7f0m0Kc/1IAQ6sgm62VzfgsYjhWHi3uJLXtg2XZz9YPhUOYvnkfeHkrGTW9pGONp7f1MKf4d8764GBm5btbUQEgjNLPUYF3TVYYMnEWeTd0WPr7zSmyfGr+jyw0Y3VFKEkSyp2laz8QgjLHAg5fmwh7VN4NtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738110391; c=relaxed/simple;
	bh=ttHPeGDMTcjcBIoqQRbKRxvn64T3Ln0kMiIrAztObZo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FKK50aMcMAqKoWsUHv00gkxcoQCTC+IifiNFJkQJKRDzyKUiqkFATfSThVbi6r6stvSH8O7BL3A+R9PuCnvWa0KKNGXXcMAM/WM84sRFA5UKSZK5McH4P77PcOW42hArlMFV+6AU8o6Q30lCeH6i4A3CUFG8IESAfbYDH77mei8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VBRmaTqG; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-29f9dcd1235so3723018fac.3
        for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 16:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738110388; x=1738715188; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pWNil8Fjn4Jar+XAMcIdAlTx0TuFDQai1n5OzDTNvzE=;
        b=VBRmaTqGQ4qYMo1iGsTK3FH/zCoaaQW7MoxpKwxsslOlGk/OuF3wICqLvZ0v4Ber0s
         a7WXuYZp4pd0FPcvKGTTSivuAsu8JO4Sbu2Tp7Sj8RJORqAjs8eK0NAZx7AVY9c0uCHl
         XafKEnV+fJcLZV3DqaHtBQEkCT86lJtfzVr53IWro21mfn5F/lhw0tjDPYzvNFn1Y6Q2
         k4VzBx+maPMqGmYispp6vkQzZZH+HIq71mRXmX0V7DaW9HPQ6Achz0sKkXeiklgdJpT3
         8HuaSpLkARSqc++c13BojKhXoSqZEarZ3n4/YbmfC5CBVBI0rcVEKlEi3a5NXGYoylvA
         isuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738110388; x=1738715188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWNil8Fjn4Jar+XAMcIdAlTx0TuFDQai1n5OzDTNvzE=;
        b=kcEjo4GOV7K3wlBditwdnvPfW/8LgRReotlUXYrQ+Bw10K38/1Gr/w+l54JjQbDrHP
         zYTaYWSKxgWso0nu5pOqVhty10uf2RPWlTHQRF2ChajHbGWfjwGDUZ2OLijUFp4bGAec
         if0Dr+zZByZxlg3kGhEqIGUgvayPq3bOYQBppFA1Dp4y8Erfvg3HTxbQpXIdNbwtLbT1
         NGS5FRizknKjv8rgPCym7nZGmDWEnMR2EKXaEfWd8baSTiaKm/J8HhmVyMuqj019XeW2
         0A4P22DhlFd5fu8e7JQDO01OYwz+PUEcJuE3JFLYQvJMNWJG8qSLFPtALjKuIYqOOhRl
         UG/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUa/JItswBmv0qa5fozJ24qm2pR/rjLk//g6ONAAu/cmzGZV1XQc/46ZRvGngDOxkvmtEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyakh2LwVHwIRtqWLJ7yqEIXsWvRhnuNScSx9oPyoElypllDlwe
	yCgab6U9gHX/N8/GI/pjzvXDjHStbnLPXjmd/I0+t8XdxwlneJgfV2SSK9TYBQR8i1FqOnyWuy9
	wVA==
X-Google-Smtp-Source: AGHT+IHsDI3JvNuSMQ9/eovun24uNULLxtkUZVYW6kTWXvv63qVQ/psGtmGrSgUv9BBLi2ZcriE/74v7jeg=
X-Received: from oabsa15.prod.google.com ([2002:a05:6871:210f:b0:297:1959:a097])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:71d6:b0:29e:49b4:92b2
 with SMTP id 586e51a60fabf-2b32f0434e2mr647836fac.12.1738110387974; Tue, 28
 Jan 2025 16:26:27 -0800 (PST)
Date: Tue, 28 Jan 2025 16:14:59 -0800
In-Reply-To: <20250129001905.619859-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250129001905.619859-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250129001905.619859-4-ctshao@google.com>
Subject: [PATCH v3 3/5] perf lock: Make rb_tree helper functions generic
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, nathan@kernel.org, 
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

The rb_tree helper functions can be reused for parsing `owner_lock_stat`
into rb tree for sorting.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/builtin-lock.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 5d405cd8e696..9bebc186286f 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -418,16 +418,13 @@ static void combine_lock_stats(struct lock_stat *st)
 	rb_insert_color(&st->rb, &sorted);
 }
 
-static void insert_to_result(struct lock_stat *st,
-			     int (*bigger)(struct lock_stat *, struct lock_stat *))
+static void insert_to(struct rb_root *rr, struct lock_stat *st,
+		      int (*bigger)(struct lock_stat *, struct lock_stat *))
 {
-	struct rb_node **rb = &result.rb_node;
+	struct rb_node **rb = &rr->rb_node;
 	struct rb_node *parent = NULL;
 	struct lock_stat *p;
 
-	if (combine_locks && st->combined)
-		return;
-
 	while (*rb) {
 		p = container_of(*rb, struct lock_stat, rb);
 		parent = *rb;
@@ -439,13 +436,21 @@ static void insert_to_result(struct lock_stat *st,
 	}
 
 	rb_link_node(&st->rb, parent, rb);
-	rb_insert_color(&st->rb, &result);
+	rb_insert_color(&st->rb, rr);
 }
 
-/* returns left most element of result, and erase it */
-static struct lock_stat *pop_from_result(void)
+static inline void insert_to_result(struct lock_stat *st,
+				    int (*bigger)(struct lock_stat *,
+						  struct lock_stat *))
+{
+	if (combine_locks && st->combined)
+		return;
+	insert_to(&result, st, bigger);
+}
+
+static inline struct lock_stat *pop_from(struct rb_root *rr)
 {
-	struct rb_node *node = result.rb_node;
+	struct rb_node *node = rr->rb_node;
 
 	if (!node)
 		return NULL;
@@ -453,8 +458,15 @@ static struct lock_stat *pop_from_result(void)
 	while (node->rb_left)
 		node = node->rb_left;
 
-	rb_erase(node, &result);
+	rb_erase(node, rr);
 	return container_of(node, struct lock_stat, rb);
+
+}
+
+/* returns left most element of result, and erase it */
+static struct lock_stat *pop_from_result(void)
+{
+	return pop_from(&result);
 }
 
 struct trace_lock_handler {
-- 
2.48.1.262.g85cc9f2d1e-goog


