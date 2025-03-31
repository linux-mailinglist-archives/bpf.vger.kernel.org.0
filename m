Return-Path: <bpf+bounces-54931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B872A760F5
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 10:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699863A1663
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 08:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B96D1D63C5;
	Mon, 31 Mar 2025 08:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgP0DN95"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F14487BE
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743408538; cv=none; b=k7NJeFwB4qCuhUaKPkacTFGKrTrEIrPDAf1OV0FukmoXxPPSPYi6TSHUfWTQK2VpiC67N3n8grq6dYD3NfToofHriXL2zuVAGnoYfrA9x/jpY/cQO1Gsk7SoSxV4drbkqzHoW2Uq0wR2w51grNDU0DQZ7DqdGyJ158GmH4BMKPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743408538; c=relaxed/simple;
	bh=/at7c45nf1j9WiNW7z91BFuvSYozx/q5GqcS+AgKEbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AqRi4mCBtOyrdJkzxJcKavqUjrh6fAmc0tX3LTMv4wQzHCdDfofzCECjfxe/I8VCFyYKneANtS3UlWb0IJA3ceKkBmIbnsaYBxLHYKHu2VX1i9GRF7iKgnIx5o7piBUNNKi4pyYiaKRdgynnbks0HI5mTLU61ifWusXed+YXMgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgP0DN95; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-399744f74e9so2723023f8f.1
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 01:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743408535; x=1744013335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+wZFuHVjOSlPrTFQB4eXbAHklcQfF137d2bnkdBtBY=;
        b=lgP0DN958yuIMgBp3WvdNFSNshk5smvDD/pgua9W6d8ab0F0QXd/gql6sFOX97FgN7
         cmZqx4XCQZjZIDtfnmr4hkw2vH93RpLTtBl7K9oEnhvP1PJBeRdA3HRiyBUaoexmsMOz
         8FMisLUfe0cT9dt0AfLmk4X5mxeZzKUNlKKjNJCh6XYNT0RddYe5Z4lvo3X8eEI81JtI
         0kxGoTeUseEIIkDLAjtXFyLWRGyKJhJtF3Ibq/VqckfSD1WzcK7/RbvBfwmEDMo1oDv0
         pHlXw6uV8oheo01mI/zDN7wWPxWb2h+x1wWx41+B2xnKeIRRZaOHG9Pzz3P0aQvyeUd4
         B/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743408535; x=1744013335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+wZFuHVjOSlPrTFQB4eXbAHklcQfF137d2bnkdBtBY=;
        b=m7q7Wjs+4p/XepjJAfTJ098nwmtedvxtUb6xLCyHykoTHL2ZvOQazvsqMBOBtCDeQl
         amyD4hNn3D0bj1y3O1GYFEr1XLDw4TFqvL3/6oJuVqHReeUBrB1V95YE38CxlJfyJM+A
         TI2nDjcI2DbMILiS5ivkHWu+FD/0SctWclwT5BVLGxpV0Po/X622C8jctL1RM4no0d52
         DXCGwpmb7DSBGNOzQZvGh1z89oKlCnq/vxJDfRwsuVc0jKeTcHMKixCb1G0bt+DbWwyl
         KEB1X3ruYASkyU3/DwgLRSDdR/6AolPnPS8UWeIGL8ZozmonQzoxfV5Qmrk+MixkZIWq
         OrsQ==
X-Gm-Message-State: AOJu0YwoDhoLqXnkG3a+fFbov9iMLlj4lhp1xeVFsz3IjAoi67LEWk4k
	RMHkebnHonyTCCp9CkT87fG8w/kcNJH3uKB/V9HAEceptlj0RWrxNP2RfFxh
X-Gm-Gg: ASbGncum142HrBKpaeoR5dwDZVCBglmVmHBGyKoSzN/7dv1USqDMu1qFPE3MuYrDIb7
	eeThO8Q1YUPaNfNDG5C2mGNiXCK3D8Gryr4Fybc2hw+hqCDz6MgbNgK5W4Gy9ywF/RxRL51QM6+
	H5+WwSItkbovOdO7Oy4WSv+85Tan2IWI2eWnZqjwIBs7sxnqnExY2fpRa8TD/bJ1L1eVRLo3XHn
	7MSaVGC796E/MxB8evFvykwxCG1GL7UEzmekm0nIbn49wggNsq6kumgi1c62IzohNAP4GOH2weE
	Bi2wu+cM3niXVDqNiPH7ZxD8apalpLVmxvYntGownJ2xxGVKK8Ew1ytilDswrNfo
X-Google-Smtp-Source: AGHT+IEcuJm9GmNVhr/HIcXU+uBhQtPUP6jwe14zY7C2SVsAD4FoYt13WRNqy22R7y5coMEdAHhvUQ==
X-Received: by 2002:a5d:47a2:0:b0:39a:c9ed:8555 with SMTP id ffacd0b85a97d-39c120dfd8dmr6327175f8f.23.1743408534964;
        Mon, 31 Mar 2025 01:08:54 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b658b5dsm10471987f8f.3.2025.03.31.01.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 01:08:54 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next 4/4] selftests/bpf: remove likely/unlikely definitions
Date: Mon, 31 Mar 2025 08:13:08 +0000
Message-Id: <20250331081308.1722343-5-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250331081308.1722343-1-a.s.protopopov@gmail.com>
References: <20250331081308.1722343-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now likely/unlikely macros are defined in tools/lib/bpf/bpf_helpers.h
and thus can be removed from selftests.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/testing/selftests/bpf/bpf_arena_spin_lock.h | 8 --------
 tools/testing/selftests/bpf/progs/iters.c         | 4 ----
 2 files changed, 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_arena_spin_lock.h b/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
index d60d899dd9da..4e29c31c4ef8 100644
--- a/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
+++ b/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
@@ -95,14 +95,6 @@ struct arena_qnode {
 #define _Q_LOCKED_VAL		(1U << _Q_LOCKED_OFFSET)
 #define _Q_PENDING_VAL		(1U << _Q_PENDING_OFFSET)
 
-#ifndef likely
-#define likely(x) __builtin_expect(!!(x), 1)
-#endif
-
-#ifndef unlikely
-#define unlikely(x) __builtin_expect(!!(x), 0)
-#endif
-
 struct arena_qnode __arena qnodes[_Q_MAX_CPUS][_Q_MAX_NODES];
 
 static inline u32 encode_tail(int cpu, int idx)
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 1b9a908f2607..76adf4a8f2da 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -7,10 +7,6 @@
 #include "bpf_misc.h"
 #include "bpf_compiler.h"
 
-#ifndef unlikely
-#define unlikely(x)	__builtin_expect(!!(x), 0)
-#endif
-
 static volatile int zero = 0;
 
 int my_pid;
-- 
2.34.1


