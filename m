Return-Path: <bpf+bounces-72215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B08E0C0A548
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 10:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989263AE0CB
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 09:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60C628851F;
	Sun, 26 Oct 2025 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF4AZV6m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D192F1F418F
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761470049; cv=none; b=lvGGSd9fXLnfAHswAYwL1bOm76XmirEEvZW69VnZZEhA65Jo4GPxHsrtINggzOvBrjijoYPniOWyucLJ5T/sYtr9zWDFAPsV1FpfSkvxm9VM2neDdn3D3XI+TxzJAd1BjQAWyVGJtpCiA8whSveCu7e/TjwdVy/uCR2vllewCoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761470049; c=relaxed/simple;
	bh=yYW/ak1UJm3E5gbSPOy3veYjolaLM2LzMiaO2+3Xn2s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ft2E8uILFzKrf8nLT3B+0etjkMaVkltu9dLmmLns+DpMcPLL0A3+ibGwCir01p/1VrSXrvC7ctbcDNXVVvxYAVq0iyTNu0rPmOTkiLj54+hLn/Bl/0xPySpQSoYf2f2IMLT6PMGD/fZYFOUkyNv48z59fC31cvCiaS1NbGQq4l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kF4AZV6m; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b679450ecb6so2614307a12.2
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 02:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761470047; x=1762074847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QKaKeVhm5UnUNE6DNnz1ldVsC0c/aJHI3r3WJDhZOKs=;
        b=kF4AZV6m1tneegcMM2wixBcccRSfwk5zcS/uYPlAqNsYE/vddP4wYRrK6siY064vRJ
         loyTut8uMFLWYzACAo1NQfY+sm/r0KNI1Y5mUUshvnm7SFVcnaVN7GuNRP/NI4UY6uCM
         M4vVrnFzrqnDF7lpj31GH5+8L5f5uaiI+N7rDaVJuiGwQve8BEJUb8zfroq2CXoSAisB
         RYV3Jpb4ZVbxHjYyf3P7ickYXHZfvTHKn8AFxbVsLgTAUx6p1hR+Jxz98iKenZ3TGAFj
         0Azp3fmNunv94+5+6SsDLAwMdf+dGRp0tFRP8pUF09nSIhGD4qE4EF2IZ4FUeHFoDQzG
         EexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761470047; x=1762074847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QKaKeVhm5UnUNE6DNnz1ldVsC0c/aJHI3r3WJDhZOKs=;
        b=UYvu5ir6i2zFiwVvPB498EpigBVkCrAFub373y7XFKPRM9M8LWiEBo9PXJrUNb9uy1
         5GvUgnK1lMk8hwVgLgdsrbYiocarHAoz+XU2BgT7/ewvyZhEZqsaXaBM9p5ODHPwyaT5
         iRDN6YJolp50U717Z1Az0aV2zT2tLEuqFrXB2ljYQ0a2bywqyKTXsvfaHLeHbkv1XzNd
         DYyrCWsz41f1Y08dMS1uUcAtiHsahOlA74mnqnWHu40hnSanpia0M4u2r80ddLpkTUr2
         j83AO2DcPZsCR8SjEN3lRDnh27hUVr73wmyJ9QFmsz0iodl3E5Mgkb4dOAKupDBPtpOh
         OsBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhNfRBGJWkrX+mCGLn9f8Ppi9qTmW0DA2E/pSeGWNAoVp5iPJKWrsN4u7fqml4VNnpfzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGwRKD7midSMwhuWjaq8+hgOxJXA1hJuLlitUwjB9s8lc2eoEH
	it+ojGDvXZxY9y9MKFUo3n/cLVwLcU/o4c7r89mSd43OCKBv99W1djvH
X-Gm-Gg: ASbGnctzQxDNlaaibQspz3CKYg+fUE4FOg//eDjKotTM2d+y31TMgXrvjjppLujuxX2
	GQXgUyEER1P2viTiuxQLCj2fLwrR9ETJgb7ceEdRnFnKHNjkggLYfYdgNH8DD5BLleRurBsgVQt
	oQyw6y0I2gc1IJC0rViAFt/KIUBVzd9+uqhEGoQ9QzIWw3+RLulUPlFQ5KvRkh84BGYEKXDld1Y
	vRYesV88nYfRogBos4RbEWAaMjLcdO6DLtDMEHx9q/4NWLb0SXgsa2BoR5KADSYxv4xwZoRMOtt
	jp9z4thH4XLm/JzgUAZ354TnJWZ1mD97HBcThF6aGw0r2eOBgDYWPefCopH/x9E7Z04U4/PSU94
	ufQCzFH3J7XHhQ6IDqAKtlOuUEgoCnD08dezg+xL20xnQv8mFaWWEM8fsP/02ZbEarxhKrwU1zw
	E6me7yxYgO6x3NA6w2RUTAXQ==
X-Google-Smtp-Source: AGHT+IEe619zwvr7QyCnZh0FhG1JilOPvnQxrGb0fx5QjWMkrsvOWzzaRjQT6fRCzSTx06geLcWkig==
X-Received: by 2002:a17:903:32ce:b0:290:b928:cf3d with SMTP id d9443c01a7336-2946e299a01mr162561475ad.59.1761470046967;
        Sun, 26 Oct 2025 02:14:06 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33fed739b81sm4732043a91.6.2025.10.26.02.14.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 02:14:06 -0700 (PDT)
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
Subject: [PATCH] s390/mm: Fix memory leak in add_marker() when kvrealloc fails
Date: Sun, 26 Oct 2025 17:13:51 +0800
Message-Id: <20251026091351.36275-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When kvrealloc() fails, the original markers memory is leaked
because the function directly assigns the NULL to the markers pointer,
losing the reference to the original memory.

As a result, the kvfree() in pt_dump_init() ends up freeing NULL instead
of the previously allocated memory.

Fix this by using a temporary variable to store kvrealloc()'s return
value and only update the markers pointer on success.

Found via static anlaysis and this is similar to commit 42378a9ca553
("bpf, verifier: Fix memory leak in array reallocation for stack state")

Fixes: d0e7915d2ad3 ("s390/mm/ptdump: Generate address marker array dynamically")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/s390/mm/dump_pagetables.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/s390/mm/dump_pagetables.c b/arch/s390/mm/dump_pagetables.c
index 9af2aae0a515..0f2e0c93a1e0 100644
--- a/arch/s390/mm/dump_pagetables.c
+++ b/arch/s390/mm/dump_pagetables.c
@@ -291,16 +291,19 @@ static int ptdump_cmp(const void *a, const void *b)
 
 static int add_marker(unsigned long start, unsigned long end, const char *name)
 {
+	struct addr_marker *new_markers;
 	size_t oldsize, newsize;
 
 	oldsize = markers_cnt * sizeof(*markers);
 	newsize = oldsize + 2 * sizeof(*markers);
 	if (!oldsize)
-		markers = kvmalloc(newsize, GFP_KERNEL);
+		new_markers = kvmalloc(newsize, GFP_KERNEL);
 	else
-		markers = kvrealloc(markers, newsize, GFP_KERNEL);
-	if (!markers)
+		new_markers = kvrealloc(markers, newsize, GFP_KERNEL);
+	if (!new_markers)
 		goto error;
+
+	markers = new_markers;
 	markers[markers_cnt].is_start = 1;
 	markers[markers_cnt].start_address = start;
 	markers[markers_cnt].size = end - start;
-- 
2.39.5 (Apple Git-154)


