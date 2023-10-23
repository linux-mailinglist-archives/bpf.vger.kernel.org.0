Return-Path: <bpf+bounces-13015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7F27D3BA9
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 18:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6491B281475
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 16:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E020D1CAA3;
	Mon, 23 Oct 2023 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXD2wD3f"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6161CA96;
	Mon, 23 Oct 2023 16:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27731C433C7;
	Mon, 23 Oct 2023 16:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698077037;
	bh=oj+EgwgAzepxHI2hoonzRZkN3U3R38eFSHljj+209Do=;
	h=From:To:Cc:Subject:Date:From;
	b=FXD2wD3fBCitH/FzYJcJ+5wnQiGUW8E662UBLon8Ew1/mG8nyWPyl3aO3443uKeRP
	 AVHgtuohXc04KRFys1/jnXfgl/gD0jlEfxXlTQaVSRLxwOfkdZ8iCiSYRO8BPD+WDP
	 Xldz8aUAWTtZ2ModN7qz9cCZG/yk4dTie6ghieI47HOL8go7uPjFNHDZdNBCUVmYbN
	 EaLHuDW2yyDLuDG+65CqzmWXdSboFbwdXr6j9sc/wN0OoGB81XgKfx8G5D7g9EwIEU
	 0YQyq7BU6bqQxm0jxUzpkCYHvdITAYlDMaT+wUiguU+vcdc67azi9Sm55EnhjbZGPE
	 KNkgk7aCSdU5w==
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
Subject: [PATCH v3 bpf-next 0/9] bpf: File verification with LSM and fsverity
Date: Mon, 23 Oct 2023 09:03:40 -0700
Message-Id: <20231023160349.4161154-1-song@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes v2 => v3:
1. Rebase and resolve conflicts.

Changes v1 => v2:
1. Let bpf_get_file_xattr() use const string for arg "name". (Alexei)
2. Add recursion prevention with allowlist. (Alexei)
3. Let bpf_get_file_xattr() use __vfs_getxattr() to avoid recursion,
   as vfs_getxattr() calls into other LSM hooks.
4. Do not use dynptr->data directly, use helper insteadd. (Andrii)
5. Fixes with bpf_get_fsverity_digest. (Eric Biggers)
6. Add documentation. (Eric Biggers)
7. Fix some compile warnings. (kernel test robot)

This set enables file verification with BPF LSM and fsverity.

In this solution, fsverity is used to provide reliable and efficient hash
of files; and BPF LSM is used to implement signature verification (against
asymmetric keys), and to enforce access control.

This solution can be used to implement access control in complicated cases.
For example: only signed python binary and signed python script and access
special files/devices/ports.

Thanks,
Song

Song Liu (9):
  bpf: Expose bpf_dynptr_slice* kfuncs for in kernel use
  bpf: Factor out helper check_reg_const_str()
  bpf: Introduce KF_ARG_PTR_TO_CONST_STR
  bpf: Add kfunc bpf_get_file_xattr
  bpf, fsverity: Add kfunc bpf_get_fsverity_digest
  Documentation/bpf: Add documentation for filesystem kfuncs
  selftests/bpf: Sort config in alphabetic order
  selftests/bpf: Add tests for filesystem kfuncs
  selftests/bpf: Add test that use fsverity and xattr to sign a file

 Documentation/bpf/fs_kfuncs.rst               |  21 +++
 Documentation/bpf/index.rst                   |   1 +
 Documentation/bpf/kfuncs.rst                  |  24 +++
 fs/verity/fsverity_private.h                  |  10 ++
 fs/verity/init.c                              |   1 +
 fs/verity/measure.c                           |  82 +++++++++
 include/linux/bpf.h                           |   4 +
 kernel/bpf/verifier.c                         | 104 +++++++----
 kernel/trace/bpf_trace.c                      |  71 +++++++-
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  10 ++
 tools/testing/selftests/bpf/config            |   3 +-
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 132 ++++++++++++++
 .../bpf/prog_tests/verify_pkcs7_sig.c         | 163 +++++++++++++++++-
 .../selftests/bpf/progs/test_fsverity.c       |  46 +++++
 .../selftests/bpf/progs/test_get_xattr.c      |  37 ++++
 .../selftests/bpf/progs/test_sig_in_xattr.c   |  82 +++++++++
 .../bpf/progs/test_verify_pkcs7_sig.c         |   8 +-
 .../testing/selftests/bpf/verify_sig_setup.sh |  25 +++
 18 files changed, 775 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/bpf/fs_kfuncs.rst
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_fsverity.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_get_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sig_in_xattr.c

--
2.34.1

