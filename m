Return-Path: <bpf+bounces-49935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E9CA20674
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 09:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94CF3188A732
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 08:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A501DF748;
	Tue, 28 Jan 2025 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ho6FYe5u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227631DF73D;
	Tue, 28 Jan 2025 08:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738054019; cv=none; b=P/PtyvlGGicH7huW68aB/IFQrOM18T69MqQZMInKIsv28aHdRhh1oz04Nzh7W/kRSBFe1o6DxFQ7mJ+dN36QtDHcq2eSgxFnGsjPwMDnaPmvPktekjMMsmubozSgIy44vrl1LzMEmNZ/yBWaCqzCu7nuiDCrFSmDDRop6xIK5LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738054019; c=relaxed/simple;
	bh=6gjefGTlSgHBj050nZsylf4QqygtaEzfR2BlPPxYz58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nr1HTlCKOW9T2TDAZXEGAa6EWtxC69oXVAqePrMwHq25YBr2QAoTDYyaEzHyrM/dm/IRHjMCE4nzqnhEIqSusSutRlE/AYn/UcinHPEIJvt7i2PO/yMVguowfPvN7WXE4VTs7wJ0Eut9LRTtpQQGOibFD108kuRYMuBctZBzfP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ho6FYe5u; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21670dce0a7so111644805ad.1;
        Tue, 28 Jan 2025 00:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738054017; x=1738658817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edPp/qi7ns9gzyrhgsfr5YC2VgBldDClUoe6GDZO/bk=;
        b=ho6FYe5uoGbPozDHa+dZvteLE53oAwqCcW2dRO14Bo7V+gCMlz+i6TuqFcySJ/vsyP
         eWqUae2zTHJ5NuvL78wP1hszdvWLbdUA4sZdRdJXEFjX6Sm5B5S98dWkOKiFuwoM3P9T
         DVjAgjQI/VqlInojBMdcWOr+nlI9SrnVBjH+wPVVcFJRsPJ+YEQA8mZQ5V6bslgM21Fw
         Zn69rA7CPMBvzUsjLXBwzMOBXuJ8z28zavAhZzXln3H7ECq4mcujL2RHn8RnyqxKYOpZ
         /edHnr/rNFDloBaw60h4a7jg3Qq+ACEIiZZ0VHqJvtart1+W83EVE0JjfQm0U3WlTl1e
         rLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738054017; x=1738658817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edPp/qi7ns9gzyrhgsfr5YC2VgBldDClUoe6GDZO/bk=;
        b=P/Gj6as32cYyEOwOgjHq/gt9JnqEk0IEA/s4dbWinRhCAbAzTBVLAIHHW8mFlDOd8i
         fkdzXR0WRxH/xGRdBMck7aqz9XdoIw9lgsiUaqlYtAIeAr+vKR71VDrL4beLK6h2ZiQd
         Reu+Yai8m+uDNYbqA1Qflv6qqpdwwTVLD74wO8d3xS/oC6QkiNfzndvQubpWEm5b+LW/
         tlQEQ5rvF8K2PTQ0KSvC7dGCP+XwuavIehNJb/idLwoobjJvTVuyFV/ZOwO3T7HJz+WG
         /3pK+DFdSKLp7yKAzovFFUrOn2urUTt1jghvC9qYthICddTblWH+qkozC/5MHaX/qYvB
         Of2A==
X-Forwarded-Encrypted: i=1; AJvYcCXc2venDYkjR0zUZ0TPb6mLQnL5xJbnDM8EccjAsfL8YmQNNgHbhYY0qETot/TwDe3dR18MA08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC0+dP911pzHjMOTqcfL7sURooLqBO07pLkBZTWltaNUhk5ZHo
	6UD/JBtPJpNwVhKbEwB2rnbXpUTJKLk8PNX65bI4VXVOLLoNVBzn
X-Gm-Gg: ASbGnctHjGeIWsWGKlQ+NKD0NHwjv6nlFfmpDTAIf0GUdNusiOwJ4P4Bow2JHo1pnsr
	xjs1hPMnRoEebfTRwNPqYhN/ycfJiJpwJWpivDrvn5nSA3f0b/n9ELxckWzfLBrOsyT4YjOxcUU
	QKZ9Xk4M5GRXv29YKBGRhzdFpoldnkkrdD6fCM+iDS9OlXyd4Iq+6CX8XnpD5JVpvgU4mhdqhcR
	8KPVCpvlwCpLhczpn5ICwiPieAi1ZqS2RNlR65iM1ApMzaYzmWhJrn+laLhp5zbL1CDXhCF9Jnp
	6OOvNmoCYgHHV4k/0bKPRm+ae8btHksn50jaWVLp/BwUiOW1OTYIsQ==
X-Google-Smtp-Source: AGHT+IGqOP6e5eDSV1c9md94CzB6589bQXmg3JQW6RzNab63CO5tgoesB3YFSvcefl/J193jWpWlTA==
X-Received: by 2002:a17:902:d4c4:b0:216:55a1:35a with SMTP id d9443c01a7336-21c3558bef3mr586256735ad.30.1738054017268;
        Tue, 28 Jan 2025 00:46:57 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414e2b8sm75873275ad.205.2025.01.28.00.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 00:46:56 -0800 (PST)
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
Subject: [PATCH bpf-next v7 04/13] bpf: stop calling some sock_op BPF CALLs in new timestamping callbacks
Date: Tue, 28 Jan 2025 16:46:11 +0800
Message-Id: <20250128084620.57547-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250128084620.57547-1-kerneljasonxing@gmail.com>
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
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

Besides, In the next round, we will support the UDP proto for
SO_TIMESTAMPING bpf extension, so we need to ensure there is no
safety problem, which is usually caused by UDP socket trying to
access TCP fields.

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


