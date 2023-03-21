Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF486C3970
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 19:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjCUSqe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 14:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjCUSqG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 14:46:06 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027B25616B
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 11:45:53 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j13so16411578pjd.1
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 11:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679424352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hw/jbz9v/fFialDFe5P2QsHF8bQDPNcaDJeRDmqQ8D8=;
        b=aQWjMii5blnv7WBgvBVlrrXprMrbchCrlYfgHJBfbzVYEE5QPY/BqT6Q2Aj884ztMK
         xidihVR32QHczjwRGWws1EHNPZVjODMYY0k/QBcvn3QvKmybGR9+KoG1I+FZhaSEtssH
         byx8KN0SUWS0RyRZr5wHxUOCjV+qIxwlHGplEmH3NZ+udUPbozu6C4Ne++d6mFuLGAW3
         kONyn35d6+O87/GNuILOYJvY4pNddDBKMfdBi+XFKGqGHo4uj7Jrmitop/uoVwg/bXFQ
         qW5T7kOigjv4O9e45sxX3ADm0QjItak5MBH98hEVW4ueFRgWBxMJPGZONMTRWjfM279W
         hFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679424352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hw/jbz9v/fFialDFe5P2QsHF8bQDPNcaDJeRDmqQ8D8=;
        b=r28QhFFaDzmY4MEnMaoZXylp0GLkK+VX2LFES5fKqmefj9YpkoL17TBHYcz3K7PVHm
         mkm/6v6QwNNkvlpC0iRyoZpeh9izHzY3I9FSDF994wN5GEifabpVA7BMkoGO7tCU9qLx
         s5OB8Iu8kF5OamF9eFseYmkdsDtiNi9K4ZC/MpY4+/72hOuzP+yOzxrl2vhfTFhZZ30u
         /qd+OzRwfsLKGGzMETi090HSzVfuntUjSMFLXwjFY/U8H626Kv8R1wGTNgVEfvy4gKPg
         cEw4dayK5BbWO9LLXoe/DV3UEcqHtcqlsYdHjEe3DlAp9ok4znfhlHeb+d9N6gmFC5F/
         tf5A==
X-Gm-Message-State: AO0yUKUD8MpjfAlFuQUUX25HwUGODmLwlsDTPpt2ngF33274xxDtS6yK
        RM0PJRqrAyfiqM5cXJxLaQMqX65vZFcp0Uvgeio=
X-Google-Smtp-Source: AK7set/2SLtauPZJPbJk8fzzaZqkMJNvP4L61DxqudxrAovKfISQ+fHzZsxDh/qKrjDE2EH/qP5ekg==
X-Received: by 2002:a17:902:ecd1:b0:1a1:e237:5f0 with SMTP id a17-20020a170902ecd100b001a1e23705f0mr64193plh.58.1679424351732;
        Tue, 21 Mar 2023 11:45:51 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c15500b0019cf747253csm9095878plj.87.2023.03.21.11.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 11:45:51 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        aditi.ghag@isovalent.com
Subject: [PATCH v3 bpf-next 4/5] [RFC] udp: Fix destroying UDP listening sockets
Date:   Tue, 21 Mar 2023 18:45:40 +0000
Message-Id: <20230321184541.1857363-5-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321184541.1857363-1-aditi.ghag@isovalent.com>
References: <20230321184541.1857363-1-aditi.ghag@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Previously, UDP listening sockets that bind'ed to a port
weren't getting properly destroyed via udp_abort.
Specifically, the sockets were left in the UDP hash table with
unset source port.
Fix the issue by unconditionally unhashing and resetting source
port for sockets that are getting destroyed. This would mean
that in case of sockets listening on wildcarded address and
on a specific address with a common port, users would have to
explicitly select the socket(s) they intend to destroy.

Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
---
 net/ipv4/udp.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 02d357713838..a495ac88fcee 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1965,6 +1965,25 @@ int udp_pre_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 }
 EXPORT_SYMBOL(udp_pre_connect);
 
+int __udp_disconnect_with_abort(struct sock *sk)
+{
+	struct inet_sock *inet = inet_sk(sk);
+
+	sk->sk_state = TCP_CLOSE;
+	inet->inet_daddr = 0;
+	inet->inet_dport = 0;
+	sock_rps_reset_rxhash(sk);
+	sk->sk_bound_dev_if = 0;
+	inet_reset_saddr(sk);
+	inet->inet_sport = 0;
+	sk_dst_reset(sk);
+	/* (TBD) In case of sockets listening on wildcard and specific address
+	 * with a common port, socket will be removed from {hash, hash2} table.
+	 */
+	sk->sk_prot->unhash(sk);
+	return 0;
+}
+
 int __udp_disconnect(struct sock *sk, int flags)
 {
 	struct inet_sock *inet = inet_sk(sk);
@@ -2937,7 +2956,7 @@ int udp_abort(struct sock *sk, int err)
 
 	sk->sk_err = err;
 	sk_error_report(sk);
-	__udp_disconnect(sk, 0);
+	__udp_disconnect_with_abort(sk);
 
 out:
 	if (!has_current_bpf_ctx())
-- 
2.34.1

