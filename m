Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19DE5A1F15
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 04:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244880AbiHZCpg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 22:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244887AbiHZCpf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 22:45:35 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24A411C27
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:45:33 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r22so215467pgm.5
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5QfgEJRNKJb9Ft7vW5lcHKllT7kM9P++zdYvapMUmos=;
        b=Dt5UAkUDbBjefvOUaA3JwJDmn9c263KT6p0l55eczhC/30hED/rRBGmjSwM0KunqG4
         XWSyRDDWW0oi+0b3rG1gG2EULZXUh9E9j/3ppRq5edceNB475Yx3ArA4hEoNXzrVRYmO
         g38h7PcJo+xdIeR7QCHxdd8km1QFh9SF+1GuLBuVV8HAPYRPnzRpSTFhrWsqFda6wwkt
         AER/Ggv2GXk0zRUmjXl8rc+/x0PvViOMJMeUcSzRs2c86Y0A3keROwxMXKO2XPA9UwK1
         B4W4jazxD64nmx4EIXvj9EH03fG9QfX0eHdzaYuiLrEVZL4vCiprb721PjLG/Vr7MMky
         NjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5QfgEJRNKJb9Ft7vW5lcHKllT7kM9P++zdYvapMUmos=;
        b=7gNAbwzNMeLm526btSUZcOZwY9LB+wdVSDTgl6X+skY5bBEpT67rDvQ5RBmqBQ7nY7
         MXMvREFAO2RxpeW1QlN+d6XncAQ0bYxAiZFP3WBS7Eyj7GevYWiCk+cEOd1rj+9VrG2Y
         A6RHXqPiT5E7whDE9AvUglQCrZoKOHzBc70TLvOYYhJ9rE8IU8H+lwGcqC6I09rSZTuU
         Gex7pxE1GXwwgmPMV2AmDQlSoksXlviWPAoXXBHsjV0VxdabbfZea5h0WPztL5PQpclo
         vhc9LfDaYvIdPLyD9qMcxXceZrUtelYfcEDj2hKbgceUL1iGf5fydVSSPd7aFuT0wcaD
         WCqg==
X-Gm-Message-State: ACgBeo2GB8FAyu29oba0Vlqz7uDFhoSqZNo91h2SQnjhkIr0wNJrf0kl
        qOUouysJ9tMnca5xZxUV/KI=
X-Google-Smtp-Source: AA6agR6UaEvgCLR+vyotD4u6O6LzVm1i7qrfbDu+HjQg3lGZNJbmdv8TJVzSmCnmZmdlYcZ4lg8wLw==
X-Received: by 2002:aa7:940b:0:b0:537:97d1:7897 with SMTP id x11-20020aa7940b000000b0053797d17897mr1941202pfo.26.1661481933321;
        Thu, 25 Aug 2022 19:45:33 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:15dc])
        by smtp.gmail.com with ESMTPSA id q1-20020a6557c1000000b0042b5b036da4sm284087pgr.68.2022.08.25.19.45.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Aug 2022 19:45:32 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 15/15] bpf: Introduce sysctl kernel.bpf_force_dyn_alloc.
Date:   Thu, 25 Aug 2022 19:44:30 -0700
Message-Id: <20220826024430.84565-16-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
References: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Introduce sysctl kernel.bpf_force_dyn_alloc to force dynamic allocation in bpf
hash map. All selftests/bpf should pass with bpf_force_dyn_alloc 0 or 1 and all
bpf programs (both sleepable and not) should not see any functional difference.
The sysctl's observable behavior should only be improved memory usage.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/filter.h | 2 ++
 kernel/bpf/core.c      | 2 ++
 kernel/bpf/hashtab.c   | 5 +++++
 kernel/bpf/syscall.c   | 9 +++++++++
 4 files changed, 18 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index a5f21dc3c432..eb4d4a0c0bde 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1009,6 +1009,8 @@ bpf_run_sk_reuseport(struct sock_reuseport *reuse, struct sock *sk,
 }
 #endif
 
+extern int bpf_force_dyn_alloc;
+
 #ifdef CONFIG_BPF_JIT
 extern int bpf_jit_enable;
 extern int bpf_jit_harden;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 639437f36928..a13e78ea4b90 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -533,6 +533,8 @@ void bpf_prog_kallsyms_del_all(struct bpf_prog *fp)
 	bpf_prog_kallsyms_del(fp);
 }
 
+int bpf_force_dyn_alloc __read_mostly;
+
 #ifdef CONFIG_BPF_JIT
 /* All BPF JIT sysctl knobs here. */
 int bpf_jit_enable   __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_DEFAULT_ON);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 89f26cbddef5..f68a3400939e 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -505,6 +505,11 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 
 	bpf_map_init_from_attr(&htab->map, attr);
 
+	if (!lru && bpf_force_dyn_alloc) {
+		prealloc = false;
+		htab->map.map_flags |= BPF_F_NO_PREALLOC;
+	}
+
 	if (percpu_lru) {
 		/* ensure each CPU's lru list has >=1 elements.
 		 * since we are at it, make each lru list has the same
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 074c901fbb4e..5c631244b63b 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5299,6 +5299,15 @@ static struct ctl_table bpf_syscall_table[] = {
 		.mode		= 0644,
 		.proc_handler	= bpf_stats_handler,
 	},
+	{
+		.procname	= "bpf_force_dyn_alloc",
+		.data		= &bpf_force_dyn_alloc,
+		.maxlen		= sizeof(int),
+		.mode		= 0600,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 	{ }
 };
 
-- 
2.30.2

