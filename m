Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA236F6194
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 00:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjECWyI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 18:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjECWyD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 18:54:03 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CA346A6
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 15:54:01 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1aaea3909d1so45634165ad.2
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 15:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1683154441; x=1685746441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi6aaC/8l3i5QxK9tIEa5YGWbVWWHfYetJOJa5yrsp0=;
        b=QA7c9Gm3zfvDBCcdyrUDRH8Nm2/FN7c+6Gk7FeU/blv/jN6Guwvvw0HNKJWipVEQm1
         3exG4BD1SOdxqYixeinjntWUx7JF75l/R7BeerYNtUvl1BOmw7pPxdrnUT+J5sv3/S3y
         4tL2rKJBqa39CQ0KurAYJjzKFXyLw6OlJQNHB+oiwzhgrgO0SIwG5hzRHrjpldX7Y/pc
         mjes8c72msnKmDDT2K5gGcXOMnkbEeZKHGeJbfv+wIVOPsYYdmq7yI1Dr6JoLob1GD5G
         9CwMU/oPt+0wui2AJNTEHYnTX/N303TZNKMjevdLXZEvczlbALBDEZGUwcObdU9Wg4OE
         snDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683154441; x=1685746441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mi6aaC/8l3i5QxK9tIEa5YGWbVWWHfYetJOJa5yrsp0=;
        b=JuTFElVSiR41H07UicBBn7hChPt4g3JMKymeq4voGBUmBOiill/x1xrbo4o7zTDhwN
         k2Nu5ZFGPXVgGjPdGr+t3QzLdWcS0JtlFnfUGDh8hogqMADS1OLRISAzyEXHltczTl9H
         FPvOZxzMYnaUBG/QIDAMRoMzZJLZisO6o7qupNYi2Hhduq9me0Cc3xl+gKy5UwGf1AKf
         ua0PqTMx7ovQLf9TdBv7hFAuSf8i30ksz0AsOWshQ3TQmD7RxAeTPuXoK0W0yeVebP2U
         q/8rLejejSqLZmTdTdXQmJ+yyVr2zGYxhdkdaaTaDhRYS9zxdXlEChjfc9yZw9tr8MJm
         hlCQ==
X-Gm-Message-State: AC+VfDzbezoU7Gc0u6KvSLBSNsBWe76hlWuVpUUpiie44m/I4LB5Eus8
        e7nbAeHHo9xXd7igxMsU15zRyv3pXtfHHpRUx/M=
X-Google-Smtp-Source: ACHHUZ4CCzf9G27k/hrZfQVp05Lc6h80vw+GUjHZVhoy0OjYqIWGolTlrQZEhYao6HXcYW6k32b1Yw==
X-Received: by 2002:a17:903:32c9:b0:1a6:8ed5:428a with SMTP id i9-20020a17090332c900b001a68ed5428amr2146101plr.22.1683154440657;
        Wed, 03 May 2023 15:54:00 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709028a8200b001a641e4738asm2200443plo.1.2023.05.03.15.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 15:54:00 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, aditi.ghag@isovalent.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH v7 bpf-next 03/10] bpf: udp: Encapsulate logic to get udp table
Date:   Wed,  3 May 2023 22:53:44 +0000
Message-Id: <20230503225351.3700208-4-aditi.ghag@isovalent.com>
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

This is a preparatory commit that encapsulates the logic
to get udp table in iterator inside udp_get_table_afinfo, and
renames the function to udp_get_table_seq accordingly.

Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
---
 net/ipv4/udp.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 71e3fef44fd5..c426ebafeb13 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2993,9 +2993,16 @@ static bool seq_sk_match(struct seq_file *seq, const struct sock *sk)
 		net_eq(sock_net(sk), seq_file_net(seq)));
 }
 
-static struct udp_table *udp_get_table_afinfo(struct udp_seq_afinfo *afinfo,
-					      struct net *net)
+static struct udp_table *udp_get_table_seq(struct seq_file *seq,
+					   struct net *net)
 {
+	const struct udp_iter_state *state = seq->private;
+	const struct udp_seq_afinfo *afinfo;
+
+	if (state->bpf_seq_afinfo)
+		return net->ipv4.udp_table;
+
+	afinfo = pde_data(file_inode(seq->file));
 	return afinfo->udp_table ? : net->ipv4.udp_table;
 }
 
@@ -3003,16 +3010,10 @@ static struct sock *udp_get_first(struct seq_file *seq, int start)
 {
 	struct udp_iter_state *state = seq->private;
 	struct net *net = seq_file_net(seq);
-	struct udp_seq_afinfo *afinfo;
 	struct udp_table *udptable;
 	struct sock *sk;
 
-	if (state->bpf_seq_afinfo)
-		afinfo = state->bpf_seq_afinfo;
-	else
-		afinfo = pde_data(file_inode(seq->file));
-
-	udptable = udp_get_table_afinfo(afinfo, net);
+	udptable = udp_get_table_seq(seq, net);
 
 	for (state->bucket = start; state->bucket <= udptable->mask;
 	     ++state->bucket) {
@@ -3037,20 +3038,14 @@ static struct sock *udp_get_next(struct seq_file *seq, struct sock *sk)
 {
 	struct udp_iter_state *state = seq->private;
 	struct net *net = seq_file_net(seq);
-	struct udp_seq_afinfo *afinfo;
 	struct udp_table *udptable;
 
-	if (state->bpf_seq_afinfo)
-		afinfo = state->bpf_seq_afinfo;
-	else
-		afinfo = pde_data(file_inode(seq->file));
-
 	do {
 		sk = sk_next(sk);
 	} while (sk && !seq_sk_match(seq, sk));
 
 	if (!sk) {
-		udptable = udp_get_table_afinfo(afinfo, net);
+		udptable = udp_get_table_seq(seq, net);
 
 		if (state->bucket <= udptable->mask)
 			spin_unlock_bh(&udptable->hash[state->bucket].lock);
@@ -3096,15 +3091,9 @@ EXPORT_SYMBOL(udp_seq_next);
 void udp_seq_stop(struct seq_file *seq, void *v)
 {
 	struct udp_iter_state *state = seq->private;
-	struct udp_seq_afinfo *afinfo;
 	struct udp_table *udptable;
 
-	if (state->bpf_seq_afinfo)
-		afinfo = state->bpf_seq_afinfo;
-	else
-		afinfo = pde_data(file_inode(seq->file));
-
-	udptable = udp_get_table_afinfo(afinfo, seq_file_net(seq));
+	udptable = udp_get_table_seq(seq, seq_file_net(seq));
 
 	if (state->bucket <= udptable->mask)
 		spin_unlock_bh(&udptable->hash[state->bucket].lock);
-- 
2.34.1

