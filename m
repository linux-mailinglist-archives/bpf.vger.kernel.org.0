Return-Path: <bpf+bounces-53234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 259F6A4EE65
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 21:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51583175206
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 20:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D488925F793;
	Tue,  4 Mar 2025 20:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XPOvUKPQ"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B3E1F8BCC;
	Tue,  4 Mar 2025 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741120301; cv=none; b=MHnmmcxeBJSsGqfm42Kqeuq48WxjcDHUQgoSTcXFaE3LfeBXbAlKDB8rOwPbY7QJ5h4k4m0x1F50SMASbHecfVYNa/YaVU2a7LBVjR15o61RtLXhUAsbhpa8TpN8DbMQdD2KnEsVLHUJrW/yzmELzYm/aM4DVDso9WHg9N0CufU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741120301; c=relaxed/simple;
	bh=tkxBDC72eU9MCONsFx4EJyrx8Yqu/GC847nibNDT1No=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=l57qzY2wd/otuZquMkThYoEJdCib8W+RqtG4BoDMgAQISV+HKsJnK6DAO/OcyeK5urD4PnBpvlNPd9H930dMP702saEKpYTkc8pV9B3qEq4hWniPRnMco+yKa5pMQiPQP9TukK76aLj7lf40NFBIH6mYMv5rAIMHKVHBcmnTDEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XPOvUKPQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id D577C210EAF0;
	Tue,  4 Mar 2025 12:31:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D577C210EAF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741120299;
	bh=+5dln2CDLel2QrL5bi52WY7oDDb4ZKz6Vy7qsxHDPVQ=;
	h=From:To:Subject:Date:From;
	b=XPOvUKPQzaFkhGBpmdtBZxuyP8g5ZnF5rEirhMBUB9x231bt6/MNtJSnUfe7DiasU
	 ije1dsOtNENEybY1JejkjPmD6YbcQv3zui3YoZ74Wv8XaoDkKIefpPpAkmfN3BySjR
	 st9RsPIGK2l4EkB8pMmzBf7dgKJ/JMeYg33zndAA=
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
Subject: [PATCH v4 bpf-next 0/2] security: Propagate caller information in bpf hooks
Date: Tue,  4 Mar 2025 12:30:48 -0800
Message-ID: <20250304203123.3935371-1-bboscaccy@linux.microsoft.com>
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
bpf_attr struct contain pointers, and depending on where the
subcommand was invoked, they could point to either user or kernel
memory. One example of this is the bpf_prog_load subcommand and its
fd_array. This data is made available and used by the verifier but not
made available to the LSM subsystem. This patchset simply exposes that
information to applicable LSM hooks.

Change list:
- v3 -> v4
  - split out selftest changes into a separate patch
- v2 -> v3
  - reorder params so that the new boolean flag is the last param
  - fixup function signatures in bpf selftests
- v1 -> v2
  - Pass a boolean flag in lieu of bpfptr_t

Revisions:
- v3
  https://lore.kernel.org/bpf/20250303222416.3909228-1-bboscaccy@linux.microsoft.com/
- v2
  https://lore.kernel.org/bpf/20250228165322.3121535-1-bboscaccy@linux.microsoft.com/
- v1
  https://lore.kernel.org/bpf/20250226003055.1654837-1-bboscaccy@linux.microsoft.com/


Blaise Boscaccy (2):
  security: Propagate caller information in bpf hooks
  selftests/bpf: Add is_kernel parameter to LSM/bpf test programs

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


