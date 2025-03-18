Return-Path: <bpf+bounces-54348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CB6A67E70
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 22:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C4D3B8C11
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 21:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0691C5F2C;
	Tue, 18 Mar 2025 21:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aSWz5sBX"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C57B1D9A49
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 21:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742331647; cv=none; b=qw/9WhDuf9LsBABTgkKJ/EW1pbwhGPsvz5KlfvFl3qLzlP4ZX8j+Br4ATCWGWC/2X5LzNF1eqSCMFnE9qRggomMkjkFhfQGHpRlvkeAIVOKaK9xKZZH7lt+xPk5QiKk9W98OgnqYZSBZUt/MEpWLgbsNHSf5+YW+5Y0my+hXGcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742331647; c=relaxed/simple;
	bh=8ZjEo3llqLTUywvBJnzVjqQY/CSOd3KoVpDuEMkqnvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AiMDW3gJtpFdHJ1UTcKwHkjMU0o2+RQMVN0xmOVi+HGa3U5/AkZx0on308yUOZpfdJcqUkl9BYxox9rtgBqt3w9OcvqGGalaR7q4xtPgXFmXeT7bqlwSOget1qYeVLfZQoTf3qp9XlzoVj7p77pjE9XSQZ4AJYjMOSoeOuQDKJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aSWz5sBX; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4a128a09-0b8b-488a-986b-7882f96bc5bb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742331640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OfG45ArWMVjcLLym1kC2zNxulD+w2HRn9zXM1xN+aMU=;
	b=aSWz5sBXWDNK/MZ0kLZhEotMYw1MUCjTGZgk6T7Vo4aMUzvlCHWlP+2j8Z14LHgjtrvFoj
	45uprfgHREkK2QanT7YqEcLD6F5DKpvBfAum4YdK8ypdKU9XSIpJHWqOCnFpwAPjmBfgv0
	inKJ1FnGYIwv5KbFZjVKel1ckA40bjo=
Date: Tue, 18 Mar 2025 14:00:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 00/14] instruction sets and static keys
Content-Language: en-GB
To: Anton Protopopov <aspsk@isovalent.com>, bpf@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>, Quentin Monnet <qmo@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>
References: <20250318143318.656785-1-aspsk@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250318143318.656785-1-aspsk@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/18/25 7:33 AM, Anton Protopopov wrote:
> This patchset implements new type of map, instruction set, and uses
> it to build support for BPF static keys. The same map will be later
> used to provide support for indirect jumps and indirect calls. See
> [1], [2] for more context.
>
> Short table of contents:
>
>    * patches 1, 9, 10, 11 are simple fixes (which can be sent
>      independently, if acked)
>
>    * patches 2, 3 add a new map type, BPF_MAP_TYPE_INSN_SET, and
>      corresponding selftests. This map is used to track how original
>      instructions were relocated into 'xlated' during the verification
>
>    * patches 4, 5, 6, 7, 8 add support for static keys (kernel only)
>      using (an extension) to that new map type. Only x86 support is
>      added in this RFC
>
>    * patches 12, 13, 14 add libbpf-side support for static keys and
>      selftests
>
> It is RFC for a few reasons:
>
> 1) The kernel side of the static keys looks clear, however, the
> libbpf side is not _that_ clear. I thought that this is better to
> commit to a particular userspace design, as any particular design
> requires a lot of changes on the libbpf side. See patch 12 for
> the details
>
> 2) The libbpf part of the series requires a patched LLVM (see [3]),
> which adds support for gotol_or_nop/nop_or_gotol instructions, so
> selftests would not compile in CI.
>
> 3) Patch 4 adds support for a new BPF instruction. It looks
> reasonable to use an extended BPF_JMP|BPF_JA instruction, and not
> may_goto. Reasons: a follow up will add support for
> BPF_JMP|BPF_JA|BPF_X (indirect jumps), which also utilizes INSN_SET maps (see [2]).
> Then another follow up will add support CALL|BPF_X, for which there's
> no corresponding magic instruction (to be discussed at the following
> LSF/MM/BPF).
>
> Besides these reasons, there are some questions / known bugs,
> which will be fixed once the general plan is confirmed:
>
>    * bpf_jit_blind_constants will patch code, which is ignored in this
>      RFC series. The solution would be either moving tracking
>      instruction sets to bpf_prog from the verifier environment,
>      or moving bpf_jit_blind_constants upper the stack (right now,
>      this is the first thing which every jit does, so maybe it can
>      be actually executed from the verifier, and provide env context)
>
>    * gen-loader not supported, fd_array usage in libbpf should be
>      re-designed (see patch 12 for more details)
>
>    * insn_off -> insn_set map mapping should be optimized (now it is
>      brute force)
>
> Links:
>    1. http://oldvger.kernel.org/bpfconf2024_material/bpf_static_keys.pdf
>    2. https://lpc.events/event/18/contributions/1941/
>    3. https://github.com/aspsk/llvm-project/tree/static-keys

