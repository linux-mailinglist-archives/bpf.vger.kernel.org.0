Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1923FC536
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 11:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240807AbhHaJxE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 05:53:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51258 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240785AbhHaJxC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 31 Aug 2021 05:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630403527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LSGXz5zVkm4f250jTbRF6daIOdS+MoPdJeoX8bvDLJI=;
        b=FLwOo/Q4AVUic2DBmZ3oTuyYEvB7DjhB4GLSDjGc6J/ah1KWxB8Y1LGFxjHbRuoeOhxeRc
        55VUzOlanDtzoHHUv2g5VnA1h/HbV4tXgj3nn/mi4E0tytSC+YeNldRARPjRQ7b6F6LAQJ
        Sp84bdVdEGo2BylGOooVcjR9/kVJwfk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-QDvS53KOM-G1HGvxYRZbaQ-1; Tue, 31 Aug 2021 05:50:58 -0400
X-MC-Unique: QDvS53KOM-G1HGvxYRZbaQ-1
Received: by mail-wr1-f71.google.com with SMTP id v18-20020adfe2920000b029013bbfb19640so3855763wri.17
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 02:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LSGXz5zVkm4f250jTbRF6daIOdS+MoPdJeoX8bvDLJI=;
        b=V/lhUiBwRjKiY/DiOj8B/EzdehzYJXMKlMJhxMt1unKGYwNJpb62rS2eYtG1X4wEYl
         v+5U5jq6vTdmQgmL7wQOPuF+6W7qK/aKSGkh8/suyNJE3e9zyz8EtP0mgE6GeaPvzRvH
         mSTauf0vhCW3CEP6AcYJcgtK3yPB0ePsfsFFmmMsPgu5rynO/7IuYdXlWYUv+dHQYKj9
         Sj7+2m/qRAq1qo/CAh+BbaHzqw2RgiieA0GpAvEEa5ymUNfpKU9i18BIBpkR0ZgGMo6S
         YthXpLvYFcRNunkPqgUR9/hrw+/DVjoUFceLcFXAAbEd+2aullqGBZDTK2m0g0iF8369
         67qA==
X-Gm-Message-State: AOAM533Dlj7dv8i8sVnmnkZRf6I/35YtK5lP6fWt/7K3c+Zy6jXrrVJK
        iouU8ABQftgIKrMYp/F4odnRjwr1VLh77swjATq4RZN5+vm8er4iqbIECdSUiZaSotcT0kaKW3+
        C6hSxR+mdqSN0
X-Received: by 2002:a7b:cd88:: with SMTP id y8mr3366206wmj.24.1630403456620;
        Tue, 31 Aug 2021 02:50:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxlq+Ojis0honlAiaLLzNSjgQeVRglyDlMRqLeiDYCnLJvpLvP0AheHktCif43/fBYU6dnmw==
X-Received: by 2002:a7b:cd88:: with SMTP id y8mr3366193wmj.24.1630403456462;
        Tue, 31 Aug 2021 02:50:56 -0700 (PDT)
Received: from krava.redhat.com ([94.113.247.3])
        by smtp.gmail.com with ESMTPSA id q14sm11278818wrc.31.2021.08.31.02.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 02:50:56 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH 6/8] ftrace: Add multi direct register/unregister interface
Date:   Tue, 31 Aug 2021 11:50:15 +0200
Message-Id: <20210831095017.412311-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831095017.412311-1-jolsa@kernel.org>
References: <20210831095017.412311-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding interface to register multiple direct functions
within single call. Adding following functions:

  register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
  unregister_ftrace_direct_multi(struct ftrace_ops *ops)

The register_ftrace_direct_multi registers direct function (addr)
with all functions in ops filter. The ops filter can be updated
before with ftrace_set_filter_ip calls.

All requested functions must not have direct function currently
registered, otherwise register_ftrace_direct_multi will fail.

