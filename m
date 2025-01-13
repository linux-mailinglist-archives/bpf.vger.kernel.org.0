Return-Path: <bpf+bounces-48666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6D7A0AEBA
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 06:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2699C3A1896
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 05:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D15E230D3A;
	Mon, 13 Jan 2025 05:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l9gWE0Mn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAC78248C
	for <bpf@vger.kernel.org>; Mon, 13 Jan 2025 05:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736745814; cv=none; b=HRH0kOctFINJ8WRZSFyVMQmfgu9noDdZmvQCfxoAr3tqFfFlusq2Kx3zfCqgnkg0lvU98lz8q3Nbi+J54fGo9TFd7vavOu3TJcTVzfIlL6GeO6HvpbXtzQHl5Z1nLElkOnBgu7dFzlY/0sdqWvDZ4yhPMQism8FC0MGsWkffBRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736745814; c=relaxed/simple;
	bh=7r3spX1VTM6b7Ljhi+bgUnGyr89CaYIzvQ4zgRIgmY8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YoPz2neK4VcJ/+F4pX+Rd1ieiDKCmDsYuWxQX6LJ3E0KTa55TjSeXEnstgA/yVbDiqN+A5HbtC4ndxzDAsPFVZB4yMKO+LRfCMnmUaz1ybriQaoSaIkopvY8kqXdHMzGKSm0PsLTmEQPyryfB0yS8o8VdbT1kRm9EK+FktdFxe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l9gWE0Mn; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef79403c5eso11400487a91.0
        for <bpf@vger.kernel.org>; Sun, 12 Jan 2025 21:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736745813; x=1737350613; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nK90VQgfJdgs3XY2vlzkWlR2hkLCvAiNELZrM3w+SYE=;
        b=l9gWE0MnlB+/Ap7+uXWp5IZlT8D00cC1G1wWbXa/wxRT8pmFlC8gbbzwKGGTGLbrlo
         tOohqX5fYEJsUDFXzeGmO1z0YC1XAfHbXdTuixGP0fLidnBXFj3NjZJFuckuUC7rPSO1
         zhFsw93ndcCTEn4qLpi7ryM/L+O+B1q2aAt7PcnIwQXoYRW4JhYUdIEMXKBbe49Ffpl+
         VSftBygeSO8hdgblj93H8jQ6rhbC84ukl8qm11rN7G6ERTPsli6RtP85DSvIGRNpvUra
         LOiP5aak2gib4/SqN8YHYnWs53IAEiO8EGvfqgjktn96VTT/aPxgpyplzWHU96J4Mrks
         Iqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736745813; x=1737350613;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nK90VQgfJdgs3XY2vlzkWlR2hkLCvAiNELZrM3w+SYE=;
        b=cgmdI45tv0pQtr9uOgVumk7N5ExKRT+qZfVlbgsDYYsFLm4Y0z53GnDwBAIv1MzBVw
         tAzkNL3G1HZmH/pXSAdUQrLHBSO5tCHyZlA3NNoGCyiGQEQy1ZRdQhX7+L1/b9co3XF8
         N8fdKVRBW+w2IAIO2H2bytyQZKVMj+gmE+4nuoIszGGXevq3uluLieAKz7VMRzxX3EGh
         gST6Z84A8xX7DdwFk5gwMs9Z7ITMAmY5zeopSBZWaM05xto4d1o8L2y2HvcV5dV6bvbD
         RB/rQu6UwpM/SiV4qo10URtrPvq1XFFlv587xkP8cIRpHi+b8dLV1tsdftqqPbcOS1fH
         V5+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9FTXnvfAbBrO6/bt8JfhuQUP7qsLeZVFgiS6XVVzOg6rGduDMi8hBYXmEwq0ln1EqtNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHj8DzPDgFLVJ3GGwlfuhsDQtUK60YqTioXqQ1csn7uo6kdq+T
	ETAuOmcqn98ONFWkAy1gFdtmK/6xIrZ8R1HEWmNRRfiAAbj5WUV4d3umWtIPlhOzAsufEHwTLXP
	iTw==
X-Google-Smtp-Source: AGHT+IE2T0lvVUiEK+HXuBqpPOONhCmR9IKp8db4I+ItSYAUaSSsYzmbt6l7f7ysmcwdqshEHrllE2BAF+4=
X-Received: from pfiv28.prod.google.com ([2002:aa7:99dc:0:b0:725:dec7:dd47])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3cc2:b0:726:f7c9:7b36
 with SMTP id d2e1a72fcca58-72d21f325b8mr31890687b3a.8.1736745812736; Sun, 12
 Jan 2025 21:23:32 -0800 (PST)
Date: Sun, 12 Jan 2025 21:20:16 -0800
In-Reply-To: <20250113052220.2105645-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250113052220.2105645-1-ctshao@google.com>
X-Mailer: git-send-email 2.47.1.688.g23fc6f90ad-goog
Message-ID: <20250113052220.2105645-4-ctshao@google.com>
Subject: [PATCH v2 3/4] perf lock: Make rb_tree helper functions generic
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


