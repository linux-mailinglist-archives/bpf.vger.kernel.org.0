Return-Path: <bpf+bounces-72550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E986BC1538E
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 15:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 831EA4E8E36
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 14:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B7722A4F8;
	Tue, 28 Oct 2025 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL4JdTzS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8212720468D
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662749; cv=none; b=QjxsP4imysUDDqC1NAMMhqoswlGVff0csXgXk4Mos/1YogcYFmogZNROgc8cBy1vIXdNEfs81ray7PIlsFpByY0n9Lpx6+A4u5Kq1w+/MQP24uLWWxMlyvbvjCSaSqE0fYtOKeEt9RmuzBE7afvJ0XR6ymMb/jGM8uuva9bkHB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662749; c=relaxed/simple;
	bh=NykIU8mJFIPF3wyCiLY9BVoMSdeY1m4MsQhWC45Rrxc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=r1O2GsaDS8EFAUNJxqOhxezpA1z/aGVeNseGqHGY/R8AP2WlC2uBjXh6gj78AmRphX0XhONy47Z/bbs4fN+cZIQql0bzrgLNU2YwdyL0GYNxyNYFaaErq5uHXGaCqLoZXJjeeGLCxWLnIUTx8SUadRsX72BpnQX6klccz5j90YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL4JdTzS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1244C4CEE7;
	Tue, 28 Oct 2025 14:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761662749;
	bh=NykIU8mJFIPF3wyCiLY9BVoMSdeY1m4MsQhWC45Rrxc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=JL4JdTzSLPRKUIU2hxryeG5BA9C4k8DAFG39rLulFCe34Pq8WoJdgRgjaWXpT07ex
	 Mg+fXFEZFqyHgwZM8IJsfPQWd3DhjFWeYJohmujAh/S/gK0KaJz/trEylum963ZVM7
	 1QkOh7ZB+i+VtQR9hx1v0NcMCxM+iC3QHc1Hv+eSRjrPYIUz0QoEBRBQv1ppgxutTo
	 pq62qcKrIhm5EnGFWXp10D5+XsZwLqLly89OR1D4NkNrzQV+/8fIpkQh6/7nFjBG2y
	 n+PHtjPAJFf8sm3+SmO8T0GVyKj29xbPnzmDQAMFuL+gI41yFCNYANNSlxmk5wz8Or
	 Ru8+DgbITkPuw==
Content-Type: multipart/mixed; boundary="===============0945223740402396935=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <33646aa56766cac6c6915ffde6652dd9b2f640a5262203002d7f6cfd4f82c247@mail.kernel.org>
In-Reply-To: <20251028142049.1324520-11-a.s.protopopov@gmail.com>
References: <20251028142049.1324520-11-a.s.protopopov@gmail.com>
Subject: Re: [PATCH v8 bpf-next 10/11] selftests/bpf: add new verifier_gotox test
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,aspsk@isovalent.com,daniel@iogearbox.net,eddyz87@gmail.com,qmo@kernel.org,yonghong.song@linux.dev
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 28 Oct 2025 14:45:47 +0000 (UTC)

--===============0945223740402396935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit 817a92582203a0d4c62d2de0abae0bd4a5418fa3
Author: Anton Protopopov <a.s.protopopov@gmail.com>

selftests/bpf: add new verifier_gotox test

This commit adds a new BPF selftest file to validate the gotox
(indirect jump) instruction functionality. The tests cover various
edge cases including reserved field validation, bounds checking,
alignment, and register usage.

> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> index c0e8ffdaa..4b4b081b4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
> new file mode 100644
> index 000000000..f7bf0a5e0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c

[ ... ]

> +SEC("socket")
> +__failure __msg("writes into insn_array not allowed")
> +__naked void jump_table_no_writes(void)
> +{
> +	asm volatile ("						\
> +	.pushsection .jumptables,\"\",@progbits;		\
> +jt0_%=:								\
> +	.quad ret0_%=;						\
> +	.quad ret1_%=;						\
> +	.size jt0_%=, 16;					\
> +	.global jt0_%=;						\
> +	.popsection;						\
> +								\
> +	r0 = jt0_%= ll;						\
> +	r0 += 8;						\
> +	r1 = 0xbeef;						\
> +	*(u64 *)(r0 + 0) = r1;					\

[ ... ]

> +SEC("socket")
> +__failure __msg("jump table for insn 4 points outside of the subprog [0,10]")
> +__naked void jump_table_outside_subprog(void)
> +{
> +	asm volatile ("						\
> +	.pushsection .jumptables,\"\",@progbits;		\
> +jt0_%=:								\
> +	.quad ret0_%=;						\
> +	.quad ret1_%=;						\
> +	.quad ret_out_%=;					\
> +	.size jt0_%=, 24;					\
> +	.global jt0_%=;						\
> +	.popsection;						\
> +								\
> +	r0 = jt0_%= ll;						\
> +	r0 += 8;						\
> +	*(u64 *)(r0 + 0) = r1;					\
> +	.8byte %[gotox_r0];					\

Does jump_table_outside_subprog() use the correct operation?  This test
writes to the jump table (line marked with * above), but the expected
error message indicates it should be testing bounds checking, not write
protection. All other bounds validation tests in the file use read
operations like "r0 = *(u64 *)(r0 + 0);" (see jump_table_misaligned_access,
jump_table_invalid_mem_acceess_pos, jump_table_invalid_mem_acceess_neg).
The write operation will cause the verifier to reject the program with
"writes into insn_array not allowed" before it can validate whether the
jump target is within the subprogram boundary.

Should this be changed to a read operation to properly test the intended
bounds check?


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `selftests/bpf: add new verifier_gotox test`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18878193924

--===============0945223740402396935==--

