Return-Path: <bpf+bounces-2975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0496737940
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 04:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D64B1C20D42
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 02:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEFDBE63;
	Wed, 21 Jun 2023 02:33:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BFDBA5F;
	Wed, 21 Jun 2023 02:33:20 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067D1B7;
	Tue, 20 Jun 2023 19:33:19 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-668704a5b5bso3119179b3a.0;
        Tue, 20 Jun 2023 19:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687314798; x=1689906798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJFALLSA0Zej+KutPxvztQdPk2ASSkOODjkIKNtNWzE=;
        b=qKNLJ1TSm1wXJWHwDkxH9F/UzLEIyQuftptzJGSxXDZzZPkvJMyfYJNfy2DOcRGeby
         Ahrs4o4hF7ae485L/o3G/NhiZHxL9sbkDJbII4IwY0v1V4LrOL734V5wObhehFb8ttpS
         XaHaIIpwRAhslQf3NXcsyysXV3VY5ftaURSaA5PhveF7rhdlCTvqISXfDgIub596Yn2i
         Pc/nNDoeIPjzvtdYOktGRck8y7vQUuw8nz3CYRFAWalA6YOxbhg7MzLviKaF+eLwP9K6
         0bbbmDnyeVP+RNEkaDsB05pQoH2sarACh0VNBmDab31tir1hSfa8hRXpeEIzS7FI2rn1
         vRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687314798; x=1689906798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJFALLSA0Zej+KutPxvztQdPk2ASSkOODjkIKNtNWzE=;
        b=J1VSCLpj6u87pbZl9OUII/NLE1ChQalcu8SnheiA0Db+VBogd6wd67iAnLaSeRgT/s
         hWCYrXkAGNsMV3maUU32tmsATJciaUJwXCb9BGmLh/Syn9uxMxt8Wi/PZRojMh0hFG0h
         KOBt54tjOrzymgN0U3UAWsqdHuKRxTYLgo8GTHM0IkQZvNXo5uqghoyp4hpfVJPHLYy6
         f6FaqmNKIwf5xKaYYjfB3q9SUT8ut8lBldlGiFK0yVJcN5fAq+tC8ei5qTIU9pFY7bmU
         KjmkPup42MYAgRmYNTN3Nz/R8rGCJMgq5/hjZvHTHNgFjJqk2gGaNUrsXxnnmMtLNQVn
         b3fQ==
X-Gm-Message-State: AC+VfDy0woEFBt2OiUW90e/e+8F790b4AHWFFpUoUnS9nA9PhHOYwgIj
	zgwafroPG52vkJxMRDzeYwQ=
X-Google-Smtp-Source: ACHHUZ76+u1Qgg4DLJ6cVJswS48hyHGNQJ1ZvA7sgFImciRpXkia92T++/EuLi7ytgn24KKIS3/i7Q==
X-Received: by 2002:a05:6a00:1a56:b0:658:c1a9:becc with SMTP id h22-20020a056a001a5600b00658c1a9beccmr20215081pfv.12.1687314798237;
        Tue, 20 Jun 2023 19:33:18 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:e719])
        by smtp.gmail.com with ESMTPSA id d20-20020aa78154000000b00666a83bd544sm1894485pfn.23.2023.06.20.19.33.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Jun 2023 19:33:17 -0700 (PDT)
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
Subject: [PATCH bpf-next 09/12] rcu: Export rcu_request_urgent_qs_task()
Date: Tue, 20 Jun 2023 19:32:35 -0700
Message-Id: <20230621023238.87079-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230621023238.87079-1-alexei.starovoitov@gmail.com>
References: <20230621023238.87079-1-alexei.starovoitov@gmail.com>
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


