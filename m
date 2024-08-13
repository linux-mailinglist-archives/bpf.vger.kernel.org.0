Return-Path: <bpf+bounces-37085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BE6950D64
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 21:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DCE3B2630A
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 19:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50841A3BD6;
	Tue, 13 Aug 2024 19:49:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C961C287;
	Tue, 13 Aug 2024 19:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723578597; cv=none; b=hb29Vxo3ihUD2J3Xneko1rPBCQ1VdILwlVSQfsLZzvinLfVi74X2efQIF35t7pZgk7+UBksx68EukksNgBQ8GXPNFix52UjuslkFIN2toD99DvqegC/Dp+pRQZpGj1oxKD/p+4x11H7ZxG8euWcbMSjf2yplF+xOshXlI4jWWIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723578597; c=relaxed/simple;
	bh=PLrFcNU7ckpOpLk686/xgxDVMbFxUHcGvJjGQOjsC2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=msZ6Q09j/3cy81DfL/pT4cQykR+NMpITnrQymWs842U0bXWcc1DBpdzlQrv5RbDxgFS4vX6GU9BaqunAvOjnuYQMx1aTaTUTRQ9Izz7YP3BanadDA2nsleKCMmeYavPX8whciYYwKAO/pztSSsMEnwKgO8vrsvOCp26Gn+hMaqM=
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
Subject: [PATCH v4] libbpf: workaround -Wmaybe-uninitialized false positive
Date: Tue, 13 Aug 2024 20:49:06 +0100
Message-ID: <14ec488a1cac02794c2fa2b83ae0cef1bce2cb36.1723578546.git.sam@gentoo.org>
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
here (see linked GCC bug). Suppress -Wmaybe-uninitialized accordingly
by initializing elf_fd.fd to -1 and elf_fd.elf to NULL.

I've done this in two other functions as well given it could easily
occur there too (same access/use pattern).

Link: https://gcc.gnu.org/PR114952
Signed-off-by: Sam James <sam@gentoo.org>
---
v4: Initialize elf and fd members in elf_open to avoid meddling with callers.

 tools/lib/bpf/elf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
index c92e02394159e..b5ab1cb13e5ea 100644
--- a/tools/lib/bpf/elf.c
+++ b/tools/lib/bpf/elf.c
@@ -28,6 +28,9 @@ int elf_open(const char *binary_path, struct elf_fd *elf_fd)
 	int fd, ret;
 	Elf *elf;
 
+	elf_fd->elf = NULL;
+	elf_fd->fd = -1;
+
 	if (elf_version(EV_CURRENT) == EV_NONE) {
 		pr_warn("elf: failed to init libelf for %s\n", binary_path);
 		return -LIBBPF_ERRNO__LIBELF;
-- 
2.45.2


