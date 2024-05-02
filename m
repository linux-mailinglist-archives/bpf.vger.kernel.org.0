Return-Path: <bpf+bounces-28468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDFF8B9F9F
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 19:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F04B1F22C87
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 17:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA1216FF49;
	Thu,  2 May 2024 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0mf6d/e"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB40316FF3E
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 17:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714671462; cv=none; b=bSoFOSESP88Fi4+l4E78NbqwV8hefZHJBAjnE5D8xfDpGSToS4fi7u+IPi1xmFo8M1MgqOE/VPG/yNgz2ZtDJXDTVm4q0Page1N2haT27qiLVpAibBB7scqP1zW8diKUq0JbwxLEw+0ZoLkvOP4rICxTmEq4tSgjIbnxWu4LvZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714671462; c=relaxed/simple;
	bh=0ks0QUIsrvXws4EBSYESUFO0NF/deCywv37MLaqIHfg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CTI4SecO81QWtLKInsdXnI5VMkJEBtnAPfpmsAZlkgs3J1zdiQmzZwX2/QelPZUU183Taymeq1R29eSnsZSx4ZKTQNAvaY7BlBdR0YY7kaF3jJfvRZu8j7eZtMm0oxbCF1Ct5Q+DeIxci63kRbJbDh5hJk6RExRvPPHNBP70Zh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0mf6d/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F3EC113CC;
	Thu,  2 May 2024 17:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714671461;
	bh=0ks0QUIsrvXws4EBSYESUFO0NF/deCywv37MLaqIHfg=;
	h=From:To:Subject:Date:From;
	b=f0mf6d/e/NzdWJk2qqmnbM+ayIrte2fDhcyW8tNOllEZEd0413Ll+aXyivuVuFzNQ
	 kKbCzxQV1qQMcxRXBEnd0XPJJGu2b5vsDVWwK6GGrrW/L31MUhdsMyAEd6pLy5eIbn
	 ENQytM/NhyIftU3A2CrHR6Tu6z/OpgcGY/whNCO5A28uh02cjkmv8TM808p0qGOb9E
	 Cdz0VJP+FC4bw0jDyzzO/EyXFBjiJxJYXNx/oMwBQC1ZShdbITuqBNS5DdeshOLuVg
	 GAYYPW7h1WPfKRAEMXfmiwavnZ6WW8b1Q1eSGmlXBT07JNYBAvGbPlm571XmkuDF01
	 G5hE+iZ0Q7BuQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 bpf@vger.kernel.org
Subject: On inlining more helpers in the JITs or the verifier
Date: Thu, 02 May 2024 17:37:01 +0000
Message-ID: <mb61p1q6k869u.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Everyone,

While working on inlining bpf_get_smp_processor_id() in the ARM64 and
RISCV JITs, I realized that these archs allow such optimizations because
they keep some information like the per-cpu offset or the pointer to the
task_struct in special system registers.

So, I went through the list of all BPF helpers and made a list of
helpers that we can inline in these JITs to make their usage much more
optimized:

I. ARM64 and RISC-V specific optimzations if inlined:

    A) Because pointer to tast_struct is available in a register:
        1. bpf_get_current_pid_tgid()
        2. bpf_get_current_task()
        3. bpf_set_retval()
        4. bpf_get_retval()
        5. bpf_task_pt_regs()
        6. bpf_get_attach_cookie()
    
    B) Because per_cpu offset is available in a register:
        1. bpf_this_cpu_ptr()
        2. bpf_get_numa_node_id()

        These can be inlined in the verifier too using the newly
        introduced per-cpu instruction.

II. These are very basic writes, can be inlined in the verifier or the JIT:
    1. bpf_msg_apply_bytes()
    2. bpf_msg_cork_bytes()
    3. bpf_set_hash_invalid()

I will first try to inline all these in the ARM64 JIT and see the
performance improvement. I am not sure what would be the best way to
benchmark all of this inlining.

Andrii, can you suggest something for the benchmarking?

Looking forward to your thoughts on this.

Thanks,
Puranjay

