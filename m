Return-Path: <bpf+bounces-58589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFB8ABE0B0
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 18:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE9B188535C
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 16:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8B12676DF;
	Tue, 20 May 2025 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTD5xooC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6275A254B17
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747758569; cv=none; b=JOWwOcbr5owpAxVUjR9RQpVU4yKYcgr6X9FxrIfZUbyq0zbYRzZuJc1q4cshcRS/qBhM+vi18GKUn14q1iCRkkEYU6LA45aYlwS6L98KaTxetnOfF36si+CaGluWlRmHqy76j8XEj5vJRI6E3JE51aTHZOYd2XwzZrpRza29/6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747758569; c=relaxed/simple;
	bh=mkgUh+/PKJp4tJ16CD2BtKt0A0PiuQzRHmUVr4QopjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mgs9EKFcp93WEld9CxiAHsh4xplQTShMcq1D0KnI96qQY1Md9JdQy5Fc3ssSbzz9TZFaNLu8cuUXG+OkTKFUuGjDWRhrVNqNgdgO0LqZgmDS0UvAl27tvZhvojJdb+iiAIPYKcqiPw0wv6VADFQyv0VNy4EH7EO1UPJ8c1g6CZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTD5xooC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-445b11306abso18855605e9.3
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 09:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747758565; x=1748363365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axlGRGU3eRtvLQFdlGMQNvbD4zSgQapTsJ37+JY4GlY=;
        b=VTD5xooCSDWGbqh7lZLTcy/x3XwMswX6598PQGOiyIGBGPfsHJF+NPT0S6vXDGXD9x
         Ja8Ef4nwKHjOUCupjUnKCd+8nByMdNCKih7UQR36zgoDZg/ep9a0Bv6adt+nLgBkDkw3
         1KKtcqyNoUvilX7DnLJXjStn3GtVdVjyIAq3AVAa3frTMwK/Il3GpJf8JE4uPbxc8ree
         /Pwefq4RVD5WFKv60g5B2IEJ++spwDRzFbBIui7eVqCevXrVmqey50w6CZxd1kVI9WUj
         RHpX0aEvkNJe96vr27qsuE3PjI04jXn3qmbXOT9+yLx+4c7FiutZ2GEMPfbfUKBYl+y0
         dg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747758566; x=1748363366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axlGRGU3eRtvLQFdlGMQNvbD4zSgQapTsJ37+JY4GlY=;
        b=ISqG+//e7rg6KDYR6WAqunts0xIWP3WeI14eZ/7fn/MZ66LUZlB6ZLYVMdVQy+2DI5
         QuETRikdWAJkdhViTSqi5Wh784bngZCGrRutNiEu1Atvx9NY9RshaHh7s9jpRL0aZ4D5
         x96TjsCokLft0Df3SQ+Hpb5wYH8G7DTQ2x550b2vQuemR5jduq+AMuTkUn33T0J3wl1h
         gnaTMamijGcFqKwTtsB6sZoBrmmdNOyylFZeX/1grlBJ9oteRbT1lmwZYpU4WacFBZQm
         VVABzWUCn1/5Lkzhpy9Ggov2EfJ9oCPxPRt1aPkermIPJMyqppv1UW+xLhIxBFdCZT7J
         dkyg==
X-Forwarded-Encrypted: i=1; AJvYcCX2qxPCeaQnfGaNEQyfIWcz/Cj9qpAyzpX5gRl0cafeILxdQ/6WaIwudKie+qPvXD3q7ww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/VxDVhgwUxwtwa79D1HT2J9IuZz3AWjyz5vYMHdtQOHIBr4wp
	W/7QbgDLhEu6Sl0/GEVABIZkZakl3E3Jk8yKyPOk4qq77Mn8St0Yjem6w0TBSh+93pxx8YVJv6o
	z1pNqKw9/wiusKH9mvXGPUnj2BaE131g=
X-Gm-Gg: ASbGncuQo8L8CpOotUF01NoO5cgGbjQHlZQRZbdMRvXKzUyvMcKU9/MhJTGxTuTIAuM
	OryFgamExqGN/j2Nx+nW2GlKkVhttTopG1mye8T72LuVqLGy9RRfelTj1S1KwJ4+1nLcSJbWfxf
	uWJO+hN1DqKeyRoV90w/4L4ecWEc3p9BSTikmTLFKiRdLTDDhdtSMN3lz68YA=
