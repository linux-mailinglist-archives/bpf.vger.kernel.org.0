Return-Path: <bpf+bounces-46353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D5E9E814A
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 18:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E2918846E8
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 17:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39D514D2A3;
	Sat,  7 Dec 2024 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDV/Wu+u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AC342A9B;
	Sat,  7 Dec 2024 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733593108; cv=none; b=bs4hP/NWQ8rW5/oXqSEBVwsaBN1iFoiC6ZszTYF/kRjr6M0ey2SjZJdr3OywFmECHrJySykYy0PUrknMlzdrw8VX8xV1Tki6ucyLprCmkQ7ZWMZtYdBSX6aoc7E+vdgAqafe9kTfhw2rNU2B+MSvjRZFxMfFawfd7v2wJriFAkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733593108; c=relaxed/simple;
	bh=V4jj7x6v4KwJQoq/YQgjFvIOJ5taHmzW404e5gSPOeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QtB6f8L/R5hk4udGFvAZuwSg7ysTgp7330V7HhUX5Amqxkp+P4eONl/ZWXRE1UnWswQzYdv3FZSbPAt969SaXlSEMZyO4+OnIuyFGi1xmNNrGiyJv+Edm28hpS4FzuOSq+2Aa+If79vMv6orYHg8kOYchBFdxO1XqG91p/kOcos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDV/Wu+u; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ee709715d9so2254493a91.3;
        Sat, 07 Dec 2024 09:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733593105; x=1734197905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6HZTgsAMC2VK600nKcDsphXjwHM5KJTPcd1uNiOZEg=;
        b=MDV/Wu+uZF3Qan7huYs4XHjQ26U+EHb1aNxg7JkCqt8sb8xGk7cjO12wjGC5tRggku
         K+9NtWId4rS7EbgpV7h9WkK9f7bc+lWi+N2rHR6vvvsLyvvm4P0Uhr0W24M8zH9RL4Lw
         If4SgCgfpB2MuVMIvhJz9uwN4ka6bXue4dibNY4ctLgqQmN0bHG6Ay1A/yf/h4ZIw+HZ
         7xrjeutwdpi7QegjeYnGFHH2ov95wWRbZYJdkdGYE0I+Y7WQmiXxYaqgYxocFWjX8DUm
         Sbv6fpjOUWpojEApAPfhlFAvOvVB1V0qYYEtPHWzvCpRkVfgEFUBPSBEjd2AAiuU3EFY
         qImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733593105; x=1734197905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6HZTgsAMC2VK600nKcDsphXjwHM5KJTPcd1uNiOZEg=;
        b=lTsyHI92rOkpyhdFSnkRvo0XiUn3eGwamP9JVHO/vfZVHfoSfSnX5WzFhVVcOqeXbN
         C60OHUcH3N45v61GR1jh7rM1M4Vz3/tPEgLLHnmZ0PbsrjJ9Xr9ne0YiYnvTzESYSvi8
         KCiaTZl3AR+iNiQXPNzX1p9bNOQeELUoyPjM9WitzTvbqQXblfaIXiM9UtXbDD/FTvfj
         J7xW/JAXQT7sxJ59UaEMTY5x0kfHBGKmVWy3juJ9IDd5+6GENeH422geb4kxK+aK2BVt
         98XauUx3u+2r7Txl4RnxzSWr36EtTHV4j6G9azJPhHJlqbM3aDmFm96qcb0Qjlk5ar34
         Hkgg==
X-Forwarded-Encrypted: i=1; AJvYcCWBFPC4o0rgiufD1g5859ShJpwK8nk/JBNnO8znHbeqXLzJJ7cwP/FL1tLv4/ZJkQxvbos3fGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMMLjPvyByxgaoE1n8SXAyT6q1444D2v2Odi8m7ZB0BPdu24+N
	xtJ7VNCXfALWx9rO5s+FJern4CK4PvtFjG4ABCvmDkKwuRFiDHGaf8pBYYqZ3DE=
X-Gm-Gg: ASbGnctaSEqjmLTh4aYUQ2PrCDZaMzeCVWeAZIWXVdcF1/lzra1c496Y2dKRTfCZvDx
	r1O5ARZwooueapnsNOZPQa7v04nfo2vak+7egLnJMsV4P6JymKpAkG7QzMTc6+uXncjFiMWK6Sd
	oocgBi6IB2zwwUZUrnfmejtDgCh0vUphHk+tPc0FNngACSk/JQZcwT48w3svxXhCcCrvMCmzns1
	Oa6S7krd7ZW6dcWntiVePL3q4KB8/qkGqFFZSErar8XwvLGd2CHLZlQK2u1g3YDF/u9UMV4lxs6
	TplqaG8JKxuL
X-Google-Smtp-Source: AGHT+IFEy/GZ5VYVzA7uLMvYbpp/bCFyfgScSvNRySeK1yimuMN3q/6gSSmmKRur/OdRSlAFyTc8Ew==
X-Received: by 2002:a17:90b:5108:b0:2ee:b83f:f876 with SMTP id 98e67ed59e1d1-2ef6aadb45cmr10447839a91.23.1733593104871;
        Sat, 07 Dec 2024 09:38:24 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2708b807sm6963793a91.43.2024.12.07.09.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 09:38:24 -0800 (PST)
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
Subject: [PATCH net-next v4 02/11] net-timestamp: prepare for bpf prog use
Date: Sun,  8 Dec 2024 01:37:54 +0800
Message-Id: <20241207173803.90744-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241207173803.90744-1-kerneljasonxing@gmail.com>
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Later, I would introduce three points to report some information
to user space based on this.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/sock.h |  7 +++++++
 net/core/sock.c    | 15 +++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 0dd464ba9e46..f88a00108a2f 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2920,6 +2920,13 @@ int sock_set_timestamping(struct sock *sk, int optname,
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
index 74729d20cd00..79cb5c74c76c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -941,6 +941,21 @@ int sock_set_timestamping(struct sock *sk, int optname,
 	return 0;
 }
 
+#if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_SYSCALL)
+void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
+{
+	struct bpf_sock_ops_kern sock_ops;
+
+	sock_owned_by_me(sk);
+
+	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
+	sock_ops.op = op;
+	sock_ops.is_fullsock = 1;
+	sock_ops.sk = sk;
+	__cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
+}
+#endif
+
 void sock_set_keepalive(struct sock *sk)
 {
 	lock_sock(sk);
-- 
2.37.3


