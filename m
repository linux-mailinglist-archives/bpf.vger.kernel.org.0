Return-Path: <bpf+bounces-72342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3D9C0EDFA
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 16:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6167189B534
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 15:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8B72FE057;
	Mon, 27 Oct 2025 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtT8YkLa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1182E611E
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577738; cv=none; b=oKXGVav/AO/ADteyny7Lheg2e3w262zbI9HdMlvlmDFAOmVzEJAvIuGn3OpJxHH+FwonrGJYYMycC9rvAvkKm7L2zlMHsP2EUF0CiiBP1KrGwBFTZY2G4mDMTWiPRvCzeai8fxyoqBTJ8qIaebaOxTN5v2G6YhhHXnOiLUH6fyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577738; c=relaxed/simple;
	bh=E6TanHOEWRAN+pm6bYT8hZApuV50k09I3qBAuiVZgYY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cgxBbEvzu+ikl9bsAplB5nzF+OVMST+Kf46OikY8xjCfi94NMbSHddVRdCBhiaAUS6BuUCEKEpzWhivhXqhf1dV9DjtaJu6qewJAIEcJk2JTPi+6SFQwc9jHkthJsLT2pKA7vnd0wWBVTOMM3XlmtEF9ybUMU9J/gp4foI1SfcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtT8YkLa; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6cf07258e3so3467473a12.0
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761577736; x=1762182536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CWC5gkPdxGSTgxFMIx5rrToJ8P8ezVw3vUIN7VkwkFM=;
        b=mtT8YkLaF20/D627XKTVaexicqyuPSry97S638w8M3Pv6rEIFZb52oEHUiI97c1cS2
         gzkRyuVa5qhodO48bqXGfRmN40FNV7+OUZeeKs5Uku+5sTjSeGHXeFnbnKsQS11MLYCm
         LM4/neskhqzXvSDnUdWRKs46yz/glsqfd5WdH1nuRvt16KGgpRc9JUbi7jD7VsMOUMP5
         XOLXY+2TVyrKcpuBe516tYlVF/fsQjxflUe/4OR6aVtINDLrlDZbjYGIATpqD5MHZjIB
         fgCr9VnHMAO4CJ0K6uq0riu812ZaXAd2dpzjsAl839oyme0old1ZTHQSu7gKZutQ0pcK
         K1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577736; x=1762182536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWC5gkPdxGSTgxFMIx5rrToJ8P8ezVw3vUIN7VkwkFM=;
        b=EFAhMlRv1m67cq8MachsWIOh1SjdpSgpsaxJgJM/xbYa/dWjA6MH/1WJqZ478bZ7s7
         DU72s3N6wONmMjOQnU8sQxToOovdGVE5fNY59K4czbDW5RTljf2kC9/O/+7xEQL9oPJp
         JJjXTUSP/w1vhST99FajoyjZniD1DSpTch3vP92iHV2uYsy954VgWj8Edekrhj/cnwac
         2GZSNzyAL6dTpkwCrrASKwg/TErnqSsRdaR0mn79qRo3H6wtqTEMHbmtnSTvwyK1c2xj
         MVvbHf4W6u1uBJvsQiTi1CR9QZ8V2Wgzbd5PbfrtW5sdLgNvCsOEb8qsN+aV+8O+QqaC
         /Rvw==
X-Forwarded-Encrypted: i=1; AJvYcCUKEPpiBL5vg47MpWelLcN1NEur02xsVbGaJpZNRZNn3UAwv2Sv+K34dSGs0epJyzPPs6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMbrghIGHEu/QslrfpmASnxvdLG/43VCpISakk7Ph4YiKZnSi1
	eLPlAQwsN0NwKr+/jwuH7+hy3WP9L2f+1wfTTUjOo/9I5AfATsHqo4aa
