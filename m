Return-Path: <bpf+bounces-54132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC9AA6339E
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 05:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82736188B956
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 04:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9021919F12A;
	Sun, 16 Mar 2025 04:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsRgX2YG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE9419ABD1;
	Sun, 16 Mar 2025 04:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742097970; cv=none; b=SOwoXLUqmwJnTRuxo2rIXdeiuHviyE8QQ5e00X8Y5yuyHS9MDSguRXq6612s9I0BX8I6r3SBejd8SS5kqkZtr2xrLuOL8xlqtiTzjN8bJN/f202gtgT10v7ug88JYV5s2iwVub3/kRD0ym/qNuUyxYFJwCcvgmlnIlj9fu5rRaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742097970; c=relaxed/simple;
	bh=TAwmD3mE9IWzqTEdxgzO+SkBgGc9QW4lOFTMCWQX6XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oso5sTbA8E63X9RGzkEeBixnJ3a3PkWELEpstlcXkqbcwieam7SZLDfL0cxdIfRc9EMJGL/dk+F6hC+cxx6Qh4dtCbcPrkmd9NjP8KhO48fxJD67BwILlvWKJzWUejBWpc3wWV+n9HByD6hiTgiloIR346aJ6MN5G2Qtn3qX7zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsRgX2YG; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso3923385e9.3;
        Sat, 15 Mar 2025 21:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742097965; x=1742702765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFS019JG0RFjz5io9ra87jX+S2pDR+I2Zduhbgoaa20=;
        b=MsRgX2YGf2wOhT7f0TCraCICb3m4wiEvVnOxzYCpfvP1W63kjfwhaSqj7J5ps8S6im
         JF86sP1GEonrj2SVPdRSDN7kXQejsM9CkvNS1C7FfAal5Qk9JtJVV5ww0xCsps2G02eQ
         apyD61Xx9oFcGhKhlzdF81/qc/S86c9C/y//+zXppUm5rQUskg98HKEFMl0pnTLgnpVu
         nKVB7lXM4Kqz/Y5Ww6wQVqtpl19iJNFUYbRWxzv+3Z5/y1Z7SjzVXlU7LKIuu/OSpHxP
         BEN20imyM46u5mhiuTCQjEomLL3xmlIry9MYKYXby5B/u7PKT84r9ECfyiSH0Y+TEXcB
         QwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742097965; x=1742702765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFS019JG0RFjz5io9ra87jX+S2pDR+I2Zduhbgoaa20=;
        b=AtJfeglDwxU3UwRf9OyB1ADrHpWtm91T7GTjZsL030DUjp4eO1w4OezfFpLr4njpH9
         NO7bmrEwDqCw4yPYBFquzlemAWlJZhCYkZzZ9PMDiifYnV6TJmhZQgY4DoUCEABnHU27
         qis5M/5M0PmsoR9Y1gJ+WfN3rrOr5e6ePKddM7AEVD4pAUOhpYJBGx5PsydI8Rkoh5WR
         B+TnX6jbLdz52S/q098aYxO89SoXEa0qDtVIpJpmT5mpyJ1ZdJpAJQFmQIfziTval+Q9
         EwWWKU5GYpq/fROVEIMQEkm+/ZI8ruRDE59ppO5d4WTTpLWsBpBKIPiJexNLLl5zLXIR
         /pVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw1nfjOsPZCGA5GozzKKgtfZg56oubOhCRS1D0Fh5lzlDcWyYPSooX7aOytQq//MDURxyuyNnCvXRXDas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm3beMaFUx51Z0LJotDzrTdmI+rqpyJRg0HtbNZPxPn/PF5tRr
	9XDGbXY6we03g7fgfjsUgaSEOqdIbtykTz4SH5+WNIgV4kA9gub9XRRQdu2LKKM=
X-Gm-Gg: ASbGnctjn7UvOIpqTlNB5L8qKI4rue5z9D5dQS9RXfxUwE5oVusMe+tH/JF0wcpw2lC
	Qepy8TsWJShBc2muYbCSADBgjBFUgxRHOIMerWDoQmfFpcc1jNEoBYs51k4GC1APMqfKpSu4aJA
	6HWudUdhxn9VBZ/R1eWpwP9cMUJJNTwYxKiyxDCAVdp8JfuUieoPF/LN/pyg0vNZxQZ5p8QmiST
	jGdMXCaCtDLxQWGgveMkZs+quP9FrWRgW5s+wVtsKlEB3IFytYQBESDvMlfE3Q6hHVOQPsQjZ4H
	DIcmpoXkWlJhmTNrT2PoTmMXTIB12ewuMw==
