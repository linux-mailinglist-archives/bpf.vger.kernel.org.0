Return-Path: <bpf+bounces-62258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 086CBAF73A3
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 14:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3150117E44E
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 12:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1592E54BE;
	Thu,  3 Jul 2025 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVhDH89t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91022E7171;
	Thu,  3 Jul 2025 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545046; cv=none; b=creiBBwyEvxGdjoZe+bF4zJV4f7InfA+XNTEbJZqNfAvoaztfjswpozAjyldeTxzjIr5D23hItNzaDgTTzm11OKafljyl2JDjetmacQPGk9ZrvcRgrXG5O7SHJJxVa2oIX8pnQhb/38NRHkMZrsx8aTED95EnJqDJ8tyIznVRQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545046; c=relaxed/simple;
	bh=/Oe9jRZcIwjwGcxoepezqgUx0mUi9iamEnH4VhUcS+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rAuTy6q3WR/HwiFGC5xmX3fQl2e30BTpuDsw6X9Dg2gQRIkIHinOs09cSJfda9xpATRTnsdvyTATEG1rbMW3Ye0m3/8Wxikj/bhywzjhsIH2ip7X+KedmsUeCfR5ak+vq/3kI13avSjYnJlL6iaJ5wd5z6DsbK+k8cZHn6X+k4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVhDH89t; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso5101841b3a.0;
        Thu, 03 Jul 2025 05:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751545041; x=1752149841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7C3sp0lcxp6ETG6ha4QtbdvqdygHhhPolCn9haFSGfU=;
        b=hVhDH89tWgd1a+7HkJCE2r/7TpxuaTPfvppkR1I1C/vqLOZW6aH/6Mcbi+y9LFR5qK
         KgY0nIT8YIfThkYbiSpcgTxcURtDDbNjOON+CyvRUHQoklX4i3CpUuwuk/U8tQXgko+D
         O6YMvdl+jQkON/9wqpFC2kQg8oozSZpE7wwUISCXeI3Jt25SzHCzXjgzYf3iJC5OnIyV
         e/SQ4SOrEIxJr3+L4Sqbq7uHSiX8xXpk/bFH9YS1fOCU272R7jWya5dxfUmV4CSmDKcg
         M2DiPgNfBQ/7ow50zFD9hQCBOUR0z3+8kisGoRykPm7B0S7o+AxXnrkEqxoiGp8d7+gT
         TfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545041; x=1752149841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7C3sp0lcxp6ETG6ha4QtbdvqdygHhhPolCn9haFSGfU=;
        b=LjVYM7Y64n2556tiBY/ToprjhI+JJY4ud7FUo1EBQSN6kzMbKqeoiPThaqBr9XtOrt
         XT1ifPmOKfdMRQfAWR5A2aemhd49/BL5ySy7b5om22VZDpASkAVoCUsCRfAS732mX39u
         4DQHKx7pV+n+lZhFIeKiWDnQdFCQWGSmAub7T7WyS0IdaEccWQGpvmGGkel1TBwIO3Wd
         czDqnNhUHqn4ifskfKMqF8bRUMNTiaU+O5LIXdwjfdWd4uhuwSe4pe1SMhg6av4bJqiR
         kuSkTQfD5ET0n8N1kr104Htn7I0YgH6PtU3uMPBIUqwt6iOuDoIsxb9S+F9tF3i/eIZK
         JPPg==
X-Forwarded-Encrypted: i=1; AJvYcCUklt69HaPbTF8k60+V/NCwNZuIBgWEcKvdvcUmKeT5zJ2YUQi9qBnHyEjIC/ef4ox07KYaEpH4MLmJ/ac=@vger.kernel.org, AJvYcCXYpSduUjPSdXSs9Bk3is2mQB24o0bBlH0agtmGHqpEYiIhog6jsFWYGLFrolgAQblANOZuis/qFKEfeQn/zxCt+sMY@vger.kernel.org
X-Gm-Message-State: AOJu0YwLYp4K/Rw5d1bRwbfNn/tsEu4NxYugC1kQf+yhSVSaKyn+yoRl
	6gCH8DjWJoI9GldPt3omaCodX09E/Fc67aMW1u6+VnoHj8V7zC4zl8Jp
X-Gm-Gg: ASbGncurdVe2vYtCAXo6QAhK9o+7HPFkrBckmxboHwABzn9leeuu7o/6xpaK46I4bBi
	grb+wpdaPF1Vycp01XTLBkseMJ0R0ntjhncXOmobGKSKmtBGtWbbJKPB3mg+2MQsnLRodStXRn+
	FfzwoINZ56XeaWCVrZyKY50V4b77Aj0KSOy0p3K1YNftVjzA0lExCQDyc22i1I82MtthmVNgzMW
	pl5EF0TJ2hoA4+r0r2uMwQupy9/zAE1MewTPxxDvTN9COccT4s1eXvfPH1EkEplT2F3Ptb7rtlq
	ANuteNHGKLq6ZIvp1PFl8DaSM7nW1APnks4iEDJN3smh9TWmqcJIo++/cyc6wXrKfJdAv272C7E
	4mY82LqlrsnKMwg==
X-Google-Smtp-Source: AGHT+IGCSxxX6rw53hMCjEjL5D+eidILLLCKHa9JtfaxpbwrpzORhKcsdox21esdUIjrA+QSZrF4zg==
X-Received: by 2002:a05:6a00:848:b0:73e:10ea:b1e9 with SMTP id d2e1a72fcca58-74b5103e10amr8569391b3a.6.1751545041156;
        Thu, 03 Jul 2025 05:17:21 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5575895sm18591081b3a.94.2025.07.03.05.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 05:17:20 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 03/18] ftrace: factor out ftrace_direct_update from register_ftrace_direct
Date: Thu,  3 Jul 2025 20:15:06 +0800
Message-Id: <20250703121521.1874196-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
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
index 4203fad56b6c..f5f6d7bc26f0 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5953,53 +5953,18 @@ static void register_ftrace_direct_cb(struct rcu_head *rhp)
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
 
@@ -6012,7 +5977,7 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 		size = FTRACE_HASH_MAX_BITS;
 	new_hash = alloc_ftrace_hash(size);
 	if (!new_hash)
-		goto out_unlock;
+		goto out;
 
 	/* Now copy over the existing direct entries */
 	size = 1 << direct_functions->size_bits;
@@ -6020,7 +5985,7 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 		hlist_for_each_entry(entry, &direct_functions->buckets[i], hlist) {
 			new = add_hash_entry(new_hash, entry->ip);
 			if (!new)
-				goto out_unlock;
+				goto out;
 			new->direct = entry->direct;
 		}
 	}
@@ -6031,16 +5996,67 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
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
@@ -6048,15 +6064,11 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
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


