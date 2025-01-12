Return-Path: <bpf+bounces-48641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 858DDA0A897
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 12:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77676166F8F
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 11:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7BA192593;
	Sun, 12 Jan 2025 11:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lihdHBJ0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE901ABED7;
	Sun, 12 Jan 2025 11:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736681890; cv=none; b=qomCeKFVIhfEOLIMmzDsG9Xh0o1MwVgliTlwzd+y1iCblq0Q9IdhnjyjjlSAKN8c6sQT9yqf4Qd2nG3mr1eGITJG1EkXD49AKjvXW9wRzb4bycoKkuQb3SGLEUvnuOpC49BxDgMWPG4E4uj1sE+ViEw6P+YN1+PWpfde7qcbKTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736681890; c=relaxed/simple;
	bh=2E1HF5NoSftlEAMfDZsNHqTJ/VktwpLAYvS4z1o1KuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P+jJxxA3VGTkai/EVsbjFEDNTwyoJsN9Y8NEBEMBk0YeuKZT5qOybytjJnAYs4Zr4GN4dXCLvmQ6QvtydgeDqLZUZUma2YD0hY8YCQEEQ1MZHAgYq0jnR0uXkOjWHRO5Wre24HTPXFKx0aTxrGsEee3wwo5+8JxMrVCYjRaRgIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lihdHBJ0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2161eb95317so57556055ad.1;
        Sun, 12 Jan 2025 03:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736681888; x=1737286688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjV/MKlqBN/wrwWo9g3ip9U4q0fvIKgRwsUvfhkt65w=;
        b=lihdHBJ0SekYR4pRUkMjS9tkiBb27zfEUs4MgwIb6GH5orMMbtVK3aoq0EeGnwrN5z
         mMFvsBxlA43aGwvAuBGNwiuZRoYmtgWnk2SxO8LQxU8JztL3bi6Swe5ZjywNtunIPfoS
         W7H3VWBuxKwXw7mtVH0OdLT5Y7Om+OAu8iuzYmG7VfcSa8dBkyNhBerI/6rKKVeAmTv+
         naim1rtSvFY55qsis+NbDlwEXwOS8cAgY9sIvHhmuMXFjK7+RhZCRK3oLaixfCs6e5Bd
         Yp+xK4neu3xwTlOeRRqAYWUVpDwAetqZ+XGrNpQH8d6+YOkM+J1DHDixjT9kjXZjgbzI
         iikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736681888; x=1737286688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjV/MKlqBN/wrwWo9g3ip9U4q0fvIKgRwsUvfhkt65w=;
        b=PphnIrexEApx1eoOt9qdrWGJiWLhpTBKrocIeIv8Cg8F4c3aqYqiaP5r/+KqByLycy
         cCkRk+WGBl+BfmCrvC/H6Vcn/eSxxmRcWEkEA8hKdJZvbuXIQTp1HQuvFy/aI7TuqpwE
         ii0vnZvfQwN/G3vcejjJciOgBq7MffhsGc4XjlzZXwdsS+v+Kazs9bsHxRZPaqsmn2sn
         VnDkYczh88dKeWHBsEm3tgpjyJqasdlNARrU77i7d9V6QT64kwqRL0j9Dgp9q1bg8Ujm
         v+S2Wd+fONFn5xTF0R9Sfzd6nXeqcAOmG6AAq/GsiHHheLbQN8WPJq4xBibXsz1yM/Kc
         F3TA==
X-Forwarded-Encrypted: i=1; AJvYcCWapjYaed2kvVzUXQGexrK+NKTZRknCznUqA0AzETRwBy3LdKEURPDyyW8veHbXjnbtGDQjKjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7oKuB6fC1Fqrp8Qw4aF3V5IDqQKjNFKRqExfxD0u27zhoNSzo
	fziXhQdWFzQM0uLuhh61FqLT/5gJiH3A3eBLg6eUQp7pakU18UrjHLbLs2J8
X-Gm-Gg: ASbGncu8vCsVMgP8hDXKxP4i5LqP0XgN8e2ytkgpS9qU6V4Vum+2ayrDZbjhoc3p/7Q
	EsfyEWfVzOoLxG5a3SHvX4zl5adr/AjMcaxH2D1NArEWPmEShrVbR5Kxxn+qTdY53CHqlDWruIu
	D205Q4PmupWwKNWtTX54rKt4IbLQoIyjKxUoQ/XdUPvP6Q+RdFi/shsYPJp3xBa1kwb/cZzoFPa
	Ish9z27q1Ze3OLOegtX4njbeqr8U99PSGDLqzTeoH5549TA9xALQcFPjuz5wAe4XkVWGyVcBmfa
	6IOsO47kCs/94ki+8Wc=
X-Google-Smtp-Source: AGHT+IEkaO35tFCtA7EY3tdzwp4B4RMJfH6AKYAwan1RTf1DX1SiDrGukRkmbCkd3f40hNsVb3SHdA==
X-Received: by 2002:a17:903:178f:b0:216:84e9:d334 with SMTP id d9443c01a7336-21a83f767e2mr229727025ad.33.1736681888191;
        Sun, 12 Jan 2025 03:38:08 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f253a98sm37353765ad.224.2025.01.12.03.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 03:38:07 -0800 (PST)
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
	horms@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net-next v5 02/15] net-timestamp: prepare for bpf prog use
Date: Sun, 12 Jan 2025 19:37:35 +0800
Message-Id: <20250112113748.73504-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250112113748.73504-1-kerneljasonxing@gmail.com>
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Later, I would introduce three points to report some information
to user space based on this.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/net/sock.h |  7 +++++++
 net/core/sock.c    | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index f5447b4b78fd..dd874e8337c0 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2930,6 +2930,13 @@ int sock_set_timestamping(struct sock *sk, int optname,
 			  struct so_timestamping timestamping);
 
 void sock_enable_timestamps(struct sock *sk);
+#if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_SYSCALL)
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
index eae2ae70a2e0..e06bcafb1b2d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -948,6 +948,20 @@ int sock_set_timestamping(struct sock *sk, int optname,
 	return 0;
 }
 
+#if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_SYSCALL)
+void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
+{
+	struct bpf_sock_ops_kern sock_ops;
+
+	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
+	sock_ops.op = op;
+	if (sk_is_tcp(sk) && sk_fullsock(sk))
+		sock_ops.is_fullsock = 1;
+	sock_ops.sk = sk;
+	__cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
+}
+#endif
+
 void sock_set_keepalive(struct sock *sk)
 {
 	lock_sock(sk);
-- 
2.43.5


