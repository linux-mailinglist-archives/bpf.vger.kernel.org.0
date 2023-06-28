Return-Path: <bpf+bounces-3620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FC87407E3
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 03:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E046280996
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 01:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FC723C0;
	Wed, 28 Jun 2023 01:56:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5228D15A0;
	Wed, 28 Jun 2023 01:56:48 +0000 (UTC)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851CE2D4C;
	Tue, 27 Jun 2023 18:56:46 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-55b0e7efb1cso759575a12.1;
        Tue, 27 Jun 2023 18:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687917406; x=1690509406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6ir4URdr01h+ZUg6kzH9KBRVLbULKDLoOzFhIlPeJI=;
        b=Ot3wsli6NbvjY75t2I9LiDretPDDdpicghUCiS9UW5Ye5U3SmfawJF25jrAH2TFgrT
         3yZhBZ1uTEG3EjAz0CwHVxWJkl+N1XLB1dJBDcpwLbcY7XR0BVeJTY19Csbv0MPiaIjJ
         dL2afA1Wp1p4qtN5Pr+dOqz9avDQ7uxm79layia8MId9IFZNMAoWbcfMsYoeIQaS5zdn
         K+6zD8XxlPSwnzxEV+Tpp0T/ThIUvCXK0NmXn4IeGdqqw48IY0HFqsPOoKVEoFCwIvh9
         JoTVar7MBzOruufflXbLT2h1EuRXarhPuDztVrztEgHi6BqIeoiQlPytNPH0PU/AqzbU
         rNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687917406; x=1690509406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6ir4URdr01h+ZUg6kzH9KBRVLbULKDLoOzFhIlPeJI=;
        b=dtwrO68NeVcCu3LrdCS1Dmkvl7O0psR9hAa01b8c61fbMb+Vg7qFIXD7zK899eYuZs
         PEFosqZb9wODeGP+lje09POnWPp0kX37Zq+COyqxNGYJvtbpkSZObbzbvHcQJO6FIgcz
         9lORZMxu4dOjKEah8AQMvRsXQv3RzLp3VilF2sJdSYni1rldlargUqlmbbEDUXoX3uxF
         inNMaZDLPJaPUuIqL7Pdf1R5ScQuzj9CcL+uwaVeXee1FTEKaiE5mg+XhVCLlbw5SuFU
         54XTsrSnXza+pc+gbMI39yHRG6U4ML+1fXykVMsdUZQrcRH8v4K7m6aMZwchzx2aT9mh
         Akvw==
X-Gm-Message-State: AC+VfDxpIGyAykP8tFLMCX3QCFAlrUzz7kJLLRRE4wHDOxJwlj+WiRND
	reaW/haDr3eG2kvX29oGwBQ=
X-Google-Smtp-Source: ACHHUZ5TUz/3lQZFltg83vQulm8G9Hc2b717uhrGE2y/Uxzov/iWhhYtlTWqsgBEdNFcXC6hEoAb2g==
X-Received: by 2002:a05:6a21:7897:b0:125:a12e:a918 with SMTP id bf23-20020a056a21789700b00125a12ea918mr13323197pzc.8.1687917405849;
        Tue, 27 Jun 2023 18:56:45 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:6420])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902a70800b001b3d4d74749sm6613239plq.7.2023.06.27.18.56.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Jun 2023 18:56:45 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 02/13] bpf: Simplify code of destroy_mem_alloc() with kmemdup().
Date: Tue, 27 Jun 2023 18:56:23 -0700
Message-Id: <20230628015634.33193-3-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

Use kmemdup() to simplify the code.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index cc5b8adb4c83..b0011217be6c 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -499,7 +499,7 @@ static void destroy_mem_alloc(struct bpf_mem_alloc *ma, int rcu_in_progress)
 		return;
 	}
 
-	copy = kmalloc(sizeof(*ma), GFP_KERNEL);
+	copy = kmemdup(ma, sizeof(*ma), GFP_KERNEL);
 	if (!copy) {
 		/* Slow path with inline barrier-s */
 		free_mem_alloc(ma);
@@ -507,10 +507,7 @@ static void destroy_mem_alloc(struct bpf_mem_alloc *ma, int rcu_in_progress)
 	}
 
 	/* Defer barriers into worker to let the rest of map memory to be freed */
-	copy->cache = ma->cache;
-	ma->cache = NULL;
-	copy->caches = ma->caches;
-	ma->caches = NULL;
+	memset(ma, 0, sizeof(*ma));
 	INIT_WORK(&copy->work, free_mem_alloc_deferred);
 	queue_work(system_unbound_wq, &copy->work);
 }
-- 
2.34.1


