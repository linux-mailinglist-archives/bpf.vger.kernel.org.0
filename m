Return-Path: <bpf+bounces-18569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B58781C1E5
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 00:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0885428A7BD
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 23:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130A679955;
	Thu, 21 Dec 2023 23:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWLVZvK2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEA679941;
	Thu, 21 Dec 2023 23:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d3eae5c1d7so9513675ad.2;
        Thu, 21 Dec 2023 15:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703201011; x=1703805811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYMrRNT3ZdfPIRMKKtuwipMRSvkNVNrUffEPckkXHwY=;
        b=hWLVZvK2ButB838RFi0PyTN+KlxaTfq3OrhxkEQ3c2MyqdbgAM/GguunGXqDpI/tdY
         uF5z51kEqpgXRgMAlgaTYLnRyTZMEMPpCBEdJrGESxRRjZupTPOyzJzWBGXUgrJvZRlr
         s9QyL4CYOCyILRzUeOgk9vaXORrIGJpZjp5uCYmhtNNl9jWFYoZl7h3DGXSgQLEDggzK
         YKLWlPMxYVomrIOCgSJR9oW6dJshmUZG7PdkogtItwEh2DVVUqDy7McLRKh8m/mxTeGa
         CyNAHeC6yQOlWWkpa4yzIJvJ49rH47IpRQ7JVek+LjW28z9xt2tXmzjAtGLJ6AxcLo9E
         RiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703201011; x=1703805811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYMrRNT3ZdfPIRMKKtuwipMRSvkNVNrUffEPckkXHwY=;
        b=HAMdokSIoHWx5dTpzRhW6kVBw1VGUiu0LPzhRa9Fctwd1l2bZDV0/WT0jqDhg5pT4L
         ar2sqFR6I1Mh3hKrRmiY2blaudUlQb/EXwssSIG4Zdw3Rx4+L5uMxLBZgnyg3Vi/S8Yk
         dMcYf01KNWjBsW2kKIouhkYRoFEG9M6XPPv+deBcMrLJUyL4bWHNaelf5iuWQ6JCJopB
         Cu1l4UX228v4pUsMpQTBjT6NyANBRoq/3u2tKuJ9AdESpNuQu12xPJvMDlXphzKQD4ST
         tC6dXIc2TshRAslVAeJm2FuxVNeHI4J34WiTvWxvqhurozLY91cRDvWivf2tAtmXqGkn
         FdKg==
X-Gm-Message-State: AOJu0Yw6umT5g7xg6N4pfRnypizvd/V2zjMnfV4Xtbt/VbQNLs+SxBI4
	OJo9RDVM/0/UXajWaGigxB1MUB7mCZo=
X-Google-Smtp-Source: AGHT+IHvrzHlxxO27n2Ek17hhVD/oGI8djQfznT41AbNXW84b1KJw2qiboCZZmUdPELRcwZUb+RqKg==
X-Received: by 2002:a17:902:c94d:b0:1d0:c7e0:c826 with SMTP id i13-20020a170902c94d00b001d0c7e0c826mr353888pla.17.1703201011564;
        Thu, 21 Dec 2023 15:23:31 -0800 (PST)
Received: from john.rmac-pubwifi.localzone (fw.royalmoore.com. [72.21.11.210])
        by smtp.gmail.com with ESMTPSA id g15-20020a1709029f8f00b001d3e33a73d5sm2139641plq.279.2023.12.21.15.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 15:23:30 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: jakub@cloudflare.com,
	rivendell7@gmail.com,
	kuniyu@amazon.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf 1/5] bpf: sockmap, fix proto update hook to avoid dup calls
Date: Thu, 21 Dec 2023 15:23:23 -0800
Message-Id: <20231221232327.43678-2-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231221232327.43678-1-john.fastabend@gmail.com>
References: <20231221232327.43678-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When sockets are added to a sockmap or sockhash we allocate and init a
psock. Then update the proto ops with sock_map_init_proto the flow is

  sock_hash_update_common
    sock_map_link
      psock = sock_map_psock_get_checked() <-returns existing psock
      sock_map_init_proto(sk, psock)       <- updates sk_proto

If the socket is already in a map this results in the sock_map_init_proto
being called multiple times on the same socket. We do this because when
a socket is added to multiple maps this might result in a new set of BPF
programs being attached to the socket requiring an updated ops struct.

This creates a rule where it must be safe to call psock_update_sk_prot
multiple times. When we added a fix for UAF through unix sockets in patch
4dd9a38a753fc we broke this rule by adding a sock_hold in that path
to ensure the sock is not released. The result is if a af_unix stream sock
is placed in multiple maps it results in a memory leak because we call
sock_hold multiple times with only a single sock_put on it.

Fixes: 4dd9a38a753fc ("bpf: sockmap, fix proto update hook to avoid dup calls")
Rebported-by: Xingwei Lee <xrivendell7@gmail.com>
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 net/unix/unix_bpf.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
index 7ea7c3a0d0d0..bd84785bf8d6 100644
--- a/net/unix/unix_bpf.c
+++ b/net/unix/unix_bpf.c
@@ -161,15 +161,30 @@ int unix_stream_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool r
 {
 	struct sock *sk_pair;
 
+	/* Restore does not decrement the sk_pair reference yet because we must
+	 * keep the a reference to the socket until after an RCU grace period
+	 * and any pending sends have completed.
+	 */
 	if (restore) {
 		sk->sk_write_space = psock->saved_write_space;
 		sock_replace_proto(sk, psock->sk_proto);
 		return 0;
 	}
 
-	sk_pair = unix_peer(sk);
-	sock_hold(sk_pair);
-	psock->sk_pair = sk_pair;
+	/* psock_update_sk_prot can be called multiple times if psock is
+	 * added to multiple maps and/or slots in the same map. There is
+	 * also an edge case where replacing a psock with itself can trigger
+	 * an extra psock_update_sk_prot during the insert process. So it
+	 * must be safe to do multiple calls. Here we need to ensure we don't
+	 * increment the refcnt through sock_hold many times. There will only
+	 * be a single matching destroy operation.
+	 */
+	if (!psock->sk_pair) {
+		sk_pair = unix_peer(sk);
+		sock_hold(sk_pair);
+		psock->sk_pair = sk_pair;
+	}
+
 	unix_stream_bpf_check_needs_rebuild(psock->sk_proto);
 	sock_replace_proto(sk, &unix_stream_bpf_prot);
 	return 0;
-- 
2.33.0


