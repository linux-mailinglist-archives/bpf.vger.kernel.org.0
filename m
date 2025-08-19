Return-Path: <bpf+bounces-65981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3870DB2BD96
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 11:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5EC41895E69
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 09:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F67631A05E;
	Tue, 19 Aug 2025 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIsn3gC0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB5D31A046;
	Tue, 19 Aug 2025 09:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596096; cv=none; b=irpZw8eVeRazZK9H0pDHaAlSW7ayN24BOC9wX0Xbf2cHgY0tkCpUV/B51x0sI9mlC1KH9JBYiX/f/qsiQ+J7gZD7Kdhp70sP/lTqFXMuNOzQwSeD3ct6hx7zpgKMWJvPawPDNseHA6Ey6K4EWXxd07DKmdVDcyzLCOPiosgfzSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596096; c=relaxed/simple;
	bh=Ta+KXGP5P/G/yZ89XMbuCBtvz/po1cUgAXq+JKoB+A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXmD+aTR1z+n0jQ8HdXCzaTCIK5TTFSTYVujSkM6YJvKsKpee42lOb31a4iAGu7h4lzZZm7LdC5qVSCt20zS+e+t/UpM26CDhSM4+vup1XmmIowS2TRDzJ0+LT4b+kjnm2kcSrLH4IumdLk9Kb03GiBwouTfaBf8DDG9ig4z48M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIsn3gC0; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-76e2ea887f6so3768545b3a.2;
        Tue, 19 Aug 2025 02:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755596094; x=1756200894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QVMhbhOtLzLkzu3HrcXzL+1NJ3SqUwSRILS3h61pRg=;
        b=KIsn3gC0ISMUzggiwttifJVezAwLjLV15prPytig2Lo41OHZ0ra4eZUHqdo7fXru+5
         m33qWrhDSeCks0bLtAx4ygHRlH3Yj8SZXpyQhUQ5evL2brDee/4oM/liu/oWXTmVH/Fa
         VN5BzUES2rtsGB1weY+spNDTTQnuGLRKaW/Gid/G+ZN6nz0abugo34OItahm20bmC/RQ
         Ohb4j3Dy419Y7XVyVaQyk6TMHyVNP/+LOCqrRB4GpFjtovoAYMFWUw/l6c5pcZFzfYDr
         7Dd6K36iy2slJidcdNP1Vhg0smQCxjhljdExZCgvFxa73yGyHNNDVonQYbAkGdV3bwE6
         fgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596094; x=1756200894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QVMhbhOtLzLkzu3HrcXzL+1NJ3SqUwSRILS3h61pRg=;
        b=hFa07F5YrPuR7QFAswj1sJ64weOiGaI0pQub4RbB0BdZiLW3hSrMr7LSdviCYJXfYw
         SvcxTwvP1KJ93h2A8+wJmkEWqZgS63ZSkPf76U+f1B4sgfuUO81TI+uDEoAPuSS4IT8L
         hne34cLD5tllHcdaMHHT3n9kdkJnalfZwelQQ+C+9C9JRZX2dBmh83FudmOktfhAfB7c
         gaQ6hC5HD/badxDeeQVklpfNOAObsXMFmkio0hX7/n+fTwJqIqjOFPR3HRBxnuM0l7SX
         rXTmY1Vc3uQ83bPPuNiPI3ItdLwTuLyZBz64/V7dYpdol03ZYcbQLWTUEJcviSCcJ3GF
         tLgw==
X-Forwarded-Encrypted: i=1; AJvYcCV+rTxniB1pnr0yi355njExTphwvgktJ6tzxmn/g4D27kJj5rs1HibQZyitLocNboVsaAmksKJO5vimv/7q@vger.kernel.org, AJvYcCVQwUxYdDNMhwmsUbT/t7icu+8I1HsUYkHPWHRYPywMcxrf/tjycHRHUDXe6nowg2OiHME=@vger.kernel.org, AJvYcCWNcNR9AiCTjlGhJDPniK9WNwhJbdV0GXn16i3BtX+666kBMHSPCwc2XqFgG3GAtATPW1H4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0BRust2iUuVYRH5eicxzpg1XeqmfSZTmwG6slu6VCNYEnesse
	eC/emyUfC2WnBcN6iRDEdig6/NUsFgm5KNLNRMS9Y1/TcYzrcKMS5Tp/
X-Gm-Gg: ASbGncvyKuKo8tA8ueHZMseUont9+1e6t/d9bSxkv/OBgIncy1fbNh4fyClzS3w34Cd
	XqVij1cXu5xrZ9TAOuT8qQX/HdgrYnjV0Ne54OKtg6ghbsNejvPrAaudTwfGzg/ygXf/Ol/ZE0X
	7XCBkFqGiXXR5JskR9GYUEwi8aeC8v3JmoYS7E//72V8hDiRcn5k1BvdAXpi5LsHg5mgDxcPJeu
	Y3OJUXgxvIHvVyLDFwyPoTuSLuKswKs6lOPGwz4/vDUvT0Tpv8qlECuewNjqajsGXQzPJqKHBqm
	ZjVJwELs2yoRxswn3zHPXRxeobok3VxSdR8ikalM2ZI53AQrD0SchJiw6SQE6X5to7vO0/sFJRR
	5QbQBJ//jxNhvOqvgSgw=
X-Google-Smtp-Source: AGHT+IESLmw4DD5Ki9GcI9bHIcRKZU1nYhicBWlVNkdY+RJM1g1BAYjGa55ISfDgFrhmGnv9FdFmIw==
X-Received: by 2002:a05:6a00:1d8d:b0:76e:8535:53d9 with SMTP id d2e1a72fcca58-76e85355e49mr1210485b3a.18.1755596093808;
        Tue, 19 Aug 2025 02:34:53 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d1314a4sm1990945b3a.41.2025.08.19.02.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:34:53 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	paulmck@kernel.org
Cc: frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 3/7] bpf: use rcu_read_lock_dont_migrate() for bpf_inode_storage_free()
Date: Tue, 19 Aug 2025 17:34:20 +0800
Message-ID: <20250819093424.1011645-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819093424.1011645-1-dongml2@chinatelecom.cn>
References: <20250819093424.1011645-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use rcu_read_lock_dont_migrate() and rcu_read_unlock_migrate() in
bpf_inode_storage_free to obtain better performance when PREEMPT_RCU is
not enabled.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- use rcu_read_lock_dont_migrate() instead of rcu_migrate_disable()
---
 kernel/bpf/bpf_inode_storage.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 15a3eb9b02d9..e54cce2b9175 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -62,8 +62,7 @@ void bpf_inode_storage_free(struct inode *inode)
 	if (!bsb)
 		return;
 
-	migrate_disable();
-	rcu_read_lock();
+	rcu_read_lock_dont_migrate();
 
 	local_storage = rcu_dereference(bsb->storage);
 	if (!local_storage)
@@ -71,8 +70,7 @@ void bpf_inode_storage_free(struct inode *inode)
 
 	bpf_local_storage_destroy(local_storage);
 out:
-	rcu_read_unlock();
-	migrate_enable();
+	rcu_read_unlock_migrate();
 }
 
 static void *bpf_fd_inode_storage_lookup_elem(struct bpf_map *map, void *key)
-- 
2.50.1


