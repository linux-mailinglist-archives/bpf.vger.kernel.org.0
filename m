Return-Path: <bpf+bounces-12978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 878807D2A17
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 08:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DF23B20DE3
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 06:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8AB63AB;
	Mon, 23 Oct 2023 06:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fzw94/Bi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA9D612F;
	Mon, 23 Oct 2023 06:14:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC3AC433C7;
	Mon, 23 Oct 2023 06:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698041678;
	bh=vI21SwsFh8BbUe3W4TDykih0dYY4CzbsnALGXjMyIZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fzw94/BicPKXZR/rGUlOawZ1Ilhgh7u7kHS1AihroAfVdHRTv33RbhtkGNf5WT6Pu
	 CADz1mgztzkE2+yNU7TV/RDwWTH4wCDfc8eutzKxX4P+EjqsWajsMkcaNez6m63MrT
	 EjpXcfJCltmXfFEGKUPEz7Hda/Wpkr2gjLFob36OdXSaqn005xBUODXC13CKSuXCJY
	 WggMOdzxkBxWtSoVL1wQjr1uLugkieMD9AahtTAEgYKVEh2qmoQlys+Ziq9c55tedy
	 cdNg7m7l8pIOsG+IcGPm60x1ZBKVBeHf3xqcP0cw4YY+Uz4UhgcKQvcEtXQxYoGMb9
	 h9dkYv9xrJWQA==
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
	Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 6/9] Documentation/bpf: Add documentation for filesystem kfuncs
Date: Sun, 22 Oct 2023 23:13:51 -0700
Message-Id: <20231023061354.941552-7-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023061354.941552-1-song@kernel.org>
References: <20231023061354.941552-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a brief introduction for file system kfuncs.

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


