Return-Path: <bpf+bounces-73642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC06C360B8
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 15:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B27E562FB4
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 14:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4AE313E2A;
	Wed,  5 Nov 2025 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aJ83/txM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aJ83/txM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC013164BB
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352620; cv=none; b=jxL33NPDlesDOxH1qSv77txlVZL6qbLnrqjPu0LgUQNKZYi6s8XPCHozfVs/Yqu8YBO9zJdKBSRQ5RqSlE8N6fEnBIm7ctGaW7V6NaLTl+BWP52PLVw1R+zUmr17PthBIVLSDXy0iqroYg3riVI+LEAV1nPpvoqVS6aT9qUg6VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352620; c=relaxed/simple;
	bh=0uWkxySb4X3qkV+td4fhoYDyaOL1Qzpqc5FJ1Y4C/Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pn3Sbvk2nKcBr7urvOQyzX0WGbTLF65TGHq0XaARhPC9PtKWPluXpzRISe3qXniY/ZNSdbhfZyga7Zb0B/5E57TPxssRXegVisilVGEvuU7/Ok9ki6Trb+PIIeF3VuhBJULAUQp8CFQGOJINqUuqQwMgIB5iS8SdWo8vw5K6KxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aJ83/txM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aJ83/txM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from pathway.suse.cz (unknown [10.100.201.202])
	by smtp-out2.suse.de (Postfix) with ESMTP id E4D691F6E6;
	Wed,  5 Nov 2025 14:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762352616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=igxPkPyQv/i/dh0I1jeBfwiP1p+UZo7J0NJEx4Op+Sk=;
	b=aJ83/txMgw60fL64t8Rt9TgcHE13k6sNObgO3cwPscsenZHBO02u8O9+qmNHyRPNaVnEuB
	AAGzuBbXFgj4obAL+EIw70JwqHmyGMFkvm5ycOzLR1Sg47oK+hr/rNvrYuEz4Ejk0ERyA8
	HLopP/LFqaSKT/6Lbwwoer0iu6ng23k=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762352616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=igxPkPyQv/i/dh0I1jeBfwiP1p+UZo7J0NJEx4Op+Sk=;
	b=aJ83/txMgw60fL64t8Rt9TgcHE13k6sNObgO3cwPscsenZHBO02u8O9+qmNHyRPNaVnEuB
	AAGzuBbXFgj4obAL+EIw70JwqHmyGMFkvm5ycOzLR1Sg47oK+hr/rNvrYuEz4Ejk0ERyA8
	HLopP/LFqaSKT/6Lbwwoer0iu6ng23k=
