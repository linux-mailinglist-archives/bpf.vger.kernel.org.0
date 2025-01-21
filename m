Return-Path: <bpf+bounces-49318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26316A175B1
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 02:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A318B3A48F4
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 01:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0C413D89D;
	Tue, 21 Jan 2025 01:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DC9nw6Rq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1FCE571;
	Tue, 21 Jan 2025 01:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737422976; cv=none; b=R4fgq4Lm5tjypzOVAdF2UbhSUXVvA/OvACwccT/WPzu2LHfJvItI6xze7DGIj0pNll1GKscFreqRIAVshpl+bB9vn6Hyw2zHgllT7fTKo8Yw81mfLkeOlbY8PxqQBa2oXdwqnAVTAx5PDGbFzBq98JYDJXeMaGffJPbLYfKOo8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737422976; c=relaxed/simple;
	bh=b5dfQu3D8lN/SJ0QMIcSKFAhYjQwLVu/dWkxduUvSb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PCLT/Jgbv1Nb8oAF7y6+etgY3dFwrJQDN92RciztBEhqB9eZQLlEU4VVIWZOMfp6dzeqlzj7UCKc6L2dPapuk4MEjc4WKS/VlwJJ/vgSqS+iO7LsRoP9895Wq8rYLI78FRnE3qZrtkD28maNYfpAGboeqBHmFGgSAYJlYkXWRW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DC9nw6Rq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2164b662090so92272065ad.1;
        Mon, 20 Jan 2025 17:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737422974; x=1738027774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpJD72QRUo+fJ8X6WYMEGLfAIe4PuuokV1Ldl6tQY/4=;
        b=DC9nw6RqBR9gz5JqOy5fzRshF/D5+FoXctgfpGyZIOaJ/KYlEpue9foD/bX3ROnrB0
         P4Li6Is8qYaNL/JaBPWcoHmglHoP+A7H+Wx/msIKTARwVwcvP3eOlL0TZbjtycVcfclO
         bQhoppacHZ8RTJCP7S52kprTY4KwGtEU2ZpDGDrq2YtB8H3fcbrEMJDhkIC51DxjODLQ
         u6qJaW/VArMOiS12PWYKysgLqvgcCYYk7i2OEOyUi45Es5STWjZ2bmmbE2r3sN+Sg9Z8
         2zNqcQWcyqxV+/AYkhLEZpkZgUA1Q4azmQFiGwJvxNVPJ301baurA/2RZbhos/RtL+2B
         YJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737422974; x=1738027774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpJD72QRUo+fJ8X6WYMEGLfAIe4PuuokV1Ldl6tQY/4=;
        b=IloBVdCf+keW1nWUJIIX5BfObEZxp1Bykplzxyq4PqXNr1zAKFs1KZPfYPwj4QVOP+
         jl6xqxnMnuTfjqrh5FTy3rtDGLqcTmLgOXzftukpgKHQvBoiMXFpgvbZ3UaKt2DJ65Oj
         3U+vI3giriYvCvur33sxDabsMCaU1p4Ker25nDO2vMXvK+1Z7eJUUQR6KDWTnAtMH8Zn
         zlqdJE2FZ3BQf1IE4rNCqDdGQ2v4QRf6GO/opfI5FBIt9Y78xbxxfYxfvOen3G5rn6k7
         QWkt/06RiKGME//JjJ8zlCrTbRr+EvVT2qbyiDmI6NkyHhuWpuCyeQWt/Fv8opFeVwSb
         s98g==
X-Forwarded-Encrypted: i=1; AJvYcCWkqWvudtf3rgs/ojO1M7zUzZo384Z/clSCbbm9MzJWu0IOea1hO6/tzzGsWYFQs6QBrI0J0Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1iFtKU5Y69KZO0hfYSbsw+NVf4NN45a1s90MHoMg4BLb/sbal
	Yo6Vuq2Xqyjds0XD4ahR4ApokIQubd/Ts/Sy+EeoC5QG6dIudb1w
