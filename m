Return-Path: <bpf+bounces-50382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873A5A26D49
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 09:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4D9E7A4CF2
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 08:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69D0206F36;
	Tue,  4 Feb 2025 08:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAoki27X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C345C2063CB;
	Tue,  4 Feb 2025 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738657772; cv=none; b=nC1KmD70LYKVmqTw0oTXymayS8zIM4FAxpXeLDA3njWB1A8x8uHjwy7J1Ex8mxrdL6LTIMHVoCfS+gCbY1Nn4vGSS3xkU3PNymDbhKd8r/uErKg8yVzmplvzhTR59N/JY67Qh8JyYOZzx804hMS8EvyrY1dDF2gpVpNy2pg9SOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738657772; c=relaxed/simple;
	bh=cygbPsqm/+24ILyOqw6LUbAFmrpTSCgSL3gnpRYWYrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkx4vx7dlWw0mzJ9yOL80RRzYZDBYa6g5O/9Kwi6/o+yNUWvWxTirs7U0NHTM3TBvgs3BBotFEG2qM/jC3DQJko35sH/a48YuErF8aGVFwLKsRtgmqcg32LGiIBD7unvnksuWTYv557OI0t5RihGxSqor3QLnbervTwYUl96vWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAoki27X; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21ddab8800bso74098185ad.3;
        Tue, 04 Feb 2025 00:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738657769; x=1739262569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vp62zAozdKsPL83mVTCVtEOMmQRcolpr5FVRl0Ln8/A=;
        b=kAoki27XrR9KFbjFNijUR3KaCPdWHbyzY9rs5joP0mzNeSeg4pbpP4XoL14FqGkATH
         3iwCnbwh0Gcdi1GJsP6/dOWcefRmOi0bm1kI90MqeluOA5RZlePpfyU/dlWuXwsEa1qQ
         4HVu6RpxO5gjB2lzpNKmVu+nR2lVdN20BjKdH+M1XvXcSR0imOuxHbtM47n5RVS3jQOT
         dkl/9YlhSjjM/lDehrf83wwqe4rJJUA4mMyzDVRo/FXMCjon7SNnZbSE1c2Zxk6DrGrl
         sl/UtZ5ECap3WTFThpwbx6NCEk5v2HY04Z5QoxpOmowgQOwfK9RfE1ALCz4NmIItDKOw
         ZVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738657769; x=1739262569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vp62zAozdKsPL83mVTCVtEOMmQRcolpr5FVRl0Ln8/A=;
        b=SsmaGEHNCv30hBodv1iQKEIePeEH8lPy7qMKAwPP3eluMb6dACa5gQiz2szB5qPAJp
         P5XIhlEDpglEfIICeHzkS/yoOfIV2ZEyXFOOMl4TfQezJeJOLQ+dBUXqnFTovYg2TMBv
         mn2xxd4gQ7NlI+ieZLeCfobA8x6hxjyibKbQGkeFhn9G9LhCDffppQkCWAWwK07++iOX
         gIztZ2eKQi866+KodfzXoyjzwPdHOO9s0yZu0g+jNZ7pZuFAdghJfmCaBBIDqjoViJfe
         BLtFHdL1CbID/QtI93hqwmySeuewDyWgmvDjtMH7MA+Xyd6peVj47piOPgWr92Nb31U8
         3G+g==
X-Forwarded-Encrypted: i=1; AJvYcCU0lph55m8Om6hgogbOa0toAZyd6wHiPzhWpGAZ7mwrgEE7P0EHz/mIhKo+88tJpSgVTIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymj0T35iykmwIkktW6hA7N7mp5yvX+o0y2/xUcQLz/DD25fklh
	I8oWjEMCqixt96l5BCma8z7BpYXMC3ZZ6G/M6tNgGksqYAIjvb+wO5YcGp3DsxWs4Q==
