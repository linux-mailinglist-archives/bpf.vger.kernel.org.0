Return-Path: <bpf+bounces-19908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE7083300C
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 22:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5BE1F23AAB
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 21:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E3857895;
	Fri, 19 Jan 2024 21:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2snUpXm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F410057887
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705698124; cv=none; b=CWSyA4XkCBVJjOFcA09BsbMRAW9WqvYTMnjaannO2Hvhon7a1s8QRdB14nQZk3qJ4LIKKsJghsug5Nm3KfvImCi6lHzO84mm21zIqxYyq6/knq4nnevedbT27uJURH65mejnXVaIEH0S64l2kQB8p3bAMb2WvcTRZFN4hJ4J824=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705698124; c=relaxed/simple;
	bh=YaSgeHWic2cEBaE1sYZmD6/8kJMwrqdB1k0swHHwHOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZTUdA1shTBaRs6i3UCUPN25GVkoHhZLA5LG8RsezzJHHuLkM7y2sv4esHSbxf6OUUL780mg5G7s+xMXbTq9LBTJzNbqFnn/uc6UmBY2FjAWHyt7I1dBqIddBGaD+hR/VqnL3GHNBTfediP3d2tYsBKO2iZDHnD1qsJcwmYqSDfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2snUpXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E647C433C7;
	Fri, 19 Jan 2024 21:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705698123;
	bh=YaSgeHWic2cEBaE1sYZmD6/8kJMwrqdB1k0swHHwHOo=;
	h=From:To:Cc:Subject:Date:From;
	b=c2snUpXme5ldTLbI/7yAUDkeOZIUwjH44ZJTOruSAl+RF8Af10TdvwACqWYSSqBKo
	 kwSdUq97mktHVPJWoTWhjb/CVAwNj7kEGLT7pQFK1ZyffZx5Mj1GRMY6QfTuSlhAnn
	 y1fg+5+fudI+XjYJBQx7FQYPv85Y/56hIfb76J3bGJugtDbHnFEaOWP9ILrqM1n1Lw
	 E4gJpAMMh6/NbLCBGatnJGEVOu4xtX5rsUzFjIRhXoXgepSDRw7NeBQhG9XojIrdPw
	 IljN7tBvsQuy8f9X8aqPj+CnruKMAKW9CnfBHy7nqrOi1uPqnZm0o0e1R1zAvXgIVC
	 htydAI/40bPqg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] libbpf: call dup2() syscall directly
Date: Fri, 19 Jan 2024 13:02:01 -0800
Message-Id: <20240119210201.1295511-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We've ran into issues with using dup2() API in production setting, where
libbpf is linked into large production environment and ends up calling
uninteded custom implementations of dup2(). These custom implementations
don't provide atomic FD replacement guarantees of dup2() syscall,
leading to subtle and hard to debug issues.

To prevent this in the future and guarantee that no libc implementation
will do their own custom non-atomic dup2() implementation, call dup2()
syscall directly with syscall(SYS_dup2).

Note that some architectures don't seem to provide dup2 and have dup3
instead. Try to detect and pick best syscall.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf_internal.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 27e4e320e1a6..58c547d473e0 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <fcntl.h>
 #include <unistd.h>
+#include <sys/syscall.h>
 #include <libelf.h>
 #include "relo_core.h"
 
@@ -555,6 +556,15 @@ static inline int ensure_good_fd(int fd)
 	return fd;
 }
 
+static inline int sys_dup2(int oldfd, int newfd)
+{
+#ifdef __NR_dup2
+	return syscall(__NR_dup2, oldfd, newfd);
+#else
+	return syscall(__NR_dup3, oldfd, newfd, 0);
+#endif
+}
+
 /* Point *fixed_fd* to the same file that *tmp_fd* points to.
  * Regardless of success, *tmp_fd* is closed.
  * Whatever *fixed_fd* pointed to is closed silently.
@@ -563,7 +573,7 @@ static inline int reuse_fd(int fixed_fd, int tmp_fd)
 {
 	int err;
 
-	err = dup2(tmp_fd, fixed_fd);
+	err = sys_dup2(tmp_fd, fixed_fd);
 	err = err < 0 ? -errno : 0;
 	close(tmp_fd); /* clean up temporary FD */
 	return err;
-- 
2.34.1


