Return-Path: <bpf+bounces-47349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A43A9F85CF
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 21:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A69A188ABA7
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 20:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488901B4F25;
	Thu, 19 Dec 2024 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHEmC3OW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78825383;
	Thu, 19 Dec 2024 20:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639952; cv=none; b=jcxvqvhbDDJSzY1m+5MVslQiBWb+Yl7k5Iy497cbplRE0uYeH3ZyjuMnTIKuoTTOkpJUorQmRr+8B/ImxMjcQUojc+mX7okIrxBoWyKtSe10Oy0/biro7ctImdU7EiorT4Xgtsi3EunSw31GP3lx9omBj/u/mYG9ddgAGBQ0sok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639952; c=relaxed/simple;
	bh=6OGXRRjINT19AQYlKYtCq2FAWsMDwPe9DbTgnysiKGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kqzm9T7kdwyOVV13Fq0X6pZlkYG3zCG1Ee4Pl+KoIqyLX/qS4YtG6X4GSqEPQLX0niARnQYfvtdAyUkBbeN+P/QpdocS+sYolJHsRgPTOo9Q7TLL28JCJCy/s52yh6qgl57v0FI9L0SCb7uHjGBRtv0qvS4lv8EIDT3yGuY8+hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHEmC3OW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E512BC4CED4;
	Thu, 19 Dec 2024 20:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734639952;
	bh=6OGXRRjINT19AQYlKYtCq2FAWsMDwPe9DbTgnysiKGk=;
	h=From:To:Cc:Subject:Date:From;
	b=fHEmC3OW0jC2jP8/9GQaJa47XpN941hzqu1nuIUDKodDVGARA8VVqlp5YX/RIp0uw
	 0/cfGc95vRwKpLDjHWAI44uoRL4re1ocnrFg+YsFTCZQCF9iNRWvGj0gVEDN2l+LES
	 1LC/qjULLyeagd1/9md5shyhXCVZ0EXaq3cigrjTow8dhkAzVV0U/uAMCu8S3Hxg7+
	 zjzuViwCuthSIaMlX4Qz9CgV9mYtIlotnKPmJV5Regrwjgu2X7oQYjE7FoNdwJS+xf
	 StqVwuzgYZ5ZzPAx9zanIDRPeOVl7DN4l+hGU93JFF5YTnOCdh4uttJkRxZj2DMpNt
	 kAjDPK814TI4Q==
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
Subject: [PATCH v6 bpf-next 0/7] Enable writing xattr from BPF programs
Date: Thu, 19 Dec 2024 12:25:29 -0800
Message-ID: <20241219202536.1625216-1-song@kernel.org>
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

 fs/bpf_fs_kfuncs.c                            | 247 +++++++++++++++++-
 include/linux/bpf_lsm.h                       |   2 +
 include/linux/btf.h                           |  20 ++
 include/linux/btf_ids.h                       |   3 +
 include/uapi/linux/xattr.h                    |   4 +
 kernel/bpf/bpf_lsm.c                          |   2 +
 kernel/bpf/btf.c                              | 117 +++++++--
 kernel/bpf/verifier.c                         |  39 ++-
 net/core/filter.c                             |  49 +++-
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   5 +
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 162 +++++++++++-
 .../selftests/bpf/progs/test_get_xattr.c      |  28 +-
 .../bpf/progs/test_set_remove_xattr.c         | 133 ++++++++++
 13 files changed, 748 insertions(+), 63 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_set_remove_xattr.c

--
2.43.5

