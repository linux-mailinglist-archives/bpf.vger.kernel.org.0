Return-Path: <bpf+bounces-36039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 448379407AF
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 07:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6C31F215D0
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 05:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87A216848F;
	Tue, 30 Jul 2024 05:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCQn9Zp5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46AE524C;
	Tue, 30 Jul 2024 05:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722317901; cv=none; b=IOIOHYZJ/GUfJmad+apEj0V/wuV7A8po8NZkINkDneCSDTHPN1cMcykMu67iFj2UmmkbBeobco4c5NUNH4IX6EFtfJjZXjkCwtxnhGhRP5CrnG+g+flDWZoh/nOp/iHXdl9/dx2LfZJdNxux51WFDtygrHdPi8H0YCpqNsPwdE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722317901; c=relaxed/simple;
	bh=z7jqy9viQO88sVvGeGwwa9OTW/LCLfaSHpJzK/pqR/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rlHVbedCPRDQBwH7jnwNUnb10fPHrc9YsZZrNpDaP8IGfZi+ESw6t4s9R82njhT0A2Pkpy5Jjj6NIZREtASRQ6gdcbGAeLRIG1F/2ORTJR0kydpXQkNiytUtoQPBCBeJCkcqHDhao9NXKBMCaCBDxeP2blABy5qCB6vJDIkY3c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCQn9Zp5; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-7aa7703cf08so3048404a12.2;
        Mon, 29 Jul 2024 22:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722317899; x=1722922699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kmh3DiaajWwrBcHe87HWokqCyVdNgn4Hwb3gpF51Ru0=;
        b=mCQn9Zp5zxxPyEh3I9ra0GQPRi5yOPJLnIs8scWsJHKjRvnEo61J0WsJyrSr/XyIoR
         qTrlgx1wxkFZ5IC7hRIor+V9MbhrE/V29Js689NSVFdCQP3y4+qmfjpwnmudnUG1PYpR
         7rhcgBnRH1JvIiyLq4TFn4jUZn1JS2ehbY3QlkIxCkYcWBmIqo1hu/7UL0Fwa+2369OL
         d9UwVMLsps4TlT/m2CA8E3Tk26GK/xhlJJ53vPznkUSlDugk1SI51vtMrWjsqNYyrkX5
         gE54iSJmFNiGI8VpY/5Ftv9qhy4GwR7/gz2FNkAGfKBr9RyAaLkMuPkKxi24eDW9zSWE
         ihFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722317899; x=1722922699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kmh3DiaajWwrBcHe87HWokqCyVdNgn4Hwb3gpF51Ru0=;
        b=iJQFiPhCxySfThP+3nhgFT3cdMP73iBr1qcpZJ0RpBAi/dXtBl5si0RqRntZTON6/A
         p443FqJoz6julQ0cIPPBMkoJ3ezIjkOT/SV2c6UDjFkIF+uVPh8qkaZdT/UGYH25/EmD
         DErRk7hCjnxEb4+9c426i/KbiRco0lTihg8GP8bq2Z0ChvbYWiTpDWGH5qz8Z6ZajdYX
         xXPvX59pQiDBHeGJRdi+Pi7Slw8UUHsl4GGz+e/nz09mrrw4xUlTSxzwRYnczrCSMT6f
         84FOQafop5vsALcJOCy1R/RcftbcKn5/sV1Q3LvljX5dU/6DPH7ecoP21oEkEMXECg9H
         qtNw==
X-Forwarded-Encrypted: i=1; AJvYcCUSsiuKPsvnI3ffZgmEhkAQ/7mVSCGYWGpwc2nnOOsAkiuElj4BivBYWAQzc66vzV/L/qjsN/ndTn4PiHFnJJMLLHnA45QkBIFlfTHfsZ81lvZ7u0lRVkClNDAfLpCqComgPMr8eb1p32ZxXs4DzOk/umM0KoFs24e4xJeCXcXEgyy02SZJ
X-Gm-Message-State: AOJu0Yz9SCxHcEnCTYONQWI5ShdWa0G64SvBp6RpVh/SFTKy47EifjkE
	pum910nexg5ts5LX2JKlBX2NOXx1+kt2kympP4xTFlisIEXhvW7w
X-Google-Smtp-Source: AGHT+IHNY4b7Xfl4xFRKOR7b7ZHsMIx0qRx7KvFAb6XcCvqxuQ+R3UgYzh/MFH7NdOR1pxeazNm6yA==
X-Received: by 2002:a17:90a:db98:b0:2c9:69d2:67a8 with SMTP id 98e67ed59e1d1-2cf7e097508mr10934649a91.9.1722317899025;
        Mon, 29 Jul 2024 22:38:19 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28c9ce0esm9691206a91.30.2024.07.29.22.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 22:38:18 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>
Subject: [PATCH bpf-next v2] bpf: kprobe: remove unused declaring of bpf_kprobe_override
Date: Tue, 30 Jul 2024 13:37:33 +0800
Message-Id: <20240730053733.885785-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the commit 66665ad2f102 ("tracing/kprobe: bpf: Compare instruction
pointer with original one"), "bpf_kprobe_override" is not used anywhere
anymore, and we can remove it now.

Fixes: 66665ad2f102 ("tracing/kprobe: bpf: Compare instruction pointer with original one")
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2: add the Fixes tag
---
 include/linux/trace_events.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 9df3e2973626..9435185c10ef 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -880,7 +880,6 @@ do {									\
 struct perf_event;
 
 DECLARE_PER_CPU(struct pt_regs, perf_trace_regs);
-DECLARE_PER_CPU(int, bpf_kprobe_override);
 
 extern int  perf_trace_init(struct perf_event *event);
 extern void perf_trace_destroy(struct perf_event *event);
-- 
2.39.2


