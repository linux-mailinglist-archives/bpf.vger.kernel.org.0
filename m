Return-Path: <bpf+bounces-3344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D105B73C66F
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 05:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDCE71C21423
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 03:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F8910E8;
	Sat, 24 Jun 2023 03:13:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C357F;
	Sat, 24 Jun 2023 03:13:50 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8ECB26A6;
	Fri, 23 Jun 2023 20:13:49 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a1a0e5c0ddso977738b6e.1;
        Fri, 23 Jun 2023 20:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687576429; x=1690168429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5dE0XhJvwd5u50dMmi7rGk+uakRp6is0d4Rg5rl7Ow=;
        b=hpZ9HhPDM1nf+tG/dgz5CbyK6JskPYmgSNgtMBSfEj5nKfnCL/JivLXBH0KcnHfwL7
         owq7PxTSOBaxCVy6ANkWcbMAIohRJxae1V+SI/Rq7ry+Di0jKj5MqJITLdcvwbzFXyd2
         B8HAWpi+D7xVyyrBW24fBg5fQNph60sqihjGGpgquBEWAjcbR8vFtIIUn/Yk0JJekFk5
         WuGbfTJzCcguVm1ZPOaSWOQDx7RVpWDzQtBp8Dfu4YRRA3Wa4rdLaKj9S2TsiKkUexm8
         qvl6sj5Lyrj9Bs9bp7TR69DqS0dINYl88cCS2THm08CFeBRMjUurOXXq2iyCqciCDZbk
         qBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687576429; x=1690168429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5dE0XhJvwd5u50dMmi7rGk+uakRp6is0d4Rg5rl7Ow=;
        b=GFe6nPriTsQD5Z0tWVIEUhtduWlmnRGDGQXUNE61vOj2rzZU2wBuOrm2JX/lDKGCjY
         hwaPpw/dHcESHQCMWM7AtRbMkcR8KLqLCuVmguA4vy0Lwo1zybadQ4OvdNKbE390zz6n
         bgft7oiZkhWiMPgEfB8iLFcET3KdmMtdy1KeKq2H2KjYuuMlCzk3qjeVNR6EiOLKCGrO
         +QLLpQNwgx7NPkapxWYTmLMcy1dfyVC1fqRg/UDTGhinOB+xEys0mNK4GgZ9eXKBbY8T
         C9pBlsJvFiYkTkkYTgSBRSbHDqB5QcJnpkJQfWf7gSuJOoSimH6TInxZZzd9KUr4TP/I
         M2rg==
X-Gm-Message-State: AC+VfDxRnHAIQ82le5n0fCux5IKvG0//8gOFfj8u7LqLIZdLxXMQMIbN
	FtKVOlM7VYqrfu14PRjEcqI=
X-Google-Smtp-Source: ACHHUZ4jZMpMrsj+OpLLGbg2UbRX2WERNS2Nssi9AirVeFLiHXVPn1tdCgLQWtjj01zXaVBkFsthww==
X-Received: by 2002:aca:2411:0:b0:3a1:b24b:9ae6 with SMTP id n17-20020aca2411000000b003a1b24b9ae6mr2535566oic.36.1687576428933;
        Fri, 23 Jun 2023 20:13:48 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:b07c])
        by smtp.gmail.com with ESMTPSA id s21-20020a170902989500b001b3f039f8a8sm245920plp.61.2023.06.23.20.13.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Jun 2023 20:13:48 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 03/13] bpf: Let free_all() return the number of freed elements.
Date: Fri, 23 Jun 2023 20:13:23 -0700
Message-Id: <20230624031333.96597-4-alexei.starovoitov@gmail.com>
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


