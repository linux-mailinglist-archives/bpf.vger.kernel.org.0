Return-Path: <bpf+bounces-42261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A5B9A1760
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 02:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95E928117D
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 00:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A931E493;
	Thu, 17 Oct 2024 00:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="d1Gjzb85"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BC91DA5A
	for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 00:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729126676; cv=none; b=deoTK2ybT28kylSzFWi5jR6ik2LR7qTs/pzWwamsHmtlGsb/K/9KVihju+cGBuCrdf5+lWdmvn9VkMyNg0z5HsK2/FHF8SthPZx8xNvCPusrGjBVRiFe/iuyekm63a+CXHBFukmxpQTr/Wt7E53he1zBFvEtbcW6rsxhe9ZNcUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729126676; c=relaxed/simple;
	bh=er7gn+9qtnqKtk/zsO18B6Kbt/ktvMPPY9dwl/7TEsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UrJGzJN/JmyCdDNYA76RB+vh2TCKunn46ZJcop/sl3QJ8b9g82x1g+ZIeATsQEdkbI+NNHarcEFov8OCddoEG5XYJ07Z50ehFdV6/dxcjXskuC81tUXB4JWINy16Kq47VxDpZgOXOcR5HpMRPRBtghBcJRXe8kisWv87DsZkugM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=d1Gjzb85; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b1418058bbso25007385a.3
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 17:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729126672; x=1729731472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NtcrI2eXbw87V4TzBkXNzP43wWWtbiCvAle8aiM7Xo=;
        b=d1Gjzb85GrSUdLctI6+KO9Tc5jsr9nEXF7R8KnF/ijY3TynsxpQ0yfsAUU7pk9kvhG
         RRVEa10RODPV57MPUCVaCVko+8WbVVgiYOm5MkcLhcYvnPjIQoqegHue8C4voZHaEpHy
         Ir9zYX9naX8w8crD4FG2QkF3RtPwgwHWk1s6RnIo4XYNvFMEbEvpWd5ljUZw5UOy+crq
         TnQKzETz279hzeCsjHFTy/6Dfb3CO4OYqSgyVcZ7U5iGiHJcMD0iha25XX6RfdCAWoXO
         AhM+do+Iqy0jOS//u+fGm38MStV0ADsrdMe/EU+lKJwzf4eSm0q5T/k1Sn5JP0/8Cm8T
         ik/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729126672; x=1729731472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NtcrI2eXbw87V4TzBkXNzP43wWWtbiCvAle8aiM7Xo=;
        b=hY5TmvYu478ZWixPfpfS3lZD3dsg1Pk224HLFRUQHfRnNtgi/CMhYpLnjvry14FzjX
         pkZrQND9sxo3LquPdI2Ympd0MUCjTfBXbZldHii0Jo8nCmXkOW3U083rGGUX6pSSkf9f
         UGiQWBywbmCk4qh8RD7kXHf8wBOI7rgf0wDv2UUi7dbJk6xGt3Ap2mxyBEDkE1jfNLdb
         1tkmlgMCbGqEBx6XGjHL1Up5VFNfQbd+8yvYVBbjxtF1NR6DfpnOyBAseW1nNPYAtJcP
         3+zy89LAr7LIn/J6OpaZkq2nCuNEs2oyx/bSuKr1msH36ynAGnsON0dLxV92TmrucOax
         Boag==
X-Gm-Message-State: AOJu0YzN/R+kJRn1nrnWe3hA4tEzgH665ljrHs4IKMog5I0BIsI4OrYF
	+YYqX8j38g03m6sfo7N40HyW59zwQZN3EjIzM3TLsnhIhgn3nhR8myaanqbecCYBBrLAyvvp6az
	B
