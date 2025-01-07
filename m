Return-Path: <bpf+bounces-48102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33805A0416A
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211113A5981
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F391F2C5B;
	Tue,  7 Jan 2025 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXxNdUyS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0879F1F2C26;
	Tue,  7 Jan 2025 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258423; cv=none; b=VrOzOFY7xvIsw+7SVvQhnEB0Rrfh8l2oYy4Fadb6p0WQAHAuemfqDxK5lIgg11jmeg6Z5Xx4hLIXlvZ8wae6fm98LHOybRV25aQZveecjmn6DdX5n/vzG98J+cCBvCKMIl0itFbrW/UCPJ1ht3oVza2dncW7PMV9NYTPDDnGf0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258423; c=relaxed/simple;
	bh=TiZoNzl0RgiYrKoxOttwDwQ6phR397SKF8QOHX/CtQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4f3YncYLEWSk8BxX/h6vJK/LS79qogqhToVViUgnMewHpCTwA4pr025Z/x2qbutl1biCajbbht8VqVBSbleYaGgl37616VeroyvWFbKYeVc8IJh+/gys7nWlh/Hf8FQiEhrPQ/9RqbpH0yPBST77n6lt+AWVhCFCV+nQ9TSSi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXxNdUyS; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43675b1155bso148810295e9.2;
        Tue, 07 Jan 2025 06:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736258418; x=1736863218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+v8wwQRMiAXIk0d5McK1drNuJdKwSevaWfwlzh6m08A=;
        b=hXxNdUySlr8Q1s1RmNpk3gaj9qUJeSNwVwW/Gcp3no3K/kUuw96bs1fo8J/cfQZIoU
         lq0wiEMq5I7is1m8IyDpPp9vAyjwvilnEmZt1RzS/AW2oHX0HynWNKkDJrE+T4+r6Mxl
         UgQDCupMN6W8FyuZUlQkpLY2HJcI6plqe65HZPkP24/CWX4B6NVvb7XfSbFMmsq6DtTS
         av/iapsCQvLRSoCmrfHgKgy9O6/UWk6AT2OghnxG3+YYddtSB9+VLG0mQ/+A+mAXKqkX
         ok3eLv+MjRb1Y0wG8rI0iJIwXBWIVWIN6zbqdq0yUOeyG/AzklwRNqC+GUwqhyG0FMzr
         mc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258418; x=1736863218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+v8wwQRMiAXIk0d5McK1drNuJdKwSevaWfwlzh6m08A=;
        b=cyQ2ynvVWHQriecnYVdkiNialQBYyQd9u1/lPMj07uuCfE9C5I4XfLpgrhd66r3KHG
         I7Jxf3YYBURPe6HlhBiaPbtwJxgOrD/+MpwqmdocpSqHJD1M3EfXBfxV819MZXIsKlbk
         N+hqT8xrDptFyWTilpkwxSTlAUT0nFjYf6rrZRRhOmcui1t5ITlsPlb3VjzwXq3Gzaqv
         Gt58n5OGIdji/nr0HvVYfL10/PUL6H6wKdP3GNaHD4/QW2wS1iWHdduEslq8bI5x5v2u
         ays9wZwRMofhKct7UOKmAXX//pFakJB3uuJvF/FZSuJQQlm/1zHgM4y60X7q6ZlShqMz
         mOrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9Rcf0DfKdB+j+AzOh0hYRp7kSXCRZYSaR/edyXj6AEhoahnK6CmDtHme7uSXkKO0b3DhF5LGm5tzwuJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy45y0yGmJhkFri4bx4jG+bu+oHoKdPGT7FuMgIZ7oYgMT+BLLF
	QmRZxZSZTPHPBTY2+tCHFBIWCQS61J0D/FVG2t89OetFd1AnotA/XKZYrUzRlabp1w==
X-Gm-Gg: ASbGncuSdmikV5QlCnCf/bnqC+z+O32+q6zLVB5q02YrDFZhJKuuc11i6NZrPsJsIAW
	aDjyRxPPpT/emDidegeWpJvIBg1xPLp+6wN64dXA49yuo9+knokMECMqRzuq6Zv7rVaUOy+1ZBj
	z0Zvha9v4VBdByU7BL51bvGLBa2m0Jd2avDfZ0w5klXL2Vr+aVadvLY6o6lHvW+vwjEESUho6hJ
	yb3jltIvsLDH3g+uFyIfpfFDGrDiFPbk26w+WC5w2apujE=