X-Gm-Gg: ASbGncv3t5jwSt1oI317AFKsAI+Dx2o1EfkVetywW1sLDVhdlOXsR4tnUDdmL6xEmMT
	SqtLTdXCuw7iQFnCpYDCOlkGnb5+zhSqWy5F7TLvdpMOiaWOjaLCUQZrofBltEwfHnwEOPhsbv5
	6Y8lZIg7FxfPH0R/CpJ/F08bKdS8pJnqqUTQ7k3R5yvYM48F5x4aNbsxkCekPGZWG52HEaJgxHN
	z1YLkvZcgLG7WrJtdmx2u0YEPx2eb52Wu+re2SZnFSLlT0iQmIG0p10b7SW2ptYXcQihBQXn979
	v0HeHHLPy3LQ6Mgh5V8Z0SpheeB0WW4m
X-Google-Smtp-Source: AGHT+IEqKwI2ut26NwGXi0jdbWYonXc2CCHEW8opmVpw5BqnaysKWvMVxbrbEskvyae5G/o9V3B9Ag==
X-Received: by 2002:a05:6a20:12d0:b0:1e0:d837:c929 with SMTP id adf61e73a8af0-1eb2144d329mr21784668637.9.1737422973770;
        Mon, 20 Jan 2025 17:29:33 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba55c13sm7702059b3a.129.2025.01.20.17.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 17:29:33 -0800 (PST)
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
Subject: [RFC PATCH net-next v6 04/13] bpf: stop UDP sock accessing TCP fields in sock_op BPF CALLs
Date: Tue, 21 Jan 2025 09:28:52 +0800
Message-Id: <20250121012901.87763-5-kerneljasonxing@gmail.com>
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

In the next round, we will support the UDP proto for SO_TIMESTAMPING
bpf extension, so we need to ensure there is no safety problem, which
is ususally caused by UDP socket trying to access TCP fields.

These approaches can be categorized into two groups:
1. add TCP protocol check
2. add sock op check

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/core/filter.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index fdd305b4cfbb..934431886876 100644
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
@@ -5673,7 +5678,12 @@ static const struct bpf_func_proto bpf_sock_addr_getsockopt_proto = {
 BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
 	   int, level, int, optname, char *, optval, int, optlen)
 {
-	return _bpf_setsockopt(bpf_sock->sk, level, optname, optval, optlen);
+	struct sock *sk = bpf_sock->sk;
+
+	if (is_locked_tcp_sock_ops(bpf_sock) && sk_fullsock(sk))
+		sock_owned_by_me(sk);
+
+	return __bpf_setsockopt(sk, level, optname, optval, optlen);
 }
 
 static const struct bpf_func_proto bpf_sock_ops_setsockopt_proto = {
@@ -5759,6 +5769,7 @@ BPF_CALL_5(bpf_sock_ops_getsockopt, struct bpf_sock_ops_kern *, bpf_sock,
 	   int, level, int, optname, char *, optval, int, optlen)
 {
 	if (IS_ENABLED(CONFIG_INET) && level == SOL_TCP &&
+	    bpf_sock->sk->sk_protocol == IPPROTO_TCP &&
 	    optname >= TCP_BPF_SYN && optname <= TCP_BPF_SYN_MAC) {
 		int ret, copy_len = 0;
 		const u8 *start;
@@ -5800,7 +5811,8 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_sock,
 	struct sock *sk = bpf_sock->sk;
 	int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
 
-	if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
+	if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk) ||
+	    sk->sk_protocol != IPPROTO_TCP)
 		return -EINVAL;
 
 	tcp_sk(sk)->bpf_sock_ops_cb_flags = val;
@@ -7609,6 +7621,9 @@ BPF_CALL_4(bpf_sock_ops_load_hdr_opt, struct bpf_sock_ops_kern *, bpf_sock,
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


