Return-Path: <bpf+bounces-37304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA970953C6A
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 23:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18791C22518
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 21:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607A713D245;
	Thu, 15 Aug 2024 21:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzHXVBzX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7727D4C62E
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723756536; cv=none; b=UOB7f8rtyRXhqD7xvVPIwOWc6CDDDAurFrHuPVs7H1Ov4kzCnnfc2JAsHvvIvKxYVscUGr/8Qia4kxC2ZDaAls0MCqLOohx3jOBbHHPBD0FTJQBdWN2dcMqZ0odPnRE90USb/bqYLXpn+SVF0dDnuehgCvU0PGmM8ou2pVs7Rng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723756536; c=relaxed/simple;
	bh=qxGahSdKmERD8xJbpEw8RNAOxSpCnDrX+yj5/qIyu8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uw4njypPau74t55S9adzuXxGFP3aOVs14DVdFXzrHO4Z6c9EBDojZl3kLFAbWUbVel4s3uVKX2jJjPyHdnNqwGHXxY8v2xesdSv2yIkh20AOmeVtlQmb3XZGWYE+xydvD5ploV3x70hnwBA4U8B5Vxb1Xq3CzKFi/8EupNkaEWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzHXVBzX; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so830785a12.3
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 14:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723756535; x=1724361335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyXDrB7oqEab3qZlXrqgWfhm9DFDe5++s7+ZzYkIQxw=;
        b=BzHXVBzXQ/mg7E+Am8UelBJBM3nCXK2/B38fiTbJ0fw0qNvj+TQfc3kV4pkt13r5Ln
         Ia5UIwpVntGFeo2vfeWg9kS9yn0nqFMGLBEKaD5fNUAWMvxSTetoXqYkfLPoozZGdY99
         SPemvWAyeFBqewJhcTfA2ClbIK9TGMQQtD4VY88OC4zJKNWDr5CNZvkuYKJakIbuFUTV
         5vgiJeT2GS/vf8HLImjTdXN96NJWbOsONK4v3BodsViYi6q76dicfVy7HPGpeMMWngF1
         uc1p7RCnGRzmTbDPiYYEZ3UMty8n/Y5DWi3DpnOJ74mV8bjv5cvs4jtUwcYv/OjZ7xDj
         sk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723756535; x=1724361335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DyXDrB7oqEab3qZlXrqgWfhm9DFDe5++s7+ZzYkIQxw=;
        b=GyEUrCdU74YU6BDsv/0Mn9F+jCZE5do3vDWgn6gmvkghsJUhIqtsbhCEtETh6JfgCD
         h2LRV9V3kSPjvKTRm8PZM180lgxjXc8M3fpPav+hpMWjYZpU/w72sn9Nfhv5z52OZn9F
         epa8Kc7D1GQmHpEVYS3Zd8zW7Xeey4gEJlcfUIVYlj2/yJWz1jMFGUDm07RESk87hHvT
         BEmd8UVHYZ69QUED3VqjgluWbs6UjGHSPToo07GpxKHZGDV12QmfZQx7fRm7Ip3+XNRy
         S/79P0h4KBRn7cLWq7N7S33ObXIBoB3Q65GWNSZrUWsu3OdzGz2+iglHoVu225ybSEdy
         KN9g==
X-Gm-Message-State: AOJu0YxdQijCokW/2C31d3PNwR+bSJUpwZrlQnmt0gfP2+z2IvZiAbtM
	bx/QREjN11X1+iANyOt1L94fpIuRTgk3oDf0bsfwOnCCDRVNBX/tWREQxTaQt2utujYeTok+TbY
	Subp0qkmhd85xVR6KR91kcFMadAw=
X-Google-Smtp-Source: AGHT+IE79fMxmEunfiUTiQtKZoPQBVV5fReHBapE4bI+XEPTL6X4epURWpykD5r2jXZdcoYqfU/mKCSImJsQE1YJs9c=
X-Received: by 2002:a17:90a:c70c:b0:2d3:b8d6:d041 with SMTP id
 98e67ed59e1d1-2d3dfff5d65mr1028322a91.32.1723756534656; Thu, 15 Aug 2024
 14:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809010518.1137758-1-eddyz87@gmail.com> <20240809010518.1137758-5-eddyz87@gmail.com>
In-Reply-To: <20240809010518.1137758-5-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Aug 2024 14:15:21 -0700
Message-ID: <CAEf4Bza97Ksce2XYiQrvzYC5Lnqz68xWM+JvDeKMfj5M3pr+Rg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: validate jit behaviour for
 tail calls
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, hffilwlqm@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 6:05=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> A program calling sub-program which does a tail call.
> The idea is to verify instructions generated by jit for tail calls:
> - in program and sub-program prologues;
> - for subprogram call instruction;
> - for tail call itself.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/verifier.c       |   2 +
>  .../bpf/progs/verifier_tailcall_jit.c         | 103 ++++++++++++++++++
>  2 files changed, 105 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_tailcall_j=
it.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index f8f546eba488..cf3662dbd24f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -75,6 +75,7 @@
>  #include "verifier_stack_ptr.skel.h"
>  #include "verifier_subprog_precision.skel.h"
>  #include "verifier_subreg.skel.h"
> +#include "verifier_tailcall_jit.skel.h"
>  #include "verifier_typedef.skel.h"
>  #include "verifier_uninit.skel.h"
>  #include "verifier_unpriv.skel.h"
> @@ -198,6 +199,7 @@ void test_verifier_spin_lock(void)            { RUN(v=
erifier_spin_lock); }
>  void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr);=
 }
