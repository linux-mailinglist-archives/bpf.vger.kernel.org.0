Return-Path: <bpf+bounces-30242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1838A8CB82E
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1029B1C20CEE
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674FE1591FC;
	Wed, 22 May 2024 01:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vlZBA4Uh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4928D158D7F
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339746; cv=none; b=tAwOZWml1SZLkd2TI6z1i6/so2kBvsR8mC0UWZS7m3j/PNIfEyTTWpJOS03j3pUOzZY0y8cvlVxcUAJgZMqFdCGZziIC0miSuAoph1sK97P+5dl7MeseiXy1gdwYriVkFVpVt5NN/ztZK/HJDYmirPmzdh36Dnar2xv4G9g+ilw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339746; c=relaxed/simple;
	bh=mpbP8rEr3C0vbeTbWGYcRrYPwWGHWpMy1BoxidaCGBo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gY7i/UHignwWqTisb5OuFBQQCAN2H9x4vsJlft3vH7ZFzcJO3QnlAItXNk4YZYK5cswTIivhgA0+BlPK0fsbK2k7Hbx1fkuvygEInsg1f+JcCl/964qcVngMTQqe+VWbTprfby0hZB7pJF6tS5AgarfyQQtVtYYDjps8XfONbSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vlZBA4Uh; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5c65e666609so12291936a12.1
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339743; x=1716944543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=14hyqItgH27nXrTOpySK5+rM0Eq8K4UXKAFuWetO8r4=;
        b=vlZBA4Uhl4IIn9na0IneEgwSS5Yuax7MgmiiIMuLcNGDzdDLVE7qSQK7mE+JJpG7Be
         IiQ27jIfty50TcGV9u9NBdWYB1jUSvPamJUsiQPc3neiR5qKKrkD+SzHVdg31Q/m17/r
         WzGAdhyuewKSstPVkxaNrpRwM1QYesydst0jCm1HMhLof/WFi8K0Pi176M7S/PGLDsgY
         8sA1PFzDrJuU6dYgRjZlZ9PKaFUVKeNR/HPH3uvfpSwFdSqz04DtXD23uHD5tiHRH97T
         Q6EC0c3iBrMWijEX6jlMgteJo93t541IbKJ6gzPioTSMDU6eOouiYVU+vJoRWX8Lr/lh
         rwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339743; x=1716944543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=14hyqItgH27nXrTOpySK5+rM0Eq8K4UXKAFuWetO8r4=;
        b=WSBP/H6QKwbhhWngNnqzL0h1H78ljbsu4vQ2uJSWIzZ9EqSP3zY/v/Se9BCYTNJjAM
         DoKvLuaItBVt44RIAHkTxwLmuTGgvBgvh0jNj3FetJo0bFeb3SIdd3sbn3Z1rpaPgOFQ
         YTwCTp1zoi9X6vOvLd91m44gu9KrNkvnY2TIGq+CcVf7uU1CRuAqCBPBzfw1hkHag2aW
         hQw9/oG4Hk+hd3NCObbFKA929jcxjsr/e02KljHrVUhwWjRh/aYBPgP9yG9VGbaK+n3S
         etMOZ4dmX0tfIo6q7zE6L5HpkxZ2S3KDyVwdn+i5Ga36PsfJmP40ggPEWyLVl1q1/uuE
         KEvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHwWOKcR9mszJhuIFTTfsl7yQ+52Eqnh9Rlg4TItSRT7UFAjS1azSzdDp1e3hEhZQv5VvjG8VwjJdje16PlE9hwdi2
X-Gm-Message-State: AOJu0YwW1J98mJ4hRn67IxUDLiT1WletYjZ3jmM6snGQhQvdNEcqUsd3
	tWCoQnoS4eARpUL6EC80xs509LKFaBjeB/dYH81QdvB6RC0VgEJtF0AqMDS/sfom9zPyTQQMQcS
	DkQ==
X-Google-Smtp-Source: AGHT+IGgEz8vQb6kJDfYmepGef5RK+eICK6sJFyqtVp8ack5BW5MAFsWuVTX7dDchbUYTS8xXBgD80Wr2iA=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a02:60a:b0:5dc:5111:d89b with SMTP id
 41be03b00d2f7-6764dd9810cmr1252a12.8.1716339742654; Tue, 21 May 2024 18:02:22
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:45 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-60-edliaw@google.com>
Subject: [PATCH v5 59/68] selftests/syscall_user_dispatch: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c | 2 --
 tools/testing/selftests/syscall_user_dispatch/sud_test.c      | 2 --
 2 files changed, 4 deletions(-)

diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c b/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
index 073a03702ff5..758fa910e510 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
@@ -4,8 +4,6 @@
  *
  * Benchmark and test syscall user dispatch
  */
-
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
index d975a6767329..76e8f3d91537 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -4,8 +4,6 @@
  *
  * Test code for syscall user dispatch
  */
-
-#define _GNU_SOURCE
 #include <sys/prctl.h>
 #include <sys/sysinfo.h>
 #include <sys/syscall.h>
-- 
2.45.1.288.g0e0cd299f1-goog


