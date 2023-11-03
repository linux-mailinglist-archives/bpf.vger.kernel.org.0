Return-Path: <bpf+bounces-14131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC57A7E0ACA
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 22:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E14B21483
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 21:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC1F2377D;
	Fri,  3 Nov 2023 21:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ocwaszkr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845F523767;
	Fri,  3 Nov 2023 21:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0885C433C7;
	Fri,  3 Nov 2023 21:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699047953;
	bh=rKZpW/h3hclAU/frcqHyWYj+PPWPzWje5PTxjEmREEE=;
	h=From:To:Cc:Subject:Date:From;
	b=OcwaszkrY1QsUVsUviawPURr1Be2wfSIBVXG6+PyJVowBEurtUniIMQITqStyvgo7
	 F/yuJzg/dFyXdQzUnooXk57seqe9mz5eRNAAmPbj2qlAdVSt1UxSVDalSfI2JnycmM
	 V1glh4iHcouwmmF/YvwfQfZOjIPmGL85RZR+yOrYaz2n7Qtyr/PFs3gY2oYKrHbqH9
	 fsnh+bMs4Xom1Eqz4u3W4N+Lx8BuIdoWWUz5HaZHSNmCKj/u+f726bYjcvlsyk5J8o
	 WnXLEqyj3v5/85+M7l372EENCSDCNPtsDtUoMmDRX+OO88kJZidFr0tBOSSWfClecc
	 eAuj4/FwMf9XQ==
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
Subject: [PATCH v10 bpf-next 0/9] bpf: File verification with LSM and fsverity
Date: Fri,  3 Nov 2023 14:45:26 -0700
Message-Id: <20231103214535.2674059-1-song@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes v9 => v10:
1. Remove WARN_ON_ONCE() from check_reg_const_str. (Alexei)

Changes v8 => v9:
1. Fix test_progs kfunc_dynptr_param/dynptr_data_null.

Changes v7 => v8:
1. Do not use bpf_dynptr_slice* in the kernel. Add __bpf_dynptr_data* and
   use them in ther kernel. (Andrii)

Changes v6 => v7:
1. Change "__const_str" annotation to "__str". (Alexei, Andrii)
2. Add KF_TRUSTED_ARGS flag for both new kfuncs. (KP)
3. Only allow bpf_get_file_xattr() to read xattr with "user." prefix.
4. Add Acked-by from Eric Biggers.

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
  bpf: Add __bpf_dynptr_data* for in kernel use
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
 include/linux/bpf.h                           |   2 +
 kernel/bpf/helpers.c                          |  47 +++++
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
 19 files changed, 826 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/bpf/fs_kfuncs.rst
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_fsverity.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_get_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sig_in_xattr.c

--
2.34.1

