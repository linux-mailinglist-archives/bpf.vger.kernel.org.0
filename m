Return-Path: <bpf+bounces-4160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC2B749463
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 05:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5039E1C20CF1
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 03:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9616F79F9;
	Thu,  6 Jul 2023 03:35:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687EEEA2;
	Thu,  6 Jul 2023 03:35:33 +0000 (UTC)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388F51BCE;
	Wed,  5 Jul 2023 20:35:31 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-553ad54d3c6so190986a12.1;
        Wed, 05 Jul 2023 20:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688614530; x=1691206530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16ENwcmfnjk7gt3rsLEbTZKRRlF4WSn886UX6QPpAdw=;
        b=R+X3KbuD60jxL0rmT5cHj8vIIUsh3ZSL5DCXvtsdTLXkBEyrpgL25mhknW/h9UWFQ5
         umRyVpzxS4WpXjlJA/GRpY6hssYs8GrgFuiBqsb2kZTj9pY9necGo1++INSOj4ElJKrW
         m1HKX42m2ubW7zx8P6JITgy1bduDDbprnPUh5vBE8RL+2CxWT1ljmYKtCkWOiZfwk7sp
         WgsNA48gIHqvZTxERwFX1KprW3hV/0XOtc6JitrWlUo3C/vmva2XC/gI8b4Tir0s/7kc
         tybk5ncZnvsII4Rg/kh5Rb+3IwCWuABCvxHDFGQwOUIV9HYZ7JI+wO/ZsOVzNDTp9Zwo
         DDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688614530; x=1691206530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16ENwcmfnjk7gt3rsLEbTZKRRlF4WSn886UX6QPpAdw=;
        b=JQ16B0pEEu1ygNpC2G3RyOWzOddnua0NKMf2V5C0fmKL70T1GxDA07e0i8sAkJAkcj
         F4DWre9P0IGFCU5591R1j6pNDrlfoMHdBbMfsNxqYTfnIQ70wd44k1ZG4jRmTLbnsQK2
         01vhtWzDPD+FklChIw7ZuIgQ5UAscLlpzh4CzbCn2RwUbZgDBjUHTY46gmwOCcu4zRuw
         1CytF+zEScONGam7AakUjlnDb44Bhv3BdIRH6leII93njBtCKOV1t5SxnpfLWBzaxyru
         PTgLcvq1cerjVKJ77OKrOLqGUywEVILKp5Xb8HSGD/4wNpWPf7MlISeVd6zZMTe88Us5
         RYZg==
X-Gm-Message-State: ABy/qLakEUPSRyW4ifUIA+CF8UKhE7AmM2JAbXnzjXwXJsMz7+Tmdl/y
	XT0D30a/tw1n8u0ECcbGCU4=
X-Google-Smtp-Source: APBJJlFlV0C97L+55+xQRrEghRt0wEVRistq6K6x/V3hh++LwskYhtxhN3JRIqL/fMRlbtZRBfed1g==
X-Received: by 2002:a05:6a20:a417:b0:101:1951:d491 with SMTP id z23-20020a056a20a41700b001011951d491mr488010pzk.6.1688614530528;
        Wed, 05 Jul 2023 20:35:30 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:f715])
        by smtp.gmail.com with ESMTPSA id jh5-20020a170903328500b001b872c17535sm234498plb.13.2023.07.05.20.35.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Jul 2023 20:35:30 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 10/14] rcu: Export rcu_request_urgent_qs_task()
Date: Wed,  5 Jul 2023 20:34:43 -0700
Message-Id: <20230706033447.54696-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
References: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
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
index 98c1544cf572..f95cfb5bf2ee 100644
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


