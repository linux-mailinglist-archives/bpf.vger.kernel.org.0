Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818386E6827
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 17:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjDRPcF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 11:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjDRPcD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 11:32:03 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292ECE60
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 08:32:01 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1a6670671e3so19297075ad.0
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 08:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681831920; x=1684423920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUqvsQSwIrgdlIXUPleFIEFJtWEpRJgT9Zrnu0X6Er0=;
        b=RW1DyetObtW4pDXVWkzzaDts3DFVkqsbpWXAcSLxG39TGlQ7DRZTYzwJzIwAn26wU0
         6uOqZm8maQ1FmRgcGKvRYvFoiCpVxp5kblso9zOi4yvcbxDAVvlQlU83ZIdtrEaDxR6K
         fTm6nHpiCcR068rhM5DGvkif1E4ywlJVfSB4Ri6vDCdFs33sXNF2VO7KwQsYIEiTigK1
         Xlo+UqNzWwEe9L0r5a67NhTSVlPMnxWyS0CyLTmkown1EAII/pZq0yHo3+wZ/DTL5J8A
         pDwpRymyldgA3yyka2bKobLoGzW4QbCyYf6vG0r3lVCW8rhwFO9hd1xbi/CIXrwO5PgW
         oppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681831920; x=1684423920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUqvsQSwIrgdlIXUPleFIEFJtWEpRJgT9Zrnu0X6Er0=;
        b=kMXBgFBWuOt+S1iBT4pOOEsgj1MS1DLdSu0RSeajB1FWVhAHpqBX4i8MoDyTnzQMrs
         0/8jUGPOHEG7ppSiyY2gWSjaDdZoRqlV883hWjv+o+tg/hx3iHGTct2+opEuPbXpMDdO
         yvS+w3aQmBPxxb+dTFteXSdxckyg2VSc2RJj5Dtz7w2omoRKow1KlxS11wggPc3r51iB
         Icr5Vfm8BXLsoA9GtJ1BZWLZiYdCPU+Xq6F48eXrLTqf13L7KSEMlEO3eu6S4q0FskO/
         hu3ohhsa3oSM5ZJmNpl6QGWh1rJeGLEbha0CBwkl5m/iW8FJZCMV3wiiCjrvyJhqdyv4
         yNyw==
X-Gm-Message-State: AAQBX9cTDz6s4Qv95xVlC418YE4+RBdXQ3+AtheVdvoNY3C13cw/VNJT
        LUVbBqC33RgN5wzAkVFPmjPetHJfzcg0GQZ5m/E=
X-Google-Smtp-Source: AKy350a1EHyblUB/s1bHM9EFvt+fHwI9hmiNr2tpXYAq53jDjYu7LBWUcT4ITH+qAmF5wDUEo4CI1A==
X-Received: by 2002:a17:902:d2c6:b0:1a6:45f7:b332 with SMTP id n6-20020a170902d2c600b001a645f7b332mr2786421plc.63.1681831920301;
        Tue, 18 Apr 2023 08:32:00 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id ba4-20020a170902720400b001a647709864sm9769630plb.155.2023.04.18.08.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 08:31:59 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        aditi.ghag@isovalent.com, Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH 2/7] udp: seq_file: Remove bpf_seq_afinfo from udp_iter_state
Date:   Tue, 18 Apr 2023 15:31:43 +0000
Message-Id: <20230418153148.2231644-3-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
References: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
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
 net/ipv4/udp.c    | 34 ++++------------------------------
 2 files changed, 4 insertions(+), 31 deletions(-)

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
index c605d171eb2d..3c9eeee28678 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2997,10 +2997,7 @@ static struct sock *udp_get_first(struct seq_file *seq, int start)
 	struct udp_table *udptable;
 	struct sock *sk;
 
-	if (state->bpf_seq_afinfo)
-		afinfo = state->bpf_seq_afinfo;
-	else
-		afinfo = pde_data(file_inode(seq->file));
+	afinfo = pde_data(file_inode(seq->file));
 
 	udptable = udp_get_table_afinfo(afinfo, net);
 
@@ -3033,10 +3030,7 @@ static struct sock *udp_get_next(struct seq_file *seq, struct sock *sk)
 	struct udp_seq_afinfo *afinfo;
 	struct udp_table *udptable;
 
-	if (state->bpf_seq_afinfo)
-		afinfo = state->bpf_seq_afinfo;
-	else
-		afinfo = pde_data(file_inode(seq->file));
+	afinfo = pde_data(file_inode(seq->file));
 
 	do {
 		sk = sk_next(sk);
@@ -3094,10 +3088,7 @@ void udp_seq_stop(struct seq_file *seq, void *v)
 	struct udp_seq_afinfo *afinfo;
 	struct udp_table *udptable;
 
-	if (state->bpf_seq_afinfo)
-		afinfo = state->bpf_seq_afinfo;
-	else
-		afinfo = pde_data(file_inode(seq->file));
+	afinfo = pde_data(file_inode(seq->file));
 
 	udptable = udp_get_table_afinfo(afinfo, seq_file_net(seq));
 
@@ -3415,28 +3406,11 @@ DEFINE_BPF_ITER_FUNC(udp, struct bpf_iter_meta *meta,
 
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

