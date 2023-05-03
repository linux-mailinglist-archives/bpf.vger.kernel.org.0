Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665E56F6193
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 00:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjECWyD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 18:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjECWyB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 18:54:01 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9154681
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 15:54:00 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1aaf21bb427so31971345ad.1
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 15:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1683154440; x=1685746440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwmHpgDmVlTo8Kp5M3jmfH1KC96jBeC1s7SoCPSCjuo=;
        b=Vpkcn3CEr0ix9AQq9OgHMitCBRXqBkzkEZsWewHXp/lAkn2P36o6kAm1wc4LNJ9oJm
         bK7DjsVcEHAc/vJz4FLZO3ufn49oaMcsoNDjYETUZmMTy4tkXMYUNNWNWwmEP2tXh8N+
         VEx6PsDgeJBud/KkcBRlqHXMclVuPvFIqJ5sU/6CMcYIfvu6tiVkF53eQimK9MKUBedk
         zPrPcZbw0qsGxzCg3EZwCKtatp+T/Bb5g7Ss8mZb6eFp566a9JZdaRW05JnSnQtHesdK
         PSqu+JPNPh4BgWx/saNC9F9pGR/sTM+n5UkRFvbM/lNOwJSvgTYXfR6YemKClGkyEeLn
         mZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683154440; x=1685746440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwmHpgDmVlTo8Kp5M3jmfH1KC96jBeC1s7SoCPSCjuo=;
        b=HQx83LRAGi6CJ4/3Y4dfNKYvlcGe/MnbQX9Fq8akE8jJgZDwyTwotPZ/1aJUP9L6HH
         /a8oSKAGGkivh6rZ1UTT2xPhd8vtSZOWUBtldGgfPPywl/kR+cba5LEMCOi0tG6azOSQ
         p9j0vw/dJyDARor1k05Bl9jLzzxhKeFq6SJseuDjCUV6+4sGi2GVk1pHS3SFNaBhXP+/
         lMEhlfrEvnzEta8tQLf80R/mbro5UM/BBDJDBVQU2YbyXEeDOFG9iLJN4yPe/wF4u9g6
         vZatxs0N/qLSjEqTWVkYb+GuTgf2UgQnXu2fRwN7SzKmoF/HZ+o2ErS7H7ryjajC7QvE
         JAjw==
X-Gm-Message-State: AC+VfDyKmGx1EHNGWmrAJw/+5FlrdhTfXRavfREpGw8UJ5soC9nhE9/a
        pTuVZimB6Vsb3uzlUfiSXgR3dZET9phb70+u+dw=
X-Google-Smtp-Source: ACHHUZ5tXldcCUYnIOYBVHSgD+ErgsvSgyLkDQUcurhJtR0y9/WXI20Vzevhqa7FQ3sHM3Uax8aeeg==
X-Received: by 2002:a17:902:b607:b0:1ab:12a:bd2e with SMTP id b7-20020a170902b60700b001ab012abd2emr1577774pls.37.1683154439668;
        Wed, 03 May 2023 15:53:59 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709028a8200b001a641e4738asm2200443plo.1.2023.05.03.15.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 15:53:59 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, aditi.ghag@isovalent.com
Subject: [PATCH v7 bpf-next 02/10] udp: seq_file: Helper function to match socket attributes
Date:   Wed,  3 May 2023 22:53:43 +0000
Message-Id: <20230503225351.3700208-3-aditi.ghag@isovalent.com>
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

