Return-Path: <bpf+bounces-67543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A91FAB4521F
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 10:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554F11C24146
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 08:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E741530506C;
	Fri,  5 Sep 2025 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xe9sc5ko"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8228D28031D
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062405; cv=none; b=DHjjTe6XrKx92SjWCHbUPStmF5UH3/KLduxwcWM8mE3AdDTIBCKM0/N8eEwFV+s1RCIeWOftlidRAq/qZ00s9mTMYYCGN/neEyPRPtUCGNbx/INtjDtVm58yqzpeMMJkZyQYhg2uYMUfx7calIMS6aCB46lXfrO/7mxjH3KeRuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062405; c=relaxed/simple;
	bh=GEf62t/g6oiTVPVC1cJMYKypf+y03W8litzuitIwb3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HA579zPu9DM9+u++EKrT75VSd7JqNToZ3iPgfgJerg9wHr8a3e2NxCSoLIkgaYNh3EdXtFb9C1jcQPKqWb2guGzNKMd7qmHAjxpY3I5mSjBo/L4cAvd4R00lekNMn7CAiZD2lxdEolQQXIxcndMCRFWt2vEHKdqxWrECH76ldXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xe9sc5ko; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b79ec2fbeso13281955e9.3
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 01:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062402; x=1757667202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4B2o7LJolSwLsUyedkxBTIDf82LUraxF+ncxBU9k/G8=;
        b=Xe9sc5kobS8rKgJpzVV3E+grt28SWN2X5TGc7W0t62nvbZgNvG9wwbzshJLnSgSotO
         G5fhUquHkbRrlM0iqDtYQvKlxf5jip1r9WWF31xIN8JvJR9MXvLnCeclsU29uhPt17Wb
         k+CY5pDHftVQk7E8/7tDVJB59PDzkcmB5eCv9K0lpk9vpsNKpMUK/556Ts6TgqL6SY8D
         RTXV4RgbnIbF3b63h/zPYIdOBBJosuFiH743skE2AJgDNvg5k8M4/v+IPZAddSL6NVNB
         kZ37OXnx+5xbpJI0ueuAHzFNQzZxWQGyiE2scXiPg7txRJ42IboHDy3Mbcd1Tzdx0QNw
         RNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062402; x=1757667202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4B2o7LJolSwLsUyedkxBTIDf82LUraxF+ncxBU9k/G8=;
        b=f6pJSITJToBGPqOG/ddvFvYhdGAfQQHbGi0kYbekZ4a6N80dDNedmB4B//8S+S9Yyg
         XCzPAeUpfwQacE1JxAJs28BGmuXSH2X+8OwcMDJ1PtWfqK6q8AvfjT+lg5c/RFOJAoft
         8B48rwpBHGNj1oAlgfLz6pEj1qISdvXB+GRxtkqHk1GzAOlDgvBLpZotLvCYfIRTbgEr
         khzwGoLl3/MjzBkCPrwaNDHd8GT6a5M/WYF36g35lHDGk2350wSDjPj8FqPZELj+yWco
         6G7u+tl1CtvtWxWTA5QCNcEYdPrMXm+7F4lgLTP2egKG6MEkEgyGx/HkAKFwkjbbp0SP
         u1Zw==
X-Forwarded-Encrypted: i=1; AJvYcCU16WnZO4v0aFOZ4WgdtBVj1xvkoKVFP9RDD4pESd4IH2yLP/RxjLIkiYL2PSFwLXSDRnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSRGWlQAzeXkPohrIpxWx4CWjUjaTAONsE3QW2V4g9CUl2ES0D
	0g3pKKQyljpYV85mB/lMmu+lge0KEq/hWpUIEvqkObIzQzQePSRAt0tJp/48etV9q3o=
