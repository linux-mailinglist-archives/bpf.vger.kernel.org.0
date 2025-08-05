Return-Path: <bpf+bounces-65036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92041B1AE79
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 08:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 063317A777E
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 06:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16E721C18C;
	Tue,  5 Aug 2025 06:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqmA5t7m"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281FA2192F2;
	Tue,  5 Aug 2025 06:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754375902; cv=none; b=ZqpKjmiHkf+ctZdVyoRNRS/Nprc1+FOOkJ+86xtFNbw9XCcbAvD+CQDnbP8pTElX36PE4EVfEKt0S3jj4vG7Pk25GqhPO8BOFz961Xt76ysqE+7k6rzfiYWatT13KgiyL2pHQdTea6iYQhk32s78qS1p+JgK8nJOC4PAIPEuhH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754375902; c=relaxed/simple;
	bh=8d7lQ+bhoPsmFsa1MIngmQ0m5Nr+uRObrl36ZfQiDrI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RB7AItPuFR53Kl8uG9k00zPfql90ciOx94uOwBw3FylwQjppzYEFsUOPJfl4sg9N4Klpu7jJ4bUfx9Ly7es1RCyAWjxiERCkuGCc3CUNi4HaAmrQpZTwwHdrb4+a6oohPI8ICP56GLsOs9V9M26YH5zJJ1g6z28XckppMDKNoIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqmA5t7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA29C4CEF4;
	Tue,  5 Aug 2025 06:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754375900;
	bh=8d7lQ+bhoPsmFsa1MIngmQ0m5Nr+uRObrl36ZfQiDrI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LqmA5t7mJbOw85Yc5AKoUnfbM5kB2zW3Ed2Qi5Psb7G4aeX8SuzJW1be/pAN4RG8+
	 R9syhpjBP0LAXUBohfI86R8S5mP1ZDmITx9UMwZi+cdRyWVjPBvQVJOeub5DEn6eQW
	 0YSX+1Qbe7U6jYCDnAVPYTDnuVa2V8mc9Nl98uxf6wwSHZy8I6qKSD7YKc6llR/Q9l
	 juw7TU6MfEM/WQHcJYpGi0DRoWO86YteUog6USFInEhnICNAcMhF6M0MiqATtRspUf
	 mCe+xAJ9DpcEgoNi3JtueEI9bLgBqiNjqFokbtZjnx/5NQEHd6uNZRC3HVF/PTR9Rn
	 AnIPea5OI7Jgg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Pu Lehui
 <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next 00/10] Add support arena atomics for RV64
In-Reply-To: <20250719091730.2660197-1-pulehui@huaweicloud.com>
References: <20250719091730.2660197-1-pulehui@huaweicloud.com>
Date: Tue, 05 Aug 2025 08:38:17 +0200
Message-ID: <87v7n21deu.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> patch 1-3 refactor redundant load and store operations.
> patch 4-7 add Zacas instructions for cmpxchg.
> patch 8 optimizes exception table handling.
> patch 9-10 add support arena atomics for RV64.
>
> Tests `test_progs -t atomic,arena` have passed as shown bellow,
> as well as `test_verifier` and `test_bpf.ko` have passed.

[...]

> Pu Lehui (10):
>   riscv, bpf: Extract emit_stx() helper
>   riscv, bpf: Extract emit_st() helper
>   riscv, bpf: Extract emit_ldx() helper
>   riscv: Separate toolchain support dependency from RISCV_ISA_ZACAS
>   riscv, bpf: Add rv_ext_enabled macro for runtime detection extentsion
>   riscv, bpf: Add Zacas instructions
>   riscv, bpf: Optimize cmpxchg insn with Zacas support
>   riscv, bpf: Add ex_insn_off and ex_jmp_off for exception table
>     handling
>   riscv, bpf: Add support arena atomics for RV64
>   selftests/bpf: Enable arena atomics tests for RV64
>
>  arch/riscv/Kconfig                            |   1 -
>  arch/riscv/include/asm/cmpxchg.h              |   6 +-
>  arch/riscv/kernel/setup.c                     |   1 +
>  arch/riscv/net/bpf_jit.h                      |  70 ++-
>  arch/riscv/net/bpf_jit_comp64.c               | 516 +++++-------------
>  .../selftests/bpf/progs/arena_atomics.c       |   9 +-
>  6 files changed, 214 insertions(+), 389 deletions(-)

What a nice series! The best kind of changeset -- new feature, less
code! Thank you, Lehui! Again, apologies for the horrible SLA. The
weather in Sweden was simply Too Good this summer!

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com> # QEMU only
Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

