Return-Path: <bpf+bounces-68067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 002BBB52576
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 03:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5B71C22503
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 01:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167D71DEFE0;
	Thu, 11 Sep 2025 01:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiGHmmly"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9AA17A305
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 01:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757552696; cv=none; b=FsXfdT9pqCPWVv0HIZt1FWeh1IePb/xB2MF0B/mcBTIbs01IvEwZZS9R7SwN1K/9zpK80gqmcuvZnIRP2AC2u9FO9PuM/etSl2FjhMfgnOfeXbc2AFTOvMBqTjeWD6RBaB9MfMcDgg1ZoX9HuhCISrvrsPXvtwL/VmOtfwjZ98Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757552696; c=relaxed/simple;
	bh=srnolZq2Gx43aiiNy7JVW/ObL3atUEMlQHRZIjs48DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lejhv0KqoHyWrbyoQcZpF3Fi6UeHcH5rmpEkMdibL2L80w4YjUKLqf3CvblWZ+M7ZX6REPsanGKjz47CkG0IYM9N/UHS5G0AbHAqTRrlaCALJAY/zY06s7SpkhpjATN3jeEXh1UEjKeAVqttB920O75Ck1vydzJwT5t19nrLgoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiGHmmly; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7724df82cabso190666b3a.2
        for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 18:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757552694; x=1758157494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQy9YgcgnyRe+cjxkJbLCk/YtWPSBVB265/FqT3P/mk=;
        b=NiGHmmlylefqDrZF+JnTw6Ci9lvtPf6e0k4oZtRgUUmmeDpP+hrXvzGdauHNLkKWt6
         QGDO24iHb1+XrFF+x2HAb0itcWzci+M4DMCSwfumVWmtSSu9dX6ntrmZRkD6uZBwUFzu
         SVA6ZL85s5fTY1BTMgrQ/SUyQ2eMG0qq/cZ+Hem2tiUHf/JaGCNmu/+7OqlYGJnrxE/s
         CMALjdYs2r3wkooJMgWvOsgTIK1A22u7izJz7b8SKbZcsy7cO8uWfeUMgNEE+qUoAmn+
         DKmKSvjR4LBu5NrNH7Kt07ICdlWVZGtCu/UD8zxBN0oT7cXkGW1mko1NAPq44APpEMw2
         KIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757552694; x=1758157494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQy9YgcgnyRe+cjxkJbLCk/YtWPSBVB265/FqT3P/mk=;
        b=DHzHGgqv4WVjajCvPyEe0Vq6H50Rj9vxMEHtttnmxI0B2xEliIUuZno5DIw4YrQ0B/
         f3khXRfGoxxW+Dqq3ozgGUtAsBUCfq2/VRp2jWZRY43LYms6I/XGJ9bw9ddAyZRwK/Lb
         z+u0z4vNS8I7uwqBXpyuXY3IZAksQRZVWR9DmDDmD/We5QpuoOg3N6E0dkt4JM375Xok
         dy3ehYZF3gBN3kOCn8/SbCQqIroBwaNrMBBozCU78sTjWszBUHAUDUUFhUwvI2Hp2Apw
         KTPUiuJElMoHzdgX+CYLzFdUkR5MO8DtHuTcMC92G/2uuOBeRDSgK10J9jv9yp4rRipS
         bSxg==
X-Gm-Message-State: AOJu0YzN2y3UZV8codu2SZFj4lOq84BjxoXJgb3u9VW5EvZUp5wcdDwi
	lNHVmqwNnWkegdTPWuT/ADlnnpG4ncoGEzfBR7c5XccLCTiBYsxPD/1ZOkmQfQ==
X-Gm-Gg: ASbGncuPrGqYwX6jfK73s3BuJtK7OfJLVtS4b2vx1Q4rfrTgg+cBrhrKFw+39GdnWNn
	beBKps+qv7KzSE12C29KjUxi2D7tj1uSrh+wJKGEXcJzZhIpd6Y1P7MFyKAlh4yh4uazXzl2nEn
	v76CNM8LkT4L4i2f0X0Rp5gJKgn1e+4GMJecIV9gIfR2wyZeUnK6bQEXccvFFdKG/j6Q2svRP5z
	TnzsdEvUJBZ3WTDs+4jz+cMs4YfdUSKDjPUbjxwcqZNMRWYQ0tr4dtaGPudtGc68NCZeqfQqB03
	qsxe7x+QXGqtzHhgnycdGsU6CAfliPG6T+WXiOHRb6bDZlEEDTIOQFrCyB3FQAYXRWk5wAEKzYl
	QpQy2dZdRgEnv9Su5+kHifdrJQB3umwgSew==
X-Google-Smtp-Source: AGHT+IGcj2ca/OB3CQiLug1BQCC2yum2dgMJK7mrG3/6+mX1Ks7ssOEcofHouAr5vv2spBsfFUqwyA==
X-Received: by 2002:a05:6a20:1585:b0:24b:954e:388a with SMTP id adf61e73a8af0-2534557a4eemr23827202637.39.1757552694219;
        Wed, 10 Sep 2025 18:04:54 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd61eaa27sm545511a91.1.2025.09.10.18.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 18:04:53 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v1 03/10] bpf: remove redundant REG_LIVE_READ check in stacksafe()
Date: Wed, 10 Sep 2025 18:04:28 -0700
Message-ID: <20250911010437.2779173-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911010437.2779173-1-eddyz87@gmail.com>
References: <20250911010437.2779173-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stacksafe() is called in exact == NOT_EXACT mode only for states that
had been porcessed by clean_verifier_states(). The latter replaces
dead stack spills with a series of STACK_INVALID masks. Such masks are
already handled by stacksafe().

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 698e6a24d2a2..8673b955a6cd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18756,13 +18756,6 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		     cur->stack[spi].slot_type[i % BPF_REG_SIZE]))
 			return false;
 
-		if (!(old->stack[spi].spilled_ptr.live & REG_LIVE_READ)
-		    && exact == NOT_EXACT) {
-			i += BPF_REG_SIZE - 1;
-			/* explored state didn't use this */
-			continue;
-		}
-
 		if (old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_INVALID)
 			continue;
 
-- 
2.47.3


