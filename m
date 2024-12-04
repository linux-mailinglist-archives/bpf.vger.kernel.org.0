Return-Path: <bpf+bounces-46096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FF49E44F7
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 20:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B406B2A4EB
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 18:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057CC217F50;
	Wed,  4 Dec 2024 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8OtP1bR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8C2217F37
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733333672; cv=none; b=V6/dO7Bc20V0h7nSOtdGLGmKUich3MQt1ukLoo8XXfE9w58It9ZBNieUg0dqSRbkpr/YPaggRhakBmInP9N9MGFjtOnOBm3g10ay7sThzLWU8hpV3iFU2W9B1mZdvj/KxLngTi0R8fOcRG3VKTlUw64tST57/zIg4q55QBVBnt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733333672; c=relaxed/simple;
	bh=x9cwD4X0QG8G+/QMOTYuQEaKVFeM6Sgogp2+q07n7Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ast9Hz7mo0gs1VYtYxJf9ovcx2QbqxzNXK5PMB6E8mONLPj5TMqEvjN6sWaHRtI/eDHv3wEDIuBmqvELO3LIFRAaqyhJ0VH0ovZ9Ev2xoFJPQjHapDPo5/ooJgK3SDcgGmlA5dpCPasRvsHXRTKyybMevuleWlbIL9tPmpHiIqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8OtP1bR; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fc8f0598cdso951350a12.1
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 09:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733333670; x=1733938470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h+ka2Ndu2aXX782K5t/AG/urCr3uZw4T/z87Wi9wdVM=;
        b=K8OtP1bRdD72/SDmN0Jze2J+cez8lzST8F6nMJLdFNMXdyHXIuN0ePdq5HAZgz9Uwc
         Dk5oCBGmshfZSq+wrFtjrh8aPuvqAl8XykLQ26SpnKTjU9TlzMajhi7/+qbpKxy07wz2
         8BamhhcRQ9sEphezFucvPk1KKwbJT712vV9/pgKMfKyVy5ZL3zZqY7R4yTHsMQ0AldoK
         8ygXrM7w6jGKuelbhg3o1MeOj4Gou07yRCGDFm7Eue8zRiWcFw4CuTZEmYRV/DYoKlAt
         4sj1PihoG2hPdx5bpoSxaV4WCyO1yoFgQNEowjfRtpTi1gyTP8j8uAt8TOZXiwFdYMdI
         R0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733333670; x=1733938470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+ka2Ndu2aXX782K5t/AG/urCr3uZw4T/z87Wi9wdVM=;
        b=vRMVc0eCFz3GDxxUK6mDq6UhtsZoERPRV3BcsK0dqpd7eK+Ydhu5EFDC2ZFL/snJp4
         e3lt8FwCXOpemwQOD/VLHJIKZBpwSbDxJpRgyJFvrODSnv0g+eOKJVy5Ru1Oq/oF0RG1
         1/yzjBMP8czjDsgoGnrxLwsgXqXoE4Xv/rABL/9xelz+vMmge1PMI93yh5sujGWx6btN
         KwyaSYKNqho1S7sSZDKb/I44Ov4q3qcGDE5qWdfmSCSKyhLUXT3v8kk9bSEJhrAiOs+l
         CQ6Y5bKCOcuMZfY7Pq3QlFw1GOvncjTpRG+vRveVfo3FVlzH3hV11D3pNqlSyk3cCoU1
         paxQ==
X-Gm-Message-State: AOJu0YzzLNFukoU0oaADDAG0Pz8MoEFtLzeyJ0DpQPyuXK4K0WreYs8i
	EvYNLgSvfGP4FK0NEEbn/vCzjsq/n4kXr9ROl4VYtdDZi3LYNUzOA48epN3s
X-Gm-Gg: ASbGncu+T33ClsLLdjVR/AsAgd5cqC9xa6U4ZAYpvwrNnlfEDk5caYdZ9nbYZeuyQ4T
	5AX1BeM+hTcV2C+XgiNUCQbvXReDtAR8dlE2sVfOQTcDl8rnMt7Mg48LFAyHHm9wMLUyIU/V+Gr
	DBz5J4oT9eW4Yz06v9UZ5mwi85SXE0tj9o5RwSZGOl9VL9HpmKuCZ6g70U9oXySvh0IeV0BWIEo
	ufqfE/AvLxnxEPtEaVWSbcLzXS2YDokwvhcJUx5R6F3AA==
X-Google-Smtp-Source: AGHT+IEvM8JaypYSQBtt4XJhi1hTtcEyPlatxw32cwkAzFAdbIgX9L5TOBzHaZExGccQmLr2hfQ2rw==
X-Received: by 2002:a05:6a20:2590:b0:1d9:761:8ad8 with SMTP id adf61e73a8af0-1e17d3f3806mr360942637.21.1733333669935;
        Wed, 04 Dec 2024 09:34:29 -0800 (PST)
Received: from badger.thefacebook.com ([2620:10d:c090:600::1:863])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c3855fasm11764191a12.55.2024.12.04.09.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 09:34:29 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf] samples/bpf: pass TPROGS_USER_CFLAGS to libbpf makefile
Date: Wed,  4 Dec 2024 09:34:16 -0800
Message-ID: <20241204173416.142240-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before commit [1], the value of a variable TPROGS_USER_CFLAGS was
passed to libbpf make command as a part of EXTRA_CFLAGS.
This commit makes sure that the value of TPROGS_USER_CFLAGS is still
passed to libbpf make command, in order to maintain backwards build
scripts compatibility.

[1] commit 5a6ea7022ff4 ("samples/bpf: Remove unnecessary -I flags from libbpf EXTRA_CFLAGS")

Fixes: 5a6ea7022ff4 ("samples/bpf: Remove unnecessary -I flags from libbpf EXTRA_CFLAGS")
Suggested-by: Viktor Malik <vmalik@redhat.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 96a05e70ace3..dd9944a97b7e 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -123,7 +123,7 @@ always-y += ibumad_kern.o
 always-y += hbm_out_kern.o
 always-y += hbm_edt_kern.o
 
-TPROGS_CFLAGS = $(TPROGS_USER_CFLAGS)
+COMMON_CFLAGS = $(TPROGS_USER_CFLAGS)
 TPROGS_LDFLAGS = $(TPROGS_USER_LDFLAGS)
 
 ifeq ($(ARCH), arm)
-- 
2.45.2


