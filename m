Return-Path: <bpf+bounces-30226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842778CB7D6
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBB828804A
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96BF15380C;
	Wed, 22 May 2024 01:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M749ZcAA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FC2153573
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339699; cv=none; b=tAFipjhRg2wPguahlvOaEcdSEP7wawCIKFEnbCqnDH//YJmgXsy894oJxxPKiZvCW2ETm8+MdkBLwYg/bCtEtW5GVBHBBLRUYBXxhcNHcrLtZGD10ZCR9xKX+WO21S+TdwCEAAP4HfOo+wvbTC4ApbTrYDTH4hf2EcuBvwDV178=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339699; c=relaxed/simple;
	bh=5HwaigB++GvyNQzZfOX3IT/xGcxYHjiLCiVX8SmJdZ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b2dSKZhO0UWsqsxTn7qRui6lwQMkv2cIMTMqgC3XW53dnDRkD3hvuWkRtjBCzQWZMDKTZOX9IHnSx2JqELLRqTzrB05Lo0L/m2XhNEhWidalbjeZ6hIqDRdBixHtC+Ufmk4jNYWOwrsdG/MfiUY7h1f0PPL6DgLuhFvgRFAubkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M749ZcAA; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f474d00351so9451520b3a.3
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339697; x=1716944497; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+hOshFmf6G7zEK9XyWMlNtDhU83mdpWiA8UPY2QVI6c=;
        b=M749ZcAA5xq7A3+Tuwt4nS1nmkCwG1KujGuwQN0ysupV2FApOkscbgCJzqctSaSzCb
         h60rUj5SKdU4GTmiHIHtCCuSOuefMN843XzFZUDFpQVVfqXcp9lkw/K1ZZAsw+QylMq8
         iQbm8E9aBzGZhmfXeg1sElT0CS7jUlZaxRBP8lz1L9lout/mqHahuAsaO0LOTD6ECv5j
         NaZE5DTy0TlYFOXAqaDjXuK8BzC8To5JeDkNd48Mx/WXL/aa5h7kxpPoTDrCoKNOJEvN
         REhVgJ/HrBvOGavUvOGkIUy9Ck7eEFDx1EaPf7GZ8csf/Jf0je2eiozvvWTnuEh7VJPk
         dwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339697; x=1716944497;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hOshFmf6G7zEK9XyWMlNtDhU83mdpWiA8UPY2QVI6c=;
        b=SeFV+Y0Ri3pAHOnpCjNuND3foqB4zg3x1slFv4pKxyrThMDtkpZpmp+I7yIDD3841U
         B/5Fu1rGR4qejnf2zKjsaiQl6JlWc+wdr1L8ybez6vtKWDyespo6RRhavCdnQ/B+7w4J
         qkY4Ys+/bEWWiesvAm7nW++JEwwvJsLGmR0n57ql9ZUGGTQNpenquxbHfXC3QYj6YfZB
         p4M7BriY1bmJoCAg9qafHgNHY6aR5uOLW/EdZWHYtUasc3oZQLpdhNuWMUFti096OA3s
         FJJftv/3U1Woy+AmEoeI91U/ZqA0HVIAd1F+UvAA0r/18g3egqA3iK4yr+22dOrsSk5O
         Egcg==
X-Forwarded-Encrypted: i=1; AJvYcCXDVkKyXH0CNXXF8Icn95qIYgtf0DeKxfr2cr1Sfv7FslUKXgDBfO/esTBguoSDFs1JrAN2fIKtlByBSL1ewEF/QDOe
X-Gm-Message-State: AOJu0YxHKqPVKYhvEQm7xVBlQqQvAYF9U66hwLTxsbvWrPDlRKEzOcf4
	oXWPedAhoeOaxhGD3fiBAQDK+6tA8wSIiwimGLN5VD6NPZoB9PoTOiKAgzOmRFCW4o64uviRPyH
	76Q==
X-Google-Smtp-Source: AGHT+IHysubaIzqInuZoraBMn6KY3/zhAPfwf/Xk9cMSLEOs6DDr4Qj7OXFhv9O7YBXKJiOesYtWd3F2Ac8=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:2e17:b0:6f3:eeda:a844 with SMTP id
 d2e1a72fcca58-6f6d5fdba7fmr15269b3a.1.1716339697132; Tue, 21 May 2024
 18:01:37 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:29 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-44-edliaw@google.com>
Subject: [PATCH v5 43/68] selftests/ptrace: Drop define _GNU_SOURCE
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
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/ptrace/get_set_sud.c | 1 -
 tools/testing/selftests/ptrace/peeksiginfo.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/ptrace/get_set_sud.c b/tools/testing/selftests/ptrace/get_set_sud.c
index 5297b10d25c3..054a78ebe8b5 100644
--- a/tools/testing/selftests/ptrace/get_set_sud.c
+++ b/tools/testing/selftests/ptrace/get_set_sud.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include "../kselftest_harness.h"
 #include <stdio.h>
 #include <string.h>
diff --git a/tools/testing/selftests/ptrace/peeksiginfo.c b/tools/testing/selftests/ptrace/peeksiginfo.c
index a6884f66dc01..1b7b77190f72 100644
--- a/tools/testing/selftests/ptrace/peeksiginfo.c
+++ b/tools/testing/selftests/ptrace/peeksiginfo.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <signal.h>
 #include <unistd.h>
-- 
2.45.1.288.g0e0cd299f1-goog


