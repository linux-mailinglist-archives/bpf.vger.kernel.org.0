Return-Path: <bpf+bounces-66652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05314B38116
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 13:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215921BA27F6
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 11:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411762586C5;
	Wed, 27 Aug 2025 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INCd+QXq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB3F30CD82
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 11:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294370; cv=none; b=abGFOILEZvgd56qrPYU2uemNNbuDkwlaLiYzarPrTwPh61kqNNeYOmxPRKAN0W049IfpDcJ5KdmrbuHBZbOXzD/0cthWkuEvGDt2hJfz+95/HxP9FMxk4LFkNepMh/AJHWqb8w6T1qrNrEo7F0VYWODsfP7BooEaGz77wq72LRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294370; c=relaxed/simple;
	bh=QHcLKVmkcDf4yQfsqTyXyESBezqlvly734ugG500XO8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iaU1u1T4lhAeGibEWw0ZVY3gGBCXyI8hy4u53Ewo1fU9Nnk8DIbHZDrJI81a+grFoWVRvZuh/+OqKwy0/05UYle+ZdWz8aBn25ZgXMT2an7mXE3u4lHtCErL+QlGmbgHkY3/1EfaUaCFjSMWDgpwtRV4AXy+kAI1ud+V6LAzSSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INCd+QXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E609DC4CEEB;
	Wed, 27 Aug 2025 11:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756294370;
	bh=QHcLKVmkcDf4yQfsqTyXyESBezqlvly734ugG500XO8=;
	h=From:To:Subject:Date:From;
	b=INCd+QXqoSltDDJXEqzygx4xP1jZuJFehppzRM1BDEooyyptCn+nc27m0gkn4vvqE
	 FOkQP/3p5UHhta7odorxK9DuCq9LU+qZw+fcpMOjY5S1PUZ+gRfWsLOMJT9fMEI+w3
	 pgNKei8qItaitWRZzd/6tsNOL43f4w1kH9GboNR3iclGNcBqYbR4ZgV7Idd/ps64yq
	 xZmUh+DrKvyljlFxH+ja+Sf6pSH6iwzR0wYzMuG4nvqkg26ZksUdC0gmJYpZ0/7YIP
	 9Zg+bWSMCizYgU1Apn3uyOp45SRF/lhUNZ6jB0pFc/ofB/0J0qIkv5YZq6Imygr/kO
	 XIU3fgLuRf5VA==
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
Subject: [PATCH bpf-next v3 0/2] bpf, arm64: support for timed may_goto
Date: Wed, 27 Aug 2025 11:32:42 +0000
Message-ID: <20250827113245.52629-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2->v3:
v2: https://lore.kernel.org/all/20250809204833.44803-1-puranjay@kernel.org/
- Rebased on bpf-next/master
- Added Acked-by: tags from Xu and Kumar

Changes in v1->v2:
v1: https://lore.kernel.org/bpf/20250724125443.26182-1-puranjay@kernel.org/
- Added comment in arch_bpf_timed_may_goto() about BPF_REG_FP setup (Xu
  Kuohai)

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
 arch/arm64/net/bpf_jit_comp.c                 | 13 +++++-
 arch/arm64/net/bpf_timed_may_goto.S           | 40 +++++++++++++++++++
 .../testing/selftests/bpf/prog_tests/stream.c |  2 +-
 .../bpf/progs/verifier_bpf_fastcall.c         | 27 ++++++++-----
 .../selftests/bpf/progs/verifier_may_goto_1.c | 34 +++-------------
 6 files changed, 76 insertions(+), 42 deletions(-)
 create mode 100644 arch/arm64/net/bpf_timed_may_goto.S

-- 
2.47.3


