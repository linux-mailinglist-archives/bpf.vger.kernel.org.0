Return-Path: <bpf+bounces-48644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAD0A0A89D
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 12:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E96B1883F26
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 11:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1273614A0B3;
	Sun, 12 Jan 2025 11:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxHDHY0w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E581ACECA;
	Sun, 12 Jan 2025 11:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736681906; cv=none; b=oSuhJ06VtdyAK4L0D+zN6BQNRh6I1158twcxoxprT21AYQ7rfBDNlw3WsjIFzwJ1Jt2gSMWxwpPRqgpTjc1Qzbbb6ZlSkNpQbf2S2SrOM9epD8xswYJ6xVGanT6x6kUl8MDEuC9lac2rnfcHTHkWmOSotzDuJlskLQJSQ1dBAwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736681906; c=relaxed/simple;
	bh=X8PG6ZLzql4XepmkV1UxAQ4M8RTqUr0lLOYSmC4iNKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mEoN1Ku26sa/ytgQNRDeZUx64mT+cVSiAlQ3y1Wj0GWPOvLVG26Ti0L7BrZID1DDe0EkrehiTLFuiOFii/3lLQJbgCbSKhuNOBGc+47kFix0YCxYLKPUb95pR/t0qMDh6w8pZcMDMuCdYUclQoNQ5V+0xgGbOjzm2oX2NQpjaFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxHDHY0w; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21636268e43so77522405ad.2;
        Sun, 12 Jan 2025 03:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736681904; x=1737286704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEm0zovFJqig1DzXXVbNZQTWvtqYNNSgeEtxTT36beo=;
        b=MxHDHY0wv6PRAc+AZCejPVdX3a0HMi1IpmAloKCZKVKYsaIiddwgAN9HGbqCAW2J+M
         1YeIZJLzgGOXAl7RB+E6rv86MTlrEENqT8DaE6Q+OVZlvvWjlO0LmX790lGDHbsIimDY
         vQAxGcr5qyXT98aVVqPrVEQqf1PBoUfkbh/ijE/mZR/mUDwrHFra2XHlLvSW6nKMeX6G
         C9ivz48x8LPGLSvx7UKleaRSakCIBEHrPiHiehsFD/Z3EnJ5NXipweIntSEBtC/IEw9d
         0RaWRuerhW8PshqYx5h3nhTiCk8jBWUgVJL9w11TT1v0aIA7Ioq97rRj1I3zJ4Zn7lVZ
         Ywgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736681904; x=1737286704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEm0zovFJqig1DzXXVbNZQTWvtqYNNSgeEtxTT36beo=;
        b=Ob7PU64wx+iZD103Kk27KjWaEMCc6AklK0lmrstSP1sNEWAUfXIsMxmDFxUJV15PRO
         FDYYwEVcOrY9CAcxKC8EPqHrSDCCQWtTfzvFkwVIdvLNKR2bXf6LFujYBMjj3pnPUK6s
         49X1rxXFnBAwJCmdIZD3800yfN+jRzvoch3IUkJcywIWSZ/+mw2BxwEXFYNj87mNg+s2
         nKeiNXJhmE1jLi9paMz/Jq0LqvGnLDBBIAAdZjbvVdw7F/P4rE8QeA1B2H0R+kjhZckd
         bDKvhLhMd9w8LtKzUyd31cnIoYfvE0wIQZ3SyYm+h8NkhX5RLodkZuf+vlDkN16ehmAK
         DL5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzLxEIB75aMDJ5zxaDrOwRjzKt7VQm5wo857sRQk3ZoI5+BbUhuB56bRHoj/uK+phXkD8vkC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIp25kTpa/F/pL5rIfUrpBMAD8CWxFhQO7tgAMnWyPbRpj5m0N
	q6/jFUeOLjJo8MHWzO1MzBwqB8PymDfytwIMUkKu0Ld4V3qQ967v
X-Gm-Gg: ASbGnctFeZdLfYt3BrRtQlsniplsuwePa8VdVr6ylVsCzkmS0erBKzWVfAphTykH4Lm
	SbXDZ0SzJ7tSwW0+HFa+FoJpWe8ox5pogAfIySeWRwQtIMZrfJR8IX+tVCgBmmLw4RSIkC5MLvN
	TEzHbwSWXKJZI2nbHlgevJ6YPvKmh4slBYXHHk3oKiXIAbKrvmFV5Ae3HFzO44Y/aK4gRe7xRs0
	0x28RVA+sEBloR7/LfO7bEZGYw7Phh7hN+NFD8LkiVOC1tD8sGDhiBtMEbaHq/q81Ic9RsSVHF5
	5uNX64WsWGv1iTe112g=
X-Google-Smtp-Source: AGHT+IEnBnWA7PeX66ST6O6xNz5j7ZtFWo9xBOoUm2pKfVacVqFpQQY7TwB+8tpyat697IY5DlFCcA==
X-Received: by 2002:a17:902:cec3:b0:211:ce91:63ea with SMTP id d9443c01a7336-21a83f56f9emr260140035ad.15.1736681904534;
        Sun, 12 Jan 2025 03:38:24 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f253a98sm37353765ad.224.2025.01.12.03.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 03:38:24 -0800 (PST)
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
Subject: [PATCH net-next v5 05/15] net-timestamp: add strict check in some BPF calls
Date: Sun, 12 Jan 2025 19:37:38 +0800
Message-Id: <20250112113748.73504-6-kerneljasonxing@gmail.com>
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

In the next round, we will support the UDP proto for SO_TIMESTAMPING
bpf extension, so we need to ensure there is no safety problem.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/core/filter.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 0e915268db5f..517f09aabc92 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5571,7 +5571,7 @@ static int __bpf_getsockopt(struct sock *sk, int level, int optname,
 static int _bpf_getsockopt(struct sock *sk, int level, int optname,
 			   char *optval, int optlen)
 {
-	if (sk_fullsock(sk))
+	if (sk_fullsock(sk) && optname != SK_BPF_CB_FLAGS)
 		sock_owned_by_me(sk);
 	return __bpf_getsockopt(sk, level, optname, optval, optlen);
 }
@@ -5776,6 +5776,7 @@ BPF_CALL_5(bpf_sock_ops_getsockopt, struct bpf_sock_ops_kern *, bpf_sock,
 	   int, level, int, optname, char *, optval, int, optlen)
 {
 	if (IS_ENABLED(CONFIG_INET) && level == SOL_TCP &&
+	    bpf_sock->sk->sk_protocol == IPPROTO_TCP &&
 	    optname >= TCP_BPF_SYN && optname <= TCP_BPF_SYN_MAC) {
 		int ret, copy_len = 0;
 		const u8 *start;
@@ -5817,7 +5818,8 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_sock,
 	struct sock *sk = bpf_sock->sk;
 	int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
 
-	if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
+	if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk) ||
+	    sk->sk_protocol != IPPROTO_TCP)
 		return -EINVAL;
 
 	tcp_sk(sk)->bpf_sock_ops_cb_flags = val;
@@ -7626,6 +7628,9 @@ BPF_CALL_4(bpf_sock_ops_load_hdr_opt, struct bpf_sock_ops_kern *, bpf_sock,
 	u8 search_kind, search_len, copy_len, magic_len;
 	int ret;
 
+	if (bpf_sock->op != SK_BPF_CB_FLAGS)
+		return -EINVAL;
+
 	/* 2 byte is the minimal option len except TCPOPT_NOP and
 	 * TCPOPT_EOL which are useless for the bpf prog to learn
 	 * and this helper disallow loading them also.
-- 
2.43.5