X-Gm-Gg: ASbGncsyChhZN450bWMI53nzIUar2R9SKyD8/MbmtoMvN3FS2/nhqY5NZun/kNn72PH
	PfTDkgVOmN6LfEQvxmlQCCuZlMnkCxgZ0+/sxgQvvgeO01kuy5xmRQe8Gi+H4XIZVUpJwwDA3ha
	Sbz1PDihpZ2zF26waLK/mvwt6Se1QB5QA5gjVjcBc092H+qnziUYlYmmwYYXwiplhyhzw+ZNUml
	XPROJ4jmaGzxvEIEANXbBO6bBMCBGUnbMhijjRq8Zf57NLYAdmv7kviMaCjuzOw9BYsh5GoKbVe
	06rKK7OikmOrxTnrakDjqJ6YY7gwS5wHBOub3UX8K1y6c3rmtvhkQLtgES50kkMPPyEu2vBsZSI
	C0f3xQ27XG3nbCcR6wrtFqN21eZu3LxBMqvJgYmV5pMMkYJ8=
X-Google-Smtp-Source: AGHT+IGBjO7xQV7cWnxGjNyx+7vN27kfCPPMb+7tirAXxLTouuf1kijLEtLKWTroGzkDJeGipPC59w==
X-Received: by 2002:a05:600c:1c26:b0:45d:d68c:dfa5 with SMTP id 5b1f17b1804b1-45dd68ce344mr12325985e9.19.1757062401693;
        Fri, 05 Sep 2025 01:53:21 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d729a96912sm18487293f8f.8.2025.09.05.01.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:53:21 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 2/3] bpf: replace use of system_unbound_wq with system_dfl_wq
Date: Fri,  5 Sep 2025 10:53:08 +0200
Message-ID: <20250905085309.94596-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905085309.94596-1-marco.crivellari@suse.com>
References: <20250905085309.94596-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

queue_work() / queue_delayed_work() / mod_delayed_work() will now use the
new unbound wq: whether the user still use the old wq a warn will be
printed along with a wq redirect to the new one.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 kernel/bpf/helpers.c  | 4 ++--
 kernel/bpf/memalloc.c | 2 +-
 kernel/bpf/syscall.c  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e3a2662f4e33..b969ca4d7af0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1593,7 +1593,7 @@ void bpf_timer_cancel_and_free(void *val)
 	 * timer callback.
 	 */
 	if (this_cpu_read(hrtimer_running)) {
-		queue_work(system_unbound_wq, &t->cb.delete_work);
+		queue_work(system_dfl_wq, &t->cb.delete_work);
 		return;
 	}
 
@@ -1606,7 +1606,7 @@ void bpf_timer_cancel_and_free(void *val)
 		if (hrtimer_try_to_cancel(&t->timer) >= 0)
 			kfree_rcu(t, cb.rcu);
 		else
-			queue_work(system_unbound_wq, &t->cb.delete_work);
+			queue_work(system_dfl_wq, &t->cb.delete_work);
 	} else {
 		bpf_timer_delete_work(&t->cb.delete_work);
 	}
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 889374722d0a..bd45dda9dc35 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -736,7 +736,7 @@ static void destroy_mem_alloc(struct bpf_mem_alloc *ma, int rcu_in_progress)
 	/* Defer barriers into worker to let the rest of map memory to be freed */
 	memset(ma, 0, sizeof(*ma));
 	INIT_WORK(&copy->work, free_mem_alloc_deferred);
-	queue_work(system_unbound_wq, &copy->work);
+	queue_work(system_dfl_wq, &copy->work);
 }
 
 void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9794446bc8c6..bb6f85fda240 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -901,7 +901,7 @@ static void bpf_map_free_in_work(struct bpf_map *map)
 	/* Avoid spawning kworkers, since they all might contend
 	 * for the same mutex like slab_mutex.
 	 */
-	queue_work(system_unbound_wq, &map->work);
+	queue_work(system_dfl_wq, &map->work);
 }
 
 static void bpf_map_free_rcu_gp(struct rcu_head *rcu)
-- 
2.51.0


