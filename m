Return-Path: <bpf+bounces-3628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EABDF740809
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 04:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67B2281135
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 02:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B4F882B;
	Wed, 28 Jun 2023 01:57:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13931C3C;
	Wed, 28 Jun 2023 01:57:19 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB9DDA;
	Tue, 27 Jun 2023 18:57:18 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b539d2f969so3449315ad.0;
        Tue, 27 Jun 2023 18:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687917438; x=1690509438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJFALLSA0Zej+KutPxvztQdPk2ASSkOODjkIKNtNWzE=;
        b=h8X/4jkIFsXgLZtZ8UmeAGEq5sycoK/XFUVVfiJxRQuVVic4UFrEP/xXlaIBbMx1k9
         FmBdvpIGjekcm4Ws/Eu4zK+xY4V4EFAJcJzOO5YmWDjZqaTaf7Wd/atTukdOIhk/sO1D
         angij+ciL5ccGZB1Ml49cBIVzNq5MWsbrK7KuCO6ZDLIJDwXVLaeNxEOc0/EsWyuR8rH
         N7i0HjM9BHELIiRZ75s6LkThYcZx+BDHlQLHs6gbAPLS5wKiMR/QkxLOexLV5JAF0hnZ
         wCcGvvCwVRCfg1HGLdGLkaL5zVP/dnyhVJy+3i334fizIn566JRzgl/DiD7YAY1lQd9+
         CH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687917438; x=1690509438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJFALLSA0Zej+KutPxvztQdPk2ASSkOODjkIKNtNWzE=;
        b=Bdm8H60aAE93OaIBfWN/XOpyoxMpxje2SeWvCIS/pUtautY1gR08Etb0mQ0g530O0D
         ip6ssDNm0AbwFBwKSWqVDqYYY9teP8LJnc9QDrX7/HuHeY/VIc/+8UX90vuh7SutkZNM
         WKNpaFAX6Us5CxcOE2kPUsWfx9x7zJcAAZ/2EM+iMldk4jQtnuskHcSdouJnDsTOviOa
         z397e9xixQxQRRvjP9uS/fhg1iY0Qt1SAD3UZFoCIRNMfDy4HB8v+mb4b7vSvdkkdJEd
         ZDBZj/tsmkUSW7UbmvJOKFRnekeuAVop5J14P/+LhLT5j6nF3uUwv6Q4C2T7f3qwg09h
         GQnA==
X-Gm-Message-State: AC+VfDzpzqmdVNfUXcET3O47Z1a+ob2Bh4qS4hhXxvv5twMtyRiLjyl2
	PZTwgKIGmLdJMYhoKe/qljw=
X-Google-Smtp-Source: ACHHUZ4mqRbVdrbzOcQ5mk9oJGSnYahKscizFj42AIxrgg30lKY/pQQPuTEa+rMPsBjM2Vc1d7kI8w==
X-Received: by 2002:a17:902:c411:b0:1b6:92f0:b6f5 with SMTP id k17-20020a170902c41100b001b692f0b6f5mr4620plk.14.1687917438176;
        Tue, 27 Jun 2023 18:57:18 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:6420])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902da8300b001ab13f1fa82sm1262579plx.85.2023.06.27.18.57.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Jun 2023 18:57:17 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 10/13] rcu: Export rcu_request_urgent_qs_task()
Date: Tue, 27 Jun 2023 18:56:31 -0700
Message-Id: <20230628015634.33193-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
References: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
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


