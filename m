Return-Path: <bpf+bounces-30197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8178CB73C
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11BFB1F217E9
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D453784E08;
	Wed, 22 May 2024 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XkQhF8xT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030BF84A4C
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339614; cv=none; b=Q8ZYE9Ir9C4X8OBthq5wU8gaI9YDpEyEzI6NTjvFfCdz65X7cwQBxlAMbKaJF0WMQ4LB9iiaV8CF+pr0e+33bxbbnD4VRmNOK0NoDHj1mcyAqKhB8YXbcomxMc5RUdJqXj15FbnmbrgwrKLKAkaXpxK9U59XFgz893fHUt8eWGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339614; c=relaxed/simple;
	bh=wsyMQnSJoz2Wb99bdxmDTEHWi5oTqZOWO4XctcEHfZI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kh5ebPJ2+hC9i2YnWzv5JuzDOU1KYiCXVOKPpw9kk4uCsQMUrNkHq2NRefWP/kA8uVo+6C/akElleu5x75WpXOFBrdznZne0FzWddgKH4v2Jc/DrClRf+Cvuc/R34/lgAN8OCWwEPDohIJU2u7Hm9yBttZttAApv9GMTW03lEFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XkQhF8xT; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b38e234a96so12244080a91.0
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339612; x=1716944412; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PsA+RTqEPsjVoyQz5htVdcF3IiHZQEx5aOWSYNx99Ok=;
        b=XkQhF8xTBH7x+fZzve2HF0FQepqr47zFBURLol2odjLRMjJqtHznQZ8//+43psjXO/
         yu+wQrPAQJq+Z8NKmfPeiEI/hQV/+O1kfH/8jzOA0SA3xw8wY7eCnP19UxRxMDekdA5s
         thFu7ZMGchQr5p1x4w8Z03G/pxEqpikRev7OVrVjKCiVv19Qz9aHxRNMu46uiqcxb9wh
         TIWKD80Tnp/TjacnGOKNZjFgu0GG5RNwDOYiecQix+va28C8FtBUK3FLF+pU1mJoscOw
         QrmtrWBFDDS+KNhyTHozakubWiv3OxSBtAO8ODJPfdgqGtKF7KWNrdEBFIsti0WJnpgv
         BoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339612; x=1716944412;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PsA+RTqEPsjVoyQz5htVdcF3IiHZQEx5aOWSYNx99Ok=;
        b=L3GswEqgtht0z9uScG7FTlKNla2dOB5qHStCcT1KZ00imZVH6sGGCdwOkPCS3dwP34
         69v0em3X2ZEbN/K0aJEliOufavRl9wyr/21KhqesVW05a1u4/hMrRJkDaEdrK+IxA/dy
         P+POLweCg/Rk2/wop7NHDH3/WmuxZOLwLYwhEOg7Ns2XPLpKFAVwVw3hBPuBm+XBIFIC
         okRfzu2EsjzWz9ISq2/hn7cxa33nHFrBo69GxdsJ96MqdD6NCLmwivQ+6aLUd9NxBm/R
         XDUnBp6kT+e4FQzOVgabrCUoIfQZ/6iNNxPkBa0Erzfr6gF8lFkUR0vcopzBkGYdiGVC
         gAHw==
X-Forwarded-Encrypted: i=1; AJvYcCXAKTyWIqiN6F0EX+Z6dAR0d+Gj9Rpp9QEx5xmCTxPU+I041GLE/x+c3ELneGZij0HddzCqfPyb3RExNx18qtH4Vv9z
X-Gm-Message-State: AOJu0YzYNQZWkHfyGZAXwwoVXFg9IczTukkUSlu1L+oIg/FPraV7iKA6
	J2Km1eOxp1DxDpUzMY2rySsRcW+PTjr4yVpMA8DrFneNQuCpa3VI2gJ3/IRNaTFT3iNnx5C8noD
	f4w==
X-Google-Smtp-Source: AGHT+IEcD4R5LAcOkQ6bfXkqs31q98gBsHVg7hM3ofLnT8WyE84ISOt6pDCwS+T69u05hB7J0k9BXfKJ8Es=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:c40e:b0:1e8:37ea:d17 with SMTP id
 d9443c01a7336-1f31c948c7emr89065ad.1.1716339612406; Tue, 21 May 2024 18:00:12
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:00 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-15-edliaw@google.com>
Subject: [PATCH v5 14/68] selftests/exec: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/exec/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index fb4472ddffd8..c5bdb653422b 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS = -Wall
 CFLAGS += -Wno-nonnull
-CFLAGS += -D_GNU_SOURCE
 
 TEST_PROGS := binfmt_script.py
 TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216 non-regular
-- 
2.45.1.288.g0e0cd299f1-goog


