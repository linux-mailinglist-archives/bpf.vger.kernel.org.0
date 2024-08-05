Return-Path: <bpf+bounces-36405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94AF9480BF
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 19:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A1B281732
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 17:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F8615ECF2;
	Mon,  5 Aug 2024 17:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAPF+OLt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078591494DA
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 17:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880434; cv=none; b=ZyQfxzXMXBMT8n/uqjDMltFxZoZVkWdqyszyWqaIVtGOMuu3lQV4/MdZz7npvePtM0k68qLiKWryk4JzkiDmdg3rh6Q6XuZrGtpxH8WuU5BQl6IKNPOErDFLS2WlPCXlkkZM5L3Fk2L+9siUQo8eezPNC2IR5gSm+d77hRlWOHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880434; c=relaxed/simple;
	bh=D4+HdpZOhJCZs14JJR4OQCb8S4tMmVjc+z1BHs2ck0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LjiWuZeUi46oLRHd3aFKEZSQ/V+jQU6oDm40BfsO+kpB4jjQBA3PDhThSEgjxWuPxoGzVH5Sbg5Lwg3g3omTcgafknQftU4tNPMG+H8WPElrlifGIIyyPxTTW76so2+ejQURRVHSb/jPK461/LOKgRv8+mcMS8JCy2lnJvO6weY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAPF+OLt; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so65543445e9.2
        for <bpf@vger.kernel.org>; Mon, 05 Aug 2024 10:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722880431; x=1723485231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/9aACln0MhLSdXEH1Bt5C7lvsvWw4460bVEDPFvtrY=;
        b=QAPF+OLtA7h0czDif+R7Gx8WCnQtxWZ0tmd+psbxBZbTDbNSWaxTQ+xZj/u6+9XZL3
         n8B34pB7u8E4hnqY+eTWyOUcK+MJubCoFY3PjnEE0K3iEP7oiBwjbi6Tm2GojH0jJ479
         XJ1PU8DznjYskskhOXTnkl0XbZsgGf9PNbFT9GOneCb7/iGFyt6Xulv4A9x6l47BIYuX
         S9U9DxwfxK1PB18ukg05h6lZeeNjdaGzPNQRmP6IZknECTqQpJqNBusgyefcVJzdCxG8
         q2P+ByPPOhMdPDJmo8eeVfxtz6cnNV08Wv2NFk/ISI7GWERE4wYpZaw6o+CXqjpasRDO
         anRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722880431; x=1723485231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/9aACln0MhLSdXEH1Bt5C7lvsvWw4460bVEDPFvtrY=;
        b=LKwDb+2HO/qX/ongoQivX+2liJx3XarnzXG/rZ71QCA5kgUiAKX5SpfhdNE4MRrQhv
         pqKH7IuxLP99vXtHmkKcD9iGwRra42+JpFLCHTAEGkv5geQZPTQ8pulD2ki106pcnzsi
         9orZfVwTaG3QA4Jp5l9s4f6ZhzbZUnIBVqwoBANvMVgHJ1rSbEVhw1vZwFprro0MDvmx
         aSmQNzZwGKADmGwZvkt9RIbkIcOldTwCgh8JZ1zj59KuxYtvOEZYu77Kb++EQsXiMkIP
         RUhQgtHkXmBOVB3VFVWtDo45hGZfHyeFg2RhQQZxGcAU060/r2ca4yXqe37XusD7cWAB
         iKZQ==
X-Gm-Message-State: AOJu0YzSmPOLWEPPVId6sw0tYuBJRHMbKHJxs43h4+KmO871uB6cgxy7
	+tgQ5phlqMj0dd6rqcdU34XPW6ROs694EX33uXhLIWEXPgUSheoheWwEOfdURFuxlt6HEL3koDW
	Y7L1hSNy14V9a4eiJpfmdOGvPfYE=
X-Google-Smtp-Source: AGHT+IEKG0D3KyLcjEWP9RZEs5I1vQ9l82Mq5jTLBp6nHBHqQUMVqj91tCqDSSTkKGEkbBcy1X7PkaYXSQ0yeDqYt+w=
X-Received: by 2002:a05:6000:dc1:b0:367:926a:7413 with SMTP id
 ffacd0b85a97d-36bbc189bc0mr6613865f8f.63.1722880430903; Mon, 05 Aug 2024
 10:53:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240803025928.4184433-1-yonghong.song@linux.dev>
