Return-Path: <bpf+bounces-58372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB13AB9254
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 00:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A65CD7B4119
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 22:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86539289E3F;
	Thu, 15 May 2025 22:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7uJ93BH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3099E347C7
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 22:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747348993; cv=none; b=W7ZZYjSAHblnMWzfxSX1KkyuCoPYOVn2CacuAUs3jWgw4yVueMTl2F3p5SaeE6uWIpjTgd5ZmVRcpW9XWcm8vA8Ifvpf9juEn8I9rX7qNlf0koFZPZtWN6KIqswvBdruEFdJieDx+eaz3XgIZ8sIxxRkaUSa6Cj0imIBxn4IXxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747348993; c=relaxed/simple;
	bh=eiOiK2ZSXyTuDsrXGYnbufCz1JBnQvcbQpQNwJr5CUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vDFVNCTZWxg/vJHS2Le+w0K2+R3p5q3pdHu5wBTIAxXiUgX6P5d/DkoDjmmf6Qcj2hGPfQ8rbUP6rICtrHAIXZRI8GmMQxPu/TpwupbYyEfdomuYvhdLjcgnFgx5SLUFgGhcyyNpjHp1nE+OCTGtAA67GJiNJKBP/aBwN6U5LWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7uJ93BH; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a0b9303998so996671f8f.0
        for <bpf@vger.kernel.org>; Thu, 15 May 2025 15:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747348989; x=1747953789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZvzo7l34pOvB/sxaMybDN+lTA3P6NnF3jJSXd+mZjQ=;
        b=A7uJ93BHN8N4ZSFD3jASdRH4KCUl7VzujCBv3pWJRswlLOrvOvtMH0gqSd0YMbjs+w
         FVcFoILxuM1Cm844vICpACis4nijQjvy0w4ymPjNq91horIQnaX70fh8CBYk6MKVbDqe
         oXtLrWU7gAbDTgIbHFTvqNJwfmSy7VWkfp26UvuY0iotdC6ptUFwhf+/jxd8HXEW1fZM
         dgOmUpksvw+bKn3GkDhj9lg9Dl4vnhGAqoY5Cd0PYPG6MAlEZYUn0W2c4msmvIAU8u1/
         HuFP/BLbW+vePuaYazxUc3G11oeYiYyQZimJAKGmkM2p7dV2inj+aWCq/xE7LFYBPgo8
         fuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747348989; x=1747953789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZvzo7l34pOvB/sxaMybDN+lTA3P6NnF3jJSXd+mZjQ=;
        b=F1aowrA2MJ3VmJul5FQ01loNEPmisOyoNhQvoFHGXTonysbWVk2Mrgo88VOnsJwGn/
         mlrTD7SBNWWoIAirEF6RyimagGkISE++R4IdrI6sKSPFOz+Kxmx1uzR5jtvt+UIATdRm
         +OiH/6C4uCSTQYIo/xU2PXL28aveGOdQ+7QMMTVLNAuB1N6+1aZNGZ+AFGqgJskgaXFt
         BHhHirdtTc9AAB3BO1axKNdPd0N3k70vRzM9NCumLTJLzlM7nolZR3Mnjtq7JnW/p1UA
         cWUZwP/HjOXbnIEWttK5c+4p8UYnL+FYM2iXAlU+3Ivj6brwHq4xZ7b+21F1oP/DMod/
         CqQw==
X-Gm-Message-State: AOJu0YxSlRooSQFeC3oFl/ZYnNlzZ1rvxy6Wmb/2RkIHA+UKKOoRgrJ9
	d8efOpnjlaGVvttuTDD2lTh10YSbIX/VjMvoCcOOkxuBtMQEwUVmZjuBhel3v62WEOL/zvjODYP
	N8dB3IzZw9i3n6IhBK1EQFG/SZqbH16Y=
X-Gm-Gg: ASbGncuJ5zShYjSYObpNvC4FYWySnEv+GRRXXaWjgDhgquRzyLQ2teCAXeGIeqTDkSF
	zosHnOdsXlhW3UyFsL1Ne1yHvBqV3xd8WAs1doaZ1VQxl6rM25oSIyjqaoz7/ZP5IDyXqRkzGML
	3E4pVleZGrxnBsNJ5oSsqh6Nw7K43N0RoOFOfk76Fy3c3Ol/zrNaIYnSp6OR/bfQ==
