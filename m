Return-Path: <bpf+bounces-52057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C25A3D252
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 08:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A362B189564C
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 07:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFBA1E9B21;
	Thu, 20 Feb 2025 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRL70anV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAB01C5D5E;
	Thu, 20 Feb 2025 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036652; cv=none; b=YO9XzvoFeKoU1OePH17fgYEFzQAExxDO44KAqgIw+nMtweqjLhFk6MzdbJwsRpGDrbK2dq1k/WppZO4xyaT0I/vP5npc207cPisiPEgpL3x3kOTJ7PrUJQvup2tAXrGfz/dJ6pwfcrppoQLUh0YApXXdHfGSZIuflmYBhoRUKdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036652; c=relaxed/simple;
	bh=QI63TEo7OBUA2R+M2ML5uZeeala2bdwqtRWUt0H/DSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RoGI31BYt7H8Svdpnuev20N613GD1C0+BAoCkHVt3zLLVqLE4FGlDyZw+bJR0Gw0lEy8EdZZYJQWq9bimEXZyy6hJGUomSq20x3q/LF1lTT9ez+nVmmKvxJvgUh/mGhNxq2F4bqT9dWKrkpVAE4I08L0MkoqB29P6Rb7Cw7lSJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRL70anV; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220e83d65e5so10052795ad.1;
        Wed, 19 Feb 2025 23:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740036650; x=1740641450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/p8GGgo+9N78a/jndiD1gK8PO1CY8jXwXhYb2d1ooT4=;
        b=aRL70anVJr0N2pW0iDWT05uZuk3xy/UMTLRjMVlK6GuvM2jYJ5wcXEls93oNXb5aqX
         F5eE5a+dlu+Y8Z/fW86owVAy8PsXFwiGn4tF0m97FgWQmKWylZuJUT3VeShh2B+55s6M
         sSOZkhWsIl5laZn+cmz2IaE2H2S7V9AdPMX6UNYe1WwoWvoxe+qN7GRcQloDv0sk2hEn
         dKSOXnC9J1jEsgCTf6ZmjBZ3fP23ZX4R/e4SrvfC5zTro7FlKjoUfn8v2z84QMVi0BOg
         QW871/jFIsja9nWQh5GEVN36MGYEpTtaFi0/BGNFrOkgzJ0h0zJXgzfzFaSWZwsQxJeR
         xizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740036650; x=1740641450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/p8GGgo+9N78a/jndiD1gK8PO1CY8jXwXhYb2d1ooT4=;
        b=NpNFkQmfDCKuGIAmwX4gM6cvGXfYlzKiChI/uvQ4Jnbze/zZ2eQR3LT1/jrFU7G6nu
         fBdWokD2Chi4QD82SmGRAh90yPNMsiL6Cn+8Zvrqiz29IjgrxbxDHJBea/t16xSU5VTg
         1JbB8gtBmXrsoG7mXUhMhH5r/LlTY3eHWVlQ3oKw4VT3lhDYTamf0OmMEVewHLqUbqsM
         Sj7mtQWAM/NPJiaOP2FyZEA4f4lILjaEprDMyaCWX+KhJMKPmusAO7T06gawt+SNi5Is
         2FCZa2hJmyWYVSm1idxzLiIP0tA9ljuNBwN1k3T0kUpIgZxWSjEVUBdi535rTAnpPSQy
         E3kw==
X-Forwarded-Encrypted: i=1; AJvYcCXRxqb5lMdZt7hSZCt6PMl3rYJrJ7FJWb5cpPsYgDFtJpAmeZ6RkKzcTfV6DdPJC5F7DkM6UmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrSn1V/QwKCaMznPBLTdiqfTag+ck+UWxqilQNoaZtsdoQ/4on
	wqh/wgRi5iErdpGg6nzFUrml7XujhPE7gP1Y5IGRSlZjCAX3dzrH
