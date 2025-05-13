Return-Path: <bpf+bounces-58122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E69AB57B8
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 16:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7387E7B691B
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 14:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0A01C701A;
	Tue, 13 May 2025 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+EVOyoo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F92F1C5499
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148113; cv=none; b=K/Ytlbiy4xODI4fg4eIL8GWHm+yyvuPQmSo+PtdA7lnZ4uGIAWBWXquFl4RB5SdQYalRA3v2x/1HmsdWkZPjrMgZrZLRFF2FxK/Fod1KsiTPtTvRxTrfNKsT1MbJoQmZ0Jy6dF5Cv0vcu2eQ+WkHT5e1lC6SgplNaitogb7oRWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148113; c=relaxed/simple;
	bh=GbY5xlsM61JF/NINTN4NzF5xDLJoKmxQkfb0d4XSbsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9+Dd0mCrXQYlaR4cqmrq9CbEA5CRUQxEN8hdxvU0iiL0ig0x5I/DhgLaWNBgxifHtbYYan015wdJR0wnfrU/5CW8YYiTXu7YZenKMS2Axuk/N011n20sJgzMUbGDIoC1PTmBz/IZ/1GF0paDHpkOK2oQ8FI0fISWYzX8eI5XKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+EVOyoo; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a108684f90so3503724f8f.1
        for <bpf@vger.kernel.org>; Tue, 13 May 2025 07:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747148110; x=1747752910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmpP3W8hF50ihQEXJgEH5iooGlB7pZXVv27qa4Wn2/8=;
        b=G+EVOyoo9fURLMMY+mH8TSM/MY+YqavSfzgUCa9mo7322TGobK9KB8x9WPPcFzTjgh
         5UX4bQP7zCeEVUdaDTRuTkREIf7Cwk9mJMGc46LWgTnunRiqu5tuXRHjuAOjtcS+fuVv
         jxCWsBqUt/3pI91hK9isVFeDbZkGKgZO/VD6XjP+XNKhkMDJ8AewgxdfsrVyq5naJnAi
         CVTdLfY9qoABiHqlKcXViLXCNeNG5aiq3HAn4M3GiWanXRC5laHX1c5sJxJaUINKtLqp
         mxd4u0W0Zn1QQyJtXqW4FwwiZPryWgNYvtAh/tZ+E4I2FAbhShdQiKnmW4UAdJgKIxsz
         FPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747148110; x=1747752910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmpP3W8hF50ihQEXJgEH5iooGlB7pZXVv27qa4Wn2/8=;
        b=MCiVVwghmc2vqpQiJ2A2TO4uUC8RMiZzrQ0zdCVW0dhArCGRxESxAhLvzffaJN/kOf
         /feH+IXrgzUkCiiubD6UJ0RdS3/4n6M2kYRdtITEfWQRs7MX+or9IQepy8GVpNQri8yq
         wDTtBStOsYpSxJElU2u0jPryUKT2QQGEPkTSvxQxG6vj3mCEqlZbk9etUlPMwrXtnpZZ
         uwg5seCO38D2lIeRZUt6Kue/tfUM/s7LwGrTUHD4HMqPsYyI/g256e6BanuHNVdToI8O
         FTJ/En7KXVmIJefdCyYJZe8w3zIZA7GVOyyhJHiNZ+8al4Q4YhSaNSa9H96k+BHuqYMS
         zu5w==
X-Gm-Message-State: AOJu0YxPpMVMhi/SuYZQT1vrjn6XzN3DNk7i71ddiXb+GZ3HOJtRnro8
	pJgdi0RMlXNX7fklRgsnjfKTwFwZbStrCW0lpM5EtJ1W6KZh4xAM81679Wt2pk3FOpDcNEj87w9
	4gSbWwre864L7pOD0dfTJbK083bU=
X-Gm-Gg: ASbGnct2AFJKFJMv45aETZ0v2t5TNnfmL1L8dQd9+O/GNLQYzJ4UValJDTlyYAVrvft
	p1fYwDCwr5MZejgNRfGbxcj9YaRlxNSMP+rs2UJnYQB6C6CBGJ/E7vnVZLWweQv1C62Yr7uQSF6
	EbAcrUXN/kgnjVbaooytBMfw89W40OQ/lXZA82MkYsIakeh199
X-Google-Smtp-Source: AGHT+IHwHJGN761OxSl7ZWJ5EWEj7OIn6ig9dXHtYOAYFbu3Vh4DGGWeuQsvtGVV5tatNPzvnDu5H9L8FIQXI4GAROc=
X-Received: by 2002:a05:6000:40dc:b0:391:3aab:a7d0 with SMTP id
 ffacd0b85a97d-3a1f64314d3mr13552231f8f.19.1747148109617; Tue, 13 May 2025
 07:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511182744.1806792-1-yonghong.song@linux.dev>
 <CAADnVQKi30n+BkRpWKztBnFJ1tsejJYE6f=XtGUodvozZar6PA@mail.gmail.com> <a07347c2-3941-4d21-a8d2-9e957ad8368b@linux.dev>
