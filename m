Return-Path: <bpf+bounces-3351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB59573C681
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 05:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A968281F55
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 03:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1CF46AF;
	Sat, 24 Jun 2023 03:14:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7A97F;
	Sat, 24 Jun 2023 03:14:18 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ED9E47;
	Fri, 23 Jun 2023 20:14:16 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b512309c86so9528255ad.1;
        Fri, 23 Jun 2023 20:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687576456; x=1690168456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJFALLSA0Zej+KutPxvztQdPk2ASSkOODjkIKNtNWzE=;
        b=Posl1N45nd9idugsdC3M7csc+TZcClM4RxGd6bv/qpt4UamKsMxC/nl9S4MnZ6/oKD
         u4nKziVyHdmcm4W+paOlN9YSojFB1+imXTB35jEl/ol4uzjLc+CEjY4Ctupn187E7yTU
         degc2D+RKIdee0z39ZOmXNsZPPXEwn1tXRhlMXPGy4R4MsBiR8ZpMt+Vo2jf9DxudV4Y
         FjOpilbEGHOqQXbPYl7mmwFelc3VLV931afnbTv13nPQlHBJzBCiXavNIytsIOFrQ3nk
         S4Mv29QPHUEqex5UB6LfbVtfMMihCDhq7F9gFFlgsr2i9MyLviAs6LD0bRRmlr+r6Gxq
         bUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687576456; x=1690168456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJFALLSA0Zej+KutPxvztQdPk2ASSkOODjkIKNtNWzE=;
        b=ZOFX8r+Vyjr3UY/Q5rumPvenUoVxQ2ypT6mw1SmZxqJhswsLcCtYU0aOS7bEDfyjS/
         7ob2v049KBQtm7UoQpFBGwhwGj4kB1y9o2KYZqkB8kzecFY1fEyiIRmNWD4f7okJ8MUC
         az+uHfvz80k2qLk4M+8lq1d6QqKdYmlQExEijlg+AkFsVHxKYtmDyWPsq2F8n8pXzLVR
         eoZSmqx+BF3HggpFD6gt/4+VQoBYfEnKWSc0UivVyX6a/Zdmjg7892QVUcj0+fr2VfJS
         XaBkY452/T5PtUZvo8Q5ACvYHAiaxPxVu0B3Aq84oReEUtdqLuP5smaCxCP/eyaBHX7b
         QpFg==
X-Gm-Message-State: AC+VfDykz5Gk4xb/2k3La/StR+2cCz7MBeq3u37blPvRn8tJWDZE5Mmo
	+CYtUU929K18ToTYhDgubO8=
X-Google-Smtp-Source: ACHHUZ6sr3mb5nOlKO4mn5gKd4FlBguxSlFzf5WdGbq4peJxDD3eguXLmtSNnJ7lYZSE/NNCf8Xg0A==
X-Received: by 2002:a17:902:d4c9:b0:1b6:6dc8:edeb with SMTP id o9-20020a170902d4c900b001b66dc8edebmr1132344plg.21.1687576456264;
        Fri, 23 Jun 2023 20:14:16 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:b07c])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902f7cd00b001b3d4bb352dsm238626plw.175.2023.06.23.20.14.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Jun 2023 20:14:15 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: daniel@iogearbox.net,
	andrii@kernel.org,
	void@manifault.com,
	houtao@huaweicloud.com,
	paulmck@kernel.org
Cc: tj@kernel.org,
	rcu@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 10/13] rcu: Export rcu_request_urgent_qs_task()
Date: Fri, 23 Jun 2023 20:13:30 -0700
Message-Id: <20230624031333.96597-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: "Paul E. McKenney" <paulmck@kernel.org>

If a CPU is executing a long series of non-sleeping system calls,
RCU grace periods can be delayed for on the order of a couple hundred
milliseconds.  This is normally not a problem, but if each system call
does a call_rcu(), those callbacks can stack up.  RCU will eventually
notice this callback storm, but use of rcu_request_urgent_qs_task()
allows the code invoking call_rcu() to give RCU a heads up.

This function is not for general use, not yet, anyway.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/rcutiny.h | 2 ++
 include/linux/rcutree.h | 1 +
 kernel/rcu/rcu.h        | 2 --
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 7f17acf29dda..7b949292908a 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -138,6 +138,8 @@ static inline int rcu_needs_cpu(void)
 	return 0;
 }
 
+static inline void rcu_request_urgent_qs_task(struct task_struct *t) { }
+
 /*
  * Take advantage of the fact that there is only one CPU, which
  * allows us to ignore virtualization-based context switches.
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 56bccb5a8fde..126f6b418f6a 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -21,6 +21,7 @@ void rcu_softirq_qs(void);
 void rcu_note_context_switch(bool preempt);
 int rcu_needs_cpu(void);
 void rcu_cpu_stall_reset(void);
+void rcu_request_urgent_qs_task(struct task_struct *t);
 
 /*
  * Note a virtualization-based context switch.  This is simply a
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 4a1b9622598b..6f5fb3f7ebf3 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -493,7 +493,6 @@ static inline void rcu_expedite_gp(void) { }
 static inline void rcu_unexpedite_gp(void) { }
 static inline void rcu_async_hurry(void) { }
 static inline void rcu_async_relax(void) { }
-static inline void rcu_request_urgent_qs_task(struct task_struct *t) { }
 #else /* #ifdef CONFIG_TINY_RCU */
 bool rcu_gp_is_normal(void);     /* Internal RCU use. */
 bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
@@ -508,7 +507,6 @@ void show_rcu_tasks_gp_kthreads(void);
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 static inline void show_rcu_tasks_gp_kthreads(void) {}
 #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
-void rcu_request_urgent_qs_task(struct task_struct *t);
 #endif /* #else #ifdef CONFIG_TINY_RCU */
 
 #define RCU_SCHEDULER_INACTIVE	0
-- 
2.34.1