X-Google-Smtp-Source: AGHT+IF1no4Z88lnPHuzCsBarqwgAC4v0M7opxraiKR/eH5WGP2lYlyxJiJpoT59roiorPDf4IOaVBfewOnJ08pZGpc=
X-Received: by 2002:a05:6000:2211:b0:3a3:6f26:5813 with SMTP id
 ffacd0b85a97d-3a36f2658fbmr7798456f8f.25.1747758565351; Tue, 20 May 2025
 09:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519203339.2060080-1-yonghong.song@linux.dev>
 <20250519203344.2060544-1-yonghong.song@linux.dev> <CAADnVQKR=i3qqxHcs3d2zcCEejz71z8GE2y=tghDPF2rFZUObg@mail.gmail.com>
 <85503b11-ccce-412e-b031-cc9654d6291d@linux.dev>
In-Reply-To: <85503b11-ccce-412e-b031-cc9654d6291d@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 May 2025 09:29:11 -0700
X-Gm-Features: AX0GCFsvGNfJ938W1yB0htwiTKlS993pGltbvebwspe3bRO3xtxYnYOIU5TW0QU
Message-ID: <CAADnVQLvN-TshyvkY3u9MYc7h_og=LWz7Ldf2k_33VRDqKsUZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Warn with bpf_unreachable() kfunc
 maybe due to uninitialized variable
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 8:25=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 5/19/25 6:48 AM, Alexei Starovoitov wrote:
> > On Mon, May 19, 2025 at 1:34=E2=80=AFPM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >> Marc Su=C3=B1=C3=A9 (Isovalent, part of Cisco) reported an issue where=
 an
