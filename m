Return-Path: <bpf+bounces-47362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D89499F87A4
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 23:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E8E4162C2B
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 22:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D7C1CC8AD;
	Thu, 19 Dec 2024 22:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCYDdsDy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD231BC061;
	Thu, 19 Dec 2024 22:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734646485; cv=none; b=GBOUnx3zwHZZ5fJI5FBjY7Euk6BM8shTlzgyGDle2PhVhzWp7hbYlbjP/3fBgfjY9gHbMAYNDXhtdwt6OX+Q0wm792adEzlXmyCFD5JcD4KK6DhRWBZDacCy7Vm4fZ26UfK5pyjnHZ6G/d4B2u7UPMAKMwlh/qigb6pomnyYRtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734646485; c=relaxed/simple;
	bh=YavK3e9o6ZeYvS9H+BxSrYkff+uIlz64SNHDiq6xHCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TiEWVXO1nmOS2Zxg6O8Sv8oWNs475fqMREmx2G/AloJvzTlUPF3cS0SI4pGsza0zLnLh26KjZHh/RLPQn+rGtvZ17BdrkuzTkTggiap9KRC3jYRViPNSe5Z0skgt40JiytQ9iUJzHogmTqX1vqhj4ZyDpQP8HjXlu/8MnrzBWiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCYDdsDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95856C4CECE;
	Thu, 19 Dec 2024 22:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734646485;
	bh=YavK3e9o6ZeYvS9H+BxSrYkff+uIlz64SNHDiq6xHCM=;
	h=From:To:Cc:Subject:Date:From;
	b=cCYDdsDy0w6isODk2LKPaZx744RMi+NxSDDv5IITTfKKpdaR8q6u16qduOba6T2qr
	 efH6F1MSdZ44mTEyvJHCAFxXtpDZ4oYCDGirHEViAJfpdsNKCddzDgD7dOmjJJRRAo
	 3eUTvsYZtliZch6WkMFhOYVK1v4I7dadBwxDO0KIfaEme6oeejoVCwhcVZCmSxrtGB
	 A1jAgm1MtiL2k7qGTRHp403F45Vd5h2iJyBuq5lTrsIjdToM3V1BSkcv4sHbWLxCBT
	 An0IXr5d3rzC+sxq1GnkVMxzodSiKcaOVLSjypQplDRyIgoiMK3QV+fDehkom+ybWZ
	 ANjXjTfXehFYA==
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
Subject: [PATCH v7 bpf-next 0/7] Enable writing xattr from BPF programs
Date: Thu, 19 Dec 2024 14:14:32 -0800
Message-ID: <20241219221439.2455664-1-song@kernel.org>
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
 kernel/bpf/verifier.c                         |  34 +--
 net/core/filter.c                             |  49 +++-
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   5 +
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 162 +++++++++++-
 .../selftests/bpf/progs/test_get_xattr.c      |  28 +-
 .../bpf/progs/test_set_remove_xattr.c         | 133 ++++++++++
 13 files changed, 742 insertions(+), 63 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_set_remove_xattr.c

--
2.43.5

