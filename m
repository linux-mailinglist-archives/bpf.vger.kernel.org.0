Return-Path: <bpf+bounces-46776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 027029F00E7
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 01:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3C6E188D7C2
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6363941AAC;
	Fri, 13 Dec 2024 00:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PIh5v+ns"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E09286A1
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 00:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734049998; cv=none; b=ak8H3MKISyZhltaKMiD3FekOuxHvta0bGexm0v1WJLjfR2S/GIz4sjWtCEuo+eO9IMjprQTuid5PBC/PjpkNWZebxU2WOU7tdusJ82LqD5T3qmNUnJApbsMigyTtvPe00aFJf4fp3/wNhvoe5A0UGQoJvKCIgVm7lqlMgQ+1fow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734049998; c=relaxed/simple;
	bh=s+YOevH5qJpXQeBMeav5HfEhx0qMLUBz1Ow99oWav84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pc0Q7z+vq2E5K9heh+aBPQ+SQPeQGoom1IJk0TVi2cBx1ssa4vfgqNK8KvJXs5AnN8N6Z4GCzK79tvnhDha0KGmR3aijMkck/Jbv058lqJlnD9JlqK+0nTOfuUMORUulf8g1lNqSsntI8iMjU/jRuyGLIj2dIogWOyMUMRgK8IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=PIh5v+ns; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef760a1001so1026180a91.0
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 16:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734049996; x=1734654796; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rp8FO0OCSZ/qUCDzOjOMxVbbH2AtMi4o4J4InXgU+q8=;
        b=PIh5v+ns487yQoJNSdf/wOV2TVRwB411RwbGrNHYpD/kfKexe9AQnLOtu7aiKllV4+
         mwxJULIeZe2QY+UjdwyVaMr9sykjUQ6DAD+wOC8OmD0oNYMs5D3lIivxg1NpVAhuP7xT
         /04waVeytg+qoXgZyBQoxO88e6B9p6uEJRD4lC3UzwKudwyw8pyAcDGcFZ6A+9JmHno8
         5efIJqPYJt1LFvJ2lENandijsgDpkbpt4vyYX6fbkUXhRZUUzdEGuePG40vlzYz01uSp
         JWDyGfElWnhO6PjJKpFzcOHqS0uf/w/6NcVAVTTgh4suOLJRWqp+d781g/QSvbH1gDjr
         82IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734049996; x=1734654796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rp8FO0OCSZ/qUCDzOjOMxVbbH2AtMi4o4J4InXgU+q8=;
        b=UFymioW6pB3NnzdtGzw0F+BbE4NHIdaK9OdHG1v8sYLhoIxJjU/Pyahqrf0pPeOl7z
         Nuwg03k0waq9ut4LOhK5zEnNoedUgHjoBKLIMZokLEQVFFm2Nv98VHm7K4BYP58uHxcL
         yybQ/IlAZn69HrMnzyLHL+9HSZ3TtLWdLb7DSCqDQZs+WN356VeSoGwx3uJ1NGwFiId6
         MdYO614WqQDjQXQehyC/DmQvGPbvHIaT76UsbFDW8pfVon2sWx6M89UajQKJbhAY4LLN
         py8wd+LYbVhzeX0xI/uRRAGnDZYUyz30zvddMFx4QtzSM2HU1TICfNVeRTbn9U3+7Z40
         5cPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/zCfkS6QZPu1desZxUkXQ6l4wb6rHNmH2c2kDJV0Kd27HDPV/s5opkF7Jq8L6EZW/kn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp1Fk3gFKHucHvNPqGtuZOQijUnx02uMUCgAQi7xnyH6hjLAKX
	AQLWdE+TwbF9jhCXEI6lznztjt/SjFPaZXakuULRfBaf57pG0kovEHagO6quWP++qtbuJW+ExrI
	e
X-Gm-Gg: ASbGncvzq+vPRbZt6f55+iNQF9ifbJ3y17KooHFP3+ltvyu4eibXu/XJcrcXjPLtllP
	RPzzce5YxCar6OQwd60clf/QHWFWC74f44HWdS/UsGtJvZB0ILf5TkP5WhkE+O5prGS+PLtIMlP
	rHZBNiB7YdRT8VfaPneqvpaMq0hoUWlWyRL7SaHprbxntpf/HALfC5lSL94N+sYBJ1IJsAQB2iA
	f9O2MxRTZN1jkK3RculB5CWNHvndYhUQXPVnodf3GdVRUOPCrIIh0R+WxM3xu3AGu5VkJVC
X-Google-Smtp-Source: AGHT+IG4gRsZLG4Vx2a1/zZIKlGxZhkfrJbfitUgDX8Uz2b6ouZp8VypnAWgqiCZsMeD1Is8X9jPmw==
X-Received: by 2002:a17:90b:4a04:b0:2ea:3d2e:a0d7 with SMTP id 98e67ed59e1d1-2f28fb67655mr1250703a91.15.1734049995974;
        Thu, 12 Dec 2024 16:33:15 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142e0ce50sm1934462a91.39.2024.12.12.16.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 16:33:15 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 12 Dec 2024 16:32:53 -0800
Subject: [PATCH v2 03/16] perf tools: csky: Support generic syscall headers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-perf_syscalltbl-v2-3-f8ca984ffe40@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2834; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=s+YOevH5qJpXQeBMeav5HfEhx0qMLUBz1Ow99oWav84=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3p0w967bHUGluV/JWs/VJgacMaueH7pVN/r1WWOmRVbW
 yJiw191lLIwiHEwyIopsvBca2BuvaNfdlS0bALMHFYmkCEMXJwCMBHFOkaG90lu90Vq035fnTjJ
 XfEzd/a/jKDIJxaK19sYPf9kMSjdYvifO7dMZILE251LdOYfVm4MklfMfhnaeM7s/SK92aqF0zK
 5AQ==
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
index 3959a9c9972999f6d1bb85e8c1d7dc5dce92fd09..6fcaa051a47621b818b4c9d967eeed050056e400 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -36,7 +36,7 @@ ifneq ($(NO_SYSCALL_TABLE),1)
   endif
 
   # architectures that use the generic syscall table scripts
-  ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc))
+  ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky))
     NO_SYSCALL_TABLE := 0
     CFLAGS += -DGENERIC_SYSCALL_TABLE
     CFLAGS += -I$(OUTPUT)/tools/perf/arch/$(SRCARCH)/include/generated
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 3b463b42b0e3982e74056e672b2ee6adad5a3f0e..407f589046e032c4103c3b6b82c9d044560c5bac 100644
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
index 0000000000000000000000000000000000000000..11707c481a24ecf4e220e51eb1aca890fe929a13
--- /dev/null
+++ b/tools/perf/arch/csky/entry/syscalls/Kbuild
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_32.h
diff --git a/tools/perf/arch/csky/entry/syscalls/Makefile.syscalls b/tools/perf/arch/csky/entry/syscalls/Makefile.syscalls
new file mode 100644
index 0000000000000000000000000000000000000000..ea2dd10d0571df464574a9c0232ada0ac1f79a3f
--- /dev/null
+++ b/tools/perf/arch/csky/entry/syscalls/Makefile.syscalls
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_32 += csky time32 stat64 rlimit
diff --git a/tools/perf/arch/csky/include/syscall_table.h b/tools/perf/arch/csky/include/syscall_table.h
new file mode 100644
index 0000000000000000000000000000000000000000..4c942821662d95216765b176a84d5fc7974e1064
--- /dev/null
+++ b/tools/perf/arch/csky/include/syscall_table.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/syscalls_32.h>

-- 
2.34.1


