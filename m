Return-Path: <bpf+bounces-38115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B230195FDF0
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 02:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274B71F2306F
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 00:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A8A23DE;
	Tue, 27 Aug 2024 00:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gJJwMVuf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B571FAA
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 00:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724717791; cv=none; b=iA3rBR0Qs4x0IchIg9Zp01pJuVSSmYuX+jv0DljjBHcgSURzmmPz9x+rvC5T0dLKsKGZb1lMjPc8BmcSegGQ2eh+NWTSfrohaW/TwWqZl41/hfkKt3AgOEYyT0QyQaQZwpNriIY2dLhJjtRnFh9gtzA0ApViYK6hnbwE1rcfwrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724717791; c=relaxed/simple;
	bh=dwXgFkLLxDlJ/psywywm0sXw8F+FfB0iKbQ1oItwNfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HJYfcklmHCEl5qWhKCBYlayN1r7t37Nk7oKf5wlmIJO20PWLANTK0SMjS+aO9BHIRR59HqstxVnLmTbVMZfJslw0r/lUb5Dy3Bal91sePqQtHoRev1c6wKKkPguTYBEHdbW4CG3B2lYd+oi1OngYPZPrngrppJDZvIJYsrtcy88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gJJwMVuf; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6bf6606363fso26769856d6.3
        for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 17:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724717788; x=1725322588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvaGTDglxkoTbtTs4rY1slGgaJPTK8jyVArxMPfgfwk=;
        b=gJJwMVufTosef4Y9OZjt3sdIpPdv1fkI9AmtlD0pSvudoslZmASl/JoM/Jh1ErxBYI
         u5coH+9blADKC2JbLvFe62C6VMUMB5+WXrs8O5XThyWRZampVCmd2p8XNsprgg9mCwVk
         DIFww9EadWDh/STmkEPOZbU5hJAJlT+Dfs1WCye6ACCYZAbz4RnKbtfM2Ja4sG+jni5X
         MY/MRT8+/CKqNErfbi7m/qh3fyIu3Q3+QozlNlQHDmANTVabSfPSLyGo6tzbfS/aEkqP
         W/XPYnW7UUjfQBRjGDOAK/Ub05PBpjXgOlaUU+pQJBbuYa6VQZ4ZvYzbRgsGlJLbJPiA
         au5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724717788; x=1725322588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvaGTDglxkoTbtTs4rY1slGgaJPTK8jyVArxMPfgfwk=;
        b=NF4zgrSTosZFVgCx+1DeX399+tXBC5lze/PBkNrOdKL3+W0fpMfC3YhRyv1bIImSwT
         YSWlrZpaRj3/eb9Na3f36KvsraKYnhxZeK2uo4neOcSunjAuNuhGJeYQS+qI6q6DfzVZ
         /AvoHwrlrfMJfYoBatO3b16GloafBNSJcxtEJhf1w80Afx7rXZG0OzjLKvgnZybfZJXg
         iapdj6fTn0bXjzD8KcJ7Ez5pvZ58os/WkTapzfotmbYCb+KY8lsybFchVJs4I2SVLsug
         11sY0z7peeE3brdID9OC7pmokTdEp/oPVdISlhuD9V8IxnZTYIPPkHEB4zKX2kB8JsPL
         R9gQ==
X-Gm-Message-State: AOJu0YyQAPUmZqffBTYqDrulgkVEaKZep3c8sy5aJfFm/h0wBVVXK9rq
	O+chpCikQ9vAavqEKT9Y0zBmwIcWKFag+yLHZOVDRHljPuz5m/Lb2LjOTpmolb9RyASkiZ5Su0G
	B
X-Google-Smtp-Source: AGHT+IFbFBMiUYVwMkpOUUbZNRct4zq9d+QQoMIsLLVopZRMJGyE2dwc1oLKOSJFttUfDoFHXfmJ3Q==
X-Received: by 2002:a05:6214:418c:b0:6b5:936d:e5e9 with SMTP id 6a1803df08f44-6c16dc86c56mr136602326d6.26.1724717787936;
        Mon, 26 Aug 2024 17:16:27 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162dcda66sm51387136d6.122.2024.08.26.17.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 17:16:27 -0700 (PDT)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	xiyou.wangcong@gmail.com,
	wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com,
	Amery Hung <amery.hung@bytedance.com>,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH bpf-next v1 1/2] bpf: tcp: prevent bpf_reserve_hdr_opt() from growing skb larger than MTU
