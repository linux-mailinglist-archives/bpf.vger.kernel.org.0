Return-Path: <bpf+bounces-53265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A19E6A4F35A
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 02:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1B6188D7EC
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 01:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075CC136327;
	Wed,  5 Mar 2025 01:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8Kln8Bs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE8922338
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 01:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741137536; cv=none; b=Ue2oN8l/c0HJzusCfn8NTEk5UXLC7yGb33+YmAoSPQLbC1uqUR/C4Xbn6vAWX0zojYq5LLWDmjuscxbwTDJ+Nq3oAbum0pEtDq4VeHSYJ7UNaCJ7POpYr/kJDzqoDh30V9LU4ztBPKwJMpiE72XH5R4qB5tvdonM2kgIT2HyFb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741137536; c=relaxed/simple;
	bh=7wLAt7O8W74x95cBoOOBhxEA4GSGkeqLTG2jdVQE1ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FlHSy3VUxpR4UOleLVZZwe7FBa8diDUhCqOHpPZotkVh+GJIkQpij67D0DnE+7LpKEiqtrMniVELcuZVlFON+fg/bBJGzbI9QkL7UyOcC1Dh8c2Snn6OOCEuVdYCbbODQpadW0ODpauU0rwppcX/dEuSySQCJ1P9Cq8VPk9LKq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8Kln8Bs; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43bcad638efso10130935e9.2
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 17:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741137533; x=1741742333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpbEdVMPpfdOJ9ldOmfW/MnEw0rgThHsWUYVOYyHCYQ=;
        b=U8Kln8Bs8uj+cdSw11kI0+P+T+SmpdN2s93Sw2O4EFK6BaboFhYCB0K7n4BYqaMqok
         BQD9RXDzRxKvpTDC38BufMkDQeW39B3qihTjArf3RXPGVXAnywJP8tJvL6N/Ct39W/Wm
         f7eZnC7t77dkx61UnHPVhn7At9LdHHb73w9OzcmmdZ/EiwyuATR4Cg0ZH4KdHOpMzq4x
         4jm2kxA40mMgVIEz0ODASgO6y8euph+4XAM69i9DLg/nlHBLwNctNaTj5Gw/oBe+bBrH
         txnv4Sdo6935YweDtEjV5RjralM4giN67ZVD2f3WDClk+YebpJHNN/Yg7vMNCRId9MmK
         bW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741137533; x=1741742333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpbEdVMPpfdOJ9ldOmfW/MnEw0rgThHsWUYVOYyHCYQ=;
        b=SB4UCZ4k7KGd/oNc9hOeyuCuOgPnY6dJA6DbcMSkE7QtDSXPiw6HaEOCb8WA2LP/v2
         ixZuXGBpwx/nj/UcxNrr9aJhLRiM99coBr7DCJp1kZXPrmN1wYCIQ0vmWkIO72YGyYeM
         SJEUuIlUb2gnMwkw8feNZV7kC47NDQMmTlxRhSh+aHmczO75crT8ln+SEw23M5xnTRbi
         JYbERT/GjlPjSEWM2SOgMT2QR2H59f50FGXFV1hGQoS98kuOVyxS9gwwV3Z6/a/gKSho
         VwzaP495ZzjpQ2hZE9QcUoDlVutQqygLYvwqGpMT4svVhH3gXiSqhzS7bSw7HdEnVvYB
         jrdg==
X-Gm-Message-State: AOJu0YxeejvjWDIt8LcgjSAK1KdVRli0EL3TVP8Ps48oxt6brriwv6Zj
	Xidqnqetzbmg3Bd7WpxgLukS7FS0Q4s9WF+iOrYdNEoWsgJHwsot8Nv/+Ot9hoA=
X-Gm-Gg: ASbGncvXaK+FIX6nyzRHJVNi+eJaEwjnBG7CUxALZXOnW6ejVuwHYEhbIPsKWW+fRrE
	mQJtKlX0nPbFeYiiKOsTrXfXyBlSnMNTJYJ97rqyjSwgsWitGgvG8r6vhUXRCx6o9dioM5sICrA
	FjsGwqnGloN5HryfrmyZ3ydxLC/F/GeEcVOln9S26IHtOV86kxsV4+DXtbRMSdyEEF+9vLP7pG4
	dew9kZOCgBeTQ5cSO8DxvbMZNOb1z7Mms+Zjfxl8pqc1i8FzKCvF1+zFYgDFlPJaYMl8CcJ7x+6
	Twr2MjhERgIItOLffgQYSLrI3SSU4C8tTw==
