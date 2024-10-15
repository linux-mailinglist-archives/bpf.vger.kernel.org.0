Return-Path: <bpf+bounces-42060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A2699F097
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 17:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942B6282123
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 15:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504491B3922;
	Tue, 15 Oct 2024 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eQuqLm0C"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9501B2193
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004547; cv=none; b=G15BrIvHJEA9kqhDjOawHzvmXHTU1uvkgffGny4rQEU+QfTnKf9VxVZubZzVN26pPk+exoM9Mv8MPOzrpDsysolZeknWdqFi3IZd/IKMTPZrSVtijYmZmh81VSfKFUE2+rRrQh+TMhCslEi5mJnVXzzt7GkAg0IwHG+2O5Bjbzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004547; c=relaxed/simple;
	bh=EqkBC8fXor46H69Q4ctkRgE8OuY/tWitYaLWLlh0N0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jgT7LBtPtXvh9M9/dMinlRmqL0pXIeIlvz1fumwZASNz/h8IZhZGEiiAZZAGBNx6jBUEp86ytiqLbeA/6jm9MAqfRoGGbLe+MApIeBFCizYAMbLn7FVoz2WgvmtEHzF5ZYlJbtV0rzhOOT+Gp07sbya2Ju+vErIJcf9ZpMYMiCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eQuqLm0C; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729004539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gQCrhodYPcy7xFf+Q4NF3VtsBRCxxU3D90ZsES+wNfM=;
	b=eQuqLm0CSIvnynIVxPQyN1h3NG3/ZG7cfO1ocRu5iqjho0ySUfKltYnH/yq7JZ5iwNfi2z
	7Wme/HnImwB4bhf/rD478o9Da3h86vpYqPjI3Q+UifdgCmSDOe3PiESoSV3RoDAC23yjAL
	5JvhAHv/FmlO55dhjE0nQRrkvrPc/Zc=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	toke@redhat.com,
	martin.lau@kernel.org,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	xukuohai@huaweicloud.com,
	eddyz87@gmail.com,
	iii@linux.ibm.com,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v8 0/2] bpf: Fix tailcall infinite loop caused by freplace
Date: Tue, 15 Oct 2024 23:02:05 +0800
Message-ID: <20241015150207.70264-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Previously, I addressed a tailcall infinite loop issue related to
trampolines[0].

In this patchset, I resolve a similar issue where a tailcall infinite loop
can occur due to the combination of tailcalls and freplace programs. The
fix prevents adding extended programs to the prog_array map and blocks the
extension of a tail callee program with freplace.

Key changes:

1. If a program or its subprogram has been extended by an freplace program,
   it can no longer be updated to a prog_array map.
2. If a program has been added to a prog_array map, neither it nor its
   subprograms can be extended by an freplace program.

Additionally, an extension program should not be tailcalled. As a result,
return -EINVAL if the program has a type of BPF_PROG_TYPE_EXT when adding
it to a prog_array map.

Changes:
v7 -> v8:
  * Address comment from Alexei:
    * guard(mutex) should not hold range all the way through
      bpf_arch_text_poke().
  * Address suggestion from Xu Kuohai:
    * Extension prog should not be tailcalled independently.

v6 -> v7:
  * Address comments from Alexei:
    * Rewrite commit message more imperative and consice with AI.
    * Extend bpf_trampoline_link_prog() and bpf_trampoline_unlink_prog()
      to link and unlink target prog for freplace prog.
    * Use guard(mutex)(&tgt_prog->aux->ext_mutex) instead of
      mutex_lock()&mutex_unlock() pair.
  * Address comment from Eduard:
    * Remove misplaced "Reported-by" and "Closes" tags.

v5 -> v6:
  * Fix a build warning reported by kernel test robot.

v4 -> v5:
  * Move code of linking/unlinking target prog of freplace to trampoline.c.
  * Address comments from Alexei:
    * Change type of prog_array_member_cnt to u64.
    * Combine two patches to one.

v3 -> v4:
  * Address comments from Eduard:
    * Rename 'tail_callee_cnt' to 'prog_array_member_cnt'.
    * Add comment to 'prog_array_member_cnt'.
    * Use a mutex to protect 'is_extended' and 'prog_array_member_cnt'.

v2 -> v3:
  * Address comments from Alexei:
    * Stop hacking JIT.
    * Prevent the specific use case at attach/update time.

v1 -> v2:
  * Address comment from Eduard:
    * Explain why nop5 and xor/nop3 are swapped at prologue.
  * Address comment from Alexei:
    * Disallow attaching tail_call_reachable freplace prog to
      not-tail_call_reachable target in verifier.
  * Update "bpf, arm64: Fix tailcall infinite loop caused by freplace" with
    latest arm64 JIT code.

Links:
[0] https://lore.kernel.org/bpf/20230912150442.2009-1-hffilwlqm@gmail.com/

Leon Hwang (2):
  bpf: Prevent tailcall infinite loop caused by freplace
  selftests/bpf: Add test to verify tailcall and freplace restrictions

 include/linux/bpf.h                           |  17 ++-
 kernel/bpf/arraymap.c                         |  26 +++-
 kernel/bpf/core.c                             |   1 +
 kernel/bpf/syscall.c                          |   7 +-
 kernel/bpf/trampoline.c                       |  47 +++++--
 .../selftests/bpf/prog_tests/tailcalls.c      | 120 ++++++++++++++++--
 .../testing/selftests/bpf/progs/tc_bpf2bpf.c  |   5 +-
 7 files changed, 190 insertions(+), 33 deletions(-)

-- 
2.44.0


