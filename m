Return-Path: <bpf+bounces-51496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AC2A3535D
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 02:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B38F16E04D
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 01:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10412288DA;
	Fri, 14 Feb 2025 01:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDHqlUuV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A95275419;
	Fri, 14 Feb 2025 01:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739494872; cv=none; b=UX369ssVpPvmy1exr8OUXliudvdZiXMhUFx2o05rG7D3DjZbDgG99aDEKP0sws/ilUzWjg8egYmPBSuseqpZWRC5r+58HpVLbBWjklxEOWOyNd2BReMdnH2wVQOTbnUPf3nN2rMWYx7ji9fnr+ksH7NmGQ/SaFStEV1oxpvssSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739494872; c=relaxed/simple;
	bh=3f4fr3wEVqOkIsOc+1STd0Ns5iBgLGFkFca2uJbMweM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gYNR8NsMlEQq1DKJDqsFm4vyIMN9slggErU4r0sQbfqpEx6Up33rlPyO0VU3iLK74mGrXbnGgHP5SJdAWF3IgovEHUWzjWOsuAVozBqJa+URMLsx5DqTOCTUMqkMhKFdShghqkb9xZzqx+VRyK8vLjLzZ8rj2GWHtTEw77mTLG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDHqlUuV; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fc11834404so1892691a91.0;
        Thu, 13 Feb 2025 17:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739494869; x=1740099669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jcgdad4TkftRTh1q65WudnE3mEROlme3+Pzdel+ZVs=;
        b=PDHqlUuVp+Wry6F4NUYFLJulhroZDy6sPz7NQkvY6haWDvs8Xi8YVQlqBURTvtBWM/
         7LNhWT5DrRdcnrJihfzrKRDkGuvdkVSxfNWTXe0hHCDpZI7ZN5EepBZ/Xo95iGO//6V8
         jlRxJmoJtRHFjLG5tni/OEi6Iy6rqK73P7jQl4Bn04CECQfXDcB9SK7V0OJ+6CMx+Geq
         zOsoiK8tEF6tBK6PygmTypgKwRNwSIuiewHvTbGjhZxqg6KiILj+AbbWHVqWUNQ2Dtzv
         VzhGw3XBkchsQL4Ow55DvJSQcIlEQ338TEbAL0rFipDY2vUWlMrGMMOjAVYpcy2sYRKC
         JFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739494869; x=1740099669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jcgdad4TkftRTh1q65WudnE3mEROlme3+Pzdel+ZVs=;
        b=Ykl6QkhNCYedUUGROQCidbwo9ojh0Q15ttOUbEuNDRDea094Hg4XBnVNnALhRxBXea
         Ela8GYwPiW174aXviqRe+geF3DKPCjJgtH2L5at6KQUrJiopZCFBX+GB9Nd7Z4DRT7gt
         fe/dSuMwDQHr7ivekuCYumhbAsX336NbFOD0BVaxgz7JUZ6yG9etVn+ELfUYSMlecL9U
         nTf7AAp282qdIDEBHVeRmWPhoDdUf0lYH7zTH0IwM+fy64gbrPgmQqeUtj/hCDFkhVpL
         pJ+c+pXJxqubFNuYUqrftRn75kgv/cplZ3scLj7WE77Wep/yFfe/9qZiOms3oWWEfXUZ
         /YOg==
X-Forwarded-Encrypted: i=1; AJvYcCXwvVS7x5iwaLWhiA/Uj4R2VntpDPGqBQyl4jvHrFfaG0/KdjFuDhTYtvo/w02shh8ii+6nzUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ6vnnPaaZHtOozvlayQQlGvSXIqkOE5uFkV/cNlINhRYiSujH
	T55QR7HehJJpsd1sblpo3yh07tg0y5B54oJs0yVLF9teJyWqCA4t
X-Gm-Gg: ASbGncs3r6Ekv5RuGPP8naBkTEZiRsHQoZGpZYtCh++WHZ8ekTVIWp1aVeW4AWusRHm
	F0szimlTRP3j/q1ezfKusA6owkVsn7RDigDMUx+aZQ58zFEXc2iTRy9VMxwILCQxAFPiy5eadZ7
	8WdeB3aYgx7Hw6YRkiIaQjZHS2oHof1bNpfKKGKDcdt9nhgoGD9KAGNvDrCgPczhFI6EPIs/TqF
	bP+IW1qewJAnL0gPckmL0wuLCfXTmmp9K6x4aA29oARvnCXIYklF5tg/zet1rdswmR6TDqAPr9l
	96tu9n1YtL+Hi7eIAUFQZpfqyoa0IZW++q0zhr0gVa6pY00/F7mMvg==
X-Google-Smtp-Source: AGHT+IF4LSiImQXxMrZls32LhmR+tuDFoVzv02aP2ZUjJGRvwSuXck+6lsKTCO9YvjSpNcYG4PoyyA==
X-Received: by 2002:a17:90a:d88c:b0:2ee:a6f0:f54 with SMTP id 98e67ed59e1d1-2fbf5bf82e9mr13684752a91.13.1739494869350;
        Thu, 13 Feb 2025 17:01:09 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d534db68sm18629565ad.39.2025.02.13.17.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 17:01:08 -0800 (PST)
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
Subject: [PATCH bpf-next v11 04/12] bpf: disable unsafe helpers in TX timestamping callbacks
Date: Fri, 14 Feb 2025 09:00:30 +0800
Message-Id: <20250214010038.54131-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250214010038.54131-1-kerneljasonxing@gmail.com>
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
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


