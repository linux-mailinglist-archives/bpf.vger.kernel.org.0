Return-Path: <bpf+bounces-7433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F3D777292
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 10:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48BD71C2032E
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 08:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14501DDCB;
	Thu, 10 Aug 2023 08:13:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88241ADE8
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 08:13:38 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EE42680
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 01:13:36 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686f1240a22so594428b3a.0
        for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 01:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691655216; x=1692260016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+gOX8E32N7J0qn1e/cgbPAAdyKUl0JYooXv5sNbHuI=;
        b=OG7IuzB6CPOFfsV9wFrgnazb3f1VQrgIV5f+OOZdkCCvMJDzb3aV1VZFFlJjpUsXA3
         +BP87n9CA/2IoiPk0nP0DzRB7WQ7FQy3RpzkGS3xJcTT6KV93ClOZg7CbgeULa7wj9ly
         Fr3KCTw83jY9eghkbiZB2yqiscmS6/rgT4aHFfjPPmngWuHbHqylqAWkCsuflY/r6XA/
         u+1EJS1Q7o+TgHUDSY/Y9RXZe993prhItKrseX0iBXnPuQufH4ZiVy6hcumq/SQIiGp4
         weiY7Tex+vf38O2Fi3m5cUUfZFvNYFueWFQFMKwYqa/fe7Wq4zxqt5ZSwFX0OfTK0l6P
         IEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691655216; x=1692260016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+gOX8E32N7J0qn1e/cgbPAAdyKUl0JYooXv5sNbHuI=;
        b=EnP8yypYqAHkCpq3wJlTNteWniKuKcS4jdLaURJg1q9V/HAh3RZZ1vst/BvDAo/yDe
         0QqL1o5tqoqHyisJzPWpDJmNMs6lH9li7t0k1ngvpj8nnUwHCNFQZD9f9v8qI9LlPfqw
         xB7q8juRlC4NXcnYZ8vX4KV7lMymi9Bd+U+ZF51EWYqP+mABAxraqG92QFVk4u60c8Oh
         ILsRVAvb6COyN+EOgfTdmPdEj0rKv4D7/EOHriCKjdZdqRs4cubvF3SPYtAVbOFfpBzy
         DJDr35xaT0JMOgmdN7xG9Kaq7SucGM7UCtnqvpAhQRkSFd7i0HBqBUU3ivVfn0hOZ1Be
         THUw==
X-Gm-Message-State: AOJu0YyisDLl6CN8U3jllXiI/P6Mmob3DqA5oYFpdKqrHh7dTs0Fso6B
	n7jNYkGlcZQmTllk/gDgzwkPiw==
X-Google-Smtp-Source: AGHT+IGtscS04wQJzOPzeNPixXB/Nvlgj5vG5uoIWZkaaoCuS2LHPKsrUQS+DTx+/kSMNoPf/s1uqQ==
X-Received: by 2002:a17:903:246:b0:1b8:76ce:9d91 with SMTP id j6-20020a170903024600b001b876ce9d91mr1911030plh.1.1691655216226;
        Thu, 10 Aug 2023 01:13:36 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.40])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b001b1a2c14a4asm1019036plg.38.2023.08.10.01.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:13:35 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	muchun.song@linux.dev
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wuyun.abel@bytedance.com,
	robin.lu@bytedance.com,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RFC PATCH v2 2/5] mm: Add policy_name to identify OOM policies
Date: Thu, 10 Aug 2023 16:13:16 +0800
Message-Id: <20230810081319.65668-3-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230810081319.65668-1-zhouchuyi@bytedance.com>
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch adds a new metadata policy_name in oom_control and report it
in dump_header(), so we can know what has been the selection policy. In
BPF program, we can call kfunc set_oom_policy_name to set the current
user-defined policy name. The in-kernel policy_name is "default".

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 include/linux/oom.h |  7 +++++++
 mm/oom_kill.c       | 42 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/include/linux/oom.h b/include/linux/oom.h
index 7d0c9c48a0c5..69d0f2ec6ea6 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -22,6 +22,10 @@ enum oom_constraint {
 	CONSTRAINT_MEMCG,
 };
 
+enum {
+	POLICY_NAME_LEN = 16,
+};
+
 /*
  * Details of the page allocation that triggered the oom killer that are used to
  * determine what should be killed.
@@ -52,6 +56,9 @@ struct oom_control {
 
 	/* Used to print the constraint info. */
 	enum oom_constraint constraint;
+
+	/* Used to report the policy info. */
+	char policy_name[POLICY_NAME_LEN];
 };
 
 extern struct mutex oom_lock;
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 255c9ef1d808..3239dcdba4d7 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -443,6 +443,35 @@ static int dump_task(struct task_struct *p, void *arg)
 	return 0;
 }
 
+__bpf_kfunc void set_oom_policy_name(struct oom_control *oc, const char *src, size_t sz)
+{
+	memset(oc->policy_name, 0, sizeof(oc->policy_name));
+
+	if (sz > POLICY_NAME_LEN)
+		sz = POLICY_NAME_LEN;
+
+	memcpy(oc->policy_name, src, sz);
+}
+
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "kfuncs which will be used in BPF programs");
+
+__weak noinline void bpf_set_policy_name(struct oom_control *oc)
+{
+}
+
+__diag_pop();
+
+BTF_SET8_START(bpf_oom_policy_kfunc_ids)
+BTF_ID_FLAGS(func, set_oom_policy_name)
+BTF_SET8_END(bpf_oom_policy_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_oom_policy_kfunc_set = {
+	.owner          = THIS_MODULE,
+	.set            = &bpf_oom_policy_kfunc_ids,
+};
+
 /**
  * dump_tasks - dump current memory state of all system tasks
  * @oc: pointer to struct oom_control
@@ -484,8 +513,8 @@ static void dump_oom_summary(struct oom_control *oc, struct task_struct *victim)
 
 static void dump_header(struct oom_control *oc, struct task_struct *p)
 {
-	pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, oom_score_adj=%hd\n",
-		current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order,
+	pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, policy_name=%s, oom_score_adj=%hd\n",
+		current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order, oc->policy_name,
 			current->signal->oom_score_adj);
 	if (!IS_ENABLED(CONFIG_COMPACTION) && oc->order)
 		pr_warn("COMPACTION is disabled!!!\n");
@@ -775,8 +804,11 @@ static int __init oom_init(void)
 	err = register_btf_fmodret_id_set(&oom_bpf_fmodret_set);
 	if (err)
 		pr_warn("error while registering oom fmodret entrypoints: %d", err);
+	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
+					&bpf_oom_policy_kfunc_set);
+	if (err)
+		pr_warn("error while registering oom kfunc entrypoints: %d", err);
 #endif
-
 	return 0;
 }
 subsys_initcall(oom_init)
@@ -1196,6 +1228,10 @@ bool out_of_memory(struct oom_control *oc)
 		return true;
 	}
 
+	set_oom_policy_name(oc, "default", sizeof("default"));
+
+	bpf_set_policy_name(oc);
+
 	select_bad_process(oc);
 	/* Found nothing?!?! */
 	if (!oc->chosen) {
-- 
2.20.1


