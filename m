Return-Path: <bpf+bounces-41231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9680F9944EF
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84305B230AB
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD199192B6F;
	Tue,  8 Oct 2024 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMsDxYJR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E585018C036;
	Tue,  8 Oct 2024 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381104; cv=none; b=Dg59cVBbCVPSavGnt+Ykq+vABOQzc0y4yG3sWHDUWEc/kifvwa7cm1bR2AO8AjM5n2UPudGdSJ3V8RyHwvieLtd1dUrUvqHSfpJ+UOY91qXIj0Gd5mZVmrfNE4PIXoEebRk3kreH1tqBdpYbRPUOb/fNrQqHqsqKgR7JGTsFo6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381104; c=relaxed/simple;
	bh=O+rOCs8Km96tOettkmdRxJdlhsVKmwjIfgNQYUpVrIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e/FNucjBLuCxRKnx4J7wB2CwiC50wgq+Nl1HFLpVS/giM5foyMI6yZuWSiBzJsRJVbnGlYeXU7oRb9RuGTgm1gtEWc+W6mhxwyBkBVzI0hKtt8Zr5SitKr60vJNolFu28jEOxAa+QwO5sa2DD2X1N6eaDPDFheyh+k0l+Y7DNho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMsDxYJR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b6c311f62so47288895ad.0;
        Tue, 08 Oct 2024 02:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728381102; x=1728985902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clbNLhCp+XW6B4yk6HCtD08Zy4k9Z0TDt4mDq2HKh3E=;
        b=VMsDxYJRahd5hktauEs6tM/TXmy3+wRsrVWvcGuRI0Lxh2MEKLzpEdhRyd3o+Ei/5D
         kZOahmzlMK/o/Cu4ErhfhDeTlnIkmoFnSw37RZsKpN6G8lSqFlJO7t6AFAXWsKtExzxa
         bM48SUMrdTAsnEFTHoj//rqd06kG8h/ouNR4/K6DNFOnm5tMWSkR5+5AExQsTQ/bolBU
         XGTIVkdopaDt2ILC62GH/z4ZGLHaf214uQU+bvWfceMM615HMrJjKeOXehxD8tzCLb8p
         bB8KVfJXqgB0OXOgP73a+Jg534iJxdaTskuNE3Y9ys30talnvcthegB1DmqzVs+UPEUR
         6GIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728381102; x=1728985902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clbNLhCp+XW6B4yk6HCtD08Zy4k9Z0TDt4mDq2HKh3E=;
        b=vzId6M5mQF6X62w/rr3y96TDJG/FDCz+ZHwmi5VCu5quJAcQXMiU8YPigcNmKaq3nd
         G+3tVyWvCryalElZWd5hmTxj89o95or3UtxCPmR0rykHAB3YRgcGGKghnVmUuBY5JEEF
         B0G+wVzlOBm9FdVszMmhVBS/gTJt7hFC+K5YMwZcxox8igFmGC0OTN3UMaX6adG4CJ/T
         ofMi8ckcIV3rwlBuZM1oSyfGMIBeMWuDaMpFH54hDxy/LMTHfPnJjA7nCOlfxLQrpCXv
         NwXvCCSHOOY7au67stcJlGOUgVGC2U+7PNcW6bw8mAii+maxs06Bf/9VqHP6CxVdA3ZW
         P9mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVAo3G7wXV56XwI8JArYWYdP/3coPfZ2N48hhWD/wdwMw6ALYDEkyDpbyUr/JCzPgeYwpSOME=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXDisHWdRcQhyqapxsOi1TUYinyjyqmF/AQkVHo3QnZ1xM1DiU
	mumx616draNdpseZkCOHNsMCT9KVBTjgggs7EvIQpzhT3gZDmo02
X-Google-Smtp-Source: AGHT+IHQUWiP5VPlQ5FbrqdDcAGrJrUGqd/XwD/1PvwRofhB6VtQnZaj7ZoDd9IfM8cvklLAN0wVmQ==
X-Received: by 2002:a17:902:e848:b0:20b:96b6:9fc2 with SMTP id d9443c01a7336-20bfe022a3emr199451565ad.10.1728381102073;
        Tue, 08 Oct 2024 02:51:42 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cfd25sm52527345ad.73.2024.10.08.02.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 02:51:41 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 5/9] net-timestamp: ready to turn on the button to generate tx timestamps
Date: Tue,  8 Oct 2024 17:51:05 +0800
Message-Id: <20241008095109.99918-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241008095109.99918-1-kerneljasonxing@gmail.com>
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Once we set BPF_SOCK_OPS_TX_TIMESTAMP_OPT_CB_FLAG flag here, there
are three points in the previous patches where generating timestamps
works. Let us make the basic bpf mechanism for timestamping feature
 work finally.

We can use like this as a simple example in bpf program:
__section("sockops")

case BPF_SOCK_OPS_TX_TIMESTAMP_OPT_CB:
	dport = bpf_ntohl(skops->remote_port);
	sport = skops->local_port;
	skops->reply = SOF_TIMESTAMPING_TX_SCHED;
	bpf_sock_ops_cb_flags_set(skops, BPF_SOCK_OPS_TX_TIMESTAMP_OPT_CB_FLAG);
case BPF_SOCK_OPS_TS_SCHED_OPT_CB:
	bpf_printk(...);

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/uapi/linux/bpf.h       |  8 ++++++++
 net/ipv4/tcp.c                 | 27 ++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h |  8 ++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 1b478ec18ac2..6bf3f2892776 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7034,6 +7034,14 @@ enum {
 					 * feature is on. It indicates the
 					 * recorded timestamp.
 					 */
+	BPF_SOCK_OPS_TX_TS_OPT_CB,	/* Called when the last skb from
+					 * sendmsg is going to push when
+					 * SO_TIMESTAMPING feature is on.
+					 * Let user have a chance to switch
+					 * on BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG
+					 * flag for other three tx timestamp
+					 * use.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 82cc4a5633ce..ddf4089779b5 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -477,12 +477,37 @@ void tcp_init_sock(struct sock *sk)
 }
 EXPORT_SYMBOL(tcp_init_sock);
 
+static u32 bpf_tcp_tx_timestamp(struct sock *sk)
+{
+	u32 flags;
+
+	flags = tcp_call_bpf(sk, BPF_SOCK_OPS_TX_TS_OPT_CB, 0, NULL);
+	if (flags <= 0)
+		return 0;
+
+	if (flags & ~SOF_TIMESTAMPING_MASK)
+		return 0;
+
+	if (!(flags & SOF_TIMESTAMPING_TX_RECORD_MASK))
+		return 0;
+
+	return flags;
+}
+
 static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 {
 	struct sk_buff *skb = tcp_write_queue_tail(sk);
 	u32 tsflags = sockc->tsflags;
+	u32 flags;
+
+	if (!skb)
+		return;
+
+	flags = bpf_tcp_tx_timestamp(sk);
+	if (flags)
+		tsflags = flags;
 
-	if (tsflags && skb) {
+	if (tsflags) {
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 		struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index fc9b94de19f2..d3bf538846da 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7033,6 +7033,14 @@ enum {
 					 * feature is on. It indicates the
 					 * recorded timestamp.
 					 */
+	BPF_SOCK_OPS_TX_TS_OPT_CB,	/* Called when the last skb from
+					 * sendmsg is going to push when
+					 * SO_TIMESTAMPING feature is on.
+					 * Let user have a chance to switch
+					 * on BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG
+					 * flag for other three tx timestamp
+					 * use.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.37.3


