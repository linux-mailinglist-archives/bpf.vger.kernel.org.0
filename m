Return-Path: <bpf+bounces-77512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B49CE9F92
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 15:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBC683025582
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 14:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC35316910;
	Tue, 30 Dec 2025 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwaVGuGs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F7F2253B0;
	Tue, 30 Dec 2025 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767106221; cv=none; b=FHEL3qZSnB02mdN1XCvPjitAhUudJaUoN3G6QoTA7AuuhAdf3dYIHsxmcBPJvc9hCEV6IN8VtuaxmTPLT1bsGV/3nl6LHQGI8s070I/uhE2+yUDwTraOIuoX8NiGLegZtMDRzz65O0wmcE9vLjEf+vuQX1fRZqGaXIyJ1XsnMNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767106221; c=relaxed/simple;
	bh=8xysnLmoKexyoy3E0mV2YzmnUunnOMQmOy2mzrTjMCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a38WrNPDH3ygDv6Xr+phi6umrIUpCe4EXeDE0F1TIcwpfgZObBMZ0+Pa/x4fPqYys/SkO9SdfmoKJ1fN7tvPjknJPC4ysoXiRqzJIuYGODXHdKMxUEtRzOEkeErRsM9MmJa/q5vHcGA1RCeIeg7se08PtIC7ZPzhvg9WJumqiRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwaVGuGs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAD1C4CEFB;
	Tue, 30 Dec 2025 14:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767106220;
	bh=8xysnLmoKexyoy3E0mV2YzmnUunnOMQmOy2mzrTjMCE=;
	h=From:To:Cc:Subject:Date:From;
	b=CwaVGuGsIxcPdLnDw48i+vYFzYBHbz5tUqfRj4fekidD/Jbn+6NbyDl7C0/UGHqFH
	 l1ED7oxuVpfMefIFTj68Hmh1QgvIctyalEYTTGj12DBqU9MNIuav3Xch8LiIz/HPPn
	 CBwKDXKe3Mj8cdtFSxYTrR3DMYploLE6TgNU/L2VjxvftjUcjdWJ8R155GawPdLXbd
	 LizkNH4nha9CwPYWbHxvkt690tvpg/rom8/ULmwopDaDysgdxRILJU3K/HfIcjv3us
	 9WMx5Ztsj23FCVNGaLSZmO/kKPKeozUaO0FbphDUyobZQO/U33jImSzTR6VtbEbtbP
	 dUJorj2HjsXxg==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>,
	Florent Revest <revest@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Song Liu <song@kernel.org>
Subject: [PATCHv6 bpf-next 0/9] ftrace,bpf: Use single direct ops for bpf trampolines
Date: Tue, 30 Dec 2025 15:50:01 +0100
Message-ID: <20251230145010.103439-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
while poking the multi-tracing interface I ended up with just one ftrace_ops
object to attach all trampolines.

This change allows to use less direct API calls during the attachment changes
in the future code, so in effect speeding up the attachment.

In current code we get a speed up from using just a single ftrace_ops object.

- with current code:

  Performance counter stats for 'bpftrace -e fentry:vmlinux:ksys_* {} -c true':

     6,364,157,902      cycles:k
       828,728,902      cycles:u
     1,064,803,824      instructions:u                   #    1.28  insn per cycle
    23,797,500,067      instructions:k                   #    3.74  insn per cycle

       4.416004987 seconds time elapsed

       0.164121000 seconds user
       1.289550000 seconds sys


- with the fix:

   Performance counter stats for 'bpftrace -e fentry:vmlinux:ksys_* {} -c true':

     6,535,857,905      cycles:k
       810,809,429      cycles:u
     1,064,594,027      instructions:u                   #    1.31  insn per cycle
    23,962,552,894      instructions:k                   #    3.67  insn per cycle

       1.666961239 seconds time elapsed

       0.157412000 seconds user
       1.283396000 seconds sys



The speedup seems to be related to the fact that with single ftrace_ops object
we don't call ftrace_shutdown anymore (we use ftrace_update_ops instead) and
we skip the synchronize rcu calls (each ~100ms) at the end of that function.

rfc: https://lore.kernel.org/bpf/20250729102813.1531457-1-jolsa@kernel.org/
v1:  https://lore.kernel.org/bpf/20250923215147.1571952-1-jolsa@kernel.org/
v2:  https://lore.kernel.org/bpf/20251113123750.2507435-1-jolsa@kernel.org/
v3:  https://lore.kernel.org/bpf/20251120212402.466524-1-jolsa@kernel.org/
v4:  https://lore.kernel.org/bpf/20251203082402.78816-1-jolsa@kernel.org/
v5:  https://lore.kernel.org/bpf/20251215211402.353056-10-jolsa@kernel.org/

v6 changes:
- rename add_hash_entry_direct to add_ftrace_hash_entry_direct [Steven]
- factor hash_add/hash_sub [Steven]
- add kerneldoc header for update_ftrace_direct_* functions [Steven]
- few assorted smaller fixes [Steven]
- added missing direct_ops wrappers for !CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
  case [Steven]

v5 changes:
- do not export ftrace_hash object [Steven]
- fix update_ftrace_direct_add new_filter_hash leak [ci]

v4 changes:
- rebased on top of bpf-next/master (with jmp attach changes)
  added patch 1 to deal with that
- added extra checks for update_ftrace_direct_del/mod to address
  the ci bot review

v3 changes:
- rebased on top of bpf-next/master
- fixed update_ftrace_direct_del cleanup path
- added missing inline to update_ftrace_direct_* stubs

v2 changes:
- rebased on top fo bpf-next/master plus Song's livepatch fixes [1] 
- renamed the API functions [2] [Steven]
- do not export the new api [Steven]
- kept the original direct interface:

  I'm not sure if we want to melt both *_ftrace_direct and the new interface
  into single one. It's bit different in semantic (hence the name change as
  Steven suggested [2]) and I don't think the changes are not that big so
  we could easily keep both APIs.

v1 changes:
- make the change x86 specific, after discussing with Mark options for
  arm64 [Mark]

thanks,
jirka


[1] https://lore.kernel.org/bpf/20251027175023.1521602-1-song@kernel.org/
[2] https://lore.kernel.org/bpf/20250924050415.4aefcb91@batman.local.home/
---
Jiri Olsa (9):
      ftrace,bpf: Remove FTRACE_OPS_FL_JMP ftrace_ops flag
      ftrace: Make alloc_and_copy_ftrace_hash direct friendly
      ftrace: Export some of hash related functions
      ftrace: Add update_ftrace_direct_add function
      ftrace: Add update_ftrace_direct_del function
      ftrace: Add update_ftrace_direct_mod function
      bpf: Add trampoline ip hash table
      ftrace: Factor ftrace_ops ops_func interface
      bpf,x86: Use single ftrace_ops for direct calls

 arch/x86/Kconfig        |   1 +
 include/linux/bpf.h     |   7 ++-
 include/linux/ftrace.h  |  31 +++++++++-
 kernel/bpf/trampoline.c | 259 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------
 kernel/trace/Kconfig    |   3 +
 kernel/trace/ftrace.c   | 406 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 6 files changed, 632 insertions(+), 75 deletions(-)

