Return-Path: <bpf+bounces-4159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A99749461
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 05:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE74281175
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 03:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6387B748F;
	Thu,  6 Jul 2023 03:35:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1BB63B7;
	Thu,  6 Jul 2023 03:35:28 +0000 (UTC)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4B51BC8;
	Wed,  5 Jul 2023 20:35:27 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-55b1238cab4so149042a12.2;
        Wed, 05 Jul 2023 20:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688614527; x=1691206527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wO9G0EswJ/clqhMAYknq09+PSdQoMWL3dAjmtV4xtc=;
        b=NCFy5LJWSD94GDPz68RNYmd+hZU6Gu4dl6swGsYtpDZ/2fxy1NrcODA8LwleB0jRBC
         5JNwzu50beppCBISHHksoo3o2zZqrWh/lJq2gwy93hAyIqi8o9xjYcyFyoHaqQmitsfm
         fZ3+Nd9+TC8eQ7e6DxMTqEip12Kz2GmWhWaNvkkMNYBey2eKQNs3a1lV+SpM98WXmtyO
         Pcj/8InvBlfG0UjwUUuiDO+gIT3PrmvVk9pB/gDfUPuefL2gnOD82Xo4tzQbVnh5wZ6l
         M7KxPFSbQiANYAkTjUFzXl1yJ+h9tt2Bs5cuQycv5h0WeWKvIp/DaU6YmAh6HuXgKGUq
         3o7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688614527; x=1691206527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wO9G0EswJ/clqhMAYknq09+PSdQoMWL3dAjmtV4xtc=;
        b=P7XDwBc/MIRU+osQWdb3y0duAUu6LXzeGXh0RB/3J79Z/RejA7NYh7gxbzpn1QgcYL
         ExL7jjPuCmqpPy7x73koBAM86D3MjjrNbmMcaM91dWtqJQVg2SnIJ0nMKNi09MwqS1LN
         NZ7lWP8qpjwIeKtlWJmX9H6nYUtHuvPr3hFSDHjrVjokYEGcJpx2ZwW957Rd1eeNWZC4
         0nRdShFbflhtvDwjnHqpZHbDQ2NXhSZj3z5/jKezMkzuX4TnvePoKCcIXhB1GygnhFEo
         p1pJ6XUUHwPgcoUA/4rOpwvzTpkTM6xl2lEQ3OnNYh6uTG8w5DTn1fe1OZTi+izzkpR/
         12Yg==
X-Gm-Message-State: ABy/qLbSw4ZQGxdDc3DfCzb92n0zKi9XfIXpbA+eDP+4NYdAEEoiWTwZ
	5YwToDgCT4n+/Nkz24Yt9vo=
X-Google-Smtp-Source: APBJJlHewuq2MG+fG/uHdZZNLPosh3ErVF6uSyt61Qj6lbp/EFICkOYCbgNN0ycvKjoEdc2fshuBSA==
X-Received: by 2002:a17:90b:e10:b0:263:16f3:f04a with SMTP id ge16-20020a17090b0e1000b0026316f3f04amr455542pjb.1.1688614526611;
        Wed, 05 Jul 2023 20:35:26 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:f715])
        by smtp.gmail.com with ESMTPSA id j13-20020a17090a694d00b00263fc1ef1aasm1096185pjm.10.2023.07.05.20.35.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Jul 2023 20:35:26 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 09/14] bpf: Allow reuse from waiting_for_gp_ttrace list.
Date: Wed,  5 Jul 2023 20:34:42 -0700
Message-Id: <20230706033447.54696-10-alexei.starovoitov@gmail.com>
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

alloc_bulk() can reuse elements from free_by_rcu_ttrace.
Let it reuse from waiting_for_gp_ttrace as well to avoid unnecessary kmalloc().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 9986c6b7df4d..e5a87f6cf2cc 100644
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
@@ -295,12 +304,7 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 
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


