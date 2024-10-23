Return-Path: <bpf+bounces-42918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9009ACFE9
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 18:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B44B1F22320
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 16:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2181CBE8C;
	Wed, 23 Oct 2024 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cA4B6k0D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B30C1CACDD
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700134; cv=none; b=hJntYhD08e3UsmasYELF5zhtWMXMN9/pQ5zmZX48BgeESQqip6llM/1e+7xaflDNZogWfcwkFappCRx5j8edMfrJKde6g0Xqabttg2SXXi7BKUOlE6oLnwqwRIrWan30yYqKenFQyLpxPTZuYIVDbztSipMazh+O6LdvhsWGx74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700134; c=relaxed/simple;
	bh=4u8rRxbwaybGTdRCRNqJEZJBYRcRlyyXAr6ZELaXNRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WT8VIRd7Lb2+/7y2c3ylvVayTLzPkD735rPY4JPOEWZTBBVLk65xhLlG7D4L0BrYTYMEREB6yOD4Bi6HKV8Ypb/pvQDqTkwkqbBB4d/hDVf7IcRNpBRSm68F0Zuxyc8Xy9wwAn8uwraXcqPQdZdd0rbd09uhicmU422Tc5/atuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cA4B6k0D; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea9739647bso4874283a12.0
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 09:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729700132; x=1730304932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjBqbvlnGazZtmidiDIYon/9E8vuWGvNC6LtF1BTFJw=;
        b=cA4B6k0DNgToUQ0WnBSH2i9BpmYEV/sFVaQeSa5YTtBnGsQGWj4c7Dla4oONmbcjuA
         vrGVrdYn+HOjUV2EVx4DqXASh3V4++ZMs9JYfUxMHh9ohcdVy0Zeu5ebxW9mone3xKWH
         hTOnM1Ie1xlFbThXRSmYymSgCIHnKCLqR4YkgM31QzWkwxDwvY/Wdqd9k+56kEurq99Z
         YkQSU1uOpf9opX/R8RIizv6iLlMGRisEjX9CA187HEFYB0p0XpCUYANecXyA0u+meJ6V
         qi2tvi/Rgc0POnL4x9FvWo/jC39Fvkw+kkzR4DwnJ+lH1+VnFoWQuzKQeyTGyeTjIgOr
         Uq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729700132; x=1730304932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjBqbvlnGazZtmidiDIYon/9E8vuWGvNC6LtF1BTFJw=;
        b=w89f0GRHb0XIf0LxdzX0SWYuDIG7Jm/igDsBaISiDgM/591RlMW8PAGolFcr4eFInF
         KSciwO3T9J4/rjKvGG5DofFjdqdGA8ad8vagcobTp8bhIEvYjvkd9qWdpBS0mUzFkGLa
         DcGlqODf6qzCHE+TWjlxur8d+tGx6oNKbHnHv1cwiQeEK3X3Ypj5YFnlDsMg7lIfd5WC
         YnnljFlJjZx2rIMqs5FVsmX5+UZPv9n4eZT8Yag8lQQnpQJIKfZdxU7cjpqYo4W1fors
         BHpAmtlkss1zL7gyjRPxyk5Eh2lXTHwahkJxKt8hkNXhEoiFYNk5y9WAKCiVm2qHqQ29
         fj3A==
X-Gm-Message-State: AOJu0Yy2qkiNWA5nsAwl8WR0Vfo5w7Bg4jlmtsQAwAvVhNITCyOMTEm6
	ZDpbxqCfFhq4+uJtjcpedmo6RLVohrTSu3cLye2uMCG+sY8gOFTq/hBaFCf4crS7w+LHKgHCAam
	NyXP+B16Rf/Bnl7AjXGzbqYLrZ80=
X-Google-Smtp-Source: AGHT+IGGRO+NNKRKjackoBqMgU1z8ISHTDVr+QJBw7oCTQaasCY8d4zKWjKs2zruk8ImbzvPuZ6Wz8X9aDoVdKgrvno=
X-Received: by 2002:a05:6a21:9208:b0:1d8:a49b:ee71 with SMTP id
 adf61e73a8af0-1d978b32745mr3609451637.29.1729700132424; Wed, 23 Oct 2024
 09:15:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023022752.172005-1-houtao@huaweicloud.com>
