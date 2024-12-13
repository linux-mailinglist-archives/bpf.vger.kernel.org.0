Return-Path: <bpf+bounces-46775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 499AF9F00DF
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 01:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB72285E40
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176C728DA1;
	Fri, 13 Dec 2024 00:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BsxPjUM2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7ED1426C
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 00:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734049996; cv=none; b=s0iseTvP+mx1cvAyimcSMKWPOPqnP+XF0kHZZ4WVHW7EHO6p5xtU6iNXcYa5/7yYgk5/KrlYz1uZ9q+IxM54x8DcwiLjlsjqb+dOqi5Nbu2bExZ9Y3bVtCx/O2eh1IfCTtduLwucF5TNkFsHox2FtsIOlHFHbhE2YZBycs2rVWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734049996; c=relaxed/simple;
	bh=IQtfuUT0+eGZ51OwwywtWIPS5QSw2EsnD9K86OE9bhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YtoWWvS1Wb4UT0J6Ofs5sGimwwgGWSpcsmyQeeoQxxh885BgH8wP8JUaPF2oTEubLrrl7kco3C+Pqo9r8HjTMAzIR0EyDT1Alz/fGbwlN647Lt3JDkW8nrc//aFXLirBahZljvIEdKY+1/BIzWQplci3S1W8+LUE2WFLSFLnOlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BsxPjUM2; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7feb6871730so862672a12.2
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 16:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734049993; x=1734654793; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/t4tAnrXs8dbqT90IARLfldAs+rJPVA/lhEFBD44es=;
        b=BsxPjUM2rRrUQUQ0leQAsyEBnudUfLUiSscfanhA3lw9tM15qIZ1pTrWZ8V58Js6JW
         4x0oLX4nCVVG5srsUvkF3yG604MecM6lLevn4wUtvarZElKXk2TtQyZkIc56iAVqEAX0
         2tUpyx6EmGid4CQqJHpvpysbvMn+QYi5L5puj/1cvp6875vA0FlAmoMC/35OJFKHOCSl
         gU6CnoNPWTGDh311cgOj3PdY7AHoqo+iVIT82NKIMJn2nFh7FdLrGUoTD30fNcmaxoZ/
         p3YeFy68G7mOU8efe++wUALhLvuJz7BtvpFp6jT6H5En91tm4R8ST4TA4tnE7LjZb+E5
         y4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734049993; x=1734654793;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/t4tAnrXs8dbqT90IARLfldAs+rJPVA/lhEFBD44es=;
        b=e28qs/1gdQz9FgiXSyMgmoHPViVARlAe/Pyf9Dr81bcoqtSDBC/faDNOalmrUQ80rS
         olsoYI+lcywbDtjsYiNhRZ/4q9QGc3H1Ga6YKTzMohKi4TcsHOC8ndKosm4G9oB0W+o8
         FnkudcOHC5LSZw3LlOXJU8dZx4IdPQQhDYiXD10LmlY2VgQFd6TsxQZMtPn9tWQluL0X
         0hRFa9BEK3vf8A0N1LE9zbq+5Jzjp32A4qHogfujOiKi/YiEDnOLEAUncmaHxbWNZBhs
         jqZAXZVTNhuadGFB0TZ0i1r7gD9j1Z47I8SZbmoSi4eV6XuBiypkeSpNnoX2z2oE3PLf
         AJrg==
X-Forwarded-Encrypted: i=1; AJvYcCUFogSsWc3Lj1nDyZ2iGlIEre4TcwQAO0Ksn7tUpyRgUdsMTs+y+RVSYrHWie0bTGEl/Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPDmQBq1HBh0cOARNszpGzQRW3WbQY2ilkjGMoNOj9/DBbps9B
	zVVwTkIM5wgaOzFVCU6y5vRPiDgwys8AIq5wWQkll/HanvHd6obBjqCqMy+saWiTr77W378CwXU
	e
X-Gm-Gg: ASbGnct0XTC3WPODIKhVDbWHuJ5D2USUT9K2HX/VBb4FuA97PgKjS0S9HohyDwSl1ka
	vmQxAGa/VIaTodPKPfKT12FK6FNkry7+MpYmbPaHxC30QbhXKqljXlXMb/8nU90NIIkLcKrKQRO
	992zq3DgJBTbz9Gm3xQ2qlNWylQ+BU+KpfFyD3LNQpOSGoAVlgC2eVvPxOuoxKKjiEkO2nkHcb3
	unbrknr/PFfFB/AGW/AJCiY0szdC9ezKepFsh3Mx0H3APJ+3XIS1qu6GVR5rGkz91/eNKA2
