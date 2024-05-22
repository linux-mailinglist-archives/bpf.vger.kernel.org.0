Return-Path: <bpf+bounces-30201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F2A8CB753
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C101F21499
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2DA146A7D;
	Wed, 22 May 2024 01:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yLTtOhdx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E57146019
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339627; cv=none; b=D1ZUCR4iqa8lm3y3q9lc5L6ryMZFufvDoNGMxRuRFXqni8DxtmHpQKrd9v4FP7WtMYEiX8Nuw6FW9oJvsaaUNNslVv9zwUH8nuY/CNVgPcl/UEro3xGfGOiZjHgLCPD9Azfb5BTdXdpCoKfw6c9+7jzy547D1sA01BaNNh0oapc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339627; c=relaxed/simple;
	bh=h2u1MofALu0r1tYsSYukYszzEq5gHMXIX9iUm9aPpv8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rcwrCdg2ANl/286ApyiXXxK87eoAbGM3duyzFs5gyqqlK9DhLB3E2ghBotPaLLMCZui4t1ibGpbxDgyAi1411VZtT0YYTyoR1UROYtW17tnYQDJACWaqqxIb25Susq3c0zSmDuKVs2+5IB10lRB0tpdK/p7KAm6RtOvgR/5ny58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yLTtOhdx; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-65789db0259so6460905a12.0
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339624; x=1716944424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NK4aimLzcbzcHbun/AiqJMn6SwzGMo+GBjyX7d91cEw=;
        b=yLTtOhdxpJw7AIeqoZGxYnthyR5KhjOoSFpQitVZcURhgTCyvxMX6vR6juapy7h+9N
         f03TpNYeGMeBA2y6LMHt9QFomIFDpn+CVL194UM/v4taGt9aBvWdi3Fv2OhKx9l7uaI+
         OtycS5kol5aPsydq+GkLGiyi/ue/5wk60oWOoHBIapZR9nISOLaGLcJMwqcAPg6ToIir
         HSrVYpWNCIZlrZxgOK5i4ZfJMO2nO3W536FYc0ZRTTuBEu5wtuPSvWWCWgxn+uLmzO+n
         MpaNZX3StcGh5spUrdn+qtPWbrhTBHNNFHlsh+NNK7ZH8+slrAU9YQtfamDQgsXARoT6
         6rAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339624; x=1716944424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NK4aimLzcbzcHbun/AiqJMn6SwzGMo+GBjyX7d91cEw=;
        b=N7KnzRILj7dQl9L73B8hNuo5SMqz68dOo0g92V0vspuT3MUzveQK1Nkd3nR2pdA7+l
         sVE6OPz0ZkPY0Jea4pmu9AE4oswdsTm8wE8xibKwSvb5DypWDck8fzT/nvSOH2VFscQk
         +6zupG/J2IwxN8o+8T9z1gJm8KrFc+hHIBSZSQ6pVRHasMBIkfWH5H62+6kOUiE6AxmV
         F92QzXaGC1iyOLtNSvY3HHHIjBlp2bG8x/t/eqZwnI1ql477oEnoAYU3kZL41b6CCqsg
         bMMCOBvBYJLDYvqlnGxRunmNeTQ1yW326+dB5MMuwKRfz7guewVKgP85gVQ+3iYTacCn
         HyKA==
X-Forwarded-Encrypted: i=1; AJvYcCUhcu8dGBeWclny4PBrZgSe4VcSs2gusQX02gHUE4eg3nDQXqob5mwGpfqSx2UB3lHDOTg90xHUBC/4NvqDxQelygJ9
X-Gm-Message-State: AOJu0YyUhKft2s1qGzO0own7xH5mY5cgPqd63Lx9xykZKjRKpaWH+SiV
	RZeU1jPYNbqhY58egcdnHkQmv6uFBoK9ZjQmC3X6nxwNF6Fjda9Pe7Ny5fCv1VLFHbZE409nr4L
	IYw==
X-Google-Smtp-Source: AGHT+IEfubfbv0g1n6E/xjRKgWJVsI5mDRaAB3rAehbhcdlOwRi+21CKT/tu9kKkmJpP9Jll2mvLmtGZyiQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:e74f:b0:1f3:135c:f70f with SMTP id
 d9443c01a7336-1f31c97ec7fmr402795ad.6.1716339623577; Tue, 21 May 2024
 18:00:23 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:04 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-19-edliaw@google.com>
Subject: [PATCH v5 18/68] selftests/firmware: Drop define _GNU_SOURCE
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
 tools/testing/selftests/firmware/fw_namespace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/firmware/fw_namespace.c b/tools/testing/selftests/firmware/fw_namespace.c
index 04757dc7e546..c16c185753ad 100644
--- a/tools/testing/selftests/firmware/fw_namespace.c
+++ b/tools/testing/selftests/firmware/fw_namespace.c
@@ -2,7 +2,6 @@
 /* Test triggering of loading of firmware from different mount
  * namespaces. Expect firmware to be always loaded from the mount
  * namespace of PID 1. */
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
-- 
2.45.1.288.g0e0cd299f1-goog


