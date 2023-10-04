Return-Path: <bpf+bounces-11365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 296FF7B7F0D
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 14:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A32CE281E16
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 12:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A5C13FF0;
	Wed,  4 Oct 2023 12:27:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABA913FE6;
	Wed,  4 Oct 2023 12:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0494AC433C7;
	Wed,  4 Oct 2023 12:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696422449;
	bh=vZdeekHmX6PRJrot+PinxMvY1FiWo7fqDKl0jsBzl+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ImQPHdN5Vej8ZQgiOvsRoxKhp/zQ4Hl2xHXEjV4iyS98p1zFUHKHL50ytHlMRK484
	 9hzk0/ouyrOenAmjzEdDDnUHYfH6QmpzDmo1bL4rmj8feQ7JTPlFiv8OU0V9caUc61
	 IC3WjJiR2dah3NRJhNL5VcKtF0magsuCqJAVTnNZmhxEysDJC+p0Rfvb2uT2R9h1s1
	 ns7MX2dQ183fjYtbfCOPvPfvlf0BA4j9YQr/LxGTtCjjYa3UicdOf3eqrUunR1dZh9
	 QL5CYN/+QLMn8L1zku2UjN0HmQ/AjQeLhR9bQK0bMQArhxh3LGzK95NdheiCoQbN12
	 z4jEO4wgv/U8g==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH bpf-next 1/3] selftests/bpf: Add cross-build support for urandom_read et al
Date: Wed,  4 Oct 2023 14:27:19 +0200
Message-Id: <20231004122721.54525-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004122721.54525-1-bjorn@kernel.org>
References: <20231004122721.54525-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

Some userland programs in the BPF test suite, e.g. urandom_read, is
missing cross-build support. Add cross-build support for these
programs

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/bpf/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 47365161b6fc..a9cbb85fa180 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -198,7 +198,7 @@ endif
 # do not fail. Static builds leave urandom_read relying on system-wide shared libraries.
 $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c liburandom_read.map
 	$(call msg,LIB,,$@)
-	$(Q)$(CLANG) $(filter-out -static,$(CFLAGS) $(LDFLAGS))   \
+	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) $(filter-out -static,$(CFLAGS) $(LDFLAGS))   \
 		     $(filter %.c,$^) $(filter-out -static,$(LDLIBS)) \
 		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
 		     -Wl,--version-script=liburandom_read.map \
@@ -206,7 +206,7 @@ $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c liburandom
 
 $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_read.so
 	$(call msg,BINARY,,$@)
-	$(Q)$(CLANG) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
+	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
 		     -lurandom_read $(filter-out -static,$(LDLIBS)) -L$(OUTPUT)  \
 		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
 		     -Wl,-rpath=. -o $@
-- 
2.39.2


