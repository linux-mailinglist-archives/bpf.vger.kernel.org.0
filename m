Return-Path: <bpf+bounces-66162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D64B2F35F
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 11:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FAAB5E735D
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 09:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29242EF669;
	Thu, 21 Aug 2025 09:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfoGFXys"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1522EE616;
	Thu, 21 Aug 2025 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767203; cv=none; b=iAb4aspZGIKzVRgXro+QyYXrxAkJLDjrRBwQee981+OEv87CTTLlUn1Wi5RqVLcaIMSo6nV5H/9rm6K1mLEMGkCKDSC2kHBMTTPDycbz1L6WaZXToveEtSgQ4pMnndSxHiCR3tcJl8JKURtru/mNfDNMaPnwnXTN4vCVLL9gfzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767203; c=relaxed/simple;
	bh=Ta+KXGP5P/G/yZ89XMbuCBtvz/po1cUgAXq+JKoB+A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXMD+yNMP/wg4DiVihXK4ujLnjXuYq/DrawaPZyeyxO6G7wqeZ+l6HfgKEMiRRcmcOPLIrImDJUqhlIYiw+a2IkmQWRep3N5Tpu+2PffLy4S0oC7KLn7cYeesRrVChx4BWAi20aludfLWLXdxZVvcaa0rAr7GTrpzrX3XT5JFT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfoGFXys; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-32326bd4f4dso630106a91.1;
        Thu, 21 Aug 2025 02:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755767201; x=1756372001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QVMhbhOtLzLkzu3HrcXzL+1NJ3SqUwSRILS3h61pRg=;
        b=DfoGFXysZDZZnLuHGedmbGJZi2uHWauEQ28ju98ABZjHIJwBBtuoxX1ngO19WZsjM1
         uyY4neEwz+7OU0a3JmFuKWMoBQ5b8QTxpCUPZKD/mFCeXmicI+i0UGsHz/1t+qdAZnte
         yG8/UV6/tLKUWhjzB1n0h4Qlq6JUc3jIY30SIlHgjjAFXAaeb6wLB5KJ9ChnhvtWAdT2
         Q7DUSVFPLcM7911jhl95c+pFSJP8tNGIME0qRbyPB8LDy6VL8SVLQTcm0R2DvGksn8t5
         MMpY/8fFTyrc7jl9diSuyj0IKwDm1Jz4+vwnzRkFpXqWTs3KfOaqaCsQ6nYc4xPcwqZc
         N1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755767201; x=1756372001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QVMhbhOtLzLkzu3HrcXzL+1NJ3SqUwSRILS3h61pRg=;
        b=TTMNVMgTIK76qJYDhFambL2alLFUfkHQFUjF5h7rljwTlC6QxZivxrnXK4QF8eY+yT
         AfJt2nOjgHxs9NPU0N1tBB97PxWTs9uTrQp+bAZa1SPOhOzFygoaXkvUJMhMr4IuZRz+
         T5Vfrgdd8FE0J2VEAt8MS9fpKL0kGHL7RGbj9RZxPimI41uGnQHUWzB+ayC2e42nXeHh
         TKg98GYz0lYhVg10QyzLrTgMydGeQo4gaNpM+8YF31+RjxNqA5r0ywPpK2iasZYRaHhp
         V300bPfAN3S2i7z5afa4jHf+uBfien7s6anBAnZTKpORIUijhzlCy4g+7xibA22GGGY5
         Y3PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi5cnrRoqxICxFfn5XBPHM69cxkU88yJfUQAPlao+91QDYetSHV1QhPoiD5vA68pW/lN4=@vger.kernel.org, AJvYcCW0C2xo9QSkXe83munmGSo3lkoeOGM3VixV3bIXHiuuLlHMj8piGqsYkIo40BsB1p9Bui8b@vger.kernel.org, AJvYcCXmxXehteNUF/ctzJJz/2y+MCs6I3BmnI16kCgHtl4kBOLRUf/vk0yTWYdgQqQFwiUjCSsibkXsj5QLoCV9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4CgBVXX9PuSrKPOYMiXJelLhX+8FIXFDgZQ0M3mdNbE6pG10g
	phnKOnuYakbcHJxkuLANyvy5TNRJWWsehId7xfEo/Rmqx15vLaIp9cd8
X-Gm-Gg: ASbGncu7Jpsb7Gs/tv4XHA2mtgTuvFKUc9YyGn5wHOdXR/hyYJ5WCM/ZTNhQ6+dHaLS
	YTdI3ZoZ6BSSRmqvN2rR4FadEbgWQ8KXADv1+bR+fkUJ/6nVqcqXSKkDKOmqRd8TqY92sM3J3OL
	KWwxJ+CP3QheqgHycsXMLz7D3rNqZCHAqtzmf5usarojgm3aBxs+z7mGy2SsJxU7Y2zgNsTtzG/
	0aFKnHw+AJ384LdBtBtDOtemflB6i+WaWoq34KYH7onW/y6d973px3eqPQaA5A/KefJ15yWnVDa
	B8YheDslBwbxVwTNMyKoxuONBA0YzHKZ24Hb7XrH9cKbn3lBogfQ4h/4jaVbc8u7wT8fDp/TMaJ
	RJd/9s39ENlTBzciejiPoEzKtG/TcvWj46Q==
X-Google-Smtp-Source: AGHT+IHQaq8GeJuFXhkTC5l/8f8O+joWaAvZZ7nHcCehzsCAPrzZWRziMF5VtxqCODLpV0qfOtCVzw==
X-Received: by 2002:a17:90b:3c08:b0:311:be43:f09a with SMTP id 98e67ed59e1d1-324ef3c6639mr1985454a91.9.1755767201325;
        Thu, 21 Aug 2025 02:06:41 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76ea0c16351sm1708937b3a.14.2025.08.21.02.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:06:41 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 3/7] bpf: use rcu_read_lock_dont_migrate() for bpf_inode_storage_free()
Date: Thu, 21 Aug 2025 17:06:05 +0800
Message-ID: <20250821090609.42508-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821090609.42508-1-dongml2@chinatelecom.cn>
References: <20250821090609.42508-1-dongml2@chinatelecom.cn>
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


