Return-Path: <bpf+bounces-64609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E60AAB14C21
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 12:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E63218A10C6
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 10:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C323C289838;
	Tue, 29 Jul 2025 10:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mV11jTfE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A4E22539E;
	Tue, 29 Jul 2025 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753784899; cv=none; b=fAPaOP7C48+xmLkxy6oyyLfbMFK2CJWJzKV7SxBEVpEzbg6IwO666BONltFxq96j2oq1Qj4H07hZLCgDMCpXGEcoD0gDWJoDGgGCNn4IgZdgKX86I0Z7CJaDQD708H+LwOZ1NOvFcDoiQy5effqfutoQweLwcInXF693lDyuLJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753784899; c=relaxed/simple;
	bh=OdjL2rd1addmR1OyPctySgVMlUNEtBw1AyeTREwXlmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=op1hnF3yQyWGB344uCI8+WA6YjiVZRr8ARCOfkh8mFUpXWpWcQJQEIFgVvwL1/UzW5WlmIVd14gaPfTArsNdZzF01Kpwl5zXOPTMBn/r0XY21duKWirxi+9dajKSwb6+dJfKv9T9TAHxG+n+HGfZeGEr3gHUYo1ngcWXlZzb2k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mV11jTfE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC27EC4CEF5;
	Tue, 29 Jul 2025 10:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753784898;
	bh=OdjL2rd1addmR1OyPctySgVMlUNEtBw1AyeTREwXlmQ=;
	h=From:To:Cc:Subject:Date:From;
	b=mV11jTfEzIy7cXmLJFY4fmn7U37r6DX9yP3lmPbtt5dwSA8KG2y8881YwOB9Ph2Yy
	 VIUnsq5ImkMQynvHIL+M/tHcOdifQU+3r3vVSx+LLvxK09rlboMz57EWaRtXTL9JTb
	 pcuU3wegX6QusUMJ+C2DHhigdbSxGlGAucMF6Lf7U84UYBDKqCXCNAnzEL3tiQvLLa
	 C3Ipovo2vCe4hCQ3YVczf3Lq7eZCZme3EWVq+b4a42V/p4hEdCnTm+nFwbbiati9CO
	 LM0tmHvSAf1ANu0mhOSLoCrNUJn2zy2UZZyI+Sp6Lq26SVD+mG8GU/+Ez0PIp5IJd4
	 JWL2XmaqlEdHw==
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
Subject: [RFC 00/10] ftrace,bpf: Use single direct ops for bpf trampolines
Date: Tue, 29 Jul 2025 12:28:03 +0200
Message-ID: <20250729102813.1531457-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
while poking the multi-tracing interface I ended up with just one
ftrace_ops object to attach all trampolines.

This change allows to use less direct API calls during the attachment
changes in the future code, so in effect speeding up the attachment.

However having just single ftrace_ops object removes direct_call
field from direct_call, which is needed by arm, so I'm not sure
it's the right path forward.

Mark, Florent,
any idea how hard would it be to for arm to get rid of direct_call field?

thougts? thanks,
jirka


---
Jiri Olsa (10):
      ftrace: Make alloc_and_copy_ftrace_hash direct friendly
      ftrace: Add register_ftrace_direct_hash function
      ftrace: Add unregister_ftrace_direct_hash function
      ftrace: Add modify_ftrace_direct_hash function
      ftrace: Export some of hash related functions
      ftrace: Use direct hash interface in direct functions
      bpf: Add trampoline ip hash table
      ftrace: Factor ftrace_ops ops_func interface
      bpf: Remove ftrace_ops from bpf_trampoline object
      Revert "ftrace: Store direct called addresses in their ops"

 include/linux/bpf.h           |   8 +-
 include/linux/ftrace.h        |  51 ++++++++++---
 kernel/bpf/trampoline.c       |  94 +++++++++++++-----------
 kernel/trace/ftrace.c         | 481 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------
 kernel/trace/trace.h          |   8 --
 kernel/trace/trace_selftest.c |   5 +-
 6 files changed, 395 insertions(+), 252 deletions(-)

