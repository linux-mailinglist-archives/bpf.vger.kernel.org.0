Return-Path: <bpf+bounces-51317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07545A332A3
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 23:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B140F167337
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 22:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665F4204C26;
	Wed, 12 Feb 2025 22:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tX065EKa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA43204086
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 22:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399450; cv=none; b=a6oTAClPTni31ABwNqPlWzYOFGF9YeHv8JkJo5nvk5AVZyuF+T49s2gBiEdrD3DlwipQb3RtkM1VkkUJio4UWy6p0qjKfPF29KcxuKnIVeXT6uYrlxdvOa4UFFmds8UBsGV6w1CLud5mJPIO4K4YSwBHP2cimS3J4/PE0O7uNMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399450; c=relaxed/simple;
	bh=4JuFZc5w2LCt7uJHwRk3CddKeQ1pM4baFKxQ+C/RUgI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XT9XgrxnpHFqIWpl9V7gDGHeZGqQRh89PQHQ0ol58DpcSR1yUVZVCpT9s7l0t5saKqIZGeXFqiXgmeND9iPQxskPh5EdMDsqmAWNGwNKZ4hFVd+pIraRrYdIGMoJgjKLG3W83A7mVSTzvfPqcVcJ5/rGjW3PMDG0EA2pxd4/Oq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tX065EKa; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220d1c24b25so4331025ad.0
        for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 14:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739399448; x=1740004248; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xp6JXzWQDgJraueffuAM7pmy5niWB0JPsWhbLqxLJuY=;
        b=tX065EKaTv2mhh/296KU6+We68bngvpU4VoQcvg4TJpK+hcGk11cPQgmJYQyZXLEIB
         QP1l5MM75EiEaaGjOEHkdBKNu5ME92ZaHMR27CM2Us0bQGmTaRxpV8N/fsRzrKOYLHkj
         ww3e1f9ckxTHWtOgVJXn8bYz6qBuBDSGifRrR4otJ2rUR7zvsWzQn4bKTU8sKAq0bVGd
         1suxjupeIMoibl2EWX2BfFYDQdFlMAVoGdWbtzJI1rMUIgrv92xny91j7OzNyDhFeQLk
         MyVyvhroQRus3NlQBnuCVT2o2xEALOXWDrkrDIUI6Lxgi0IH8e8VYyTlMsT0j7HSbgkI
         DwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739399448; x=1740004248;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xp6JXzWQDgJraueffuAM7pmy5niWB0JPsWhbLqxLJuY=;
        b=fGddM1J5nc1v7kT/ctNa+JDphQSfYqpihiC7Wjhx2rAoBo/uUjJC5+5Foi3sFxwxsN
         9AzJTgV/mOZT8osprdD23Rpfr965qj848FZZUu0xL58dltqTlGegBSC0YauAA2XaKqP3
         0fbiBMfsYPYmebFEUixUZhS0wA7LV+iqk+M8sOPiq08v/5MEgcdHWg6Xc2SOtp4FqLvn
         9Hq3G/U8PMsSAhIyw/E+rLMwhyXJujRnLt3tvBWkI4HjIK7Ikz7doBwIBFaiQE9cZygI
         7bsehIEn9f3MtFLaIo74B8Ouom+U5vIalkCnYLC4hoEi6qroVLw37+LS7Bsjdby2wGHk
         9TfA==
X-Forwarded-Encrypted: i=1; AJvYcCX/fb9t2IQyyFlUt6afSjuhaiAK0iR0zLDclo0rI3jMXcwnyYjt9w6K/qd6nvXae6qnbdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB4GpVkCtX4MgahazRmgdklpMzs+oNsCf7u4MkC3zw2/DtNu9c
	+h8FOhIOsP4nvzkwARVpQFLEzDRpubg598qJHu+I8SNmgR1VNPatYkEflGPXJE5eaQoed3fHbn+
	LNA==
X-Google-Smtp-Source: AGHT+IEBBiJFCF3wEaVNJRVbpU0yixawbj3CSdHQuUgkpm5T1RSKHo6nSIBj+hC+a0gSgUgMG6dxyJIN0Pc=
X-Received: from pjyp8.prod.google.com ([2002:a17:90a:e708:b0:2f8:4024:b59a])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d549:b0:216:6901:d588
 with SMTP id d9443c01a7336-220d1ed1f92mr17422035ad.15.1739399447824; Wed, 12
 Feb 2025 14:30:47 -0800 (PST)
Date: Wed, 12 Feb 2025 14:24:54 -0800
In-Reply-To: <20250212222859.2086080-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250212222859.2086080-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212222859.2086080-4-ctshao@google.com>
Subject: [PATCH v5 3/5] perf lock: Make rb_tree helper functions generic
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
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
2.48.1.502.g6dc24dfdaf-goog


