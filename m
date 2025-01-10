Return-Path: <bpf+bounces-48518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 831FAA0866B
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 06:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3421B1886B38
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 05:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5485B205E2E;
	Fri, 10 Jan 2025 05:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WWAF/PXb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1262063FC
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 05:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736486113; cv=none; b=F0pHzI/fX1WVW56cLl3pRbJV8i6eA5rDt+YcnqFXIWFKDMlrSBjWrUB1s/teIc9wR0JsUrMKdPUlTxztsul8tLiPjDKSNynJEWQXHQsQVMDtmK0NJrn+/EtmFzWALhJFNfJSxzAnuoD4jWk8Up+kBvj6XIvvCbEp579RETywsog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736486113; c=relaxed/simple;
	bh=7r3spX1VTM6b7Ljhi+bgUnGyr89CaYIzvQ4zgRIgmY8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rpCULMjxrnBLiKn3593eSeMo+9j3YYyQTZ6nqctgJC/edugO+E9PBcJlCL7EU5Gpq4ZMOTA/F2QpdJB5tFXCpWACplr40uA4O0HQMtt61Xi39VS60prF3pvuzBAZUsL5mSxY78qASeJX9M2iIdAH1YQb+oOjz4XdLSACiq1Sgww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WWAF/PXb; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef79403c5eso4889653a91.0
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2025 21:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736486111; x=1737090911; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nK90VQgfJdgs3XY2vlzkWlR2hkLCvAiNELZrM3w+SYE=;
        b=WWAF/PXb84Kp7d8v91buiy2xvNt2+fk2T7R5LUy9RelaEqmXGFuQA5awicLKdG2ekL
         SqaCw5AdypW8TF8QlfLp87c8O2ioJH6qgtK1o6nz3/AYWEM4GjVo2wL0a/rsnNn8eO13
         EhrcD6a5ltIyvbXp7oC+QLbJKKy2l6+WfLQ5H2mJQ9p3lMkPf4D7cJzfr4oBRq2la+2q
         2X32muXVMdPe7b1qoMKDeSECd62ic3AISkLV5j72g6ttYMF5ck+Kxf48Ofc+zpsjih2i
         vg+h3yP7A/UFGVkivLzEzwWxw3oXApIdjQwIVvhbUXDkkqfeC1USPb1yc/8ZFLtku19Y
         k9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736486111; x=1737090911;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nK90VQgfJdgs3XY2vlzkWlR2hkLCvAiNELZrM3w+SYE=;
        b=OXGnzgvmJqce82Qd79D3igM4DsekKA5+WFJxyIGGuzTR6nrrCBKZ83fHwNBfQpnn6t
         eRJoP+kRaSJT/y2iMH/y2re503myuaxFf7B9dTWtFlUl5Vw3XpGxisCH54d7jp71BcYM
         ADRNRjWG1CoQvMuHoSbg3nbz8dDf0KSBrhRx+Yi1VnZxYKdKvX7saAYI6XSublbWPJlo
         fOS1LQtM4vxGau/WvSXGJbijp24N6fauTIZ51iNcc7szyr75xxuENtsJFxhCqvfrfbg7
         HnB2zLkqiNF8JeOGD2djcj2i+V5cGRPXtk7+VPl8KZ6dvRlP3g6v6SXiZfTg8/SHLjRM
         HgMw==
X-Forwarded-Encrypted: i=1; AJvYcCX4dgM57DuLCRx1dPjj7tJedHJgnvnzacgEbNpM7TD/LN47naE1hl8yM6yTzhW5hmtcQlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypj4E8qnOGJLej5Q5qmpoY9zorXig6UtYPnYQjzTiFHC0Mk34H
	/PPujgcHMrjMuCpzdv03/F4IO52jKnMbSRZGRJjOrVUZrV14hxqw26yN0NwAKuJm+4nc+W3+JIr
	Bnw==
X-Google-Smtp-Source: AGHT+IGlBmwxlhdWhpyG89HKs3UpAFypEVCtO1wb10nPEF0fSyibZ1nDSSEdGPg5uIjNzFSctiSI+svOy0k=
X-Received: from pjbsz8.prod.google.com ([2002:a17:90b:2d48:b0:2ee:3128:390f])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5241:b0:2ee:d18c:7d84
 with SMTP id 98e67ed59e1d1-2f548f59de6mr13874596a91.20.1736486110811; Thu, 09
 Jan 2025 21:15:10 -0800 (PST)
Date: Thu,  9 Jan 2025 21:11:43 -0800
In-Reply-To: <20250110051346.1507178-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250110051346.1507178-1-ctshao@google.com>
X-Mailer: git-send-email 2.47.1.688.g23fc6f90ad-goog
Message-ID: <20250110051346.1507178-4-ctshao@google.com>
Subject: [PATCH v1 3/4] perf lock: Make rb_tree helper functions generic
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
index 062e2b56a2ab..f9b7620444c0 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -438,16 +438,13 @@ static void combine_lock_stats(struct lock_stat *st)
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
@@ -459,13 +456,21 @@ static void insert_to_result(struct lock_stat *st,
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
@@ -473,8 +478,15 @@ static struct lock_stat *pop_from_result(void)
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
 
 struct lock_stat *lock_stat_find(u64 addr)
-- 
2.47.1.688.g23fc6f90ad-goog


