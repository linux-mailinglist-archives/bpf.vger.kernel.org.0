Return-Path: <bpf+bounces-38531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 143E09658F4
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 09:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F8EDB251BC
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 07:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D54715F41D;
	Fri, 30 Aug 2024 07:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZQ7phyN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3EB15C154;
	Fri, 30 Aug 2024 07:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003869; cv=none; b=FsFe1pnU9rX8lRzNPceyVlgX78/nkgn7N8bcQR+uO12aFp8Ncoajw/L/kafwuLqC7pcbj4YiAKDqpgeujTqE9YJQkU1CXh1aqUIJu0pc9a8WTyt8SAXqXiBW8dfMsUYXZXYuIBSZEVqnii9julfKcryKRROXd4bcv9kMBOnmiZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003869; c=relaxed/simple;
	bh=ab9E8yRsVsHNSM1VcLw6wnCuw/OKKKTdW168xZIgIJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RW/Ur0TXMGZeinaiRxtKJ6z9jBXLrwl4Zx6SHX0P77ck2bBinXPDLjj4tM0xbXHroyo/mIQz3RimRbB+tuh96QyPyqcRNLkv2y8i2K5idnWzAS0C+4nVrihC3nierTpS+cx4S7L8QbUeaGkm0pOgCkcu1iHeeRyCaNlTPQVpxH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZQ7phyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242F5C4CEC2;
	Fri, 30 Aug 2024 07:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725003869;
	bh=ab9E8yRsVsHNSM1VcLw6wnCuw/OKKKTdW168xZIgIJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XZQ7phyNKtZDX4or/EXnonJV+IXRySCOITTQgFC3nAfJkGcwv5cBgyOgzkghlE4T/
	 OPVQVey6bW+y090lIzs3/L1XoZpsapLBMxQRlC8SqQppy3WB2OvE8gOsFqvq0eC9xr
	 VarKorz25elSSfFj73qUjYePvecRFUhdsdbdcIcjFNkby7Kc6QK0ZPxvXZyf6gtjxe
	 ob/f7E6TV+hw536dhN5WAc8tEU+BV/AOu0mf26wOXSEGHRa+N23KIh1wFha6iYgWxQ
	 scs4aVkAs+GB8TsO9IaAx4sEdw8CiA43jc+qvehsIXhWdBbdqEWD6OS9U58ojgQAul
	 W6e8YActPrU7A==
From: Alexey Gladkov <legion@kernel.org>
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Oleg Nesterov <oleg@redhat.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4] bpf: Remove custom build rule
Date: Fri, 30 Aug 2024 09:43:50 +0200
Message-ID: <20240830074350.211308-1-legion@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <CAADnVQL4Cy-F_=RJy_=3v97mfaMRWGp54xN-t9QzOqY3+hoghg@mail.gmail.com>
References: <CAADnVQL4Cy-F_=RJy_=3v97mfaMRWGp54xN-t9QzOqY3+hoghg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the documentation, when building a kernel with the C=2
parameter, all source files should be checked. But this does not happen
for the kernel/bpf/ directory.

$ touch kernel/bpf/core.o
$ make C=2 CHECK=true kernel/bpf/core.o

Outputs:

  CHECK   scripts/mod/empty.c
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
  INSTALL libsubcmd_headers
  CC      kernel/bpf/core.o

As can be seen the compilation is done, but CHECK is not executed. This
happens because kernel/bpf/Makefile has defined its own rule for
compilation and forgotten the macro that does the check.

There is no need to duplicate the build code, and this rule can be
removed to use generic rules.

Acked-by: Masahiro Yamada <masahiroy@kernel.org>
Tested-by: Oleg Nesterov <oleg@redhat.com>
Tested-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 kernel/bpf/Makefile       | 6 ------
 kernel/bpf/btf_iter.c     | 2 ++
 kernel/bpf/btf_relocate.c | 2 ++
 kernel/bpf/relo_core.c    | 2 ++
 4 files changed, 6 insertions(+), 6 deletions(-)
 create mode 100644 kernel/bpf/btf_iter.c
 create mode 100644 kernel/bpf/btf_relocate.c
 create mode 100644 kernel/bpf/relo_core.c

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 0291eef9ce92..9b9c151b5c82 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -52,9 +52,3 @@ obj-$(CONFIG_BPF_PRELOAD) += preload/
 obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
 obj-$(CONFIG_BPF_SYSCALL) += btf_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += btf_relocate.o
-
-# Some source files are common to libbpf.
-vpath %.c $(srctree)/kernel/bpf:$(srctree)/tools/lib/bpf
-
-$(obj)/%.o: %.c FORCE
-	$(call if_changed_rule,cc_o_c)
diff --git a/kernel/bpf/btf_iter.c b/kernel/bpf/btf_iter.c
new file mode 100644
index 000000000000..0e2c66a52df9
--- /dev/null
+++ b/kernel/bpf/btf_iter.c
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include "../../tools/lib/bpf/btf_iter.c"
diff --git a/kernel/bpf/btf_relocate.c b/kernel/bpf/btf_relocate.c
new file mode 100644
index 000000000000..c12ccbf66507
--- /dev/null
+++ b/kernel/bpf/btf_relocate.c
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include "../../tools/lib/bpf/btf_relocate.c"
diff --git a/kernel/bpf/relo_core.c b/kernel/bpf/relo_core.c
new file mode 100644
index 000000000000..aa822c9fcfde
--- /dev/null
+++ b/kernel/bpf/relo_core.c
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include "../../tools/lib/bpf/relo_core.c"
-- 
2.46.0


