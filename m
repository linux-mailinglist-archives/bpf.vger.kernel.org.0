Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87D46F6195
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 00:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjECWyI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 18:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjECWyE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 18:54:04 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931AE44B7
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 15:54:02 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64115eef620so8451971b3a.1
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 15:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1683154442; x=1685746442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcKx3nBKX8xE4I77EWn/gEVYn3xfHIo69qJzSU3VXDM=;
        b=h15aTaaNLw+ceV+c+QIVUDdZ3UcRmPrhmZwzfT9CazYtiaTvOugavkwVnvoG3Nn2v4
         7gXKGD/jp0CrPPTaIxC2F6RT5UYyaBhhafbW2X4Jaqc3qxAip4W1iSCfUD0darCIPQo2
         MfGDqxQlV83WmmS8ncRc9Y3HsIaSfD2guJWAPSoIjq0/dSuJspRUeL0Fl1P1fK4FtKwh
         oNGjhIlaGJgSsH/a/B1gkKoHGX4uP1PqgJK4RHv7MrPq5f0BZUDd1/5cRaOKchecec8i
         yFj0WthymzuMqpYOxoakFuCR/g26rQpiqIulx4ln2EU7chIoX7Ska8RCb24gg7HgwrJ/
         aDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683154442; x=1685746442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcKx3nBKX8xE4I77EWn/gEVYn3xfHIo69qJzSU3VXDM=;
        b=ICPSkcpR/xArofxwD+vPPeaOhofaXjZxOtavZJSqocu/4C6TuSHcJJyC/rXYwCAQgH
         /EO5va1ls/dBKaKAKejrHMdpPIRsbOeIV1wO9d2uJW8/+gF4Hy/DDI57dXwPaTaD04Zp
         oHqlG1QZGmZXBljZ0S8e2Moad7DbozHVhCDnEL4nYZ7iJT3hkle+ndcGXyybXH5BP1nP
         QuJlA+P2z2w9Ljnwpfpf4qrtSboPjgko2z2RMyAzhYFDJZiTKodemCMPhOLCJ9U0S0ia
         04N3fZGaS1jzeTM3rda35tju0Hzfby7LX8XXkwcJ6K5NUe3DULJCTEQhwTRTD5L/G3b5
         xFOQ==
X-Gm-Message-State: AC+VfDwPGmm2fXoeEsqZo8Ap9K/10CMnjbUSpLT6H3oawU7xvv5EmpFA
        19BnjM5PCaaQxj+oZb9pCGTvYl1GU9D9i04Rxds=
X-Google-Smtp-Source: ACHHUZ7mMRMEVLtjRRkSu1jiJQkBpNiQUEapOssD83MDtEg4/hTWOnr+suNrFfm7lUsbx7YTCNz/4g==
X-Received: by 2002:a17:902:d2c5:b0:1a6:d0a8:c70f with SMTP id n5-20020a170902d2c500b001a6d0a8c70fmr1454819plc.5.1683154441735;
        Wed, 03 May 2023 15:54:01 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709028a8200b001a641e4738asm2200443plo.1.2023.05.03.15.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 15:54:01 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, aditi.ghag@isovalent.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH v7 bpf-next 04/10] udp: seq_file: Remove bpf_seq_afinfo from udp_iter_state
Date:   Wed,  3 May 2023 22:53:45 +0000
Message-Id: <20230503225351.3700208-5-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230503225351.3700208-1-aditi.ghag@isovalent.com>
References: <20230503225351.3700208-1-aditi.ghag@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a preparatory commit to remove the field. The field was
previously shared between proc fs and BPF UDP socket iterators. As the
follow-up commits will decouple the implementation for the iterators,
remove the field. As for BPF socket iterator, filtering of sockets is
exepected to be done in BPF programs.

Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
---
 include/net/udp.h |  1 -
 net/ipv4/udp.c    | 25 +++++--------------------
 2 files changed, 5 insertions(+), 21 deletions(-)

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
index c426ebafeb13..9f8c1554a9e4 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2993,14 +2993,16 @@ static bool seq_sk_match(struct seq_file *seq, const struct sock *sk)
 		net_eq(sock_net(sk), seq_file_net(seq)));
 }
 
+static const struct seq_operations bpf_iter_udp_seq_ops;
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
@@ -3424,28 +3426,11 @@ DEFINE_BPF_ITER_FUNC(udp, struct bpf_iter_meta *meta,
 
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

