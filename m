Return-Path: <bpf+bounces-36778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB6294D360
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 17:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAC7E1F22089
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA7F198837;
	Fri,  9 Aug 2024 15:24:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113011DFE1;
	Fri,  9 Aug 2024 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217063; cv=none; b=ChGCcVRKDSOwhUOLqpVBj9+nVXRnomxXC+RiYHnuYQD74i5Z+dBXkUii8SptFt3luIr96USovjj60zWMJ2Nrwrw4gQcu9l2iHc7t81hwT6yA39rcEiDJgmhXaXI4Tb+Z+f0eBHmpXsAYDcVyZQRwLTSH5Mxfd2QHAsO9iBF060Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217063; c=relaxed/simple;
	bh=+wtquJAHNEvMNhnx7GTRaejycNUfyag/XLdCrd7poF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BUZC84cK98te4MKv4G044RA+OBxtRYRYH4anE36c7BX0DX+D6yJp9OqA4xa42lCgIVPcDNORaEc5mCVJ95/PQB2N0QZkl8oe8296ZKWL5Z2x+p7R8oDEEbeMYBDXprZFEfdnD8ZMUKCJCfxP6GbWoV6yFi2P/3jjjJb2uEXrKFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>,
	Andrew Pinski <quic_apinski@quicinc.com>,
	=?UTF-8?q?Kacper=20S=C5=82omi=C5=84ski?= <kacper.slominski72@gmail.com>,
	=?UTF-8?q?Arsen=20Arsenovi=C4=87?= <arsen@gentoo.org>,
	Sam James <sam@gentoo.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] libbpf: workaround -Wmaybe-uninitialized false positive
Date: Fri,  9 Aug 2024 16:24:04 +0100
Message-ID: <3ebbe7a4e93a5ddc3a26e2e11d329801d7c8de6b.1723217044.git.sam@gentoo.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In `elf_close`, we get this with GCC 15 -O3 (at least):
```
In function ‘elf_close’,
    inlined from ‘elf_close’ at elf.c:53:6,
    inlined from ‘elf_find_func_offset_from_file’ at elf.c:384:2:
elf.c:57:9: warning: ‘elf_fd.elf’ may be used uninitialized [-Wmaybe-uninitialized]
   57 |         elf_end(elf_fd->elf);
      |         ^~~~~~~~~~~~~~~~~~~~
elf.c: In function ‘elf_find_func_offset_from_file’:
elf.c:377:23: note: ‘elf_fd.elf’ was declared here
  377 |         struct elf_fd elf_fd;
      |                       ^~~~~~
In function ‘elf_close’,
    inlined from ‘elf_close’ at elf.c:53:6,
    inlined from ‘elf_find_func_offset_from_file’ at elf.c:384:2:
elf.c:58:9: warning: ‘elf_fd.fd’ may be used uninitialized [-Wmaybe-uninitialized]
   58 |         close(elf_fd->fd);
      |         ^~~~~~~~~~~~~~~~~
elf.c: In function ‘elf_find_func_offset_from_file’:
elf.c:377:23: note: ‘elf_fd.fd’ was declared here
  377 |         struct elf_fd elf_fd;
      |                       ^~~~~~
```

In reality, our use is fine, it's just that GCC doesn't model errno
here (see linked GCC bug). Suppress -Wmaybe-uninitialized accordingly.

Link: https://gcc.gnu.org/PR114952
Signed-off-by: Sam James <sam@gentoo.org>
---
 tools/lib/bpf/elf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
index c92e02394159e..ee226bb8e1af0 100644
--- a/tools/lib/bpf/elf.c
+++ b/tools/lib/bpf/elf.c
@@ -369,6 +369,9 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
 	return ret;
 }
 
+#pragma GCC diagnostic push
+/* https://gcc.gnu.org/PR114952 */
+#pragma GCC diagnostic ignored "-Wmaybe-uninitialized"
 /* Find offset of function name in ELF object specified by path. "name" matches
  * symbol name or name@@LIB for library functions.
  */
@@ -384,6 +387,7 @@ long elf_find_func_offset_from_file(const char *binary_path, const char *name)
 	elf_close(&elf_fd);
 	return ret;
 }
+#pragma GCC diagnostic pop
 
 struct symbol {
 	const char *name;
-- 
2.45.2


