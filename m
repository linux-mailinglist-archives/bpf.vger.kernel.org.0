Return-Path: <bpf+bounces-20971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F84845E62
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 18:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324FC1C245E7
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 17:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5F75B035;
	Thu,  1 Feb 2024 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEMHIeJM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE565B036
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808072; cv=none; b=T5ITV6HuIiYwrZBuTc2A6k3KvtX01G1HtBVmWyCIExMVaUgTzEXYxpSe/SC9EtNDHauMOGOKoQDv3ghTXODIsBhged1g00LnZMVlHnwRSc3R1sexnlqbfuOfOvDfNXnSjVcLfDiQ+smc5L356RpSECBk1ZLXKr5XuFYcRTCqYHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808072; c=relaxed/simple;
	bh=Z8jg+TiWfdlbJURhufvnuM+daxABoZjXXHNRN58Q0Hc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GDHDyJ4c6aF0+NBj0QNXbbl5t0ISVZ/GXL3xUXmh6/9spmw+SvrLbF7Ig/O1fFSJhgD12E1Vx+8Zke2h/wsb1AA32g1qEOXlTo/QQ8ZSi254EA4bIOv6QPIMQaPurmqfSKNGkHtZaJH2oDS1nY3Qkcgo54nMRjA/7X6cJCRH3M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEMHIeJM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F54C433C7;
	Thu,  1 Feb 2024 17:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706808072;
	bh=Z8jg+TiWfdlbJURhufvnuM+daxABoZjXXHNRN58Q0Hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HEMHIeJMyJlcGpusOHljwCvuM65qSBKKfufH8ZDUO6s2PjrkNwVnKToDrKzRRdQh8
	 FQDrzvBbJmHM11GXm+9+k4KWaueHqtsqdhkAUAL9k1r7Q/LpIxuRdTJnjZ4ZlVJe0B
	 9YaajRqZhn/Uxjl2SF5BwiwzRLBK2e9w+4xvViBy8qgpZFjZ/RwJG/nRWmEmGVRQWv
	 RTRwFByG6f1oMBNGgl68pRYz7uwSof7t9Nj1NhxJGUuH1tcssFoZSbPUqNF+DTGkEy
	 CgtWYO7l1apchgUben5WVI/lXob0NsOJ3ETKMeyVxH/vcDzJNiP23i0J+KwYFRXI4l
	 f2xkjky6pBmEg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 1/5] libbpf: call memfd_create() syscall directly
Date: Thu,  1 Feb 2024 09:20:23 -0800
Message-Id: <20240201172027.604869-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201172027.604869-1-andrii@kernel.org>
References: <20240201172027.604869-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some versions of Android do not implement memfd_create() wrapper in
their libc implementation, leading to build failures ([0]). On the other
hand, memfd_create() is available as a syscall on quite old kernels
(3.17+, while bpf() syscall itself is available since 3.18+), so it is
ok to assume that syscall availability and call into it with syscall()
helper to avoid Android-specific workarounds.

Validated in libbpf-bootstrap's CI ([1]).

  [0] https://github.com/libbpf/libbpf-bootstrap/actions/runs/7701003207/job/20986080319#step:5:83
  [1] https://github.com/libbpf/libbpf-bootstrap/actions/runs/7715988887/job/21031767212?pr=253

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f6953d7faff1..6932f2c4ddfd 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1525,11 +1525,20 @@ static Elf64_Sym *find_elf_var_sym(const struct bpf_object *obj, const char *nam
 	return ERR_PTR(-ENOENT);
 }
 
+/* Some versions of Android don't provide memfd_create() in their libc
+ * implementation, so avoid complications and just go straight to Linux
+ * syscall.
+ */
+static int sys_memfd_create(const char *name, unsigned flags)
+{
+	return syscall(__NR_memfd_create, name, flags);
+}
+
 static int create_placeholder_fd(void)
 {
 	int fd;
 
-	fd = ensure_good_fd(memfd_create("libbpf-placeholder-fd", MFD_CLOEXEC));
+	fd = ensure_good_fd(sys_memfd_create("libbpf-placeholder-fd", MFD_CLOEXEC));
 	if (fd < 0)
 		return -errno;
 	return fd;
-- 
2.34.1


