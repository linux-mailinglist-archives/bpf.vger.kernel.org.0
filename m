Return-Path: <bpf+bounces-50443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C51B4A279CB
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 19:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72DBB1882869
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 18:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAC5217737;
	Tue,  4 Feb 2025 18:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQXTbaCs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E1D213E81;
	Tue,  4 Feb 2025 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738693858; cv=none; b=PtoB3N4Nn8WfWFjVLo8xWdXpA4IFbeD9w13FXv3lgUQAOuWS/bzAIqlkwzB8fFqwAmyaqj8h+vUiVtfrjnECoJIdcqoRXtE+kRhhCKMULU3/r5OAUwa/LLVfDM+u4QP7s303QiqLAV9DZQdqfEdb/MApvY21Q8pJOieP4Df3gGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738693858; c=relaxed/simple;
	bh=oWTFfmKtbyAyYXnxvSxqnwP/ldGMDUrwHrs6elTSBzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FEhrWjO8QJ151lIqg71I0IO42wEgRyTs0mYKAVeQ8jzug+aBm13pu3QbdsTxU+fEyAh+naO4viasFxt9gm8JchTGgDuoBtpUUmECLwNkQeVF/gVPt9JzGKqsYa+3TuP65HQIfDsosi2WCcfLzJKTm84gy1veXZf84q5mk5SRcSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQXTbaCs; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f9bed1f521so1778786a91.3;
        Tue, 04 Feb 2025 10:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738693856; x=1739298656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGxPdzXVoeHm3LgeydHUwfPaVQIbeImRWqiQNcBnypA=;
        b=XQXTbaCsWnAmayjnmsFn9Q28ArDlgVQNwTK9a387STBji9VnwIy2o+wL50Z11yFYTo
         BlgVrckA4atH/qFK5m/SmPYJ3TOhrRKZiJuwdl8y4r2iaWt3AnDa74hHiV75u3yGMGXV
         EC0h+3E6LO9BGiD38ERVYqLkgYVfJ0oAHvDkj7Th1gBpwMyoQ4ZutlYHhqFbs08PhBWF
         slrnQBMdAmA8lEyL7bUxjePBHdAqNJOW54OMjy1K5BHBSSybRToRzaJzg0eH3fXZZXj8
         +WVT2VaVmwTMMoPdUjFHEts7f0IsbqZovn1RpbDh1+MSANmcfHTX34fHIyy1P2rirlOw
         L96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738693856; x=1739298656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGxPdzXVoeHm3LgeydHUwfPaVQIbeImRWqiQNcBnypA=;
        b=gS1U3GPheJBYyAeqOzg6rg6HU3rVvcT4kmsyRot9p5wib57cMITmR6+ib+fvNsDjup
         XRkX8lppEbc7z5B2a0tlfO9PVhdInCXEui8tXxIxBFtPy1RiXo5a+Fw/7yCH922L0Zzl
         Y6QZ7Tjc0F/hVzLOx9qcoc/+9OhnFi296sV6qrw/LMhrEVsnbh0YWmUq1/zZN4/N/g97
         67yb2kSPSHvc2uaEZL3TO+2RVtNdra2E2f9sPimt3pEwy/IEIwtYs4uMmnRgOzCMBkgJ
         AH4s9D0x1exNhLUa2XObnRiX44I/thwMKXxJx18Fec6kKOyK+uZRk1VPHoP6ks6wyR63
         CEgA==
X-Forwarded-Encrypted: i=1; AJvYcCXh0m8oyGjys1c/0Znm3NJeg0dJgJE7AmH/9vKPzKfg7N3mXxdoXdbLGQLJUP49JESWSSyoklo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaUSsNMh/LJogMUO/4RXAfs8N+iIO8L5reTNpjVWa9rdTqAZs8
	xyDxBklM4fFnsFXvZxIh3XqgbEftjDPeYkiuODEKpLNUGI5i0fdi
X-Gm-Gg: ASbGncsfM+vVrZDCJ98Ghma05Pgoj/3kj5zzuvyu691NvkxiqM1lgeRwLXAn6020l4g
	TgFmJaVM0dcUIqXZOPnlopg+zwsj3uDgQYnIyOBhg2fRQrWoQG6qdljBr0Mt5wZYKv4awlhbuCy
	ZtKjoWewPga3R/UK+m1cKBMqtbKgXCA2Evjz0ef0NSwSkGfwnAb4F6bFh9L8oOrdOTjSLkWIfSG
	QPphj4+oCS4hk7DcWib8HeBgfuTYbTu8a917PESvzlXPYjDLXxqWuSgUt6rByvqzEDx8fDHCccQ
	xJZLT+llw77OIwy5vMwgT26o8AFCoCjEq/AMe/Sk1aOB45iatfp/mA==
X-Google-Smtp-Source: AGHT+IEWZIW6WSrci5N8ZIyiMhnOtrUAg2Ey94ERajOIN5mvRU9aE6Ys5gqDlPqUhFNyBTtD9vsjBw==
X-Received: by 2002:a17:90b:5445:b0:2ee:aa28:79aa with SMTP id 98e67ed59e1d1-2f83abc3161mr36795852a91.6.1738693856041;
        Tue, 04 Feb 2025 10:30:56 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f848a99a45sm11590591a91.38.2025.02.04.10.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 10:30:55 -0800 (PST)
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
Subject: [PATCH bpf-next v8 04/12] bpf: stop calling some sock_op BPF CALLs in new timestamping callbacks
Date: Wed,  5 Feb 2025 02:30:16 +0800
Message-Id: <20250204183024.87508-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250204183024.87508-1-kerneljasonxing@gmail.com>
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simply disallow calling bpf_sock_ops_setsockopt/getsockopt,
bpf_sock_ops_cb_flags_set, and the bpf_sock_ops_load_hdr_opt for
the new timestamping callbacks for the safety consideration.

Besides, In the next round, the UDP proto for SO_TIMESTAMPING bpf
extension will be supported, so there should be no safety problem,
which is usually caused by UDP socket trying to access TCP fields.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/core/filter.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index dc0e67c5776a..d3395ffe058e 100644
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


