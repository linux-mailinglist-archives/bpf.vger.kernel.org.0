Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BD133DE4B
	for <lists+bpf@lfdr.de>; Tue, 16 Mar 2021 20:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhCPT6d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Mar 2021 15:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbhCPT6T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Mar 2021 15:58:19 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A89C06174A
        for <bpf@vger.kernel.org>; Tue, 16 Mar 2021 12:58:18 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 18so9568450pfo.6
        for <bpf@vger.kernel.org>; Tue, 16 Mar 2021 12:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=a9CBjlAP5e33cA2QipBV/aoUrUumLdhfeslJJGZo7r4=;
        b=oyzzBGeXnkE9YSeF7VwxpLpRi88hcPvjAHaaLHQZVIQ0ZNdgazR0n+LfKeiAGmJ80G
         69c8HmiwH/MyQnpV1NPg9xgqjq8UkT8/iewf96eeRtyHmPKAaXTuc1b1x4G5n675+/16
         bqj2pW7YDAaDBkdzdwY9sNADspSUZHnxHaCLW3wnCfJcbokrTK47D7WwQ+exUWO+KqTW
         pgWfFqN2K3zeelgnQ2LGzOzZUMPkuqtLhtvCivf5Rk0pi5FNncfkbnZeuw1K+ZsA18Bh
         kopjXxDQQf0QQjagZUO28ilXaQkk28Zu8CHcMSG981jCK2q9OGSd2pujMCHqMEdI+zWA
         IOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a9CBjlAP5e33cA2QipBV/aoUrUumLdhfeslJJGZo7r4=;
        b=d1/R74u41sYGjWgTfWvgyZ7iVOFNiziL+YojHgRvVckqKKYsnXOvUfkyRJb6bK/eaI
         dhaOUyYjzBI27BiYr01DLccCBKXUKsI1jpqk84ZB64Tbu+lD2DcxGG4uHt2wzJwZnJuL
         kVbixseFz1g6b8p6swEdBQ4J/o51zapuOEzHfWoGjv4pvxS13YeOuhQCGF0JSUGquIUF
         5uu2OlHXrF7PRjToHNIiS18h9goTcoWTXV5LPHAt7rBdACW6MVC52NRWR/ZnWO+0ZABe
         r675LEy+oYGm/63SqdNCCt2aXTFGexMYYPkhpbSjtYmsRdqVC9/6vprlqj/a6QR9WlMQ
         XNFA==
X-Gm-Message-State: AOAM533mipOJon645TAK4YbunzIOO1hISRNiqdoMe2O8/omb9oDYyilX
        kQI0nvixWwGA9EAZEL59+Ag=
X-Google-Smtp-Source: ABdhPJxmX/welgs7wEGMCUDUe80sbHVZkqihasCiIiSX7ixqTdRM1QMVAmOuNpOkINd1bDGtkHFTFQ==
X-Received: by 2002:a63:74d:: with SMTP id 74mr1191128pgh.316.1615924698320;
        Tue, 16 Mar 2021 12:58:18 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id l190sm127290pfl.73.2021.03.16.12.58.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Mar 2021 12:58:17 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, rostedt@goodmis.org, andrii@kernel.org,
        paulmck@kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf] ftrace: Fix modify_ftrace_direct.
Date:   Tue, 16 Mar 2021 12:58:15 -0700
Message-Id: <20210316195815.34714-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

The following sequence of commands:
  register_ftrace_direct(ip, addr1);
  modify_ftrace_direct(ip, addr1, addr2);
  unregister_ftrace_direct(ip, addr2);
will cause the kernel to warn:
[   30.179191] WARNING: CPU: 2 PID: 1961 at kernel/trace/ftrace.c:5223 unregister_ftrace_direct+0x130/0x150
[   30.180556] CPU: 2 PID: 1961 Comm: test_progs    W  O      5.12.0-rc2-00378-g86bc10a0a711-dirty #3246
[   30.182453] RIP: 0010:unregister_ftrace_direct+0x130/0x150

When modify_ftrace_direct() changes the addr from old to new it should update
the addr stored in ftrace_direct_funcs. Otherwise the final
unregister_ftrace_direct() won't find the address and will cause the splat.

Fixes: 0567d6809182 ("ftrace: Add modify_ftrace_direct()")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/trace/ftrace.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4d8e35575549..40dd24db1708 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5045,6 +5045,20 @@ struct ftrace_direct_func *ftrace_find_direct_func(unsigned long addr)
 	return NULL;
 }
 
+struct ftrace_direct_func *ftrace_alloc_direct_func(unsigned long addr)
+{
+	struct ftrace_direct_func *direct;
+
+	direct = kmalloc(sizeof(*direct), GFP_KERNEL);
+	if (!direct)
+		return NULL;
+	direct->addr = addr;
+	direct->count = 0;
+	list_add_rcu(&direct->next, &ftrace_direct_funcs);
+	ftrace_direct_func_count++;
+	return direct;
+}
+
 /**
  * register_ftrace_direct - Call a custom trampoline directly
  * @ip: The address of the nop at the beginning of a function
@@ -5120,15 +5134,11 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
 
 	direct = ftrace_find_direct_func(addr);
 	if (!direct) {
-		direct = kmalloc(sizeof(*direct), GFP_KERNEL);
+		direct = ftrace_alloc_direct_func(addr);
 		if (!direct) {
 			kfree(entry);
 			goto out_unlock;
 		}
-		direct->addr = addr;
-		direct->count = 0;
-		list_add_rcu(&direct->next, &ftrace_direct_funcs);
-		ftrace_direct_func_count++;
 	}
 
 	entry->ip = ip;
@@ -5329,6 +5339,7 @@ int __weak ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
 int modify_ftrace_direct(unsigned long ip,
 			 unsigned long old_addr, unsigned long new_addr)
 {
+	struct ftrace_direct_func *direct, *new_direct = NULL;
 	struct ftrace_func_entry *entry;
 	struct dyn_ftrace *rec;
 	int ret = -ENODEV;
@@ -5344,6 +5355,20 @@ int modify_ftrace_direct(unsigned long ip,
 	if (entry->direct != old_addr)
 		goto out_unlock;
 
+	direct = ftrace_find_direct_func(old_addr);
+	if (WARN_ON(!direct))
+		goto out_unlock;
+	if (direct->count > 1) {
+		ret = -ENOMEM;
+		new_direct = ftrace_alloc_direct_func(new_addr);
+		if (!new_direct)
+			goto out_unlock;
+		direct->count--;
+		new_direct->count++;
+	} else {
+		direct->addr = new_addr;
+	}
+
 	/*
 	 * If there's no other ftrace callback on the rec->ip location,
 	 * then it can be changed directly by the architecture.
@@ -5357,6 +5382,14 @@ int modify_ftrace_direct(unsigned long ip,
 		ret = 0;
 	}
 
+	if (unlikely(ret && new_direct)) {
+		direct->count++;
+		list_del_rcu(&new_direct->next);
+		synchronize_rcu_tasks();
+		kfree(new_direct);
+		ftrace_direct_func_count--;
+	}
+
  out_unlock:
 	mutex_unlock(&ftrace_lock);
 	mutex_unlock(&direct_mutex);
-- 
2.30.2

