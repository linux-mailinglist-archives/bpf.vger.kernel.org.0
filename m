Return-Path: <bpf+bounces-47211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F342D9F616D
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 10:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B34947A01ED
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 09:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C5419C561;
	Wed, 18 Dec 2024 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YuHBymNz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA6E19AD8B
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734513877; cv=none; b=tVbDM33e0/kt4S6w34j1N+Kp5RXXH4FeTLZhhnSeH67FnoOkjLc8XbjBeziYSkpcEeYwzQwiOQpZF9tZZRRNgZ67zyMWmXZB068UKx7QtXEA+Y8jk7Z42k1Xxba1yYMhpaklEe132892RqYhxpUOllR5xwqCZDNAIytUrsXxlCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734513877; c=relaxed/simple;
	bh=aj6KhD87JndqJTmCbrJmfbqawzLsCSF87gVbexImUU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VB6pToysAMi6ZuwFO9d5Fgr/FTfoCOFMC13oS6Mc8lTFdO1G3cuxrmU+VVoJbYQ9S+N4Wn+DunJV3/YtjaxWtLEuDvIRn0IQc5WhWRD1W5WZfRCUpzfYzqMwHyxf3JiBoqTPjC5zAR+VMtIUIAHVGQf8cJ1bVZ74XCnmjy1OKU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YuHBymNz; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ef748105deso4499981a91.1
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 01:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734513875; x=1735118675; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uc6AkHxSAkZ2nW0ejwY9TuAU4WyUl5DsEUDPCF/WMmI=;
        b=YuHBymNzRDeFZjOcAvAx/b2n6NphwdS5dDS2Z+/abgIXeOPpI5BZJCIa2kNz4hwSJc
         hs9KbHBIFwFZSDIficRCBIiVHshD7hXFYJksKcppum4oXjP0j9xAWNxvDRMgKYRMmfsv
         zABBh/SkgJRUPpL0bhbWg0PGTUU5eFNeIdzz5e4RI9sm17H6NR0XSWuDSYAVO2QyhNwp
         2uAJBnzDkzAEdQogCwyd7j+MzDSMmRKZPYE7Y72XCLLkqtNYekGs90CV5uV50d/ZMXI7
         xkfnktydZ/CPZX/w1y1oFMSHYvsTcw1Cmcdtji/CkJOMrKu4mpXQDtEK2DqldYz/azes
         tBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734513875; x=1735118675;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uc6AkHxSAkZ2nW0ejwY9TuAU4WyUl5DsEUDPCF/WMmI=;
        b=Iz1/lrtAWfBZmLeIAC+dIaR3/5Y5Djqe5oXS2SCMki1bmov5aVLDGINxr+4M2WwCrn
         zhze2NyONi+QWTIHo4OHh63JYNrT4NHimBVMwGDX//nMiofx61Aqpn+6ecKSy1+3Eu1s
         Fh37gKx443gnSCPmrLuMGdSl2rDUyEQRxeEbDJrRu5xBJhT3pLVCD5wp1mGp4x5KIrli
         s/4CLApFMQUeFAgbiMF+EEMt0fHrMovyLA6AaaXxWZnU9ep74gPlXLddC4rpdwHvPqg0
         sL0GAbhS4RZ8/x5Xj4l8k/Iyzn3NW8JrqUzKuEwpBj6tTqEwCsp41uSyaynHy4QAwKA6
         os6w==
X-Forwarded-Encrypted: i=1; AJvYcCXUmQO2PVnsrJnCqGNX413iEbt0leRc0TMi1RhBHr/HYPcfmkwJFwa9Xp7uNxwVJnsRbh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR+XtMEIMYlv0XGZaxjEcGOwrJdnJW5wkWO7HqoSz1nfnk7ECV
	BN/IVsDSjrw7guuEevrDwhQwJtBP8cEuU38EBRePTaiAmSjujSUNzyermDKPbSg=
X-Gm-Gg: ASbGnct5WuNMagvY2RDN6QeMKY5CInhsyNeQLCW/hAVp1Z0FZeI5Cn8ifmTz8WYRFlI
	0Ug88aGQtAIIV67wrUM5KXzir8ZkSqZXQ3nGak2Ah7JPIJJQwBs3mtyJx4gOFseXssTNRvdXLt2
	fZdzSZ+UwOz2atmmpnwx6o7qvZUBmCWIW8DI+7Dq6v02qgQh0ahXgn6pNj5ihZCc7WEtPb+h59t
	7asNYrlYi/I2qokmuE6YMVPyHG/huJS+rHh89qw1XZSjDjPQS5V7VL/A8HUBZ/4I8PCXhct
X-Google-Smtp-Source: AGHT+IEYfeptiNvPvwhEIFQk4qrtcNpSuwqJU4nqArf0lp9ixOHLB81Va8vS+TepDJm9AqqgSFUpaw==
X-Received: by 2002:a17:90a:1208:b0:2ee:c457:bf83 with SMTP id 98e67ed59e1d1-2f2e9303915mr2983950a91.19.1734513875015;
        Wed, 18 Dec 2024 01:24:35 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e64f90sm72119995ad.241.2024.12.18.01.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 01:24:34 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 18 Dec 2024 01:24:01 -0800
Subject: [PATCH v4 03/16] perf tools: csky: Support generic syscall headers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241218-perf_syscalltbl-v4-3-bc8caef2ca8e@rivosinc.com>
References: <20241218-perf_syscalltbl-v4-0-bc8caef2ca8e@rivosinc.com>
In-Reply-To: <20241218-perf_syscalltbl-v4-0-bc8caef2ca8e@rivosinc.com>
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
 Arnd Bergmann <arnd@arndb.de>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2180; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=aj6KhD87JndqJTmCbrJmfbqawzLsCSF87gVbexImUU4=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3rSlCO7U2T0SlQbfRQzLpk9SV20rivlS+UJhkt/FBjd2
 NQFbOI7SlkYxDgYZMUUWXiuNTC33tEvOypaNgFmDisTyBAGLk4BmAjPMoa/oqfu9xrJb/Deu+KZ
 TKg26/IfpVo/Nm2dM9HFdaPp1bqbDowMaz61s3dXtR1+f+Vd/FWRSaezHH99rY7xvB9xsGqTQ8w
 udgA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

csky uses the generic syscall table, use that in perf instead of
requiring libaudit.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.perf                              | 2 +-
 tools/perf/arch/csky/entry/syscalls/Kbuild            | 2 ++
 tools/perf/arch/csky/entry/syscalls/Makefile.syscalls | 3 +++
 tools/perf/arch/csky/include/syscall_table.h          | 2 ++
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f717e4628d9e4632f53fed16524a659a3e4feea5..b20daf3769771a7c23cc0f7dd46f562510bc3199 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,7 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-generic_syscall_table_archs := riscv arc
+generic_syscall_table_archs := riscv arc csky
 ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
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