In-Reply-To: <a07347c2-3941-4d21-a8d2-9e957ad8368b@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 May 2025 07:54:58 -0700
X-Gm-Features: AX0GCFslzxS13a6zMUw0qxoyOrZzRHZaFAHe0ERGXSFU8T1LkdQOOlaY6sotqCw
Message-ID: <CAADnVQJr1WCQ9UE91cbO3jjd3jn4he9SZuZgsdLy3+HOdjviLQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Warn with new bpf_unreachable() kfunc
 maybe due to uninitialized var
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 10:49=E2=80=AFPM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
>
>
> On 5/11/25 8:30 AM, Alexei Starovoitov wrote:
> > On Sun, May 11, 2025 at 11:28=E2=80=AFAM Yonghong Song <yonghong.song@l=
inux.dev> wrote:
> >> Marc Su=C3=B1=C3=A9 (Isovalent, part of Cisco) reported an issue where=
 an
> >> uninitialized variable caused generating bpf prog binary code not
> >> working as expected. The reproducer is in [1] where the flags
> >> =E2=80=9C-Wall -Werror=E2=80=9D are enabled, but there is no warning a=
nd compiler
> >> may take advantage of uninit variable to do aggressive optimization.
> >>
> >> In llvm internals, uninitialized variable usage may generate
> >> 'unreachable' IR insn and these 'unreachable' IR insns may indicate
> >> uninit var impact on code optimization. With clang21 patch [2],
> >> those 'unreachable' IR insn are converted to func bpf_unreachable().
> >>
> >> In kernel, a new kfunc bpf_unreachable() is added. If this kfunc
> >> (generated by [2]) is the last insn in the main prog or a subprog,
> >> the verifier will suggest the verification failure may be due to
> >> uninitialized var, so user can check their source code to find the
> >> root cause.
> >>
> >> Without this patch, the verifier will output
> >>    last insn is not an exit or jmp
> >> and user will not know what is the potential root cause and
> >> it will take more time to debug this verification failure.
> >>
> >>    [1] https://github.com/msune/clang_bpf/blob/main/Makefile#L3
> >>    [2] https://github.com/llvm/llvm-project/pull/131731
> >>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >>   kernel/bpf/helpers.c  |  5 +++++
> >>   kernel/bpf/verifier.c | 17 ++++++++++++++++-
> >>   2 files changed, 21 insertions(+), 1 deletion(-)
> >>
> >> In order to compile kernel successfully with the above [2], the follow=
ing
> >> change is needed due to clang21 changes:
> >>
> >>    --- a/Makefile
> >>    +++ b/Makefile
> >>    @@ -852,7 +852,7 @@ endif
> >>     endif # may-sync-config
> >>     endif # need-config
> >>
> >>    -KBUILD_CFLAGS  +=3D -fno-delete-null-pointer-checks
> >>    +KBUILD_CFLAGS  +=3D -fno-delete-null-pointer-checks -Wno-default-c=
onst-init-field-unsafe
> >>
> >>    --- a/scripts/Makefile.extrawarn
> >>    +++ b/scripts/Makefile.extrawarn
> >>    @@ -19,6 +19,7 @@ KBUILD_CFLAGS +=3D $(call cc-disable-warning, fra=
me-address)
> >>     KBUILD_CFLAGS +=3D $(call cc-disable-warning, address-of-packed-me=
mber)
> >>     KBUILD_CFLAGS +=3D -Wmissing-declarations
> >>     KBUILD_CFLAGS +=3D -Wmissing-prototypes
> >>    +KBUILD_CFLAGS +=3D -Wno-default-const-init-var-unsafe
> >>
> >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >> index fed53da75025..6048d7e19d4c 100644
> >> --- a/kernel/bpf/helpers.c
> >> +++ b/kernel/bpf/helpers.c
> >> @@ -3283,6 +3283,10 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned=
 long *flags__irq_flag)
> >>          local_irq_restore(*flags__irq_flag);
> >>   }
> >>
> >> +__bpf_kfunc void bpf_unreachable(void)
> >> +{
> >> +}
> > Does it have to be an actual function with the body?
> > Can it be a kfunc that doesn't consume any .text ?
>
> I tried to define bpf_unreachable as an extern function, but
> it does not work as a __bpf_kfunc. I agree that we do not
> need to consume any bytes in .text section for bpf_unreachable.
> I have not found a solution for that yet.

