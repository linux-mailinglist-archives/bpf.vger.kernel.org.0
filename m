Return-Path: <bpf+bounces-53121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE80DA4CE3B
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 23:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03C3C7A8DCF
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 22:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B0D23814F;
	Mon,  3 Mar 2025 22:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GlKkRPmy"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA891F0E5B;
	Mon,  3 Mar 2025 22:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040678; cv=none; b=hRanXVnesaOZuxFJ13pKinvtDUI59xWjwPaaHx6RV+ji3UwCz9isK0YSqHvlF1GidEo0f8AEWUAiUkXaazGgYE0+SbPatxtL+/IFc+bTMzGwVIWHJYtTVZmYwoisIVt5/Bmj4AdQ8gfM1mU9MYVX0El3SWNn3ob/W/O3bTcgYEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040678; c=relaxed/simple;
	bh=SaNxT4G3peWWAdisrKpx0p2x4jH98gYd2FM4Hy56mgQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bkGrgug9AiqqHT6DmsxURFG+7RJivlJ6qOSqJCSIX/a9AgT0pBcuuDpvjB7sFmbtd04cGsOW0d1hSiDCsXEy9+b/jm4w+77vXJG7hx+uV9yve/Jwy0EwDa4I96dvbqG44b70KOfE9ma2oYySMQxm6jKFJVeiIUW6XRk6emIk1s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GlKkRPmy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id E91F02110486;
	Mon,  3 Mar 2025 14:24:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E91F02110486
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741040676;
	bh=hwTZqZPuxCEL290JXbO8DS7toEDrCkSnLhZ5WPM1hvY=;
	h=From:To:Subject:Date:From;
	b=GlKkRPmyU48gE3YpgV7lYsj1NrnTod/1A21ycg8bIS9BQqQOXvAKueBYn2t17yTnX
	 OtucV5CFcLwn+pFpjvJaRtcqjmLuY00VLUofepI1csXB9Lo/jDHzrkf7StuZl9jnCY
	 wd71kpKLDX8SELNDg7wUtCZw6IM1rGtaL3tGbizU=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	selinux@vger.kernel.org,
	bboscaccy@linux.microsoft.com
Subject: [PATCH 0/1 v3] security: Propagate caller information in bpf hooks
Date: Mon,  3 Mar 2025 14:24:03 -0800
Message-ID: <20250303222416.3909228-1-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

While trying to implement an eBPF gatekeeper program, we ran into an
issue whereas the LSM hooks are missing some relevant data.

Certain subcommands passed to the bpf() syscall can be invoked from
either the kernel or userspace. Additionally, some fields in the
bpf_attr sruct contain pointers, and depending on where the subcommand
was invoked, could point to either user or kernel memory. One example
of this, is the bpf_prog_load subcommand and it's fd_array.  This data
is made available and used by the verifier, but not made available to
the LSM subsystem. This patchset simply exposes that information to
applicable LSM hooks.


Change list:
- v2 -> v3
  - reorder params so that the new boolean flag is the last param
  - fixup function signatures in bpf selftests
- v1 -> v2
  - Pass a boolean flag in lieu of bpfptr_t

Revisions:
- v2
  https://lore.kernel.org/bpf/20250228165322.3121535-1-bboscaccy@linux.microsoft.com/
- v1
  https://lore.kernel.org/bpf/20250226003055.1654837-1-bboscaccy@linux.microsoft.com/


Blaise Boscaccy (1):
  security: Propagate caller information in bpf hooks

 include/linux/lsm_hook_defs.h                     |  6 +++---
 include/linux/security.h                          | 12 ++++++------
 kernel/bpf/syscall.c                              | 10 +++++-----
 security/security.c                               | 15 +++++++++------
 security/selinux/hooks.c                          |  6 +++---
 tools/testing/selftests/bpf/progs/rcu_read_lock.c |  3 ++-
 .../selftests/bpf/progs/test_cgroup1_hierarchy.c  |  4 ++--
 .../selftests/bpf/progs/test_kfunc_dynptr_param.c |  6 +++---
 .../testing/selftests/bpf/progs/test_lookup_key.c |  2 +-
 .../selftests/bpf/progs/test_ptr_untrusted.c      |  2 +-
 .../selftests/bpf/progs/test_task_under_cgroup.c  |  2 +-
 .../selftests/bpf/progs/test_verify_pkcs7_sig.c   |  2 +-
 12 files changed, 37 insertions(+), 33 deletions(-)

-- 
2.48.1


