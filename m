Return-Path: <bpf+bounces-806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D22707028
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 19:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46C1281595
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 17:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD9F31EF2;
	Wed, 17 May 2023 17:56:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E5410966
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 17:56:38 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112BF1724
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 10:56:37 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2534d7abe8bso548054a91.3
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 10:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684346196; x=1686938196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M7mcSpdirUgkVBfG92gpr7cQ+vS0HR8NrlCwWzn4Gog=;
        b=gcQZDmkFG08yvkELFW4xN8gxSmJyJjqRESbBjoEgL1Ob0SDrbp3FQF7q7TfJF+CJaL
         tebkQ3qxSiUqKY4LToBbaB9Mgry/6EAtP9yO6WsgO0qrEKOySpCxbbfP5B9t4+dPdCSi
         waGsuYhPE103yImT6icBnheeO3Fc/Yw45wctWY+q5wKkYSPFi6eJS6d0UuIewWjTDCds
         XGs0iSibEMz+MDl6Tu54e9oZ2ikX36T33zshQKpDN6MEYnxzUog+khiW1cN7fNhJe4mJ
         IG7agdulC/6JLec5zkgAnGvDf3M/4NRjGv323K0GIC1WnRYQozTSEQHtDI7qAPaJ/Olq
         maFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684346196; x=1686938196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7mcSpdirUgkVBfG92gpr7cQ+vS0HR8NrlCwWzn4Gog=;
        b=Vpu2Z19oM2/L/ILjYQyeUev068ION7umUWTs/cLohh8ywanMf6JkNTPw3/Zv89PjQt
         Wbp2fU50ILPXSz0+g7zTH23AZnaPTuvvwOI8+5iFWFq5RCf9WM/yNbuykQ0j2vymq+o4
         LUe7v/zZ2Lcek7nFKFwNeixPJf+HmOL3AhtbxteucalROyC3ZI3aKN076qwRJQCMUHXh
         hI9PkugYZPSEp9tShg0NIPdF23oNPr0bVZ2MCGsZDDIZlMHFHNR4dmohhmwA0DzXq3IR
         Lvd0bVN2IDjGuKlNhyO33H+IWDxcxLZ3DhShMFG6+7Zwi9d5KTwMIzPkmuIcvJCOcclc
         DXyw==
X-Gm-Message-State: AC+VfDyYN4Of+XvMAV1JlIj71/f6sLC9hctkBN/wc9ZcGem4FCjHHYwC
	yXHrum8R5VvVpj1YBVWIaWCnT8c7rmuI4oIHpRA=
X-Google-Smtp-Source: ACHHUZ58Lh7rMwLbjtC/yj4o8Q2tgqFxavft3G+CVKWV4S0qHG4OTYGMmwuK3iKBaR1ocZCWzCoJHw==
X-Received: by 2002:a17:90b:4a83:b0:253:3e9d:f925 with SMTP id lp3-20020a17090b4a8300b002533e9df925mr450054pjb.31.1684346196106;
        Wed, 17 May 2023 10:56:36 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id 63-20020a630142000000b0051303d3e3c5sm15819857pgb.42.2023.05.17.10.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:56:35 -0700 (PDT)
From: Aditi Ghag <aditi.ghag@isovalent.com>
To: bpf@vger.kernel.org
Cc: kafai@fb.com,
	sdf@google.com,
	aditi.ghag@isovalent.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH v8 bpf-next 03/10] bpf: udp: Encapsulate logic to get udp table
Date: Wed, 17 May 2023 17:56:27 +0000
Message-Id: <20230517175627.528080-1-aditi.ghag@isovalent.com>
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