From: Petr Mladek <pmladek@suse.com>
To: Petr Pavlu <petr.pavlu@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 0/6] kallsyms: Prevent invalid access when showing module buildid
Date: Wed,  5 Nov 2025 15:23:12 +0100
Message-ID: <20251105142319.1139183-1-pmladek@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[iogearbox.net,gmail.com,kernel.org,arm.com,google.com,vger.kernel.org,suse.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spam-Level: 

We have seen nested crashes in __sprint_symbol(), see below. They seems
to be caused by invalid pointer to "buildid".

I made an audit of __sprint_symbol() and found several situations
when the buildid might be wrong:

  + bpf_address_lookup() does not set @modbuildid

  + ftrace_mod_address_lookup() does not set @modbuildid

  + __sprint_symbol() does not take rcu_read_lock and
    the related struct module might get removed before
    mod->build_id is printed.

This patchset solves these problems:

  + 1st, 2nd patches are preparatory
  + 3rd, 4th, 6th patches fix the above problems
  + 5th patch cleans up a suspicious initialization code.

This is the backtrace, we have seen. But it is not really important.
The problems fixed by the patchset are obvious:

  crash64> bt [62/2029]
  PID: 136151 TASK: ffff9f6c981d4000 CPU: 367 COMMAND: "btrfs"
  #0 [ffffbdb687635c28] machine_kexec at ffffffffb4c845b3
  #1 [ffffbdb687635c80] __crash_kexec at ffffffffb4d86a6a
  #2 [ffffbdb687635d08] hex_string at ffffffffb51b3b61
  #3 [ffffbdb687635d40] crash_kexec at ffffffffb4d87964
  #4 [ffffbdb687635d50] oops_end at ffffffffb4c41fc8
  #5 [ffffbdb687635d70] do_trap at ffffffffb4c3e49a
  #6 [ffffbdb687635db8] do_error_trap at ffffffffb4c3e6a4
  #7 [ffffbdb687635df8] exc_stack_segment at ffffffffb5666b33
  #8 [ffffbdb687635e20] asm_exc_stack_segment at ffffffffb5800cf9
  #9 [ffffbdb687635ea8] hex_string at ffffffffb51b3b61
  #10 [ffffbdb687635ef8] vsnprintf at ffffffffb51b7291
  #11 [ffffbdb687635f50] sprintf at ffffffffb51b7541
  #12 [ffffbdb687635fb8] __sprint_symbol at ffffffffb4d849d6
  #13 [ffffbdb687636018] symbol_string at ffffffffb51b4588
  #14 [ffffbdb687636168] vsnprintf at ffffffffb51b7291
  #15 [ffffbdb6876361c0] vscnprintf at ffffffffb51b73b9
  #16 [ffffbdb6876361d0] printk_sprint at ffffffffb4d2ae82
  #17 [ffffbdb6876361f8] vprintk_store at ffffffffb4d2d06d
  #18 [ffffbdb6876362c8] vprintk_emit at ffffffffb4d2d1bf
  #19 [ffffbdb687636308] printk at ffffffffb565e5ce
  #20 [ffffbdb687636370] show_trace_log_lvl at ffffffffb4c42374
  #21 [ffffbdb687636478] __die_body at ffffffffb4c426ca
  #22 [ffffbdb687636498] die at ffffffffb4c42778
  #23 [ffffbdb6876364c0] do_trap at ffffffffb4c3e49a
  #24 [ffffbdb687636508] do_error_trap at ffffffffb4c3e6a4
  #25 [ffffbdb687636548] exc_stack_segment at ffffffffb5666b33
  #26 [ffffbdb687636570] asm_exc_stack_segment at ffffffffb5800cf9
  #27 [ffffbdb6876365f8] hex_string at ffffffffb51b3b61
  #28 [ffffbdb687636648] vsnprintf at ffffffffb51b7291
  #29 [ffffbdb6876366a0] sprintf at ffffffffb51b7541
  #30 [ffffbdb687636708] __sprint_symbol at ffffffffb4d849d6
  #31 [ffffbdb687636768] symbol_string at ffffffffb51b4588
  #32 [ffffbdb6876368b8] vsnprintf at ffffffffb51b7291
  #33 [ffffbdb687636910] vscnprintf at ffffffffb51b73b9
  #34 [ffffbdb687636920] printk_sprint at ffffffffb4d2ae82
  #35 [ffffbdb687636948] vprintk_store at ffffffffb4d2d06d
  #36 [ffffbdb687636a18] vprintk_emit at ffffffffb4d2d1bf
  #37 [ffffbdb687636a58] printk at ffffffffb565e5ce
  #38 [ffffbdb687636ac0] show_trace_log_lvl at ffffffffb4c42374
  #39 [ffffbdb687636bc8] __die_body at ffffffffb4c426ca
  #40 [ffffbdb687636be8] die at ffffffffb4c42778
  #41 [ffffbdb687636c10] do_trap at ffffffffb4c3e49a
  #42 [ffffbdb687636c58] do_error_trap at ffffffffb4c3e6a4
  #43 [ffffbdb687636c98] exc_stack_segment at ffffffffb5666b33
  #44 [ffffbdb687636cc0] asm_exc_stack_segment at ffffffffb5800cf9
  #45 [ffffbdb687636d48] hex_string at ffffffffb51b3b61
  #46 [ffffbdb687636d98] vsnprintf at ffffffffb51b7291
  #47 [ffffbdb687636df0] sprintf at ffffffffb51b7541
  #48 [ffffbdb687636e58] __sprint_symbol at ffffffffb4d849d6
  #49 [ffffbdb687636eb8] symbol_string at ffffffffb51b4588
  #50 [ffffbdb687637008] vsnprintf at ffffffffb51b7291
  #51 [ffffbdb687637060] vscnprintf at ffffffffb51b73b9
  #52 [ffffbdb687637070] printk_sprint at ffffffffb4d2ae82
  #53 [ffffbdb687637098] vprintk_store at ffffffffb4d2d06d
  #54 [ffffbdb687637168] vprintk_emit at ffffffffb4d2d1bf
  #55 [ffffbdb6876371a8] printk at ffffffffb565e5ce
  #56 [ffffbdb687637210] show_trace_log_lvl at ffffffffb4c42374
  #57 [ffffbdb687637318] __die_body at ffffffffb4c426ca
  #58 [ffffbdb687637338] die at ffffffffb4c42778
  #59 [ffffbdb687637360] do_trap at ffffffffb4c3e49a
  #60 [ffffbdb6876373a8] do_error_trap at ffffffffb4c3e6a4
  #61 [ffffbdb6876373e8] exc_stack_segment at ffffffffb5666b33
  #62 [ffffbdb687637410] asm_exc_stack_segment at ffffffffb5800cf9
  #63 [ffffbdb687637498] hex_string at ffffffffb51b3b61
  #64 [ffffbdb6876374e8] vsnprintf at ffffffffb51b7291
  #65 [ffffbdb687637540] sprintf at ffffffffb51b7541
  #66 [ffffbdb6876375a8] __sprint_symbol at ffffffffb4d849d6
  #67 [ffffbdb687637608] symbol_string at ffffffffb51b4588
  #68 [ffffbdb687637758] vsnprintf at ffffffffb51b7291
  #69 [ffffbdb6876377b0] vscnprintf at ffffffffb51b73b9
  #70 [ffffbdb6876377c0] printk_sprint at ffffffffb4d2ae82
  #71 [ffffbdb6876377e8] vprintk_store at ffffffffb4d2d06d
  #72 [ffffbdb6876378b8] vprintk_emit at ffffffffb4d2d1bf
  #73 [ffffbdb6876378f8] printk at ffffffffb565e5ce
  #74 [ffffbdb687637960] show_trace_log_lvl at ffffffffb4c42374
  #75 [ffffbdb687637a68] __warn at ffffffffb4cb0d4d
  #76 [ffffbdb687637aa0] report_bug at ffffffffb51a73fb
  #77 [ffffbdb687637ad8] handle_bug at ffffffffb5666817
  #78 [ffffbdb687637ae8] exc_invalid_op at ffffffffb56669d3
  #79 [ffffbdb687637b00] asm_exc_invalid_op at ffffffffb5800e0d
  [exception RIP: btrfs_ioctl_send+0x26e]
  RIP: ffffffffc06070ce RSP: ffffbdb687637bb8 RFLAGS: 00010282
  RAX: ffff9f6e50160380 RBX: ffff9f8eda64f200 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
  RBP: 0000000000000000 R8: 000000000000000a R9: ffff9f6c9e1c5b20
  R10: 0000000000000075 R11: 0000000000000004 R12: ffff9f6d43a24000
  R13: 0000000000000001 R14: 0000000000000000 R15: ffff9a2d65644d30
  ORIG_RAX: ffffffffffffffff CS: 0010 SS: 0018
  #80 [ffffbdb687637c78] _btrfs_ioctl_send at ffffffffc05c31d4 [btrfs]
  #81 [ffffbdb687637ce8] btrfs_ioctl at ffffffffc05c80c4 [btrfs]
  #82 [ffffbdb687637df8] __x64_sys_ioctl at ffffffffb4f776df
  #83 [ffffbdb687637e38] do_syscall_64 at ffffffffb56663f8
  RIP: 00007fbd339164a7 RSP: 00007ffde6a19888 RFLAGS: 00000246
  RAX: ffffffffffffffda RBX: 0000000000000fe2 RCX: 00007fbd339164a7
  RDX: 00007ffde6a19980 RSI: 0000000040489426 RDI: 0000000000000022
  RBP: 00007ffde6a1ab80 R8: 00007ffde6a19980 R9: 00007fbd33808700
  R10: 00007fbd338089d0 R11: 0000000000000246 R12: 0000000000000022
  R13: 0000000000000001 R14: 0000000000000001 R15: 00005585428002b0
  ORIG_RAX: 0000000000000010 CS: 0033 SS: 002b

Petr Mladek (6):
  module: Add helper function for reading module_buildid()
  kallsyms: Cleanup code for appending the module buildid
  kallsyms/bpf: Set module buildid in bpf_address_lookup()
  kallsyms/ftrace: Set module buildid in ftrace_mod_address_lookup()
  kallsyms: Clean up @namebuf initialization in
    kallsyms_lookup_buildid()
  kallsyms: Prevent module removal when printing module name and buildid

 include/linux/filter.h   | 15 +++++++---
 include/linux/ftrace.h   |  6 ++--
 include/linux/module.h   |  9 ++++++
 kernel/kallsyms.c        | 60 ++++++++++++++++++++++++++++++----------
 kernel/module/kallsyms.c |  9 ++----
 kernel/trace/ftrace.c    |  5 +++-
 6 files changed, 76 insertions(+), 28 deletions(-)

-- 
2.51.1