For llvm patch in [3], please remove changes in function isValidIdInMiddle()
as gotol_or_nop or nop_or_gotol will not appear in the *middle* of any
instruction. "gotol" should not be there either, I may remove it sometime
later.

>
> Anton Protopopov (14):
>    bpf: fix a comment describing bpf_attr
>    bpf: add new map type: instructions set
>    selftests/bpf: add selftests for new insn_set map
>    bpf: add support for an extended JA instruction
>    bpf: Add kernel/bpftool asm support for new instructions
>    bpf: add BPF_STATIC_KEY_UPDATE syscall
>    bpf: save the start of functions in bpf_prog_aux
>    bpf, x86: implement static key support
>    selftests/bpf: add guard macros around likely/unlikely
>    libbpf: add likely/unlikely macros
>    selftests/bpf: remove likely/unlikely definitions
>    libbpf: BPF Static Keys support
>    libbpf: Add bpf_static_key_update() API
>    selftests/bpf: Add tests for BPF static calls
>
>   arch/x86/net/bpf_jit_comp.c                   |  65 +-
>   include/linux/bpf.h                           |  28 +
>   include/linux/bpf_types.h                     |   1 +
>   include/linux/bpf_verifier.h                  |   2 +
>   include/uapi/linux/bpf.h                      |  40 +-
>   kernel/bpf/Makefile                           |   2 +-
>   kernel/bpf/bpf_insn_set.c                     | 400 +++++++++++
>   kernel/bpf/core.c                             |   5 +
>   kernel/bpf/disasm.c                           |  33 +-
>   kernel/bpf/syscall.c                          |  28 +
>   kernel/bpf/verifier.c                         |  94 ++-
>   tools/include/uapi/linux/bpf.h                |  40 +-
>   tools/lib/bpf/bpf.c                           |  17 +
>   tools/lib/bpf/bpf.h                           |  19 +
>   tools/lib/bpf/bpf_helpers.h                   |  63 ++
>   tools/lib/bpf/libbpf.c                        | 362 +++++++++-
>   tools/lib/bpf/libbpf.map                      |   1 +
>   tools/lib/bpf/libbpf_internal.h               |   3 +
>   tools/lib/bpf/linker.c                        |   6 +-
>   .../selftests/bpf/bpf_arena_spin_lock.h       |   3 -
>   .../selftests/bpf/prog_tests/bpf_insn_set.c   | 639 ++++++++++++++++++
>   .../bpf/prog_tests/bpf_static_keys.c          | 359 ++++++++++
>   .../selftests/bpf/progs/bpf_static_keys.c     | 131 ++++
>   tools/testing/selftests/bpf/progs/iters.c     |   2 -
>   24 files changed, 2315 insertions(+), 28 deletions(-)
>   create mode 100644 kernel/bpf/bpf_insn_set.c
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insn_set.c
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_static_keys.c
>   create mode 100644 tools/testing/selftests/bpf/progs/bpf_static_keys.c
>