In-Reply-To: <20240803025928.4184433-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 Aug 2024 10:53:39 -0700
Message-ID: <CAADnVQKt8FQjuZKFTGbyf5uKGZ8gfjzSvC36CbZ7ENbkuCmopA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix arena_atomics selftest
 failure due to llvm change
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 7:59=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> Peilen Ye reported an issue ([1]) where for __sync_fetch_and_add(...) wit=
hout
> return value like
>   __sync_fetch_and_add(&foo, 1);
> llvm BPF backend generates locked insn e.g.
>   lock *(u32 *)(r1 + 0) +=3D r2
>
> If __sync_fetch_and_add(...) returns a value like
>   res =3D __sync_fetch_and_add(&foo, 1);
> llvm BPF backend generates like
>   r2 =3D atomic_fetch_add((u32 *)(r1 + 0), r2)
>
> But 'lock *(u32 *)(r1 + 0) +=3D r2' caused a problem in jit
> since proper barrier is not inserted based on __sync_fetch_and_add() sema=
ntics.
>
> The above discrepancy is due to commit [2] where it tries to maintain bac=
kward
> compatability since before commit [2], __sync_fetch_and_add(...) generate=
s
> lock insn in BPF backend.
>
> Based on discussion in [1], now it is time to fix the above discrepancy s=
o we can
> have proper barrier support in jit. llvm patch [3] made sure that __sync_=
fetch_and_add(...)
> always generates atomic_fetch_add(...) insns. Now 'lock *(u32 *)(r1 + 0) =
+=3D r2' can only
> be generated by inline asm. The same for __sync_fetch_and_and(), __sync_f=
etch_and_or()
> and __sync_fetch_and_xor().
>
> But the change in [3] caused arena_atomics selftest failure.
>
>   test_arena_atomics:PASS:arena atomics skeleton open 0 nsec
>   libbpf: prog 'and': BPF program load failed: Permission denied
>   libbpf: prog 'and': -- BEGIN PROG LOAD LOG --
>   arg#0 reference type('UNKNOWN ') size cannot be determined: -22
>   0: R1=3Dctx() R10=3Dfp0
>   ; if (pid !=3D (bpf_get_current_pid_tgid() >> 32)) @ arena_atomics.c:87
>   0: (18) r1 =3D 0xffffc90000064000       ; R1_w=3Dmap_value(map=3Darena_=
at.bss,ks=3D4,vs=3D4)
>   2: (61) r6 =3D *(u32 *)(r1 +0)          ; R1_w=3Dmap_value(map=3Darena_=
at.bss,ks=3D4,vs=3D4) R6_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,var_o=
ff=3D(0x0; 0xffffffff))
>   3: (85) call bpf_get_current_pid_tgid#14      ; R0_w=3Dscalar()
>   4: (77) r0 >>=3D 32                     ; R0_w=3Dscalar(smin=3D0,smax=
=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff))
>   5: (5d) if r0 !=3D r6 goto pc+11        ; R0_w=3Dscalar(smin=3D0,smax=
=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff)) R6_w=3Dscalar(smin=3D0,sm=
ax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0x)
>   ; __sync_fetch_and_and(&and64_value, 0x011ull << 32); @ arena_atomics.c=
:91
>   6: (18) r1 =3D 0x100000000060           ; R1_w=3Dscalar()
>   8: (bf) r1 =3D addr_space_cast(r1, 0, 1)        ; R1_w=3Darena
>   9: (18) r2 =3D 0x1100000000             ; R2_w=3D0x1100000000
>   11: (db) r2 =3D atomic64_fetch_and((u64 *)(r1 +0), r2)
>   BPF_ATOMIC stores into R1 arena is not allowed
>   processed 9 insns (limit 1000000) max_states_per_insn 0 total_states 0 =
peak_states 0 mark_read 0
>   -- END PROG LOAD LOG --
>   libbpf: prog 'and': failed to load: -13
>   libbpf: failed to load object 'arena_atomics'
>   libbpf: failed to load BPF skeleton 'arena_atomics': -13
>   test_arena_atomics:FAIL:arena atomics skeleton load unexpected error: -=
13 (errno 13)
>   #3       arena_atomics:FAIL
>
> The reason of the failure is due to [4] where atomic{64,}_fetch_{and,or,x=
or}() are not
> allowed by arena addresses. Without llvm patch [3], the compiler will gen=
erate 'lock ...'
> insn and everything will work fine.
>
> This patch fixed the problem by using inline asms. Instead of __sync_fetc=
h_and_{and,or,xor}() functions,
> the inline asm with 'lock' insn is used and it will work with or without =
[3].
> Note that three bpf programs ('and', 'or' and 'xor') are guarded with __B=
PF_FEATURE_ADDR_SPACE_CAST
> as well to ensure compilation failure for llvm <=3D 18 version. Note that=
 for llvm <=3D 18 where