X-Google-Smtp-Source: AGHT+IE+cHydkaERdSD+wRFQhHGrAS7bLwqT2iHcE1mxpJnlcyNLvPzueWZ8aAMjYSwm9joVel+kjw==
X-Received: by 2002:a05:620a:470d:b0:7a9:a1f4:d4e1 with SMTP id af79cd13be357-7b120fcfe30mr2263816385a.39.1729126671812;
        Wed, 16 Oct 2024 17:57:51 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b13617a23esm242466685a.60.2024.10.16.17.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 17:57:50 -0700 (PDT)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: john.fastabend@gmail.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	cong.wang@bytedance.com,
	zijianzhang@bytedance.com
Subject: [PATCH bpf 2/2] tcp_bpf: add sk_rmem_alloc related logic for ingress redirection
Date: Thu, 17 Oct 2024 00:57:42 +0000
Message-Id: <20241017005742.3374075-3-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241017005742.3374075-1-zijianzhang@bytedance.com>
References: <20241017005742.3374075-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

Although we sk_rmem_schedule and add sk_msg to the ingress_msg of sk_redir
in bpf_tcp_ingress, we do not update sk_rmem_alloc. As a result, except
for the global memory limit, the rmem of sk_redir is nearly unlimited.

Thus, add sk_rmem_alloc related logic to limit the recv buffer.

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
---
 include/linux/skmsg.h | 11 ++++++++---
 net/core/skmsg.c      |  6 +++++-
 net/ipv4/tcp_bpf.c    |  4 +++-
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index d9b03e0746e7..2cbe0c22a32f 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -317,17 +317,22 @@ static inline void sock_drop(struct sock *sk, struct sk_buff *skb)
 	kfree_skb(skb);
 }
 
-static inline void sk_psock_queue_msg(struct sk_psock *psock,
+static inline bool sk_psock_queue_msg(struct sk_psock *psock,
 				      struct sk_msg *msg)
 {
+	bool ret;
+
 	spin_lock_bh(&psock->ingress_lock);
-	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
+	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
 		list_add_tail(&msg->list, &psock->ingress_msg);
-	else {
+		ret = true;
+	} else {
 		sk_msg_free(psock->sk, msg);
 		kfree(msg);
+		ret = false;
 	}
 	spin_unlock_bh(&psock->ingress_lock);
+	return ret;
 }
 
 static inline struct sk_msg *sk_psock_dequeue_msg(struct sk_psock *psock)
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index b1dcbd3be89e..110ee0abcfe0 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -445,8 +445,10 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 			if (likely(!peek)) {
 				sge->offset += copy;
 				sge->length -= copy;
-				if (!msg_rx->skb)
+				if (!msg_rx->skb) {
 					sk_mem_uncharge(sk, copy);
+					atomic_sub(copy, &sk->sk_rmem_alloc);
+				}
 				msg_rx->sg.size -= copy;
 
 				if (!sge->length) {
@@ -772,6 +774,8 @@ static void __sk_psock_purge_ingress_msg(struct sk_psock *psock)
 
 	list_for_each_entry_safe(msg, tmp, &psock->ingress_msg, list) {
 		list_del(&msg->list);
+		if (!msg->skb)
+			atomic_sub(msg->sg.size, &psock->sk->sk_rmem_alloc);
 		sk_msg_free(psock->sk, msg);
 		kfree(msg);
 	}
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 48c412744f77..39155bec746f 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -56,6 +56,7 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
 		}
 
 		sk_mem_charge(sk, size);
+		atomic_add(size, &sk->sk_rmem_alloc);
 		sk_msg_xfer(tmp, msg, i, size);
 		copied += size;
 		if (sge->length)
@@ -74,7 +75,8 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
 
 	if (!ret) {
 		msg->sg.start = i;
-		sk_psock_queue_msg(psock, tmp);
+		if (!sk_psock_queue_msg(psock, tmp))
+			atomic_sub(copied, &sk->sk_rmem_alloc);
 		sk_psock_data_ready(sk, psock);
 	} else {
 		sk_msg_free(sk, tmp);
-- 
2.20.1


