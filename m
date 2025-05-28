Return-Path: <bpf+bounces-59105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812CEAC6063
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22BAB7A502B
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9771F37D3;
	Wed, 28 May 2025 03:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GR5Fi5x+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63901F17E8;
	Wed, 28 May 2025 03:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404213; cv=none; b=FlRZfuvEdax3cceJ5+zrrSO1OkDoIn1BZmFwHqyI+HE+SN5vhkIKmM0cnmqwP2H4NbTQ7nylF9riW6N9H8EOg40hsCQc6lUNUUcdejGwJ0ET2iLpcf7Vb33LVk5E0y3yDGfElsrerpCcoA//ZkBhnshO0vBhpai0++K7RZilju0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404213; c=relaxed/simple;
	bh=1fwUg9kN1ZusHPzIWHFgs+cuOvftS0FFPnEIprFNV2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WiBKGHgv8MuupV3PLnt9QEx3I4fzqvh0zG5txasJ7P2eSPGWRQKyYIQSjuwxdzXs/97igmn811Of7D7GLXn0s4LRVarHEMZ3hmO/SugHUJT3L0OqO0MapVt7AbyJJg04+QyrHYwO9g/cozeS4DJC/PO5w5TJ+yjY1rrtqqe9wgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GR5Fi5x+; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b26d7ddbfd7so3498800a12.0;
        Tue, 27 May 2025 20:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748404211; x=1749009011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKvUSOWXMccipDrf7DsG0TgpjJedGkWJTSZCOMyRAZY=;
        b=GR5Fi5x+lfDb+iWkgfkuomPSHH5pmM5KpvqPb2nj5GJ9mltJM2ptPY/2oP+IGgdUYh
         Jy3CrevsC3dLGOogbRJKA8Ua6X4uv9YhnPl3IRwVgj1TbCNo+/uxvPiJ5oFty/i0nG3J
         /IrM2SteTp2wrj99dTn1osswIQzWoA8wi6wHTQIjEuOUDMujkklDz1sw+IP57N6t305U
         74CtarBnS56MOg1s4ZquAKH1fpAOIqJWkndOhNBr0rF4mqcL2EyNpRPJ5MBKaINHrKjs
         d615WpzeqSOTIJUHM7uQ21cGz+Wns222V4yrV6tk+rVMjOlFeEfZNB1vZPodr8dUoBwg
         ftjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404211; x=1749009011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKvUSOWXMccipDrf7DsG0TgpjJedGkWJTSZCOMyRAZY=;
        b=Y/KlCUu8kNGdhwf6dJR2gCztMJFbvD6/6SqDF7xMbUFykFt/wbBKNry/XDatU5iSjU
         y4vJLw06UxtDBtjfuUK+nqvjWXbErQBe8xFWcyVebfpI6Vx24evAYgnsyRIcOcV7ZS9I
         iWtvxW8iSit5fF6u68C5mZXd7WfaJ4ShZ9TYiynsIiWAIkr56lXq5haUTg3R5fQc1YRd
         7tZZfUDcMCNFYTxPQjmsSFUsBRLjOEhXLDCNqwusahgOM1lS9nFL2MxN9MWyd6XPtSbs
         ZwML1rTs0G/JRV/joxZsHZSaWJW8HH51JfKKNTkFK5t7kcgXSSAT6kwFvlBF9fITiyoE
         UUyA==
X-Forwarded-Encrypted: i=1; AJvYcCUYtJlAjNWw/vLGvwLZW9OLMLudkChweTj71bsqXq9xGhfDFdT3YuFNzs/ytK1A35RbQEw1wjukJ6eOSPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOm96wtApmimaTzI/U9Z6qFQ/rTxhCdD+JNPJCUiD2g8AYkVg6
	AInTLVroV4EC0G5p/dwjDYslktKJx0O4BsaIpuoyjorpeADoertfZAPk
X-Gm-Gg: ASbGncsLEzO5ACv3XkUoAAM/wKKG/Ol7uZE1cHWS+LO1YpuyLzO+jveqLndwtRfkNbO
	4yQ++yjWSXsjnKfTHimasXiSwQhM9pJwQcPsxspLI8SngMTFsZxIkmXtTSm+eaDcphissWrr/Ac
	/PJ7FGvGpiTbYxyc9CH9YG/lJOo/M9/LQPx6jHg3fD2NqQvqYesAhBkJSUDU6xIU9IR0c6qoQU1
	e2u8t78rZjR0MSaqWAh50iTn6EAaXOC6MG2j5/kyEAc110NHVuig0DDO5QvuNHkF9KGKJCqy0sg
	WmCYG/WoI7ENP2Y45eszLfifbeT/FwlpCCHlhmXMwpPDswDlljpiLQDtIq9oxEhXy2C4
X-Google-Smtp-Source: AGHT+IGG2Sc/hwcLt/vu9eqQkgCFuls5UzM2jnZ1L14nDNHAJZrPgOboZLInAAAPUefuR7XUCLG7lA==
X-Received: by 2002:a17:902:cccb:b0:231:ecd5:e719 with SMTP id d9443c01a7336-23414fb5561mr294495325ad.24.1748404211034;
        Tue, 27 May 2025 20:50:11 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm2074505ad.169.2025.05.27.20.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:50:10 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 16/25] ftrace: supporting replace direct ftrace_ops
