Return-Path: <bpf+bounces-51716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A53A37A2D
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 04:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4319A7A4791
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 03:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0D616F282;
	Mon, 17 Feb 2025 03:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEoi77KM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C3E1531E9;
	Mon, 17 Feb 2025 03:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739763825; cv=none; b=siN8xcArnijCRpTbzCu8PaUWTO98QcmvBpuC8oHWRqvUMjISrO2JOEE8RIDgO3qoLVw2fWIw64SDwEA3Q1zCq/f/cMIpsp51h/Iru/xzSyU8DA+25aZFsuo58PLMY8YEm7Feug3FbyYEMjm3mcrUh9U392OHoBeJYCqHRogdDgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739763825; c=relaxed/simple;
	bh=FBcJp9oqBtHgTXIQ0nluk1qGKr+1altiJ5AKiI+z7pc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QKcZKzgzxC9AGZE9uXnPd+15d3xNtrRkPwhDWFlFH1zQV4Dns0XVN4A/9dP0eINsHysXDfvuUKHceLBJ1qLS9cSWO+KnJ7qZZgCitcA0Ayq8Sv8E7Qx3To39NNK/YUKd3UpjTOEGY5JH0I/kU8NH3/iaYMVgYhVX0jzCK7eWSj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEoi77KM; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220ec47991aso34622045ad.1;
        Sun, 16 Feb 2025 19:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739763823; x=1740368623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7PZ/JXec2sS9s17cIhf6J+D/ZmzZ33uHOow6MZzhj8=;
        b=eEoi77KMo/ck7Z5aWDVk1kM5O51a5vKqtRAv8BrsxA8gMvyAt6iE21+uhUwBfM1LoD
         YY2Br6KOjWBsX4LF7CIVeuy4GoU+Dc8xAWfBfbMBJmLXJ89STBkOaFGnVucWq3NCggj0
         h7eSUUthonpHbI4aFuF0pwpHMmrr3M/wJqtdoLSYTwZK4xfb5b8NHrETIMFP0B2clHVf
         wngwSp67y2tBCvSN4/mRzps+npzK+tU3s8J0bsxfozb1UQDm25l8jAGNBKZt1BQ2FEG4
         RCwLzmoFLqVTQHICuXhEcMmtIhPHZSpZbcQAlPOFk7lph7vugnBG4R+dZ3jwJzwovZHv
         mDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739763823; x=1740368623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7PZ/JXec2sS9s17cIhf6J+D/ZmzZ33uHOow6MZzhj8=;
        b=Z6BoWpFCCuC9qIAEPq5HpWWaUV6riVOM7oL249K8xOTogfAnu+nZm+rnkSGlxZ3pRa
         hfC6kEo8zIfrXY7sXZmbkE45mo9aW6roiRrjoYis9dU+G2xHfwADYIJleNPpM5kgCx9y
         ZNX+58bNuqS9AHYjuc5K2vYwqA5x9zRGHF0B/gGmOLFLOMT561vAOg6GKn/Shbyzc00Y
         VdHuCp8n6DlodKIz+YdPJYaEZh3m0gxwXAmyPBwCwpA9BM23B67mg4RKh30wPxZvZ+3R
         wguzh0hi2vqvr10r41OKL1Pdo9PznsZaVmU37Wi28sweo3vT3KA2nnh3VOfuJ9ZzwUGq
         hVRw==
X-Forwarded-Encrypted: i=1; AJvYcCWKGq0LIsYY22XSrDUYfBcBrNTFE3wLq5UdxHxyA0eCmw6W/6mWokrwOldrjQteq71Hx1ggY+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZxie6miKpJIbWFAC+0iKoyQNeJQ7/M5LiZ+C3PyPcPSYcxrJw
	pywDJgdSQXylVNYwJLk2M4GyAvlln0GjMXu0WLh7kF6v2I9wwyEG
X-Gm-Gg: ASbGnctj6wBYqlnUG9r5wAJbXa1UOuWaY1FXcACvRez/O7v7z5V0qF+VREd3IGg9Jyw
	sdwE4IznYvb/OerUSp/TTgMCFpaDoRaqvsWdMsaEFEkboe4kgASGreV5psZVf84skcrCVAoWCyj
	gy02vb81mERL5oL5NMP/lNwzpDj0mLYn1os8SEkqBmc1VHRH39Y91sZabiSpEj5JjZDh1jBjEvN
	TmE2HRSlA6j7GnnujP9knrQ/zeRMEniN2pVGJdMxXOoL9BUQXlrn2/KuS7UKjyLaiAAcMZ+nfXG
	e7uzU3s5+YCK3ILnL9vJW/X3/30UScmrk3L+LMwiq6pr8AoNEp1XYjLvVSIcpyA=
X-Google-Smtp-Source: AGHT+IHQRE1vt6lmboosX9eGV6PAYsfEkKNzfQEjyUmNC4Qse6RXjY7eJIZR/zJNXEMmjps0GThNyg==
X-Received: by 2002:a17:902:e546:b0:220:d79f:60f1 with SMTP id d9443c01a7336-2210408cdabmr119818205ad.42.1739763823131;
        Sun, 16 Feb 2025 19:43:43 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536b047sm61966585ad.101.2025.02.16.19.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 19:43:42 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com,
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
Subject: [PATCH bpf-next v2 2/3] bpf: support TCP_RTO_MAX_MS for bpf_setsockopt
Date: Mon, 17 Feb 2025 11:42:44 +0800
Message-Id: <20250217034245.11063-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250217034245.11063-1-kerneljasonxing@gmail.com>
References: <20250217034245.11063-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some applications don't want to wait for too long because the
time of retransmission increases exponentially and can reach more
than 10 seconds, for example. Eric implements the core logic
on supporting rto max feature in the stack previously. Based on that,
we can support it for BPF use.

This patch reuses the same logic of TCP_RTO_MAX_MS in do_tcp_setsockopt()
and do_tcp_getsockopt(). BPF program can call bpf_{set/get}sockopt()
to set/get the maximum value of RTO.

It would be good if a BPF program sets max value of RTO before
transmission as we can see in the later patch (selftests).

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/core/filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 2ec162dd83c4..ffec7b4357f9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5382,6 +5382,7 @@ static int sol_tcp_sockopt(struct sock *sk, int optname,
 	case TCP_USER_TIMEOUT:
 	case TCP_NOTSENT_LOWAT:
 	case TCP_SAVE_SYN:
+	case TCP_RTO_MAX_MS:
 		if (*optlen != sizeof(int))
 			return -EINVAL;
 		break;
-- 
2.43.5


