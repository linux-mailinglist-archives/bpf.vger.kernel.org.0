Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B4233DD2B
	for <lists+bpf@lfdr.de>; Tue, 16 Mar 2021 20:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240334AbhCPTK5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Mar 2021 15:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240332AbhCPTKt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Mar 2021 15:10:49 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A0CC06174A
        for <bpf@vger.kernel.org>; Tue, 16 Mar 2021 12:10:49 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so1949516pjg.5
        for <bpf@vger.kernel.org>; Tue, 16 Mar 2021 12:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SglmtjaV/e3PlEoT5Ri5+doiX8k7hyqQ3wAzknTS3iQ=;
        b=QGuSKOgRP7lwsMl0SqKozhpBW7HllK4J5lhacbJeui8NI7IKOuNdEC/Sr3qwwmxwmO
         W9Qmb7KuUbdj8bCb5DEKoc0Td8wALOug/UfZOLuYk+3rhjILttLT0boKFf2ihZE+khri
         mZXyjXnreECJg512/LJi1dl6NSIvSmma428FrjFny9sUAnTdc4bit1xy7woxyEtxp2L+
         Kyn0/hE+6XodqSvAKWQ28hj0JUBWaKr+9q48jdNYqOM1299H1Bo5qm20G4DI5T2VBlQa
         CUp13hDpr+n/5vQvAfNAOzjC333I3gCJZWyu7wRFU06oit9DchxlQkgANeqRiRsu6nI7
         ERtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SglmtjaV/e3PlEoT5Ri5+doiX8k7hyqQ3wAzknTS3iQ=;
        b=imHl5bJ4l74xAa7PVU1P/DUa28c65/Gic36BfCOD+kOOR+7Va9DVb+gvyVtJ08qfKZ
         W44DjzQYz5eNh6DmA0Syd4u1aRnsOH6GCC3mcWpaeKQfnydtRZ4E97yQQ8jqDKdp4phM
         GJ4j4azK6+yaX+mMcS1JmUuE3lrfmqvqtAabSqL2Q9i7b/0X/AkurjFEfE/ksxDHIKps
         1SpddfXGvi4gkwkmyU5E3O+gHgpT/YqVQ5qV+doiQXd2hB+NZs7pa0+/o/5izT5ceDil
         SmGNUuIVhiekZnzljPfEPlTiGaLwrS0S0YfiH8ZmlKqwFGl3l7wk1ienc/M8mUG5kggu
         Mdqw==
X-Gm-Message-State: AOAM5331hyj/z1GPsd1lwWStkPmQ2Y9RKePRcRCPHXNDEZ+wX0sLO2vW
        jQ1diU6lgh9WEhH3e43zlOVerwYEjXs=
X-Google-Smtp-Source: ABdhPJxkELycbIP9mqLhPSAHVxME6gLlZS1vdBYe2yIQQr9GrzfKIP1bbeziwra8G1jkh+522WTyig==
X-Received: by 2002:a17:902:e8d3:b029:e3:cb77:2dde with SMTP id v19-20020a170902e8d3b02900e3cb772ddemr947211plg.78.1615921848858;
        Tue, 16 Mar 2021 12:10:48 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id 76sm4766599pfw.156.2021.03.16.12.10.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Mar 2021 12:10:48 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, rostedt@goodmis.org, andrii@kernel.org,
        paulmck@kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 bpf] ftrace: Fix modify_ftrace_direct.
Date:   Tue, 16 Mar 2021 12:10:46 -0700
Message-Id: <20210316191046.28002-1-alexei.starovoitov@gmail.com>
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
Steven,
I think I've changed it the way you requested. Please ack if so.

 kernel/trace/ftrace.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4d8e35575549..1f94a100e587 100644
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
+	struct ftrace_direct_func *direct, *new_direct;
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
-- 
2.30.2

