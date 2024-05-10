Return-Path: <bpf+bounces-29343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300FF8C1A55
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF22628147F
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713EA1B977;
	Fri, 10 May 2024 00:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vZ6RUIAR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A1F17BA3
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299751; cv=none; b=MsyuEDfrL6LaXSGLd3yEG7/RuEP3ejOTHbLVnYcKFLgH7JHZK5oT5xR+lwazwkTeT5q3Yiwb1RDD3NFbadX88T398o9AlUpEWM120mn3jPh0d6ptfhZHHxSUys4FCCvHm1z+rjQaPkGi7C1QDMIfm6IkKSSD9wUfpXsX9w/u/Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299751; c=relaxed/simple;
	bh=euHNwBS6Epsw1wGiLajK2FBLzSmnArw8M3ba7LO9eJs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m6hZmtbTDpdZuqCUgw+qs3xnDZnItJ8kMKj7ylXmHs3/6y+AKNCOypzlScBnLcB7/YXRLLiAMWfcak7uiTmnMv52zyDbgi+c474+Nc1WxQrgZSEmLR7UEMnp7ma0qBQQfXslpHJ431cBo1zeYQgUvrqVm8VN/zkNcnUrBQKQnH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vZ6RUIAR; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2b294c5ebc1so1344470a91.2
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299749; x=1715904549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fSnXkY+i8xBz8FisUXSmsQkSZaie1U2SXlbBYlPacTk=;
        b=vZ6RUIAROp4TeZVIOsBzL+Wq/esP4F5Ptb0waSrED95Do9vKJdY7Pmm+SwTDdlxv1Q
         A7QGcisSKcDaqVY6mZswZWJUOYl9BlBm5+++3jPqFCG08CKoZhrIBOHvpCIoEdYwjtdf
         CqlmY7ZrriAaaE/Xpy8Wa7W4uGiJBCVMbaunAcgrzhC3v7Z4v4f9mnhJhO6VZbvOMZ64
         MQkdJExyAgkO/7hmSs5lw/IJ6dEi3icChbWPwKc9EqAv9SKKtzWu4ZVH7EdudB7jGWcW
         HkaIImw79HjdMNOrRIcRLpXm/HbjcXgP59CJjqgMpguGqZ7BmU5oKEaiMXE4DcBNueyW
         yU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299749; x=1715904549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fSnXkY+i8xBz8FisUXSmsQkSZaie1U2SXlbBYlPacTk=;
        b=a2udTgxBBVRY3oIO546XwKhsfBcWdfrFaz5T6hsE3wHIbfYdN3vy3jQnOuTlWMMeEL
         xA2x6rUIeH7jIc5Rdrhkce/IKyfTTvuoiposGvubH6vC8GPKsXIq/l3Sayii67nGroZ2
         b60+ieOoai2I952a1EYebQ5x1GZRmDNxKJqvDZ2qbKLZQLGfUgbtCDu2bW3ScWEcBqIJ
         LCLJ/WxCcpIW8A1uBXSevgXx16dLkLheox4v5Q8nE7UabRwikFcLsFO8QGYGKI9UY7zd
         hcIbZ49HqLttwZk0ssRtPjGqurHT3+bkwJirGUVJ9RRSvCadTWWen66uoRg4PtY2gABb
         YURA==
X-Forwarded-Encrypted: i=1; AJvYcCUjxNfKLLTqs8BzMa7xiMjTuxTP4e4220+TxzFHStSlhW7Qayl2CdALi+wEK49Rv7viwd+lkqBOuLsBbi+NsggGvC+c
X-Gm-Message-State: AOJu0YyRgLSx+e3Ltk8O4X19r5VkOJ40oeV//mASer9MqGr8ulMdTodU
	LseDJ7JW0k2+dPTrhiPxwkrGzRgojfLRgp1m0eZbJTNfQuGK7S1c/ZZOOfyayV3FB5otnppKoa7
	F1A==
X-Google-Smtp-Source: AGHT+IHrf8Ip06EWjJVaznBkpYP2PcAGdeazjj+Ng12mTejT5b1sQiTOfSMabgEBTdHLaeObK490rYSR9aw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:f2d2:b0:2ad:5fb9:16e9 with SMTP id
 98e67ed59e1d1-2b6cc247cb3mr2716a91.2.1715299748321; Thu, 09 May 2024 17:09:08
 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:20 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-4-edliaw@google.com>
Subject: [PATCH v4 03/66] selftests/arm64: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/arm64/signal/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/signal/Makefile b/tools/testing/selftests/arm64/signal/Makefile
index 8f5febaf1a9a..37c8207b99cf 100644
--- a/tools/testing/selftests/arm64/signal/Makefile
+++ b/tools/testing/selftests/arm64/signal/Makefile
@@ -2,7 +2,7 @@
 # Copyright (C) 2019 ARM Limited
 
 # Additional include paths needed by kselftest.h and local headers
-CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
+CFLAGS += -std=gnu99 -I.
 
 SRCS := $(filter-out testcases/testcases.c,$(wildcard testcases/*.c))
 PROGS := $(patsubst %.c,%,$(SRCS))
-- 
2.45.0.118.g7fe29c98d7-goog


