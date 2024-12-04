Return-Path: <bpf+bounces-46115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0458B9E46AF
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 22:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F3A283BFB
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 21:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BCA1922D7;
	Wed,  4 Dec 2024 21:31:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DCA23919F;
	Wed,  4 Dec 2024 21:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733347884; cv=none; b=TwxTAv/X/sNKEb/Ci8Mmv8FPDmsIXx/dAi5vnCIToJJRWwkjhsG9HO77uJrwXiSXzlUunUP4QCQmwa5Mfl19WfeLQopcENA51FArYqakVivdRfqld/TGrR3yjejLK9PVzZNooePcpeE8r0jb8x0EfUV4L/5q5qavPAyNJt58KM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733347884; c=relaxed/simple;
	bh=yuBNlLzaZI5XSkMVajmbciuNfubFCWVPWQEvzf+N4NA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gRqITO+m70b9d59gizY9QjiL7++1oz6K7tYvsA2eFXnav3M5ufxl99S2nNWFHfADtQCEh4xUsMSqyyr7s1ljXgXxabbtggsfZ2kjsxNBb4Us/HzwjuinOG7817Bh2B9hPdlLea/WoqZAe/DtUH+OmqBeBcqZngSzE6BZjRT5YEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C30001063;
	Wed,  4 Dec 2024 13:31:46 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BC0433F58B;
	Wed,  4 Dec 2024 13:31:15 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Nick Terrell <terrelln@fb.com>,
	bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH] bpftool: Fix failure with static linkage
Date: Wed,  4 Dec 2024 21:30:59 +0000
Message-Id: <20241204213059.2792453-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When building perf with static linkage:

  make O=/build LDFLAGS="-static" -C tools/perf VF=1 DEBUG=1
  ...
  LINK    /build/util/bpf_skel/.tmp/bootstrap/bpftool
  /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-gnu/libelf.a(elf_compress.o): in function `__libelf_compress':
  (.text+0x113): undefined reference to `ZSTD_createCCtx'
  /usr/bin/ld: (.text+0x2a9): undefined reference to `ZSTD_compressStream2'
  /usr/bin/ld: (.text+0x2b4): undefined reference to `ZSTD_isError'
  /usr/bin/ld: (.text+0x2db): undefined reference to `ZSTD_freeCCtx'
  /usr/bin/ld: (.text+0x5a0): undefined reference to `ZSTD_compressStream2'
  /usr/bin/ld: (.text+0x5ab): undefined reference to `ZSTD_isError'
  /usr/bin/ld: (.text+0x6b9): undefined reference to `ZSTD_freeCCtx'
  /usr/bin/ld: (.text+0x835): undefined reference to `ZSTD_freeCCtx'
  /usr/bin/ld: (.text+0x86f): undefined reference to `ZSTD_freeCCtx'
  /usr/bin/ld: (.text+0x91b): undefined reference to `ZSTD_freeCCtx'
  /usr/bin/ld: (.text+0xa12): undefined reference to `ZSTD_freeCCtx'
  /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-gnu/libelf.a(elf_compress.o): in function `__libelf_decompress':
  (.text+0xbfc): undefined reference to `ZSTD_decompress'
  /usr/bin/ld: (.text+0xc04): undefined reference to `ZSTD_isError'
  /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-gnu/libelf.a(elf_compress.o): in function `__libelf_decompress_elf':
  (.text+0xd45): undefined reference to `ZSTD_decompress'
  /usr/bin/ld: (.text+0xd4d): undefined reference to `ZSTD_isError'
  collect2: error: ld returned 1 exit status

Building bpftool with static linkage also fails with the same errors:

  make O=/build -C tools/bpf/bpftool/ V=1

To fix the issue, explicitly link libzstd.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/bpf/bpftool/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index a4263dfb5e03..65b2671941e0 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -130,8 +130,8 @@ include $(FEATURES_DUMP)
 endif
 endif
 
-LIBS = $(LIBBPF) -lelf -lz
-LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lz
+LIBS = $(LIBBPF) -lelf -lz -lzstd
+LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lz -lzstd
 ifeq ($(feature-libcap), 1)
 CFLAGS += -DUSE_LIBCAP
 LIBS += -lcap
-- 
2.34.1


