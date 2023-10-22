Return-Path: <bpf+bounces-12922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D397D210A
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 07:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2446528175D
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 05:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80790EDA;
	Sun, 22 Oct 2023 05:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Su7E2SO7"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2983136A
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 04:59:58 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F27EDA;
	Sat, 21 Oct 2023 21:59:57 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53e84912038so3119925a12.1;
        Sat, 21 Oct 2023 21:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697950795; x=1698555595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBySzR+l1+gpl5uLMz6UdtdL0sUeapQTO47B6XYiJBQ=;
        b=Su7E2SO73F9YgURqDnjV1kOTpHiJLfnjyMelXzf+2VkrnWyW33GMAZPxwwGgKeFUXU
         KrwB4gtyrQ1ObfXY5QdrmcKFl8FCB+tFUvLPdImlmrdvOTXgJ0ZopKo/cmHkhVNfDxNb
         XuZvU8gcY3N1mqPpMydvqFbnbHUfBweu+Zdkda7Fwss/BJyTJZDJOJF6J197balKL0eT
         GeYPu9J49StjRkdhFzrBDZ18Zjt1wEO88LGHglvlIICyUi1Paq5FGEd+itlDAGFWppqQ
         CgjRu4cgHnbtsFUK5SzxopW9vy/eYNCUKn55r5ZZCqa5U3nzPGQtI484DSFzLo7Elw7B
         AdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697950795; x=1698555595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBySzR+l1+gpl5uLMz6UdtdL0sUeapQTO47B6XYiJBQ=;
        b=qMlYxiMc+DR/rWx7LhlUfxKuYoF24oVzwP9DPutWDiSrMVWUmnDdRTA4IUXY2fa3f6
         U81Q8/QsoDHu4Nwk0ks+Re+MHu/jHm0EWWnxd0cnBKcC7dfCQe60yxZZ8frXH9LTkKQO
         pA7jNgJWuJFcVcxgCzyqv2cWDdl9IO5rOMTS8kK8TmBg1KZvFgJaM1aweQMAamm6DAp9
         N+90QtlS6z09CSba48k9WyeU7LAjnNSKj9tJObwHqKTmceBbq8Ld0xeRKFCdXI3ywqXI
         +4EAw8cJm9ifXnJ6CQhc2SybIrd+2z/YhNfUwYjyZKL/mzcoELdBZt6bC5LuRLT8xHMQ
         nB4A==
X-Gm-Message-State: AOJu0YwWAEsaOGTev5XzDKv4vIQeU6kzVS782ykevW7GAnl/i/z+jR48
	mxPxzId5jJjbJ2MC51FVDs++YTmdlQ23mM3ib/o=
X-Google-Smtp-Source: AGHT+IGMKsonpyWMlgeANbElGK30CcxRJYitihsHXOD6l1tgr6e0cQqqaoebSrSchWN9K787aJOIdGmHNFIzjl0BrfI=
X-Received: by 2002:a17:906:ee8a:b0:9b7:2a13:160c with SMTP id
 wt10-20020a170906ee8a00b009b72a13160cmr4126038ejb.69.1697950795485; Sat, 21
 Oct 2023 21:59:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020155842.130257-1-tao.lyu@epfl.ch>
In-Reply-To: <20231020155842.130257-1-tao.lyu@epfl.ch>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 21 Oct 2023 21:59:44 -0700
Message-ID: <CAEf4BzaqOt8DyB781geXYfrosmgQCkzDOCOH8WBVmCAPs+wQBw@mail.gmail.com>
Subject: Re: [PATCH] Incorrect backtracking for load/store or atomic ops
To: Tao Lyu <tao.lyu@epfl.ch>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org, 
	security@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, sanidhya.kashyap@epfl.ch, 
	mathias.payer@nebelwelt.net, meng.xu.cs@uwaterloo.ca, 
	kartikeya.dwivedi@epfl.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 9:06=E2=80=AFAM Tao Lyu <tao.lyu@epfl.ch> wrote:
>
> Hi,
>
> I found the backtracking logic of the eBPF verifier is flawed
> when meeting 1) normal load and store instruction or
> 2) atomic memory instructions.
>
> # Normal load and store
>
> Here, I show one case about the normal load and store instructions,
> which can be exploited to achieve arbitrary read and write with two requi=
rements:
> 1) The uploading program should have at least CAP_BPF, which is required =
for most eBPF applications.
> 2) Disable CPU mitigations by adding "mitigations=3Doff" in the kernel bo=
oting command line. Otherwise,
> the Spectre mitigation in the eBPF verifier will prevent exploitation.
>
>                                    1: r3 =3D r10 (stack pointer)
>                                    3:           if cond
>                                                  /           \
>                                                /                \
>         4: *(u64 *)(r3 -120) =3D 200      6: *(u64 *)(r3 -120) =3D arbitr=
ary offset to r2
>                  verification state 1                  verification state=
 2 (prune point)