Have you tried marking it as 'naked' and empty body?

> >
> >> +
> >>   __bpf_kfunc_end_defs();
> >>
> >>   BTF_KFUNCS_START(generic_btf_ids)
> >> @@ -3388,6 +3392,7 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_=
ITER_NEXT | KF_RET_NULL | KF_SLE
> >>   BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF=
_SLEEPABLE)
> >>   BTF_ID_FLAGS(func, bpf_local_irq_save)
> >>   BTF_ID_FLAGS(func, bpf_local_irq_restore)
> >> +BTF_ID_FLAGS(func, bpf_unreachable)
> >>   BTF_KFUNCS_END(common_btf_ids)
> >>
> >>   static const struct btf_kfunc_id_set common_kfunc_set =3D {
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 28f5a7899bd6..d26aec0a90d0 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -206,6 +206,7 @@ static int ref_set_non_owning(struct bpf_verifier_=
env *env,
> >>   static void specialize_kfunc(struct bpf_verifier_env *env,
> >>                               u32 func_id, u16 offset, unsigned long *=
addr);
> >>   static bool is_trusted_reg(const struct bpf_reg_state *reg);
> >> +static void verbose_insn(struct bpf_verifier_env *env, struct bpf_ins=
n *insn);
> >>
> >>   static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux=
)
> >>   {
> >> @@ -3398,7 +3399,10 @@ static int check_subprogs(struct bpf_verifier_e=
nv *env)
> >>          int i, subprog_start, subprog_end, off, cur_subprog =3D 0;
> >>          struct bpf_subprog_info *subprog =3D env->subprog_info;
> >>          struct bpf_insn *insn =3D env->prog->insnsi;
> >> +       bool is_bpf_unreachable =3D false;
> >>          int insn_cnt =3D env->prog->len;
> >> +       const struct btf_type *t;
> >> +       const char *tname;
> >>
> >>          /* now check that all jumps are within the same subprog */
> >>          subprog_start =3D subprog[cur_subprog].start;
> >> @@ -3433,7 +3437,18 @@ static int check_subprogs(struct bpf_verifier_e=
nv *env)
> >>                          if (code !=3D (BPF_JMP | BPF_EXIT) &&
> >>                              code !=3D (BPF_JMP32 | BPF_JA) &&
> >>                              code !=3D (BPF_JMP | BPF_JA)) {
> >> -                               verbose(env, "last insn is not an exit=
 or jmp\n");
> >> +                               verbose_insn(env, &insn[i]);
> >> +                               if (btf_vmlinux && insn[i].code =3D=3D=
 (BPF_CALL | BPF_JMP) &&
> >> +                                   insn[i].src_reg =3D=3D BPF_PSEUDO_=
KFUNC_CALL) {
> >> +                                       t =3D btf_type_by_id(btf_vmlin=
ux, insn[i].imm);
> >> +                                       tname =3D btf_name_by_offset(b=
tf_vmlinux, t->name_off);
> >> +                                       if (strcmp(tname, "bpf_unreach=
able") =3D=3D 0)
> > the check by name is not pretty.
> >
> >> +                                               is_bpf_unreachable =3D=
 true;
> >> +                               }
> >> +                               if (is_bpf_unreachable)
> >> +                                       verbose(env, "last insn is bpf=
_unreachable, due to uninitialized var?\n");
> >> +                               else
> >> +                                       verbose(env, "last insn is not=
 an exit or jmp\n");
> > This is too specific imo.
> > add_subprog_and_kfunc() -> add_kfunc_call()
> > should probably handle it instead,
> > and print that error.
>
> add_subprog_and_kfunc() -> add_kfunc_call() approach probably won't work.
> The error should be emitted only if the verifier (through path sensitive
> analysis) reaches bpf_unreachable().
>
> if bpf_unreachable() exists in the bpf prog, but verifier cannot reach it
> during verification process, error will not printed.

you mean when bpf_unreachable() in the actual dead code
then the verifier shouldn't error ? Makes sense.

> > It doesn't matter that call bpf_unreachable is the last insn
> > of a program or subprogram.
> > I suspect llvm can emit it anywhere.
>
> It is totally possible that bpf_unreachable may appear in the middle of
> code. But based on past examples, bpf_unreachable tends to be in the
> last insn and it may be targetted from multiple sources. This also makes
> code easier to understand. I can dig into llvm internal a little bit
> more to find how llvm places 'unreachable' IR insns.

I recall Anton hit some odd case of unreachable code with
upcoming indirect goto/call work.
If llmv starts emitting call bpf_unreachable that may be another case.

