Return-Path: <bpf+bounces-43952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7A19BBF56
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 22:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF76281721
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 21:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E611FB3C7;
	Mon,  4 Nov 2024 21:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KoWLTJ32"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E080D1FAEF4
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754412; cv=none; b=TyUY/9L5iZoOJKxe9/PiJzZH+HmmGuI68MbTkQcFFphHUPQGoqiR2sJ0QmtLNFRcrobocGJJI268vMwtsERwlEbOSqimSlTisWlPs2kt4e4YDjbVFFEnLQxWZHbZSOtJqegPEzW9MveJMt5JMUJ2Lk60MoRdzDWatqqYQ6zc23k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754412; c=relaxed/simple;
	bh=ZitlmStPUDyqE42TaZ1/Aw7xZREQZHuveVKJPTTwCSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PbkVuEHrvEelLmZ79Dfgx1+vOztUel7QpSHxE0XUwjNp7fD8aQiUdmeENvJWz78sRwd1j1wBmVNbVOJUyBsXdL79RwKmylsyPYRaWf9Pcc5ckKfBI2v9reZ9eH0Mbl3+/BikA08IusLmUfjtmVVTgDgQ8OeQ+rQJZtTeRjqAACE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KoWLTJ32; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e52582cf8so3998190b3a.2
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 13:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730754410; x=1731359210; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+963qXEwYm2XJW7YS60AKfnebwcLNYV8rSqgqXSlsc=;
        b=KoWLTJ32jbqoNjinww4vRlZ3HHgt7MYgMJ52xGcry7wXQzaI1E+gI2vO6HdeQukCWn
         ss3FHBvF9CXLUIuZIaMCKwb/SEelmP8BZKrZvFs5bspJl+gxXiwKdtkLBdCBA08XWU9m
         T4XmfzBRSyBkzPj7udAKSuowzA+piu0M8RJU22o1/Lfaaqkw5s4olZB9LY/spFNbREWa
         NyGBgaqDG1aKHtlw6MMiJqMdNLmD94K+HhW4DEnVL0jRdBLEFMOq+5+S4TVtXNnMi2ig
         SjHlpa3P8GVAWZwsdtjPMPO2kWGrTCTzvPFrfjmsjDujRqQ6VHAokkA47nluml2wXPjc
         qwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730754410; x=1731359210;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+963qXEwYm2XJW7YS60AKfnebwcLNYV8rSqgqXSlsc=;
        b=p0VYfoWHMFnZFtJ31RECB2EoffWSoZwhLj3v6yAXMRYaTRf3wQw6M8dsbHujVggZ+x
         uPcS5Kk501fs2NXexyYPRIQcGFqbeZpde5SGUC+FzfaTZ4TSRm7eS51x9G0skIJhSfhT
         LcmbduIzDnmoB2RFvMO5x4yM3H6mefxj4/lv61WKIl/WjU2fhhZFCN8mUHLTU2JF/sp8
         0U7AR8kfXHPVnc7HDucS+YhqeMSwoVKThsKCkp1UBr1cMhsr6D9Eia9A+lsaBiBrjdip
         +I5Rc2tJORm05es4TcqNdIXWP6mOwhZpkHqajDULFS08/bLmba3WEjtE14HiWB0OS9pC
         5llw==
X-Forwarded-Encrypted: i=1; AJvYcCUGfQy88cXOOJ4NUQ2YQOpEfH9tE+dLQVTTIq2W06Cv7+FUJeJY/5ib1naJRU+X0UTard4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdaWJBF5/PHL+JUGH8nLvL2TVt9iZZ6CcK3Jqq3zIbsTOu9EWX
	3w+NPqY7KcM84zi9gEgJrcCznw2h5ueKNdjZidxworRuYeFGQV6Lq10xYgHj3Hc=
X-Google-Smtp-Source: AGHT+IF56vX4uXLDm1AHdM0OyBuJkwT7LeC8FxDJ053gvmIEUtUOVtkQSjLnyUylcTDwbzpxIp0ndA==
X-Received: by 2002:a05:6a20:3d88:b0:1db:ec5c:cae7 with SMTP id adf61e73a8af0-1dbec5ccb0bmr2012154637.40.1730754410022;
        Mon, 04 Nov 2024 13:06:50 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee490e08f4sm7248293a12.40.2024.11.04.13.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:06:49 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 04 Nov 2024 13:06:05 -0800
Subject: [PATCH RFT 03/16] perf tools: csky: Support generic syscall
 headers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-perf_syscalltbl-v1-3-9adae5c761ef@rivosinc.com>
References: <20241104-perf_syscalltbl-v1-0-9adae5c761ef@rivosinc.com>
In-Reply-To: <20241104-perf_syscalltbl-v1-0-9adae5c761ef@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
 Leo Yan <leo.yan@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2542; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=ZitlmStPUDyqE42TaZ1/Aw7xZREQZHuveVKJPTTwCSY=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ7qmebSPvJLnlxCDzruxNWwTI9QuWXrtCxerXi23pumc1
 TmjYJuOUhYGMQ4GWTFFFp5rDcytd/TLjoqWTYCZw8oEMoSBi1MAJnLnEMNf2dTNCj4yGg/ju9Z/
 PpMy3XOKlK28r5DDSzEJ47VhC9v5GBn+SDgfyNnayyra/erw82XVu80mWx/ya+lR2ioWWRZ7/x4
 HAA==
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

csky uses the generic syscall table, use that in perf instead of
requiring libaudit.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.config                            | 2 +-
 tools/perf/Makefile.perf                              | 2 +-
 tools/perf/arch/csky/entry/syscalls/Kbuild            | 2 ++
 tools/perf/arch/csky/entry/syscalls/Makefile.syscalls | 3 +++
 tools/perf/arch/csky/include/syscall_table.h          | 2 ++
 5 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 504d762cc572..a19c59c8cd3b 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -36,7 +36,7 @@ ifneq ($(NO_SYSCALL_TABLE),1)
   endif
 
   # architectures that use the generic syscall table scripts
-  ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc))
+  ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky))
     NO_SYSCALL_TABLE := 0
     CFLAGS += -DGENERIC_SYSCALL_TABLE
     CFLAGS += -I$(OUTPUT)arch/$(SRCARCH)/include/generated
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 02ff3f2fcf12..7c5fba39d8e6 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,7 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc))
+ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky))
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
 include Makefile.config
diff --git a/tools/perf/arch/csky/entry/syscalls/Kbuild b/tools/perf/arch/csky/entry/syscalls/Kbuild
new file mode 100644
index 000000000000..11707c481a24
--- /dev/null
+++ b/tools/perf/arch/csky/entry/syscalls/Kbuild
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_32.h
diff --git a/tools/perf/arch/csky/entry/syscalls/Makefile.syscalls b/tools/perf/arch/csky/entry/syscalls/Makefile.syscalls
new file mode 100644
index 000000000000..ea2dd10d0571
--- /dev/null
+++ b/tools/perf/arch/csky/entry/syscalls/Makefile.syscalls
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_32 += csky time32 stat64 rlimit
diff --git a/tools/perf/arch/csky/include/syscall_table.h b/tools/perf/arch/csky/include/syscall_table.h
new file mode 100644
index 000000000000..4c942821662d
--- /dev/null
+++ b/tools/perf/arch/csky/include/syscall_table.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/syscalls_32.h>

-- 
2.34.1


