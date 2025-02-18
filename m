Return-Path: <bpf+bounces-51802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B850A3924B
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 06:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 724347A1317
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 05:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171131B0406;
	Tue, 18 Feb 2025 05:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kET4Ngg6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED6AECF;
	Tue, 18 Feb 2025 05:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739854949; cv=none; b=ib9lQZqt2hiAPYRAGlDfvHk9bhTYnFPp62u7KwMvT61jzG7FQlNm/cx/RNmSpj3HkjupL2dri1LIntMcoPk5b6GOKZjq9dK4VyFlOC5Q93vstJ79N8aAPJupHAF/iWZk6UkEDBWrfU0LsXYQ0hLcXOnXA38QZuDHUwC2WgwJNqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739854949; c=relaxed/simple;
	bh=3f4fr3wEVqOkIsOc+1STd0Ns5iBgLGFkFca2uJbMweM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ff0hGcYOavJUQifRWv0RqKGL9N6kii3SPGfKS/yP6KuG1FbYxi0beOJiEN/NKGdAEINIaGbXPPp0flQntDDtpWGH6rZ8o8vL+LM2ngZuU2/czk11G+C8U30Mmxt9/8bWxpTGnr52skuFNwVDFYBkdFjciAMLATB4NhPllMM29pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kET4Ngg6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22101839807so60018265ad.3;
        Mon, 17 Feb 2025 21:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739854947; x=1740459747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jcgdad4TkftRTh1q65WudnE3mEROlme3+Pzdel+ZVs=;
        b=kET4Ngg6A00p2M0ibwTCCWGHPHWqzQwrySLgJ+oXH+hJdsGMxUu1lMtznP6+jvP4d4
         We4d/fbPaMy2W7nStqCpJltvLGmW894n7osSStuqV4lpOxD9MilE72+ShwGDPvs0Dj1e
         VpgO4/xI5oV9ItLpkHQWDCbzCOGFd5XZKrfsyFR9zh/qvvvdiodjG3TjRxPKh/T1PaHd
         OiY3ruCX5C4whmWtOOs244UVf7YZzWJBnyUi5t+z7AWDWuCFg/tADHd01ok2l4mdCVnl
         HreFCqyByz3HWgcVPpTR0GlDVA6aL9X2sYGt8S/y55XR5vOWR6VpGXPIyNLpFS949X64
         7MYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739854947; x=1740459747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jcgdad4TkftRTh1q65WudnE3mEROlme3+Pzdel+ZVs=;
        b=dmxNJ9ZksVI9v3EOov3fhbbo/qjP3iB6S5yEYB+dS/z7kvp3RSirqRpH5NqTNpDTtj
         oTgwMufpwYyk7ZiasrjirMQOmmuveTPnVztQN/TD/fN/uWLuTC7f28dzKEpyA3FcTfv+
         5sztn8B7pT6ITX0fc5yOiBgZcQkoQ26cFPTvwDN5o+Rxc6/wp4D40rbD08W6te0MonpC
         Ox2+toAG8oZI1OongjS2An3TfZkUcdKeczpQ/fHdcJG1T/cGwUqbMa8DdBe4lBQWKnWX
         jOL1tmqCg2rhwsLCvVKp2wscxdyv8BZvAuEObf1VNwcUwo8RFJWU5SnehVYjBMQPzrpf
         gFNg==
X-Forwarded-Encrypted: i=1; AJvYcCWtEaJmhdQcKrix4DTdm/MOfd3dx9MpioSn1enSx0uvYgeItq/VANVk3p1yjrgpQxzTc0J76xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVEPXna3EWqmK10mokG8rRHrWEcIt8r3ITqb0yr+9xqGtdFzAH
	bgXPqYXArkRfDzITvrOmJwQYpGbTXrGGUmqYCtcOLYXemu26viSVde91no9TS4ZCcg==
X-Gm-Gg: ASbGncsv9VLlSGYk4pOd7Gp//9l3EouhHjlTKEpvr93OnCUs6QJJJn9OuHDBPpwqcnZ
	2uIrbK8gULUWBbyiFlsIgv3LttNYx1NwQARQcG0cP4LuhA/KGAiHQxIFocVZqEaqZCtFu+dFWS7
	2ORMj83iQQwo7CLXQyfjdcED41iuFCA1/M2I2eq+oR145TflhWBPIzyJomK6r+cBtioiVCTz9T1
	xhHUjl/qDyn8kgGzqezTXpAJtfQaX5DHVD9ZLnZ+OETExz/07bCq9EfI76TvuoJBfiu6e5lOppz
	wGdpZVEwZkyIiMDYKaTi87CyWpjSk9EtvR91Vzf8OczmbXmTfybA38cU+/ErfFo=
X-Google-Smtp-Source: AGHT+IGDlDQtZ2/iCjhv8oUTNh8upPD6clzP6SkxIJRB0Kv9p9JbKOPeLrkNgWpE8H3l9IrFrx8inw==
X-Received: by 2002:a05:6a21:3994:b0:1ee:6e65:6335 with SMTP id adf61e73a8af0-1ee8cbbd682mr25774380637.29.1739854947482;
        Mon, 17 Feb 2025 21:02:27 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adda5be52f1sm4337938a12.34.2025.02.17.21.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 21:02:27 -0800 (PST)
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
Subject: [PATCH bpf-next v12 04/12] bpf: disable unsafe helpers in TX timestamping callbacks
Date: Tue, 18 Feb 2025 13:01:17 +0800
Message-Id: <20250218050125.73676-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250218050125.73676-1-kerneljasonxing@gmail.com>
References: <20250218050125.73676-1-kerneljasonxing@gmail.com>
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


