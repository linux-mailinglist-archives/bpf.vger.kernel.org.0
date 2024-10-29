Return-Path: <bpf+bounces-43434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F93A9B55AA
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 23:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16421C20B93
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 22:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135BA20ADC5;
	Tue, 29 Oct 2024 22:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMsVeM5Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B58206E61
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 22:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730240273; cv=none; b=ahfIk7m2LjTM9QsNwyXnlD3B/tA9g+nKDpEhppDN+RE95H1wKvT+JRirhIHD3CCFMbHSgm7r0LQaskq/7triwXdrKH1+wEf06inSDtCOBvjy+xLmcWkIgfRYBLyC2MaRAgMq4mCtVCAgmaXAY8D+eLucPpWhhZXZraaLpVJPgd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730240273; c=relaxed/simple;
	bh=0C5TalIrfBjgMojPb6Y3zU21zF8/Fakv/XG1ZlxG4yA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5p5jGHv61hJZrufCcfamRxeuCnmJmZiTJ2i5ee4v1BkfGEefobhilecpHVXKLsj3IROJvFRlU+yQWI1UiE0L6MjTIzRtkUqK2rJtMgYEw0p6GMUpo5F16N/N1wESDHEClAt5bQC6bThnP6H0wgCqOuAUG7uE0y2SlDnzQsDL5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMsVeM5Z; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-720aa3dbda5so388370b3a.1
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 15:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730240271; x=1730845071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfXoY+PsOCrThveVcjwMP/5VExdUfxAxPNa/avTzze0=;
        b=bMsVeM5ZXmiWkAq4XnaV4uONxtoItm4I9X+GQlMrfBp3Tq9zdHrKT8L/jZJtJpW1Fs
         1HFuKrAXHpNY/fPqrjoFC9ro/nWmuVhq3vO29iRUthbL8ziWlbfHkZfB75qNnN+/QphO
         iAUjZ0iX2R5UoFFKnUtsJttt2yxaKMmeb19Y7y3wuj9f6j7Gux4JnyiTtPYy1A1BdhM4
         SrObguNgG+GEpusGTPeFdtFZKi1VExH8pwRCWumGgB/JxCBTA/GR1lxuCArSPinVYPRk
         c7VAqn4BPy9fycffs1N27884UFFR7rr9CQauk6nngGoYaDUab9FqeBYcr/5sOPyhlwOv
         Bofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730240271; x=1730845071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfXoY+PsOCrThveVcjwMP/5VExdUfxAxPNa/avTzze0=;
        b=rQS24SaYsNmso7ljUhsUV9mh3iUBEOeQ7vx+1mZLKr8l0H5T0zhp4PPhcQCHuga9kq
         2mWuC0JR2jHXF7KLk5kjqMklEgi2LMCxCRf7jltblelfu9vNV/svB5urAPirRGSoExB5
         cLkykxRZtP/hcf5YJVGBZVMDREIkmyoAgHSYuMpTOyJHlYgUdlcJyTUor1dD/GrF4W5/
         2Iv8i6VDiZATclmmyPOvq96Jd4FIW9zvEIRr54l2UqXDNwd4LTDR47BpbAkq5MJRvtEb
         HhPCrurtG4tyE50MnOf+uh9REMDDBh9BsAphrASNAMbDJvxb4DgrRe2Qz3mVLhaiTvYx
         Ipiw==
X-Gm-Message-State: AOJu0Ywj0HC8dxrd7EUAPIvuYbwzp29TbY86OxpMhTCizpTyPuQa4p7f
	x1BGWIOC/KZcpI1Rzyy9Ov84CZeQjyj63wFaR7qR0MAFqeiLaG72H01sHQHCkAWeAyUpvaktcbd
	nJZDXoTdkad3SGIlzTTGhW1PGH4w=
X-Google-Smtp-Source: AGHT+IEbioHmXOL6opwJR+oCiUXGhzZNvxKVOArBmqbbcX5/HfcNem8sncvJ7QjsQj0X6iHb5WvbAB+oFfLppx+lG+Q=
X-Received: by 2002:a05:6a00:2191:b0:71e:44f6:6900 with SMTP id
 d2e1a72fcca58-720ab3f39d8mr1365606b3a.16.1730240270687; Tue, 29 Oct 2024
 15:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029193911.1575719-1-eddyz87@gmail.com>