X-Google-Smtp-Source: AGHT+IGb1bfeq2CiQMVETr9rXVJVnKO6IM9s0EsP5RN9c3rxDS9Lkjv5GvzfMIFUqaC7T2pAXsTwiA==
X-Received: by 2002:a5d:584f:0:b0:385:ea2b:12cc with SMTP id ffacd0b85a97d-38a221ea286mr51254874f8f.13.1736258418063;
        Tue, 07 Jan 2025 06:00:18 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:17::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e1cesm49720755f8f.64.2025.01.07.06.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 06:00:17 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Barret Rhoden <brho@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 05/22] rqspinlock: Add rqspinlock.h header
Date: Tue,  7 Jan 2025 05:59:47 -0800
Message-ID: <20250107140004.2732830-6-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250107140004.2732830-1-memxor@gmail.com>
References: <20250107140004.2732830-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1497; h=from:subject; bh=TiZoNzl0RgiYrKoxOttwDwQ6phR397SKF8QOHX/CtQw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnfTCclgCk8LJ6bdDVdLpisCaetAgrsza+fIA9DgUX va6iEkqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ30wnAAKCRBM4MiGSL8RyiaMD/ 9ktRXkwuo8lWq4wSfhAG1PV3gPfAHOX3OizjgrBoi+8Vo8P9HNaNfztbPPX/Tqof1Ei4u5qawSJcqQ lTR2RBAYnZKTi0EINmKXk0k5DkOC4YzTM8lb/SCMrJB848/dvsiuo+wdSqEyZZK7VSKQCPlVS3bWar 3UeFKLNYdafVrdKYs5HGlhaeIRSEGaE/A1Le0uy3C3SjKWy5w+CeqifsHGQg8k4WJtqbsliG8Bl8VU dyIzoIxxjelbaz+Vlo7znAHiedXe00d2zigWKSyou5GQnj2/Fgw8XWrha3RADZVM7Ex1/d15sj/Mo2 R0Eoz+7IBGxETeji/UNu2O6cL404DcHYu2qFP67k+l2jX70KHsNyGv/Oz6S89MR/1jmmlHoIDMx8gE vQYA+rKqZ+8RcIOn/c1jeWlEJfrD2Fr5P1DNUGGyIGbFWA6+ECMihmGVcl4ZfWeWcTS8inuTxp+Bar rzfMCPtTp/g8qMiHWUR1bCm9usIIvaf1tN5bVmN+4BjpSPcuM4hiFTrcv7ttkR07EjRAmfnl2TUFDG KwY3DXibGWoTOBPeFdcJQsQFEGXf8uJqX1IXre4C5Dl2M8iY5Apw3/QjlkwINjOUFY+kaTlFOUVhRd WYEMjMGZFjFhUIC2Qxi4Uca4Yz2vK2KsbCJsGkepmWpfjlX+sGeM+9+2k1TQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This header contains the public declarations usable in the rest of the
kernel for rqspinlock.

Reviewed-by: Barret Rhoden <brho@google.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/asm-generic/rqspinlock.h | 18 ++++++++++++++++++
 kernel/locking/rqspinlock.c      |  1 +
 2 files changed, 19 insertions(+)
 create mode 100644 include/asm-generic/rqspinlock.h

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
new file mode 100644
index 000000000000..5c2cd3097fb2
--- /dev/null
+++ b/include/asm-generic/rqspinlock.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Resilient Queued Spin Lock
+ *
+ * (C) Copyright 2024 Meta Platforms, Inc. and affiliates.
+ *
+ * Authors: Kumar Kartikeya Dwivedi <memxor@gmail.com>
+ */
+#ifndef __ASM_GENERIC_RQSPINLOCK_H
+#define __ASM_GENERIC_RQSPINLOCK_H
+
+#include <linux/types.h>
+
+struct qspinlock;
+
+extern void resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+
+#endif /* __ASM_GENERIC_RQSPINLOCK_H */
diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
index caaa7c9bbc79..b7920ae79410 100644
--- a/kernel/locking/rqspinlock.c
+++ b/kernel/locking/rqspinlock.c
@@ -23,6 +23,7 @@
 #include <asm/byteorder.h>
 #include <asm/qspinlock.h>
 #include <trace/events/lock.h>
+#include <asm/rqspinlock.h>
 
 /*
  * Include queued spinlock definitions and statistics code
-- 
2.43.5


