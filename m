Return-Path: <bpf+bounces-38303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBEA962F6D
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 20:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7991DB20C52
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 18:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E3B1AAE0D;
	Wed, 28 Aug 2024 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4wHN4AK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5235F1A76B9;
	Wed, 28 Aug 2024 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868670; cv=none; b=q7ArbcL9yhefYjPY28xr1Ag5EByyqmZXiPCvG5ikiSN+KNmLt6QJcmT3q7nOqg4CaSUwl2CM0tvwD/VRudVJYDPUJsM0Av4FHcJE+2AFrEcx/IKG+OWpPlpFVy6Q1HLJOBc1vhRi8FP/xhL+WiXkI5yzsvTKI1LLJsr/ylX8zUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868670; c=relaxed/simple;
	bh=Qjd/jE02GSJBrIcD1FBndJ80GXP0jSSiOA7x0tSVfdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvHn+Fq0qnvcOcTczjT2E7ITNYOrJDyJvWSfux5cE7M0YdhTyPDEW/hlKlFYwOej0sR1mMZcVehM5Qryh3++hpI/A+IIOCYFH+0LP6R4jEqrN0TfQ1UrU5+reIXYo8+swWxyKAZXBPVllF0TZVEgYBu0rwSjzWLY1d8w5BI5ImM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4wHN4AK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F73C4CEC0;
	Wed, 28 Aug 2024 18:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724868669;
	bh=Qjd/jE02GSJBrIcD1FBndJ80GXP0jSSiOA7x0tSVfdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q4wHN4AKTDICgw860xxO7ntbo38wyAh3TRzL1R2nX0c4bcfBlLoNeVKRZGghn1QAE
	 ZQCba7sWpgU5dl8kUZFGiNXZ1GaUe84zk4TA3kZpSvSFIDyxvTSv3XSF8g+PEvDtui
	 UOEl52rHMZTYw6Al0XJkLqCng4P/acyyEo7f+dmIID3CuIgQMsQzblPJftixufa2XJ
	 GuIkTjJjlLGB+eI3vl9uZmtgFOAbuJUq2otbnC+224Gd3KU3aa4/otSG1GC7Fw0X+X
	 XT/yh+b+toPV1lPfHJ4nzvPVctz51g3/XciDKBRir4kSMeBhGJebJe1TwfBFTXq2MC
	 l9FPGP44iDIGQ==
From: Alexey Gladkov <legion@kernel.org>
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v3] bpf: Remove custom build rule
Date: Wed, 28 Aug 2024 20:10:28 +0200
Message-ID: <20240828181028.4166334-1-legion@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <CAK7LNATb8dbhvdSgiNEMkdsgg93q4ZUGUxReZYNjOV3fDPnfyQ@mail.gmail.com>
References: <CAK7LNATb8dbhvdSgiNEMkdsgg93q4ZUGUxReZYNjOV3fDPnfyQ@mail.gmail.com>
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

$ touch kernel/bpf/core.c
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
index 000000000000..eab8493a1669
--- /dev/null
+++ b/kernel/bpf/btf_iter.c
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "../../tools/lib/bpf/btf_iter.c"
diff --git a/kernel/bpf/btf_relocate.c b/kernel/bpf/btf_relocate.c
new file mode 100644
index 000000000000..8c89c7b59ef8
--- /dev/null
+++ b/kernel/bpf/btf_relocate.c
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "../../tools/lib/bpf/btf_relocate.c"
diff --git a/kernel/bpf/relo_core.c b/kernel/bpf/relo_core.c
new file mode 100644
index 000000000000..6a36fbc0e5ab
--- /dev/null
+++ b/kernel/bpf/relo_core.c
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "../../tools/lib/bpf/relo_core.c"
-- 
2.46.0


