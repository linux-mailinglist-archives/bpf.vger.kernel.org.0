Return-Path: <bpf+bounces-976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7358670A2EB
	for <lists+bpf@lfdr.de>; Sat, 20 May 2023 00:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB921C211F6
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 22:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA88567F;
	Fri, 19 May 2023 22:52:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4E0211A
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 22:52:07 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471B71B3
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 15:52:05 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d2981e3abso1581048b3a.1
        for <bpf@vger.kernel.org>; Fri, 19 May 2023 15:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684536724; x=1687128724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwmHpgDmVlTo8Kp5M3jmfH1KC96jBeC1s7SoCPSCjuo=;
        b=LYSiA2S3kunWusplK+mfGdkFGhwsM89VInsdYTaz1T/i4ByR6AF8Xr6mKWFeiuWsCH
         3XRZiomEXuqT9gRNaeHviyS9AxiKjotFmy7+jVsvLO7m1ON4mQbpbWUEYhvl45Vq3qbV
         2LQoey6wW+zubX2SVDU+GzwhasVZhENHAHuU+UK9SD8xcrU4IiS0pPdfEJPuN+ncXQRu
         aMlhh20l/imqB/p6pHs2g+r/k1pegVWo0ZetUMYpplzTed1jsF/SrgSxeIupVKv/EAQL
         JCX13UDnMbHThfOaDV8KEcqkfnkSuoCNxllfb6lwHV895XGn7N9jzxI0QmQ68avx5fjP
         1mxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684536724; x=1687128724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwmHpgDmVlTo8Kp5M3jmfH1KC96jBeC1s7SoCPSCjuo=;
        b=SXoqDJHsFWpYzsiFZOH2/rhYk90gHRtD4LX+GYkmVfdmQjgab14Xn0oVlGiK+zRxtd
         USIvrdzuwLW2uCJzEH8FRpvS0C759RM48y/ksB1Y7BlWLFIIltfJj3tKQOOrbxatkkQK
         PBlYkmUyRX3oRsz7hBqHzQ0JFfsPBr8vt0TmRND2Pm5QzSsU4ooV62khJsBoM6RetAZg
         Ef+vqDuy6YMpOA5BJv093C71QrRhaH1J+BmcD6IwMvikawHX/4e4N9bXSt/6nv9ZLYwg
         tO6Gu7oQ0y9sVrcYdi4xIUKk6vwu61Z06L01Ki3UcRdZUJ+AxSPj/lvDwQvqIQPQgKFy
         adHg==
X-Gm-Message-State: AC+VfDw7sKdkAO3+zMnvwxteNegvu08lZlBRcy24uYJWW8EHaWDpA81o
	Oig6GCCkF6L1J0aQhTk5g+ETemTFVmJ6XE/B6yw=
X-Google-Smtp-Source: ACHHUZ70yiPcw9CECQHrMsaJZgFSNdGHU9WQrYpfT1yO2zYugqxqJkVE9FnODZ4hBcU4G2hCEP3T0w==
X-Received: by 2002:a17:902:7289:b0:1ac:6084:1f4 with SMTP id d9-20020a170902728900b001ac608401f4mr3943384pll.27.1684536724489;
        Fri, 19 May 2023 15:52:04 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c08400b001a6ed2d0ef8sm117880pld.273.2023.05.19.15.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 15:52:03 -0700 (PDT)
From: Aditi Ghag <aditi.ghag@isovalent.com>
To: bpf@vger.kernel.org
Cc: kafai@fb.com,
	sdf@google.com,
	aditi.ghag@isovalent.com
Subject: [PATCH v9 bpf-next 2/9] udp: seq_file: Helper function to match socket attributes
Date: Fri, 19 May 2023 22:51:50 +0000
Message-Id: <20230519225157.760788-3-aditi.ghag@isovalent.com>
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

This is a preparatory commit to refactor code that matches socket
attributes in iterators to a helper function, and use it in the
proc fs iterator.

Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
---
 net/ipv4/udp.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c605d171eb2d..71e3fef44fd5 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2983,6 +2983,16 @@ EXPORT_SYMBOL(udp_prot);
 /* ------------------------------------------------------------------------ */
 #ifdef CONFIG_PROC_FS
 
+static unsigned short seq_file_family(const struct seq_file *seq);
+static bool seq_sk_match(struct seq_file *seq, const struct sock *sk)
+{
+	unsigned short family = seq_file_family(seq);
+
+	/* AF_UNSPEC is used as a match all */
+	return ((family == AF_UNSPEC || family == sk->sk_family) &&
+		net_eq(sock_net(sk), seq_file_net(seq)));
+}
+
 static struct udp_table *udp_get_table_afinfo(struct udp_seq_afinfo *afinfo,
 					      struct net *net)
 {
@@ -3013,10 +3023,7 @@ static struct sock *udp_get_first(struct seq_file *seq, int start)
 
 		spin_lock_bh(&hslot->lock);
 		sk_for_each(sk, &hslot->head) {
-			if (!net_eq(sock_net(sk), net))
-				continue;
-			if (afinfo->family == AF_UNSPEC ||
-			    sk->sk_family == afinfo->family)
+			if (seq_sk_match(seq, sk))
 				goto found;
 		}
 		spin_unlock_bh(&hslot->lock);
@@ -3040,9 +3047,7 @@ static struct sock *udp_get_next(struct seq_file *seq, struct sock *sk)
 
 	do {
 		sk = sk_next(sk);
-	} while (sk && (!net_eq(sock_net(sk), net) ||
-			(afinfo->family != AF_UNSPEC &&
-			 sk->sk_family != afinfo->family)));
+	} while (sk && !seq_sk_match(seq, sk));
 
 	if (!sk) {
 		udptable = udp_get_table_afinfo(afinfo, net);
@@ -3205,6 +3210,21 @@ static const struct seq_operations bpf_iter_udp_seq_ops = {
 };
 #endif
 
+static unsigned short seq_file_family(const struct seq_file *seq)
+{
+	const struct udp_seq_afinfo *afinfo;
+
+#ifdef CONFIG_BPF_SYSCALL
+	/* BPF iterator: bpf programs to filter sockets. */
+	if (seq->op == &bpf_iter_udp_seq_ops)
+		return AF_UNSPEC;
+#endif
+
+	/* Proc fs iterator */
+	afinfo = pde_data(file_inode(seq->file));
+	return afinfo->family;
+}
+
 const struct seq_operations udp_seq_ops = {
 	.start		= udp_seq_start,
 	.next		= udp_seq_next,
-- 
2.34.1


