Return-Path: <bpf+bounces-37915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B2E95C2FB
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 03:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B53F1F2301F
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 01:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5D51CAA2;
	Fri, 23 Aug 2024 01:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DPAaQN3k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A8C18E3F
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 01:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724377719; cv=none; b=KIJb+DLvnfOPKGyIeWFoIrD9mSfU02/3UXVOo6mrpUgvEos5P4cltxXTLo4x8IMWBI5Y/i4k445l5Veb4MVy483yFS/9BGZTU9g98cEGHbQP5LYSWHcx0yvhf25FWtJPwIo/kQrpzRY4f9k2BBgykEWePdf7CCyTfpZ7rPrFLQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724377719; c=relaxed/simple;
	bh=4hKbplegsIw81cNQ5WnyXPLM8uqwna6/0A25fiGrYYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P2GUVoKmqK3IneoO3NWg/Cp17HOGOpE6xZIjJM2rqQIJtzl5sGOmqXwtbpj+Z2/4Ay2lWHKq6Au1B1OZJCKv0Ho4g9RcP5CPSLyKEFPSRGiJIlPJzmCg2T7I3OI5S+w6fRzJyTnfu6sPnN5ImlD7nr8HgruiVO2o6q820PD/Uu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DPAaQN3k; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42816ca782dso10312935e9.2
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 18:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724377715; x=1724982515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FMhmmCDtW4ujiSa3oMXcmqVGqRJv4lFRXkcZHpGm9i4=;
        b=DPAaQN3kyP+HUA+69tvNNMY5wOCcR+ndGsqTs2/VWOq++8ku9s0nVEaNOE1Rg7juDS
         8JCeGt+fwv5Axai2v7MM4pQcBHWEQnY0UzcJc0yGva5z3MmD+SOS9kIlDiXVxGR5fpeh
         KljCUI44huX5bFInSm8Jc54Eipr/bwnHqqHr3SI/e8YuS2QBz+SzIB2zQAetF+oB+4oH
         MBByucwImSgJDG7qT6g+MFU2Q1SwJLUup2vycqmXsqlFUrk7bHlqIwvpSZ/3GBwfgXBs
         DEa76WKhexOmVASFMFEd2HhiD8sfpyJXTZFyy6Q9hAn96pVINECwVunr7GRBxWdpvKAK
         ptGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724377715; x=1724982515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FMhmmCDtW4ujiSa3oMXcmqVGqRJv4lFRXkcZHpGm9i4=;
        b=Qd8xvGl6SBA+bjstu6Hs5ufS6osgxQfEvyVxCC+VHo5yJ+VfZo/ZdlbubdYdAgQGzA
         RZu/0f79mMmpvGM8zzlWGIDZuo1LZMux/YLAN4kPsiXUuQnMK43Whbhb3YuLmAJibS0g
         Z3AOJ6tPyacrtoIbtjcCxXdFc6X30f9nj44voRDRbfF31zQh1Ec9wKNz226T+7aHBnft
         IRe8vaCttFEX2x+2VI7gNnRylRP3Bg0AXPl0MUSayKS/En7FDzRLGqD0aYEWaRvwVPAm
         hdNoREt9dIDOQduzNmbtnRGBxkHry1iRLheArThDUgSYSaYGmbOKV1wwAzRDkYlyzx/5
         d6CQ==
X-Gm-Message-State: AOJu0YwhRTxcZHz9OGUsZo6nCisYJ0K7AhzsScs1JLf76McdUYURxwQB
	Ey422UA75EE4UWyag6YsVxfJbKJ80bxzALudbympov0R+8GtZwywzCme1sAKpAU=
X-Google-Smtp-Source: AGHT+IHk01EO7ycizahG1PJ7kp0j+rAUMJ0RqMuMbKWO67qXCheWVipXYM16MUpGo+l/0O4m55S89g==
X-Received: by 2002:adf:fe4e:0:b0:36b:b297:1419 with SMTP id ffacd0b85a97d-37311855d3amr280118f8f.20.1724377715448;
        Thu, 22 Aug 2024 18:48:35 -0700 (PDT)
Received: from localhost (27-51-129-77.adsl.fetnet.net. [27.51.129.77])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eba23d78sm4939192a91.29.2024.08.22.18.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 18:48:35 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Hodges <hodgesd@meta.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.6 1/2] bpf: Fix a kernel verifier crash in stacksafe()
Date: Fri, 23 Aug 2024 09:48:28 +0800
Message-ID: <20240823014829.115038-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yonghong Song <yonghong.song@linux.dev>

[ Upstream commit bed2eb964c70b780fb55925892a74f26cb590b25 ]

Daniel Hodges reported a kernel verifier crash when playing with sched-ext.
Further investigation shows that the crash is due to invalid memory access
in stacksafe(). More specifically, it is the following code:

    if (exact != NOT_EXACT &&
        old->stack[spi].slot_type[i % BPF_REG_SIZE] !=
        cur->stack[spi].slot_type[i % BPF_REG_SIZE])
            return false;

The 'i' iterates old->allocated_stack.
If cur->allocated_stack < old->allocated_stack the out-of-bound
access will happen.

To fix the issue add 'i >= cur->allocated_stack' check such that if
the condition is true, stacksafe() should fail. Otherwise,
cur->stack[spi].slot_type[i % BPF_REG_SIZE] memory access is legal.

Fixes: 2793a8b015f7 ("bpf: exact states comparison for iterator convergence checks")
Cc: Eduard Zingerman <eddyz87@gmail.com>
Reported-by: Daniel Hodges <hodgesd@meta.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/r/20240812214847.213612-1-yonghong.song@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
shung-hsi.yu: "exact" variable is bool instead enum because commit 4f81c16f50ba
("bpf: Recognize that two registers are safe when their ranges match") is not
present.
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/verifier.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 171045b6956d..3f1a9cd7fc9e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16124,8 +16124,9 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		spi = i / BPF_REG_SIZE;
 
 		if (exact &&
-		    old->stack[spi].slot_type[i % BPF_REG_SIZE] !=
-		    cur->stack[spi].slot_type[i % BPF_REG_SIZE])
+		    (i >= cur->allocated_stack ||
+		     old->stack[spi].slot_type[i % BPF_REG_SIZE] !=
+		     cur->stack[spi].slot_type[i % BPF_REG_SIZE]))
 			return false;
 
 		if (!(old->stack[spi].spilled_ptr.live & REG_LIVE_READ) && !exact) {
-- 
2.46.0


