Return-Path: <bpf+bounces-51209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A496A31E8D
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 07:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB634167F51
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 06:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49651FBE8A;
	Wed, 12 Feb 2025 06:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+FSEpEm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ADA1FBCB9;
	Wed, 12 Feb 2025 06:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341159; cv=none; b=aQmPne0iko17NAHMcGDiRInk7iMEJNXZCUqx6FMy+rdtVsMk9k2dc0vo8SD9DqVe1PXiezZiMfm69+1FJqI5IMDwgmrsnXH789KqF4tOy26TXUDb6i1akvMh+TyvTX8x5n2Z3rikYKaE18lINGu7YE+mXcj8DLTPeN0GYLSZ5Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341159; c=relaxed/simple;
	bh=xKbudb0FUrth0r9fVulR0YQSW9YlrDYUxAjIB9W3r94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WCiyQMWqgWiBc9FY+TkbLhO39M3rSpkFAqdLAEraI+tCoYr4SZhcPFsntfijYb4W+RD8P/d5PNkH4YnTIgQN7IXWicihzPyw3FCAiDIU9QglVUke6k3jhIeE5Leki7rFR5scfObzVgNaB68YdoJWP549Edv+sXv0rmH9H4jcxEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+FSEpEm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f4a4fbb35so7578485ad.0;
        Tue, 11 Feb 2025 22:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739341156; x=1739945956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCClYBX4dv1juFzLnShvLFoS82zgt+5gs+BbDuAzfbU=;
        b=d+FSEpEmY2nTUNvC0RXflKDX1l5hVizDBJsBI3v/sQr8q/feRmN4n4t+AQL1JPvoPv
         vgC2n0B7ikLtrb3wpnzrdi95NnRGcfXJARHLJnezjoLGfjS9fdr8q7hAD8bJS89rxMB6
         o1EKz8rDFmeQWoznI+uC2cAXCXZyE1FG/FCvQ4WK6v8ftYWd+xX57KXbnPsxwHGQ17B/
         UuwxeTUMnsBs4kS7/VyTzA1hWZguv3BTJA4pqLPVguEccr2e8C54YzvxroDvwsh0ZXVM
         Vn2p4zrVvmW3I1LPTxwhbK3d6gd6/zM8OLAN1CqS2XLx2xF5u2KR6WqaUZ65G7DLg9cM
         TVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341156; x=1739945956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCClYBX4dv1juFzLnShvLFoS82zgt+5gs+BbDuAzfbU=;
        b=S6dkQroRq4Mlx6snh+KoVITVu6Nq+8XxLOutT9gqcovTYjE4kEGmk8QJLJyiseDm3A
         p099YFLHilNQ9Hfo0dHLhhPqeKj8QohCgBrjUuzxnaqphJJM5piuEzSxKbAcEobbTYHA
         WDt7y3Ly4lpGTQwpyqaYqE4BRfapqwaRCMOFHXb0EkEjlP8F88nDK7bDXw5tN72sD9iO
         n8N4HKFmEmrgQcTjvCMjGCQRFp62cys6iegixc8p4FFqFYjKuK3UwBED8R+0MZ14BagC
         1jtTa6ElYplP7G0vroreoHDQa1qtBm0AHGcuEAtKguq4GnAs9myp6wcLCAFl8MiCQ356
         7jxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWvIb7jU91Qz+7JaumzkYeyZISRgj8I8kdzTzAkeBiSXZ+FdtIFy00EqkmawljZ7RaqOM+IHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFN5lOkbVaCF3Dug3YGSb5ShXInLN6fD8TWPQPz2PNToI8EhjE
	9cWYhSSIEWKe0KAsuDMLbIkNWU8VAnD+lzmXj2Jpt33OqBYeb2vU
X-Gm-Gg: ASbGncuFZ+o5zhmXsDkihs/eYwgJsU1U4xrgrVURdQUAkFzS8mhBVr9i4JQNva6yi4q
	b7FMiitsscSZORdZTaFaJb6dsvLo0K6dBpIQv1mSYbxWLjg9VZDVhfNKOWUnDSWJqusMa+D9+7c
	Eb6diUZSZGkyLhnejhOc/+ikLBt4m0ENf/Y/s8yqwfpdqBRKKPCi6FuSwPJ65sq3MgTVlaYn7Rh
	Ja6c6ZULXZfyC/b5g6dViIhg0gaetY3ycif3ck7pDwLPkq/UHf6tCXSnmPRULxCAQZ7rsd4vPz1
	P5dVWj/DJEIgnGcxYwoupzlrfVCJ5lz/ouOMVRcxgtxnkzy5dD7DUnZYG+MhHzU=
X-Google-Smtp-Source: AGHT+IE3qOZg2MrTipqqchD2WrsEz7ElbKgm/uEJppPRgC+1BZ7b2c4OD1AVutaFnSwM0lRoM6ODfQ==
X-Received: by 2002:a17:902:c94a:b0:21f:6546:9adc with SMTP id d9443c01a7336-21fb6c1a9c9mr91913975ad.13.1739341155807;
        Tue, 11 Feb 2025 22:19:15 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683dac7sm105277835ad.142.2025.02.11.22.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 22:19:15 -0800 (PST)
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
Subject: [PATCH bpf-next v10 02/12] bpf: prepare the sock_ops ctx and call bpf prog for TX timestamping
Date: Wed, 12 Feb 2025 14:18:45 +0800
Message-Id: <20250212061855.71154-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250212061855.71154-1-kerneljasonxing@gmail.com>
References: <20250212061855.71154-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces a new bpf_skops_tx_timestamping() function
that prepares the "struct bpf_sock_ops" ctx and then executes the
sockops BPF program.

The subsequent patch will utilize bpf_skops_tx_timestamping() at
the existing TX timestamping kernel callbacks (__sk_tstamp_tx
specifically) to call the sockops BPF program. Later, four callback
points to report information to user space based on this patch will
be introduced.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/net/sock.h |  7 +++++++
 net/core/sock.c    | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 7916982343c6..6f4d54faba92 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2923,6 +2923,13 @@ int sock_set_timestamping(struct sock *sk, int optname,
 			  struct so_timestamping timestamping);
 
 void sock_enable_timestamps(struct sock *sk);
+#if defined(CONFIG_CGROUP_BPF)
+void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op);
+#else
+static inline void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
+{
+}
+#endif
 void sock_no_linger(struct sock *sk);
 void sock_set_keepalive(struct sock *sk);
 void sock_set_priority(struct sock *sk, u32 priority);
diff --git a/net/core/sock.c b/net/core/sock.c
index eae2ae70a2e0..bde45569d4da 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -948,6 +948,20 @@ int sock_set_timestamping(struct sock *sk, int optname,
 	return 0;
 }
 
+#if defined(CONFIG_CGROUP_BPF)
+void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
+{
+	struct bpf_sock_ops_kern sock_ops;
+
+	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
+	sock_ops.op = op;
+	sock_ops.is_fullsock = 1;
+	sock_ops.sk = sk;
+	bpf_skops_init_skb(&sock_ops, skb, 0);
+	__cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
+}
+#endif
+
 void sock_set_keepalive(struct sock *sk)
 {
 	lock_sock(sk);
-- 
2.43.5


