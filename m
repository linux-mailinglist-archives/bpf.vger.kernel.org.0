Return-Path: <bpf+bounces-807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC31270702F
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 19:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677132815DA
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 17:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0425831EF4;
	Wed, 17 May 2023 17:57:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D087910966
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 17:57:18 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B0A10D0
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 10:57:17 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ae3bd3361dso2446505ad.1
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 10:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684346237; x=1686938237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gPFdfU1/FNcaeQ9qRdTfmPayMhEgRQuBsJmqrhB0EAo=;
        b=c9Y+83XIm+phnPsmYd2Mry8+eQPf7RTGvKZPSdI+i9Cu3VQY8H3LrGhI5lB67nFl5I
         Qmgo/l1XRilD21OuQC0PGU3VFrvWRucHf1xQWCjVxjwaqKOH53uX3je+fKIQB+c0isN8
         uPrQUo0sEQ0lFVpmlbUNrqngwr9AuvQyoh+ua5E6rII8YSNREGEKQVL1aUnazOYFXYMG
         ZcmEKxILPe0wPmsBtMz1N64yb8dP3FmONIwOzsAyLmD4od5L7CzTjGrjXOGwx/xEdGsY
         mTRKTcEI7LnCtmcOsHvsgqDImdIJiClAwCrYgwwgqc2fVRrTDUyZVmTALjdRb5xzt0QT
         gaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684346237; x=1686938237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gPFdfU1/FNcaeQ9qRdTfmPayMhEgRQuBsJmqrhB0EAo=;
        b=jOVCMkZKa/aMeQCKzqTxA66v8kFB5HJFMxGOSH4f9Pyt7TsbV9UBTF65wsYkunzXnB
         piBJvE5qFjzwNiz3yGoIM1MZagg4jrjCXh+LOoRpSpleegOBKrXYTRvWQDgUOc8VV/Od
         XVnLrvLvaI9i9FNLCdaCB6TQMykpqCl9u30fsZkSagCEE7f741ONOspo4TzyLrgfMdi/
         cgVvYA28PkAKMHXAtyXvaCgL9zkN9RV0D7wdZ9KFsoJMFRj9g8GZWt5izlJ45PbkQK72
         C6/En6OlSV3b/GCP6Ccrw5zlCkuujX69h3En1eXocpADX6eI3Dd1RARHU5Cp4Eo0Av/a
         QVOA==
X-Gm-Message-State: AC+VfDzlcQrxirg5p1v3wm7/D1NqCTT5JhQZ2SqoLkHZiy4w81gu7KuQ
	52Z96OROg/jgANVNIbbRP624An3rD0p6eXT36fw=
X-Google-Smtp-Source: ACHHUZ5KKt26OondzSXmb6nwaFlVLy872GlIQuNvD32fLphhfyoW3x7RErAfR/fouBdyWR9EFmzkIQ==
X-Received: by 2002:a17:902:c403:b0:1a9:4cd5:e7e0 with SMTP id k3-20020a170902c40300b001a94cd5e7e0mr4417578plk.17.1684346236797;
        Wed, 17 May 2023 10:57:16 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id w10-20020a1709029a8a00b001a95c7742bbsm17979962plp.9.2023.05.17.10.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:57:16 -0700 (PDT)
From: Aditi Ghag <aditi.ghag@isovalent.com>
To: bpf@vger.kernel.org
Cc: kafai@fb.com,
	sdf@google.com,
	aditi.ghag@isovalent.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH v8 bpf-next 04/10] udp: seq_file: Remove bpf_seq_afinfo from udp_iter_state
Date: Wed, 17 May 2023 17:57:11 +0000
Message-Id: <20230517175711.528170-1-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
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


