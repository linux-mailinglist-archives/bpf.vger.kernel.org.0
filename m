Return-Path: <bpf+bounces-4044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6919374830C
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 13:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E7A1C20AE0
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 11:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ACF79CC;
	Wed,  5 Jul 2023 11:39:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91BF748D;
	Wed,  5 Jul 2023 11:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C3EC43391;
	Wed,  5 Jul 2023 11:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688557179;
	bh=urR3yZnDusvfwXBBOCw/IKT8fxfFq0fp8eLiyLD/Gk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mjrzNsnkwMA7QUoyv8VZHYooJ9qpesUo3fpr7hiB/TVnxsZHH9BhWMCKLK8at5QwS
	 V9hMGMNDTEq3nNEQ6c3DCl83x7CH/qRoAk5UNVLg8DQffuNqmHl4AlteM2DLsljmQs
	 5VuXlXM9uZxiblRRVomfvkyWZuEcaquye35Zfui17JLeLC9AHJlbSvfgq+DCac65GS
	 WvKfzA2uUlTbXQQcpTnKOsXLKWF3MNPpFWtQjerp92230pbjBn3bPavNHUlXYCM8w8
	 NK92ORPQi9wQqzp90yshBg7i4NS7GpOFowqCsYqGQZxY08HdzQbNHiWnCGo50L1MAJ
	 o/vqbVggKlsVA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Honor $(O) when figuring out paths
Date: Wed,  5 Jul 2023 13:39:26 +0200
Message-Id: <20230705113926.751791-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230705113926.751791-1-bjorn@kernel.org>
References: <20230705113926.751791-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

When building the kselftests out-of-tree, e.g.
  | make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- \
  |   O=/tmp/kselftest headers
  | make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- \
  |  O=/tmp/kselftest HOSTCC=gcc FORMAT= \
  |  SKIP_TARGETS="arm64 ia64 powerpc sparc64 x86 sgx" \
  |  -C tools/testing/selftests gen_tar

the kselftest build would not pick up the correct GENDIR path, and
therefore not including autoconf.h.

Correct that by taking $(O) into consideration when figuring out the
GENDIR path.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/bpf/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index ad6b585e0d7c..daccc1b8573a 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -12,7 +12,11 @@ BPFDIR := $(LIBDIR)/bpf
 TOOLSINCDIR := $(TOOLSDIR)/include
 BPFTOOLDIR := $(TOOLSDIR)/bpf/bpftool
 APIDIR := $(TOOLSINCDIR)/uapi
+ifneq ($(O),)
+GENDIR := $(O)/include/generated
+else
 GENDIR := $(abspath ../../../../include/generated)
+endif
 GENHDR := $(GENDIR)/autoconf.h
 HOSTPKG_CONFIG := pkg-config
 
-- 
2.39.2


