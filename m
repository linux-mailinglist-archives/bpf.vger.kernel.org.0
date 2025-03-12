Return-Path: <bpf+bounces-53891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4C8A5E07A
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 16:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77299189C637
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 15:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDDF253F30;
	Wed, 12 Mar 2025 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9zqu+lD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC6C252904;
	Wed, 12 Mar 2025 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793760; cv=none; b=AFOrlrzqITtRUW55Bkwb/29cFZRct8DgQ0rgaa33HQrblDzJFp4x/qD6C87SyKpDVck3idXvXcBGlc8mWuISmbI3M+k3wVP8fwlYl9uSRyuWvgn3zcd0Y3f1m+aaLL8tHNLeuoTEEtdVpMeTauPgZrE7ToT2QqIQQBa+7oky/VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793760; c=relaxed/simple;
	bh=+Aad5XPyf1doXoWRlaNoTTUsGkq/7xdCXRgULYAvTog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lJPvN3LdESqUhmD4EgWhnK6a00waw/qYArT+dJb8SqA39ficPs3hkEJmWx2VVV8xj/CesyzBhLrr/ozVPPOZim4TWppQtC8pAlXd/F6DrlrTO69tOKj1EIPP04T+pwmDKRxSNyS5FzrixWYQMw34NETbs3uK6eKRu+j38Q/oZM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9zqu+lD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224171d6826so39698795ad.3;
        Wed, 12 Mar 2025 08:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741793758; x=1742398558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8T8Uqmta0Kh5TnKQbbsbMXCRaE8kpvtZWd24zT74u40=;
        b=N9zqu+lDDVDy0aOlYTxVJdVO3LSGhWIcAp7mNlFmcG4QcwRlVwd/MLc4KT1U1tf03w
         sz4FeratD2IM/1s5mS+D8Z8qnvmx+aGszQT/N1uk9Oj5VwHHwv804T1MTZOHcVKv/FNS
         1DoU/Zpdm89xvy5C4bbPh06Y8u5Qbnd76scVmft45UJj3utCKRuxIg1pLBptNUJxCznK
         2YR6PfeGyzrtI3Blumo5/GbynBdsqXjrUKzCiEtkILIXTGLWhfV5q0rOtwut3t3f+9E7
         9kxAoor0nrlXOQJ0WngRIvkJp2Pbo++XA+LwerP3uA988rXzdyhS5VTedRRE47tdgS4R
         V9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741793758; x=1742398558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8T8Uqmta0Kh5TnKQbbsbMXCRaE8kpvtZWd24zT74u40=;
        b=gc8au5r9OGhiPOORcf7FF5LWXfChqRLVv4du7ceoJ6pO5lGldGHNkEq7d6OS4hA5EM
         El5EBcnm2xbAIA1NvYwJEhcuuUJhNSy5Sih4kSoydQrGEW1c/Tg7sRaFrM3fXocumY/o
         oCRCiOFeb51VPrC1CdZkf1hn/B0JryHFub5YUugMuzOzfnGx/9mJER7luxqyBEUI9LC/
         kCVj3Sbk2J4WqCATbdCDiolIR0o0tdGLpijG85aKf3TVc7AalhKVFlFAgqAU1vIcYTZo
         efV6PdT+zsXtPDvM1OE4wJyM87bQEHJdTfeS0Q0tFu4bOUkiUNklYt6AT0diJ1qzvwnJ
         V4GA==
X-Forwarded-Encrypted: i=1; AJvYcCWbK/bT8sV5GwsVpmHcfoPPG2Wg6iN1Ta5WzyU76JS7BY/rfuvmxCKsJdjAC7sUPn7/rVvSAzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzctfRBXECPIxPMkF/FAWgetuHegFsTaEEyVYrw9e2062/imQtY
	TAuVhzu3BQELQ3XHiiwq+W9yfP6Be73ukdY51XfQRepRY66xcmZ+
