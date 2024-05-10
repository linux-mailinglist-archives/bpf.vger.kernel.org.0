Return-Path: <bpf+bounces-29393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F4D8C1B58
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36090283AB0
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FF213D524;
	Fri, 10 May 2024 00:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VXWsVMiQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9BF13D251
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299898; cv=none; b=B7Yny6bHuJV+hutMS8XrbxDZCwDaXr50eguuwF1uqK4EJTwpt/jDtW2g1evCazogN8HOLVT2Trc8Be2NhcacMq1yi4mKF22HjM284zOuCdQ93h6BhLx7U3wXYU92pM+NcGM/jIyTjKaGPXenTFSjdnHcPNAJXVq8L5C/B9FX1ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299898; c=relaxed/simple;
	bh=6p8G22YTy6ZtsOf462zez70QpBb44q4tILI9m4e2cqY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BK6CTAzGE/w10n7twxToM3hcqJfdjkq5FONE5Ph5/iw65iXTJGQcDcLgehj6C2d9QqdWGYFCYBHTiFd5OjQYEUm3vAV5jdvZ6ZAcQ88gkix640k77+ZEWlyN7kXWwyaj0S6ExUASjlU3+syGR4CfG+M/PDp4tEFyw/XgrZRCYMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VXWsVMiQ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ec4c65a091so11225495ad.3
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299896; x=1715904696; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BLIfPVA39L5GI7BSivGjVMs24Ei0WVbUZT0FyKIU17I=;
        b=VXWsVMiQa9wO5DfJFjejH1tWvIekYjyfjIJDkDVb4jjgptmSYXwhYFd5z/4eTuj5t6
         NwkL3PlLQpU+PFmnuTgW7FjPwkIr/RNUS3AibsEW7OV0WdrFOfoCDNmtnI8H7IwEQdJs
         haVCORWVjy1vojqfjYgE1ldORtLPAPDgOOpdZ4EEJxDixz6lByGAKLuuJYbt79EQVxUj
         p/VFbYk1jFZug7N5WKOM3dtwCjfsFtxZMU4/7Nq/a4UK4nJb5gI17U7Mw8PleFgmUV4Q
         YkyJsAKnBrKfCXEW/Ym7yhD25yB8HiNVDNwRu4RhJ4nU/7xXWZzBVAvgTsaUYcIM9Ire
         10+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299896; x=1715904696;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BLIfPVA39L5GI7BSivGjVMs24Ei0WVbUZT0FyKIU17I=;
        b=c8wJ6L5z7HaLsOKcBKPuwdyHEV7NOV+OINdlOAG656XpsrjCREEetVyMOxpGJa/PN5
         UmxCpHdySir9x8ProYi8CIGb5rtECcXN5JD9arPlioWpik5JBNWlbfFe/sACSZN+4zqN
         SJ5yBknk6NS7422FMEP6iQ9PmzhfHEB3oUbJ8oNzMyfXWMMAqu1AwVe7PRrcKVuEvZv9
         92yVsXUqKfX8yug6TTeF8ve7aROkDyXzE5TRdlTYhHUc0bneGGoVtDo6ZCZTMVCaWBKb
         CtsFOOLzTOvTAdD3NGtoBJuXHSnznr5lan03sNdPeTkNOJicavvY/FQ3AFuNm4jzW0Pj
         1R8w==
X-Forwarded-Encrypted: i=1; AJvYcCWnW/XJN395kM+HSuBhQSPFojynn8CAcPF7lgMgqLeyS/M17WDe3WaXqO3rwXWXH+8BPD8fG72T58BR4KxDeR3TCeN4
X-Gm-Message-State: AOJu0YxdQ/oa39bwblX3QBeU0zlE9Q08ZrU511xMCA9AL1mYYQeMf/SH
	OQ6GGPEs9T0Ik5oJcUB37lNiW//f7b7wDWf7Vj5jN/AmfDBAt70vaLG1y92bHuQ5iMT3uK6TYHP
	Wpw==
X-Google-Smtp-Source: AGHT+IFtfbvY/gKNd590DPbi3Q8xYAZ3vcX3cNU4cCMn2Exsx2DTyqLE5W9LADivebCpRTu48XwgWckzf5M=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:903:1d1:b0:1e4:55d8:e210 with SMTP id
 d9443c01a7336-1ef43f4cf18mr628075ad.10.1715299895951; Thu, 09 May 2024
 17:11:35 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:09 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-53-edliaw@google.com>
Subject: [PATCH v4 52/66] selftests/rseq: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/rseq/basic_percpu_ops_test.c | 1 -
 tools/testing/selftests/rseq/basic_test.c            | 2 --
 tools/testing/selftests/rseq/param_test.c            | 1 -
 tools/testing/selftests/rseq/rseq.c                  | 2 --
 4 files changed, 6 deletions(-)

diff --git a/tools/testing/selftests/rseq/basic_percpu_ops_test.c b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
index 2348d2c20d0a..5961c24ee1ae 100644
--- a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
+++ b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: LGPL-2.1
-#define _GNU_SOURCE
 #include <assert.h>
 #include <pthread.h>
 #include <sched.h>
diff --git a/tools/testing/selftests/rseq/basic_test.c b/tools/testing/selftests/rseq/basic_test.c
index 295eea16466f..1fed749b4bd7 100644
--- a/tools/testing/selftests/rseq/basic_test.c
+++ b/tools/testing/selftests/rseq/basic_test.c
@@ -2,8 +2,6 @@
 /*
  * Basic test coverage for critical regions and rseq_current_cpu().
  */
-
-#define _GNU_SOURCE
 #include <assert.h>
 #include <sched.h>
 #include <signal.h>
diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index 2f37961240ca..48a55d94eb72 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: LGPL-2.1
-#define _GNU_SOURCE
 #include <assert.h>
 #include <linux/membarrier.h>
 #include <pthread.h>
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 96e812bdf8a4..88602889414c 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -14,8 +14,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * Lesser General Public License for more details.
  */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <sched.h>
 #include <stdio.h>
-- 
2.45.0.118.g7fe29c98d7-goog


