Return-Path: <bpf+bounces-978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A34570A2EF
	for <lists+bpf@lfdr.de>; Sat, 20 May 2023 00:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427AD1C211B5
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 22:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE606AA7;
	Fri, 19 May 2023 22:52:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739EB5685
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 22:52:08 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2522DE43
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 15:52:07 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d3578c25bso1284248b3a.3
        for <bpf@vger.kernel.org>; Fri, 19 May 2023 15:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684536726; x=1687128726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPFdfU1/FNcaeQ9qRdTfmPayMhEgRQuBsJmqrhB0EAo=;
        b=jS3h1KtZcjzkNkHfdHSj8F9KDSB8NekUvnF/YcPqhtehGNuqUdvaQ+B7OTJN3qdjyJ
         z81C0Qr6kbTElwssJDM63jBWFDUJ/p4ZAs1Kj4b4U5fYraXmBxUwoS3ivyEX95sfsfVj
         19LK4qLkkt3abTT48/q39ghLnLqifn+Mh57nO3MUX2GPJLjaB1j+KNseyIIHJgA3vsBm
         /G6AZGBbH/jKCP98rVoBazS4XRswsOBVLFL3pTzGzZfnQlYP/90vqqnZBD7CifcvWN5y
         WfyvE98/H7g2nbJEsuqoSV+iND/8r/QEqFYg/sWRQhrOIAsWi4lFS9Q6eXZH4EUdHQI6
         azyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684536726; x=1687128726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPFdfU1/FNcaeQ9qRdTfmPayMhEgRQuBsJmqrhB0EAo=;
        b=VswSZy7bjYGs/dOg8duzICZbhWcP+OCOraQyED5h8Rd9VAhuOjWiGGN0urGgfCZR/l
         CugZop85SJnsSqusE1wA0dF5Y/I8qNnyzIiaiw9Rh3851sfZTmBbr8g4ku3MArS+2Th7
         JkEDBrjiBm3lW3rMyrHXXM5fgFQV3wZ0QhIjx8bAlc3u1OmuCCoP8Odo817g4IDKcyoN
         uHrm5YouxrS8/KEQOzLzgj7KzlUUIwIOWd4yhs/FxNMYIvBu7WxdSg1Ek4mfJYJdYEq6
         NrsJ7BplPuFkbVa51JBDkLmzR2NHXwpaxSCagGWSdXtJzFJOlOuJSfhofWJjOY8YOUWO
         /IdA==
X-Gm-Message-State: AC+VfDzEF4Rozvb4ej5T04+stsnEk4McQdQoAJ8qazEJ8Y/TrdZ1pwzT
	CF0CvS63TBOdiWNPrYYlNbj9BfK/p2Q8HSIkbyI=
X-Google-Smtp-Source: ACHHUZ6yb2StUUb7JCWKoZjhp4jK9MdlIy3eLAVBxPeR0IA1zoiSZANO5Emn7+hFlyA3O1udKS6baQ==
X-Received: by 2002:a17:902:d504:b0:1ac:9885:9f54 with SMTP id b4-20020a170902d50400b001ac98859f54mr4310211plg.63.1684536726423;
        Fri, 19 May 2023 15:52:06 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c08400b001a6ed2d0ef8sm117880pld.273.2023.05.19.15.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 15:52:06 -0700 (PDT)
From: Aditi Ghag <aditi.ghag@isovalent.com>
To: bpf@vger.kernel.org
Cc: kafai@fb.com,
	sdf@google.com,
	aditi.ghag@isovalent.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH v9 bpf-next 4/9] udp: seq_file: Remove bpf_seq_afinfo from udp_iter_state
Date: Fri, 19 May 2023 22:51:52 +0000
Message-Id: <20230519225157.760788-5-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519225157.760788-1-aditi.ghag@isovalent.com>
References: <20230519225157.760788-1-aditi.ghag@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is a preparatory commit to remove the field. The field was
previously shared between proc fs and BPF UDP socket iterators. As the
follow-up commits will decouple the implementation for the iterators,
remove the field. As for BPF socket iterator, filtering of sockets is
exepected to be done in BPF programs.

Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
---
 include/net/udp.h |  1 -
 net/ipv4/udp.c    | 27 +++++++--------------------
 2 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index de4b528522bb..5cad44318d71 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -437,7 +437,6 @@ struct udp_seq_afinfo {
 struct udp_iter_state {
 	struct seq_net_private  p;
 	int			bucket;
-	struct udp_seq_afinfo	*bpf_seq_afinfo;
 };
 
 void *udp_seq_start(struct seq_file *seq, loff_t *pos);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c426ebafeb13..289ef05b5c15 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2993,14 +2993,18 @@ static bool seq_sk_match(struct seq_file *seq, const struct sock *sk)
 		net_eq(sock_net(sk), seq_file_net(seq)));
 }
 
+#ifdef CONFIG_BPF_SYSCALL
+static const struct seq_operations bpf_iter_udp_seq_ops;
+#endif
 static struct udp_table *udp_get_table_seq(struct seq_file *seq,
 					   struct net *net)
 {
-	const struct udp_iter_state *state = seq->private;
 	const struct udp_seq_afinfo *afinfo;
 
-	if (state->bpf_seq_afinfo)
+#ifdef CONFIG_BPF_SYSCALL
+	if (seq->op == &bpf_iter_udp_seq_ops)
 		return net->ipv4.udp_table;
+#endif
 
 	afinfo = pde_data(file_inode(seq->file));
 	return afinfo->udp_table ? : net->ipv4.udp_table;
@@ -3424,28 +3428,11 @@ DEFINE_BPF_ITER_FUNC(udp, struct bpf_iter_meta *meta,
 
 static int bpf_iter_init_udp(void *priv_data, struct bpf_iter_aux_info *aux)
 {
-	struct udp_iter_state *st = priv_data;
-	struct udp_seq_afinfo *afinfo;
-	int ret;
-
-	afinfo = kmalloc(sizeof(*afinfo), GFP_USER | __GFP_NOWARN);
-	if (!afinfo)
-		return -ENOMEM;
-
-	afinfo->family = AF_UNSPEC;
-	afinfo->udp_table = NULL;
-	st->bpf_seq_afinfo = afinfo;
-	ret = bpf_iter_init_seq_net(priv_data, aux);
-	if (ret)
-		kfree(afinfo);
-	return ret;
+	return bpf_iter_init_seq_net(priv_data, aux);
 }
 
 static void bpf_iter_fini_udp(void *priv_data)
 {
-	struct udp_iter_state *st = priv_data;
-
-	kfree(st->bpf_seq_afinfo);
 	bpf_iter_fini_seq_net(priv_data);
 }
 
-- 
2.34.1


