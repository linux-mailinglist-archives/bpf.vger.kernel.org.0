Return-Path: <bpf+bounces-3345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF4D73C672
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 05:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FFCF1C2144F
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 03:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3029917C3;
	Sat, 24 Jun 2023 03:13:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028F27F;
	Sat, 24 Jun 2023 03:13:55 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C9AE47;
	Fri, 23 Jun 2023 20:13:53 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-55e57337756so930487eaf.0;
        Fri, 23 Jun 2023 20:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687576433; x=1690168433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16uWDlZdQR3Juwac+BQwsJvGxkAsevnPbRvEaTU5eEY=;
        b=B6XZ3jgGD6DdakMXT0qyN74hn0ckaNLgOrz8SwvtV14P8yqvRf1fwJKAmUFyOrNUI5
         px/z0LunAxAckmSg94/eu2ncizYvsfZQnLzugWukkZ1lId4C+gHt77zzXyU0tSqHCZMu
         2EFBzdZwEAmTMyNgX771KnWdtRID/wxJdN2Qox6+V1UoYHmlZQ6DnfMhlgsGsseFT9rK
         9Yzdsx174V9l79V9urKNEtjh9CsPeY8CmFzlCoBDFIgzSTlMBPv0yJkcRBxy4lsbiq1Y
         EpGgntBqp5F9bTmuLzlhYEzAsZFAQzG1ZPb5TqN2nfA80blFUjELRL73+kgVoXlfBE8X
         X0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687576433; x=1690168433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16uWDlZdQR3Juwac+BQwsJvGxkAsevnPbRvEaTU5eEY=;
        b=GC4X+z5qJDXVS1/xlL5WJM9x1XDRzDurh6kJU+QuCaDEI37T02aIq2byMk2T+x6JGN
         P6VYyrez0WRyMvTl+k8/QyXmDsPECDVOdfNj7U3Mb/LJVkeBq2tMOXITgPavc6yqtIWv
         z36cneFFHdHDvXn2ijqp3FxAur/hwHS5+nTBaD6z1dghybLE+6m9GqlnpJzGZIT+J0mR
         e+hNg0ymP+rnXyhxPdmRfQi1nBvKHoZjZwfL6srn5lQWH9INtapURUtIRzCUtGqFE0nh
         2tQjkBIdGOq1hwPumwR+pTurTm1zYobxS5vPNJttMHhwzHaP78Y9c0XrOtvkqkkcLStS
         O7jQ==
X-Gm-Message-State: AC+VfDwYMjrT1L8W18AdB8VgZ4wlyv8Wio657tV5o3Y/Sg7q+A9nRCUV
	d/fOZRZ5O83skYnQdyuJ5R4=
X-Google-Smtp-Source: ACHHUZ6i4Q6XBEi1sWyBTXB8kwICKU1XyzeLDi9VjKLqnvRFRaPgV4AqnmvXMhFgS8mZ6rtGRoKFXg==
X-Received: by 2002:a05:6808:b28:b0:3a1:aef1:bbf3 with SMTP id t8-20020a0568080b2800b003a1aef1bbf3mr2949957oij.23.1687576432861;
        Fri, 23 Jun 2023 20:13:52 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:b07c])
        by smtp.gmail.com with ESMTPSA id a19-20020a170902b59300b001b04c2023e3sm229348pls.218.2023.06.23.20.13.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Jun 2023 20:13:52 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 04/13] bpf: Refactor alloc_bulk().
Date: Fri, 23 Jun 2023 20:13:24 -0700
Message-Id: <20230624031333.96597-5-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

Factor out inner body of alloc_bulk into separate helper.
No functioncal changes.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 46 ++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 693651d2648b..9693b1f8cbda 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -154,11 +154,35 @@ static struct mem_cgroup *get_memcg(const struct bpf_mem_cache *c)
 #endif
 }
 
+static void add_obj_to_free_list(struct bpf_mem_cache *c, void *obj)
+{
+	unsigned long flags;
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		/* In RT irq_work runs in per-cpu kthread, so disable
+		 * interrupts to avoid preemption and interrupts and
+		 * reduce the chance of bpf prog executing on this cpu
+		 * when active counter is busy.
+		 */
+		local_irq_save(flags);
+	/* alloc_bulk runs from irq_work which will not preempt a bpf
+	 * program that does unit_alloc/unit_free since IRQs are
+	 * disabled there. There is no race to increment 'active'
+	 * counter. It protects free_llist from corruption in case NMI
+	 * bpf prog preempted this loop.
+	 */
+	WARN_ON_ONCE(local_inc_return(&c->active) != 1);
+	__llist_add(obj, &c->free_llist);
+	c->free_cnt++;
+	local_dec(&c->active);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_restore(flags);
+}
+
 /* Mostly runs from irq_work except __init phase. */
 static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 {
 	struct mem_cgroup *memcg = NULL, *old_memcg;
-	unsigned long flags;
 	void *obj;
 	int i;
 
@@ -188,25 +212,7 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 			if (!obj)
 				break;
 		}
-		if (IS_ENABLED(CONFIG_PREEMPT_RT))
-			/* In RT irq_work runs in per-cpu kthread, so disable
-			 * interrupts to avoid preemption and interrupts and
-			 * reduce the chance of bpf prog executing on this cpu
-			 * when active counter is busy.
-			 */
-			local_irq_save(flags);
-		/* alloc_bulk runs from irq_work which will not preempt a bpf
-		 * program that does unit_alloc/unit_free since IRQs are
-		 * disabled there. There is no race to increment 'active'
-		 * counter. It protects free_llist from corruption in case NMI
-		 * bpf prog preempted this loop.
-		 */
-		WARN_ON_ONCE(local_inc_return(&c->active) != 1);
-		__llist_add(obj, &c->free_llist);
-		c->free_cnt++;
-		local_dec(&c->active);
-		if (IS_ENABLED(CONFIG_PREEMPT_RT))
-			local_irq_restore(flags);
+		add_obj_to_free_list(c, obj);
 	}
 	set_active_memcg(old_memcg);
 	mem_cgroup_put(memcg);
-- 
2.34.1


