Return-Path: <bpf+bounces-34719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B1A930323
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 03:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C171F22C9F
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 01:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BF1182B2;
	Sat, 13 Jul 2024 01:53:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDDE168BE;
	Sat, 13 Jul 2024 01:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720835579; cv=none; b=n2DwLQl61HMyN3ukOZo1o5yjHRjSyfZFv7+cuLcuPsPBHb+yqSeR++Dfo0OwAvpE6/V8nKnTY23GFqRJjnDtThZkCEUvel99oaRqAH86BcWb8yxd/WZqeIjD5ZC3vIrj/a14M9t7VvSOljzoucjavIqdMOdVBdFVhacuregpE3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720835579; c=relaxed/simple;
	bh=Zl+GVY9X46EIRGEz3WCn0GePbcOjFTipK6K7vw7lwdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2b0Ad3nGcMPCtys4oFP+swyGEgWKkjbGJPGHko4YkJsPxHqriqcc+pVw/2kAZ6GnunOPtcIaLSFamL6eKskIAzeJsET6bnYnUGNS2DRqjAj9pgE2lNaU1JIFFMV5x6Hu4EzAY8/2ZXC3GmoVby2hRRjS2mQFf4Nn2McxnTKmXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fb457b53c8so20294945ad.0;
        Fri, 12 Jul 2024 18:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720835577; x=1721440377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8GIpNdAF3iKCsQcqAWsrBumnPtDD2xvLOgJAL98wkY=;
        b=b1rLXaKi+xBBCTGQBkvqy5/OMEkWWc8V6mTNlLr0gm+kg8JPQHMuxKC+Y6C1V68bf6
         0nfErZIApf8c4QlhhCrLkTqlMQZad3Xp/bDal4O2X1TYURvXGOJsWGOMJq7GsWn4yfWh
         39l9vLlSx25zXSwwyusPIDnC76Rmgj3Twolmku+BB7SPrljyq0lYEZi2zrmS0pXrVIuQ
         Nk9cCUwnXbWvpR6hjHSpF74kaSEQ+WGjZfdagruDdCfnmNTOhcGEyAXKX1y5pDr1gPni
         aAx4sMfOk1YVamYnofuW3myJAH9UDyggQaxr6l+oQ7AgLV7mo5dvffaknvhtNIu8s8tF
         +EXw==
X-Forwarded-Encrypted: i=1; AJvYcCWliSRs2Nqy8qkVoWttEfw8oeFBMB8t848KQW2EDwG+8huq93RGZ8iH7CxqMG15GPcpmYw/ToiQhWQIRyXiciVj422XLz7Z
X-Gm-Message-State: AOJu0YwEsZPsyVohYS/UKa2EZjnThj0Jr3+p7NisJ/qd1JRo6LxjQAJv
	69JDet84NxMF3Szvi31qMofuv2GJC5rMipoH2sdG1DQvXJjMQ7H6G1N0q+Q=
X-Google-Smtp-Source: AGHT+IE9JsRAeSIgDP2a5zU+QoEmVrvAGehV1+us3yv3YqYNOfd4AtLjwCG1111dcaizUeeyzZaSEw==
X-Received: by 2002:a17:902:d484:b0:1fb:5b83:48d9 with SMTP id d9443c01a7336-1fbb6d65bc9mr108511695ad.37.1720835577469;
        Fri, 12 Jul 2024 18:52:57 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb9a58asm866205ad.65.2024.07.12.18.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 18:52:57 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	Julian Schindel <mail@arctic-alpaca.de>,
	Magnus Karlsson <magnus.karlsson@gmail.com>
Subject: [PATCH bpf 2/3] selftests/bpf: Add XDP_UMEM_TX_METADATA_LEN to XSK TX metadata test
Date: Fri, 12 Jul 2024 18:52:52 -0700
Message-ID: <20240713015253.121248-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240713015253.121248-1-sdf@fomichev.me>
References: <20240713015253.121248-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This flag is now required to use tx_metadata_len.

Fixes: 40808a237d9c ("selftests/bpf: Add TX side to xdp_metadata")
Reported-by: Julian Schindel <mail@arctic-alpaca.de>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/include/uapi/linux/if_xdp.h                     | 4 ++++
 tools/testing/selftests/bpf/prog_tests/xdp_metadata.c | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index 638c606dfa74..2f082b01ff22 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -41,6 +41,10 @@
  */
 #define XDP_UMEM_TX_SW_CSUM		(1 << 1)
 
+/* Request to reserve tx_metadata_len bytes of per-chunk metadata.
+ */
+#define XDP_UMEM_TX_METADATA_LEN	(1 << 2)
+
 struct sockaddr_xdp {
 	__u16 sxdp_family;
 	__u16 sxdp_flags;
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index f76b5d67a3ee..c87ee2bf558c 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -68,7 +68,8 @@ static int open_xsk(int ifindex, struct xsk *xsk)
 		.fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
 		.comp_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
 		.frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE,
-		.flags = XDP_UMEM_UNALIGNED_CHUNK_FLAG | XDP_UMEM_TX_SW_CSUM,
+		.flags = XDP_UMEM_UNALIGNED_CHUNK_FLAG | XDP_UMEM_TX_SW_CSUM |
+			 XDP_UMEM_TX_METADATA_LEN,
 		.tx_metadata_len = sizeof(struct xsk_tx_metadata),
 	};
 	__u32 idx;
-- 
2.45.2


