Return-Path: <bpf+bounces-74390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB487C57745
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 13:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2BDF3AC013
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 12:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9765C34D3B2;
	Thu, 13 Nov 2025 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHg4vXRN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122DB7081A;
	Thu, 13 Nov 2025 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763037493; cv=none; b=SmpFMZXxB/LlbARLXPjM4h8PFk3eLsKc9Qv0f7rH7QKRBmfb71vQ2JpXTPXY3wrh+kr2/ls1adjZ60ilrJ2+9w+CnB+soKeFA+XY/1y2bQRUi+js95LaQ5vtWSt5B2T4yrXvH/LZalh3fPq14WQzXy/BA3LWKS4b7BfBhNQQZVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763037493; c=relaxed/simple;
	bh=25tS6q1AZItoMjE4RRfXKyei13//Mr24PudR3vNckio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NVBsDqd/K1oH3Z+cFUoDBlZdyI8DXngP8Mb0Xy9NLxqGkegEBl2CgCeIynbM1ahT09C4YHlgibequWDHx8fWmsJsRGPFKG3IuPdfZ+gQ1OAdEyRod7DmFqV9NO9e/eRXbro9T7UEZOq/Nz+Um9ybu4eqQjYaDkQlMZnbwu+ASSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHg4vXRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D95AC4CEF8;
	Thu, 13 Nov 2025 12:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763037492;
	bh=25tS6q1AZItoMjE4RRfXKyei13//Mr24PudR3vNckio=;
	h=From:To:Cc:Subject:Date:From;
	b=vHg4vXRN92JvP3p4h2LoLuD1MDwBbqu4piKyhRd1tXZIkgEiDQM5YoWGSbPAjeXBN
	 UCWvWRhBdhmZ2U6eaOVNvIakAH0H26L/w3FN1lS+LdfjDR1zOYfeukkrRnMNu0twk8
	 hOOBqLyYTch3poaZMmaJ9tHotZwkxf8YbVzBIQcYmqD9jJKLqIJg5Dm/pIjW9MfcI9
	 jhqm3XxVWdUF1Leh92aQA08Au0lSPGd9uNheCbPZlrILtFxy8KxtkpjMbmgBi0tSVV
	 yQ/iufs2ppFWm8EbSJcR/90Jz7yKStgxo1jQ/s/hUV/CS8a8znVmJSbPrp99SQW3ej
	 MdkqW3BGskd8w==
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
Subject: [PATCHv2 bpf-next 0/9] ftrace,bpf: Use single direct ops for bpf trampolines
Date: Thu, 13 Nov 2025 13:37:42 +0100
Message-ID: <20251113123750.2507435-1-jolsa@kernel.org>
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
 include/linux/ftrace.h  |  37 ++++++++++++++-
 kernel/bpf/trampoline.c | 199 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 kernel/trace/Kconfig    |   3 ++
 kernel/trace/ftrace.c   | 326 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 kernel/trace/trace.h    |   8 ----
 7 files changed, 532 insertions(+), 49 deletions(-)

