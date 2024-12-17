Return-Path: <bpf+bounces-47129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6F99F55BB
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 19:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50EC016EF6C
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 18:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549641F7563;
	Tue, 17 Dec 2024 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDbtoSoa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443C450276
	for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459080; cv=none; b=Bdwqn9s7tH5GgxOSNDHI17gnY75iKM6Yv3aU7ixO/P6VNjQlLDPYBQPpg/Le1pFIaWA7lmvkRD1tsEyDciBdvh2//Ks2NfcOWMOW/QTvdI1uET53QGE+5xUxxItZeT4RaGpjo9j0jFuzx6D0hlzkPS1XnytvbSdVTrs+mEYuMEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459080; c=relaxed/simple;
	bh=djZOmK3mi+8enruCRE15Y+3jzUoqVWg4zRPf9QZVYrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oaMsFOwWbarKrOfugWLOeeNA166qJC7xjPMvK7I85GNAYlwzFKgRKdgYaBloF02Cq88nRzKMTSGogJY9cbmqHIu2d3xsnBiz1Mj4bPDlCxngCYhmTuB/VrEUBBL6230Dt7mi0QZg3yvZaVUQkzLWsovq15PNQ5sRJLnL8oP+kIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDbtoSoa; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa662795ca3so1270058166b.1
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 10:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734459077; x=1735063877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oesVyqgsuhP4JheOK1Zd4Y+a2JPRedDJHjsOFqdIHxE=;
        b=EDbtoSoaMjEpoeEYmdIVFdRlpCGhJQUeXlQCe/KGw4kpUjK01aAs/RmOnfuyzfWaqW
         vNA8M5XiXNPyQP1CNtXu3FGUMKcmM0NKVZqQ+KIsJBMbonO9rMRq5VGUWBJSRL8PMFtH
         3EI9q/Hla+Un3xZRIj1B4RlJlyzzWEhHzfwwehiTQhRCEYQT6Q5H2Fn/6tEwwuaMMabF
         kQLxLHoHkIoGJf842dFP/w5McbkBaya9YO3Sxi+icJfEoO4SitFAxnKCB350LP9coV6d
         q0ij/ybnyzOM0SaGb7KhDzOWoHegkGtUhxi9TpZngFP1ZxZVwHBkg9QtInC/4yEYLyKC
         /xAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734459077; x=1735063877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oesVyqgsuhP4JheOK1Zd4Y+a2JPRedDJHjsOFqdIHxE=;
        b=lvkHA0oldgERSlsR4yjMzMsdRjwmNn4RWLTgRVGWN5zcc5EmRVKPdqWfzUhlrwDj1G
         fDFdmuZ19dQ1EpJ2KdprOrgPaSHvx8Om9fLVxOBvqrpi/FwSRaU13DiWhfZER4J3PSts
         +xt9kkHvbX+eRDfL0liOvjM7KKUF3EoOHf4csGaooVcramriu/4XifX77x42twTPKZ6f
         6LGbMtkdOibwd1WyRKYH+bDGrE8W/r9Hnd3LWpw+k6yWBlHKOJ5Sn9vxbDcujhm3G+SX
         vAfr1IUzh8ilNEYlrh8vIxCisO+5xu+nAWfooHW8RiFj5vlHHc443qS5XXNSnzIwCkGv
         OARA==
X-Gm-Message-State: AOJu0YwrIob2jNx1XnvuufGOsOF8+ByiZLvG/H5qORlVjYMRn+9BeDjI
	8OGokldY0ev2NuodvC9UW/f+Qk+kiLCqvnEKSUPa7ZBNd5r3xH6lQjE5CQ==
X-Gm-Gg: ASbGncvcamAi50pO7l0c9ChTOiCOTJjNTHybt0F5peqjei74mjtvcGZu3/PGbuk6nwO
	f1U1xVwqtnENgw4VpwOeCRMyR6LYHTkY68YjVriVzxTSlb0wyEkw4FWgsm88HsL1ba4qd3nGgzx
	FRdQaf56jkjtWeunL6ru31dA7Si+ARmNmR5eHmbRzMIO0sAxYoUzoRXCxChujGpul9JSKKtfv8G
	lPNFTtd1IpJ+oqtQBe2RUGQ2EuilmqpsvTJIyMFm3bKfq4YcuMpUaPbgfUn22o0mLEZJkM=
X-Google-Smtp-Source: AGHT+IFuvpAhG06RiO961GTp0FheJLDROf8xSemNQ9/Lu9tkngVLbj0PQnzP0V5WCtAsbO61JCDV0w==
X-Received: by 2002:a17:907:1c01:b0:aa6:bcc2:3f02 with SMTP id a640c23a62f3a-aabdcb7fddamr388422366b.29.1734459077170;
        Tue, 17 Dec 2024 10:11:17 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::7:a0aa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96359934sm464824866b.98.2024.12.17.10.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 10:11:16 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] veristat: fix top source line stat collection
Date: Tue, 17 Dec 2024 18:11:13 +0000
Message-ID: <20241217181113.364651-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Fix comparator implementation to return most popular source code
lines instead of least.
Introduce min/max macro for building veristat outside of Linux
repository.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/veristat.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 162fe27d06f8..9d17b4dfc170 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -26,6 +26,14 @@
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 #endif
 
+#ifndef max
+#define max(a, b) ((a) > (b) ? (a) : (b))
+#endif
+
+#ifndef min
+#define min(a, b) ((a) < (b) ? (a) : (b))
+#endif
+
 enum stat_id {
 	VERDICT,
 	DURATION,
@@ -904,7 +912,7 @@ static int line_cnt_cmp(const void *a, const void *b)
 	const struct line_cnt *b_cnt = (const struct line_cnt *)b;
 
 	if (a_cnt->cnt != b_cnt->cnt)
-		return a_cnt->cnt < b_cnt->cnt ? -1 : 1;
+		return a_cnt->cnt > b_cnt->cnt ? -1 : 1;
 	return strcmp(a_cnt->line, b_cnt->line);
 }
 
-- 
2.47.1


