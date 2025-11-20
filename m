Return-Path: <bpf+bounces-75184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC67C765BE
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 22:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5472F4E07DA
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 21:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C300430BF58;
	Thu, 20 Nov 2025 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ivcmt+4Z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361F7309EE0;
	Thu, 20 Nov 2025 21:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763673853; cv=none; b=GdDl2+4qKW/TB7+rmPoUUT+Wo6soFZU4vWnnxxhdgKzKmblXhnTTMaINqz34iuxWIucLdHJuWPgkJyLMy3k8WxwV28w3vqb+UaImHHXqAG0zbl3kZSfOclTiWF6H3L0aZAwECC82hJoqMZPFZl89N+QU/Kk4roDLe4cRruypi7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763673853; c=relaxed/simple;
	bh=4Y8r/6ty+KwQSyf1uJgttUHp2wq+e/5lt08/NAvm/u0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S43KUHeoTGFEkwix+o7CjSibHfluF8vNGymf9414JqyayLn4yB/x47lUsvow/J0+ewH455aFhE8j/EXD2wwqO0W+rG6yaILAwyN+gzqhTPlhjSy8jMdVX8LVgOK7XFrrZWYhphqqzdzlwS/4dKtIWjOivp7SKfjMqQSjsdnukos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ivcmt+4Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B04C4CEF1;
	Thu, 20 Nov 2025 21:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763673852;
	bh=4Y8r/6ty+KwQSyf1uJgttUHp2wq+e/5lt08/NAvm/u0=;
	h=From:To:Cc:Subject:Date:From;
	b=Ivcmt+4ZsjqlDy79/NuPdPgc6lzXqtlHNT9fAgqWiK+5KvRrFRA22XrsSGL3QfCkC
	 YwYSQLEM48sZt+t2TgN8miH00hi8FmmulYFjoGwyXbHkpvmzowMpqlZ1LEeVuxMyVy
	 CLnsWPcsUAcN5YrwoFy9WPUXWKkR6uLm7NYf3sm4Eau5NfUGquwkRIKpvHM7JvAKGz
	 9cEBzzuZOqo4gFwnApCzk+/jIC/t1sAoub+McPU7/cxERjYsCf7QZSobLE6gRnD0H2
	 l8E34fJMSltjgVz8G4Ja8LVZmISycSlQiReQSZkPCDoqfuShScskP1gMPLhFfr4MB7
	 tFy94sW8tCQ6g==
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
Subject: [PATCHv3 bpf-next 0/8] ftrace,bpf: Use single direct ops for bpf trampolines
Date: Thu, 20 Nov 2025 22:23:54 +0100
Message-ID: <20251120212402.466524-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.1
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
Jiri Olsa (8):
      ftrace: Make alloc_and_copy_ftrace_hash direct friendly
      ftrace: Export some of hash related functions
      ftrace: Add update_ftrace_direct_add function
      ftrace: Add update_ftrace_direct_del function
      ftrace: Add update_ftrace_direct_mod function
      bpf: Add trampoline ip hash table
      ftrace: Factor ftrace_ops ops_func interface
      bpf, x86: Use single ftrace_ops for direct calls

 arch/x86/Kconfig        |   1 +
 include/linux/bpf.h     |   7 ++-
 include/linux/ftrace.h  |  37 +++++++++++++-
 kernel/bpf/trampoline.c | 205 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 kernel/trace/Kconfig    |   3 ++
 kernel/trace/ftrace.c   | 337 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 kernel/trace/trace.h    |   8 ---
 7 files changed, 547 insertions(+), 51 deletions(-)

