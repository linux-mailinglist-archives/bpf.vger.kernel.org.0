Return-Path: <bpf+bounces-2969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D3973792D
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 04:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB18E1C20DAA
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 02:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1B12575;
	Wed, 21 Jun 2023 02:32:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA17915BE;
	Wed, 21 Jun 2023 02:32:55 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061E8F1;
	Tue, 20 Jun 2023 19:32:55 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b52bf6e669so43216635ad.2;
        Tue, 20 Jun 2023 19:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687314774; x=1689906774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5dE0XhJvwd5u50dMmi7rGk+uakRp6is0d4Rg5rl7Ow=;
        b=pFpKKVIhWLOacLaK4ACO7CJR5EfTYtMLXSJLS0p6Vt4vEeCWfGrdy27nUgsR/4Elpe
         FUOH9F/L2n+xiHUprzvX7RtfMlY1EehhmtXcQD+35WA09E4JmFIPE+s0rFfd5fGrWeFT
         saCLgujjLTtP9FqRphFbKvnvPjqrrrpQ5ZODkDEv14gZJB+VSbS0ezl9QPi4bx/ssnHq
         yd3PXooGNwdrGdyH2XAADBt137wAMNbo2BKuOnIj69txUpr29pTyVIoljvYiMfUmFAXv
         4J+EAww4ncGUTjcbyHtCAOip2GIoQ7yVF5q55uDePhoyqcVnc88WmCM4ZGtW10D7op6x
         1uMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687314774; x=1689906774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5dE0XhJvwd5u50dMmi7rGk+uakRp6is0d4Rg5rl7Ow=;
        b=CIedwQaRJJ8MTBAZL350tsgPcW45j73wOt+0okk2lQuCHBmIDR7JYFzM3v0XSyTg8r
         zrOV8libSIIU6oZ7KYO+Zvrh17xvNx9aEqZiexsRvTOxMjLGA06nQZWaoBRLFzdWThJ0
         7secbgzXsBryhqXOooyD7wGxywD4ZLytjeez3bd+LPFEqb7KN8Vkjtpso+6awOoCbkU1
         TM8AlXW5n+LAPCspkRHlQTMonDMgjNm6V3wsyKfDFx+bzlbzdFuAhtCe1+wecZOWO5h6
         pg8CTDqIpU/rAHooBL0iyCh9zDoo/AMQJtMZjph8uap7Aizw5CQvAtvPkRBLraZK0E7v
         E3Fg==
X-Gm-Message-State: AC+VfDwaBA2bkse64wx/sBb1Y8doqUnFDBwrjP1IpDv9juEOtaddkBt5
	3YnX+KMuoWQOOfUEhGKbF0w=
X-Google-Smtp-Source: ACHHUZ6hP+/68xZlB/1oLVt1LlDULPjN03SzRz4XC7q4z8Vhs92C5FcKdgPYUz31bUxGv2sYvNYoSA==
X-Received: by 2002:a17:902:d509:b0:1b0:4a37:9ccc with SMTP id b9-20020a170902d50900b001b04a379cccmr16821189plg.62.1687314774314;
        Tue, 20 Jun 2023 19:32:54 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:e719])
        by smtp.gmail.com with ESMTPSA id y20-20020a1709027c9400b001a9bcedd598sm2251306pll.11.2023.06.20.19.32.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Jun 2023 19:32:53 -0700 (PDT)
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
Subject: [PATCH bpf-next 03/12] bpf: Let free_all() return the number of freed elements.
Date: Tue, 20 Jun 2023 19:32:29 -0700
Message-Id: <20230621023238.87079-4-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

Let free_all() helper return the number of freed elements.
It's not used in this patch, but helps in debug/development of bpf_mem_alloc.

For example this diff for __free_rcu():
-       free_all(llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size);
+       printk("cpu %d freed %d objs after tasks trace\n", raw_smp_processor_id(),
+       	free_all(llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size));

would show how busy RCU tasks trace is.
In artificial benchmark where one cpu is allocating and different cpu is freeing
the RCU tasks trace won't be able to keep up and the list of objects
would keep growing from thousands to millions and eventually OOMing.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index b0011217be6c..693651d2648b 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -223,12 +223,16 @@ static void free_one(void *obj, bool percpu)
 	kfree(obj);
 }
 
-static void free_all(struct llist_node *llnode, bool percpu)
+static int free_all(struct llist_node *llnode, bool percpu)
 {
 	struct llist_node *pos, *t;
+	int cnt = 0;
 
-	llist_for_each_safe(pos, t, llnode)
+	llist_for_each_safe(pos, t, llnode) {
 		free_one(pos, percpu);
+		cnt++;
+	}
+	return cnt;
 }
 
 static void __free_rcu(struct rcu_head *head)
-- 
2.34.1


