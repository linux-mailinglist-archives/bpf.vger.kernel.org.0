Return-Path: <bpf+bounces-52051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2517A3D24B
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 08:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83593B62B3
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 07:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521EB1E990A;
	Thu, 20 Feb 2025 07:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8a/h7OZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7185F25760;
	Thu, 20 Feb 2025 07:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036615; cv=none; b=l0mxE02+zSW10/Mj2cG1W9rp5k7+lBTW48Gpwp7ye5zmoFCVZU49NrtcMCvB0GJhcInR0KN+865B2aAFQIdAJr5HqGi5zmsse5UEIMvLYThRCkT3lZmikjHCrWFq2cdazkVtrl/M+MhrB0i6TQoBRVsM7zCXp9+tiaOicBTtRO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036615; c=relaxed/simple;
	bh=3f4fr3wEVqOkIsOc+1STd0Ns5iBgLGFkFca2uJbMweM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gYDkAVhww8oX+jNyDep5mh80F2UJFpKcrx5h/oq0aXmhEcydr+KFU8mPXUJ4Ku2zYWRnQX5XPjaSlIszd4BAa39h0cwDioAsI2pJ7Z+ujKRSWkFoLz/PIgJ9Yp/LdPNT4MYfC7CcCd6IkuMpj8juprWe1mizXfgpgYaskOXq0ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8a/h7OZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22100006bc8so9491545ad.0;
        Wed, 19 Feb 2025 23:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740036614; x=1740641414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jcgdad4TkftRTh1q65WudnE3mEROlme3+Pzdel+ZVs=;
        b=h8a/h7OZcGbbsOdNJaWxOu952EsyqUasjHkvW2uifUC+CBDslDUd9J6mDzmKd3b1cX
         iQY39gjo4IT+ITQoNkNfjxvJTYgN9HRqvBiEIj4BNudDXkP0hfDn+/1ke2mRikRYwuVQ
         t2OZiJlxSqyuhWXNPy5bnyZuYC/czZFnzbGOEk8Zfh1qpzP2JXO2NP6YK3vHUtvpa+ZH
         D7L5eotoqSgyLCZ9wIR3dVImy3KtkDR+hGmLXXWKK+yFnh2E+hhY6HF0t/kF9Nhhmsjs
         VH9wxSYExyMn7uFtGmL2QnRnGh58Uy1vGTpQfDF1POq2Vfizl9xIFc4rSwgCp/1LhAtw
         EOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740036614; x=1740641414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jcgdad4TkftRTh1q65WudnE3mEROlme3+Pzdel+ZVs=;
        b=JbDy4PptxyGecn84CERtHDqJah/tBgY0UZNhnZWXAwQQcAK269wTFFzXU0i3GxDrZQ
         kB5ZWrfWccK9AirZR1Mtpo6IFmUq876upchXVArEwrDz+MDay9t4BlobPqW1tgamMJBS
         5v+x5l+E25T5hvUE+bUl5PehAH0/tzJsGW03QMX3DfpQKDAG7oGitc0et0E95OqZ/l1f
         xmhutFM6plbbZ2vdo9hMsEk1ArB0LigLDbdTv0wUaPrs5WgBnTn7caif7KgqVYDrjLUS
         0Z5Np2Cf37k1Au3J+0R4q7T5xstl7CEVJumSQFCT8rvoHiPonk/KfWHh6hycfubLuiOl
         Hy2A==
X-Forwarded-Encrypted: i=1; AJvYcCVOBF3HicEpDn1WSkGz0SzfMLb0oXo2hzGhjyYy0evsrpxE7dRTJV/CZ9zM/471pI6aXtnoVNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDQBJNG8cRQOJ5Fv26k52G2+1JdJ7kqOgNxeLeMx549CROZlOS
	XDWWY3a72vOpiRb7ZPp+ck7GP8yKW7/PpyOFj9SvIUrcM8KbkE4O
X-Gm-Gg: ASbGncvLM6MxoDpYVmPXZTiLM/K8lQCd7xCKbqKEzsE6+yibxHb8XfLJKLAjmwnHyuv
	wtHz/WXpzs+e4Z1+NizgSlobnoQ9i60W6Eh6oQNiOQPGi18m1WrcAsO5VuG2qqVFCLZInqCaXPZ
	2pAu2vYAJYaOhGcurqBY8QFtLV1GhQqC5W2Y88RCIINvJs17nnu1moLsjXn6G96v0A1rdDguGXl
	zoD9eEqIU83HPud2JZAecNKd9BPinTfejtcM9Gz41d2D8iNbcVQmdBxhbXrk9VCNq57sFLPShZw
	/I3w86JFiAe8UhNYPv8JV6e1BsOfxk6s2aP8d8U+KbQEr/fhsB5xi1Vlb4elAhE=