> addr_space_cast is not supported, all arena_atomics subtests are skipped =
with below message:
>   test_arena_atomics:SKIP:no ENABLE_ATOMICS_TESTS or no addr_space_cast s=
upport in clang
>   #3 arena_atomics:SKIP
>
>   [1] https://lore.kernel.org/bpf/ZqqiQQWRnz7H93Hc@google.com/T/#mb68d67b=
c8f39e35a0c3db52468b9de59b79f021f
>   [2] https://github.com/llvm/llvm-project/commit/286daafd65129228e08a1d0=
7aa4ca74488615744
>   [3] https://github.com/llvm/llvm-project/pull/101428
>   [4] d503a04f8bc0 ("bpf: Add support for certain atomics in bpf_arena to=
 x86 JIT")
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  .../selftests/bpf/progs/arena_atomics.c       | 63 ++++++++++++++++---
>  1 file changed, 54 insertions(+), 9 deletions(-)
>
> Changelog:
>   v1 -> v2:
>     - Add __BPF_FEATURE_ADDR_SPACE_CAST to guard newly added asm codes fo=
r llvm >=3D 19
>
> diff --git a/tools/testing/selftests/bpf/progs/arena_atomics.c b/tools/te=
sting/selftests/bpf/progs/arena_atomics.c
> index bb0acd79d28a..dea54557fc00 100644
> --- a/tools/testing/selftests/bpf/progs/arena_atomics.c
> +++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
> @@ -5,6 +5,7 @@
>  #include <bpf/bpf_tracing.h>
>  #include <stdbool.h>
>  #include "bpf_arena_common.h"
> +#include "bpf_misc.h"
>
>  struct {
>         __uint(type, BPF_MAP_TYPE_ARENA);
> @@ -85,10 +86,24 @@ int and(const void *ctx)
>  {
>         if (pid !=3D (bpf_get_current_pid_tgid() >> 32))
>                 return 0;
> -#ifdef ENABLE_ATOMICS_TESTS
> +#if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_CA=
ST)
>
> -       __sync_fetch_and_and(&and64_value, 0x011ull << 32);
> -       __sync_fetch_and_and(&and32_value, 0x011);
> +       asm volatile(
> +               "r1 =3D addr_space_cast(%[and64_value], 0, 1);"
> +               "lock *(u64 *)(r1 + 0) &=3D %[val]"
> +               :
> +               : __imm_ptr(and64_value),
> +                 [val]"r"(0x011ull << 32)
> +               : "r1"
> +       );
> +       asm volatile(
> +               "r1 =3D addr_space_cast(%[and32_value], 0, 1);"
> +               "lock *(u32 *)(r1 + 0) &=3D %[val]"
> +               :
> +               : __imm_ptr(and32_value),
> +                 [val]"w"(0x011)
> +               : "r1"
> +       );

Instead of inline asm there is a better way to do the same in C.
https://godbolt.org/z/71PYx1oqE

void foo(int a, _Atomic int *b)
{
 *b +=3D a;
}

generates:
lock *(u32 *)(r2 + 0) +=3D r1

but
*b &=3D a;

crashes llvm :( with

<source>:3:5: error: unsupported atomic operation, please use 64 bit versio=
n
    3 |  *b &=3D a;

but works with -mcpu=3Dv3

So let's make this test mcpu=3Dv3 only and use normal C ?

pw-bot: cr

