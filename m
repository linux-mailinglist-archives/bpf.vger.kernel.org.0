Return-Path: <bpf+bounces-59095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AC6AC6051
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8E4B9E75C6
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EAE20C038;
	Wed, 28 May 2025 03:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YelcOWo7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BBF205AA8;
	Wed, 28 May 2025 03:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404192; cv=none; b=LmekRS/ekLurX7H+3IfH3ydo2OZu6VfnseBacsAoJgSIt/EsxLy2uQxu5ROB65pvsfVyz1d5xUTSRzrpQGiLeU+fUNKCQ40WphgYcIWw4J2fvccWlwhGBuud3DODAc/3j6mxihj7vQk+PP2F/4815AOGmQcPo+sbbPmTTt1+Ppo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404192; c=relaxed/simple;
	bh=qClQDl93AFZQUdkbU/XbVWIXBVJtxF9wpQ2WNufjqEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k9pnnFggGC9Y6q/Uksf3vXi/UmcoCUtWlD/BjYUvy3Sp+bnRhfTh00qrifoJZa+hfke83IvJLmOFb2ECrztM/haXm648y2/cYZbMSttk5fMASa9QumAJVNDP7DvYib3pSZyJn4WdcSjJIF1XEcgL+YsBBuJoD5Rt32Bq4F3VQ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YelcOWo7; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2347b7d6aeeso25625285ad.2;
        Tue, 27 May 2025 20:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748404190; x=1749008990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOx80xOj6UGzmt1Y5Dc93j8W1eKLEy1T+1F8mwGiOv4=;
        b=YelcOWo7gtmh2YD1Ne/cPCCWha23KBR5lXJ73Fbp8e9OdBZnBVcVZNWv7PAms0XGux
         dn2b/4Wh1WbMQ0GJIJd1vQ5pDanvtd8sjGOctKeZ8hKuL2lQIwumUS9DkLHiIfSUf422
         9HBoqjEo17E56RAzyKnokmgsuAtin4MPu+mVQRLNruzkg39zYwtH1Od3ff133kMVMtBJ
         sc7qwJSAG6eKPgpvzCEw5OyIgoZJadXWoahI2K9Ccj9/30vqh0ViaBo/F0sppdTpRjqI
         OUG2XvibTdLW0OtJtOV+ddrtSXIbHbMyqbQ/Z3GBmbhmXxAr1yU0ZjqR5qugdx1pOLhG
         3T8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404190; x=1749008990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOx80xOj6UGzmt1Y5Dc93j8W1eKLEy1T+1F8mwGiOv4=;
        b=UNcF4tjCEsN77tPP9/+tbckjyIMB3O4lwlPEunIPfMlL+WGvlZM8l2QMFjVIyO3Ajv
         egpWETc7DpY3w19Yy0l2ufQ3Dghj29WtfWCPdHVzXDDpESglFHdvaGNSm+6W2g1F30jg
         yL+CU33EuVzsyRLoxsNNM1/3MX5zNilPJl4HhhsZ+X5r7Opj77hxOChxm3uvd4gfQkIr
         sPOVmJvFvKkeApCMSmIqqbGy8V9hfFdrHKWCTvpc94HpUCqhBhlik1n9cmQ87hYuMfLW
         9Q8Rmnc09aq0L5JwLxq4N9uMPv3en/m7njuKCoZ2xtdKzwHYVqZtaNjKFdg334oyoOW+
         z5Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWT2KqqqWM5QKARCu5Sn+VsopCl9w/iYhlW3kPjqL7b2v6R1/FJ3krNmtJ9lzIwYi+GbryF91Uynk5wyUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUFvSYzDNu7HXZjV+p5ZmzYsJ+7sGCBQoI6GVQ8Dych2uoPWaP
	v2wq/2ov3ZhfUAN1ONeRjEdwlchulxoF4Iw0tNGalz9cS06nOSj7bKxo
X-Gm-Gg: ASbGnctQNm03mcWuBEpI5LJ381M/JtnoL7jvk9lyGqRs9VNJ5Kuqq8i6VlbvZW0NEmr
	Or2/FFgaHwA/eGrD45SgVSZzUyusYR0ZDf31JN7UL89DiO1QXKT9Km6vTHFNL3K0yATBg2gK3EZ
	4tiiNFH8SXWDYAUsTPvHI1dwQUbMobaPXSRQOeskQazgf2dK19OZUMqmk/9tYvIF5rGcGWMcDGc
	9/JFolDZArUGFM6C7mDRZIWwdZ7AkABNMb53kj1/kMByF2o0sVgFw+tRb5pDmVyGKn2cWmfI96S
	8hf1aKUQqIICfjltDt8t8PEiOpfG9K4MdBSmhCCC5CrCitnqqWguL+887CR8hQcMD4vw
X-Google-Smtp-Source: AGHT+IE6ZFsizyOf792pJ/ak7j1cTxvY1Gh9OREX0qMHn+XSFclTKgeM3tAhcUYnIIYWMAUoZ6pujg==
X-Received: by 2002:a17:903:1311:b0:234:bca7:2921 with SMTP id d9443c01a7336-234bca736d0mr30224255ad.33.1748404189612;
        Tue, 27 May 2025 20:49:49 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm2074505ad.169.2025.05.27.20.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:49:49 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 06/25] ftrace: factor out ftrace_direct_update from register_ftrace_direct
Date: Wed, 28 May 2025 11:46:53 +0800
Message-Id: <20250528034712.138701-7-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250528034712.138701-1-dongml2@chinatelecom.cn>
References: <20250528034712.138701-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out ftrace_direct_update() from register_ftrace_direct(), which is
used to add new entries to the direct_functions. This function will be
used in the later patch.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/trace/ftrace.c | 108 +++++++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 48 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 61130bb34d6c..a1028942e743 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5910,53 +5910,18 @@ static void register_ftrace_direct_cb(struct rcu_head *rhp)
 	free_ftrace_hash(fhp);
 }
 
