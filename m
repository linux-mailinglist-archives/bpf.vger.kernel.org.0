Return-Path: <bpf+bounces-30202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935E28CB757
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F064CB24655
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48030146D4F;
	Wed, 22 May 2024 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ai0w0YU0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728DC146A63
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339627; cv=none; b=jGPlxPG6Yhiwo2L6XzOh1nxtAPk7FxFM5W7jhxCRQGfT9WbmYI9NsnqqoHbVgb+pYZ0GZqUVzUWrNxYKNbaPpYChp9TGMbCIhAPbUhxJ/+4LCYW7Lh4D9CDzBQl7G9ERfUAH4ZDN2T2SJAdW4njMIIkKlKx88hU9zzUhAzDcXgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339627; c=relaxed/simple;
	bh=9Nq6i/uWQL9xoyolHVYicrLpfbCuPU1Pwql11yMTJfI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RIc1VFxaRiPy/TdQuE0NEfaf/zWJeowf5lXMh81g0mqdiJiYWOrs51+YOVJtYm57izHRYAzQ6rjGVj1jReSrj0H1F0hVaP6+A6rw65+XAKh1yTjSTEhKQNvI8p4GNzfagzgqCaWa4aExlfQNrn6WTzq2fUFeZN54d3pAGVHhRbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ai0w0YU0; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-62a379a7c80so229077a12.1
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339626; x=1716944426; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ICjb8r/0X2VlW3crKp/bODhAG5H3VpO5yUTD4XwYdkM=;
        b=Ai0w0YU0mnyUczrAb7KcbsSWujAgaVUwupENoXVEaDg9PVPJRiqAVmc6woJe9/MMdh
         Ij52O3f7PbJiEcOzHWRZXM9G023l7dJZkK1RgwIhZgTEH4Ysn81IFfNMDeaOE7B+32f9
         FrPBlyNqHl+wVd/bikxxUIfisuYYzzY47kE1wpgjFA6Zm9q8SdXpATUrZjuFDgu0hDoW
         nfjn3ObYePCkbj64MRDyEDq29hXjHT9AJcdpaUFN5+jOHmKRnaecuYeT3FoY1kQry1iX
         jZWlxlac1ClsQYIN/75IRQS6V7ONRszxjKZVDS7Ns8ksfTuHd4/JHmv6BEHRmBmLI7ea
         K02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339626; x=1716944426;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ICjb8r/0X2VlW3crKp/bODhAG5H3VpO5yUTD4XwYdkM=;
        b=XN/ihhNzpa5zH7hWiK9nXnl7/m4ZcCjUON/CE/TsiHbgXiaNB0gNsS5x38D7tMSIs3
         6c3IFa97KabwG6ENXbWfFEDD8sGAslSQF4NioCdeNXG8VZ7P8EoFSpHR55JE8a4jAC0r
         Rh8duCX0bbqU7x+FTHyA7j7UWV4iy6SPaXpjcZ7yV3ncCNr8maML1EHEAs45+lFYzE8a
         TBJWH/sWQNRA1Evmn8BxkY1hH4LV6y9K3V3uoE3fiZylmgePxsE8HlQHt5hg2lHH6caW
         bszLxmil8WsX9JNl5cDZRR6vq+B2g90XdtsWg4fFOTU+mRue5mwPJDOuk1k+9thKD97J
         1nbg==
X-Forwarded-Encrypted: i=1; AJvYcCUStAdI8Hq8uQgf2//4gP0xGAmZSkUMZE7Joi5/mfZ1rEaGgGfRnqAbcdFlIHjrIN13cBV3NGAuwj62fljU3J5r6G1F
X-Gm-Message-State: AOJu0YyHW28eRPLtIj3lZUQb9uj9ixiQ8l/BQVaW8yJvIQOwZnyrzHvI
	StzfQ4Wi1qPziGr9SPdDsQHAwXm0LCest+GJJ++/N9zI4AYIDXU4t6QMkXfffI1v3WBMQtYzyVe
	X5w==
X-Google-Smtp-Source: AGHT+IFVVN1hN+8KBf9/+c7BLP6SPEGkbks7vo1HQExRs2GPHR6ceK4qQ3u4PxzKSc59nuvr03+npLjv5V0=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a02:491:b0:5f4:246c:1406 with SMTP id
 41be03b00d2f7-66457fb8639mr36373a12.3.1716339625682; Tue, 21 May 2024
 18:00:25 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:05 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-20-edliaw@google.com>
Subject: [PATCH v5 19/68] selftests/fpu: Drop define _GNU_SOURCE
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
 tools/testing/selftests/fpu/test_fpu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/fpu/test_fpu.c b/tools/testing/selftests/fpu/test_fpu.c
index 200238522a9d..53a7fef839e7 100644
--- a/tools/testing/selftests/fpu/test_fpu.c
+++ b/tools/testing/selftests/fpu/test_fpu.c
@@ -4,8 +4,6 @@
  * module to perform floating point operations in the kernel. The control
  * register value should be independent between kernel and user mode.
  */
-
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <errno.h>
 #include <string.h>
-- 
2.45.1.288.g0e0cd299f1-goog


