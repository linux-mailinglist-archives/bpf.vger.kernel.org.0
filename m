Return-Path: <bpf+bounces-14191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DABA27E0CA9
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 01:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD0A8282028
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 00:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACFC399;
	Sat,  4 Nov 2023 00:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3wndlEg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEDB188;
	Sat,  4 Nov 2023 00:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AD5C433C8;
	Sat,  4 Nov 2023 00:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699056838;
	bh=Xm4N+IK6cCfxBp62n/HaElU5RuamPewSwlV6BouTrZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O3wndlEg4167fiSaPyNOa0Q87sQ8m+f9BX2B1bEKDIQ+wGvAHlXI0k90sEdH2X8tk
	 B4sT0ny7dIrlzJV/syIGaIg+T6CJA3crd9G3Djd+2ZV7+rUX3KpNV8rgS+Mfb776ia
	 +75KBTFz4gYQ1cGTP2YDJehT4Out9V/2kOPzIicCe/sW3a/JMYJs6FyZlExIJeen7l
	 jbRbv4OTeCfILy0ZbexSIh53WZda4r5ACAN/Jrz0ICyfW3ysqzVRIJBD+yk6/rLEQb
	 lIXySk15oSzIIfGXQ8gpdhvacpIUI+Bs/kQ474ofhT9R+SQWUeTZzvVtwf4vqkN4xi
	 T8hYgY/31dniw==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	fsverity@lists.linux.dev
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	kernel-team@meta.com,
	ebiggers@kernel.org,
	tytso@mit.edu,
	roberto.sassu@huaweicloud.com,
	kpsingh@kernel.org,
	vadfed@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v12 bpf-next 6/9] Documentation/bpf: Add documentation for filesystem kfuncs
Date: Fri,  3 Nov 2023 17:13:10 -0700
Message-Id: <20231104001313.3538201-7-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231104001313.3538201-1-song@kernel.org>
References: <20231104001313.3538201-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a brief introduction for file system kfuncs:

  bpf_get_file_xattr()
  bpf_get_fsverity_digest()

The documentation highlights the strategy to avoid recursions of these
kfuncs.

Signed-off-by: Song Liu <song@kernel.org>
---
 Documentation/bpf/fs_kfuncs.rst | 21 +++++++++++++++++++++
 Documentation/bpf/index.rst     |  1 +
 2 files changed, 22 insertions(+)
 create mode 100644 Documentation/bpf/fs_kfuncs.rst

diff --git a/Documentation/bpf/fs_kfuncs.rst b/Documentation/bpf/fs_kfuncs.rst
new file mode 100644
index 000000000000..8762c3233a3d
--- /dev/null
+++ b/Documentation/bpf/fs_kfuncs.rst
@@ -0,0 +1,21 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _fs_kfuncs-header-label:
+
+=====================
+BPF filesystem kfuncs
+=====================
+
+BPF LSM programs need to access filesystem data from LSM hooks. The following
+BPF kfuncs can be used to get these data.
+
+ * ``bpf_get_file_xattr()``
+
+ * ``bpf_get_fsverity_digest()``
+
+To avoid recursions, these kfuncs follow the following rules:
+
+1. These kfuncs are only permitted from BPF LSM function.
+2. These kfuncs should not call into other LSM hooks, i.e. security_*(). For
+   example, ``bpf_get_file_xattr()`` does not use ``vfs_getxattr()``, because
+   the latter calls LSM hook ``security_inode_getxattr``.
diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index aeaeb35e6d4a..0bb5cb8157f1 100644
--- a/Documentation/bpf/index.rst
+++ b/Documentation/bpf/index.rst
@@ -21,6 +21,7 @@ that goes into great technical depth about the BPF Architecture.
    helpers
    kfuncs
    cpumasks
+   fs_kfuncs
    programs
    maps
    bpf_prog_run
-- 
2.34.1


