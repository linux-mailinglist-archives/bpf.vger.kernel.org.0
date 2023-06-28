Return-Path: <bpf+bounces-3627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B040740806
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 04:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57198280A79
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 02:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708C87492;
	Wed, 28 Jun 2023 01:57:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECCB6FCC;
	Wed, 28 Jun 2023 01:57:16 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA69EDA;
	Tue, 27 Jun 2023 18:57:14 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666e916b880so3036489b3a.2;
        Tue, 27 Jun 2023 18:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687917434; x=1690509434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aR09UvnO+C0yrEmoJgbCycYlDAjgsqpYPl8jeHQqB0=;
        b=XWXab/2OYcp5/9K2Sy/HGPhxYF0wx9CDcRIfYQXSC7TggbLRE+/RKRPJdc0cudEh4f
         bZrrEzMkcJN3Q0gdYx6oAX4GYcK6nWuVV4H9dN/emZtbVJfQx2ozja/e5XQcwgDIq0w/
         dvpah3nM8l9IZwZyMb9/pLD3zeVYvCTQM48ccfvQnzvi2+GkTY2+gL4IK290JafARs4G
         SVAUrT1RxF69mSaJOEuhYZcj/hzcrG7b/5tEA6zqmAsFpoAMu35q13UrFcoC6SHqblU4
         xkbTlnKu4CtTbrdS1UGeAjuGj7tyIiqQkCW8+JY82eYU5T9bYx2WGS5ggwDCW79TW7Je
         5DyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687917434; x=1690509434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8aR09UvnO+C0yrEmoJgbCycYlDAjgsqpYPl8jeHQqB0=;
        b=boDPOoEJ9JOkgV3CfpvAxGBCDdukstqOLdWWZJjH9MYT4SoaxF9JUBoscPjZoRr2O4
         ZIvG8mzOCrEPc1+oqHUZIbzl8Uz/L0GGqhBfoUHcmIBubp+t7dvUxfOmetoNLTDtJLlt
         9kQUvU90XFldXA1NQY0qvN/HqT+mjoIxPuKb5UZjb7IZ7vchsO/D+ezuS9jQnHaEv2Gu
         XxbKjS+HD8nR0WCw/ZYsaiMOcB3+ZxGZLcOQdR+vwcUnA0XOgS6tYm5ZN7N3HePf6kKs
         OY8LriqG0/aZ77wykb6sdOdN9c5FUxIaOVjUR7EHkko3CEctxjJqll4S5ynNECWdOonm
         GFRg==
X-Gm-Message-State: AC+VfDxCB2APWQS0KRs+zGFkvx/Zxepq06Zvrs04Yl6EbO8xyhTU7gA5
	g5MBFBlDW/aDUHGVUF18cxg=
X-Google-Smtp-Source: ACHHUZ5ce+6nnJ+5Kat7T9DptCpFc+nfXc8g6f7pbHKXN7huSHJNcvncn6zus3UMGa8SHHmbJeD3ww==
X-Received: by 2002:a05:6a20:4305:b0:123:c3dc:2052 with SMTP id h5-20020a056a20430500b00123c3dc2052mr15399992pzk.35.1687917434158;
        Tue, 27 Jun 2023 18:57:14 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:6420])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902848300b001a52c38350fsm6608462plo.169.2023.06.27.18.57.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Jun 2023 18:57:13 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 09/13] bpf: Allow reuse from waiting_for_gp_ttrace list.
Date: Tue, 27 Jun 2023 18:56:30 -0700
Message-Id: <20230628015634.33193-10-alexei.starovoitov@gmail.com>
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

alloc_bulk() can reuse elements from free_by_rcu_ttrace.
Let it reuse from waiting_for_gp_ttrace as well to avoid unnecessary kmalloc().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 93242c4b85e0..40524d9454c7 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -212,6 +212,15 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 	if (i >= cnt)
 		return;
 
+	for (; i < cnt; i++) {
+		obj = llist_del_first(&c->waiting_for_gp_ttrace);
+		if (!obj)
+			break;
+		add_obj_to_free_list(c, obj);
+	}
+	if (i >= cnt)
+		return;
+
 	memcg = get_memcg(c);
 	old_memcg = set_active_memcg(memcg);
 	for (; i < cnt; i++) {
@@ -290,12 +299,7 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 
 	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp_ttrace));
 	llist_for_each_safe(llnode, t, llist_del_all(&c->free_by_rcu_ttrace))
-		/* There is no concurrent __llist_add(waiting_for_gp_ttrace) access.
-		 * It doesn't race with llist_del_all either.
-		 * But there could be two concurrent llist_del_all(waiting_for_gp_ttrace):
-		 * from __free_rcu() and from drain_mem_cache().
-		 */
-		__llist_add(llnode, &c->waiting_for_gp_ttrace);
+		llist_add(llnode, &c->waiting_for_gp_ttrace);
 
 	if (unlikely(READ_ONCE(c->draining))) {
 		__free_rcu(&c->rcu_ttrace);
-- 
2.34.1


