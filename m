Return-Path: <bpf+bounces-64258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0892AB10ABE
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 14:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7956AC46C5
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 12:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77162D4B61;
	Thu, 24 Jul 2025 12:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmTD7YAr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C882836BF
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 12:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753361689; cv=none; b=l5DDMv5tCmGA+zce9O5/LEe2MagrRIP6NfzoS/bZ4OpPgD9RvaQOhbRqk+DHDiE/7Tjd4+a1LAnUmRDG71BuFYK5zkpbCLnEfiZB8w772Qr5VY3c7emx4M6X854LQMRDgwfSzAU1Gr8gDPP54t+XPs9mANbVmVznKLLbwmALkcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753361689; c=relaxed/simple;
	bh=+9wf1dwnXePoVLI1ZZNmruynW1FsZaf+kHgnDe27s3Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VPNTumJ6QQNcLDJ5oUjFE6Y0xwtWYDfiuWnrWI/YOh3zzJL2JS2537a/ojv7JCsCDfJjPojltbVhLyYpr5Sf6JvioDnQaOs45v/w6hFoxi1ukt/JlWQIx9VW5fSkV5U0hK1bPy/3+e83IpM83AYSh5Wf0DpEyVhSAAbeo5CqHlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmTD7YAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E03C4CEED;
	Thu, 24 Jul 2025 12:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753361688;
	bh=+9wf1dwnXePoVLI1ZZNmruynW1FsZaf+kHgnDe27s3Q=;
	h=From:To:Subject:Date:From;
	b=PmTD7YArB8BjDGFguLhLapEQ5nXTzmeOCcVg+DFlRfVpK5xspOjxuo8u+xLGkXNRU
	 hcqquYtnccKNfcbrUlgthuTn3oZkisfRxSzdeLlIo1fu74KCDQxY2JfLzpqmQ1VnhU
	 eauwGpTOpPmEv6ukGc4PsWhW/VFCazPjSK18UQbr2NGogU8hmd6qNJzoQUMwZ/8MUZ
	 90GT8mNB3Dr08pkNkol0vf0/nW4cpG+BNc8wC9j67yKI9HcFOohCf1lbdIFSBD9cFm
	 e4nyB56Eqml3qnzHbkwxQZjDvi4LNC+wZE4urxVmU9xNQUl010Xy61UniF/2hqDyp1
	 R3TSBtCW3bxWA==
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
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 0/2] bpf, arm64: support for timed may_goto
Date: Thu, 24 Jul 2025 12:54:38 +0000
Message-ID: <20250724125443.26182-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This set adds support for the timed may_goto instruction for the arm64.
The timed may_goto instruction is implemented by the verifier by
reserving 2 8byte slots in the program stack and then calling
arch_bpf_timed_may_goto() in a loop with the stack offset of these two
slots in BPF_REG_AX. It expects the function to put a timestamp in the
first slot and the returned count in BPF_REG_AX is put into the second
slot by a store instruction emitted by the verifier.

arch_bpf_timed_may_goto() is special as it receives the parameter in
BPF_REG_AX and is expected to return the result in BPF_REG_AX as well.
It can't clobber any caller saved registers because verifier doesn't
save anything before emitting the call.

So, arch_bpf_timed_may_goto() is implemented in assembly so the exact
registers that are stored/restored can be controlled (BPF caller saved
registers here) and it also needs to take care of moving arguments and
return values to and from BPF_REG_AX <-> arm64 R0. 

So, arch_bpf_timed_may_goto() acts as a trampoline to call
bpf_check_timed_may_goto() which does the main logic of placing the
timestamp and returning the count.

All tests that use may_goto instruction pass after the changing some of
them in patch 2

 #404     stream_errors:OK
 [...]
 #406/2   stream_success/stream_cond_break:OK
 [...]
 #494/23  verifier_bpf_fastcall/may_goto_interaction_x86_64:SKIP
 #494/24  verifier_bpf_fastcall/may_goto_interaction_arm64:OK
 [...]
 #539/1   verifier_may_goto_1/may_goto 0:OK
 #539/2   verifier_may_goto_1/batch 2 of may_goto 0:OK
 #539/3   verifier_may_goto_1/may_goto batch with offsets 2/1/0:OK
 #539/4   verifier_may_goto_1/may_goto batch with offsets 2/0:OK
 #539     verifier_may_goto_1:OK
 #540/1   verifier_may_goto_2/C code with may_goto 0:OK
 #540     verifier_may_goto_2:OK
 Summary: 7/16 PASSED, 25 SKIPPED, 0 FAILED

Puranjay Mohan (2):
  bpf, arm64: Add JIT support for timed may_goto
  selftests/bpf: Enable timed may_goto tests for arm64

 arch/arm64/net/Makefile                       |  2 +-
 arch/arm64/net/bpf_jit_comp.c                 | 13 ++++++-
 arch/arm64/net/bpf_timed_may_goto.S           | 36 +++++++++++++++++++
 .../testing/selftests/bpf/prog_tests/stream.c |  2 +-
 .../bpf/progs/verifier_bpf_fastcall.c         | 27 ++++++++------
 .../selftests/bpf/progs/verifier_may_goto_1.c | 34 ++++--------------
 6 files changed, 72 insertions(+), 42 deletions(-)
 create mode 100644 arch/arm64/net/bpf_timed_may_goto.S

-- 
2.47.3