-/**
- * register_ftrace_direct - Call a custom trampoline directly
- * for multiple functions registered in @ops
- * @ops: The address of the struct ftrace_ops object
- * @addr: The address of the trampoline to call at @ops functions
- *
- * This is used to connect a direct calls to @addr from the nop locations
- * of the functions registered in @ops (with by ftrace_set_filter_ip
- * function).
- *
- * The location that it calls (@addr) must be able to handle a direct call,
- * and save the parameters of the function being traced, and restore them
- * (or inject new ones if needed), before returning.
- *
- * Returns:
- *  0 on success
- *  -EINVAL  - The @ops object was already registered with this call or
- *             when there are no functions in @ops object.
- *  -EBUSY   - Another direct function is already attached (there can be only one)
- *  -ENODEV  - @ip does not point to a ftrace nop location (or not supported)
- *  -ENOMEM  - There was an allocation failure.
- */
-int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
+static int ftrace_direct_update(struct ftrace_hash *hash, unsigned long addr)
 {
-	struct ftrace_hash *hash, *new_hash = NULL, *free_hash = NULL;
 	struct ftrace_func_entry *entry, *new;
+	struct ftrace_hash *new_hash = NULL;
 	int err = -EBUSY, size, i;
 
-	if (ops->func || ops->trampoline)
-		return -EINVAL;
-	if (!(ops->flags & FTRACE_OPS_FL_INITIALIZED))
-		return -EINVAL;
-	if (ops->flags & FTRACE_OPS_FL_ENABLED)
-		return -EINVAL;
-
-	hash = ops->func_hash->filter_hash;
-	if (ftrace_hash_empty(hash))
-		return -EINVAL;
-
-	mutex_lock(&direct_mutex);
-
 	/* Make sure requested entries are not already registered.. */
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
 		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
 			if (ftrace_find_rec_direct(entry->ip))
-				goto out_unlock;
+				goto out;
 		}
 	}
 
@@ -5969,7 +5934,7 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 		size = FTRACE_HASH_MAX_BITS;
 	new_hash = alloc_ftrace_hash(size);
 	if (!new_hash)
-		goto out_unlock;
+		goto out;
 
 	/* Now copy over the existing direct entries */
 	size = 1 << direct_functions->size_bits;
@@ -5977,7 +5942,7 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 		hlist_for_each_entry(entry, &direct_functions->buckets[i], hlist) {
 			new = add_hash_entry(new_hash, entry->ip);
 			if (!new)
-				goto out_unlock;
+				goto out;
 			new->direct = entry->direct;
 		}
 	}
@@ -5988,16 +5953,67 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
 			new = add_hash_entry(new_hash, entry->ip);
 			if (!new)
-				goto out_unlock;
+				goto out;
 			/* Update both the copy and the hash entry */
 			new->direct = addr;
 			entry->direct = addr;
 		}
 	}
 
-	free_hash = direct_functions;
 	rcu_assign_pointer(direct_functions, new_hash);
 	new_hash = NULL;
+	err = 0;
+out:
+	if (new_hash)
+		free_ftrace_hash(new_hash);
+
+	return err;
+}
+
+/**
+ * register_ftrace_direct - Call a custom trampoline directly
+ * for multiple functions registered in @ops
+ * @ops: The address of the struct ftrace_ops object
+ * @addr: The address of the trampoline to call at @ops functions
+ *
+ * This is used to connect a direct calls to @addr from the nop locations
+ * of the functions registered in @ops (with by ftrace_set_filter_ip
+ * function).
+ *
+ * The location that it calls (@addr) must be able to handle a direct call,
+ * and save the parameters of the function being traced, and restore them
+ * (or inject new ones if needed), before returning.
+ *
+ * Returns:
+ *  0 on success
+ *  -EINVAL  - The @ops object was already registered with this call or
+ *             when there are no functions in @ops object.
+ *  -EBUSY   - Another direct function is already attached (there can be only one)
+ *  -ENODEV  - @ip does not point to a ftrace nop location (or not supported)
+ *  -ENOMEM  - There was an allocation failure.
+ */
+int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
+{
+	struct ftrace_hash *hash, *free_hash = NULL;
+	int err = -EBUSY;
+
+	if (ops->func || ops->trampoline)
+		return -EINVAL;
+	if (!(ops->flags & FTRACE_OPS_FL_INITIALIZED))
+		return -EINVAL;
+	if (ops->flags & FTRACE_OPS_FL_ENABLED)
+		return -EINVAL;
+
+	hash = ops->func_hash->filter_hash;
+	if (ftrace_hash_empty(hash))
+		return -EINVAL;
+
+	mutex_lock(&direct_mutex);
+
+	free_hash = direct_functions;
+	err = ftrace_direct_update(hash, addr);
+	if (err)
+		goto out_unlock;
 
 	ops->func = call_direct_funcs;
 	ops->flags = MULTI_FLAGS;
@@ -6005,15 +6021,11 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	ops->direct_call = addr;
 
 	err = register_ftrace_function_nolock(ops);
-
- out_unlock:
-	mutex_unlock(&direct_mutex);
-
 	if (free_hash && free_hash != EMPTY_HASH)
 		call_rcu_tasks(&free_hash->rcu, register_ftrace_direct_cb);
 
-	if (new_hash)
-		free_ftrace_hash(new_hash);
+ out_unlock:
+	mutex_unlock(&direct_mutex);
 
 	return err;
 }
-- 
2.39.5