The unregister_ftrace_direct_multi unregisters ops related direct
functions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/ftrace.h |  11 ++++
 kernel/trace/ftrace.c  | 111 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index d399621a67ee..e40b5201c16e 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -316,7 +316,10 @@ int ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
 				unsigned long old_addr,
 				unsigned long new_addr);
 unsigned long ftrace_find_rec_direct(unsigned long ip);
+int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
+int unregister_ftrace_direct_multi(struct ftrace_ops *ops);
 #else
+struct ftrace_ops;
 # define ftrace_direct_func_count 0
 static inline int register_ftrace_direct(unsigned long ip, unsigned long addr)
 {
@@ -346,6 +349,14 @@ static inline unsigned long ftrace_find_rec_direct(unsigned long ip)
 {
 	return 0;
 }
+static inline int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+{
+	return -ENODEV;
+}
+static inline int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c60217d81040..7243769493c9 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5407,6 +5407,117 @@ int modify_ftrace_direct(unsigned long ip,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(modify_ftrace_direct);
+
+#define MULTI_FLAGS (FTRACE_OPS_FL_IPMODIFY | FTRACE_OPS_FL_DIRECT | \
+		     FTRACE_OPS_FL_SAVE_REGS)
+
+static int check_direct_multi(struct ftrace_ops *ops)
+{
+	if (!(ops->flags & FTRACE_OPS_FL_INITIALIZED))
+		return -EINVAL;
+	if ((ops->flags & MULTI_FLAGS) != MULTI_FLAGS)
+		return -EINVAL;
+	return 0;
+}
+
+int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+{
+	struct ftrace_hash *hash, *free_hash = NULL;
+	struct ftrace_func_entry *entry, *new;
+	int err = -EBUSY, size, i;
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
+	/* Make sure requested entries are not already registered.. */
+	size = 1 << hash->size_bits;
+	for (i = 0; i < size; i++) {
+		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
+			if (ftrace_find_rec_direct(entry->ip))
+				goto out_unlock;
+		}
+	}
+
+	/* ... and insert them to direct_functions hash. */
+	err = -ENOMEM;
+	for (i = 0; i < size; i++) {
+		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
+			new = ftrace_add_rec_direct(entry->ip, addr, &free_hash);
+			if (!new)
+				goto out_remove;
+			entry->direct = addr;
+		}
+	}
+
+	ops->func = call_direct_funcs;
+	ops->flags = MULTI_FLAGS;
+	ops->trampoline = FTRACE_REGS_ADDR;
+
+	err = register_ftrace_function(ops);
+
+ out_remove:
+	if (err) {
+		for (i = 0; i < size; i++) {
+			hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
+				new = __ftrace_lookup_ip(direct_functions, entry->ip);
+				if (new) {
+					remove_hash_entry(direct_functions, new);
+					kfree(new);
+				}
+			}
+		}
+	}
+
+ out_unlock:
+	mutex_unlock(&direct_mutex);
+
+	if (free_hash) {
+		synchronize_rcu_tasks();
+		free_ftrace_hash(free_hash);
+	}
+	return err;
+}
+EXPORT_SYMBOL_GPL(register_ftrace_direct_multi);
+
+int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
+{
+	struct ftrace_hash *hash = ops->func_hash->filter_hash;
+	struct ftrace_func_entry *entry, *new;
+	int err, size, i;
+
+	if (check_direct_multi(ops))
+		return -EINVAL;
+	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
+		return -EINVAL;
+
+	mutex_lock(&direct_mutex);
+	err = unregister_ftrace_function(ops);
+
+	size = 1 << hash->size_bits;
+	for (i = 0; i < size; i++) {
+		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
+			new = __ftrace_lookup_ip(direct_functions, entry->ip);
+			if (new) {
+				remove_hash_entry(direct_functions, new);
+				kfree(new);
+			}
+		}
+	}
+
+	mutex_unlock(&direct_mutex);
+	return err;
+}
+EXPORT_SYMBOL_GPL(unregister_ftrace_direct_multi);
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 /**
-- 
2.31.1

