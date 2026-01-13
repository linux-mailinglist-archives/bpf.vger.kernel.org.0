Return-Path: <bpf+bounces-78725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 352FDD19DF8
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 16:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DFE1302D2E7
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 15:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFC5387379;
	Tue, 13 Jan 2026 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJNH8+Ur"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FC91DEFE9
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768317944; cv=none; b=HybPqPXaWlpwxyA9aAV8yxN6ZrpN+MG/yMyXzb9pUkOWYx7EdnwiMejtb5ZDrCAraRboYQvXWtcEdAR6qIXmc4d9DZf+DQD1dpjLmSA20OcijabM5QLTABqvIlAzWE4bhBtd1RgAIomwoVLu7dJkyesUJqYK6hEeW+D0foEmg+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768317944; c=relaxed/simple;
	bh=KVAflsCi2hvOBSwDYxTy2dQcMB8BWaU043FEgk8NU2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tdAi+PONngTBBXZrGiWYkFGvl+uGnrITiutwZka0q073o8U0gLsDFWMrda+vRAXwlfU6V0fFhZHPhbTsyu4SHP4AleLkidEW/1IyEIcED8WUgqwsWS3YDFuvAvSbRv/7++rMRHjtjU3C9IQZYghsER6yll0YBDltLgIrYSO65rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJNH8+Ur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A477C19421;
	Tue, 13 Jan 2026 15:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768317943;
	bh=KVAflsCi2hvOBSwDYxTy2dQcMB8BWaU043FEgk8NU2g=;
	h=From:To:Cc:Subject:Date:From;
	b=TJNH8+UrBhYBBSru3EZJ8+1ElEdtDkWGUK/m4jbwhxj14GEbhV/1afhoIQSKkN9bQ
	 kR6KL/vjPBf44N91W7vqL6k6ArwpioraM2OcTkhLAoY67KhYiYg4Q/Pup+zp6sHHOl
	 JJYVpsgPXh4ZehlEXsSRYw/yUADd4Uu/ifRX6G/7NZiiGgcw397FMjpNZoQqELqrEj
	 0irPOjt00SdPP7oGabvmUjyEZY+M2t/9aRqijLJ7NkJFjPvKTiflOXeikQomAVkAhp
	 5HU2fgrakZ2HoXs27j4QLxmq9zC3Xd8Na7aXj4FqvfDpUsgaNKp9NenHikeW7pGDi7
	 NEnvxHhYayPWQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/2]  bpf: Improve linked register tracking
Date: Tue, 13 Jan 2026 07:25:24 -0800
Message-ID: <20260113152529.3217648-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series extends the BPF verifier's linked register tracking to handle
negative offsets, BPF_SUB operations, and alu32 operations, enabling better bounds propagation for
common arithmetic patterns.

The verifier previously only tracked positive constant deltas between linked
registers using BPF_ADD. This meant patterns using negative offsets or
subtraction couldn't benefit from bounds propagation:

  r1 = r0
  r1 += -4
  if r1 s>= 0 goto ...   // r1 >= 0 implies r0 >= 4
  // verifier couldn't propagate bounds back to r0

Verifier also couldn't detect such patterns with ALU32 operations.

I ran veristat before and after this change on cpuv4 selftests, sched_ext programs, and meta internal BPF programs, here is the difference:

selftests:
----------
./veristat -C -e file,prog,states,insns -f "insns_pct>5" self_before.csv self_after.csv
File                                Program                 States (A)  States (B)  States (DIFF)  Insns (A)  Insns (B)  Insns   (DIFF)
----------------------------------  ----------------------  ----------  ----------  -------------  ---------  ---------  --------------
bpf_cubic.bpf.o                     bpf_cubic_acked                 21          38  +17 (+80.95%)        237        420  +183 (+77.22%)
iters.bpf.o                         iter_obfuscate_counter           8          14   +6 (+75.00%)         83        164   +81 (+97.59%)
linked_list_peek.bpf.o              list_peek                       16           9   -7 (-43.75%)        152         88   -64 (-42.11%)
verifier_iterating_callbacks.bpf.o  cond_break2                     13          10   -3 (-23.08%)        110         88   -22 (-20.00%)
verifier_iterating_callbacks.bpf.o  test4                            2           4  +2 (+100.00%)         20         32   +12 (+60.00%)

sched_ext:
----------
./veristat/src/veristat -C -e file,prog,states,insns -f "insns_pct>5" scx_before.csv scx_after.csv
File               Program           States (A)  States (B)  States (DIFF)  Insns (A)  Insns (B)  Insns  (DIFF)
-----------------  ----------------  ----------  ----------  -------------  ---------  ---------  -------------
scx_layered.bpf.o  layered_runnable         359         381   +22 (+6.13%)       5674       6077  +403 (+7.10%)
scx_p2dq.bpf.o     p2dq_dispatch            197         208   +11 (+5.58%)       1948       2065  +117 (+6.01%)

FB programs saw the most diff (used insns_pct>20 here to output fewer lines :
-----------------------------------------------------------------------------
./veristat/src/veristat -C -e file,prog,states,insns -f "insns_pct>20" fb_before.csv fb_after.csv
File                                               Program           States (A)  States (B)  States   (DIFF)  Insns (A)  Insns (B)  Insns     (DIFF)
-------------------------------------------------  ----------------  ----------  ----------  ---------------  ---------  ---------  ----------------
bpfjailer-lib-tests-bpf-dbus_test-dbus_test.bpf.o    do_parse          6019        7631      +1612 (+26.78%)     124809     151707  +26898 (+21.55%)
bpfjailer-lib-tests-bpf-dbus_test-dbus_test.bpf.o    do_sendmsg        6020        7632      +1612 (+26.78%)     124823     151721  +26898 (+21.55%)
third-party-scx-6.9-scheds-rust-scx_layered-bpf_    layered_runnable   125         148        +23 (+18.40%)       1940       2381    +441 (+22.73%)
third-party-scx-backports-6.9-1.0.11.1-scheds-r     layered_runnable   133         155        +22 (+16.54%)       1700       2152    +452 (+26.59%)
third-party-scx-backports-6.9-1.0.8-scheds-rust     layered_runnable   114         136        +22 (+19.30%)       1499       1951    +452 (+30.15%)

v1: https://lore.kernel.org/bpf/20260107203941.1063754-1-puranjay@kernel.org/
Changes in v1->v2:
- Add support for alu32 operations in linked register tracking (Alexei)
- Squash the selftest fix with the first patch (Eduard)
- Add more selftests to detect edge cases

Puranjay Mohan (2):
  bpf: Support negative offsets, BPF_SUB, and alu32 for linked register
    tracking
  selftests/bpf: Add tests for improved linked register tracking

 include/linux/bpf_verifier.h                  |   8 +-
 kernel/bpf/verifier.c                         |  39 ++-
 .../selftests/bpf/progs/verifier_bounds.c     |   2 +-
 .../bpf/progs/verifier_linked_scalars.c       | 232 +++++++++++++++++-
 4 files changed, 265 insertions(+), 16 deletions(-)


base-commit: 9c1a3525fd64839d71e0c1a21170003a4621e6e8
-- 
2.47.3


