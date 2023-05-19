Return-Path: <bpf+bounces-977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6E370A2ED
	for <lists+bpf@lfdr.de>; Sat, 20 May 2023 00:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F941C2121A
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 22:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3E1568D;
	Fri, 19 May 2023 22:52:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF0E5685
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 22:52:08 +0000 (UTC)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50220118
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 15:52:06 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-52caed90d17so2701874a12.0
        for <bpf@vger.kernel.org>; Fri, 19 May 2023 15:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684536725; x=1687128725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7mcSpdirUgkVBfG92gpr7cQ+vS0HR8NrlCwWzn4Gog=;
        b=e6ffNQ9gUmRoBBvh4BL7a8Mb1e1U83rFa8lMbFxAbQB5nd8FkMSEJeYDFhbuDXF4wq
         Bk2aXGQ4gIefYdr1aV4nuVOp9BdBQkZMuPN5aa/c4Pv2Ol9glrTEeOBy16Ahj4Go5Tv3
         JI1kI1z3WDa0ZacJpKZJ0zxbW+Xv4G8BRQmAbNSodmQVnVxzYebhjMyMGh0SqS3XjGql
         ZdBr4wVBeDPR+4gWgWsnt911phUAKbgEnXyKV5Ph50vNpQAQ/2BaUwSV9TDCDYJv7qsL
         WwfbXtxASTbY6kM2qpmFiWA1LJZMCdUb2Q/ZXm2CODjgDCY06LRlUG+9EdN7pCu34BLX
         5U5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684536725; x=1687128725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7mcSpdirUgkVBfG92gpr7cQ+vS0HR8NrlCwWzn4Gog=;
        b=UlL7JKdRPmSCzybOr66iptvZfOEIih3I0wIctIyNdLn8FSYqs7Lq44rENYqgffy7Q5
         bI6Pd/XSwQ476uZuvrQC9QgOs/m2BfyG02dpW+yxAZIr3T5W4TEMkzecOyvsbexGwBom
         rWts0vai8DaHfujjkqY7aNnjETlLePSHeJFzQt3NXclgd0CoXAWz7xKxwdcoTmfJZV8F
         116mes2peu+gTrIl5bFikOaaec/06B2R/UROcVxIOuGaIMa2rZ9T4Wr/dv1SN8zK6rg+
         qeZckZ+QvVgqWtLwG0v01MycM26kovQqCDdTd8HoKqFq+9Irl8PAHdglEudglxvyP1w1
         shjA==
X-Gm-Message-State: AC+VfDyyQo86e8Tw1fWaAXKIWEVeGSFHU7gfYNfXoFJXM7ENBirYt+Px
	ZShpuSkKpwPxV1OpTxfAxbBCEIZSOWdoAT9pyGU=
X-Google-Smtp-Source: ACHHUZ6NMvZCIdaoFVGSJdWmrSHsVjZeu1vbY0uoT6Vnb1bhgp5KOWCmXsWKOTPxTc0ceyRTey6cVw==
X-Received: by 2002:a17:902:ce83:b0:1ac:a030:c30a with SMTP id f3-20020a170902ce8300b001aca030c30amr4178495plg.19.1684536725473;
        Fri, 19 May 2023 15:52:05 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c08400b001a6ed2d0ef8sm117880pld.273.2023.05.19.15.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 15:52:05 -0700 (PDT)
From: Aditi Ghag <aditi.ghag@isovalent.com>
To: bpf@vger.kernel.org
Cc: kafai@fb.com,
	sdf@google.com,
	aditi.ghag@isovalent.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH v9 bpf-next 3/9] bpf: udp: Encapsulate logic to get udp table
Date: Fri, 19 May 2023 22:51:51 +0000
Message-Id: <20230519225157.760788-4-aditi.ghag@isovalent.com>
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

This is a preparatory commit that encapsulates the logic
to get udp table in iterator inside udp_get_table_afinfo, and
renames the function to `udp_get_table_seq` accordingly.

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


