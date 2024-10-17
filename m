Return-Path: <bpf+bounces-42260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFE59A175E
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 02:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4499D1C21A59
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 00:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBCB14F98;
	Thu, 17 Oct 2024 00:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RxmvBFPr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FA017588
	for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 00:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729126673; cv=none; b=mGEqiu6fN2OI8QKfFJXzpj5EcXoUeZT74FSnpZ6On0lIs9obS7SLJgVl3YRq4jQcJaUEY0e0EhaUNIueZv+Vav0bxsgx7Fe52I9m8dwSe/ySyQd5w/VmN5OpBQ8Lsi/yrBeaFPZOfMLP+Dl5XsF6ddadAiLHH4kChRvN5TzCXoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729126673; c=relaxed/simple;
	bh=75hR31KYcNVVw9XfAVhT5KZdKZHt01NPK5ObpGx/k0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SNGrneYgsf9wu0JyQwWlHF9b6uNTp5FfTHJqjileKeyRfkI7JZ3kNRhcIt2Fplj5pR5070j+4wHnM/zYgqVRFwfoKAbbMytZ6mpooX5pcPdhzegCYt3dfCqkc3cNZUzvvlUrropWeWrbbVPBuzJc9ic/jt4kEhT8KjYkVzrBFO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RxmvBFPr; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b1488fde46so34888785a.2
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 17:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729126669; x=1729731469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Ie/0oo/Q1j/Vv9YDm7GQSm/OrG3L8RDi9nDJTydVEA=;
        b=RxmvBFPrgdofw2l8y8pvtZvh7CYDCyzCl+v4kJrFUKFv3/cibGUzBjYa/RFWfvQaYL
         T7oxdX7Idk5eE5prqz8UzqxsGgRvPag7G1d67+OC+JxzWrfoYjrhn58p+5XBdi4ojhXM
         ahZK2emSx43wlJ4b5yXQWGaobGbtuJ/Ld8DfqbMAvD5sDQ4fUW2rIXoEMSIxOsOK/aBX
         LuLTJnJ5csafZ/2AhpATrMdgIhRxiswPmH5x+tgSsN5JPa5836e/L1PCWvaKCmKpuaxq
         SMQC1veQCdHmTvkUalZbvLHrGQY7KTkhAtQCn1S4iLs6E+HBGAtB/rOPrkOd25qWZbqN
         5biA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729126669; x=1729731469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Ie/0oo/Q1j/Vv9YDm7GQSm/OrG3L8RDi9nDJTydVEA=;
        b=fEEiKHdvhgqKDMAofT0O6HLOHg60Vr8M4QhUBu5y3yiUhb8YJo8KXmRVjInbAFdzAF
         JEJ8utPkQqVcjre2g0LsVIrEOOiKcOof+4qCNLNXUiSkttL117t8aIh4TG3EJNzXYK0V
         gKrtm7vqAEItT+tY4EwBTySjyaNlU6yM3x2whifOaH82StcYPWbslgJJrOg7KfElexLs
         AkJmoAGH2+EpnKtPHRVv+SC7Hfc3RTNlCXw7IpCNeoiXruBQKjUscY0MeDqpzrdaQEvV
         PK+0Jc6ANaYYMAmPnEioi65FTIzD0oS2pnIpCPimtM4vW47pNeLbOml7Lstp7fT9OnEb
         Rsgg==
X-Gm-Message-State: AOJu0Yz8QSJgdSgaaqg4F7ZEiCN6EHdrMqGSaMw7kinPP6gjE364upCw
	UrlLhaveG/NlzWWWpGtivlNswLL8tYV7sNs5mZvhWU9qJkLxhXmXslrbznjsYsI6xojs5pgeOKK
	1
X-Google-Smtp-Source: AGHT+IFbS9Qlspq3VIc4TYQhRSNdXpqYJG5hpVKxDvn0CRr56E4UiAbQn5PBpciQJZUPAuZHJpYFAg==
X-Received: by 2002:a05:620a:45ab:b0:7b1:4053:71c1 with SMTP id af79cd13be357-7b1417cb2fdmr901518185a.18.1729126668815;
        Wed, 16 Oct 2024 17:57:48 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b13617a23esm242466685a.60.2024.10.16.17.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 17:57:47 -0700 (PDT)
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
Subject: [PATCH bpf 1/2] tcp_bpf: charge receive socket buffer in bpf_tcp_ingress()
Date: Thu, 17 Oct 2024 00:57:41 +0000
Message-Id: <20241017005742.3374075-2-zijianzhang@bytedance.com>
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

From: Cong Wang <cong.wang@bytedance.com>

When bpf_tcp_ingress() is called, the skmsg is being redirected to the
ingress of the destination socket. Therefore, we should charge its
receive socket buffer, instead of sending socket buffer.

Because sk_rmem_schedule() tests pfmemalloc of skb, we need to
introduce a wrapper and call it for skmsg.

Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 include/net/sock.h | 10 ++++++++--
 net/ipv4/tcp_bpf.c |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index c58ca8dd561b..4e796b1a92d2 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1519,7 +1519,7 @@ static inline bool sk_wmem_schedule(struct sock *sk, int size)
 }
 
 static inline bool
-sk_rmem_schedule(struct sock *sk, struct sk_buff *skb, int size)
+__sk_rmem_schedule(struct sock *sk, int size, bool pfmemalloc)
 {
 	int delta;
 
@@ -1527,7 +1527,13 @@ sk_rmem_schedule(struct sock *sk, struct sk_buff *skb, int size)
 		return true;
 	delta = size - sk->sk_forward_alloc;
 	return delta <= 0 || __sk_mem_schedule(sk, delta, SK_MEM_RECV) ||
-		skb_pfmemalloc(skb);
+	       pfmemalloc;
+}
+
+static inline bool
+sk_rmem_schedule(struct sock *sk, struct sk_buff *skb, int size)
+{
+	return __sk_rmem_schedule(sk, size, skb_pfmemalloc(skb));
 }
 
 static inline int sk_unused_reserved_mem(const struct sock *sk)
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index e7658c5d6b79..48c412744f77 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -49,7 +49,7 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
 		sge = sk_msg_elem(msg, i);
 		size = (apply && apply_bytes < sge->length) ?
 			apply_bytes : sge->length;
-		if (!sk_wmem_schedule(sk, size)) {
+		if (!__sk_rmem_schedule(sk, size, false)) {
 			if (!copied)
 				ret = -ENOMEM;
 			break;
-- 
2.20.1


