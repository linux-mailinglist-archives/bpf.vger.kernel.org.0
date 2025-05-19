Return-Path: <bpf+bounces-58512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4851DABCB22
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 00:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552BA1B65BB4
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 22:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C1921D583;
	Mon, 19 May 2025 22:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPrD7rNU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C941D86FF
	for <bpf@vger.kernel.org>; Mon, 19 May 2025 22:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747694933; cv=none; b=AZkzV1AuqxnrHXnzYXDF/J5AMoyED1Cly+cbx3FqcUppQZAtIw91QDG3lHAQZDr5e9zcDjDIMySLrABv9I6/nKRsdQBcdsZyLLNIXrpxxitd6UjwdJodBKGjaMHsnoFll8VnmAy5LJYyAXLsaaVGA+MJ7I5DHQRGl/qDIeUVhOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747694933; c=relaxed/simple;
	bh=rXiiZzU9nn3R0dfneSsmlE2lVoI74r4RhrJPTUdqRA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HLojTMaK+LvcJSxl9Hrxlrsx7Fj5HXjPddC9pvllF1DYh8CR5o6dJMhomPgniHrnhhfSrI4qNvSW0RJ9sRXl/I90n0bGjWy5+fv2eKf78yDppYWJu/v//omefUP47VGHpUoFlJRJGSsfa9hgF1x9o7yHt7fmdp0EaF+4or+iQUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPrD7rNU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-441d437cfaaso30093155e9.1
        for <bpf@vger.kernel.org>; Mon, 19 May 2025 15:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747694930; x=1748299730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cW1RqPTt9RrEiGDeElAXKT1TKRShzoYP+n/G+LsdW24=;
        b=ZPrD7rNUu+4fM2ygJiUrPagz3y98CxhGgWcK3RqQBcqllAaiAYNGC6n9r6Pt++3ici
         4/zbGlVEbJKP8/FVkvfbkSHPq7wN3VzvwuroEO5Po46gxrF35cJ4LgzRELU84FrqMkLR
         FNz9Hn+mq2qYTev5KvxLdoSF6cgwCXhi+KfhaKcj2XBWRniY6/s+Jf3EgG+gW+8BJY00
         13lqsZQUc4TGMGifQ+fyvH0/Z2fBbKP+uA4KSTeQ2lC3/u+qefCo2mB8FHbfi9aRN3qz
         2nR4Ffy7mURW4DitD6V8Ip3CGXLT245hmk5nlfodG2hVmagibMti06GJJqTb+BEyYkCr
         fx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747694930; x=1748299730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cW1RqPTt9RrEiGDeElAXKT1TKRShzoYP+n/G+LsdW24=;
        b=AD50697sxHUgI5drEQDJodtLHj3DzPqiFFYj8aS/s77mpxTpAJSYt3Vi+cStuS6GtQ
         8lZkgtd5xXMuQt91zk1KLIBwrTX4IOjH/KnitDGcwyYl0pnUQRQFXWF1DRQvKZeRXzcs
         EIctfNap9AjmVZxiipJamSwZhpgbF9LrzV3QfSZv69+IsMTZhmzjYxmzG/MVZhXX3suD
         mI86zy8ntYJy5xmf1hvzHB3REJcW7PO8dOdLZ1fwPrH2Nu18vwOOd7bsH4VdTTn0LYVd
         rM5BVuqKiD6in4OE5sW+N2/JGVJg5bhVIDSkt9bX/me6zJGl836esvQ67Y9ccBDDAgJi
         xPew==
X-Gm-Message-State: AOJu0YwsfZybezk91D1QL+jEDVh3cW3b07/e9NFc6m305ZcUlbHgKzU7
	1q34hgIrqk/5/kgfyAXpu57DfxJboA0m66Kv59FeF6ud+fSdInZ9Z1FhRscyUB6CMXAhv6LAB8e
	fFbpkv8IGKTimDMTwyzvocwHJnxHPx4c=
X-Gm-Gg: ASbGncvwIiLDuanSyBWm56k/u/hojFlyqV2Ob+5PCnzyAc+TAG44HaIROHRZczVfA4o
	E6EZskuSOUkOlYeu13y2xuNQ7pf/+KmfTtFD2QrLlZBd4bwSHJHqOO1U3thqE0VuDNgzP1FRj9J
	vNVwEfTsduhCKRYwRMEJDAgiuXOkDktna0hB5GV4ac3CJ/KPqmVHBKTpLV/+v/5g==