>  void test_verifier_subprog_precision(void)    { RUN(verifier_subprog_pre=
cision); }
>  void test_verifier_subreg(void)               { RUN(verifier_subreg); }
> +void test_verifier_tailcall_jit(void)         { RUN(verifier_tailcall_ji=
t); }
>  void test_verifier_typedef(void)              { RUN(verifier_typedef); }
>  void test_verifier_uninit(void)               { RUN(verifier_uninit); }
>  void test_verifier_unpriv(void)               { RUN(verifier_unpriv); }
> diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c b/=
tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
> new file mode 100644
> index 000000000000..1a09c76d7be0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +int main(void);
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> +       __uint(max_entries, 1);
> +       __uint(key_size, sizeof(__u32));
> +       __array(values, void (void));
> +} jmp_table SEC(".maps") =3D {
> +       .values =3D {
> +               [0] =3D (void *) &main,
> +       },
> +};
> +
> +__noinline __auxiliary
> +static __naked int sub(void)
> +{
> +       asm volatile (
> +       "r2 =3D %[jmp_table] ll;"
> +       "r3 =3D 0;"
> +       "call 12;"
> +       "exit;"
> +       :
> +       : __imm_addr(jmp_table)
> +       : __clobber_all);
> +}
> +
> +__success
> +/* program entry for main(), regular function prologue */
> +__jit_x86("    endbr64")
> +__jit_x86("    nopl    (%rax,%rax)")
> +__jit_x86("    xorq    %rax, %rax")
> +__jit_x86("    pushq   %rbp")
> +__jit_x86("    movq    %rsp, %rbp")

I'm a bit too lazy to fish it out of the code, so I'll just ask.
Does matching of __jit_x86() string behave in the same way as __msg().
I.e., there could be unexpected lines that would be skipped, as long
as we find a match for each __jit_x86() one?


Isn't that a bit counter-intuitive and potentially dangerous behavior
for checking disassembly? If my assumption is correct, maybe we should
add some sort of `__jit_x86("...")` placeholder to explicitly mark
that we allow some amount of lines to be skipped, but otherwise be
strict and require matching line-by-line?

> +/* tail call prologue for program:
> + * - establish memory location for tail call counter at &rbp[-8];
> + * - spill tail_call_cnt_ptr at &rbp[-16];
> + * - expect tail call counter to be passed in rax;
> + * - for entry program rax is a raw counter, value < 33;
> + * - for tail called program rax is tail_call_cnt_ptr (value > 33).
> + */
> +__jit_x86("    endbr64")
> +__jit_x86("    cmpq    $0x21, %rax")
> +__jit_x86("    ja      L0")
> +__jit_x86("    pushq   %rax")
> +__jit_x86("    movq    %rsp, %rax")
> +__jit_x86("    jmp     L1")
> +__jit_x86("L0: pushq   %rax")                  /* rbp[-8]  =3D rax      =
   */
> +__jit_x86("L1: pushq   %rax")                  /* rbp[-16] =3D rax      =
   */
> +/* on subprogram call restore rax to be tail_call_cnt_ptr from rbp[-16]
> + * (cause original rax might be clobbered by this point)
> + */
> +__jit_x86("    movq    -0x10(%rbp), %rax")
> +__jit_x86("    callq   0x[0-9a-f]\\+")         /* call to sub()         =
 */
> +__jit_x86("    xorl    %eax, %eax")
> +__jit_x86("    leave")
> +__jit_x86("    retq")
> +/* subprogram entry for sub(), regular function prologue */
> +__jit_x86("    endbr64")
> +__jit_x86("    nopl    (%rax,%rax)")
> +__jit_x86("    nopl    (%rax)")
> +__jit_x86("    pushq   %rbp")
> +__jit_x86("    movq    %rsp, %rbp")
> +/* tail call prologue for subprogram address of tail call counter
> + * stored at rbp[-16].
> + */
> +__jit_x86("    endbr64")
> +__jit_x86("    pushq   %rax")                  /* rbp[-8]  =3D rax      =
    */
> +__jit_x86("    pushq   %rax")                  /* rbp[-16] =3D rax      =
    */
> +__jit_x86("    movabsq $-0x[0-9a-f]\\+, %rsi") /* r2 =3D &jmp_table     =
    */
> +__jit_x86("    xorl    %edx, %edx")            /* r3 =3D 0              =
    */
> +/* bpf_tail_call implementation:
> + * - load tail_call_cnt_ptr from rbp[-16];
> + * - if *tail_call_cnt_ptr < 33, increment it and jump to target;
> + * - otherwise do nothing.
> + */
> +__jit_x86("    movq    -0x10(%rbp), %rax")
> +__jit_x86("    cmpq    $0x21, (%rax)")
> +__jit_x86("    jae     L0")
> +__jit_x86("    nopl    (%rax,%rax)")
> +__jit_x86("    addq    $0x1, (%rax)")          /* *tail_call_cnt_ptr +=
=3D 1 */
> +__jit_x86("    popq    %rax")
> +__jit_x86("    popq    %rax")
> +__jit_x86("    jmp     0x[0-9a-f]\\+")         /* jump to tail call tgt =
  */
> +__jit_x86("L0: leave")
> +__jit_x86("    retq")
> +SEC("tc")
> +__naked int main(void)
> +{
> +       asm volatile (
> +       "call %[sub];"
> +       "r0 =3D 0;"
> +       "exit;"
> +       :
> +       : __imm(sub)
> +       : __clobber_all);
> +}
> +
> +char __license[] SEC("license") =3D "GPL";
> --
> 2.45.2
>

