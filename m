Return-Path: <bpf+bounces-40869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C83BC98F87E
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 23:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43060B2252C
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 21:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E0A1CCEF3;
	Thu,  3 Oct 2024 21:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxL29i3O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1746A1CC88E
	for <bpf@vger.kernel.org>; Thu,  3 Oct 2024 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989508; cv=none; b=RhSPekM82Beh9DeDJ26N+gS/+L048YJu3KGW5iv/SMqd3Mn4INtbhnx+HXYsyDST6vU/UQc/nS0dRAkuUYfzsuswOsc7cOpC9Xc22yaFmGoYx8uT/qESk3lZFdKohRVxS/yCqblJkOxdxEJ6zLtLNbjnHMtWQ3pA3+kaUErrVm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989508; c=relaxed/simple;
	bh=IXkc7DluNW8Lp+EUJcSQCzpk/xvJ7ySmyRURNnrKZxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qBxZm+55OsYouO7MgzADDJMCdWHPx8yFlYAU24eD4xkv47fDPo5Uh21gjHvNQTVdfpaHrWuHATOp5C047IgBFKC7LfRNX7ic3EJAX3GDep4j3OogwZtQpPXl9bdSzMuwyZakCkOW3dLIlExHjBq0cL7ptbB8VBQoJ189NdT/G2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxL29i3O; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20bcae5e482so13589955ad.0
        for <bpf@vger.kernel.org>; Thu, 03 Oct 2024 14:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727989506; x=1728594306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wdYfT1q6808s0uDMzQmAMnNLgoEmkxawNyBxUkdvfY8=;
        b=jxL29i3OZPMm9/v/py/UibbOBIWdND1/FDi9t6IYMUEsfkjfQ8PdMiugXSyz3PIR9/
         Djrr0zxF4ES+hfrMWq11pDADznZUUQwg/rZlYKFhc81ZVz8xJE8TbJ4AAM4XF3C9kHm1
         PunjMB/zubo2stApUgowmk2wJE2TsK2AYWte1P+Dqx5MaMK+JpVlpVQMwFDBkq2diIp2
         HuCdArdguBemLIcN3wysNp1UCcDc3UlfgAqJSuSl22xPtyZMMIlPzqGMqFAJOdC9Q6fg
         pIwFVQGRig5SEKXfMF353wnG7exU/HFTGDh+yOolsOPW+t7XMcnC7OmA2BC0eH9PLOab
         GMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727989506; x=1728594306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdYfT1q6808s0uDMzQmAMnNLgoEmkxawNyBxUkdvfY8=;
        b=hyDHan9X5ea3ayY8GHYhxeFnmeMQWucAP3iG4xJmk/BZ/meCZrcrNcbVXCnOv4sQBu
         chkivWZkKU5S1BsyKr1rVXS+vludYObvsFz6F+zIvyaPpXxee2iKpQYGGESCq75JAONE
         aCOZGEikUIy8AKHb9nFmhoeYrxpaCyY+8LQJGC8f3UWi0tBdAUQj0o3AbCxPaltKBBE2
         QlhHCsQIxUZWoW72OQ7uMXC7//JTzv4IlPK1xxfu9DlAAhraY7LU8YeZthxZuJzQJaqI
         YzZyR9mZmvbx15OXpc8QEzAckdlTm+qrF0jM2oWjq6vB6h9cDUzBU/BcV0amwm8mS3bp
         19Tg==
X-Gm-Message-State: AOJu0Yy5QiGrM+ZKChZxAtwDsMlg6a0KzONlg3NLVJZHUrbcGfYPAW0C
	QbXFaQJVJe8IWtbjECkqSyHPwjVm16ICPvWt257D/uvBdg7udW+hDGpdXQ==
X-Google-Smtp-Source: AGHT+IGe4N1HlYjmAmFDBW1sVo1ShfZsyvRdYOkij+rH623TmEEqwW2Xo/CExb2pk7o1LNstry+C3w==
X-Received: by 2002:a17:90b:378b:b0:2e0:89d5:9855 with SMTP id 98e67ed59e1d1-2e1e62a4f87mr530433a91.20.1727989505929;
        Thu, 03 Oct 2024 14:05:05 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f776157sm4285264a91.17.2024.10.03.14.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 14:05:05 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>
Subject: [PATCH bpf] selftests/bpf: fix backtrace printing for selftests crashes
Date: Thu,  3 Oct 2024 14:03:07 -0700
Message-ID: <20241003210307.3847907-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_progs uses glibc specific functions backtrace() and
backtrace_symbols_fd() to print backtrace in case of SIGSEGV.

Recent commit (see fixes) updated test_progs.c to define stub versions
of the same functions with attriubte "weak" in order to allow linking
test_progs against musl libc. Unfortunately this broke the backtrace
handling for glibc builds.

As it turns out, glibc defines backtrace() and backtrace_symbols_fd()
as weak:

  $ llvm-readelf --symbols /lib64/libc.so.6 \
     | grep -P '( backtrace_symbols_fd| backtrace)$'
  4910: 0000000000126b40   161 FUNC    WEAK   DEFAULT    16 backtrace
  6843: 0000000000126f90   852 FUNC    WEAK   DEFAULT    16 backtrace_symbols_fd

So does test_progs:

 $ llvm-readelf --symbols test_progs \
    | grep -P '( backtrace_symbols_fd| backtrace)$'
  2891: 00000000006ad190    15 FUNC    WEAK   DEFAULT    13 backtrace
 11215: 00000000006ad1a0    41 FUNC    WEAK   DEFAULT    13 backtrace_symbols_fd

In such situation dynamic linker is not obliged to favour glibc
implementation over the one defined in test_progs.

Compiling with the following simple modification to test_progs.c
demonstrates the issue:

  $ git diff
  ...
  \--- a/tools/testing/selftests/bpf/test_progs.c
  \+++ b/tools/testing/selftests/bpf/test_progs.c
  \@@ -1817,6 +1817,7 @@ int main(int argc, char **argv)
          if (err)
                  return err;

  +       *(int *)0xdeadbeef  = 42;
          err = cd_flavor_subdir(argv[0]);
          if (err)
                  return err;

  $ ./test_progs
  [0]: Caught signal #11!
  Stack trace:
  <backtrace not supported>
  Segmentation fault (core dumped)

Resolve this by hiding stub definitions behind __GLIBC__ macro check
instead of using "weak" attribute.

Fixes: c9a83e76b5a9 ("selftests/bpf: Fix compile if backtrace support missing in libc")

CC: Tony Ambardar <tony.ambardar@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/test_progs.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 7846f7f98908..005ff506b527 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -20,20 +20,23 @@
 
 #include "network_helpers.h"
 
+/* backtrace() and backtrace_symbols_fd() are glibc specific,
+ * use header file when glibc is available and provide stub
+ * implementations when another libc implementation is used.
+ */
 #ifdef __GLIBC__
 #include <execinfo.h> /* backtrace */
-#endif
-
-/* Default backtrace funcs if missing at link */
-__weak int backtrace(void **buffer, int size)
+#else
+int backtrace(void **buffer, int size)
 {
 	return 0;
 }
 
-__weak void backtrace_symbols_fd(void *const *buffer, int size, int fd)
+void backtrace_symbols_fd(void *const *buffer, int size, int fd)
 {
 	dprintf(fd, "<backtrace not supported>\n");
 }
+#endif /*__GLIBC__ */
 
 int env_verbosity = 0;
 
-- 
2.46.1