In-Reply-To: <20241029193911.1575719-1-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 29 Oct 2024 15:17:38 -0700
Message-ID: <CAEf4Bzac+bFC77190DT38BTVnfC=oJP648KWW_+SmQWZEmfMmA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: disallow 40-bytes extra stack for bpf_fastcall patterns
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, Hou Tao <houtao@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 12:39=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> Hou Tao reported an issue with bpf_fastcall patterns allowing extra
> stack space above MAX_BPF_STACK limit. This extra stack allowance is
> not integrated properly with the following verifier parts:
> - backtracking logic still assumes that stack can't exceed
>   MAX_BPF_STACK;
> - bpf_verifier_env->scratched_stack_slots assumes only 64 slots are
>   available.
>
> Here is an example of an issue with precision tracking
> (note stack slot -8 tracked as precise instead of -520):
>
>     0: (b7) r1 =3D 42                       ; R1_w=3D42
>     1: (b7) r2 =3D 42                       ; R2_w=3D42
>     2: (7b) *(u64 *)(r10 -512) =3D r1       ; R1_w=3D42 R10=3Dfp0 fp-512_=
w=3D42
>     3: (7b) *(u64 *)(r10 -520) =3D r2       ; R2_w=3D42 R10=3Dfp0 fp-520_=
w=3D42
>     4: (85) call bpf_get_smp_processor_id#8       ; R0_w=3Dscalar(...)
>     5: (79) r2 =3D *(u64 *)(r10 -520)       ; R2_w=3D42 R10=3Dfp0 fp-520_=
w=3D42
>     6: (79) r1 =3D *(u64 *)(r10 -512)       ; R1_w=3D42 R10=3Dfp0 fp-512_=
w=3D42
>     7: (bf) r3 =3D r10                      ; R3_w=3Dfp0 R10=3Dfp0
>     8: (0f) r3 +=3D r2
>     mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx -1
>     mark_precise: frame0: regs=3Dr2 stack=3D before 7: (bf) r3 =3D r10
>     mark_precise: frame0: regs=3Dr2 stack=3D before 6: (79) r1 =3D *(u64 =
*)(r10 -512)
>     mark_precise: frame0: regs=3Dr2 stack=3D before 5: (79) r2 =3D *(u64 =
*)(r10 -520)
>     mark_precise: frame0: regs=3D stack=3D-8 before 4: (85) call bpf_get_=
smp_processor_id#8
>     mark_precise: frame0: regs=3D stack=3D-8 before 3: (7b) *(u64 *)(r10 =
-520) =3D r2
>     mark_precise: frame0: regs=3Dr2 stack=3D before 2: (7b) *(u64 *)(r10 =
-512) =3D r1
>     mark_precise: frame0: regs=3Dr2 stack=3D before 1: (b7) r2 =3D 42
>     9: R2_w=3D42 R3_w=3Dfp42
>     9: (95) exit
>
> This patch disables the additional allowance for the moment.
> Also, two test cases are removed:
> - bpf_fastcall_max_stack_ok:
>   it fails w/o additional stack allowance;
> - bpf_fastcall_max_stack_fail:
>   this test is no longer necessary, stack size follows
>   regular rules, pattern invalidation is checked by other
>   test cases.
>
> Reported-by: Hou Tao <houtao@huaweicloud.com>
> Closes: https://lore.kernel.org/bpf/20241023022752.172005-1-houtao@huawei=
cloud.com/
> Fixes: 5b5f51bff1b6 ("bpf: no_caller_saved_registers attribute for helper=
 calls")
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/verifier.c                         | 14 +----
>  .../bpf/progs/verifier_bpf_fastcall.c         | 55 -------------------
>  2 files changed, 2 insertions(+), 67 deletions(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 587a6c76e564..a494396bef2a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6804,20 +6804,10 @@ static int check_stack_slot_within_bounds(struct =
bpf_verifier_env *env,
>                                            struct bpf_func_state *state,
>                                            enum bpf_access_type t)
>  {
> -       struct bpf_insn_aux_data *aux =3D &env->insn_aux_data[env->insn_i=
dx];
> -       int min_valid_off, max_bpf_stack;
> -
> -       /* If accessing instruction is a spill/fill from bpf_fastcall pat=
tern,
> -        * add room for all caller saved registers below MAX_BPF_STACK.
> -        * In case if bpf_fastcall rewrite won't happen maximal stack dep=
th
> -        * would be checked by check_max_stack_depth_subprog().
> -        */
> -       max_bpf_stack =3D MAX_BPF_STACK;
> -       if (aux->fastcall_pattern)
> -               max_bpf_stack +=3D CALLER_SAVED_REGS * BPF_REG_SIZE;
> +       int min_valid_off;
>
>         if (t =3D=3D BPF_WRITE || env->allow_uninit_stack)
> -               min_valid_off =3D -max_bpf_stack;
> +               min_valid_off =3D -MAX_BPF_STACK;
>         else
>                 min_valid_off =3D -state->allocated_stack;
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/=
tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
> index 9da97d2efcd9..5094c288cfd7 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
> @@ -790,61 +790,6 @@ __naked static void cumulative_stack_depth_subprog(v=
oid)
>         :: __imm(bpf_get_smp_processor_id) : __clobber_all);
>  }
>
> -SEC("raw_tp")
> -__arch_x86_64
> -__log_level(4)
> -__msg("stack depth 512")
> -__xlated("0: r1 =3D 42")
> -__xlated("1: *(u64 *)(r10 -512) =3D r1")
> -__xlated("2: w0 =3D ")
> -__xlated("3: r0 =3D &(void __percpu *)(r0)")
> -__xlated("4: r0 =3D *(u32 *)(r0 +0)")
> -__xlated("5: exit")
> -__success
> -__naked int bpf_fastcall_max_stack_ok(void)
> -{
> -       asm volatile(
> -       "r1 =3D 42;"
> -       "*(u64 *)(r10 - %[max_bpf_stack]) =3D r1;"
> -       "*(u64 *)(r10 - %[max_bpf_stack_8]) =3D r1;"
> -       "call %[bpf_get_smp_processor_id];"
> -       "r1 =3D *(u64 *)(r10 - %[max_bpf_stack_8]);"
> -       "exit;"
> -       :
> -       : __imm_const(max_bpf_stack, MAX_BPF_STACK),
> -         __imm_const(max_bpf_stack_8, MAX_BPF_STACK + 8),
> -         __imm(bpf_get_smp_processor_id)
> -       : __clobber_all
> -       );
> -}
> -
> -SEC("raw_tp")
> -__arch_x86_64
> -__log_level(4)
> -__msg("stack depth 520")
> -__failure
> -__naked int bpf_fastcall_max_stack_fail(void)
> -{
> -       asm volatile(
> -       "r1 =3D 42;"
> -       "*(u64 *)(r10 - %[max_bpf_stack]) =3D r1;"
> -       "*(u64 *)(r10 - %[max_bpf_stack_8]) =3D r1;"
> -       "call %[bpf_get_smp_processor_id];"
> -       "r1 =3D *(u64 *)(r10 - %[max_bpf_stack_8]);"
> -       /* call to prandom blocks bpf_fastcall rewrite */
> -       "*(u64 *)(r10 - %[max_bpf_stack_8]) =3D r1;"
> -       "call %[bpf_get_prandom_u32];"
> -       "r1 =3D *(u64 *)(r10 - %[max_bpf_stack_8]);"
> -       "exit;"
> -       :
> -       : __imm_const(max_bpf_stack, MAX_BPF_STACK),
> -         __imm_const(max_bpf_stack_8, MAX_BPF_STACK + 8),
> -         __imm(bpf_get_smp_processor_id),
> -         __imm(bpf_get_prandom_u32)
> -       : __clobber_all
> -       );
> -}
> -
>  SEC("cgroup/getsockname_unix")
>  __xlated("0: r2 =3D 1")
>  /* bpf_cast_to_kern_ctx is replaced by a single assignment */
> --
> 2.47.0
>