X-Google-Smtp-Source: AGHT+IEd23eNeza65b/mFf2Ef1epXFx4Y/eggrgjqxpS7nxWsumxa7/TVE+fCJ8K+wC5TazJMd2/IA==
X-Received: by 2002:a17:90b:54c7:b0:2ee:c9b6:c26a with SMTP id 98e67ed59e1d1-2f28fb68ef6mr1014242a91.11.1734049993490;
        Thu, 12 Dec 2024 16:33:13 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142e0ce50sm1934462a91.39.2024.12.12.16.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 16:33:12 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 12 Dec 2024 16:32:52 -0800
Subject: [PATCH v2 02/16] perf tools: arc: Support generic syscall headers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-perf_syscalltbl-v2-2-f8ca984ffe40@rivosinc.com>
References: <20241212-perf_syscalltbl-v2-0-f8ca984ffe40@rivosinc.com>
In-Reply-To: <20241212-perf_syscalltbl-v2-0-f8ca984ffe40@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
 Leo Yan <leo.yan@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2767; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=IQtfuUT0+eGZ51OwwywtWIPS5QSw2EsnD9K86OE9bhw=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3p0w97f96cdWBjf3P5j8qf/XPecPv058Sizvjb1nfH/N
 DZe06qojlIWBjEOBlkxRRaeaw3MrXf0y46Klk2AmcPKBDKEgYtTACby9R8jw6mSmU2bFY+3Lfy/
 XOjNdrf3s3MDnGu57qrvuLzXbt28jB+MDKsnS+vzMHHtjLyR+cPn56XF7vwGb3eaLjRf//zjQ7t
 NKlwA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Arc uses the generic syscall table, use that in perf instead of
requiring libaudit.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.config                           | 2 +-
 tools/perf/Makefile.perf                             | 2 +-
 tools/perf/arch/arc/entry/syscalls/Kbuild            | 2 ++
 tools/perf/arch/arc/entry/syscalls/Makefile.syscalls | 3 +++
 tools/perf/arch/arc/include/syscall_table.h          | 2 ++
 5 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a72f25162714f0117a88d94474da336814d4f030..3959a9c9972999f6d1bb85e8c1d7dc5dce92fd09 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -36,7 +36,7 @@ ifneq ($(NO_SYSCALL_TABLE),1)
   endif
 
   # architectures that use the generic syscall table scripts
-  ifeq ($(SRCARCH),riscv)
+  ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc))
     NO_SYSCALL_TABLE := 0
     CFLAGS += -DGENERIC_SYSCALL_TABLE
     CFLAGS += -I$(OUTPUT)/tools/perf/arch/$(SRCARCH)/include/generated
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f5278ed9f778f928436693a14e016c5c3c5171c1..3b463b42b0e3982e74056e672b2ee6adad5a3f0e 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,7 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-ifeq ($(SRCARCH),riscv)
+ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc))
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
 include Makefile.config
diff --git a/tools/perf/arch/arc/entry/syscalls/Kbuild b/tools/perf/arch/arc/entry/syscalls/Kbuild
new file mode 100644
index 0000000000000000000000000000000000000000..11707c481a24ecf4e220e51eb1aca890fe929a13
--- /dev/null
+++ b/tools/perf/arch/arc/entry/syscalls/Kbuild
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_32.h
diff --git a/tools/perf/arch/arc/entry/syscalls/Makefile.syscalls b/tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
new file mode 100644
index 0000000000000000000000000000000000000000..391d30ab7a831b72d2ed3f2e7966fdbf558a9ed7
--- /dev/null
+++ b/tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_32 += arc time32 renameat stat64 rlimit
diff --git a/tools/perf/arch/arc/include/syscall_table.h b/tools/perf/arch/arc/include/syscall_table.h
new file mode 100644
index 0000000000000000000000000000000000000000..4c942821662d95216765b176a84d5fc7974e1064
--- /dev/null
+++ b/tools/perf/arch/arc/include/syscall_table.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/syscalls_32.h>

-- 
2.34.1


