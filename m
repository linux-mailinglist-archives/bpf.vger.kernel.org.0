Return-Path: <bpf+bounces-65717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E319FB278FB
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 08:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED0FB7BE23F
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 06:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F402BE63C;
	Fri, 15 Aug 2025 06:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8yNh5KZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED9A2BE050;
	Fri, 15 Aug 2025 06:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755238728; cv=none; b=CFYNbeqQttdavLRafeiTtjNSd9lBkYIwtc6E2t9nyI8cUwqzoXACKnMVNW6kUBErItPnGnAJ3TgthJihUBlsjsZ4U+E5WuLwbDbCV0l/n11skg4t0Dp0pg6aF4MvQyqX4YgCMY3ncAzDZVyUX7TTk5SEx4Saotcel94vANzXGsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755238728; c=relaxed/simple;
	bh=T22DPtA1nAG5+LGr5FSekZ/PqxpR2Uxni7QIRzV6pqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9hnsrsn5+u9sjKAuy5s73tRt4HkA7KPy/poFEXgvZ7MEvqZn+pO+knwXfxZbL7Qt7BnhGThrHn5h31mWPNr4ka+dAO49uhxIGH7PSZqDib6TP3C06GA5VhduZaKfbfAnzkhdRVc1nR9tG5+2L0CEr0D44TNsxBxdUSP0IYAsOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8yNh5KZ; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-76e2eb6ce24so1757185b3a.3;
        Thu, 14 Aug 2025 23:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755238726; x=1755843526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cprLtrSY5oTLdOA8hqkm/jLoYOshGMqvofbCfe4vh9g=;
        b=m8yNh5KZcyRQ/wb5k8eGJBPusxeeodcx197lfDpISNVRnLJ+OEpUA6zptVySCa0OSZ
         VXe3L6n0YaE3eQrytxa/ZOashbyO2hcnG8gfxJUm1nuggYyIy3p0bI1j13VvHiFA9pOF
         KH69oNo4Yk8AVihqN7WaD8VmvAymA1obwfeFgnCS+jiH/FM8qsTtJjL7SgCq3vRpRnG+
         C4A8wYvWnV4G7w5adP+SC+mHPwiRIFW/CSOL4qHTWH3/1m53bi9SUTZOPHyOIWcCx/Xg
         1ssDEhquMeaVeefvgAqkTmHI6/PcdffvD+069Fy+J+gFUQEG2cqBmG3nr82wJjVzGNyy
         9a+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755238726; x=1755843526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cprLtrSY5oTLdOA8hqkm/jLoYOshGMqvofbCfe4vh9g=;
        b=MamwqczShl5YGvt8TQhbAOnc3poWRQPEdgIgaldiQZQMQG+sL7GWdp7w2SSFOSVb4e
         AkdakTNXxU65ClR52zhnPEhAtSO5rM+jqw1dMrXEiRUAXslPoPtKdAe6WV78yZBDLCkn
         JwUDI1hO0edsbazHNopMV0nb+4InYg2gcP0Gg8vocPHcJQ5cbkWsYwGFWGfgTA4zlEHR
         krnksG5ngE+T06c1ThaxfduYxsnhSE8MfC7YEY8sugaMpipnVStKFspGDx6FoV/vDqZ2
         qBSAXvq6L98IlKKBVvU7O4m6rPBrZseuOK3bvXpHY6WUXjcK5ZvD174VZDbitn2QPHem
         CkNg==
X-Forwarded-Encrypted: i=1; AJvYcCVnKcwnEf99Wlc9+vK1UtUz3TaslfH9EcVgA9xjU4gAP7c/+ftqBrzvQEJpMx9PlgP+Gxk=@vger.kernel.org, AJvYcCWEnjByg8gw1HK4tiLHGZm1cRqjzNJ20nd7jNZe7/HeBaSwmsSrnVZBGK4Q/wtiKQUU8jjvHP7pyZwQGuSM@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn48/Y8C4HfzPm4nefjMuFN+2eRDVt0mm8zydKFWeuZ7OM2u/r
	ZShL3O5VmjY8yT1XCbhMnz1x2Y/TFFbc5guoO6nbNHDW7rOZMySeKQoV
X-Gm-Gg: ASbGncsJPIwAObt6x7r5DeCLr3QnXc7QQ4meO+RHIETbqQAgL2OfgubmlQ46k2tz4rA
	K4kiwnSyAvi+sdYYKa0LSfRN12ivC79qdjdD64d3e1RK3N5F8evh4KGRWe2V1tqnPPBayi2qm8M
	qrA3jVX015Y0pjS0ctaIBeqJnJ7YPrtPaeeDJngW2E5GRV+Qhbv66GjEhYYi0aE1CyLzDJlwZEQ
	7/6fIXWtG1u2Q44snoirXmHUw3Enkfsfy2seOZj8ekbUP0U2PP8M6jGtHlVRiOse5Sqd7OsUFLz
	Pw42BG1DaPDreWYpotYPy9risDSfIqxQBWy/JwsbRw3SU164YZ2reB4RLv0r/4Wz8IOZyP5sE15
	jHfq9oNLYAHhYMSJPQeRuuJZlQXjSJg==
X-Google-Smtp-Source: AGHT+IFlnrErxT4MaYx0fW8YAEISQn91gN1oAGB1cwj82YyqappOfkoRJ/ANUgxJt0FIkUsm6ACfNA==
X-Received: by 2002:a05:6a20:6c89:b0:240:2473:57c5 with SMTP id adf61e73a8af0-240d2ecc720mr1253707637.26.1755238725989;
        Thu, 14 Aug 2025 23:18:45 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4558ae7bsm408607b3a.95.2025.08.14.23.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 23:18:45 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 3/7] bpf: use rcu_migrate_* for bpf_inode_storage_free()
Date: Fri, 15 Aug 2025 14:18:20 +0800
Message-ID: <20250815061824.765906-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815061824.765906-1-dongml2@chinatelecom.cn>
References: <20250815061824.765906-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the migrate_disable/migrate_enable with
rcu_migrate_disable/rcu_migrate_enable in bpf_inode_storage_free to obtain
better performance when PREEMPT_RCU is not enabled.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/bpf/bpf_inode_storage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 15a3eb9b02d9..548530feb4da 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -62,7 +62,7 @@ void bpf_inode_storage_free(struct inode *inode)
 	if (!bsb)
 		return;
 
-	migrate_disable();
+	rcu_migrate_disable();
 	rcu_read_lock();
 
 	local_storage = rcu_dereference(bsb->storage);
@@ -72,7 +72,7 @@ void bpf_inode_storage_free(struct inode *inode)
 	bpf_local_storage_destroy(local_storage);
 out:
 	rcu_read_unlock();
-	migrate_enable();
+	rcu_migrate_enable();
 }
 
 static void *bpf_fd_inode_storage_lookup_elem(struct bpf_map *map, void *key)
-- 
2.50.1


