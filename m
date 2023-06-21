Return-Path: <bpf+bounces-2968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C130773792B
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 04:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D989B1C20DCF
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 02:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235FA20F1;
	Wed, 21 Jun 2023 02:32:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0101FC5;
	Wed, 21 Jun 2023 02:32:51 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9195B7;
	Tue, 20 Jun 2023 19:32:50 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6686a1051beso3034480b3a.1;
        Tue, 20 Jun 2023 19:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687314770; x=1689906770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6ir4URdr01h+ZUg6kzH9KBRVLbULKDLoOzFhIlPeJI=;
        b=cVtyy1keDAGc43zXUjz7P8te/CdSYAwP+ZHTHkSsZRf20+95UqkziklF9R1f/EJAVG
         SYVgcFeYdrabQ9srzDtovuFckd3cgm+LogZQdfaPGPu4U+1zfmWixcwPmLhpgoqWx1qY
         laQq3+tmxIgSlqJ97TYgw5MNH1U9wF/M1jCwuMBfA7koZpyc7itL0yU4xIyHuB4DNiWs
         vTa0uM13CVhUUYBldxz1aiQHEMFSV9wsjSAfXW0r3ys4sJ1XveuA627LCtg46/wRoQhc
         k3EaG8VZi7JqefT3Sh055hnycua3vHveSLyk5MkZd0KB5YaMrR+pP1MCiovWmP+jWPc3
         ziZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687314770; x=1689906770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6ir4URdr01h+ZUg6kzH9KBRVLbULKDLoOzFhIlPeJI=;
        b=Qw/Q9wSOV20gnAHh2wYhbR/bsieOrgA/0YXAUTFcrL1J/omYdq858JCtJ+NM0D0jWV
         22B5tqY1IEjDfVOEHwxTThHCA7H0SqTLd3Ww5BwQZQCqzNICIubRRyVi8/9I7wu7zixN
         XkxILPKDG1apYJqQT5inVys9auC4kjBz7m8NuPO7Dc/arVKkal2CP2XrJ5gb7rpbJJcz
         T8n/hKDQJBAPLBB2AmUSj15T1rtb4GzU6ITeVOe4AMjUuAYWDjVpQi3nTq3yto8nemHO
         hAY3Rav81laD6uBA5fls0QhZDsMKKWPQN/2ai+YpZsObjKIlM9fKw5MBSzBQq98e6W3W
         5MTg==
X-Gm-Message-State: AC+VfDzqCfLa6S2pE7rVm9f9BCsRINhRnjZJHsapQ0KlE57ZLgokbVyy
	HRbT4OmBZQ21YCsRb9jpmy0=
X-Google-Smtp-Source: ACHHUZ4SzoHMqXDbXtZX40cvgI1BRhhb6FDvPjqOvsYyyTp9yaIBmmW7+KipvQQ+JZuKUPuPxE/Cuw==
X-Received: by 2002:a05:6a00:2309:b0:668:7744:10ea with SMTP id h9-20020a056a00230900b00668774410eamr9902325pfh.18.1687314770235;
        Tue, 20 Jun 2023 19:32:50 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:e719])
        by smtp.gmail.com with ESMTPSA id x19-20020a62fb13000000b0066872ef995fsm1896987pfm.5.2023.06.20.19.32.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Jun 2023 19:32:49 -0700 (PDT)
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
Subject: [PATCH bpf-next 02/12] bpf: Simplify code of destroy_mem_alloc() with kmemdup().
Date: Tue, 20 Jun 2023 19:32:28 -0700
Message-Id: <20230621023238.87079-3-alexei.starovoitov@gmail.com>
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