X-Google-Smtp-Source: AGHT+IEvDjZK4i9Zp7obJtYIKJ0SIe5pUWNSGsNurKhmAeicUEQHZGzXF7RW+UNqOFBG4ScLVrodww==
X-Received: by 2002:a17:903:41c3:b0:21f:7821:55b6 with SMTP id d9443c01a7336-22104030832mr316654115ad.13.1740036613697;
        Wed, 19 Feb 2025 23:30:13 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d643sm114048205ad.126.2025.02.19.23.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:30:13 -0800 (PST)
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
Subject: [PATCH bpf-next v13 04/12] bpf: disable unsafe helpers in TX timestamping callbacks
Date: Thu, 20 Feb 2025 15:29:32 +0800
Message-Id: <20250220072940.99994-5-kerneljasonxing@gmail.com>
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

New TX timestamping sock_ops callbacks will be added in the
subsequent patch. Some of the existing BPF helpers will not
be safe to be used in the TX timestamping callbacks.

The bpf_sock_ops_setsockopt, bpf_sock_ops_getsockopt, and
bpf_sock_ops_cb_flags_set require owning the sock lock. TX
timestamping callbacks will not own the lock.

The bpf_sock_ops_load_hdr_opt needs the skb->data pointing
to the TCP header. This will not be true in the TX timestamping
callbacks.

At the beginning of these helpers, this patch checks the
bpf_sock->op to ensure these helpers are used by the existing
sock_ops callbacks only.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/core/filter.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 8631036f6b64..7f56d0bbeb00 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5523,6 +5523,11 @@ static int __bpf_setsockopt(struct sock *sk, int level, int optname,
 	return -EINVAL;
 }
 
+static bool is_locked_tcp_sock_ops(struct bpf_sock_ops_kern *bpf_sock)
+{
+	return bpf_sock->op <= BPF_SOCK_OPS_WRITE_HDR_OPT_CB;
+}
+
 static int _bpf_setsockopt(struct sock *sk, int level, int optname,
 			   char *optval, int optlen)
 {
@@ -5673,6 +5678,9 @@ static const struct bpf_func_proto bpf_sock_addr_getsockopt_proto = {
 BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
 	   int, level, int, optname, char *, optval, int, optlen)
 {
+	if (!is_locked_tcp_sock_ops(bpf_sock))
+		return -EOPNOTSUPP;
+
 	return _bpf_setsockopt(bpf_sock->sk, level, optname, optval, optlen);
 }
 
@@ -5758,6 +5766,9 @@ static int bpf_sock_ops_get_syn(struct bpf_sock_ops_kern *bpf_sock,
 BPF_CALL_5(bpf_sock_ops_getsockopt, struct bpf_sock_ops_kern *, bpf_sock,
 	   int, level, int, optname, char *, optval, int, optlen)
 {
+	if (!is_locked_tcp_sock_ops(bpf_sock))
+		return -EOPNOTSUPP;
+
 	if (IS_ENABLED(CONFIG_INET) && level == SOL_TCP &&
 	    optname >= TCP_BPF_SYN && optname <= TCP_BPF_SYN_MAC) {
 		int ret, copy_len = 0;
@@ -5800,6 +5811,9 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_sock,
 	struct sock *sk = bpf_sock->sk;
 	int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
 
+	if (!is_locked_tcp_sock_ops(bpf_sock))
+		return -EOPNOTSUPP;
+
 	if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
 		return -EINVAL;
 
@@ -7609,6 +7623,9 @@ BPF_CALL_4(bpf_sock_ops_load_hdr_opt, struct bpf_sock_ops_kern *, bpf_sock,
 	u8 search_kind, search_len, copy_len, magic_len;
 	int ret;
 
+	if (!is_locked_tcp_sock_ops(bpf_sock))
+		return -EOPNOTSUPP;
+
 	/* 2 byte is the minimal option len except TCPOPT_NOP and
 	 * TCPOPT_EOL which are useless for the bpf prog to learn
 	 * and this helper disallow loading them also.
-- 
2.43.5


