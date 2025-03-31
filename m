Return-Path: <bpf+bounces-54929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE63A760F3
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 10:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9EDD3A1D67
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 08:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986DF1D5AB7;
	Mon, 31 Mar 2025 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhrD9oVx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8633E2C190
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 08:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743408537; cv=none; b=IEXQWAz3p8xdzSMWF45Ikbi9Rl5yf0MZaG6HTwOTkXE8ljX7S5gcSZtVsJtWaGtLjgiZoJkUtlr+tsbfbUWX1GXeqxDixyzobWCwI1cy6mp5uQUH0HQmwXEuP3UC2rf+M/hpT6y+wDRM7EK/z0DHqgSaAn+7HYPinWg0SRA61mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743408537; c=relaxed/simple;
	bh=FRR5cB1nh/vM8lucYGaFfG0ls6N4KgwtkctrvENiA9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qtuYFqKQUuwutwHRR2iAkW7XqJXsMspBRcv4JGM8WhBbM5J7SYnATJSHXL69VfhnAR3S+oP7eGbqrOVJlDqWOlinOqj/Oi6SfcbTmrloIraKnGMJN+BS5Atdv+e4/W6g8m53IhAPeHQdU8g5jA/ZSTKWA87NQ6hH8JFYEk5ojlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhrD9oVx; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43948021a45so42020775e9.1
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 01:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743408533; x=1744013333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0KaT8HQhDpHR+4W2MzH4OynYTGYzQg0Z6mpRBGRY/0=;
        b=EhrD9oVximBVcaNMCYMIMkKeAVDwS0bfGod3DKyWlXfIQG9d5UFCe5PHqJwa6k21Eh
         aQxqIZbPIlVBzWFnX5UF+5pP9PckV363afT/pE2+5xre9x41LCel6W0NzJmbu7uQx0QU
         jXAzMBIdOHona4mwLKuLQrPP8mnaf/R9nOo0dxI3IVQG9xYBArbdhCLytiCoWUZF77+O
         vj1AqhpFqUagbqy5fDRpTrmwK9DIEdUjlmM1EcRxumfsqhDNKHzYaoG1eE/HzgGp6wvY
         W0OSVnMs8xZ2Rnjan6BTMjDxkvCy9V6rYk4lQaQVlV+OdwYY5Ni7pFhdXfE7ObOnfmpe
         3B8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743408533; x=1744013333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0KaT8HQhDpHR+4W2MzH4OynYTGYzQg0Z6mpRBGRY/0=;
        b=wWfNn9r5NEP9RufihEiYTvh+9qmL9snuXvD3uAxeQ720S/Hlu+oIIR6mGJA75JyKJw
         qxwMOOVQ9AkmQhUKtwyhpbuPTO6oIwVGcKdaOsLWncZJqwXguY+vb87hGBUB6e2kGp6a
         6GdqsR7QN2DPcvNIBFuXcrxL+biaTNZYoquPQmeZNp0AJYm3IY8ZDu6OfKCM6qXfBtpQ
         q1qQAuYfqCqW6+2VMPxJAToaB7NrzX10P5cJsAw8O5X19Ui/T3x5v9Mfmtl/o7GxqlQd
         W83yrJhh2UVyUarArXHj1IeTL2xzHjRhEk9ImS4SzZJQAKkGC/39tlV1sIJUKBJNJ9lJ
         tMbg==
X-Gm-Message-State: AOJu0YwQpavfEZeoFARTUbSS33roBuO36/UmhFp03Ty6RdQtSEFRstwQ
	BV5ur394a4Vo7o75rFxHM/53r0vcuqceLVSmMxrsR8kwkoqIQ+0rnH9JasOw
X-Gm-Gg: ASbGncuv+EQHWCeqTzfXJrKZzZ+/u5Z8grR9C1aH8+D9k8gcFRtnRCiY0J6tVwKbasM
	vCySyaFWIuTW1b2TgnaCwKDqjKnx3VBko7P99cIHcSRx5ouKDc39fvNQAZjVA5dRf+yJDpmcW4F
	uXsPkMUZ7e+TP5Jp2bG8/Cw00OvHs0hxL5Romb4U21oDQcHrvajLG/DjOWysCXscCXgvZawy/WW
	Z6tzNnNKrMI19/ZHQFfgLvNvveeFtqlJBxhUlXxTjo56lpSlLmf9gRWSP+wdLJCdlIVdLVd336X
	MmhENdI8+Vea6kXC26scgjLplPNoox31G5CsR01FYxAlWMFENG+JMO8v8h3l7Rn+
X-Google-Smtp-Source: AGHT+IG+VPrwTNioV4kHKUbkIqBqG4phsLHbxsj3d29gRCxJZ6SDJZklG+j1l6/T1ZUlaC1JMS6Zlw==
X-Received: by 2002:a05:6000:1788:b0:39c:cc7:3db6 with SMTP id ffacd0b85a97d-39c120de380mr5128043f8f.19.1743408533318;
        Mon, 31 Mar 2025 01:08:53 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b658b5dsm10471987f8f.3.2025.03.31.01.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 01:08:52 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next 2/4] selftests/bpf: add guard macros around likely/unlikely
Date: Mon, 31 Mar 2025 08:13:06 +0000
Message-Id: <20250331081308.1722343-3-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250331081308.1722343-1-a.s.protopopov@gmail.com>
References: <20250331081308.1722343-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add guard macros around likely/unlikely definitions such that, if defined
previously, the compilation doesn't break. (Those macros, actually,
will be defined in libbpf in a consequent commit.)

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/testing/selftests/bpf/bpf_arena_spin_lock.h | 5 +++++
 tools/testing/selftests/bpf/progs/iters.c         | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_arena_spin_lock.h b/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
index fb8dc0768999..d60d899dd9da 100644
--- a/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
+++ b/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
@@ -95,8 +95,13 @@ struct arena_qnode {
 #define _Q_LOCKED_VAL		(1U << _Q_LOCKED_OFFSET)
 #define _Q_PENDING_VAL		(1U << _Q_PENDING_OFFSET)
 
+#ifndef likely
 #define likely(x) __builtin_expect(!!(x), 1)
+#endif
+
+#ifndef unlikely
 #define unlikely(x) __builtin_expect(!!(x), 0)
+#endif
 
 struct arena_qnode __arena qnodes[_Q_MAX_CPUS][_Q_MAX_NODES];
 
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 427b72954b87..1b9a908f2607 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -7,7 +7,9 @@
 #include "bpf_misc.h"
 #include "bpf_compiler.h"
 
+#ifndef unlikely
 #define unlikely(x)	__builtin_expect(!!(x), 0)
+#endif
 
 static volatile int zero = 0;
 
-- 
2.34.1


