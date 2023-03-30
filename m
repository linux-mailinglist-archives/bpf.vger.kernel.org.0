Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEE76D0949
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 17:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjC3PTo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 11:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjC3PTo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 11:19:44 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3D8D326
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 08:18:33 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso19944776pjb.3
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 08:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680189499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdtJYr2bcULfCg+reBAuKmer6q4tZwo2JWP9J/6JBzY=;
        b=OddMGB5L56fYKW3o/65LL9YmzgW2XQl2leiGZMSN5Wc0Z9IccYkUticXIWY9Vsx9Kl
         PEj7FUWYOt7mdt/c+lX7BfcB2st7kcHO0nNlUL8NdNJ626BJsfZoeaTNb0L9NN0MmBS/
         W/I+Nya2WYmBjwVvjMiFkoMNVhUAHLHcPSIBSBS+0WU1NezU6VmrjwFVOd1yd51SGX0p
         iqDiQ1Q6ARITWOo8VyTtpEDeCUa4uAys6UdtOBlT67B1RPvki/irVQGi7Gh9FRnZi9mF
         WwD4s964yU3GFdzXYsiC3MAPjWDP11DQCOqWaphDw1v3abrln58yBh0Ar6qBYvvJIeJQ
         Y+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680189499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdtJYr2bcULfCg+reBAuKmer6q4tZwo2JWP9J/6JBzY=;
        b=kAUsCdRQpPNZvjynocfDDe5tHX+XerqrBwC6Nlk6VFK9IGpwoEVQSEhZJgRLeWm9+M
         ik9LyPXstwKBfZ/BqW2zvtwiM15cV4RMoxIoHE2rbXP2nKIDgP7ULaYYqcsUhncEK7+E
         kQoo1WtevTmpqcgbRW+8GPu0UiA9nEluP2/lG0P4eW2YDHl4LPpPyo3FRU4M9KWK4YzM
         Wld82TvlQccHLz/uiM7nmEjmY63WufOKmdfJXirY43FVIVO6sgm2xf3uKR9GtOZUfLay
         oA9S44XlPht2GZC8W22niimNOz5trPKHOVAaVctYmIV6SuKiHJAQrytlyZwDXwgpCv4I
         ferQ==
X-Gm-Message-State: AAQBX9cqyQB7v+ku55PWuFkJXZ4bD/fJnbEDYQ/8d3KAqf4oKeISVX80
        1/D4T6HgdSZFUctbRldmbQ+v7gfGnQH+pzEqw1k=
X-Google-Smtp-Source: AKy350b5i7hlIpsbeewqoYd+IegYziAKqem7vl3zaxjnuYBar5+z1UyItIf7m+S0RNfVqx10wXbGtw==
X-Received: by 2002:a17:903:7cf:b0:1a1:c792:8e73 with SMTP id ko15-20020a17090307cf00b001a1c7928e73mr19973110plb.60.1680189499371;
        Thu, 30 Mar 2023 08:18:19 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id f17-20020a63de11000000b004fc1d91e695sm23401177pgg.79.2023.03.30.08.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:18:18 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        aditi.ghag@isovalent.com
Subject: [PATCH v5 bpf-next 3/7] udp: seq_file: Helper function to match socket attributes
Date:   Thu, 30 Mar 2023 15:17:54 +0000
Message-Id: <20230330151758.531170-4-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330151758.531170-1-aditi.ghag@isovalent.com>
References: <20230330151758.531170-1-aditi.ghag@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 net/ipv4/udp.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c574c8c17ec9..cead4acb64c6 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2983,6 +2983,8 @@ EXPORT_SYMBOL(udp_prot);
 /* ------------------------------------------------------------------------ */
 #ifdef CONFIG_PROC_FS
 
+static inline bool seq_sk_match(struct seq_file *seq, const struct sock *sk);
+
 static struct udp_table *udp_get_table_afinfo(struct udp_seq_afinfo *afinfo,
 					      struct net *net)
 {
@@ -3010,10 +3012,7 @@ static struct sock *udp_get_first(struct seq_file *seq, int start)
 
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
@@ -3034,9 +3033,7 @@ static struct sock *udp_get_next(struct seq_file *seq, struct sock *sk)
 
 	do {
 		sk = sk_next(sk);
-	} while (sk && (!net_eq(sock_net(sk), net) ||
-			(afinfo->family != AF_UNSPEC &&
-			 sk->sk_family != afinfo->family)));
+	} while (sk && !seq_sk_match(seq, sk));
 
 	if (!sk) {
 		udptable = udp_get_table_afinfo(afinfo, net);
@@ -3143,6 +3140,17 @@ struct bpf_iter__udp {
 	int bucket __aligned(8);
 };
 
+static unsigned short seq_file_family(const struct seq_file *seq);
+
+static inline bool seq_sk_match(struct seq_file *seq, const struct sock *sk)
+{
+	unsigned short family = seq_file_family(seq);
+
+	/* AF_UNSPEC is used as a match all */
+	return ((family == AF_UNSPEC || family == sk->sk_family) &&
+		net_eq(sock_net(sk), seq_file_net(seq)));
+}
+
 static int udp_prog_seq_show(struct bpf_prog *prog, struct bpf_iter_meta *meta,
 			     struct udp_sock *udp_sk, uid_t uid, int bucket)
 {
@@ -3194,6 +3202,19 @@ static const struct seq_operations bpf_iter_udp_seq_ops = {
 	.stop		= bpf_iter_udp_seq_stop,
 	.show		= bpf_iter_udp_seq_show,
 };
+
+static unsigned short seq_file_family(const struct seq_file *seq)
+{
+	const struct udp_seq_afinfo *afinfo;
+
+	/* BPF iterator: bpf programs to filter sockets. */
+	if (seq->op == &bpf_iter_udp_seq_ops)
+		return AF_UNSPEC;
+
+	/* Proc fs iterator */
+	afinfo = pde_data(file_inode(seq->file));
+	return afinfo->family;
+}
 #endif
 
 const struct seq_operations udp_seq_ops = {
-- 
2.34.1

