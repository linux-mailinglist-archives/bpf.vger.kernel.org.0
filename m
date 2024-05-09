Return-Path: <bpf+bounces-29259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C86FA8C1671
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A602826F2
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A0D13B28F;
	Thu,  9 May 2024 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XBVVxbVp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C1713AD34
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284931; cv=none; b=bt2hiMLKoyqSV0wMTkcFXPqrUUXZhGfiVuVY1UR9J3V8FX4IWew/BK17dgJIxMu4YKzK13A9HGw7/mhI8pxRPKdJNIdCWiVDCe1qZYaThNYlegcOmoAnNkkDpNBiZY+mJm4bfSYomKuHmbr5ncY3dg6bayzg+YGFGo4M9Rz4cow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284931; c=relaxed/simple;
	bh=16xQFZUemPEW+OmTRE/3AJIID4VuLDiTh8Uti+95Avc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D2u40/b20ljVeJ0jCCogMt0HkYMdmAFjeAX72WZNNZxNcMnCh16wacZ3zdrT0ZFgxto75Z6ZJ2HClmSv/MVE4Xf8SU1fET+h4B+GU2DzGT4+Vfsfe6orwX2pjw6wwZRGQxgO+7zz4CSz++e4UNgNnOAvI/u8gxvN52kby/GOrrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XBVVxbVp; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de60cd96bf3so2833799276.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 13:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284928; x=1715889728; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ld4la0VxD3l5sUUAGJ4Eky+q6o3Kf635llpLjU0Q2ns=;
        b=XBVVxbVp0tDi1eejJVKANr+8xaxS/RZuT7cPK9azYrwtike+1VH1jwViW/jBCCJLsZ
         hupPKaiadKuVDG9F61e2VC7dz2WWlo1OJ0xyC3AZv/ehIs9gj7HSyrsnO+AKhQDAq8FI
         +0zVDs+SkVvFSnP86mwJg2loLZnsQjj6DrXYNwjXw5zCPhGFjOSbMKNxvI8QqP8c0oaH
         p5EQxr+oR2Qcz16c1EdviPH3wsgHREVRBM4YMZRAgpS8P0Squ52ocsQQeVXgt3ozvZtd
         LON1xSoAlM3uF+AtUiqyCkFCkd8BIZOP4/5H/FBtStBt6D8UzjR/IebYtdq88C0B3BqC
         QYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284928; x=1715889728;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ld4la0VxD3l5sUUAGJ4Eky+q6o3Kf635llpLjU0Q2ns=;
        b=bbLmKfAFaNxvGqC9G8oAK048XX2FHERMmDKICEaGIOLe7D+RB9ytdc/Wj2Z62Tq3p3
         G7aui0p8IC3iLDIJPR5WSs7zJm5pTDA7uuKuCXpBmdt7Vya5ij4g9J8y6m7joWu18Vnj
         kUgMPsfI70sHuA5agEXRjy3OT1wz4ydTD8yBtkKe241LTwdUIHs3YYtA7v/cyDV6s251
         1iK+rZRC1uPs75Hm6W7yxtbelJH0O6TVq9Ha0WNadJ8REMLuMd4f92GmPUlpmjBtn4QO
         g4i3OGHzaefXErVMq2BtGvYf8jOtMqZT7A8yzGhVGAHhvMwR0rHFNdydOaIAdAiAthBX
         GIZA==
X-Forwarded-Encrypted: i=1; AJvYcCX551WmNLlFTWzb3dI/32KdZRylvDlnybeZ7ycyhfXeEvz9NLgk+e2uF5FFtHolNdJrg/qUycLw+4Amv+OfVdd2J9Mv
X-Gm-Message-State: AOJu0Yy8mKByzKopQTIX4EOeo0EB54KcPa04EXDq2NOTm6h4t7Exgr7H
	YADPsbQmdYhn8dnh4//iQhBQME1ZvxI2mCj4qhb6gsGmRlBLZxqJR+yPpo4Dw67wU7I17kPHPOu
	jnA==
X-Google-Smtp-Source: AGHT+IH7mCutPVAsCyjnUwqjavBhEaHc72uO0KGnsx9I5mIx6c+B/OzfNxUabcxwf0ME6yuKTrwEQgs1qvI=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:2b03:b0:dd9:20c1:85b6 with SMTP id
 3f1490d57ef6-dee4e48f302mr225691276.2.1715284928394; Thu, 09 May 2024
 13:02:08 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:21 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-30-edliaw@google.com>
Subject: [PATCH v3 29/68] selftests/membarrier: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Edward Liaw <edliaw@google.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/membarrier/membarrier_test_impl.h        | 1 -
 .../testing/selftests/membarrier/membarrier_test_multi_thread.c  | 1 -
 .../testing/selftests/membarrier/membarrier_test_single_thread.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/tools/testing/selftests/membarrier/membarrier_test_impl.h b/tools/testing/selftests/membarrier/membarrier_test_impl.h
index af89855adb7b..a8a60b6271a5 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_impl.h
+++ b/tools/testing/selftests/membarrier/membarrier_test_impl.h
@@ -1,5 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#define _GNU_SOURCE
 #include <linux/membarrier.h>
 #include <syscall.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
index 4e14dba81234..c00f380b2757 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
+++ b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <linux/membarrier.h>
 #include <syscall.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/membarrier/membarrier_test_single_thread.c b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
index fa3f1d6c37a0..c399fbad8efd 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
+++ b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <linux/membarrier.h>
 #include <syscall.h>
 #include <stdio.h>
-- 
2.45.0.118.g7fe29c98d7-goog


