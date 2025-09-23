Return-Path: <bpf+bounces-69482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CEEB97A2B
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 23:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEFEB1AE0BA7
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 21:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2525F30E851;
	Tue, 23 Sep 2025 21:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gz0GSTbB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975D527A44A;
	Tue, 23 Sep 2025 21:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664318; cv=none; b=EDbEDez2FcoKzt34+e5GAXcwL8Jb0Q1vPQsKGLlVfysJ6FnghMygDhu6OHIj4gRKgusxEWnknrfvVvt4yguzn18u12YjqLNquQ3Koskyh8bovp4SN7QWFyA3yr+Mr+ITU4O/rZlgMRCqFt9SlLtt2Z+DJZxqzehplD1Xlmq7rUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664318; c=relaxed/simple;
	bh=p2j7MDsIv5UEmLCpN5Vf/Kx8rWPcuDGKJUfRsR6Fgkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mUEpsf1hkcPJisyW5GFd6VMGuiFKq4Zk7rAmwG17oxYVNpp3CoyKeanoq/AcO6THJO+Q6se88yYEdiOSkn5L1n215fs7nke+auNasd80yzVuqz3zPdalcooICLqp35SpoBj0SGiCt1WKpWlyDouToJndzShlFypGr2yE3wedJvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gz0GSTbB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17100C4CEF5;
	Tue, 23 Sep 2025 21:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758664318;
	bh=p2j7MDsIv5UEmLCpN5Vf/Kx8rWPcuDGKJUfRsR6Fgkg=;
	h=From:To:Cc:Subject:Date:From;
	b=Gz0GSTbB02KXVz5VBCKMOLCJc+mR5coG9Hi1m9fmyC0VshtTZnnTWoKpWSv8a5hAb
	 9Gdcds0jdc9fdeD5raXVOl21kwSXZOHzMVE10slAMpd7mTs6y8B5EjVaodfFL+lK6J
	 1c3vjMF2SPnDu9Is7KyOrZniH2/ixR8lthGpguoigVXiB6M8K/Ln+grYzZ0uDoMd2C
	 Up0ippNga6koLTUJiFK6iASoV8F92hsOGRnjtKfojAzUs734K2wYwXZikPMSmW2vuj
	 dP07UlmnrAzSh89p9PAEKpc0HnrEg6kEzsNm65MAZQUM3OTS7FS0rfqJTeSlp9YdeC
	 jsmLp4WylgRrw==
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
	Menglong Dong <menglong8.dong@gmail.com>
Subject: [PATCH 0/9] ftrace,bpf: Use single direct ops for bpf trampolines
Date: Tue, 23 Sep 2025 23:51:38 +0200
Message-ID: <20250923215147.1571952-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
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
I got following speed up when measuring simple attach/detach 300 times [1].

- with current code:

  perf stat -e cycles:k,cycles:u,instructions:u,instructions:k -- ./test_progs -t krava -w0
  #158     krava:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

  Performance counter stats for './test_progs -t krava -w0':

     12,003,420,519      cycles:k                                                       
         63,239,794      cycles:u                                                       
        102,155,625      instructions:u                   #    1.62  insn per cycle     
     11,614,183,764      instructions:k                   #    0.97  insn per cycle     

       35.448142362 seconds time elapsed

        0.011032000 seconds user
        2.478243000 seconds sys


- with the fix:

  perf stat -e cycles:k,cycles:u,instructions:u,instructions:k -- ./test_progs -t krava -w0
  #158     krava:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

  Performance counter stats for './test_progs -t krava -w0':

     14,327,218,656      cycles:k                                                       
         46,285,275      cycles:u                                                       
        102,125,592      instructions:u                   #    2.21  insn per cycle     
     14,620,692,457      instructions:k                   #    1.02  insn per cycle     

        2.860883990 seconds time elapsed

        0.009884000 seconds user
        2.777032000 seconds sys


The speedup seems to be related to the fact that with single ftrace_ops object
we don't call ftrace_shutdown anymore (we use ftrace_update_ops instead) and
we skip the 300 synchronize rcu calls (each ~100ms) at the end of that function.

v1 changes:
- make the change x86 specific, after discussing with Mark options for
  arm64 [Mark]

thanks,
jirka


[1] https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?h=test&id=1b7fc74c36a93e90816f58c37a84522f0949095a
---
Jiri Olsa (9):
      ftrace: Make alloc_and_copy_ftrace_hash direct friendly
      ftrace: Add register_ftrace_direct_hash function
      ftrace: Add unregister_ftrace_direct_hash function
      ftrace: Add modify_ftrace_direct_hash function
      ftrace: Export some of hash related functions
      ftrace: Use direct hash interface in direct functions
      bpf: Add trampoline ip hash table
      ftrace: Factor ftrace_ops ops_func interface
      bpf, x86: Use single ftrace_ops for direct calls

 arch/x86/Kconfig              |   1 +
 include/linux/bpf.h           |   7 +-
 include/linux/ftrace.h        |  48 ++++++++++---
 kernel/bpf/trampoline.c       | 128 +++++++++++++++++++++++++--------
 kernel/trace/Kconfig          |   3 +
 kernel/trace/ftrace.c         | 477 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------
 kernel/trace/trace.h          |   8 ---
 kernel/trace/trace_selftest.c |   5 +-
 8 files changed, 447 insertions(+), 230 deletions(-)