X-Google-Smtp-Source: AGHT+IFkJyLdWjI8nfA1WvIvwtiTV7VWihwT5d23OWLAqwleIgIJEZM2nJguMY7fYCvmZV2N0eV35OsBPEuZnUV6Fs4=
X-Received: by 2002:a05:6000:40cc:b0:3a3:6a24:7b87 with SMTP id
 ffacd0b85a97d-3a36a247d1fmr7219367f8f.33.1747694930033; Mon, 19 May 2025
 15:48:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519203339.2060080-1-yonghong.song@linux.dev> <20250519203344.2060544-1-yonghong.song@linux.dev>
In-Reply-To: <20250519203344.2060544-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 19 May 2025 15:48:38 -0700
X-Gm-Features: AX0GCFsk5nMkuMyzXNnvvqQ3fX07gZ3DP2QuaK6XrOFQiJT8ZjrHAobe1KsVKhM
Message-ID: <CAADnVQKR=i3qqxHcs3d2zcCEejz71z8GE2y=tghDPF2rFZUObg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Warn with bpf_unreachable() kfunc
 maybe due to uninitialized variable
To: Yonghong Song <yonghong.song@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 1:34=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Marc Su=C3=B1=C3=A9 (Isovalent, part of Cisco) reported an issue where an
> uninitialized variable caused generating bpf prog binary code not
> working as expected. The reproducer is in [1] where the flags
> =E2=80=9C-Wall -Werror=E2=80=9D are enabled, but there is no warning as t=
he compiler
> takes advantage of uninitialized variable to do aggressive optimization.
> The optimized code looks like below:
>
>       ; {
>            0:       bf 16 00 00 00 00 00 00 r6 =3D r1
>       ;       bpf_printk("Start");
>            1:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 =
=3D 0x0 ll
>                     0000000000000008:  R_BPF_64_64  .rodata
>            3:       b4 02 00 00 06 00 00 00 w2 =3D 0x6
>            4:       85 00 00 00 06 00 00 00 call 0x6
>       ; DEFINE_FUNC_CTX_POINTER(data)
>            5:       61 61 4c 00 00 00 00 00 w1 =3D *(u32 *)(r6 + 0x4c)
>       ;       bpf_printk("pre ipv6_hdrlen_offset");
>            6:       18 01 00 00 06 00 00 00 00 00 00 00 00 00 00 00 r1 =
=3D 0x6 ll
>                     0000000000000030:  R_BPF_64_64  .rodata
>            8:       b4 02 00 00 17 00 00 00 w2 =3D 0x17
>            9:       85 00 00 00 06 00 00 00 call 0x6
>       <END>
>
> The verifier will report the following failure:
>   9: (85) call bpf_trace_printk#6
>   last insn is not an exit or jmp
>
> The above verifier log does not give a clear hint about how to fix
> the problem and user may take quite some time to figure out that
> the issue is due to compiler taking advantage of uninitialized variable.
>
> In llvm internals, uninitialized variable usage may generate
> 'unreachable' IR insn and these 'unreachable' IR insns may indicate
> uninitialized variable impact on code optimization. So far, llvm
> BPF backend ignores 'unreachable' IR hence the above code is generated.
> With clang21 patch [2], those 'unreachable' IR insn are converted
> to func bpf_unreachable(). In order to maintain proper control flow
> graph for bpf progs, [2] also adds an 'exit' insn after bpf_unreachable()
> if bpf_unreachable() is the last insn in the function.
> The new code looks like:
>
>       ; {
>            0:       bf 16 00 00 00 00 00 00 r6 =3D r1
>       ;       bpf_printk("Start");
>            1:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 =
=3D 0x0 ll
>                     0000000000000008:  R_BPF_64_64  .rodata
>            3:       b4 02 00 00 06 00 00 00 w2 =3D 0x6
>            4:       85 00 00 00 06 00 00 00 call 0x6
>       ; DEFINE_FUNC_CTX_POINTER(data)
>            5:       61 61 4c 00 00 00 00 00 w1 =3D *(u32 *)(r6 + 0x4c)
>       ;       bpf_printk("pre ipv6_hdrlen_offset");
>            6:       18 01 00 00 06 00 00 00 00 00 00 00 00 00 00 00 r1 =
=3D 0x6 ll
>                     0000000000000030:  R_BPF_64_64  .rodata
>            8:       b4 02 00 00 17 00 00 00 w2 =3D 0x17
>            9:       85 00 00 00 06 00 00 00 call 0x6
>           10:       85 10 00 00 ff ff ff ff call -0x1
>                     0000000000000050:  R_BPF_64_32  bpf_unreachable
>           11:       95 00 00 00 00 00 00 00 exit
>       <END>
>
> In kernel, a new kfunc bpf_unreachable() is added. During insn
> verification, any hit with bpf_unreachable() will result in
> verification failure. The kernel is able to provide better
> log message for debugging.
>
> With llvm patch [2] and without this patch (no bpf_unreachable()
> kfunc for existing kernel), e.g., for old kernels, the verifier
> outputs
>   10: <invalid kfunc call>
>   kfunc 'bpf_unreachable' is referenced but wasn't resolved
> Basically, kernel does not support bpf_unreachable() kfunc.
> This still didn't give clear signals about possible reason.
>
> With llvm patch [2] and with this patch, the verifier outputs
>   10: (85) call bpf_unreachable#74479
>   unexpected bpf_unreachable() due to uninitialized variable?
> It gives much better hints for verification failure.
>
>   [1] https://github.com/msune/clang_bpf/blob/main/Makefile#L3
>   [2] https://github.com/llvm/llvm-project/pull/131731
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/bpf/helpers.c  | 5 +++++
>  kernel/bpf/verifier.c | 5 +++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index c1113b74e1e2..4852c36b1c51 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3273,6 +3273,10 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned lo=
ng *flags__irq_flag)
>         local_irq_restore(*flags__irq_flag);
>  }
>
> +__bpf_kfunc void bpf_unreachable(void)
> +{
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(generic_btf_ids)
> @@ -3386,6 +3390,7 @@ BTF_ID_FLAGS(func, bpf_copy_from_user_dynptr, KF_SL=
EEPABLE)
>  BTF_ID_FLAGS(func, bpf_copy_from_user_str_dynptr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_copy_from_user_task_dynptr, KF_SLEEPABLE | KF_TRU=
STED_ARGS)
>  BTF_ID_FLAGS(func, bpf_copy_from_user_task_str_dynptr, KF_SLEEPABLE | KF=
_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_unreachable)
>  BTF_KFUNCS_END(common_btf_ids)
>
>  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d5807d2efc92..08013e2e1697 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12105,6 +12105,7 @@ enum special_kfunc_type {
>         KF_bpf_res_spin_unlock,
>         KF_bpf_res_spin_lock_irqsave,
>         KF_bpf_res_spin_unlock_irqrestore,
> +       KF_bpf_unreachable,
>  };
>
>  BTF_SET_START(special_kfunc_set)
> @@ -12208,6 +12209,7 @@ BTF_ID(func, bpf_res_spin_lock)
>  BTF_ID(func, bpf_res_spin_unlock)
>  BTF_ID(func, bpf_res_spin_lock_irqsave)
>  BTF_ID(func, bpf_res_spin_unlock_irqrestore)
> +BTF_ID(func, bpf_unreachable)
>
>  static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
>  {
> @@ -13508,6 +13510,9 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>                         return err;
>                 }
>                 __mark_btf_func_reg_size(env, regs, BPF_REG_0, sizeof(u32=
));
> +       } else if (!insn->off && insn->imm =3D=3D special_kfunc_list[KF_b=
pf_unreachable]) {

Looks good, but let's not abuse special_kfunc_list[] for this case.
special_kfunc_type supposed to be in both set[] and list[].
This is not the case here.
It was wrong to add KF_bpf_set_dentry_xattr, bpf_iter_css_task_new,
bpf_dynptr_from_skb, and many others.
Let's fix this tech debt that we accumulated.

special_kfunc_type should include only kfuncs that return
a pointer, so that this part is triggered:

        } else if (btf_type_is_ptr(t)) {
                ptr_type =3D btf_type_skip_modifiers(desc_btf, t->type,
&ptr_type_id);

                if (meta.btf =3D=3D btf_vmlinux &&
btf_id_set_contains(&/special_kfunc_set, meta.func_id)) {

All other kfuncs shouldn't be there. They don't need to be in
the special_kfunc_set.

Let's split enum special_kfunc_type into what it meant to be
originally (both set and list), and move all list-only kfuncs
into a new array.
Let's call it kfunc_ids.
Then the check in this patch will look like:
insn->imm =3D=3D kfunc_ids[KF_bpf_unreachable]

Digging through the code it looks like we made a bit of a mess there.
Like this part:
        } else if (btf_type_is_void(t)) {
                if (meta.btf =3D=3D btf_vmlinux &&
btf_id_set_contains(&special_kfunc_set, meta.func_id)) {
                        if (meta.func_id =3D=3D
special_kfunc_list[KF_bpf_obj_drop_impl] ||
                            meta.func_id =3D=3D
special_kfunc_list[KF_bpf_percpu_obj_drop_impl]) {


*obj_drop don't need to be in a set,
and btf_id_set_contains() doesn't need to be called.
Both kfuncs should be moved to new kfunc_ids[]

