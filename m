Return-Path: <bpf+bounces-47186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF55A9F5DE3
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 05:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01EF27A1992
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 04:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E2814F9EB;
	Wed, 18 Dec 2024 04:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRc0hi5j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FB135974;
	Wed, 18 Dec 2024 04:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734497251; cv=none; b=Pp5O/mWkpnFnjlJLBEwI08FTcK5ePg6RN6AiMG8HELNQzjiJ2hnY5LxBE9u1GXMoTVqqCc8T/nJEoZxDEnnD5nG+RbOqPL/hFQRNd37i1/xE/90ZJ2RYrR6ZQ4R6EcKAV2snP9bmPGRy4mi/WxWBzktJjy+iFpCu2XcNTm38nRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734497251; c=relaxed/simple;
	bh=N06FIWtq5f6afA0TvjPQ7CITRjH8zMnihpeOW6GSQgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pehAFYtb8ocJN9Omiw9uL3gKWeLGSI9Lr8aMk6wwMbY+rEZVB8qFfUovDWlGN8NR14t3r1Pir/mMVftwXzQc2tqCo+xJFs26qcQ4cs6JtRBrqowRw/e6Njaw0pY8QHXlEOOk5cuUvi5FBpccMHPGt7Jc0E5mGWWrc9/UviQz3GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRc0hi5j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585EBC4CECE;
	Wed, 18 Dec 2024 04:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734497251;
	bh=N06FIWtq5f6afA0TvjPQ7CITRjH8zMnihpeOW6GSQgU=;
	h=From:To:Cc:Subject:Date:From;
	b=JRc0hi5j00z2rkJgtsWsJEo9PKFJi7yhUxWNL/MgZMFCVwTxvU4NKT3z1l5R70Ezr
	 f3Q8s2ZnS+F3kCFsvdQjw+jwP7J0ZB4oj6CKoIfa7Tj8nWsjTtUqz1bPFZmjG0TYEJ
	 8SAUU3cP3C0fOu6Z5YMneq4mVvLhq+i36HlGVIiK3U5hT6OwDZgCrzWVQpcWucB6/K
	 1rjorh8XdG1E5ba/Nv4PhxaZorKE+xvbhhq6Ida9ujR6xYzGqKVlHgi70WMrfdJpUz
	 mVgWedev1cE+mq0j9dJ1/ycricihXZP0lwieBxBZLDXfrFJCHQjCY0S6RlCBjlsYkO
	 tqOt6EdFp1gwQ==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	memxor@gmail.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v5 bpf-next 0/5] Enable writing xattr from BPF programs
Date: Tue, 17 Dec 2024 20:47:06 -0800
Message-ID: <20241218044711.1723221-1-song@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to set and remove xattr from BPF program. Also add
security.bpf. xattr name prefix.

kfuncs are added to set and remove xattrs with security.bpf. name
prefix. Update kfuncs bpf_get_[file|dentry]_xattr to read xattrs
with security.bpf. name prefix. Note that BPF programs can read
user. xattrs, but not write and remove them.

Cover letter of v1 and v2:

Follow up discussion in LPC 2024 [1], that we need security.bpf xattr
prefix. This set adds "security.bpf." xattr name prefix, and allows
bpf kfuncs bpf_get_[file|dentry]_xattr() to read these xattrs.

[1] https://lpc.events/event/18/contributions/1940/

Changes v4 => v5
1. Let verifier pick proper kfunc (_locked or not _locked)  based on the
   calling context. (Alexei)
2. Remove the __failure test (6/6 of v4).

v4: https://lore.kernel.org/bpf/20241217063821.482857-1-song@kernel.org/

Changes v3 => v4
1. Do write permission check with inode locked. (Jan Kara)
2. Fix some source_inline warnings.

v3: https://lore.kernel.org/bpf/20241210220627.2800362-1-song@kernel.org/

Changes v2 => v3
1. Add kfuncs to set and remove xattr from BPF programs.

v2: https://lore.kernel.org/bpf/20241016070955.375923-1-song@kernel.org/

Changes v1 => v2
1. Update comment of bpf_get_[file|dentry]_xattr. (Jiri Olsa)
2. Fix comment for return value of bpf_get_[file|dentry]_xattr.

v1: https://lore.kernel.org/bpf/20241002214637.3625277-1-song@kernel.org/

Song Liu (5):
  fs/xattr: bpf: Introduce security.bpf. xattr name prefix
  selftests/bpf: Extend test fs_kfuncs to cover security.bpf. xattr
    names
  bpf: lsm: Add two more sleepable hooks
  bpf: fs/xattr: Add BPF kfuncs to set and remove xattrs
  selftests/bpf: Test kfuncs that set and remove xattr from BPF programs

 fs/bpf_fs_kfuncs.c                            | 214 +++++++++++++++++-
 include/linux/bpf_lsm.h                       |   8 +
 include/uapi/linux/xattr.h                    |   4 +
 kernel/bpf/bpf_lsm.c                          |   2 +
 kernel/bpf/verifier.c                         |  55 ++++-
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   5 +
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 162 ++++++++++++-
 .../selftests/bpf/progs/test_get_xattr.c      |  28 ++-
 .../bpf/progs/test_set_remove_xattr.c         | 133 +++++++++++
 9 files changed, 590 insertions(+), 21 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_set_remove_xattr.c

--
2.43.5