X-Gm-Gg: ASbGncvZHq2ateZH/36RQ6nNiUayzPTY4ZkMbdrRmG9pl/wM5xPXCt7Wn9ovx9Gac5C
	D2Eqr4SUx8nzc4HfcSNpxxQTNhchnOngjLLo+pWODAB0NCH+9aagqAAIU/lKACZEmtaCu6vFAR3
	80RWKS81+v8A1mOHTQNSc6snUPvJAZlqxIrI07zzpZIjOkxqTsLxkYzxtusv69vJhRikyirS+E1
	wWEJeQIRCAcldXoDnAXS2BOQvYjiwcNuDxzlisar4JAkjYGr36tZCOlRdtQZMWShPRmWT4JMKDj
	vCVxHmTaRr8o
X-Google-Smtp-Source: AGHT+IFmcHRb38f9k/NtDEih1WWJkP1kNCt1xQdNvL6Sg8Gu8H/L9jP+++r5jcRFk0LIKTXLXYGKvA==
X-Received: by 2002:a17:902:e552:b0:216:2bd7:1c2e with SMTP id d9443c01a7336-21dd7c664damr323784375ad.18.1738657769577;
        Tue, 04 Feb 2025 00:29:29 -0800 (PST)
Received: from fedora.. ([183.156.115.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32ea80csm90826685ad.140.2025.02.04.00.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 00:29:29 -0800 (PST)
From: Hou Tao <hotforest@gmail.com>
To: bpf@vger.kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	houtao1@huawei.com,
	hotforest@gmail.com
Subject: [PATCH bpf-next 1/3] rculist: add hlist_nulls_replace_rcu() helper
Date: Tue,  4 Feb 2025 16:28:46 +0800
Message-ID: <20250204082848.13471-2-hotforest@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204082848.13471-1-hotforest@gmail.com>
References: <20250204082848.13471-1-hotforest@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add hlist_nulls_replace_rcu() to replace an existing element in the hash
list. For the concurrent list traversal, the replace is atomic, it will
find either the old element or the new element.

Signed-off-by: Hou Tao <hotforest@gmail.com>
---
 include/linux/rculist_nulls.h | 42 +++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index 89186c499dd4..795071fda6ad 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -52,6 +52,14 @@ static inline void hlist_nulls_del_init_rcu(struct hlist_nulls_node *n)
 #define hlist_nulls_next_rcu(node) \
 	(*((struct hlist_nulls_node __rcu __force **)&(node)->next))
 
+
+/**
+ * hlist_nulls_pprev_rcu - returns the element of the list before @node.
+ * @node: element of the list.
+ */
+#define hlist_nulls_pprev_rcu(node) \
+	(*((struct hlist_nulls_node __rcu __force **)(node)->pprev))
+
 /**
  * hlist_nulls_del_rcu - deletes entry from hash list without re-initialization
  * @n: the element to delete from the hash list.
@@ -145,6 +153,40 @@ static inline void hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
 	}
 }
 
+/**
+ * hlist_nulls_replace_rcu - replace an element in hash list
+ * @n: new element to add
+ * @o: old element to replace
+ *
+ * Description:
+ * Replace an existing element in a hash list with a new one,
+ * while permitting racing traversals.
+ *
+ * The caller must take whatever precautions are necessary
+ * (such as holding appropriate locks) to avoid racing
+ * with another list-mutation primitive, such as hlist_nulls_add_head_rcu()
+ * or hlist_nulls_del_rcu(), running on this same list.
+ * However, it is perfectly legal to run concurrently with
+ * the _rcu list-traversal primitives, such as
+ * hlist_nulls_for_each_entry_rcu(), used to prevent memory-consistency
+ * problems on Alpha CPUs.  Regardless of the type of CPU, the
+ * list-traversal primitive must be guarded by rcu_read_lock().
+ */
+static inline void hlist_nulls_replace_rcu(struct hlist_nulls_node *n,
+					   struct hlist_nulls_node *o)
+{
+	struct hlist_nulls_node *next = o->next;
+	struct hlist_nulls_node **pprev = o->pprev;
+
+	WRITE_ONCE(n->next, next);
+	WRITE_ONCE(n->pprev, pprev);
+	rcu_assign_pointer(hlist_nulls_pprev_rcu(o), n);
+
+	if (!is_a_nulls(next))
+		WRITE_ONCE(next->pprev, &n->next);
+	WRITE_ONCE(o->pprev, LIST_POISON2);
+}
+
 /* after that hlist_nulls_del will work */
 static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
 {
-- 
2.48.1


