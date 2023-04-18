Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD3F6E6828
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 17:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjDRPcG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 11:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjDRPcD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 11:32:03 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BBCE6A
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 08:32:01 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n17so12006651pln.8
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 08:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681831921; x=1684423921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5xBGSQzsY3CbPFJoYnSBy33rsY0QyNtxY6oZiS3oGM=;
        b=XUKiSs/nbhQFXc+Ow29S7Ep76DFld8+Vk/c23lbZu9P4ThWX9ILWOmScx/fSNKO5Km
         ZIT2vwsa/lWKg2b9/MbZ4aZwg11XFQKdBUiwBaxtov8xEPNn4hV7MgaJ9lgGf3acxiff
         bXbPMbrdnELOOT33ltcFaRBbXeTkG5cVEuMffKuW6hv12+3UN1+KfUj1hwJVI152nxmJ
         wOqJSX9PaLcbsyXw2uyFZwpunon/HhqjXhFQPogHRyTeQQvS/fUk37Mqr+FV1UPB3BZ4
         PAAhUOmcJEfuiDps6zZ0R5CA5iV5raQNJmPAvsAjJsd9R6jeJ80ZW4t5W8bBF2nwSGUW
         WPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681831921; x=1684423921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5xBGSQzsY3CbPFJoYnSBy33rsY0QyNtxY6oZiS3oGM=;
        b=l/6r8is1NTORWVcyci4qSjA5pNsV5GP+5qMUwuAO0V8XPCCV3One4taYO0t2ckBAGY
         JSZYSq5oKjqP7qTC8+k0oQiXfmepqLu4AYShlnrkjd7EPPtmIDXb/OOkvh4M7xpekYdj
         XKFBuT+qGTwp+Xo7uWWeAzPJ0H06brg9B2WdQ/nwLLsKEqSJsHIEZO+HAFbn4k1wfsWV
         JO9DAH95por315Z10XjqgfKMjm2OOpeK+mFKr+idZvt4hxUcoLygNbZ2OV41i9J3g+dn
         TZWoA7Yps5/gsWXOnFNI8Zl+bH9vGPISiTZzJWhdb+puu77WkeMIlRsrUTjZvsHuM4iR
         Lgbg==
X-Gm-Message-State: AAQBX9ce53m5WjT2ya48q4gIH619BOusnkcQvcNJGE3AaSzjBEeYBCwI
        0wllin07NQW7d2NRSHDij2IzU2d0wD/5Idi9ALM=
X-Google-Smtp-Source: AKy350ZSDaYg465mQO56H+S5nmpTdJoIw5JTNi0BQwRT65oh69WYH4PU2Qa5DpKblv689RNexOh1yw==
X-Received: by 2002:a05:6a20:8412:b0:ee:58da:4e4c with SMTP id c18-20020a056a20841200b000ee58da4e4cmr325093pzd.1.1681831921109;
        Tue, 18 Apr 2023 08:32:01 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id ba4-20020a170902720400b001a647709864sm9769630plb.155.2023.04.18.08.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 08:32:00 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        aditi.ghag@isovalent.com
Subject: [PATCH 3/7] udp: seq_file: Helper function to match socket attributes
Date:   Tue, 18 Apr 2023 15:31:44 +0000
Message-Id: <20230418153148.2231644-4-aditi.ghag@isovalent.com>
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

This is a preparatory commit to refactor code that matches socket
attributes in iterators to a helper function, and use it in the
proc fs iterator.

Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
---
 net/ipv4/udp.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 3c9eeee28678..8689ed171776 100644
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
@@ -3010,10 +3020,7 @@ static struct sock *udp_get_first(struct seq_file *seq, int start)
 
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
@@ -3034,9 +3041,7 @@ static struct sock *udp_get_next(struct seq_file *seq, struct sock *sk)
 
 	do {
 		sk = sk_next(sk);
-	} while (sk && (!net_eq(sock_net(sk), net) ||
-			(afinfo->family != AF_UNSPEC &&
-			 sk->sk_family != afinfo->family)));
+	} while (sk && !seq_sk_match(seq, sk));
 
 	if (!sk) {
 		udptable = udp_get_table_afinfo(afinfo, net);
@@ -3196,6 +3201,21 @@ static const struct seq_operations bpf_iter_udp_seq_ops = {
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