X-Google-Smtp-Source: AGHT+IGwD+YHi6NRZbI3JgmYUGC2lD+hmoBPgIS3QPH67BE2rrt97PhFHv+btnwZkKfp26vUUPevOlX2cLUF9MVvKLo=
X-Received: by 2002:a05:6000:402a:b0:3a3:4ba4:fdee with SMTP id
 ffacd0b85a97d-3a3511996b5mr5471758f8f.1.1747348989218; Thu, 15 May 2025
 15:43:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515200635.3427478-1-yonghong.song@linux.dev>
In-Reply-To: <20250515200635.3427478-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 15 May 2025 15:42:57 -0700
X-Gm-Features: AX0GCFvkoUn--4tr-QeWUNWoi02PYcD9UMZPtvtKCuv96YbppYiui7P29gbRsDQ
Message-ID: <CAADnVQL9A8vB-yRjnZn8bgMrfDSO17FFBtS_xOs5w-LSq+p74g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Warn with new bpf_unreachable()
 kfunc maybe due to uninitialized var
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 1:06=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Marc Su=C3=B1=C3=A9 (Isovalent, part of Cisco) reported an issue where an
> uninitialized variable caused generating bpf prog binary code not
> working as expected. The reproducer is in [1] where the flags
> =E2=80=9C-Wall -Werror=E2=80=9D are enabled, but there is no warning and =
compiler
> may take advantage of uninit variable to do aggressive optimization.
>
> In llvm internals, uninitialized variable usage may generate
> 'unreachable' IR insn and these 'unreachable' IR insns may indicate
> uninit var impact on code optimization. With clang21 patch [2],
> those 'unreachable' IR insn are converted to func bpf_unreachable().
>
> In kernel, a new kfunc bpf_unreachable() is added. If this kfunc
> (generated by [2]) is the last insn in the main prog or a subprog,
> the verifier will suggest the verification failure may be due to
> uninitialized var, so user can check their source code to find the
> root cause.
>
> Without this patch, the verifier will output
>   last insn is not an exit or jmp
> and user will not know what is the potential root cause and
> it will take more time to debug this verification failure.
>
> bpf_unreachable() is also possible in the middle of the prog.
> If bpf_unreachable() is hit during normal do_check() verification,
> verification will fail.
>
>   [1] https://github.com/msune/clang_bpf/blob/main/Makefile#L3
>   [2] https://github.com/llvm/llvm-project/pull/131731
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

What's the difference between v1 and v2 ?
Pls spell it out in a cover letter or commit log.

