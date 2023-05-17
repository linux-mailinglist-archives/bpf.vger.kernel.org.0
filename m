Return-Path: <bpf+bounces-805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEE4707013
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 19:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C00280F87
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 17:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9941431EF1;
	Wed, 17 May 2023 17:55:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3C310966
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 17:55:33 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FE6BE
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 10:55:31 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6439f186366so787684b3a.2
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 10:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684346131; x=1686938131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qwmHpgDmVlTo8Kp5M3jmfH1KC96jBeC1s7SoCPSCjuo=;
        b=cguQi9Wa88u74CLoidFpgp4ILYJIHpAvUY5uuNqwy5fmtZenAW/Q4AbbXeUyh1Ny6c
         ebILhQDE8CxacdJd2tBJtuwwlkEuWjD+fhHoiMIiJeTbX3TUD/9TO7OZ26JykN9Nzvbp
         dkw2CP01W9AoVzX+HkQK1WC2DEGfqjNzOXaLh47ai+QJ76xM13ArunuvCVG/ZpX2mxwt
         9f5jNrsR9HlHB2OLBAzgYUelGzvAp1gP4l6m1WCm8Tja8qvJWOmvVwM2lzSmcpuAOL/0
         XrdG7HOJ/WnlXjgCywvK28SlCsAjJCEdT9RY1TQC1pxb6Mpco1d3xF1KAnDBPJEsnPVg
         lC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684346131; x=1686938131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwmHpgDmVlTo8Kp5M3jmfH1KC96jBeC1s7SoCPSCjuo=;
        b=PVJBY2scCMCdk0MOWcZzKm61BVsDT6veIzVU+oGchvs+Uf3t/wcK6OQifgYv+s/uOB
         b7LytRQB/wIpMXExEt/2rUhpEKo08RF9Ir5NONkUEFBLCoGio+kx3xpo/5auOf9wsGIn
         iA5D6hsZ/kINErHDdmOEEZ82Nv2zV72IQLkaNqZ9xZBlWkxzKM1x8jXF5sjtfroCw3zJ
         lJvAomTSUMPC9NL9PHX6QQUc6h38yWiZ9dnUiFoXcplxKELxvVDNIdcOj+Qfr3Ajcrbc
         HrfcFnWBwYA6Fc+SgI9Oi1OkBfJWWTFL3bg2dAcZbofldSBSWo7PHiEEDkXq72y9KG8B
         rFWA==
X-Gm-Message-State: AC+VfDx99Kf/G6LNPfGXj1cuk6NJgehuYrhsvBQpxQiCdh/RaPAbkkTD
	GJuWIJDM37Mh+e+UVMbeInK680KgOipAoh94PLI=
X-Google-Smtp-Source: ACHHUZ4NLMm8p6CzTp9maeiojyGTSQksY0L51Lsaynw6Rh8vmR4zSsa17VCMwHbCX58edv8O4JEDMA==
X-Received: by 2002:a05:6a00:a21:b0:64c:c836:662d with SMTP id p33-20020a056a000a2100b0064cc836662dmr675567pfh.20.1684346130741;
        Wed, 17 May 2023 10:55:30 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id b23-20020aa78117000000b0063d670ad850sm6044373pfi.92.2023.05.17.10.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:55:30 -0700 (PDT)
From: Aditi Ghag <aditi.ghag@isovalent.com>
To: bpf@vger.kernel.org
Cc: kafai@fb.com,
	sdf@google.com,
	aditi.ghag@isovalent.com
Subject: [PATCH v8 bpf-next 02/10] udp: seq_file: Helper function to match socket attributes
Date: Wed, 17 May 2023 17:55:25 +0000
Message-Id: <20230517175525.528000-1-aditi.ghag@isovalent.com>
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


