Return-Path: <bpf+bounces-69751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5548ABA0B96
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 19:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 672357B42C6
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 16:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137E119F40B;
	Thu, 25 Sep 2025 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JG4/9Smv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011C730B508
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 17:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758819619; cv=none; b=LgNyXP2na6KLeK/J1riH+GYYGPVUgUK79t4EAK+FE0nVyB6TVPfPvsLVU6lYmJx6cqEYeUDX1FVtA1tSSdPfCOetz6bwKMfQOGMrnjGMGASs5GZz4HbjbE37EVwhQzB1ZHtWB+TcKEvTxGNYr4TBFviXzCzIcwsg1dfhNWC2AsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758819619; c=relaxed/simple;
	bh=WNxAnmCw4P1TtKlBwI2Ow+v7MaCfjNgBJ6uifpDB/70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgwsnxAfCr7d+rAKYwb07/VgDozFfwlfWW4Vr8p66/yk0aA3ixGA1Ay3lqvSRsc+VNJYI6s3XjvipkxueHmMX7P73ly/lpCpTsC3HiX0RcPv1hkqucD2Y7olXLFk6x7Tj7k04WwN19oonZ1KxdTasQ5kOdk/Y/aqCMusmeBkYiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JG4/9Smv; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77f207d0891so1264434b3a.1
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 10:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758819616; x=1759424416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJ5kMbOBwIZudleYReSesMHzWocvI5qVkxY80vlrovE=;
        b=JG4/9Smv0i9lA64Q928iGiX6nn/o3A2O6sCpvHqXfGj+D1rh/UpNE8Mbx9j+MiJVtp
         WFWbTPz2fui6R8OOD/luCjoO8SaeAsk5iH/x4PKuHDOVpoDcQXCRkZKt8oAo1PCrtjcJ
         csyNLxiT/mFSm5k48YmW1r/+I0TEtkoXlw7UCngpxz9Y+Xt3r4CSy8LX1xG8s0z88xST
         Dv8xy7izmRZ2pk79dpKGPVfatkv4pGm/hMcwD58U54mRHedaQ9H2W6IIlOVWISBS9t+j
         V75hIUyhhhlWFMmBuqEIa0MhO5yxv6KLqQGgleBKdsn7ehpJbPDZRJ8awB+fbOQcNLNY
         Jwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758819616; x=1759424416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJ5kMbOBwIZudleYReSesMHzWocvI5qVkxY80vlrovE=;
        b=RSM/4Y8w5rYx+RpzG5m7Er0TLM8JyaaD4ON6oaU0C8hPyU/17d7tgZ9pHAhDFNYCKe
         tpSNuSDhYxtQbYCY33LtQ/wFmQOVBtMgSJcynu9qn8xjN683wLuj+ZGLW/ddRWfw29S1
         I6ZNiFCh+7WLL8jLGl+8oSf7VwTZ0IHhvBe5LMO8tkuVJi08uWDDNouE6baKD+elVPHf
         D1yJeLONvhey6rS+sZoGyELaAU4a5I9i55CJH5LrCuCSCVZUF454yyk7jlz5l9LNUHI3
         m6xyjqWp6ZzvdUbK35+7X/9Aq0LsFQapdz+XWPbt8L1+8+0sXTDIaJjTX7Fnx1oEITi6
         /mMw==
X-Gm-Message-State: AOJu0Yxqat3E/mZD8fq+TLQQSHFRHNpiqsa9J4CIMSV24ArtmqZTWKaa
	OMJT0PvNurNmFID90O7fUhN30QXyIXUvclmTz4ChWxo6yZ+ixHX9+9vP1YJqMw==
X-Gm-Gg: ASbGncsp24r8FM6JGZkHQjb6hSxrtaEHNi5ruUKynsI81vfPpB+ev/9QQkRYCBp+v/T
	dHcvEsbun6o08kQYc9sIljl0SB85LsRdBqQehlQjBppfbg4cq2+Xp6IMfgtGVsyGCD+xxgKgDp6
	ne3nDrXydDWKul9Fl3VBPxKwoEh0uBuUoThngPSFI733BgCwHhMbORNv8efA/myhXB6HCUSFfjG
	EK3BtQcDNSpu/i4FGHHlvN+iZGysCtv97/GSOlxAOY8x+qTjmArS80sQLEhBx1Bk7PXQIyH47cw
	Otz49a+7Rt89L+AB5tzwBYrOSIDZo7c6DZEKS9ISwCTYmXHSsAUUxW7p9eDQsHGcFDUJtKm3z2l
	iu18gyWMMz4LD
X-Google-Smtp-Source: AGHT+IF64W5FA8cGGFwXqDnRK2BW/s5biCaOMMt7UPRhhyPKNl8ixpKfpsD7Kltnj/s+mxRuFg050g==
X-Received: by 2002:a05:6a20:d305:b0:2f1:302d:1275 with SMTP id adf61e73a8af0-2f1302d14d4mr1255040637.17.1758819615743;
        Thu, 25 Sep 2025 10:00:15 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023cb593sm2434880b3a.39.2025.09.25.10.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 10:00:15 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test changing packet data from global functions with a kfunc
Date: Thu, 25 Sep 2025 10:00:13 -0700
Message-ID: <20250925170013.1752561-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250925170013.1752561-1-ameryhung@gmail.com>
References: <20250925170013.1752561-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier should invalidate all packet pointers after a packet data
changing kfunc is called. So, similar to commit 3f23ee5590d9
("selftests/bpf: test for changing packet data from global functions"),
test changing packet data from global functions to make sure packet
pointers are indeed invalidated.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/progs/verifier_sock.c       | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index bf88c644eb30..0bed5715c9e1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Converted from tools/testing/selftests/bpf/verifier/sock.c */
 
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
@@ -1068,6 +1068,34 @@ int invalidate_pkt_pointers_from_global_func(struct __sk_buff *sk)
 	return TCX_PASS;
 }
 
+__noinline
+long xdp_pull_data2(struct xdp_md *x, __u32 len)
+{
+	return bpf_xdp_pull_data(x, len);
+}
+
+__noinline
+long xdp_pull_data1(struct xdp_md *x, __u32 len)
+{
+	return xdp_pull_data2(x, len);
+}
+
+/* global function calls bpf_xdp_pull_data(), which invalidates packet
+ * pointers established before global function call.
+ */
+SEC("xdp")
+__failure __msg("invalid mem access")
+int invalidate_xdp_pkt_pointers_from_global_func(struct xdp_md *x)
+{
+	int *p = (void *)(long)x->data;
+
+	if ((void *)(p + 1) > (void *)(long)x->data_end)
+		return TCX_DROP;
+	xdp_pull_data1(x, 0);
+	*p = 42; /* this is unsafe */
+	return TCX_PASS;
+}
+
 __noinline
 int tail_call(struct __sk_buff *sk)
 {
-- 
2.47.3


