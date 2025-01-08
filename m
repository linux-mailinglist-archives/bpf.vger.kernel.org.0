Return-Path: <bpf+bounces-48311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EE7A068CC
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 23:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7500C3A13B2
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 22:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8826C2046A0;
	Wed,  8 Jan 2025 22:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbThi3x0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0596119EEBF;
	Wed,  8 Jan 2025 22:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736376707; cv=none; b=eGd1jUZXQMyXZT7nmLu6Tqt2H+yrBZEMD2Wjx5Kuz3GFIMz0dwI7qW5/5KJb6fOq0mIm1K9eqOWRZ6zAQzEqEsKkwZ7Lbb5xvZr0ys/mpy+RDDe2PPPPtrZXclszT1WNCKf+BWAjCzkNwJAjgBLHI0g4fMDuiaIGuASef1zhHl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736376707; c=relaxed/simple;
	bh=i83+Yfsqi8DjiGhr+ul/R7ISjSLZnDhHNpYlRk/ErXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uSg6V+x+OddIll/AKbGtCtwiZWxNKoO6ep3Hx848jz4ww3bDspTlMyJ2T8bgQOGYul6kGJSQpnhOzOMoYf7u4Gy3YDqXRTFK1vuZ7qL3+QTJAdHm6LY/Z88F7/XptYV8HKSY0TVRwOg2UL6+UiXAln7FhQi3CnToYs5eFCO1tB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbThi3x0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39709C4CED3;
	Wed,  8 Jan 2025 22:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736376706;
	bh=i83+Yfsqi8DjiGhr+ul/R7ISjSLZnDhHNpYlRk/ErXA=;
	h=From:To:Cc:Subject:Date:From;
	b=bbThi3x0U2vf/JPgG9XR9puaH5M13TAHva6GfgCV1Sv0HRYHtld8XFwnS/c9KSX2/
	 ozx1yQazm2MFq2fGd6lkkZodJklUay2sRau6yOAAGHrQ3oXS5FFMqfRMwNzxcx27Fg
	 acxre25qkpNZ9qq6Zrjl8BmKqBzNTy5XXwWeQdTjT7AqDoD70iQQcvLHRXfzgE1QwW
	 SJx5aqFvLHqB60OrsAjw1rpXAH4a/I5lZ8fkO+EYV9evgrjcS6Fa09PUYD4gGosa/C
	 E2zIuGypzG1fNL01/SK1idlkqWVc6+ewCojf1lEvlI0KxkHi2i9JJLyKpVhnXnbg7o
	 HmW3M8wg2DRXA==
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
Subject: [PATCH v8 bpf-next 0/7] Enable writing xattr from BPF programs
Date: Wed,  8 Jan 2025 14:51:33 -0800
Message-ID: <20250108225140.3467654-1-song@kernel.org>
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

To pick the right version of kfunc to use, a remap logic is added to
btf_kfunc_id_set. This helps move some kfunc specific logic off the
verifier core code. Also use this remap logic to select
bpf_dynptr_from_skb or bpf_dynptr_from_skb_rdonly.


Cover letter of v1 and v2:

Follow up discussion in LPC 2024 [1], that we need security.bpf xattr
prefix. This set adds "security.bpf." xattr name prefix, and allows
bpf kfuncs bpf_get_[file|dentry]_xattr() to read these xattrs.

[1] https://lpc.events/event/18/contributions/1940/

Changes v7 => v8
1. Rebase and resolve conflicts.

v7: https://lore.kernel.org/bpf/20241219221439.2455664-1-song@kernel.org/

Changes v6 => v7
1. Move btf_kfunc_id_remap() to the right place. (Bug reported by CI)

v6: https://lore.kernel.org/bpf/20241219202536.1625216-1-song@kernel.org/

Changes v5 => v6
1. Hide _locked version of the kfuncs from vmlinux.h (Alexei)
2. Add remap logic to btf_kfunc_id_set and use that to pick the correct
   version of kfuncs to use.
3. Also use the remap logic for bpf_dynptr_from_skb[|_rdonly].

v5: https://lore.kernel.org/bpf/20241218044711.1723221-1-song@kernel.org/

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

Song Liu (7):
  fs/xattr: bpf: Introduce security.bpf. xattr name prefix
  selftests/bpf: Extend test fs_kfuncs to cover security.bpf. xattr
    names
  bpf: lsm: Add two more sleepable hooks
  bpf: Extend btf_kfunc_id_set to handle kfunc polymorphism
  bpf: Use btf_kfunc_id_set.remap logic for bpf_dynptr_from_skb
  bpf: fs/xattr: Add BPF kfuncs to set and remove xattrs
  selftests/bpf: Test kfuncs that set and remove xattr from BPF programs

 fs/bpf_fs_kfuncs.c                            | 246 +++++++++++++++++-
 include/linux/bpf_lsm.h                       |   2 +
 include/linux/btf.h                           |  20 ++
 include/linux/btf_ids.h                       |   3 +
 include/uapi/linux/xattr.h                    |   4 +
 kernel/bpf/bpf_lsm.c                          |   2 +
 kernel/bpf/btf.c                              | 117 +++++++--
 kernel/bpf/verifier.c                         |  31 +--
 net/core/filter.c                             |  49 +++-
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   5 +
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 162 +++++++++++-
 .../selftests/bpf/progs/test_get_xattr.c      |  28 +-
 .../bpf/progs/test_set_remove_xattr.c         | 133 ++++++++++
 13 files changed, 739 insertions(+), 63 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_set_remove_xattr.c

--
2.43.5