> >> uninitialized variable caused generating bpf prog binary code not
> >> working as expected. The reproducer is in [1] where the flags
> >> =E2=80=9C-Wall -Werror=E2=80=9D are enabled, but there is no warning a=
s the compiler
> >> takes advantage of uninitialized variable to do aggressive optimizatio=
n.
> >> The optimized code looks like below:
> >>
> >>        ; {
> >>             0:       bf 16 00 00 00 00 00 00 r6 =3D r1
> >>        ;       bpf_printk("Start");
> >>             1:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r=
1 =3D 0x0 ll
> >>                      0000000000000008:  R_BPF_64_64  .rodata
> >>             3:       b4 02 00 00 06 00 00 00 w2 =3D 0x6
> >>             4:       85 00 00 00 06 00 00 00 call 0x6
> >>        ; DEFINE_FUNC_CTX_POINTER(data)
> >>             5:       61 61 4c 00 00 00 00 00 w1 =3D *(u32 *)(r6 + 0x4c=
)
> >>        ;       bpf_printk("pre ipv6_hdrlen_offset");
> >>             6:       18 01 00 00 06 00 00 00 00 00 00 00 00 00 00 00 r=
1 =3D 0x6 ll
> >>                      0000000000000030:  R_BPF_64_64  .rodata
> >>             8:       b4 02 00 00 17 00 00 00 w2 =3D 0x17
> >>             9:       85 00 00 00 06 00 00 00 call 0x6
> >>        <END>
> >>
> >> The verifier will report the following failure:
> >>    9: (85) call bpf_trace_printk#6
> >>    last insn is not an exit or jmp
> >>
> >> The above verifier log does not give a clear hint about how to fix
> >> the problem and user may take quite some time to figure out that
> >> the issue is due to compiler taking advantage of uninitialized variabl=
e.
> >>
> >> In llvm internals, uninitialized variable usage may generate
> >> 'unreachable' IR insn and these 'unreachable' IR insns may indicate
> >> uninitialized variable impact on code optimization. So far, llvm
> >> BPF backend ignores 'unreachable' IR hence the above code is generated=
.
> >> With clang21 patch [2], those 'unreachable' IR insn are converted
> >> to func bpf_unreachable(). In order to maintain proper control flow
> >> graph for bpf progs, [2] also adds an 'exit' insn after bpf_unreachabl=
e()
> >> if bpf_unreachable() is the last insn in the function.
> >> The new code looks like:
> >>
> >>        ; {
> >>             0:       bf 16 00 00 00 00 00 00 r6 =3D r1
> >>        ;       bpf_printk("Start");
> >>             1:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r=
1 =3D 0x0 ll
> >>                      0000000000000008:  R_BPF_64_64  .rodata
> >>             3:       b4 02 00 00 06 00 00 00 w2 =3D 0x6
> >>             4:       85 00 00 00 06 00 00 00 call 0x6
> >>        ; DEFINE_FUNC_CTX_POINTER(data)
> >>             5:       61 61 4c 00 00 00 00 00 w1 =3D *(u32 *)(r6 + 0x4c=
)
> >>        ;       bpf_printk("pre ipv6_hdrlen_offset");
> >>             6:       18 01 00 00 06 00 00 00 00 00 00 00 00 00 00 00 r=
1 =3D 0x6 ll
> >>                      0000000000000030:  R_BPF_64_64  .rodata
> >>             8:       b4 02 00 00 17 00 00 00 w2 =3D 0x17
> >>             9:       85 00 00 00 06 00 00 00 call 0x6
> >>            10:       85 10 00 00 ff ff ff ff call -0x1
> >>                      0000000000000050:  R_BPF_64_32  bpf_unreachable
> >>            11:       95 00 00 00 00 00 00 00 exit
> >>        <END>
> >>
> >> In kernel, a new kfunc bpf_unreachable() is added. During insn
> >> verification, any hit with bpf_unreachable() will result in
> >> verification failure. The kernel is able to provide better
> >> log message for debugging.
> >>
> >> With llvm patch [2] and without this patch (no bpf_unreachable()
> >> kfunc for existing kernel), e.g., for old kernels, the verifier
> >> outputs
> >>    10: <invalid kfunc call>
> >>    kfunc 'bpf_unreachable' is referenced but wasn't resolved
> >> Basically, kernel does not support bpf_unreachable() kfunc.
> >> This still didn't give clear signals about possible reason.
> >>
> >> With llvm patch [2] and with this patch, the verifier outputs
> >>    10: (85) call bpf_unreachable#74479
> >>    unexpected bpf_unreachable() due to uninitialized variable?
> >> It gives much better hints for verification failure.
> >>
> >>    [1] https://github.com/msune/clang_bpf/blob/main/Makefile#L3
> >>    [2] https://github.com/llvm/llvm-project/pull/131731
> >>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >>   kernel/bpf/helpers.c  | 5 +++++
> >>   kernel/bpf/verifier.c | 5 +++++
> >>   2 files changed, 10 insertions(+)
> >>
> >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >> index c1113b74e1e2..4852c36b1c51 100644
> >> --- a/kernel/bpf/helpers.c
> >> +++ b/kernel/bpf/helpers.c
> >> @@ -3273,6 +3273,10 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned=
 long *flags__irq_flag)
> >>          local_irq_restore(*flags__irq_flag);
> >>   }
> >>
> >> +__bpf_kfunc void bpf_unreachable(void)
> >> +{
> >> +}
> >> +
> >>   __bpf_kfunc_end_defs();
> >>
> >>   BTF_KFUNCS_START(generic_btf_ids)
> >> @@ -3386,6 +3390,7 @@ BTF_ID_FLAGS(func, bpf_copy_from_user_dynptr, KF=
_SLEEPABLE)
> >>   BTF_ID_FLAGS(func, bpf_copy_from_user_str_dynptr, KF_SLEEPABLE)
> >>   BTF_ID_FLAGS(func, bpf_copy_from_user_task_dynptr, KF_SLEEPABLE | KF=
_TRUSTED_ARGS)
> >>   BTF_ID_FLAGS(func, bpf_copy_from_user_task_str_dynptr, KF_SLEEPABLE =
| KF_TRUSTED_ARGS)
> >> +BTF_ID_FLAGS(func, bpf_unreachable)
> >>   BTF_KFUNCS_END(common_btf_ids)
> >>
> >>   static const struct btf_kfunc_id_set common_kfunc_set =3D {
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index d5807d2efc92..08013e2e1697 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -12105,6 +12105,7 @@ enum special_kfunc_type {
> >>          KF_bpf_res_spin_unlock,
> >>          KF_bpf_res_spin_lock_irqsave,
> >>          KF_bpf_res_spin_unlock_irqrestore,
> >> +       KF_bpf_unreachable,
> >>   };
> >>
> >>   BTF_SET_START(special_kfunc_set)
> >> @@ -12208,6 +12209,7 @@ BTF_ID(func, bpf_res_spin_lock)
> >>   BTF_ID(func, bpf_res_spin_unlock)
> >>   BTF_ID(func, bpf_res_spin_lock_irqsave)
> >>   BTF_ID(func, bpf_res_spin_unlock_irqrestore)
> >> +BTF_ID(func, bpf_unreachable)
> >>
> >>   static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
> >>   {
> >> @@ -13508,6 +13510,9 @@ static int check_kfunc_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn,
> >>                          return err;
> >>                  }
> >>                  __mark_btf_func_reg_size(env, regs, BPF_REG_0, sizeof=
(u32));
> >> +       } else if (!insn->off && insn->imm =3D=3D special_kfunc_list[K=
F_bpf_unreachable]) {
> > Looks good, but let's not abuse special_kfunc_list[] for this case.
> > special_kfunc_type supposed to be in both set[] and list[].
> > This is not the case here.
> > It was wrong to add KF_bpf_set_dentry_xattr, bpf_iter_css_task_new,
> > bpf_dynptr_from_skb, and many others.
> > Let's fix this tech debt that we accumulated.
> >
> > special_kfunc_type should include only kfuncs that return
> > a pointer, so that this part is triggered:
> >
> >          } else if (btf_type_is_ptr(t)) {
> >                  ptr_type =3D btf_type_skip_modifiers(desc_btf, t->type=
,
> > &ptr_type_id);
> >
> >                  if (meta.btf =3D=3D btf_vmlinux &&
> > btf_id_set_contains(&/special_kfunc_set, meta.func_id)) {
> >
> > All other kfuncs shouldn't be there. They don't need to be in
> > the special_kfunc_set.
> >
> > Let's split enum special_kfunc_type into what it meant to be
> > originally (both set and list), and move all list-only kfuncs
> > into a new array.
> > Let's call it kfunc_ids.
> > Then the check in this patch will look like:
> > insn->imm =3D=3D kfunc_ids[KF_bpf_unreachable]
>
> IIUC, the main goal is to remove some kfuncs from special_kfunc_set
> since they are unnecessary.
>
> I think we do not need an 'enum' type for special_kfunc_set since
> the for all kfuncs in special_kfunc_set, btf_id_set_contains()
> is used to find corresponding btf_id. So current 'enum special_kfunc_type=
'
> is only used for special_kfunc_list to find proper kfunc_id's.
>
> I think the following change should achieve this:
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 08013e2e1697..2cf00b06ae66 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12060,7 +12060,7 @@ enum kfunc_ptr_arg_type {
>          KF_ARG_PTR_TO_RES_SPIN_LOCK,
>   };
>
> -enum special_kfunc_type {
> +enum special_kfunc_list_type {
>          KF_bpf_obj_new_impl,
>          KF_bpf_obj_drop_impl,
>          KF_bpf_refcount_acquire_impl,
> @@ -12126,24 +12126,10 @@ BTF_ID(func, bpf_rbtree_first)
>   BTF_ID(func, bpf_rbtree_root)
>   BTF_ID(func, bpf_rbtree_left)
>   BTF_ID(func, bpf_rbtree_right)
> -#ifdef CONFIG_NET
> -BTF_ID(func, bpf_dynptr_from_skb)
> -BTF_ID(func, bpf_dynptr_from_xdp)
> -#endif
>   BTF_ID(func, bpf_dynptr_slice)
>   BTF_ID(func, bpf_dynptr_slice_rdwr)
> -BTF_ID(func, bpf_dynptr_clone)
>   BTF_ID(func, bpf_percpu_obj_new_impl)
>   BTF_ID(func, bpf_percpu_obj_drop_impl)
> -BTF_ID(func, bpf_throw)
> -BTF_ID(func, bpf_wq_set_callback_impl)
> -#ifdef CONFIG_CGROUPS
> -BTF_ID(func, bpf_iter_css_task_new)
> -#endif
> -#ifdef CONFIG_BPF_LSM
> -BTF_ID(func, bpf_set_dentry_xattr)
> -BTF_ID(func, bpf_remove_dentry_xattr)
> -#endif
>   BTF_SET_END(special_kfunc_set)
>
>   BTF_ID_LIST(special_kfunc_list)
>
> I renamed 'enum special_kfunc_type' to 'enum special_kfunc_list_type'
> implying that the enum values in special_kfunc_lit_type has
> 1:1 relation to special_kfunc_list.
>
> WDYT?

I think this is not going far enough.
We confused ourselves with the current special_kfunc_type.
I prefer a full split where enum special_kfunc_type
contains only kfuncs for special_kfunc_set and _list,
and a separate enum that covers kfuncs in a new kfunc_ids[]

> >
> > Digging through the code it looks like we made a bit of a mess there.
> > Like this part:
> >          } else if (btf_type_is_void(t)) {
> >                  if (meta.btf =3D=3D btf_vmlinux &&
> > btf_id_set_contains(&special_kfunc_set, meta.func_id)) {
> >                          if (meta.func_id =3D=3D
> > special_kfunc_list[KF_bpf_obj_drop_impl] ||
> >                              meta.func_id =3D=3D
> > special_kfunc_list[KF_bpf_percpu_obj_drop_impl]) {
> >
> >
> > *obj_drop don't need to be in a set,
> > and btf_id_set_contains() doesn't need to be called.
> > Both kfuncs should be moved to new kfunc_ids[]
>
> As you mentioned, for this one, we can do
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2cf00b06ae66..a3ff57eaa5f4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12110,7 +12110,6 @@ enum special_kfunc_list_type {
>
>   BTF_SET_START(special_kfunc_set)
>   BTF_ID(func, bpf_obj_new_impl)
> -BTF_ID(func, bpf_obj_drop_impl)
>   BTF_ID(func, bpf_refcount_acquire_impl)
>   BTF_ID(func, bpf_list_push_front_impl)
>   BTF_ID(func, bpf_list_push_back_impl)
> @@ -12129,7 +12128,6 @@ BTF_ID(func, bpf_rbtree_right)
>   BTF_ID(func, bpf_dynptr_slice)
>   BTF_ID(func, bpf_dynptr_slice_rdwr)
>   BTF_ID(func, bpf_percpu_obj_new_impl)
> -BTF_ID(func, bpf_percpu_obj_drop_impl)
>   BTF_SET_END(special_kfunc_set)
>
>   BTF_ID_LIST(special_kfunc_list)
> @@ -13909,7 +13907,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>                  if (reg_may_point_to_spin_lock(&regs[BPF_REG_0]) && !reg=
s[BPF_REG_0].id)
>                          regs[BPF_REG_0].id =3D ++env->id_gen;
>          } else if (btf_type_is_void(t)) {
> -               if (meta.btf =3D=3D btf_vmlinux && btf_id_set_contains(&s=
pecial_kfunc_set, meta.func_id)) {
> +               if (meta.btf =3D=3D btf_vmlinux) {
>                          if (meta.func_id =3D=3D special_kfunc_list[KF_bp=
f_obj_drop_impl] ||
>                              meta.func_id =3D=3D special_kfunc_list[KF_bp=
f_percpu_obj_drop_impl]) {
>                                  insn_aux->kptr_struct_meta =3D

Yes. Something like this but with new enum and new kfunc_ids[], like:
if (meta.func_id =3D=3D kfunc_ids[KF_bpf_obj_drop_impl] ..

There is a concern that two KF_* enums may be confusing,
since it's not obvious whether
special_kfunc_list[KF_foo] or kfunc_ids[KF_foo] should be used.
Need to think about how to resolve the ambiguity...

We also have these things for btf_ids of types:
extern u32 btf_tracing_ids[];
extern u32 bpf_cgroup_btf_id[];
extern u32 bpf_local_storage_map_btf_id[];
extern u32 btf_bpf_map_id[];
extern u32 bpf_kmem_cache_btf_id[];

