Return-Path: <bpf+bounces-29244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8F78C1623
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF0672864A3
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E05F134421;
	Thu,  9 May 2024 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nxk876M4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E47D84E05
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284891; cv=none; b=NlqpJgUA+Ece+FgVZSDpzyCdp7FBRi65586k2qLKV97Sks29JXjATu7w1Pq16e61vfkHFxVYQ5pCBH1zVsAfviEbDW82wf4Fv2rg8not0nQhd6BeYSGRME0CusP+bGSrw4q/DsV5ocPka8mh6bYOm9w69nL82svjPAGl9N0RCiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284891; c=relaxed/simple;
	bh=NLfWchjBMnfj0uHgc+lZRCh3/hwhcn1C4pDxOTbEqG8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jz18MpYy8VwWydIm8nZAMG4TK/sAHvGC2pzKpYCBqQqrHT5YqiDF1gM3udcMsdO0Zwa6xWJfATPvtV/Sg2jU8qBq/EuVTxItYmFWaxqcETxguEXx/EEI0bKpyIdmoShWJ/iOTwPBcfYshk+OO2gOOgXtR/5AkqmQXURz6V78LIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nxk876M4; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de5a8638579so2119461276.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 13:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284888; x=1715889688; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C3wSVWuIBaY3YuCyJCESt9Kj/Ip4PjdWD4+MMXdzxtY=;
        b=nxk876M4d4a7uleVvTf5RtGdGgChoJfyTYNgKVRutTKLrwGPv6yIdH5v87Ml+5M8ZQ
         bxH1k6jxaPdIqFXxmFU8FSl+KF5EuABHYaoWqAyD/qw6/bwddWKQU/lN3K4s+6QK29NR
         Q9x4qbNpF+BsZkcUJKg6lit9J6G5g/FFh7WrxsQUYHjBDwZbifXo6G+2spLGhXWy604e
         AnM08jUI4vNZlxWvdl7pmI0TKQZrQ+uToSYVEX3jCrHrTPjhks3uL+i2N/RT7Z9dkXLR
         Ij8OY+vHiiaw7Eg8uZ+o6miOgyavCX7k7poZhiTFZcZHWKpgY1GOFYA2OC6crFzE3GCl
         p+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284888; x=1715889688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C3wSVWuIBaY3YuCyJCESt9Kj/Ip4PjdWD4+MMXdzxtY=;
        b=te1XcsaqM2l8kPZqU91OUi0mwaqiq6Flw0W1CeK0P/53bm0n6QaYg01Vz2aHVZ2/WD
         wmJoR4aSxMrxUB1tvwfEmZPbreS5niG/dx/pbC5nRm+pfoJYHAcavKKhnTkBLbg+mY7S
         48fMK9MJe2hep7ZQMrZr4cDEp2m5u0BMXE/IGTKX8O+/Q049W6mHizBXw2tEo4kJgRbW
         TCSbr0NaFJ9RAm37uK7MVFtqsO3/8B1AU8siJ+Aj03rEoP/Dam+HCv9HiQelcPlhqp6B
         PECwRf94j6mlOrdqWdoCRSvfm69j64WBcTAiMZ77DzqAxKCoVukEy2rGXkGEeNtOcx4N
         yg/A==
X-Forwarded-Encrypted: i=1; AJvYcCXG2+zxRG3g7VLwhBQgGCnI8fj/EVmjRDgWDWZf898etbkPCTfrSqbMO89pYMKJbhTj59EQ4Xqae8Y2VouoZpcAhmzt
X-Gm-Message-State: AOJu0Yy5ChYPQfRhfh3p8CTchIWmjGwjiQVqxzJ9Vv3yskUL3FKEwKnq
	285+CfSWJnX56X0AVganS3eSCRZ8CUISFIg1gQHvRpnu08RuYS8WALa/1YR9zy1vq9qEg/j0o7M
	rDQ==
X-Google-Smtp-Source: AGHT+IG3vixfOgsVRvWw8ba1GSc0WVoejlZw5UUOvsn+v5cimkQ1a21N59uv9KSFtZ774wjBAuCjwsx2Iew=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:d3c7:0:b0:de5:c2b:389b with SMTP id
 3f1490d57ef6-dee4f1924eamr46589276.5.1715284888528; Thu, 09 May 2024 13:01:28
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:06 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-15-edliaw@google.com>
Subject: [PATCH v3 14/68] selftests/drivers: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>
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
 tools/testing/selftests/drivers/dma-buf/udmabuf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf.c b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
index c812080e304e..7c8dbab8ac44 100644
--- a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
+++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #define __EXPORTED_HEADERS__
 
 #include <stdio.h>
-- 
2.45.0.118.g7fe29c98d7-goog


