Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 986A0107E1E
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2019 12:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfKWLIA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 23 Nov 2019 06:08:00 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39968 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfKWLIA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Nov 2019 06:08:00 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2so10290014ljg.7
        for <bpf@vger.kernel.org>; Sat, 23 Nov 2019 03:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/S4Voe4xMw9DysKVRvMiYj0/jWImWXMpbGJqyhXqcPA=;
        b=IdN9oTlvu0aRzQtzP+WB4pv+jqX9HhG8xldhpZYCcUnXF7okU7rMYjtps69w1wli0b
         wZHbe6TjDCp9jg66w1aKJaes48ksx7rAo5eX/Z2dvQ6/W8nrjHywgA0XqYl/aduM8tIF
         9R3XH1Mkga65DRctF3+glJU/CCvGeca0dbN7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/S4Voe4xMw9DysKVRvMiYj0/jWImWXMpbGJqyhXqcPA=;
        b=h8gxub0fSRzcJf1vpyHT5CZv+9zuVVy1vRGz7Go69rkidmPdeUGibIWfBP9F1Dc5Gr
         Kq9XXqHly31NIV8KjTzLk1FHg5Crr6G+GA83TVKCUlrXiOF5PQp/3bEQn5No5kuA3H1H
         c/RIFePe0ySAvusgYMEe0jaHTpMWNC7aUwvrF+/FMYanCinvMtT6gj1gtYdxtKz7O+ps
         DzsrjUNe3Zky27pubNoHGb8APnk0CFDDB1Qdp3p5K3mB9eoQLSzQGg91efjJfxcG3sCN
         RSH/8n7MwgoSVUzPa7nGo+2KaFfskgkZdFxJM7XUARHeuiAiXeEkeWcnktan0vw57wg4
         tTxA==
X-Gm-Message-State: APjAAAU2sxJF50Bf71CvQwloCYkS/HeIpyxThP5JhXOnoETvg8EYxK0s
        Z+Q/DawneHO2+LeGuQuRW8uCXgpcbtFH3A==
X-Google-Smtp-Source: APXvYqxLnIo1klSQNuij7g2YCx86r59CNZPuHysdztPRoMr9u4gc7DjI6rkAbCkNrFhDMsGOtullBQ==
X-Received: by 2002:a2e:3a12:: with SMTP id h18mr8966702lja.217.1574507277832;
        Sat, 23 Nov 2019 03:07:57 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id x19sm617059ljh.14.2019.11.23.03.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 03:07:57 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next 3/8] bpf, sockmap: Allow inserting listening TCP sockets into SOCKMAP
Date:   Sat, 23 Nov 2019 12:07:46 +0100
Message-Id: <20191123110751.6729-4-jakub@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191123110751.6729-1-jakub@cloudflare.com>
References: <20191123110751.6729-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In order for SOCKMAP type to become a generic collection for storing TCP
sockets we need to loosen the checks in update callback.

Currently SOCKMAP requires the TCP socket to be in established state, which
prevents us from using it to keep references to listening sockets.

Change the update pre-checks so that it is sufficient for socket to be in a
hash table, i.e. have a local address/port assigned, to be inserted. Return
-EINVAL if the condition is not met to be consistent with
REUSEPORT_SOCKARRY map type.

This creates a possibility of pointing one of the BPF redirect helpers that
splice two SOCKMAP sockets on ingress or egress at a listening socket,
which doesn't make sense. Introduce appropriate checks in the helpers so
that only established TCP sockets can be a target for redirects.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/sock_map.c                     | 28 ++++++++++++++++++-------
 tools/testing/selftests/bpf/test_maps.c |  6 +-----
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 9f572d56e81a..49744b344137 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -439,11 +439,14 @@ static int sock_map_update_elem(struct bpf_map *map, void *key,
 		ret = -EINVAL;
 		goto out;
 	}
-	if (!sock_map_sk_is_suitable(sk) ||
-	    sk->sk_state != TCP_ESTABLISHED) {
+	if (!sock_map_sk_is_suitable(sk)) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
+	if (!sk_hashed(sk)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	sock_map_sk_acquire(sk);
 	ret = sock_map_update_common(map, idx, sk, flags);
@@ -480,13 +483,17 @@ BPF_CALL_4(bpf_sk_redirect_map, struct sk_buff *, skb,
 	   struct bpf_map *, map, u32, key, u64, flags)
 {
 	struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
+	struct sock *sk;
 
 	if (unlikely(flags & ~(BPF_F_INGRESS)))
 		return SK_DROP;
-	tcb->bpf.flags = flags;
-	tcb->bpf.sk_redir = __sock_map_lookup_elem(map, key);
-	if (!tcb->bpf.sk_redir)
+
+	sk = __sock_map_lookup_elem(map, key);
+	if (!sk || sk->sk_state != TCP_ESTABLISHED)
 		return SK_DROP;
+
+	tcb->bpf.flags = flags;
+	tcb->bpf.sk_redir = sk;
 	return SK_PASS;
 }
 
@@ -503,12 +510,17 @@ const struct bpf_func_proto bpf_sk_redirect_map_proto = {
 BPF_CALL_4(bpf_msg_redirect_map, struct sk_msg *, msg,
 	   struct bpf_map *, map, u32, key, u64, flags)
 {
+	struct sock *sk;
+
 	if (unlikely(flags & ~(BPF_F_INGRESS)))
 		return SK_DROP;
-	msg->flags = flags;
-	msg->sk_redir = __sock_map_lookup_elem(map, key);
-	if (!msg->sk_redir)
+
+	sk = __sock_map_lookup_elem(map, key);
+	if (!sk || sk->sk_state != TCP_ESTABLISHED)
 		return SK_DROP;
+
+	msg->flags = flags;
+	msg->sk_redir = sk;
 	return SK_PASS;
 }
 
diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index 02eae1e864c2..c6766b2cff85 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -756,11 +756,7 @@ static void test_sockmap(unsigned int tasks, void *data)
 	/* Test update without programs */
 	for (i = 0; i < 6; i++) {
 		err = bpf_map_update_elem(fd, &i, &sfd[i], BPF_ANY);
-		if (i < 2 && !err) {
-			printf("Allowed update sockmap '%i:%i' not in ESTABLISHED\n",
-			       i, sfd[i]);
-			goto out_sockmap;
-		} else if (i >= 2 && err) {
+		if (err) {
 			printf("Failed noprog update sockmap '%i:%i'\n",
 			       i, sfd[i]);
 			goto out_sockmap;
-- 
2.20.1

