Return-Path: <bpf+bounces-13189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41067D5ED9
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 01:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 702D0B209BD
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 23:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94824737F;
	Tue, 24 Oct 2023 23:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kN/tWs6J"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2FD749D;
	Tue, 24 Oct 2023 23:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC86C433C7;
	Tue, 24 Oct 2023 23:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698191763;
	bh=aJu3M1pmGuwRVs/3QdMpTfbmlAVZrf2C1vqwSefnvig=;
	h=From:To:Cc:Subject:Date:From;
	b=kN/tWs6JJL8vVA4q2zpFSNhq/APaxLLwA+hzp9eJf7TA3DBbWhhd6DB2WodInV4OU
	 f0+RJGz0s1uiuoD5w2WhHsF1Z07Z/WP8RWNF74br/1CSoLREAxFY3ktyR4rclMoX52
	 VKVkxVaJ7u0x/BqcokCVoeRIg6M5yjCJGtLqWXZH7myT7oXXfnToWGZU2I18MvbcfV
	 MZXn8xQNN5WEHGfa5TySaBCpN4gPzWZo0DU3j4/4pjXzjxuT8zgUvzV7HsqmM35ZEc
	 p3UhysjqzzNiuPigeuV8b4XRI9hr1DZMtg3vnAF/89CFE8CagJ0NkT7YQMeAU1fpFI
	 PAgGNGojrhVIw==
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
Subject: [PATCH v6 bpf-next 0/9] bpf: File verification with LSM and fsverity
Date: Tue, 24 Oct 2023 16:55:42 -0700
Message-Id: <20231024235551.2769174-1-song@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes v5 => v6:
1. Let fsverity_init_bpf() return void. (Eric Biggers)
2. Sort things in alphabetic orders. (Eric Biggers)

Changes v4 => v5:
1. Revise commit logs. (Alexei)

Changes v3 => v4:
1. Fix error reported by CI.
2. Update comments of bpf_dynptr_slice* that they may return error pointer.

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
  selftests/bpf: Add test that uses fsverity and xattr to sign a file

 Documentation/bpf/fs_kfuncs.rst               |  21 +++
 Documentation/bpf/index.rst                   |   1 +
 Documentation/bpf/kfuncs.rst                  |  24 +++
 fs/verity/fsverity_private.h                  |  10 ++
 fs/verity/init.c                              |   1 +
 fs/verity/measure.c                           |  85 +++++++++
 include/linux/bpf.h                           |   4 +
 kernel/bpf/helpers.c                          |  16 +-
 kernel/bpf/verifier.c                         | 104 +++++++----
 kernel/trace/bpf_trace.c                      |  74 +++++++-
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  10 ++
 tools/testing/selftests/bpf/config            |   3 +-
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 132 ++++++++++++++
 .../bpf/prog_tests/verify_pkcs7_sig.c         | 163 +++++++++++++++++-
 .../selftests/bpf/progs/test_fsverity.c       |  46 +++++
 .../selftests/bpf/progs/test_get_xattr.c      |  37 ++++
 .../selftests/bpf/progs/test_sig_in_xattr.c   |  82 +++++++++
 .../bpf/progs/test_verify_pkcs7_sig.c         |   8 +-
 .../testing/selftests/bpf/verify_sig_setup.sh |  25 +++
 19 files changed, 789 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/bpf/fs_kfuncs.rst
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_fsverity.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_get_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sig_in_xattr.c

--
2.34.1

