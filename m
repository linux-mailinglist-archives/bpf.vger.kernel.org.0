Return-Path: <bpf+bounces-3346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D31373C674
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 05:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B157281F50
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 03:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18C51FD2;
	Sat, 24 Jun 2023 03:13:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D587F;
	Sat, 24 Jun 2023 03:13:58 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A314E47;
	Fri, 23 Jun 2023 20:13:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666edfc50deso953948b3a.0;
        Fri, 23 Jun 2023 20:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687576437; x=1690168437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=demoIvd6FUiWf68KRG+qXQL3nbt4VblYJWw6+Cz8IOo=;
        b=sgfK82GqNhjk9qkC5VjJV3YL8U0hG58WuUkRH8QQaDbWoVOyqfWOtHerQJiGmOhpXa
         SWj2jdviKPi/pwl7Q3rGnfvUSVraoEAhVjAf3Vl+f6o+XCI4TMWbUE/srSt0QA79Zg3+
         9D+fE78lpjld3RaWGkS+HItFKnld3Uc7U+1iux3aq/vOyyGVsdrPM5IZvjL+FoIwu3vB
         TaO07/kk7rDWNHKFSXGRWBg3G6WbmKwkuTlS1ReKDXgbXFYLfeQ+dW59F+AS/ZxNObgW
         EDxAQdb0nhjQ8U1p590MV7jf+KuWKwGjgjS1Rphv0Lsq/vwAJLxuvNS0mNiUL12CELZw
         cofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687576437; x=1690168437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=demoIvd6FUiWf68KRG+qXQL3nbt4VblYJWw6+Cz8IOo=;
        b=ZIFhVwUiNuD1DcDnKZBmn/ZhBhBJw0VrdU5uB+Jzo49ZxCuqlnyiGt0EiAwZrxuYVD
         p7w2d42xZNMD1WgSTxoTJZpx1QTOV1eaXhSBsiJJ89ZMbZyy2e/9rQrBTVzBYSOnzH5Y
         zfkQEX2+Za+p9/ZNk/aLb6sFCpCE6s3Vl/ZoVRo4usDrf0CtSh2ngmD3tD8lDWdcMZTk
         xqYMB/sM3hTtDU/JfaAow7z7jws7/Legz2+5nb9w3WMRu39yhjejU7mbIWAAGbgZ8tgc
         Hjo0chGkUWe5tzUXKD2CPuhyXeUxQk5GIOSFpcVkdacTfl0qgoiJka/p+taIy9NaRR0a
         urOg==
X-Gm-Message-State: AC+VfDwt4P1+UZoeHD8cSJXrMqzmKBzyAQI5zyN/3u4sD1qfKR9YIhWM
	EdfsAU3ngJ7AHprh8DcGIzU=
X-Google-Smtp-Source: ACHHUZ6EJt5ILDUNDUuY7/FujMmanXoq+PAdTjPZ8EouZHKZ38QPRAvZIMlVBjHBUVmXj7E+cQZ6Iw==
X-Received: by 2002:a05:6a00:1493:b0:668:9b2d:b534 with SMTP id v19-20020a056a00149300b006689b2db534mr19237238pfu.1.1687576436618;
        Fri, 23 Jun 2023 20:13:56 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:b07c])
        by smtp.gmail.com with ESMTPSA id x13-20020a056a00270d00b0064fabbc047dsm217051pfv.55.2023.06.23.20.13.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Jun 2023 20:13:56 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 05/13] bpf: Further refactor alloc_bulk().
Date: Fri, 23 Jun 2023 20:13:25 -0700
Message-Id: <20230624031333.96597-6-alexei.starovoitov@gmail.com>
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

In certain scenarios alloc_bulk() migth be taking free objects mainly from
free_by_rcu_ttrace list. In such case get_memcg() and set_active_memcg() are
redundant, but they show up in perf profile. Split the loop and only set memcg
when allocating from slab. No performance difference in this patch alone, but
it helps in combination with further patches.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 9693b1f8cbda..b07368d77343 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -186,8 +186,6 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 	void *obj;
 	int i;
 
-	memcg = get_memcg(c);
-	old_memcg = set_active_memcg(memcg);
 	for (i = 0; i < cnt; i++) {
 		/*
 		 * free_by_rcu_ttrace is only manipulated by irq work refill_work().
@@ -202,16 +200,24 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 		 * numa node and it is not a guarantee.
 		 */
 		obj = __llist_del_first(&c->free_by_rcu_ttrace);
-		if (!obj) {
-			/* Allocate, but don't deplete atomic reserves that typical
-			 * GFP_ATOMIC would do. irq_work runs on this cpu and kmalloc
-			 * will allocate from the current numa node which is what we
-			 * want here.
-			 */
-			obj = __alloc(c, node, GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT);
-			if (!obj)
-				break;
-		}
+		if (!obj)
+			break;
+		add_obj_to_free_list(c, obj);
+	}
+	if (i >= cnt)
+		return;
+
+	memcg = get_memcg(c);
+	old_memcg = set_active_memcg(memcg);
+	for (; i < cnt; i++) {
+		/* Allocate, but don't deplete atomic reserves that typical
+		 * GFP_ATOMIC would do. irq_work runs on this cpu and kmalloc
+		 * will allocate from the current numa node which is what we
+		 * want here.
+		 */
+		obj = __alloc(c, node, GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT);
+		if (!obj)
+			break;
 		add_obj_to_free_list(c, obj);
 	}
 	set_active_memcg(old_memcg);
-- 
2.34.1


