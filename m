Return-Path: <bpf+bounces-52705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7837A47054
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 01:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D79E3A87A3
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 00:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248BC250F8;
	Thu, 27 Feb 2025 00:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ylbvyIdG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5488B4A24
	for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 00:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616595; cv=none; b=HVgg50exaDkVQLkZFjyeSAocnTqwhR2KcOC+Rkf9QXQeVcG6RG91s4T6artGWkwL7FOX7c6o4iZvEGAFPbCsL8x6iCLIvblnpZHPI9Pe8IQQR1ZXJzZXxHmzydt+4Hbl6KPrm2U97zNJsYQBljqFnaeh3qPly8sdOe393TR3GAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616595; c=relaxed/simple;
	bh=SLA+bDmdTB6ULu5zbTamkrhePwVhtRIJqJ5avVgZmLw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=prNrd5do6YvMm9T41YeaZEAEMpkOUN9vJmFZMHmfNTwMnDYnQtoFcPtR30zAPn2XzzuYomrMTnsF1H4svPLnUk/xsCPFy2/dbFJxb79bKNhiB4SdDxyBvnTvIfSQwP2LU2l41yMdL2E3+t1RvXyMiWFacs3dE0YaMXCD7mSC1cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ylbvyIdG; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc0bc05b36so1243277a91.3
        for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 16:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740616594; x=1741221394; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6PFYTBhXyGigxmAagzwCn1stPWOoCBAs7wU0xTcNHU0=;
        b=ylbvyIdGEzMQfhCTJaVvnPIofmXMkkkNaPMfrtkS+TO57Ig/2Ii+/nPOeYyxfpePbQ
         TFh0kEpmzy/YcX/6MNVtTKEt2PeTs2n4ugh6dIkL2v4m9Zp/90bjY27w7jsnsmuBYvrL
         2hXzL1v9FOUTQ86sqFNtFubE06HC1MW+qYT5GgYTrQgYNPny/E/KV3FZx0uXVlL9+5wh
         XUNdacbAJVEfy+tZ8MP3LR1utLtbUlVLhrYnZAdfiRew0JzZFX8nB7vkxPE9tgybQ0Ov
         LluooylI3CZXunXLbdWnYba6DilBQporz3nwYbJLG0DyiVbc9VEG9d/6/I24KFHQ7D1O
         Awnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740616594; x=1741221394;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6PFYTBhXyGigxmAagzwCn1stPWOoCBAs7wU0xTcNHU0=;
        b=bnnjzN39gxBtRkXyANPy8dFNWUhHPMOXkyTY+FEtvvnyRepemvej+1LS47E9nl4D4d
         0RbLpqeMDLhP93aKeatazDkBXoyHn+u8gLt1sF77VE6sJgbHzWmIF2gaiOcNcS87YdWe
         WfHUoHspqTgSd+oEH362yJWCtO0BeEhHw2dhjoaKOWobiE7rLdvgmh+J1NH5+RJlxKsL
         sUvCRd0JPoOikNVQEfXo0gJJfG+He/l5jMdc+5cUgCrhgdB9DyUxhEPcP8f8xLQAABcu
         QnB7Qu4B9jU6bOC04wFe1anmlateGnam7/8Uc2MX9OeCsFXzxnH/hm0FILJOt29WcETw
         ZB6w==
X-Forwarded-Encrypted: i=1; AJvYcCVHeWOpP+wvYCt2855aYS4nprWlpvYKAwVtxVxwa3XbweDZNAYVbsbgpreO6pMOXpQ+RCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUZpoTviGA5SmVxV6qBCa7rin77AYAwDUHsBJILvjWHVuzMHev
	f+xXUYntA+WMFP+Yxjbx1u5Q6vblEDZCIc1XVdHEMZidwTEu71T4Pees38EcNcApYintwNV2dKs
	f7g==
X-Google-Smtp-Source: AGHT+IHxikcWC0rOad7hFjtNrnAgUU6gfBjwzL5p/aLBMlY833GPCude+7dcuG9JSoMILugl97UxdWTlb5o=
X-Received: from pjboi16.prod.google.com ([2002:a17:90b:3a10:b0:2fc:1eb0:5743])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:268d:b0:2ee:59af:a432
 with SMTP id 98e67ed59e1d1-2fce874088emr34694684a91.31.1740616593750; Wed, 26
 Feb 2025 16:36:33 -0800 (PST)
Date: Wed, 26 Feb 2025 16:28:55 -0800
In-Reply-To: <20250227003359.732948-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227003359.732948-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227003359.732948-4-ctshao@google.com>
Subject: [PATCH v8 3/4] perf lock: Make rb_tree helper functions generic
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, nick.forrington@arm.com, 
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
2.48.1.658.g4767266eb4-goog


