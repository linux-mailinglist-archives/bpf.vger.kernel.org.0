Return-Path: <bpf+bounces-51996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68623A3CBC1
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 22:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40DB63B429F
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 21:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1073A2580EE;
	Wed, 19 Feb 2025 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kE5g4+eF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A65523536C
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 21:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740001579; cv=none; b=pOV5cpaMHgKycAEcb0D8MNd/j32GATvbJZ/jSL0Au6yMlcBsYxds1RPz05TW2csBbyR3t2brILfF175k5laGRbKcdNiLnMbHBbg9MHkG2PkTW5WBivhckbcDLv2CMFbuUmbRMnMv/IqiB3lDkBKsuB2FX37N1JdnJaRXz6Pdxug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740001579; c=relaxed/simple;
	bh=I2lDkKLdTF+XzkwyuAKaxLnLyGAXCmSHLqfNO5ARzI4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ranzM3TTKKgAcEHWQb/bi+7UBpAJyk6k8VhX/B0LBzb+EOCosOHKTVL5qXMWDNp5tFI6kCMUWuEizaqmbBz3bKzkhSgzJpfPtsffHR4vKDH3RvQTq8qDeR54roMugrHXQe8PeCHN228D/dGa4MKFoqG5/Z+oww85qmIBLB5SR0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kE5g4+eF; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220d1c24b25so4102005ad.0
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 13:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740001577; x=1740606377; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1bPKqrufA/2xIYAJseqgRoZ6IOxuWUNgXHgZ4Li3xvQ=;
        b=kE5g4+eFZ21RwcRY0rDayTDOAR455NSAjQdb4Utk8J1fHVAnAws6TxC2OJ4SAUkGFf
         JDZQR8cz6G6QPMPmTxJ+XYALpOV+JxXWq31Q9JTtI3wulmNYZ3IjCHxfS1RUlruHXMCo
         1v+rqXAtH3C7NPLBubQwLGBl+RcT4kA8E1x8wr4A8g0Fp3TsS398gNsacziFX7xve9KQ
         l98qK65vKlqWxfJ7PWN9qOAHqcjtk6Fjiy8vpS5IiTVmxHcoFEEfwYSeCnLEyJ5Xg5ng
         tObFLbEBNvJJzTNt6bv5NBejKLfcYivPjq4N3VMzN7qOj4+7284mMJj6Tk3Re73dZjA4
         UcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740001577; x=1740606377;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1bPKqrufA/2xIYAJseqgRoZ6IOxuWUNgXHgZ4Li3xvQ=;
        b=wCFzcz/NSYLjq74xO1adn/q90S5E31SqMAkLPOty1AhvIDhtxJYPOP3b4cLqTHASgU
         pTJAVVPBYPWQpKfsbWgFip0g+AC6FmQBaFqrFv8cLGN/We95CFRUKxxrRCGYe+LdUVEw
         XhYz/nNfDPrgXf3DQu2QZCx7kIkoqpMpbpYvo0WL/f0zg+U6zqzOW8pHeuOYXjmgLbdS
         irZzylg2S/KNE3jp6yvlB4VPcOrzbKPyIUZlwhNOVTStuc9SPs+9+XJkDCHrbsyKsZvH
         7v5nqBhkto5+fZNa2LJj3zPPPw/dS8uAf+brr9BQsCXRpaUKUhYGxKXf7DZgwOsJMztd
         2lHA==
X-Forwarded-Encrypted: i=1; AJvYcCVgp90nfe4ChO40duwHr2ggeAzeIbQGPpudBFLUBTwNjLK7H2mGkKttCpvq9On4hI1Bkn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXsvDVeusXylb/kN7VFNIad+0QPyrnfZaa9hFSgMzADsi0i4du
	06JwWmDxoVwInLTRl6FMO8WdeduyAHv5fSYyd2OSr3u5zSEMAVsmKLuk7A/9syo2jPfuhMYRdh8
	e8w==
X-Google-Smtp-Source: AGHT+IHPuRPmO/3O1HSUOneJjxjlMEiHb2sZQ7LZdaWMUGYrTa5vuT0gkpzgWVT2Jke2mXEyfyhdPxrnJTk=
X-Received: from pfbho22.prod.google.com ([2002:a05:6a00:8816:b0:730:96d1:c213])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3384:b0:1ee:d06c:cddc
 with SMTP id adf61e73a8af0-1eed06ccea1mr11871720637.30.1740001577366; Wed, 19
 Feb 2025 13:46:17 -0800 (PST)
Date: Wed, 19 Feb 2025 13:40:02 -0800
In-Reply-To: <20250219214400.3317548-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250219214400.3317548-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219214400.3317548-4-ctshao@google.com>
Subject: [PATCH v6 3/4] perf lock: Make rb_tree helper functions generic
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
2.48.1.601.g30ceb7b040-goog