In-Reply-To: <20241023022752.172005-1-houtao@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Oct 2024 09:15:20 -0700
Message-ID: <CAEf4BzZpL7faQh61X_pqr+57qxzDD1LcxWgUqNZCCKh1z5hV9w@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Extend the size of scratched_stack_slots to 128 bits
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 7:15=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> When the fastcall pattern is enabled for bpf helper or kfunc, the stack
> size limitation is increased from MAX_BPF_STACK (512 bytes) to
> MAX_BPF_STACK + CALLER_SAVED_REGS * BPF_REG_SIZE (560 bytes), as
> implemented in check_stack_slot_within_bounds(). This additional stack
> space is reserved for spilling and filling of caller saved registers.
>
> However, when marking a stack slot as scratched during spilling through
> mark_stack_slot_scratched(), a shift-out-of-bounds warning is reported
> as shown below. And it can be easily reproducted by running:
> ./test_progs -t verifier_bpf_fastcall/bpf_fastcall_max_stack_ok.
>
>   ------------[ cut here ]------------
>   UBSAN: shift-out-of-bounds in ../include/linux/bpf_verifier.h:942:37
>   shift exponent 64 is too large for 64-bit type 'long long unsigned int'
>   CPU: 1 UID: 0 PID: 5169 Comm: new_name Tainted: G ...  6.11.0-rc4+
>   Tainted: [O]=3DOOT_MODULE
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996) ...
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x8f/0xb0
>    dump_stack+0x10/0x20
>    ubsan_epilogue+0x9/0x40
>    __ubsan_handle_shift_out_of_bounds+0x10e/0x170
>    check_mem_access.cold+0x61/0x6d
>    do_check_common+0x2e2e/0x5da0
>    bpf_check+0x48a2/0x5750
>    bpf_prog_load+0xb2f/0x1250
>    __sys_bpf+0xd78/0x36b0
>    __x64_sys_bpf+0x45/0x60
>    x64_sys_call+0x1b2a/0x20d0
>
> However, the shift-out-of-bound issue doesn't seem to affect the output
> of scratched stack slots in the verifier log. For example, for
> bpf_fastcall_max_stack_ok, the 64-th stack slot is correctly marked as
> scratched, as shown in the verifier log:
>
>   2: (7b) *(u64 *)(r10 -520) =3D r1       ; R1_w=3D42 R10=3Dfp0 fp-520_w=
=3D42
>
> The reason relates to the compiler implementation. It appears that the
> shift exponent is taken modulo 64 before applying the shift, so after
> "slot =3D (1ULL << 64)", the value of slot becomes 1.
>
> Fix the UBSAN warning by extending the size of scratched_stack_slots
> from 64 bits to 128-bits.
>
> Fixes: 5b5f51bff1b6 ("bpf: no_caller_saved_registers attribute for helper=
 calls")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  include/linux/bpf_verifier.h | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 4513372c5bc8..1bb6c6def04d 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -773,8 +773,11 @@ struct bpf_verifier_env {
>          * since the last time the function state was printed
>          */
>         u32 scratched_regs;
> -       /* Same as scratched_regs but for stack slots */
> -       u64 scratched_stack_slots;
> +       /* Same as scratched_regs but for stack slots. The stack size may
> +        * temporarily exceed MAX_BPF_STACK (e.g., due to fastcall patter=
n
> +        * in check_stack_slot_within_bounds()), so two u64 values are us=
ed.
> +        */
> +       u64 scratched_stack_slots[2];

We have other places where we assume that 64 bits is enough to specify
stack slot index (linked regs, for instance). Do we need to update all
of those now as well? If yes, maybe then it's better to make sure
valid programs can never go beyond 512 bytes of stack even for
bpf_fastcall?..

>         u64 prev_log_pos, prev_insn_print_pos;
>         /* buffer used to temporary hold constants as scalar registers */
>         struct bpf_reg_state fake_reg[2];
> @@ -939,7 +942,7 @@ static inline void mark_reg_scratched(struct bpf_veri=
fier_env *env, u32 regno)
>
>  static inline void mark_stack_slot_scratched(struct bpf_verifier_env *en=
v, u32 spi)
>  {
> -       env->scratched_stack_slots |=3D 1ULL << spi;
> +       env->scratched_stack_slots[spi / 64] |=3D 1ULL << (spi & 63);
>  }
>
>  static inline bool reg_scratched(const struct bpf_verifier_env *env, u32=
 regno)
> @@ -949,25 +952,28 @@ static inline bool reg_scratched(const struct bpf_v=
erifier_env *env, u32 regno)
>
>  static inline bool stack_slot_scratched(const struct bpf_verifier_env *e=
nv, u64 regno)
>  {
> -       return (env->scratched_stack_slots >> regno) & 1;
> +       return (env->scratched_stack_slots[regno / 64] >> (regno & 63)) &=
 1;
>  }
>
>  static inline bool verifier_state_scratched(const struct bpf_verifier_en=
v *env)
>  {
> -       return env->scratched_regs || env->scratched_stack_slots;
> +       return env->scratched_regs || env->scratched_stack_slots[0] ||
> +              env->scratched_stack_slots[1];
>  }
>
>  static inline void mark_verifier_state_clean(struct bpf_verifier_env *en=
v)
>  {
>         env->scratched_regs =3D 0U;
> -       env->scratched_stack_slots =3D 0ULL;
> +       env->scratched_stack_slots[0] =3D 0ULL;
> +       env->scratched_stack_slots[1] =3D 0ULL;
>  }
>
>  /* Used for printing the entire verifier state. */
>  static inline void mark_verifier_state_scratched(struct bpf_verifier_env=
 *env)
>  {
>         env->scratched_regs =3D ~0U;
> -       env->scratched_stack_slots =3D ~0ULL;
> +       env->scratched_stack_slots[0] =3D ~0ULL;
> +       env->scratched_stack_slots[1] =3D ~0ULL;
>  }
>
>  static inline bool bpf_stack_narrow_access_ok(int off, int fill_size, in=
t spill_size)
> --
> 2.29.2
>

