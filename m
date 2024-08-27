Return-Path: <bpf+bounces-38120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C6395FE60
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 03:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C731C2194B
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 01:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0253E8831;
	Tue, 27 Aug 2024 01:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OENk3ttc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F3079D0
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 01:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724722755; cv=none; b=hcG/ZOyOkTCXj7nBLoP0YEG0HZqQORHFzNs2TqczXfc0skKf2uO5zFiX8oMMWLNIIc8KoIjGibUV8n38pHxI7tGcSNh7Cz+ACvvDLwHZo19p/T8qSoibXOMFyH7xtGXfgbr+rGLpjW4OrtG91De4FwnUYywIebu6fGTtFDiBqW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724722755; c=relaxed/simple;
	bh=dwXgFkLLxDlJ/psywywm0sXw8F+FfB0iKbQ1oItwNfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XIw1jlPcWyvEm7qAjIz1keDmQSzvSiJ+oKX2r/2DhKhPj6wDT5lGStwdTj0bpMKb/XxDd32ip8er+DiQJMq2xX2TIfPHqFwSFrn7mYUsUqXrQm2V16xETtXDZnY8S5kgVkGE/0T+QzdKVx6a0y8XFh9SH5MYiDdMatjS//30+Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OENk3ttc; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e1659e9a982so5451627276.1
        for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 18:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724722752; x=1725327552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvaGTDglxkoTbtTs4rY1slGgaJPTK8jyVArxMPfgfwk=;
        b=OENk3ttcMsNJ3X0Ph+O4ADnJfcCUytxTN6TE49Q2UPQCqT5NWC/T/9jyLWDIz02iPI
         wFgBNo46qsdUXfsFWCtj7uJU3D37czVfp+y+O8ZIaSKWlDiNEHsBncOiwHcq1bb9DFx1
         /FOf4HRlzU4kDy8SNtZENtgoOOjhbtYIXZEvCBaRFrk0aTO1Weevj+6NxarpZPWStzbh
         hnBBc6MSiY3eqQWSJzmC8MEXdSwLP1SFv0AWfniGC8mAqbx7Kx3GGLvPy9lvFe+LyymT
         hMj0YrSWTJQSAWEQIz9uA6NCzAAnCjKgdilNvUl/z7IQya9he5IJURyRwcv2EGVExL8c
         B/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724722752; x=1725327552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvaGTDglxkoTbtTs4rY1slGgaJPTK8jyVArxMPfgfwk=;
        b=WflLr10bSTD4lLc0LIqtPg2d+hJpHul+mQbVkRRPxK90pKxakdnapHicurh2PSnIHF
         oQZMq9KImZddmQovEoE99Tg+jLbsx+2VDIWO7lUcuN4kiJUpkcz3Ypu6NREWpCkK8HtC
         0qZcT6BQLRzzGpzxDQTJZg33/Lb57wNl8CqSeVTDgszG3ETbuxEiizAgI2hgEX3/ws1V
         DBAplKhI0+fQoCfay7oVOXhM4JfXWy0MVnnYF0Y5pgExCvo4w6Nrszp64mxHmyP/3uhg
         8g+iRoEIIky1AQtDEnpq0DU2/wxwe0W+yY2lEgfrlR/+uSVkCY7nP6voix2qATJgWt5g
         lmSQ==
X-Gm-Message-State: AOJu0YwjjZC8WFpUhP5y95BZiKtXz/MPort+cwp5SQUgIcgGMTIPlDGN
	mkq1/0AveSHlUdUGDoTuDndOhB2Qn978wFZ0Cabz5bsWxaWqpNVgrXoYV6WbGumfQXUf8zkt20Q
	B
X-Google-Smtp-Source: AGHT+IGcBthqqwXGlXS1UIA2b0+LNsadtZIAhf5q1hjivMroYx3q1Ov4J2iMLxocellfd4rC0mb90g==
X-Received: by 2002:a05:6902:1026:b0:e13:c984:d7cf with SMTP id 3f1490d57ef6-e17a8682365mr12351049276.50.1724722752080;
        Mon, 26 Aug 2024 18:39:12 -0700 (PDT)
Received: from n191-036-066.byted.org ([147.160.184.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe1c5711sm48263401cf.82.2024.08.26.18.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 18:39:11 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/2] bpf: tcp: prevent bpf_reserve_hdr_opt() from growing skb larger than MTU
Date: Tue, 27 Aug 2024 01:37:35 +0000
Message-Id: <20240827013736.2845596-2-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240827013736.2845596-1-zijianzhang@bytedance.com>
References: <20240827013736.2845596-1-zijianzhang@bytedance.com>
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


