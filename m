Return-Path: <bpf+bounces-27659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E178B06CD
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 12:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B93DEB24A8C
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 10:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF041591FE;
	Wed, 24 Apr 2024 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccm86sDB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7907158D9A;
	Wed, 24 Apr 2024 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952936; cv=none; b=hdZfJ9qg7i5Mi2sVGtoTQ+XEsfwHTTS1M4k3+kATuvuzIgS3guSJQgCheJzsxmpEXByz+yp6DLenea86XQnwjAkFguC1k5Oz6jQiRAFyzEuKfh7X9DJ7vRtlBkgkamzozh4HTaM3u3ClEq/qax6mYduGvKx8lzcy9s2l83qpj2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952936; c=relaxed/simple;
	bh=auFY18YIDH3eAr8JIYORGxi3kkoujHcNT3OIr4U6g/E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rWjc/WSeZA3AbZoF3srfNR7XSJxEQAjfwaMNOlc1XuRs0O/Oe6nUv3/5kgcz2U/8ONEg5m7N2E2mnL8EjD5GCuxHbuoLnM9jSd2PA9WpRdPdEz0M/by/LfMyP0G1KeA1tCJttts7jISBAS0pRKm0dM0xEBgIxhPc3NH7grZDZmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccm86sDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42161C113CE;
	Wed, 24 Apr 2024 10:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713952935;
	bh=auFY18YIDH3eAr8JIYORGxi3kkoujHcNT3OIr4U6g/E=;
	h=From:To:Cc:Subject:Date:From;
	b=ccm86sDBB+eanMapYnGoGvq6SxoIdHZSgfO7wXEbDZ+LNO3akLLdUwu5vKon59wTM
	 z+pxwI+l/xRZqhdyXsK3PL5UlgKhHxDGk7SL2Gktp7Ohe9/KgIGGnrMuXqb6QogmIH
	 pfnbrhkoQCFWtqeHjecwzSzXgTFCEDZn8MQOB4bzh+hCpq6J9bYd7qtfny2WmkogPo
	 3uMXE7SUMo4/fwWcJngJZBW9fHSTW3A5SS/JQc5EJmcWlsmY9+YJLRcR4dtS6ogaPO
	 b9fugPnFRSNOq1aEj5UuaHXKJfFvEnlnNXEquOR6VcDEFhYbCKuWgDAIZouj0W4QAd
	 HfXlt2cdODxsQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ilya Leoshkevich <iii@linux.ibm.com>
Cc: puranjay12@gmail.com
Subject: [PATCH bpf v6 0/3] bpf: prevent userspace memory access
Date: Wed, 24 Apr 2024 10:02:07 +0000
Message-Id: <20240424100210.11982-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

V5: https://lore.kernel.org/bpf/20240324185356.59111-1-puranjay12@gmail.com/
Changes in V6:
- Disable the verifier's instrumentation in x86-64 and update the JIT to
  take care of vsyscall page in addition to userspace addresses.
- Update bpf_testmod to test for vsyscall addresses.

V4: https://lore.kernel.org/bpf/20240321124640.8870-1-puranjay12@gmail.com/
Changes in V5:
- Use TASK_SIZE_MAX + PAGE_SIZE, VSYSCALL_ADDR as userspace boundary in
  x86-64 JIT.
- Added Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

V3: https://lore.kernel.org/bpf/20240321120842.78983-1-puranjay12@gmail.com/
Changes in V4:
- Disable this feature on architectures that don't define
  CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE.
- By doing the above, we don't need anything explicitly for s390x.

V2: https://lore.kernel.org/bpf/20240321101058.68530-1-puranjay12@gmail.com/
Changes in V3:
- Return 0 from bpf_arch_uaddress_limit() in disabled case because it
  returns u64.
- Modify the check in verifier to no do instrumentation when uaddress_limit
  is 0.

V1: https://lore.kernel.org/bpf/20240320105436.4781-1-puranjay12@gmail.com/
Changes in V2:
- Disable this feature on s390x.

With BPF_PROBE_MEM, BPF allows de-referencing an untrusted pointer. To
thwart invalid memory accesses, the JITs add an exception table entry for
all such accesses. But in case the src_reg + offset is a userspace address,
the BPF program might read that memory if the user has mapped it.

x86-64 JIT already instruments the BPF_PROBE_MEM based loads with checks to
skip loads from userspace addresses, but is doesn't check for vsyscall page
because it falls in the kernel address space but is considered a userspace
page. The second patch in this series fixes the x86-64 JIT to also skip
loads from the vsyscall page. The last patch updates the bpf_testmod so
this address can be checked as part of the selftests.

Other architectures don't have the complexity of the vsyscall address and
just need to skip loads from the userspace. To make this more scalable and
robust, the verifier is updated in the first patch to instrument
BPF_PROBE_MEM to skip loads from the userspace addresses.

Puranjay Mohan (3):
  bpf: verifier: prevent userspace memory access
  bpf, x86: Fix PROBE_MEM runtime load check
  selftests/bpf: Test PROBE_MEM of VSYSCALL_ADDR on x86-64

 arch/x86/net/bpf_jit_comp.c                   | 63 +++++++++----------
 include/linux/filter.h                        |  1 +
 kernel/bpf/core.c                             |  9 +++
 kernel/bpf/verifier.c                         | 30 +++++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  3 +
 5 files changed, 74 insertions(+), 32 deletions(-)

-- 
2.40.1


