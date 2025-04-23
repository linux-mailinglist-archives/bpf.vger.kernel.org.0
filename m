Return-Path: <bpf+bounces-56485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4F4A986F7
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 12:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2205A3F34
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 10:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FB126C398;
	Wed, 23 Apr 2025 10:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDYTcBCs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D245D268FEB;
	Wed, 23 Apr 2025 10:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745403131; cv=none; b=ph9rJvHrgy6ToeKe2X+HXebebhxzUUREiQpRxahOAsiU5oji6c6fDPnZPmTFczBj5lSndGVnZmkEb4LYG91WtGzfQ17Z+RwN/QCpbB/m0ZGVzz2/laSVJ/stIxf+lQw4w8afp0MNneo8ovQnuqD1cQwjZ3SvSP9ONDBqMVCh0Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745403131; c=relaxed/simple;
	bh=0tPJ8mi/IaknU+odJztdVn7rnmNajNaShzpp0+/yzUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QAUar7QN/BN0ioPgV+fv7w3Ivl3zakiRETfi6I5qWEZIJ9e+AMKthoOUovCZgm/OfcH3asGOJhdsr/7SLT9DcewODcAXujWW0J3D16QE5SrjkGC1LpevgnLs4/X80gi1LNoRD/ERoWH7bIE7hOaqOGOKMX3rm39hzNxm1cRPQEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDYTcBCs; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7376dd56f60so4435646b3a.3;
        Wed, 23 Apr 2025 03:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745403128; x=1746007928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+5GhlYau1vYRJo6luDQW5bI32zszXHjJmD7lMKKoHpA=;
        b=LDYTcBCs29mewevTAtAF56zHeKUOstoRye0W+MDmrZRDiH80BXs0eNVY2cec3i5KXK
         7u2m6+yHTTAgHQ0lAFDi/MbKgPSrWNwiABxbDgqk91QkxA7yIXpKKbZa6HaPOrRHAfFy
         uA2j5Ojf0aOHC+H5SJTo5PJCUGXkcB4zq92ZO8JaGGZX/Zdz5TRFsyBpkzU+GHs198/Q
         5k8Q2FCbbq0YO+OGHgqUd4KZ01udfs/uo8F37T3GGw9qq0cjlXbJiQCCtD3Mpj3LHvdW
         Fq97m4PD2aX2sam+DWShILUqJ6ao0vrlHn6TQPa2EsBSieARV5z9lXSc/cV7OuvwYQSK
         0kBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745403128; x=1746007928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+5GhlYau1vYRJo6luDQW5bI32zszXHjJmD7lMKKoHpA=;
        b=tVoG0jgcpdzjaLHZf5ID8oUAzFAPWRxQ4ClcnM9c6biFDp1tzKNOjt5FeknOKkZumb
         V8M3/g8HcgijeJ8BOBMTjqpqNTJoQKzyMA9pSJkfK5phc7zYAgwHCnIITVKrAO/QWpNe
         teCVor+yD4GExlC+mcwaycDzxkIeJ5lMG5TYDllD4aJHz1G38wnm+5OCNZTv3MOyJq6N
         Va3IZ50c+pONZt5uY1r3jQUlPix3dfWnQSpIIoh+KCoLM64iE0i8giuv+9kCmQ55pEga
         gqA+dUmXC4dzk29Z0tcJz2POZhWfRNf4uTsNP5hqoiVDcND/zSBI0Uv/F/W+GMSIoqFl
         8H6w==
X-Forwarded-Encrypted: i=1; AJvYcCWiQSCM1nKljprRne0bwOy8FC31nPawwOnGYNDK6zhK1TkfgY398BMVDOHlZchteE+I7k8CNvrb1ARwm0UR@vger.kernel.org, AJvYcCWqZQyqIFT1A9MZ3t/Ftk8FSYdM5fNcdfNx3kzVBZ82gkyz4Cy6p4niwShkJ1f53iQWhYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzjSvQdP/bZFYfNpwqRxyxd+fRanh5SbmkILfnDpgaQsM9Mi+/
	2rq8y371p/C9vl6oSt9E5L8IFCSCfomZd0H3VUV4cQbgVZ2QJ8/puEP6F3SV
X-Gm-Gg: ASbGncvHYB2XVSY31cKyyENpNGoMnhs1DctzkmsrCQKiEeLcZjLtQ7Wkgx6kmA+GZYv
	5bNsaaecGxRkkfdde8vgAa9XJ/E89VBnTywrdI52j9Ww1zm9eiJXW7loLyaclxMdkgAgdIE5L1B
	wDk1DVfrI1rUz1P+SQGSzd2VJW22gmN4NTNovlvlydPx5KNwkk9v5sktQ+0ByyR1SCTajBYf7Ox
	o7ZjNdjhs3vyiKOhhvzuLB/wktujfU2AgJXkS1uchls/ChN8bqFX8XfjFJMTG1WhYmoUZ/t+KGS
	DNhAkc5mcCTY+eJInTDxHVtmvMuKY6Opb+ArGn+sEztqfkDxVnG7tA==
X-Google-Smtp-Source: AGHT+IFYnhOBn5pS9shSq5SLZtSLmusdGP2QV0V8marPCcCYHjxdzclWwlwxEVaAinCSJFTwfmlfew==
X-Received: by 2002:a05:6a20:9f4f:b0:1f5:520d:fb93 with SMTP id adf61e73a8af0-203cbc72b3emr26471767637.24.1745403128068;
        Wed, 23 Apr 2025 03:12:08 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:933:3ee4:f75:4ee9])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b0db157ed7fsm8740970a12.75.2025.04.23.03.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 03:12:07 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net] xsk: respect the offsets when copying frags
Date: Wed, 23 Apr 2025 17:10:47 +0700
Message-ID: <20250423101047.31402-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing offsets when copying frags in xdp_copy_frags_from_zc().

Fixes: 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 net/core/xdp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index f86eedad586a..a723dc301f94 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -697,7 +697,8 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
 	nr_frags = xinfo->nr_frags;
 
 	for (u32 i = 0; i < nr_frags; i++) {
-		u32 len = skb_frag_size(&xinfo->frags[i]);
+		const skb_frag_t *frag = &xinfo->frags[i];
+		u32 len = skb_frag_size(frag);
 		u32 offset, truesize = len;
 		netmem_ref netmem;
 
@@ -707,8 +708,8 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
 			return false;
 		}
 
-		memcpy(__netmem_address(netmem),
-		       __netmem_address(xinfo->frags[i].netmem),
+		memcpy(__netmem_address(netmem) + offset,
+		       __netmem_address(frag->netmem) + skb_frag_off(frag),
 		       LARGEST_ALIGN(len));
 		__skb_fill_netmem_desc_noacc(sinfo, i, netmem, offset, len);
 
-- 
2.43.0