Date: Tue, 27 Aug 2024 00:14:06 +0000
Message-Id: <20240827001407.2476854-2-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240827001407.2476854-1-zijianzhang@bytedance.com>
References: <20240827001407.2476854-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

This series prevents sockops users from accidentally causing packet
drops. This can happen when a BPF_SOCK_OPS_HDR_OPT_LEN_CB program
reserves different option lengths in tcp_sendmsg().

Initially, sockops BPF_SOCK_OPS_HDR_OPT_LEN_CB program will be called to
reserve a space in tcp_send_mss(), which will return the MSS for TSO.
Then, BPF_SOCK_OPS_HDR_OPT_LEN_CB will be called in __tcp_transmit_skb()
again to calculate the actual tcp_option_size and skb_push() the total
header size.

skb->gso_size is restored from TCP_SKB_CB(skb)->tcp_gso_size, which is
derived from tcp_send_mss() where we first call HDR_OPT_LEN. If the
reserved opt size is smaller than the actual header size, the len of the
skb can exceed the MTU. As a result, ip(6)_fragment will drop the
packet if skb->ignore_df is not set.

To prevent this accidental packet drop, we need to make sure the
second call to the BPF_SOCK_OPS_HDR_OPT_LEN_CB program reserves space
not more than the first time. Since this cannot be done during
verification time, we add a runtime sanity check to have
bpf_reserve_hdr_opt return an error instead of causing packet drops later.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
Co-developed-by: Zijian Zhang <zijianzhang@bytedance.com>
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
---
 include/net/tcp.h     |  8 ++++++++
 net/ipv4/tcp_input.c  |  8 --------
 net/ipv4/tcp_output.c | 13 +++++++++++--
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2aac11e7e1cc..e202eeb19be4 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1058,6 +1058,14 @@ static inline int tcp_skb_mss(const struct sk_buff *skb)
 	return TCP_SKB_CB(skb)->tcp_gso_size;
 }
 
+/* I wish gso_size would have a bit more sane initialization than
+ * something-or-zero which complicates things
+ */
+static inline int tcp_skb_seglen(const struct sk_buff *skb)
+{
+	return tcp_skb_pcount(skb) == 1 ? skb->len : tcp_skb_mss(skb);
+}
+
 static inline bool tcp_skb_can_collapse_to(const struct sk_buff *skb)
 {
 	return likely(!TCP_SKB_CB(skb)->eor);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e37488d3453f..c1ffe19b0717 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1550,14 +1550,6 @@ static bool tcp_shifted_skb(struct sock *sk, struct sk_buff *prev,
 	return true;
 }
 
-/* I wish gso_size would have a bit more sane initialization than
- * something-or-zero which complicates things
- */
-static int tcp_skb_seglen(const struct sk_buff *skb)
-{
-	return tcp_skb_pcount(skb) == 1 ? skb->len : tcp_skb_mss(skb);
-}
-
 /* Shifting pages past head area doesn't work */
 static int skb_can_shift(const struct sk_buff *skb)
 {
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 16c48df8df4c..f5996cdbb2ba 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1033,10 +1033,19 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
 					    BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG))) {
 		unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
+		unsigned int old_remaining;
 
-		bpf_skops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts, &remaining);
+		if (skb) {
+			unsigned int reserved_opt_spc;
+
+			reserved_opt_spc = tp->mss_cache - tcp_skb_seglen(skb);
+			if (reserved_opt_spc < remaining)
+				remaining = reserved_opt_spc;
+		}
 
-		size = MAX_TCP_OPTION_SPACE - remaining;
+		old_remaining = remaining;
+		bpf_skops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts, &remaining);
+		size += old_remaining - remaining;
 	}
 
 	return size;
-- 
2.20.1