X-Google-Smtp-Source: AGHT+IFMi1jVWUXBQdvEoFhvu627JLlSjogGj2NkK98qIQpEBvHQcPTsHgVMMGHCdxRIMjLpzLaSSA==
X-Received: by 2002:a05:600c:5117:b0:439:a6db:1824 with SMTP id 5b1f17b1804b1-43bd29d6c7fmr6886065e9.16.1741137532531;
        Tue, 04 Mar 2025 17:18:52 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:9::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39118753933sm3424850f8f.48.2025.03.04.17.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 17:18:51 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 1/3] selftests/bpf: Introduce cond_break_label
Date: Tue,  4 Mar 2025 17:18:47 -0800
Message-ID: <20250305011849.1168917-2-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305011849.1168917-1-memxor@gmail.com>
References: <20250305011849.1168917-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2098; h=from:subject; bh=7wLAt7O8W74x95cBoOOBhxEA4GSGkeqLTG2jdVQE1ls=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnx6ZyvBTMFEOe3foCY/HEA3Xje5VIYhs2yIBBnE2Y Cyn6jTOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8emcgAKCRBM4MiGSL8RyoUSD/ sH+QJDmGOFtI+In1/WJw1o+rSyf77wIeAnz5S9llXvOKiz4XVEX1/U1Hv6UvRNo65hvBJ7YLQeMkv/ OV6fVhNqG85LPOWxyNeRZVwT1EY0upKCgQ2JpUIAE5iYyI6lF73BBm3nuwGnTxsbe+qWsDZtSg0mdw BQVM8rwSxv6pV4i96DgkxgU+TEyZ9MgrGTHtItK5Y5Pw7oJQwodeLkH2PAJYnimY+3IEcxwoGHRxpu xJ7gIQ2EIyeIMNngz3KHEtz7WZGBfZtpOc/AHY/bSbdFQPnJkeZwdNJmDrel/5tO2U0q5rs9xQ96Ln sXIaLgGk+8SolaaXoVjcgbxl2NTu5oPp0Baw+qa7KIaVt8xco2D2jcjdwVczXw22oMwf3eN78107sp BE6qxHlnGR4bT2N923LCppM1PiE3LBumL2/vNDYN5vH4Inuy1R7Cpb3UXv/fbvoFIF7gGMBXvUtWm9 q67lvDP853izcxsbcWnv/iPYFkmG6rvZIKDbibZo7QqZ00BCe5oWKV9oomnAKfI+8pxmOqwyxgS/Gk B85akQ2KR50934GrrvTZvTaaIJsxWm9vsAnTu8G9MyBpOyNwOU9Ej1fRK7Mn5FFVZpKiKCOwM3Mo6E 3nA3sCh/aYV+0GMJ/r5bUrfX/rCSNT9jSI/onT2vEPBI44Wqi8BMTKT5HFoA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add a new cond_break_label macro that jumps to the specified label when
the cond_break termination check fires, and allows us to better handle
the uncontrolled termination of the loop.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/bpf_experimental.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index cd8ecd39c3f3..6535c8ae3c46 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -368,12 +368,12 @@ l_true:												\
 	ret;						\
 	})
 
-#define cond_break					\
+#define __cond_break(expr)				\
 	({ __label__ l_break, l_continue;		\
 	asm volatile goto("may_goto %l[l_break]"	\
 		      :::: l_break);			\
 	goto l_continue;				\
-	l_break: break;					\
+	l_break: expr;					\
 	l_continue:;					\
 	})
 #else
@@ -392,7 +392,7 @@ l_true:												\
 	ret;						\
 	})
 
-#define cond_break					\
+#define __cond_break(expr)				\
 	({ __label__ l_break, l_continue;		\
 	asm volatile goto("1:.byte 0xe5;		\
 		      .byte 0;				\
@@ -400,7 +400,7 @@ l_true:												\
 		      .short 0"				\
 		      :::: l_break);			\
 	goto l_continue;				\
-	l_break: break;					\
+	l_break: expr;					\
 	l_continue:;					\
 	})
 #else
@@ -418,7 +418,7 @@ l_true:												\
 	ret;						\
 	})
 
-#define cond_break					\
+#define __cond_break(expr)				\
 	({ __label__ l_break, l_continue;		\
 	asm volatile goto("1:.byte 0xe5;		\
 		      .byte 0;				\
@@ -426,12 +426,15 @@ l_true:												\
 		      .short 0"				\
 		      :::: l_break);			\
 	goto l_continue;				\
-	l_break: break;					\
+	l_break: expr;					\
 	l_continue:;					\
 	})
 #endif
 #endif
 
+#define cond_break __cond_break(break)
+#define cond_break_label(label) __cond_break(goto label)
+
 #ifndef bpf_nop_mov
 #define bpf_nop_mov(var) \
 	asm volatile("%[reg]=%[reg]"::[reg]"r"((short)var))
-- 
2.47.1


