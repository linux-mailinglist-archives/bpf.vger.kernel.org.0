Return-Path: <bpf+bounces-13195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CB57D5EDF
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 01:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843BD1C20D9B
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 23:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0008D2D61D;
	Tue, 24 Oct 2023 23:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHCNDjyf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642D93E495;
	Tue, 24 Oct 2023 23:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98831C433C8;
	Tue, 24 Oct 2023 23:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698191800;
	bh=Xm4N+IK6cCfxBp62n/HaElU5RuamPewSwlV6BouTrZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XHCNDjyf4qoKwtHkpy6r4wub2wJJn13C1l73043H7NjRGaHi7GjGvq4DZ953dObBv
	 p9DgsMqX2jEYFYRgV0S0e3WmkAaQdFDq0NPytLxKi0XeqsUuCNo+9GKrXY8QkYt8Fj
	 TEwyyQj6gxnM5k4iGNjnqH7GMMF1ogiE5d4xq0nU3on6eBiHRwevuLQovPkcvhTHcf
	 KRfdNNQGok8VmFfeHtKezKXFC4fAoLR8uuAPoW9UfENaFR4FQ4B0+x4H70NjNrNqwZ
	 pMbrppiqkl5aL7s4TgD3JIItFSkAIgaNyL06ZyJVLWX02C0gAYA05WkVtA9Pe2sVXz
	 2aG1au0rO1hxA==
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
Subject: [PATCH v6 bpf-next 6/9] Documentation/bpf: Add documentation for filesystem kfuncs
Date: Tue, 24 Oct 2023 16:55:48 -0700
Message-Id: <20231024235551.2769174-7-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024235551.2769174-1-song@kernel.org>
References: <20231024235551.2769174-1-song@kernel.org>
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