> ---
>  kernel/bpf/helpers.c  |  5 +++++
>  kernel/bpf/verifier.c | 22 +++++++++++++++++++++-
>  2 files changed, 26 insertions(+), 1 deletion(-)
>
> In order to compile kernel successfully with the above [2], the following
> change is needed due to clang21 changes:
>
>   --- a/Makefile
>   +++ b/Makefile
>   @@ -852,7 +852,7 @@ endif
>    endif # may-sync-config
>    endif # need-config
>
>   -KBUILD_CFLAGS  +=3D -fno-delete-null-pointer-checks
>   +KBUILD_CFLAGS  +=3D -fno-delete-null-pointer-checks -Wno-default-const=
-init-field-unsafe
>
>   --- a/scripts/Makefile.extrawarn
>   +++ b/scripts/Makefile.extrawarn
>   @@ -19,6 +19,7 @@ KBUILD_CFLAGS +=3D $(call cc-disable-warning, frame-a=
ddress)
>    KBUILD_CFLAGS +=3D $(call cc-disable-warning, address-of-packed-member=
)
>    KBUILD_CFLAGS +=3D -Wmissing-declarations
>    KBUILD_CFLAGS +=3D -Wmissing-prototypes
>   +KBUILD_CFLAGS +=3D -Wno-default-const-init-var-unsafe
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
> index f6d3655b3a7a..5496775a884e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -206,6 +206,7 @@ static int ref_set_non_owning(struct bpf_verifier_env=
 *env,
>  static void specialize_kfunc(struct bpf_verifier_env *env,
>                              u32 func_id, u16 offset, unsigned long *addr=
);
>  static bool is_trusted_reg(const struct bpf_reg_state *reg);
> +static void verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *=
insn);
>
>  static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
>  {
> @@ -3399,7 +3400,10 @@ static int check_subprogs(struct bpf_verifier_env =
*env)
>         int i, subprog_start, subprog_end, off, cur_subprog =3D 0;
>         struct bpf_subprog_info *subprog =3D env->subprog_info;
>         struct bpf_insn *insn =3D env->prog->insnsi;
> +       bool is_bpf_unreachable =3D false;
>         int insn_cnt =3D env->prog->len;
> +       const struct btf_type *t;
> +       const char *tname;
>
>         /* now check that all jumps are within the same subprog */
>         subprog_start =3D subprog[cur_subprog].start;
> @@ -3434,7 +3438,18 @@ static int check_subprogs(struct bpf_verifier_env =
*env)
>                         if (code !=3D (BPF_JMP | BPF_EXIT) &&
>                             code !=3D (BPF_JMP32 | BPF_JA) &&
>                             code !=3D (BPF_JMP | BPF_JA)) {
> -                               verbose(env, "last insn is not an exit or=
 jmp\n");
> +                               verbose_insn(env, &insn[i]);
> +                               if (btf_vmlinux && insn[i].code =3D=3D (B=
PF_CALL | BPF_JMP) &&
> +                                   insn[i].src_reg =3D=3D BPF_PSEUDO_KFU=
NC_CALL) {

hmm. there is bpf_pseudo_kfunc_call() for that.

> +                                       t =3D btf_type_by_id(btf_vmlinux,=
 insn[i].imm);
> +                                       tname =3D btf_name_by_offset(btf_=
vmlinux, t->name_off);
> +                                       if (strcmp(tname, "bpf_unreachabl=
e") =3D=3D 0)

same issue as in v1. don't do strcmp.
Especially, since the 2nd hunk of this patch is doing it
via special_kfunc_list[].

> +                                               is_bpf_unreachable =3D tr=
ue;

why extra bool ?
Just print the error and return.

> +                               }
> +                               if (is_bpf_unreachable)
> +                                       verbose(env, "last insn is bpf_un=
reachable, due to uninitialized var?\n");

bpf_unreachable()

..variable.

> +                               else
> +                                       verbose(env, "last insn is not an=
 exit or jmp\n");
>                                 return -EINVAL;
>                         }
>                         subprog_start =3D subprog_end;
> @@ -12122,6 +12137,7 @@ enum special_kfunc_type {
>         KF_bpf_res_spin_unlock,
>         KF_bpf_res_spin_lock_irqsave,
>         KF_bpf_res_spin_unlock_irqrestore,
> +       KF_bpf_unreachable,
>  };
>
>  BTF_SET_START(special_kfunc_set)
> @@ -12225,6 +12241,7 @@ BTF_ID(func, bpf_res_spin_lock)
>  BTF_ID(func, bpf_res_spin_unlock)
>  BTF_ID(func, bpf_res_spin_lock_irqsave)
>  BTF_ID(func, bpf_res_spin_unlock_irqrestore)
> +BTF_ID(func, bpf_unreachable)
>
>  static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
>  {
> @@ -13525,6 +13542,9 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>                         return err;
>                 }
>                 __mark_btf_func_reg_size(env, regs, BPF_REG_0, sizeof(u32=
));
> +       } else if (insn->imm =3D=3D special_kfunc_list[KF_bpf_unreachable=
]) {
> +               verbose(env, "unexpected hit bpf_unreachable, due to unin=
it var or incorrect verification?\n");

!insn->off must be checked as well.
The wording of the message is odd.
s/unexpected hit bpf_unreachable/unexpected bpf_unreachable()/

and I'd finish with "due to uninitialized variable?"
Humans will read it. Don't abbreviate.

"incorrect verification" part is weird. It won't convey
any useful information to users.

pw-bot: cr

> +               return -EFAULT;
>         }
>
>         if (is_kfunc_destructive(&meta) && !capable(CAP_SYS_BOOT)) {
> --
> 2.47.1
>

