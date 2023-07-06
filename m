Return-Path: <bpf+bounces-4154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77CF749456
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 05:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749D6280C08
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 03:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1492D1867;
	Thu,  6 Jul 2023 03:35:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53F0185B;
	Thu,  6 Jul 2023 03:35:08 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40A21BC8;
	Wed,  5 Jul 2023 20:35:07 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8baa836a5so1004355ad.1;
        Wed, 05 Jul 2023 20:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688614507; x=1691206507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKB1+Lkjs9jIhLzRZegSs16t8bNoVyzYLNE9YXmjTOA=;
        b=OQuy/g4+r38t4lYd6j3gDF0yZYv4Vo3p0IcIfcobeQ6Teudq12lnIeNA0mes9Vk3bU
         /VR1M5rbRjKP5xT8thjbKOAhQcA6SOY+bYH7c3r2bNvP0lw0DPhCR02yh1inWgRFHZfJ
         50iAqWIdmNvxVplcCKd00Rf41IWXKUpj5pzbMqf4HDwzm6uEBnvLq5/iW4zcT6Ziftve
         fwq+EkVqY1NAMnOweTR7boh9KNg0eYRDa/jffTMhaQbzZEtpchStNDyN1/XaQDtYHQCc
         YWLQ/ic++zCNrtHv7RXxDAoybp6wt+IjX9+wK98KrDMA49Qla76d48OltRj/Yg1+6WMy
         iTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688614507; x=1691206507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKB1+Lkjs9jIhLzRZegSs16t8bNoVyzYLNE9YXmjTOA=;
        b=WT2kCaGcaFF/+lCX+VfqRMuRJBZ3cH9SUmXXQ4IH3aZK553D3A42r07+WdnnMpoT6S
         NhTccv7B8e2YcYJ70Acbfi8o8Ew9hKIBC5ktMcnYc63E6VW10Ap0wXkVzmftJ6TlRB9Q
         rRJ4RxQqImgq4jxKsEDYcCrryIF7CuN+lBhTOJbFFS81r/WnhPRgXgjfof9tamCDdnuL
         dqE+T07M+C/piG1i/6iUMuOO3XgXk/IMN5ZRDr9iQjW1dx7+n3EUHfpedGuhQCtmdVue
         GujahiDpWrLCNMMEGfNYQRlpftrCCSOGE6S4bjVKnGvUK1DvlJW4X2HtpywO5v3B7JzQ
         X1RQ==
X-Gm-Message-State: ABy/qLaCS2LYDAvpQpkyjAXLYZGeHYZDPj6snaNAAgksPP+exITOV1yz
	dHqMV1Y3NO6DFiNukEuaYic=
X-Google-Smtp-Source: APBJJlHS52lOtYNtz50v7vUTQnMjH6ZlUq1u7ICZEl7VfsLo1CfHmWTaiIyqq2ZIJFfbm71ViNs92A==
X-Received: by 2002:a17:902:7889:b0:1b5:25f8:2160 with SMTP id q9-20020a170902788900b001b525f82160mr730246pll.30.1688614507128;
        Wed, 05 Jul 2023 20:35:07 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:f715])
        by smtp.gmail.com with ESMTPSA id g5-20020a1709026b4500b001b027221393sm229702plt.43.2023.07.05.20.35.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Jul 2023 20:35:06 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 04/14] bpf: Refactor alloc_bulk().
Date: Wed,  5 Jul 2023 20:34:37 -0700
Message-Id: <20230706033447.54696-5-alexei.starovoitov@gmail.com>
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

Factor out inner body of alloc_bulk into separate helper.
No functional changes.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Hou Tao <houtao1@huawei.com>
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


