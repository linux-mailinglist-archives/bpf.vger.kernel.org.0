Return-Path: <bpf+bounces-30234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC268CB800
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24D04B2364D
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3700615666B;
	Wed, 22 May 2024 01:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F99wygNJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C8115533C
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339723; cv=none; b=jPLJfYMXheFx+akDplQ0sm8oFKqViVf1HdsSwj8A3nvgaEX2bosAMDsu226G0d8yMG67tuoSDyjPcF3lVKAPMJw4/bwCDtvh7xJvf02uQPxoi0Al7HWMNqcFEnvZanirtVMqjGdpui7B4gbZdPOQXURf1VcfQ/gvZO/3oLeSpmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339723; c=relaxed/simple;
	bh=63kKOK9q7td0MhpcQUXeLupUPzT9Zvc/+i5hQx2aP5Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TLhkoftx1mR5CwsdZQM8+Vljx9QNkUgMLSZN5OEqKxq4Dajw+anZtdgSx6NflCbmoWI8ocR5nST13oDRxZ/8LDmQHDRsIGFYlYSskdNkeX2RK3Q7NRHK7K71Ouh8+v4TePVx5pQ3zBWwQNBeCjz3WqdI/X8inPtgFJOs87r1w1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F99wygNJ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f697985f86so3218923b3a.1
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339722; x=1716944522; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dUmmygsAekCvb1sAxXTt/LLFhqw2XmquX3PYUBGtKuc=;
        b=F99wygNJJgPP1z2gxhwQdyooccpIWRNehMq2mJtLbdgccOqIgSxkaXfGnZMoFttqgm
         siXZ7P7ICY+Rn13X/ZNVNx6pLeSkkzr1/po+lna6xr0S7T/e4rY77qVWiWucvt12+DEm
         FeDXnQw58V58c7uOE+IIqBta/8T7HV16IDq02lu9MN3MZpOCExDEP6tG4QkfKWQXIttO
         +AbIbvorkxfAdcIZzm1OPhwZD6ZhHNF8Yz3CteZGeXTMJteSWmfK8HtY7GikctroheRo
         i6+jzhdHbIETaw8QJl8iuRzkK9qYhp+e28PyxOptRopImQy/21KvC5rqEsRewPIRIPL2
         x50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339722; x=1716944522;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dUmmygsAekCvb1sAxXTt/LLFhqw2XmquX3PYUBGtKuc=;
        b=Xn2nRsmBZS+Fofquqp10W9T7rGaehbC4+uL7tu9FlG92eVoe+DKA0gHteeu0F+62Ye
         km9+KtoSX0u4LRj6qt1BbEn7qLcTsfwnj8R9oe6s+nsSyOf8mutYFYQ+xfEHDtr6xadT
         w8eOAfSZHC0WZcLMxJ+rigcnAMv7sGbAzyI6BY2D/DmkFiskbTQa0D+JfQBrHGVMNbjU
         su+leLs8u5Ekc5urlIFCF0HUJKJovADfk+CfLjNkEHjtBXEJ+bT3bNQH+dWWKEh4EjRq
         Qv842Bs+QrezWSbY6Ca9dDrw0idCeTCFV61TEsLmwx7BRW3RHEwD3gSl81DPnnMfhk/L
         PFfg==
X-Forwarded-Encrypted: i=1; AJvYcCVh1fH/8aqxi0WF8lJTt+oFusP7xqn298K73fvWoclx+5Ke3RrwnRFZc8/Um0Uc3Ghx0irzVt5k7ScR+hsQhS2rwyqZ
X-Gm-Message-State: AOJu0Yx62hfY7YM2aCkL271AfUx+7AmTnH/DjbbjDByWzOwFrerCkiKS
	WGwjDwAn5S/FychS28WLkT+VKkXRvmURl7RwJv6VyiA4LdhG1yhoA5jQf8pO9IR8nyIEr1RGqld
	YGA==
X-Google-Smtp-Source: AGHT+IG4H8QACvR6bgMlwjQZlJORskEQiHsnadZ28t0SHRUcGChmPWb+2uVYxv2B/0aMSfdVlBWp3ChsGV0=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:ac2:b0:6ed:d215:9c30 with SMTP id
 d2e1a72fcca58-6f6d64c9235mr20041b3a.6.1716339721836; Tue, 21 May 2024
 18:02:01 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:37 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-52-edliaw@google.com>
Subject: [PATCH v5 51/68] selftests/rlimits: Drop define _GNU_SOURCE
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
 tools/testing/selftests/rlimits/rlimits-per-userns.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/rlimits/rlimits-per-userns.c b/tools/testing/selftests/rlimits/rlimits-per-userns.c
index 26dc949e93ea..e0b4f2af9cee 100644
--- a/tools/testing/selftests/rlimits/rlimits-per-userns.c
+++ b/tools/testing/selftests/rlimits/rlimits-per-userns.c
@@ -2,7 +2,6 @@
 /*
  * Author: Alexey Gladkov <gladkov.alexey@gmail.com>
  */
-#define _GNU_SOURCE
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <sys/time.h>
-- 
2.45.1.288.g0e0cd299f1-goog


