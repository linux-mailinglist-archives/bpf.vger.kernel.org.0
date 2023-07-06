Return-Path: <bpf+bounces-4155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B9E749458
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 05:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAACA281213
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 03:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174E21FB3;
	Thu,  6 Jul 2023 03:35:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF551C39;
	Thu,  6 Jul 2023 03:35:12 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B50198E;
	Wed,  5 Jul 2023 20:35:11 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-262e839647eso259038a91.2;
        Wed, 05 Jul 2023 20:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688614511; x=1691206511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eqzE1hZrK6k4U+CY/v2fs3fUbAlzEXpPd6LEk9iT+8=;
        b=Fjc4FuLawdQgw4MSBgBNtgYZTKWgkAZQX9nQY4uCj75tcocKgv+Kr6GePj0/bojvnb
         JR5IoJm8ntgXg0qxi6lUfHl9Djs0VvI1R9MUkv7KEiaMZdLs4cymWkTUxH1g+Dq9WZY3
         h3WEF+sll7IB4c1rrGjPpksN+mo4VubKiIzRfHlQdiW/t8HQt73NP77O3NaPC3Ee91KH
         nDwR8PS6vv/lj/72VzBvneQxWbi4qX77Q5BU/o3oSDmsxagz229KFk8uZyQQPJSl6h3P
         qr/5JfupWr/15OkU0Put5BlntpXvF5FKYfhW3OAzw6HiAlXwazcFu7P69WQvGVMPa+D9
         uaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688614511; x=1691206511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1eqzE1hZrK6k4U+CY/v2fs3fUbAlzEXpPd6LEk9iT+8=;
        b=AwMPUjmyOxTz7oa5KQFcuFRbpAZ/y5CXgls2BIipYvJkPFtIryiCCPPbGQaBM84biY
         HvNT/AiUMTjLWQNhIrqcqRoRgDbDrB5tYlosGz/TUJKonfYebUKgEA4H4TBZ3ejCuYDY
         lYEYIKL/+/wYDNYt/JoRoLmG3TLoUTreaNB1Yc3f5Wjo/ngLfVj7J07RrtJcNQAlmHhL
         CuY+nAAo/LGdpncJm5pYsV9evWzneLXbSuXuhhlCF0Jyscx4lZwQVukio5A2McMVsnnW
         sLj0Kv+CHdXZc4SB3rdT4y8+R4xbm6DXUkvFFQrczhofeYHQU2Wi40DzsfSvDsoMZxCg
         JPnQ==
X-Gm-Message-State: ABy/qLbLIWASKYh+WUgLkD7csrb6RRBCHibPzIgXNveXAA4R3jBQJCK5
	rvJzzHyjh9E3h/QRBflV/W0=
X-Google-Smtp-Source: APBJJlFlbwQf/XdUcogJy0XVZtkIdvY4CPKvhoHNuhiTyGAX4nLEZFsJ26althycxW1m56oiXg9qcg==
X-Received: by 2002:a17:90a:f28a:b0:263:9816:fe0f with SMTP id fs10-20020a17090af28a00b002639816fe0fmr632692pjb.15.1688614511024;
        Wed, 05 Jul 2023 20:35:11 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:f715])
        by smtp.gmail.com with ESMTPSA id l20-20020a17090aec1400b00256bbfbabcfsm2070422pjy.48.2023.07.05.20.35.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Jul 2023 20:35:10 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 05/14] bpf: Factor out inc/dec of active flag into helpers.
Date: Wed,  5 Jul 2023 20:34:38 -0700
Message-Id: <20230706033447.54696-6-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

Factor out local_inc/dec_return(&c->active) into helpers.
No functional changes.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 9693b1f8cbda..052fc801fb9f 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -154,17 +154,15 @@ static struct mem_cgroup *get_memcg(const struct bpf_mem_cache *c)
 #endif
 }
 
-static void add_obj_to_free_list(struct bpf_mem_cache *c, void *obj)
+static void inc_active(struct bpf_mem_cache *c, unsigned long *flags)
 {
-	unsigned long flags;
-
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		/* In RT irq_work runs in per-cpu kthread, so disable
 		 * interrupts to avoid preemption and interrupts and
 		 * reduce the chance of bpf prog executing on this cpu
 		 * when active counter is busy.
 		 */
-		local_irq_save(flags);
+		local_irq_save(*flags);
 	/* alloc_bulk runs from irq_work which will not preempt a bpf
 	 * program that does unit_alloc/unit_free since IRQs are
 	 * disabled there. There is no race to increment 'active'
@@ -172,13 +170,25 @@ static void add_obj_to_free_list(struct bpf_mem_cache *c, void *obj)
 	 * bpf prog preempted this loop.
 	 */
 	WARN_ON_ONCE(local_inc_return(&c->active) != 1);
-	__llist_add(obj, &c->free_llist);
-	c->free_cnt++;
+}
+
+static void dec_active(struct bpf_mem_cache *c, unsigned long flags)
+{
 	local_dec(&c->active);
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_irq_restore(flags);
 }
 
+static void add_obj_to_free_list(struct bpf_mem_cache *c, void *obj)
+{
+	unsigned long flags;
+
+	inc_active(c, &flags);
+	__llist_add(obj, &c->free_llist);
+	c->free_cnt++;
+	dec_active(c, flags);
+}
+
 /* Mostly runs from irq_work except __init phase. */
 static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 {
@@ -300,17 +310,13 @@ static void free_bulk(struct bpf_mem_cache *c)
 	int cnt;
 
 	do {
-		if (IS_ENABLED(CONFIG_PREEMPT_RT))
-			local_irq_save(flags);
-		WARN_ON_ONCE(local_inc_return(&c->active) != 1);
+		inc_active(c, &flags);
 		llnode = __llist_del_first(&c->free_llist);
 		if (llnode)
 			cnt = --c->free_cnt;
 		else
 			cnt = 0;
-		local_dec(&c->active);
-		if (IS_ENABLED(CONFIG_PREEMPT_RT))
-			local_irq_restore(flags);
+		dec_active(c, flags);
 		if (llnode)
 			enque_to_free(c, llnode);
 	} while (cnt > (c->high_watermark + c->low_watermark) / 2);
-- 
2.34.1