Date: Wed, 28 May 2025 11:47:03 +0800
Message-Id: <20250528034712.138701-17-dongml2@chinatelecom.cn>
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

Introduce the function replace_ftrace_direct(). This is used to replace
the direct ftrace_ops for a function, and will be used in the next patch.

Let's call the origin ftrace_ops A, and the new ftrace_ops B. First, we
register B directly, and the callback of the functions in A and B will
fallback to the ftrace_ops_list case.

Then, we modify the address of the entry in the direct_functions to
B->direct_call, and remove it from A. This will update the dyn_rec and
make the functions call b->direct_call directly. If no function in
A->filter_hash, just unregister it.

So a record can have more than one direct ftrace_ops, and we need check
if there is any direct ops for the record before remove the
FTRACE_OPS_FL_DIRECT in __ftrace_hash_rec_update().

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/ftrace.h |  8 ++++
 kernel/trace/ftrace.c  | 87 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 40727d3f125d..1d162e331e99 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -528,6 +528,9 @@ void ftrace_stub_direct_tramp(void);
 
 int reset_ftrace_direct_ips(struct ftrace_ops *ops, unsigned long *ips,
 			    unsigned int cnt);
+int replace_ftrace_direct(struct ftrace_ops *ops, struct ftrace_ops *src_ops,
+			  unsigned long addr);
+
 #else
 struct ftrace_ops;
 static inline unsigned long ftrace_find_rec_direct(unsigned long ip)
@@ -556,6 +559,11 @@ static inline int reset_ftrace_direct_ips(struct ftrace_ops *ops, unsigned long
 {
 	return -ENODEV;
 }
+static inline int replace_ftrace_direct(struct ftrace_ops *ops, struct ftrace_ops *src_ops,
+					unsigned long addr)
+{
+	return -ENODEV;
+}
 
 /*
  * This must be implemented by the architecture.
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 5b6b74ea4c20..7f2313e4c3d9 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1727,6 +1727,24 @@ static bool skip_record(struct dyn_ftrace *rec)
 		!(rec->flags & FTRACE_FL_ENABLED);
 }
 
+static struct ftrace_ops *
+ftrace_find_direct_ops_any_other(struct dyn_ftrace *rec, struct ftrace_ops *op_exclude)
+{
+	struct ftrace_ops *op;
+	unsigned long ip = rec->ip;
+
+	do_for_each_ftrace_op(op, ftrace_ops_list) {
+
+		if (op == op_exclude || !(op->flags & FTRACE_OPS_FL_DIRECT))
+			continue;
+
+		if (hash_contains_ip(ip, op->func_hash))
+			return op;
+	} while_for_each_ftrace_op(op);
+
+	return NULL;
+}
+
 /*
  * This is the main engine to the ftrace updates to the dyn_ftrace records.
  *
@@ -1831,8 +1849,10 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
 			 * function, then that function should no longer
 			 * be direct.
 			 */
-			if (ops->flags & FTRACE_OPS_FL_DIRECT)
-				rec->flags &= ~FTRACE_FL_DIRECT;
+			if (ops->flags & FTRACE_OPS_FL_DIRECT) {
+				if (!ftrace_find_direct_ops_any_other(rec, ops))
+					rec->flags &= ~FTRACE_FL_DIRECT;
+			}
 
 			/*
 			 * If the rec had REGS enabled and the ops that is
@@ -6033,6 +6053,69 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 }
 EXPORT_SYMBOL_GPL(register_ftrace_direct);
 
+int replace_ftrace_direct(struct ftrace_ops *ops, struct ftrace_ops *src_ops,
+			  unsigned long addr)
+{
+	struct ftrace_hash *hash;
+	struct ftrace_func_entry *entry, *iter;
+	int err = -EBUSY, size, count;
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
+	ops->func = call_direct_funcs;
+	ops->flags = MULTI_FLAGS;
+	ops->trampoline = FTRACE_REGS_ADDR;
+	ops->direct_call = addr;
+
+	err = register_ftrace_function_nolock(ops);
+	if (err)
+		goto out_unlock;
+
+	hash = ops->func_hash->filter_hash;
+	size = 1 << hash->size_bits;
+	for (int i = 0; i < size; i++) {
+		hlist_for_each_entry(iter, &hash->buckets[i], hlist) {
+			entry = __ftrace_lookup_ip(direct_functions, iter->ip);
+			if (!entry) {
+				err = -ENOENT;
+				goto out_unlock;
+			}
+			WRITE_ONCE(entry->direct, addr);
+			/* remove the ip from the hash, and this will make the trampoline
+			 * be called directly.
+			 */
+			count = src_ops->func_hash->filter_hash->count;
+			if (count <= 1) {
+				if (WARN_ON_ONCE(!count))
+					continue;
+				err = __unregister_ftrace_direct(src_ops, src_ops->direct_call,
+								 true);
+			} else {
+				err = ftrace_set_filter_ip(src_ops, iter->ip, 1, 0);
+			}
+			if (err)
+				goto out_unlock;
+		}
+	}
+
+out_unlock:
+	mutex_unlock(&direct_mutex);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(replace_ftrace_direct);
+
 /**
  * unregister_ftrace_direct - Remove calls to custom trampoline
  * previously registered by register_ftrace_direct for @ops object.
-- 
2.39.5


