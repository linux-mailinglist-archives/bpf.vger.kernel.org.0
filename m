Return-Path: <bpf+bounces-35770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF2A93DAA6
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 00:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CAC51F23660
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 22:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF5114B064;
	Fri, 26 Jul 2024 22:20:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52CE143C6A;
	Fri, 26 Jul 2024 22:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722032452; cv=none; b=ioecfSYtOwbomJdu4pz9TY6+4o9fz/4XrMY7T4/AtZeqsCHA5uYTIUe05vwlNq6+IfZwq5S+ZIS3/lanJoUAQpAVDPGEadAmw5ZGyltBjJLFAOjKrkqC/A23P9+W91m+Iz/xlafD7bLOmBltpeEWiK1ipq/zoel2jdSWMC8rCWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722032452; c=relaxed/simple;
	bh=a2gUn3UJy9fWdFeUAAh9cqsl8BXd91pp4YtCKH80gYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MIHGde89lxlPd/yWBCmE4TbhViTj7kzBWdpqHhcvfmyvr+p46UXeUWq5EOv8rIhozy4XXVQAn+wBVP79OOe5vduUZg/Y+O/OblTjjtJG14l+zVvdjbGIuU8RKKXFvxY4dNsV47vlyPVsM38/EUReQIGu0xlxP6TC/cLxV/iENRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc569440e1so10413825ad.3;
        Fri, 26 Jul 2024 15:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722032449; x=1722637249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fhJLFDJSY+qgKMb5r3WKrRKASbs5d+B46l/MhXgWp6o=;
        b=YbOgeG/V3bsXKLPL2rZ5D/0HQ1mTTlt0vZIUDnml8Y1ikNEPWpAfyaFxlCFSvdej81
         17aNjG29Ze7Ir/e4RVvfWD/juVeJJ//mI6k9+wzrjfjhLIp7WqIrPRR220HweR2rcZx9
         xUroVv5gx/5u9t9QJDBBZ2yH5Q+hLUFrQTt7e/lpuvbIjzoCPhNyzQvYhl38RZqi8b5s
         W5Is+Kysby5FWiu/7PfKWrEOhlhob3QFEh5DwyT8RGJ5DwHuKEa4HkVw+duwwmkg6Fdk
         ixQSgGlVFOUMaTzt6aFmU6hF+e7glATc8g6+R4pVSZ0Kw/pn7D+nnsUJw0yKYPQylo/o
         CnkA==
X-Forwarded-Encrypted: i=1; AJvYcCWhNZNpp/XXYeT57cldV08uIjaaXD+qnIGQMcENoTBdB2Gin1PNAuGCLexX7oz9/RPW6NQCQ+7XzYx6N+3cH7l+ui+yuxU0
X-Gm-Message-State: AOJu0YzgXCjd3x+NUUKHyug5tWe6F9C1iG/tDQDiSbQ81jjHzTRw1eVy
	flDQYzlfFsJxyvZSbbgoAhmLkgaGVXq/NeuzYKBw98cOqhQGEqngCul05wg=
X-Google-Smtp-Source: AGHT+IEWZfHmIrWkSomdlfty+UV4YCj6mZe8xaWfYljwUfBo+xzhq9yUALiKcUP9QOUCw981Bz1rIw==
X-Received: by 2002:a17:903:234f:b0:1fb:80cf:fc95 with SMTP id d9443c01a7336-1ff048e73c5mr13153945ad.62.1722032449416;
        Fri, 26 Jul 2024 15:20:49 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f2b80bsm37718855ad.205.2024.07.26.15.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 15:20:48 -0700 (PDT)
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
	haoluo@google.com,
	jolsa@kernel.org,
	Julian Schindel <mail@arctic-alpaca.de>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf-next] xsk: Try to make xdp_umem_reg extension a bit more future-proof
Date: Fri, 26 Jul 2024 15:20:48 -0700
Message-ID: <20240726222048.1397869-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We recently found out that extending xsk_umem_reg might be a bit
complicated due to not enforcing padding to be zero [0]. Add
a couple of things to make it less error-prone:
1. Remove xdp_umem_reg_v2 since its sizeof is the same as xdp_umem_reg
2. Add BUILD_BUG_ON that checks that the size of xdp_umem_reg_v1 is less
   than xdp_umem_reg; presumably, when we get to v2, there is gonna
   be a similar line to enforce that sizeof(v2) > sizeof(v1)
3. Add BUILD_BUG_ON to make sure the last field plus its size matches
   the overall struct size. The intent is to demonstrate that we don't
   have any lingering padding.

0: https://lore.kernel.org/bpf/ZqI29QE+5JnkdPmE@boxer/T/#me03113f7c2458fd08f3c4114a7a9472ac3646c98

Reported-by: Julian Schindel <mail@arctic-alpaca.de>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/xdp/xsk.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7e16336044b2..1140b2a120ca 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1320,14 +1320,6 @@ struct xdp_umem_reg_v1 {
 	__u32 headroom;
 };
 
-struct xdp_umem_reg_v2 {
-	__u64 addr; /* Start of packet data area */
-	__u64 len; /* Length of packet data area */
-	__u32 chunk_size;
-	__u32 headroom;
-	__u32 flags;
-};
-
 static int xsk_setsockopt(struct socket *sock, int level, int optname,
 			  sockptr_t optval, unsigned int optlen)
 {
@@ -1371,10 +1363,19 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 
 		if (optlen < sizeof(struct xdp_umem_reg_v1))
 			return -EINVAL;
-		else if (optlen < sizeof(struct xdp_umem_reg_v2))
-			mr_size = sizeof(struct xdp_umem_reg_v1);
 		else if (optlen < sizeof(mr))
-			mr_size = sizeof(struct xdp_umem_reg_v2);
+			mr_size = sizeof(struct xdp_umem_reg_v1);
+
+		BUILD_BUG_ON(sizeof(struct xdp_umem_reg_v1) >= sizeof(struct xdp_umem_reg));
+
+		/* Make sure the last field of the struct doesn't have
+		 * uninitialized padding. All padding has to be explicit
+		 * and has to be set to zero by the userspace to make
+		 * struct xdp_umem_reg extensible in the future.
+		 */
+		BUILD_BUG_ON(offsetof(struct xdp_umem_reg, tx_metadata_len) +
+			     sizeof_field(struct xdp_umem_reg, tx_metadata_len) !=
+			     sizeof(struct xdp_umem_reg));
 
 		if (copy_from_sockptr(&mr, optval, mr_size))
 			return -EFAULT;
-- 
2.45.2


