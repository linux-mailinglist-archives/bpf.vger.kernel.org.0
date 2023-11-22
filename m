Return-Path: <bpf+bounces-15726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A429B7F55CE
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 02:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB831C209A5
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 01:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB1015A2;
	Thu, 23 Nov 2023 01:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvxhF8eo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53315C1
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 17:21:19 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5c1f8b0c149so255106a12.3
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 17:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700702479; x=1701307279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5x5wCn+m1qlOislwiqC1Il1BdRTEuXZKH0bnS8IcXJA=;
        b=YvxhF8eoemnGhRUxeD87lJdcNk1I7fKbYezMyOJq0uNpC2kEbCMVGWG5NHFsyq1R3t
         zUIslPYMsTMaskKOxPLAvzVIwlughLXXooinimJmkK8IR7FhPc1roNtaUZExN0MXdKF1
         II1bU/Teog2Cbp3MTH6ojWXVf6mLhKi/gpNk9cXgRwjCP7s/QqL9qAdnFHz6EAKsozXH
         DmTZaNn6DYZg5BJG4iC+vo3OF4ehY5vdXSWllx1EdylUOy9tf5gMasrE6rrszDC0/NEp
         G5d8Vua9FRzMIngCW5d4h7soYWqOVLWdEj/sQNe8MHKShpQydR/GS7DZzbebVL/TWZ8o
         ScYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700702479; x=1701307279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5x5wCn+m1qlOislwiqC1Il1BdRTEuXZKH0bnS8IcXJA=;
        b=DwZ8ynsXLD3cyTYQ+1/2UD89G0eSBwUPjHCfzq8gJnihHUZ/V+3eEou5EcTsJGItbT
         TJDSG4qFv/Hp64QUCrF6NzN4kGZ8WzOpgaK5AyKNwdT/syXj3g3lA2X3BowsXiggYkRO
         3mBBdTpfZK2ddT743Snp2LzThn4nkTn6S4NiOaWyrDluvnrOvtwVvAoBRufPwdIBIKJ2
         s5A0hRSQmBfLX3+bTY6PNVQrVLKeAQgQ0f4+f2pxwpa4s+XTJiVf+J2Xyf8ROXbKDmHa
         j9wM6vdAMQyYjyakXolILjSu5gew5bAoOOOsQedPdFodNSXRzMkLsBbQXhOOKbj3aFkc
         w7Jg==
X-Gm-Message-State: AOJu0YzL9N21w/qGJZpgRf8WCpJ8SAXueqTal3kDyq7/605Ywuc2Io8L
	Vs/b93sJgsWXjfPlNPvwQvc=
X-Google-Smtp-Source: AGHT+IFO2X1iMSafxSXHzfZST9BN8Xic8pKYiNXNrudjNj11ATLu1ERJhmbwgKBrlPYK3M1Vwzfo0g==
X-Received: by 2002:a05:6a20:3ca1:b0:18b:9031:822a with SMTP id b33-20020a056a203ca100b0018b9031822amr694826pzj.46.1700702478628;
        Wed, 22 Nov 2023 17:21:18 -0800 (PST)
Received: from io.. ([2601:648:8900:1ba9:9579:8591:5a0:f6b5])
        by smtp.gmail.com with ESMTPSA id 1-20020a17090a000100b00274922d4b38sm159546pja.27.2023.11.22.17.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 17:21:18 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: mhiramat@kernel.org,
	rostedt@goodmis.org,
	peterz@infradead.org
Cc: bpf@vger.kernel.org,
	kernel-team@meta.com,
	inwardvessel@gmail.com
Subject: [PATCH] kprobes: consistent rcu api usage for kretprobe holder
Date: Wed, 22 Nov 2023 05:20:58 -0800
Message-ID: <20231122132058.3359-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems that the pointer-to-kretprobe "rp" within the kretprobe_holder is
RCU-managed, based on the (non-rethook) implementation of get_kretprobe().
The thought behind this patch is to make use of the RCU API where possible
when accessing this pointer so that the needed barriers are always in place
and to self-document the code.

The __rcu annotation to "rp" allows for sparse RCU checking. Plain writes
done to the "rp" pointer are changed to make use of the RCU macro for
assignment. For the single read, the implementation of get_kretprobe()
is simplified by making use of an RCU macro which accomplishes the same,
but note that the log warning text will be more generic.

I did find that there is a difference in assembly generated between the
usage of the RCU macros vs without. For example, on arm64, when using
rcu_assign_pointer(), the corresponding store instruction is a
store-release (STLR) which has an implicit barrier. When normal assignment
is done, a regular store (STR) is found. In the macro case, this seems to
be a result of rcu_assign_pointer() using smp_store_release() when the
value to write is not NULL.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 include/linux/kprobes.h | 7 ++-----
 kernel/kprobes.c        | 4 ++--
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index ab1da3142b06..64672bace560 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -139,7 +139,7 @@ static inline bool kprobe_ftrace(struct kprobe *p)
  *
  */
 struct kretprobe_holder {
-	struct kretprobe	*rp;
+	struct kretprobe __rcu *rp;
 	struct objpool_head	pool;
 };
 
@@ -245,10 +245,7 @@ unsigned long kretprobe_trampoline_handler(struct pt_regs *regs,
 
 static nokprobe_inline struct kretprobe *get_kretprobe(struct kretprobe_instance *ri)
 {
-	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),
-		"Kretprobe is accessed from instance under preemptive context");
-
-	return READ_ONCE(ri->rph->rp);
+	return rcu_dereference_check(ri->rph->rp, rcu_read_lock_any_held());
 }
 
 static nokprobe_inline unsigned long get_kretprobe_retaddr(struct kretprobe_instance *ri)
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 075a632e6c7c..d5a0ee40bf66 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2252,7 +2252,7 @@ int register_kretprobe(struct kretprobe *rp)
 		rp->rph = NULL;
 		return -ENOMEM;
 	}
-	rp->rph->rp = rp;
+	rcu_assign_pointer(rp->rph->rp, rp);
 	rp->nmissed = 0;
 	/* Establish function entry probe point */
 	ret = register_kprobe(&rp->kp);
@@ -2300,7 +2300,7 @@ void unregister_kretprobes(struct kretprobe **rps, int num)
 #ifdef CONFIG_KRETPROBE_ON_RETHOOK
 		rethook_free(rps[i]->rh);
 #else
-		rps[i]->rph->rp = NULL;
+		rcu_assign_pointer(rps[i]->rph->rp, NULL);
 #endif
 	}
 	mutex_unlock(&kprobe_mutex);
-- 
2.42.0


