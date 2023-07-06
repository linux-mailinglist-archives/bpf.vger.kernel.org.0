Return-Path: <bpf+bounces-4152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C88174944F
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 05:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD4A1C20C9B
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 03:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1A515AC;
	Thu,  6 Jul 2023 03:35:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB0FA5A;
	Thu,  6 Jul 2023 03:35:00 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F261F198E;
	Wed,  5 Jul 2023 20:34:59 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6b708b97418so233031a34.3;
        Wed, 05 Jul 2023 20:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688614499; x=1691206499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhOq2nzPha5tdwWCWLTN4pqz4R1IbYNeZFnIcmPu3ks=;
        b=Uj7/BR1Q5MVH1+yL4UGWosf1Y3f0xKVrm1NT5GRNciKarBbr8jDnYRP4/s/FlyMZkl
         swR73/VNgq4QCXdqjThlOZjRNFQaLkrZQyirSAoxC44D9YVnYTjDJ1D4euhWHLkPpMIj
         PrAcvdt7weLWbOBtmtevPW8op/IKgFRmuvGj8UPQI+SQAsUU2jcm9sWvasqCKfQ54nhv
         slNEFSJxRli28N5Cgx9rokQcsPLogF2JQJ3jjhSeNSUr1hKu7aWl29eXgE5b5+FbHp4p
         GsoXR+GoOCnb3hkom8pBZxuUPpsYEGKatEQkB/HuHMa1q6jIWrA4EvLtl5U4mrdmg6Qj
         5hBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688614499; x=1691206499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhOq2nzPha5tdwWCWLTN4pqz4R1IbYNeZFnIcmPu3ks=;
        b=JR1iRdnAGMJvQPhmi4Ge0VbIOObgFvKBz74FifsacsiOCxT1bRee7+pL9C31PYJ312
         y3XzieSsNSSWjNEgzAWMt9u7bmdru5ggtiluFm109VeCfepCd1OenIFfHQF3ZEVnyR21
         +/64iCeR86ZwuqjNKRFutp1qgBFTOTjOw1rbZqRvkpR3CJBgpui1ivmAXT2JF27/6gl+
         vsNMqCFt9M/J9vXZOh24pX0PsDoXETePati8Din4TE1gNYfAaP0vsDDfqpXZnjPMLeVq
         gMWDez5c48tssDc48JiP7dnttxa9WDwa9XeQih7QUL8X7x2Zq1zpwySAsCWY/vnTrHBm
         /9Vg==
X-Gm-Message-State: ABy/qLYaLck/2oXISXtehZACB1vS6JybIXQaLL6Okjy8QvXjdM3UgmBn
	LGsPdTP53cFHnI3pmjeLAwo=
X-Google-Smtp-Source: APBJJlF5gF6mjB+gQ4w/G/XlbPW1bbTtwwRoVCSiuv8ke/BdS5mINXdqW7Fv5FndoeaPv8nvws629A==
X-Received: by 2002:a05:6870:1f8f:b0:1b0:1e3f:1369 with SMTP id go15-20020a0568701f8f00b001b01e3f1369mr1399435oac.57.1688614499216;
        Wed, 05 Jul 2023 20:34:59 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:f715])
        by smtp.gmail.com with ESMTPSA id v24-20020a631518000000b0053051d50a48sm268825pgl.79.2023.07.05.20.34.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Jul 2023 20:34:58 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 02/14] bpf: Simplify code of destroy_mem_alloc() with kmemdup().
Date: Wed,  5 Jul 2023 20:34:35 -0700
Message-Id: <20230706033447.54696-3-alexei.starovoitov@gmail.com>
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

Use kmemdup() to simplify the code.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Hou Tao <houtao1@huawei.com>
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