X-Gm-Gg: ASbGncuXbInQqYtHobtJiBBE3t/FlV3a8Dbpg27Wq0IJKHHH8zu2EzfaP1zKXnCyRaT
	GA3GK6Ql0hKiBEzLMlXnXLK6xbXC8h6SZ5bkNHopn2Eml/2cN6izGya66nKsFc9V3iPLOeDTBPV
	6KVxPD9nZaGvmq52Wjkhao1VmXCEP9aIa8HlDWBwvv75PvQ+qy6Si8m7rif4PnsEBwy7L9ENtx4
	eyUzmN11jwyEUNxvyVcEDLnaGJHon4NwzVFBJ9m7o+AwCJHHj40ZgvqXonqIFEOqZ8CjKY/88gT
	/Pp+1mJ6Jyf8hTDLfZzuY0PKKDLFExiYJlhur9rjH+Y0qoP96V4qO/g+nPwB8Rtg+kozN0YuLxE
	PkacvD4kmBg==
X-Google-Smtp-Source: AGHT+IFAn1ByWumNFMk7F9tmPlXKy9cRGLS3Avm6EbxOC99x+zqhlEFnEPI5gj1l0NdW25jZ6R/9Qg==
X-Received: by 2002:a05:6a00:843:b0:736:a973:748 with SMTP id d2e1a72fcca58-736aaad3d00mr33218850b3a.22.1741793758085;
        Wed, 12 Mar 2025 08:35:58 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.244.131.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736ab812cb0sm10813562b3a.164.2025.03.12.08.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 08:35:57 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
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
	horms@kernel.org,
	kuniyu@amazon.com,
	ncardwell@google.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v3 1/4] tcp: bpf: introduce bpf_sol_tcp_getsockopt to support TCP_BPF flags
Date: Wed, 12 Mar 2025 16:35:20 +0100
Message-Id: <20250312153523.9860-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250312153523.9860-1-kerneljasonxing@gmail.com>
References: <20250312153523.9860-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch refactors a bit on supporting getsockopt for TCP BPF flags.
For now, only TCP_BPF_SOCK_OPS_CB_FLAGS. Later, more flags will be added
into this function.

No functional changes here.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/core/filter.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index a0867c5b32b3..2932de5cc57c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5282,6 +5282,26 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
 			     KERNEL_SOCKPTR(optval), *optlen);
 }
 
+static int bpf_sol_tcp_getsockopt(struct sock *sk, int optname,
+				  char *optval, int optlen)
+{
+	if (optlen != sizeof(int))
+		return -EINVAL;
+
+	switch (optname) {
+	case TCP_BPF_SOCK_OPS_CB_FLAGS: {
+		int cb_flags = tcp_sk(sk)->bpf_sock_ops_cb_flags;
+
+		memcpy(optval, &cb_flags, optlen);
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int bpf_sol_tcp_setsockopt(struct sock *sk, int optname,
 				  char *optval, int optlen)
 {
@@ -5415,20 +5435,9 @@ static int sol_tcp_sockopt(struct sock *sk, int optname,
 		if (*optlen < 1)
 			return -EINVAL;
 		break;
-	case TCP_BPF_SOCK_OPS_CB_FLAGS:
-		if (*optlen != sizeof(int))
-			return -EINVAL;
-		if (getopt) {
-			struct tcp_sock *tp = tcp_sk(sk);
-			int cb_flags = tp->bpf_sock_ops_cb_flags;
-
-			memcpy(optval, &cb_flags, *optlen);
-			return 0;
-		}
-		return bpf_sol_tcp_setsockopt(sk, optname, optval, *optlen);
 	default:
 		if (getopt)
-			return -EINVAL;
+			return bpf_sol_tcp_getsockopt(sk, optname, optval, *optlen);
 		return bpf_sol_tcp_setsockopt(sk, optname, optval, *optlen);
 	}
 
-- 
2.43.5


