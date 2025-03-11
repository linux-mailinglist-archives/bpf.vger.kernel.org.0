Return-Path: <bpf+bounces-53791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE84A5BB49
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 09:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347CA18966D6
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 08:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E9E22F177;
	Tue, 11 Mar 2025 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RL9OS5I5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7BF22D4CE;
	Tue, 11 Mar 2025 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683399; cv=none; b=FsYra9av3wP1nV0Epu4vj71nJ6TTrtgOKrHqjzlAKpKcKPquJ1J6JbTEjXFVakHMlrFkdHIqjXLFUmEqcKBuJOFhvQxxyt6krkuS/TIZYnVw4oSw+LYKUGZDE4mCed1URJcWZ7Gp6r5bM90ZyiKuW/NRAOS/GeO1HC2Ipgpl0Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683399; c=relaxed/simple;
	bh=Tch7y1CukP5jx++pF34KjErW5dxeSlzBY2Tru7LU6lU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P/KhJDmVXVrZPYHwb0ccPZjt7ZbKvEr8WqFeQG9g69L6u+gIoL2IaYvJTpXazkuzVOjYpeOMQ84RQK+DwakW4pfV+MquOMEOrx/ZG5L05un9dveFx8/dmMBbiR/6rmIqSDvDgISOeQe65Kmmg721SWupR/q4OQjBnYs0owICoWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RL9OS5I5; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac25d2b2354so629298166b.1;
        Tue, 11 Mar 2025 01:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741683395; x=1742288195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RloDxb8gbXe9v36aikwRPJswC5qN9OsoL3FMniv5dsM=;
        b=RL9OS5I5uMuBth3BoAJcuZ1g9MUt41YU1f2yWwIgeiP772PV1U53DY+WbtRi0FMrJU
         a5cPWnEAkq7UuOogB01LPNNpahGzcXgL5tHJI9UIS4dpq06M7+rkBGh6j8+FSVcpnkW3
         l0dhIQkBk3CrQ8apjGKSOHx2fk8IWRVXqRO8NSfUhxK7tO8m6dOFFGIMkxuXOkTui88d
         JWK7l8+XpY67s7+3hBtEb0fgDSb3rNtpxJEp6MWKiFLbdtSHK+m//KSukAumBYnIf9Ef
         OQA5jwBFSmTLVsKM2FUvrR8K4d/a0ROoFdHE0IXHPumBGcOV2Pzb/zlumFOPeEEF3xrO
         k7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741683395; x=1742288195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RloDxb8gbXe9v36aikwRPJswC5qN9OsoL3FMniv5dsM=;
        b=TlYIbiGgeXAVGelhkMMTWlY4dDnHLmfCbBgkdMd5evX8UqZTjxgGyMILumoBYehF2t
         WYvDDFkyPpxcy3O70TpNJwM+PPZuAnw98B3nXVCXxbFBT/qZovB4Uwn8YyYIJZF1AARd
         rJiE4CxzHJvvv139IBnnGWp2ZoDMn9+ZX22RXU1EBigzYxrKySr5UFnGpgQaB7mOWktG
         d8oNb++/0Ze/quKBUwDWEpWuLCGEjOe5sTlSeZP6Di/ovWJ8p2jtgTDomPpM72bZehdm
         gnZaGk2nlDrwyT53s3E48P87rMVsYeHYX8YxnOUlD9i//yYCkPH9BcgIDXGcPEXumpYD
         td/g==
X-Forwarded-Encrypted: i=1; AJvYcCWRHsG6Rx8IG3y0F/4O0bgdHMwpWR/uGTMOy0LR9tE/JOjgaOEyKVmqdTfAIpaBVEjGrzv2Ixc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzPtk9+h500jNjJYOmH3nf3NGENf3tStnLxUlQx42oMr0OlSm6
	3KF1xSOk67liYFfi2gs7ohnDQPKTJOo2w1o/461IbuBVYX3JbHBu
X-Gm-Gg: ASbGncscLnXXXwrv9h/dd9zri8QJ8JPoZOfGczO/+/IhktPfjZ0x6hN59CFdt2sj5jG
	JOFuHJIxKZCyoNOZ7P870w64DggrXhMdEu6Nr72opxC3iEfBVua/sghJCizC9ZCPqp2igjRZ4+5
	tGLrmB1Wz7pG6w+uBx5uadnmfErtO2uS64xpUD4TmQnPoRtAsQfJtjX5y2gGxu3j3aopZEFONG7
	G/xVAuLJbqqTjePG5QArGQqIWfMvUJel7rndi0LDh0Td+pojYC7Ii5p5P3GNxZ44LbuU9b1A6lO
	t1TKxUaF88+izUGIdJoGajzCLRptYOtuzK7heci8OzyOhCwyrBpS181opuSkP6n3FIh1mMmzQ1Q
	/7WA0QA==
X-Google-Smtp-Source: AGHT+IHnWDdhKwXUNMeFMntmtTYRFW5XvWVwLIl/J4TmUwplfzOR7LjtlTTNcy/Ct6S/hLUe+8CfHg==
X-Received: by 2002:a17:907:7d8b:b0:abc:4b7:e3d3 with SMTP id a640c23a62f3a-ac252aae2c7mr2075444166b.27.1741683395166;
        Tue, 11 Mar 2025 01:56:35 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c766a16esm7965571a12.60.2025.03.11.01.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 01:56:34 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 3/6] tcp: bpf: support bpf_getsockopt for TCP_BPF_DELACK_MAX
Date: Tue, 11 Mar 2025 09:54:34 +0100
Message-Id: <20250311085437.14703-4-kerneljasonxing@gmail.com>
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

Support bpf_getsockopt if application tries to know what the delayed ack
max time is.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/core/filter.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 4d34d35af5c7..46ae8eb7a03c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5301,6 +5301,12 @@ static int bpf_sol_tcp_getsockopt(struct sock *sk, int optname,
 		memcpy(optval, &rto_min_us, optlen);
 		break;
 	}
+	case TCP_BPF_DELACK_MAX: {
+		int delack_max_us = jiffies_to_usecs(inet_csk(sk)->icsk_delack_max);
+
+		memcpy(optval, &delack_max_us, optlen);
+		break;
+	}
 	default:
 		return -EINVAL;
 	}
-- 
2.43.5


