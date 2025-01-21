Return-Path: <bpf+bounces-49316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C311A175AE
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 02:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADCF27A29EA
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 01:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7AA1465A1;
	Tue, 21 Jan 2025 01:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJ7vohYJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097562581;
	Tue, 21 Jan 2025 01:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737422965; cv=none; b=fKUrREX7JkZPW/aUGRGu4NC5Df0OVVP1e9BSV5x20xGpRkxQDcoP7qATXiFytuBIFf+IOYtL820pIf0P9f8MMznWSrImEkDvCSM556yGbbdr5aONR+vbZCgd3dbi+HM5Akl0XORTjMPJlLoirOp2k4VJC25l92J14QdeB27y0dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737422965; c=relaxed/simple;
	bh=3D6CTiqb/f70GuSUwpWkXCXGc4XWIghQE63JycIPQH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q9JHclfx6ewcU3CC4AdXOsEMI67jh27foAANJsa6V9q2ze+pp6ESBaRYQBLlOo8ITvGr2V34I2+3394nY419zUbHvxLyK18ja70xUsGMCojkAWGsCna3zdOF+T1c0m69kiCiccdqa8W+tVGwrNblHiaBg9sk0LaefmqFJ+VV2R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJ7vohYJ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ee86a1a92dso6957707a91.1;
        Mon, 20 Jan 2025 17:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737422962; x=1738027762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkstOM3ja7v2blKf63dQgeE3MsZLse2qrlDmnXc41uQ=;
        b=QJ7vohYJZffbnP2Hhy8PZXv1na5SgAQntU+NpH3/OGlj/9K7+yNnoDoYKeljH9aUbA
         F+l8Ht+uxgnH3lRmM9LwdDwCWvnlZKNWSKaamGVSmCiy9wXtHxbzHK7YL4Fw1j3/yaFx
         IVAMIgpxMgOM6UNiFYtEqx6nS8kHY66HAP+Qqa6RFhj2xLlWQQFChKz1SZVn4W6PJomM
         tBHS4foLqxWNkbGW/4Dshfc3hbNURY0D1zzVOEhtDA3ocRyp9d4+JwHmduHQIKf0vrNy
         fBhIeKdyWQ/ZMe+G50S9JPTCS5963BmHhDh2ijICv4sU6KpaRK/zg/R8UoJBzqapQvsq
         pMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737422962; x=1738027762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkstOM3ja7v2blKf63dQgeE3MsZLse2qrlDmnXc41uQ=;
        b=PPpwzoc4JD+mpIeL9hPlvJYRRwMUL9Z22SZCSh4YO9F2IHekOZ12jIqMODQTEv5z1n
         iEilrtpIvozSxOk4Y6TvURVD9rXP++laPmV6hDsWB/t9C3/ylYnY8Hcf84/wOzDXDX7L
         AyWWP1kIs6cc2MhmGsV5fQV2fmLD/wIarwV9IicpUd2sqCJlkRmPHSPpl9DLU2SUhoHD
         jbeSkx6w7eeghWJMCjaphcpmr0tMH0tjsZ9PcCPPPtME57lNKMvcrmLGVfdJI04A7+xb
         Vrpg0Q8YiF6BS5ryJ/HIpCWoLY7FoX13nl1mlTwKIOiECqks4KmuEH/KzCJEqZUA3uY7
         FBYA==
X-Forwarded-Encrypted: i=1; AJvYcCUaCFtA2x91NHhppBFffzjtrLqN6q2mRKgnLIzXa5dK1cZUQhFJ0NJfhwUl5kZiJJYaAxzdJmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdVpXEX5bUM8B8ACRbbWlGRhs1oetxdZ/UiWvVZ2xIXwIcsck5
	uW0lRMEheUbCF6NNSbZJhvThG+9gIzw97D+XyX1et8cw43lyNq2N
X-Gm-Gg: ASbGncvrxbrADtouydW0WM3UH6b1chGOFxjI4R1LyCtxv/Fm49ckyva37AmQfDYHsRn
	5seSN1oMkngqSCB3RAHzFEmjB3R2bzpY7/Io27OgSF92f5tCi8YeI/OAy3NocK81bNcPrNIL/93
	5WGvQQebaTEmcO5OHK9Kfp9BjAHPVQz/x8vYJYXVoYl8qkpDlgOU6wRkG5PSQuLiruErvHospgM
	ahk0e/qbtZnhdg4QR5BGdp6vC2YTi0TcJ62Rrn5eWs07s20zfS3iz2M6L8WraVG+E9h0k/gDLd3
	E6aT5WUqt0cDnfAjylpQUqZkXFXrDFt9
X-Google-Smtp-Source: AGHT+IGeDXkYW3fQISiYo51Qyam3GIbnaV13t/hEAugsGS4mdyuWyKZEVj+uLCmwSTWCNKPoirQ+Vw==
X-Received: by 2002:a05:6a00:418d:b0:71e:21:d2d8 with SMTP id d2e1a72fcca58-72daf946789mr23181257b3a.7.1737422962285;
        Mon, 20 Jan 2025 17:29:22 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba55c13sm7702059b3a.129.2025.01.20.17.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 17:29:21 -0800 (PST)
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
Subject: [RFC PATCH net-next v6 02/13] net-timestamp: prepare for timestamping callbacks use
Date: Tue, 21 Jan 2025 09:28:50 +0800
Message-Id: <20250121012901.87763-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250121012901.87763-1-kerneljasonxing@gmail.com>
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Later, I would introduce four callback points to report information
to user space based on this patch.

As to skb initialization here, people can follow these three steps
as below to fetch the shared info from the exported skb in the bpf
prog:
1. skops_kern = bpf_cast_to_kern_ctx(skops);
2. skb = skops_kern->skb;
3. shinfo = bpf_core_cast(skb->head + skb->end, struct skb_shared_info);

More details can be seen in the last selftest patch of the series.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/net/sock.h |  7 +++++++
 net/core/sock.c    | 13 +++++++++++++
 2 files changed, 20 insertions(+)

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
index eae2ae70a2e0..e165163521dc 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -948,6 +948,19 @@ int sock_set_timestamping(struct sock *sk, int optname,
 	return 0;
 }
 
+void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
+{
+	struct bpf_sock_ops_kern sock_ops;
+
+	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
+	sock_ops.op = op;
+	sock_ops.is_fullsock = 1;
+	sock_ops.sk = sk;
+	bpf_skops_init_skb(&sock_ops, skb, 0);
+	/* Timestamping bpf extension supports only TCP and UDP full socket */
+	__cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
+}
+
 void sock_set_keepalive(struct sock *sk)
 {
 	lock_sock(sk);
-- 
2.43.5