>                                               \                  /
>                                                 \              /
>                                       7:  r6 =3D *(u64 *)(r1 -120)
>                                                          ...
>                                     17:    r7 =3D a map pointer
>                                     18:            r7 +=3D r6
>                          // Out-of-bound access from the right side path
>
> Give an eBPF program (tools/testing/selftests/bpf/test_precise.c)
> whose simplified control flow graph looks like the above.
> When the verifier goes through the first (left-side) path and reaches ins=
n 18,
> it will backtrack on register 6 like below.
>
> 18: (0f) r7 +=3D r6
> mark_precise: frame0: last_idx 18 first_idx 17 subseq_idx -1
> mark_precise: frame0: regs=3Dr6 stack=3D before 17: (bf) r7 =3D r0
> ...
> mark_precise: frame0: regs=3Dr6 stack=3D before 7: (79) r6 =3D *(u64 *)(r=
3 -120)
>
> However, the backtracking process is problematic when it reaches insn 7.
> Insn 7 is to load a value from the stack, but the stack pointer is repres=
ented by r3 instead of r10.
> ** In this case, the verifier (as shown below) will reset the precision o=
n r6 and not mark the precision on the stack. **
> Afterward, the backtracking finishes without annotating any registers in =
any verifier states.
>
>     else if (class =3D=3D BPF_LDX) {
>         if (!bt_is_reg_set(bt, dreg))
>             return 0;
>         bt_clear_reg(bt, dreg);
>         if (insn->src_reg !=3D BPF_REG_FP)
>             return 0;
>         ...
>    }
>
> Finally, when the second (left-side) path reaches insn 7 again,
> it will compare the verifier states with the previous one.
> However, it realizes these two states are equal because no precision is o=
n r6,
> thus the eBPF program an easily pass the verifier
> although the second path contains an invalid access offset.
> We have successfully exploited this bug for getting the root privilege.
> If needed, we can share the exploitation.
> BTW, when using the similar instructions in sub_prog can also trigger an =
assertion in the verifier:
> "[ 1510.165537] verifier backtracking bug
> [ 1510.165582] WARNING: CPU: 2 PID: 382 at kernel/bpf/verifier.c:3626 __m=
ark_chain_precision+0x4568/0x4e50"
>
>
>
> IMO, to fully patch this bug, we need to know whether the insn->src_reg i=
s an alias of BPF_REG_FP.

Yes!

> However, it might need too much code addition.

No :) I don't think it's a lot of code. I've been meaning to tackle
this for a while, but perhaps the time is now.

The plan is to use jmp_history to record an extra flags for some
instructions (even if they are not jumps). Like in this case, we can
remember for LDX and STX instructions that they were doing register
load/spill, and take that into account during backtrack_insn() without
having to guess based on r10.

I have part of this ready locally, I'll try to finish this up in a
next week or two. Stay tuned (unless you want to tackle that
yourself).

> Or we just do not clear the precision on the src register.
>
> # Atomic memory instructions
>
> Then, I show that the backtracking on atomic load and store is also flawe=
d.
> As shown below, when the backtrack_insn() function in the verifier meets =
store instructions,
> it checks if the stack slot is set with precision or not. If not, just re=
turn.
>
>             if (!bt_is_slot_set(bt, spi))
>                 return 0;
>             bt_clear_slot(bt, spi);
>             if (class =3D=3D BPF_STX)
>                 bt_set_reg(bt, sreg);
>
> Assume we have an atomic_fetch_or instruction (tools/testing/selftests/bp=
f/verifier/atomic_precision.c) shown below.
>
> 7: (4c) w7 |=3D w3
> mark_precise: frame1: last_idx 7 first_idx 0 subseq_idx -1
> mark_precise: frame1: regs=3Dr7 stack=3D before 6: (c3) r7 =3D atomic_fet=
ch_or((u32 *)(r10 -120), r7)
> mark_precise: frame1: regs=3Dr7 stack=3D before 5: (bf) r7 =3D r10
> mark_precise: frame1: regs=3Dr10 stack=3D before 4: (7b) *(u64 *)(r3 -120=
) =3D r1
> mark_precise: frame1: regs=3Dr10 stack=3D before 3: (bf) r3 =3D r10
> mark_precise: frame1: regs=3Dr10 stack=3D before 2: (b7) r1 =3D 1000
> mark_precise: frame1: regs=3Dr10 stack=3D before 0: (85) call pc+1
> BUG regs 400
>
> Before backtracking to it, r7 has already been marked as precise.
> Since the value of r7 after atomic_fecth_or comes from r10-120,
> it should propagate the precision to r10-120.
> However, because the stack slot r10-120 is not marked,
> it doesn't satisfy bt_is_slot_set(bt, spi) condition shown above.
> Finally, it just returns without marking r10-120 as precise.

this seems like the same issue with not recognizing stack access
through any other register but r10?

Or is there something specific to atomic instructions here? I'm not
very familiar with them, so I'll need to analyse the code first.

>
> This bug can lead to the verifier's assertion as well:
> "[ 1510.165537] verifier backtracking bug
> [ 1510.165582] WARNING: CPU: 2 PID: 382 at kernel/bpf/verifier.c:3626 __m=
ark_chain_precision+0x4568/0x4e50"
>
> I've attached the patch for correctly propagating the precision on atomic=
 instructions.
> But it still can't solve the problem that the stack slot is expressed wit=
h other registers instead of r10.

I can try to solve stack access through non-r10, but it would be very
useful if you could provide tests that trigger the above situations
you described. Your test_precise.c test below is not the right way to
add tests, it adds a new binary and generally doesn't fit into
existing set of tests inside test_progs. Please see
progs/verifier_xadd.c and prog_tests/verifier.c and try to convert
your tests into that form (you also will be able to use inline
assembly instead of painful BPF_xxx() instruction macros).

Thanks.

>
> Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
> ---
>  kernel/bpf/verifier.c                         |  58 +++++-
>  tools/testing/selftests/bpf/Makefile          |   6 +-
>  tools/testing/selftests/bpf/test_precise.c    | 186 ++++++++++++++++++
>  .../selftests/bpf/verifier/atomic_precision.c |  19 ++
>  4 files changed, 263 insertions(+), 6 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/test_precise.c
>  create mode 100644 tools/testing/selftests/bpf/verifier/atomic_precision=
.c
>

[...]

