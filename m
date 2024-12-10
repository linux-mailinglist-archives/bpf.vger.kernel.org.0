Return-Path: <bpf+bounces-46445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BB29EA433
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 02:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90563288E23
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 01:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4CD433C0;
	Tue, 10 Dec 2024 01:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Zm49/vCW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E146A7083E
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 01:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733793650; cv=none; b=KKrOOFidKMPWUzvSXbom0GD2Lt3ibMtyoLd2lpBA35aV2bDLvYJZT29KgFHR0jtzC6YTAl0nWsGo7JU/Sw7xOf/+pv3LmSIsyv8c3OxuSTGPQ8cply5Zaz4xaKJIXQ2y/sZqxjxf2WgezyUq+nFN7xG54ok/+njOefaCc5XbpWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733793650; c=relaxed/simple;
	bh=aloKRih2BG1pQzE3xxC0ytS5ZZwBsQB+Dt2eriW1xfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VzDWJT1tf1TVi3PYeHGSTZQsJJj10tgk3wABgQBUM14G3I0y6ORR/6J712raeOkfYGXqqPXCawu4Usfrw7IF8sXZIAdjMzZq09T0LewUxkZRY2r+SxVzq2iKgi8dOaNYFhuEPNrU3rRx8/2dwe3mJoNoxDvLbvjKpHFDoJuig6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Zm49/vCW; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46760d9e4daso13726961cf.0
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 17:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733793648; x=1734398448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sn80vTt34N+xZTV5Pd8DGCQRSaWyxIiO0FmcIs+JZ+4=;
        b=Zm49/vCWu1blWez+9lpN+h0ZznT63o0AypzQXHCbeMZvTDM0vDwmSJ1XcnT1+xJCA0
         98rh2yceTSVu7SyvY6V7b/3x4NRAvJcwA9/LLQNI/Ytod90CwFmeKp5kK4YzzrAouRun
         cFM2HnxQc0V4/i26glqmcAdiEls1hlC9fq0hgEs9UivkZ4gbFYKsp+711TVFIqttYBBw
         JM5xfGJpaE2AQ8oTa247TP1LLpI/Rt5ESpiS68wH+gCDW4UT1GdfU3jjbu9IQgITnZf9
         DTXD6VXo9eoKJg8RiqV+Hi9J81fMjubi37VeXlslhn+djjbLVGYz0iNIB8Nd43dQK++l
         3FFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733793648; x=1734398448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sn80vTt34N+xZTV5Pd8DGCQRSaWyxIiO0FmcIs+JZ+4=;
        b=al/+bZZ//1iEl50XahVmRwdW4vvlRGqIF6MH4FgFJ0KM0Dgeuvgy8AHE2Rott/D5vR
         dZxBFs6PSZT309V/TbmFCbV3Fj6/MxwSnGBM6iVsbmtNlQhTAHIYEVIn2dOSllt0OcyS
         dqQGUAPDH/Jznm3IsfuqkKc1vv0EgcZGqJtk6GmYe+kpnNrP7SQUR/JV2YGT9WKaaAz2
         DWDjhxbcwbKZAg4lZn9vpDKhUYOMf5fAKlXThSh+cOWa/ENdcCPP/NBkSJ8c1ugppOr3
         oJZP62P/4LqOiOQNUq+3PY6xOSWMTzgWMTzCqq/Wp0AENF4cvCFEMvvu2xJvkj3IAZOu
         EDOw==
X-Gm-Message-State: AOJu0Yxw1+TjwZ8i/4eO5rTSWW1xaL74JDBXuooQrPzK1o3+qz8g+V08
	yvTD7f7naYofgI8fUzTRRwnfoU5ZhNHlDPdcgUuwFKNsC/prbvNSs2MkXu+c+3XIeybBZb9A2fz
	d
X-Gm-Gg: ASbGnctx6bEPFPcKjcKjjPbwsbpVdsSGHNxnBb1mDTOTvsFVo3MmdiLqXz5eXhIAC1k
	nx9qTunzUtgXwPPEGBw+bt15sVnBeMes21/M8tCpcxtODhhBwXcm8x4cRK4jJuJlkXQMHXUpYsi
	lGXhLaTySPFAT+b2uH/q+qVr4okHb6wDBHTSe0soU/w+rij/4nScH8MF1W20ruLE9efqXxCvZOn
	rVwDRMdvzAsn7zZ4NbZ6LNBKkbFqZBiFlwIjfRi9mp8CcBpDl5TnEEDDOqBXbsKcT/3Uo0YBg1d
	m9E=
X-Google-Smtp-Source: AGHT+IGFsaW8q35XIH/VQcLwFEL11CZTZsFHXhqarsU6U0+ZIeZifd2sFt+3RWL9aAOYE+9YfzMQYg==
X-Received: by 2002:ac8:58c4:0:b0:461:9d9:15c2 with SMTP id d75a77b69052e-46734c94c38mr251622191cf.1.1733793647744;
        Mon, 09 Dec 2024 17:20:47 -0800 (PST)
Received: from n191-036-066.byted.org ([139.177.233.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4677006d143sm8116521cf.19.2024.12.09.17.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 17:20:47 -0800 (PST)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: john.fastabend@gmail.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH v2 bpf 2/2] tcp_bpf: add sk_rmem_alloc related logic for tcp_bpf ingress redirection
Date: Tue, 10 Dec 2024 01:20:39 +0000
Message-Id: <20241210012039.1669389-3-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241210012039.1669389-1-zijianzhang@bytedance.com>
References: <20241210012039.1669389-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

When we do sk_psock_verdict_apply->sk_psock_skb_ingress, an sk_msg will
be created out of the skb, and the rmem accounting of the sk_msg will be
handled by the skb.

For skmsgs in __SK_REDIRECT case of tcp_bpf_send_verdict, when redirecting
to the ingress of a socket, although we sk_rmem_schedule and add sk_msg to
the ingress_msg of sk_redir, we do not update sk_rmem_alloc. As a result,
except for the global memory limit, the rmem of sk_redir is nearly
unlimited. Thus, add sk_rmem_alloc related logic to limit the recv buffer.

Since the function sk_msg_recvmsg and __sk_psock_purge_ingress_msg are
used in these two paths. We use "msg->skb" to test whether the sk_msg is
skb backed up. If it's not, we shall do the memory accounting explicitly.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
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
index e90fbab703b2..8ad7e6755fd6 100644
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
index b21ea634909c..392678ae80f4 100644
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


