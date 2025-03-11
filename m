Return-Path: <bpf+bounces-53790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 614E6A5BB40
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 09:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9E31896229
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 08:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF4822C331;
	Tue, 11 Mar 2025 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQGUzUGm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6791DED63;
	Tue, 11 Mar 2025 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683396; cv=none; b=NI68wuKeePg2bVHPJ5Ck8oqm0G1s3yukngHlI1ofQ2H6+zORyeGWa1E00oSKnPRlbLwROHKNPEhprd1VzcQ4qk3VoKUURyrfkktq9pVwmmkBYh2ZfnaAAfRCmg5OcP4xr1QJDczlzw4qRAj2blzB3+Iy8ybIBf3l2UhoqCdwFBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683396; c=relaxed/simple;
	bh=ykb2g5yizED+vebhylmrflSTLVLfkil8AAMNomOGoYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sZ/p2v126gyFL9z8HdbyCP+4j16B3/KRBy/2a3VgAtY+B1x5U9D3njcYA0JNXGXHvXmm2F8c4q5lz9unxndpcW7sUahPNe6d/b3rwIjLBtQyxOY737s8Y/CQ6jgIeXs/foswc4iXDqZ/FX0oTbq23YmoGf/gFEjKUKyH6QTM4qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQGUzUGm; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5b572e45cso9344276a12.0;
        Tue, 11 Mar 2025 01:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741683393; x=1742288193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Yd0B7kz/F6zvlGEGELE4rgUtQ3PdQMGH8uZAdiGdh0=;
        b=cQGUzUGmMeFPH7FXKZXAAgEzj3u+UuyNEKry3OOPjAMl3bZol1uSjQa3yNi5y4uCnU
         b60wucoPjLCw6gfMWRLrJ/RlA/9VAPPKRydmMKAL7a4eQg64qOr+FE7sJDAF9wCfU+uT
         aBWFUHI77NzBQzSX/Y28TusTXOXCkWnNJVwYC3Thkku8/jKxQvek3E4ZB4zmG2GAm4OG
         Gs8MU///9JCIdJeGkXWl360YTkV357/Zhsg+mt1vgYFE1kTPYfi0EP53hKeuGM0LDOHW
         xG1aiij4tCxYDJ7yUly5i3quh8CibJBw3m5G43k1FG8FBWvX/VXWJRtvybGSbhnBtJrX
         hU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741683393; x=1742288193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Yd0B7kz/F6zvlGEGELE4rgUtQ3PdQMGH8uZAdiGdh0=;
        b=JEONrws8lvjzMBGZ86qiDSXkJhRxueRgU4FVAZyB0OP3i/SJiIyvm39K4fTdzj5cx3
         0aBkh1sGxRS6lXGBbTWzrSVA4P456aaZ9A3HMea2dJibA+I6qR9m53TshrS3k3IKABJv
         8/Cw5xgazT/3oBUOIcmUt6oA286kLqJPENlGNnDw2HrcoRyYwilhKAXBwt9u6oKxT6SF
         7hlhhZH6mSwCS9Q1XTrbTDm0jNhUCw2KM6zWGD4LgT6QR7QOtRfzPrnttruujylXoUhO
         r91psanb1tysmz0VmjpiStFh0kzuOBzTRBlxYBnl5JdUnRcuE+MqoMcPFQSsKX9o8Rf5
         cdqg==
X-Forwarded-Encrypted: i=1; AJvYcCWCpejZStnjO5xtqTIV41FvHz9NGZ7kKhxvgw9ixuxPAFQLIOrKOCxBykU044y0u9ZkL7uNuTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvZ2vBQmI1M/zD+ugIbrf/L7L7OtxqQ3tfC5sicz69+eZKAEuF
	20DX1qiAjeA2Ae/sw8SW2IQn/RDuudtwWGjurAptJnoxMVOb3Qig
X-Gm-Gg: ASbGncsQ3xh5qU0ql2R8bPk+A996NO4Wavr2whIIdgIDI6J6g7XHhoWH66q8ncyQVDd
	v8WGjLR9sTF0WEd/nBsaEgYC4nmH/3ll2AhdrefeiZziBq6UAJg32tE4T3M2fbG3Mb8aH4c+gI4
	YcOiwPyOj5DhQuPdswvbgPHobKOjvALJwtrlIffy6u3Taj9T4VEg0tFuS9yHqyOCfQeYwICFC8c
	OXimjDc97Nce8v3KmLqj+kDu6JvBLNQIj0Tr/H0KDjNds+OM9Xbic/iTBxkcKYL4+Lj1OobjmhN
	ZVPNaYBFLmGSlhMxwdylGfn+S83GAlHLtu37CBT/xmIBbYTPLtu6gOtPCVyHjLGajwGucOKy6QP
	Q8as5Xw==
X-Google-Smtp-Source: AGHT+IHdpcSHffRPGcgC4nv4LQP5i6mMalzp8jCXBJjTSVI7t9Zs1LxWEm8rb6hyRcBrF1En0ussLQ==
X-Received: by 2002:a05:6402:43cd:b0:5e0:4276:c39e with SMTP id 4fb4d7f45d1cf-5e5e251190cmr21290422a12.30.1741683392689;
        Tue, 11 Mar 2025 01:56:32 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c766a16esm7965571a12.60.2025.03.11.01.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 01:56:32 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 2/6] tcp: bpf: support bpf_getsockopt for TCP_BPF_RTO_MIN
Date: Tue, 11 Mar 2025 09:54:33 +0100
Message-Id: <20250311085437.14703-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250311085437.14703-1-kerneljasonxing@gmail.com>
References: <20250311085437.14703-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support bpf_getsockopt if application tries to know what the RTO MIN
of this socket is.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/core/filter.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 2932de5cc57c..4d34d35af5c7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5295,6 +5295,12 @@ static int bpf_sol_tcp_getsockopt(struct sock *sk, int optname,
 		memcpy(optval, &cb_flags, optlen);
 		break;
 	}
+	case TCP_BPF_RTO_MIN: {
+		int rto_min_us = jiffies_to_usecs(inet_csk(sk)->icsk_rto_min);
+
+		memcpy(optval, &rto_min_us, optlen);
+		break;
+	}
 	default:
 		return -EINVAL;
 	}
-- 
2.43.5


