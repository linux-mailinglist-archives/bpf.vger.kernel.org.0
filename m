Return-Path: <bpf+bounces-50857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44138A2D586
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 11:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5B83AB972
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 10:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83AC1B4155;
	Sat,  8 Feb 2025 10:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HN+UYhqX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6A2192D8E;
	Sat,  8 Feb 2025 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739010772; cv=none; b=PXT4fEyl+yHqBYEZ1InQ5lvglSEOmy+HgXsxKw65telQKfZqbGUg70MqaGc3ny7n8wB1/ltdzpR8zM5+Si8kfTx+7y2EBA5nqrRYGOyT5fjrV0aVhJKbvHzXDoMAXxNjx6Sv1bocJnX1CwOXOPxV9BfaVWqD7Ei2RSBFuvBZQbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739010772; c=relaxed/simple;
	bh=IOkmfI06LTb3oz7n3bh7mmcfKsas5MSQLjMjVkJ97Tc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JDIRrzWj3ahIVzROFTOaLyqSLoXvRN95kjQPQUsNR61TWm+MR7E+xr4JvoYu2smlLAlyzlQElQz0P/tsD26OvsVBLJPxCuE4dS4Bp4wjAvWphzvHWKuoN7uvKpqWD7ROLI1dFtHq23inLwu90dlaGcJBk35PSQdFOAETABi5k44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HN+UYhqX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f4a4fbb35so33158045ad.0;
        Sat, 08 Feb 2025 02:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739010770; x=1739615570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbcQK4pzLWWZdECzEzWgcvFcvBHn89f2+AyACM8EpXs=;
        b=HN+UYhqXVWh2wuoJ7Kx5z+fBE+fByWTKlmhtjnjXCaivVUy1eXpQY3qExUkpCCQ5rA
         sjMJU2fSnfon14pbsLjZcHNxJy5tuXX0cK86r2bWSdKQjXbclRbW86wHx/rec8i22CB4
         GqGWfhR0sGJoK6kX7T2OIcMqnWW+8wcpGvMu/GfE5H6k+4jztPHFhpVZmkCL8s+Kakf+
         t8/fx4sCltIz5j3p4QZ+c13MgCfueRGB2f3J1fFacMOEKMq7PiUQYr2fUJuchoW+qUrK
         I19/orr0/AglUS4Jxsy2knhfnKcvUWsa8D1puLMCtoj/soPYCrZ+7MyoAtFhOxWcZ/yH
         igXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739010770; x=1739615570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbcQK4pzLWWZdECzEzWgcvFcvBHn89f2+AyACM8EpXs=;
        b=VDzMcJY7N5xyMIiqCBV7/6flG064cuVD2nWaVOzJNbxTwg6sKmOsz8YqZYev3nlDyB
         uD7+CGilmVvmivAE88SnCbqwbk8zYc+W/mPdYFDLClic0tfgbIosjBWh2JoQxm6CufEf
         /rm+uXYrytoUWAfyQiAO93EBlFQPn+M8ATPmhTRhUWc31FXy+qKGmPTUuvplDjPCBDOV
         xVIp0g6T/O/1sF93AqY5BkRg0uFfDUfgPUzr7X1dE15/fZe1s4MMlxRNR6xOREzy0f9D
         LEYdr891ry641e2ZFGh08x58v3O0RG1QlBynKmciUUy2sZZ/efxh8xTii3HlbTpYZwxI
         1Gqw==
X-Forwarded-Encrypted: i=1; AJvYcCXUDF7bVwLqXrmdzmXCCJh8jq/bsyWxu/K7bO3GDfxSbUrkzV7DYB4wpjFoVIJ9KZs0Nhw7XQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRVFUBysgWIL8uoPiwnEd+Ws+3r8N0q00X5PKHePQvw00pEb5Q
	ZFzaMBpTQGhOZWUmjnaXTMG0/aPAnqrFEzfhC5fJzDx4YHUi46iC
X-Gm-Gg: ASbGncsQxAqNwccF8MJbGoiL8r1qh7Nhw5OVnhXGKSbXvcKUVLjKLJoOWDl2phiQHrQ
	TqM/HUS3ITroCF9JcHzEoujJCnx6Fb96RWHG/o6J2oWfcNu/UCVMYP54EnIfVT51TrVyNvnw5Mg
	5av8OpOfC7/XFrloq5Oj4UWaQLbpUbIFqQY9W6ViEeTwjt02WAzSdbloVjtVTnfttoYm1FJpSlp
	cPmGznevC22j0yFeb3sHCR8/SfLgVA41ecJQNgg+l9/3GzIpcJ9kNC4EWK01T6Nx4odOcy/BL+Y
	KIND4X7xUjFsKQhx6d35sTWNtY0te78MPXUrfyNuU/K9/UzSX4Oixg==
X-Google-Smtp-Source: AGHT+IG4HpZoRkaFIPNndD1O70EDddx2yARzPOjix+npb+O7Stop94umbKsb0ovUs+BGDuFZ4mD6KA==
X-Received: by 2002:a17:903:2b0c:b0:215:7287:67bb with SMTP id d9443c01a7336-21f4eff38cdmr113028535ad.0.1739010770324;
        Sat, 08 Feb 2025 02:32:50 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af58sm44527835ad.70.2025.02.08.02.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 02:32:50 -0800 (PST)
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
Subject: [PATCH bpf-next v9 04/12] bpf: stop calling some sock_op BPF CALLs in new timestamping callbacks
Date: Sat,  8 Feb 2025 18:32:12 +0800
Message-Id: <20250208103220.72294-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250208103220.72294-1-kerneljasonxing@gmail.com>
References: <20250208103220.72294-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Considering the potential invalid access issues, calling
bpf_sock_ops_setsockopt/getsockopt, bpf_sock_ops_cb_flags_set,
and the bpf_sock_ops_load_hdr_opt in the new timestamping
callbacks will return -EOPNOTSUPP error value.

It also prevents the UDP socket trying to access TCP fields in
the bpf extension for SO_TIMESTAMPING for the same consideration.

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