X-Gm-Gg: ASbGnctXblvE2r1E0CF4WD1wggPM+TjpcIf2RGpHwUs3SyauDkGeXRqM7iJQj7cYGrl
	LHtaODzo8xMf9DHzSp30DyBi2CPHIROV4VTpa3fkmc6PGU1uy9DGY1PndFcrQRYHs1xEN9Cds9o
	xrBSZs8N4oRCbNGkQKcaE6nNA9y8wEjmd7osGfjlJzYfZCyCX6R6UCGUlik71z61ScoJtLABbt4
	EP7hvHIuT/g8jyliNvCoYd6/OJYbpFYWOvhzHm8Zmjn6k0Hbjyqcsr/lA07zXD447rynpdxRVSV
	G6NrdOTWPVALtYZpub9gQOVswYojdzdkQ/7/jTV5zKuaQnsL/xybvvMQ7wTLV9teFYCztrvaYuq
	gAfjmI2UweJaNbk/zuJgQT2Ys2vRtoYwWoFTsxoz2+vJsDNIQNpaPT7c1aJ+fk0GGJ7hQVPuhbw
	4VtalsPK1Ow2o+/cr1F6YTL9CH/guLz8cp
X-Google-Smtp-Source: AGHT+IFHIscxo7imWnRY5urYdW89HjcRlzIelV1JJZA81YcKKcZ25FMolijoFKaqSlkIM5bdPfTYvw==
X-Received: by 2002:a17:902:f68b:b0:27e:f1d1:74e0 with SMTP id d9443c01a7336-294cb37a547mr2902695ad.17.1761577736199;
        Mon, 27 Oct 2025 08:08:56 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498cf358fsm84405955ad.20.2025.10.27.08.08.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 08:08:54 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] s390/mm: Fix memory leak in add_marker() when kvrealloc fails
Date: Mon, 27 Oct 2025 23:08:38 +0800
Message-Id: <20251027150838.59571-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function has a memory leak when kvrealloc() fails.
The function directly assigns NULL to the markers pointer, losing the
reference to the previously allocated memory. This causes kvfree() in
pt_dump_init() to free NULL instead of the leaked memory.

Fix by:
1. Using kvrealloc() uniformly for all allocations
2. Using a temporary variable to preserve the original pointer until
   allocation succeeds
3. Removing the error path that sets markers_cnt=0 to keep
   consistency between markers and markers_cnt

Found via static analysis and this is similar to commit 42378a9ca553
("bpf, verifier: Fix memory leak in array reallocation for stack state")

Fixes: d0e7915d2ad3 ("s390/mm/ptdump: Generate address marker array dynamically")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- update the fixing logic to prevent memory leak in v1
v1 link: https://lore.kernel.org/all/20251026091351.36275-1-linmq006@gmail.com/
---
 arch/s390/mm/dump_pagetables.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/s390/mm/dump_pagetables.c b/arch/s390/mm/dump_pagetables.c
index 9af2aae0a515..ab0c1fcf2782 100644
--- a/arch/s390/mm/dump_pagetables.c
+++ b/arch/s390/mm/dump_pagetables.c
@@ -291,16 +291,15 @@ static int ptdump_cmp(const void *a, const void *b)
 
 static int add_marker(unsigned long start, unsigned long end, const char *name)
 {
-	size_t oldsize, newsize;
-
-	oldsize = markers_cnt * sizeof(*markers);
-	newsize = oldsize + 2 * sizeof(*markers);
-	if (!oldsize)
-		markers = kvmalloc(newsize, GFP_KERNEL);
-	else
-		markers = kvrealloc(markers, newsize, GFP_KERNEL);
-	if (!markers)
-		goto error;
+	struct addr_marker *new_markers;
+	size_t newsize;
+
+	newsize = (markers_cnt + 2) * sizeof(*markers);
+	new_markers = kvrealloc(markers, newsize, GFP_KERNEL);
+	if (!new_markers)
+		return -ENOMEM;
+
+	markers = new_markers;
 	markers[markers_cnt].is_start = 1;
 	markers[markers_cnt].start_address = start;
 	markers[markers_cnt].size = end - start;
@@ -312,9 +311,6 @@ static int add_marker(unsigned long start, unsigned long end, const char *name)
 	markers[markers_cnt].name = name;
 	markers_cnt++;
 	return 0;
-error:
-	markers_cnt = 0;
-	return -ENOMEM;
 }
 
 static int pt_dump_init(void)
-- 
2.39.5 (Apple Git-154)