X-Google-Smtp-Source: AGHT+IHBIpDn5I6oDUPVr9V5ItvG6mUgYbh8JUY0xjPJvkMd3lQIrG6tia0tYndOnZLCB6ubQR+rjQ==
X-Received: by 2002:a05:600c:56c5:b0:43c:fffc:7886 with SMTP id 5b1f17b1804b1-43d1ef4b074mr78421855e9.8.1742097965220;
        Sat, 15 Mar 2025 21:06:05 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:1::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d2010e618sm67780255e9.40.2025.03.15.21.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 21:06:04 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel@lists.infradead.org,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 17/25] rqspinlock: Add entry to Makefile, MAINTAINERS
Date: Sat, 15 Mar 2025 21:05:33 -0700
Message-ID: <20250316040541.108729-18-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250316040541.108729-1-memxor@gmail.com>
References: <20250316040541.108729-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1896; h=from:subject; bh=TAwmD3mE9IWzqTEdxgzO+SkBgGc9QW4lOFTMCWQX6XQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn1k3dm8uyglj3VmEv2htJ2FLhnf1JsYuPf2RZsbxU w2qldUiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ9ZN3QAKCRBM4MiGSL8RytukD/ 9AxDBzDg2jelKivmQxOWC/3ddLF46czI6LpjRZJqkS8CF+Rtgtq1ntcZfd3DwB1YlWNi59wKsFGBnJ dvHyPQHl0wf8x/+YSIKnWOfRTtXXm7HO9EOcusWDuo7nYRoA6dOki8cc0dHPcr7GEZguYUvNkT0I48 RiCeb9ouXdF+9R7dZDI+htv3iB6XrR4vhmfLw+DsE6xSAwFvvJafz+GmaF+szclNho4RF6EOzxUl+s 9fggq12ESIsqk1CtgtcCSL6XBKYoZejR5xun8ldsowdPo5VU+FkBaYLjflcljs+9humS8ea8kzLQdP tBQO13yb3uzxTs0rzzQ5/m2QAPHnV4C/XBS1o7/1f/CZhhWnZfWCaezDqmj0DFHBrWFw2t2BYMKyOt pEej2vsoOJjeV8O2P9XN9/Iu3qJeRZnrOSzeuVMQefuxjD1W0fZFj6Xwgp1NI5FVcn/7XfvNSAOiu/ DO6EIdHh69dWmTxrN+gImrK3Wzp51GSrlSwfasmj7JZIFiKeByLszlkhWluDw0sXtGBsmACfkKy+sM T3FsOfpMqz/WkgyhFoHDnsNMix7+9iuhgQVHa+2cRw3AIbEwsgvPZpdR/BwhcqlQHmSCPw7fcEmu1a biNUSz51QbPHYHW/PBBsMPvZawZXKGycs82Q07EQPrq2bm8G4sFtEpjZMzyA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Ensure that the rqspinlock code is only built when the BPF subsystem is
compiled in. Depending on queued spinlock support, we may or may not end
up building the queued spinlock slowpath, and instead fallback to the
test-and-set implementation. Also add entries to MAINTAINERS file.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 MAINTAINERS                | 2 ++
 include/asm-generic/Kbuild | 1 +
 kernel/bpf/Makefile        | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3864d473f52f..c545cd149cd1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4297,6 +4297,8 @@ F:	include/uapi/linux/filter.h
 F:	kernel/bpf/
 F:	kernel/trace/bpf_trace.c
 F:	lib/buildid.c
+F:	arch/*/include/asm/rqspinlock.h
+F:	include/asm-generic/rqspinlock.h
 F:	lib/test_bpf.c
 F:	net/bpf/
 F:	net/core/filter.c
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 1b43c3a77012..8675b7b4ad23 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -45,6 +45,7 @@ mandatory-y += pci.h
 mandatory-y += percpu.h
 mandatory-y += pgalloc.h
 mandatory-y += preempt.h
+mandatory-y += rqspinlock.h
 mandatory-y += runtime-const.h
 mandatory-y += rwonce.h
 mandatory-y += sections.h
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 410028633621..70502f038b92 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
-obj-$(CONFIG_BPF_SYSCALL) += btf.o memalloc.o
+obj-$(CONFIG_BPF_SYSCALL) += btf.o memalloc.o rqspinlock.o
 ifeq ($(CONFIG_MMU)$(CONFIG_64BIT),yy)
 obj-$(CONFIG_BPF_SYSCALL) += arena.o range_tree.o
 endif
-- 
2.47.1