X-Gm-Gg: ASbGnctAsTy82YEvcqtH/H2ZrFoe+rrNt6hYeSBgzhURTzXjkUTl4N3bc+uuJu0KSXB
	OnGTlEF3SY8permo3/9n8kj8OtbkLrvBUH0djcCfEBtK++R8ottxf1LGhWqwYcuV+6Ci4sGihs3
	e3ksc5HSiEjJS8ybNJPwbfpa7aFxpyrhDvNWGulUPvuhmD1JTlynPWYn9YAvGjxCWJ2i4Bf+I9j
	QkO/8fXlpuA2az0YQ20p63Xbc9/A8cN/zqNgh/sp5Ulg0bQD8hJM7pkY9wPfGR9TAPd1PpFHKgU
	TPUy2Fa8KAxgWDHugscsXNsBWvVVWwvCpgldze6jY4/mIJAtOkqZ9+2ftGxhoFU=
X-Google-Smtp-Source: AGHT+IEL4GrZJ70BNJH9vlmqwATRjyw9TS+BS7dI03WRf+qwCYRZSswIz2hiKgw7fUMS4d7y8tXJ7A==
X-Received: by 2002:a17:902:eccf:b0:220:f140:f7be with SMTP id d9443c01a7336-221711a6986mr129567965ad.41.1740036650187;
        Wed, 19 Feb 2025 23:30:50 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d643sm114048205ad.126.2025.02.19.23.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:30:49 -0800 (PST)
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
	jolsa@kernel.org,
	shuah@kernel.org,
	ykolal@fb.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v13 10/12] bpf: add BPF_SOCK_OPS_TSTAMP_SENDMSG_CB callback
Date: Thu, 20 Feb 2025 15:29:38 +0800
Message-Id: <20250220072940.99994-11-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250220072940.99994-1-kerneljasonxing@gmail.com>
References: <20250220072940.99994-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces a new callback in tcp_tx_timestamp() to correlate
tcp_sendmsg timestamp with timestamps from other tx timestamping
callbacks (e.g., SND/SW/ACK).

Without this patch, BPF program wouldn't know which timestamps belong
to which flow because of no socket lock protection. This new callback
is inserted in tcp_tx_timestamp() to address this issue because
tcp_tx_timestamp() still owns the same socket lock with
tcp_sendmsg_locked() in the meanwhile tcp_tx_timestamp() initializes
the timestamping related fields for the skb, especially tskey. The
tskey is the bridge to do the correlation.

For TCP, BPF program hooks the beginning of tcp_sendmsg_locked() and
then stores the sendmsg timestamp at the bpf_sk_storage, correlating
this timestamp with its tskey that are later used in other sending
timestamping callbacks.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/uapi/linux/bpf.h       | 5 +++++
 net/ipv4/tcp.c                 | 4 ++++
 tools/include/uapi/linux/bpf.h | 5 +++++
 3 files changed, 14 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6f728342fabc..a46f6c35b232 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7053,6 +7053,11 @@ enum {
 					 * when SK_BPF_CB_TX_TIMESTAMPING
 					 * feature is on.
 					 */
+	BPF_SOCK_OPS_TSTAMP_SENDMSG_CB,	/* Called when every sendmsg syscall
+					 * is triggered. It's used to correlate
+					 * sendmsg timestamp with corresponding
+					 * tskey.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 12b9c4f9c151..2b4791a6791c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -492,6 +492,10 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
 			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
 	}
+
+	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
+	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb)
+		bpf_skops_tx_timestamping(sk, skb, BPF_SOCK_OPS_TSTAMP_SENDMSG_CB);
 }
 
 static bool tcp_stream_is_readable(struct sock *sk, int target)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 11d9fc3e3434..8429c01573cd 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7050,6 +7050,11 @@ enum {
 					 * when SK_BPF_CB_TX_TIMESTAMPING
 					 * feature is on.
 					 */
+	BPF_SOCK_OPS_TSTAMP_SENDMSG_CB,	/* Called when every sendmsg syscall
+					 * is triggered. It's used to correlate
+					 * sendmsg timestamp with corresponding
+					 * tskey.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.5


