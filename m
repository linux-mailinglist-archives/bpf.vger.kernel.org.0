Return-Path: <bpf+bounces-66090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD17B2E109
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 17:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9354B5865B8
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 15:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B73322525;
	Wed, 20 Aug 2025 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gd+h1ldt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A022D481C
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702922; cv=none; b=ogfcEzcRnMuAteVjE6pMXRrABoOHOEqWKEMckfIx63NmpcsEJ+2eNzdQ7uVydRyQ9eQYXduD1tSwmiUe9sUpGtqaORY0kr9FaHTZjRILJoMwYD+2zCHCC6jcn9ZVSq8Z4inIrkkC1P/+x3P3bh0SOY+gS8dnlJEvSKaFrY0scV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702922; c=relaxed/simple;
	bh=hBrg8O0g7jixSViAPifIWIovm1UHUOv6ejAMd9uN2MU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3zbyYK483R3VK1TjYf4+gL8WoFd3kmJVGwCU5wI1KrbXFgmmFh781P/VyL5i65EHdfBmqxkigObo35PP/uLbQAz6TSPJt3DWyUwEc1B83YS+5sBFW5HGtDE1ypPNR4SAQV7HZvwmOdEsY2bVB/8Q+uxrLxdnX9zYRzheKVn+kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gd+h1ldt; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b109c58e29so107483321cf.3
        for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755702919; x=1756307719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ne63wwGU8OAFMNP3Lx0kvltgtXa3RxoxCeJ/ZWsCvSY=;
        b=gd+h1ldtCL37KDt8QoJ5bztL7MmWSj3jI8oqzUzPYGPjfyolTO7R30uJtIc/73wqgZ
         KrgtaTsxR6pI7FivNZ6JMSzfRr0RTlABJ6y7gfjsrc69nW1+U6ZLvazY8zIZ9+jg+Xet
         sXUD+ztOTV4QQ5sXf65vSDB4kWaKAuXWqAtz3gmGNHuXRrECxn6ouxIItOQDAa5fa4yM
         T2mrkdasscIV9CjTRT1hGu7G8vq02pSpfZ9UQf3bLKKdVtF1P/4KiXoEyn7JaXOhgtIj
         sy2Hl5FbQqVf1lBKEHcqZ8DjOF+zi68fbi3FcUF0w6o7CNoL0ENBE235QIFph1sjW4BL
         NLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755702919; x=1756307719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ne63wwGU8OAFMNP3Lx0kvltgtXa3RxoxCeJ/ZWsCvSY=;
        b=SwbfPZr8bCRaaODP22hxMmLx2pytiMhBKRsu1l+yxrIBBNyDdT+fd33S/BO1Zmf4tE
         quA2Gpw0Xw50+R+9HZFZcxwMic8yjbC1r0k5efvQHk5ks7o9metfkhnUBAfLMxwEEJVK
         XkD1us8YWXqym7lparVXLPf+qQ6hX29+OfVqXHReRs2zerQBm7NPB1y2ydj3DdM7o5OW
         fvqmL/L2RzVdDQUi4pXs//eVgRShh6SdxlFwoiIDQ1lueQge5+tkTd4/qWNpaxuQGDdr
         X71OBIc6dcrVSNR8ZYN94bnH41p3SLyqy5zBH/z6XlL7XvleMq3hB9sovhBLCdNJglB9
         fiaA==
X-Forwarded-Encrypted: i=1; AJvYcCWDhtNZoWFLfw52+HokPemF3hX2WESDc7s35IPUO2pqoF4sSZ2YMi/LFq+ccYdm1JGSX2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu4K2qyPgu//q8/GOFoqTHwSqWQA8SyZGxEhrvz+hYzua4ZNrv
	gxRAt40Ch35Y1pPnaWvHPrfTCH6u0GAswoOo41TCqd9MMFf+0qYx92Y5IK5f5yfFqvSfb1QirAh
	kgcNJHmuzCfFTDgp66qFds8TbjKgcx80=
X-Gm-Gg: ASbGncuQ8JWka35aI/gmXYOKemD3trzQxKoYZ9lQy0jDJndIq6ViKKoHlI1DmRhRSRZ
	0pyG4wKtBr5mx+bkpo43wNxRbScqVnPkqpDwunUpwPIa426uhHH6ZvoOui5j1CGuyskQeI7ZnsP
	c3Dk8pmRGjuOqzaIK+4dYQyQKOk2P6NQ9XyRDMmfhGL+xX3eSuBDgUakS9r0htJJ2xvebAAhEt3
	FyOP2M=
X-Google-Smtp-Source: AGHT+IEhvcBpHbyb8zJE1tdIUXgei1yo5S1lhVhBrc3v8eD/pw88pf9i2sKakywspMWJKV8iIiStAODFgEDiO+8vOpk=
X-Received: by 2002:a05:622a:1450:b0:4af:1bc1:781e with SMTP id
 d75a77b69052e-4b2918e2d78mr34004311cf.0.1755702918187; Wed, 20 Aug 2025
 08:15:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820103956.394955-1-hengqi.chen@gmail.com>
In-Reply-To: <20250820103956.394955-1-hengqi.chen@gmail.com>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Wed, 20 Aug 2025 08:15:06 -0700
X-Gm-Features: Ac12FXyvYTosJS9opCF_VZUPe0FWbpaLM0LfVzg5HccfqkRuq8f9okrm2jBPRv4
Message-ID: <CAK3+h2zGKRLe4OHjEKf4aQZOFR6X9vFE+RRvDdm-9Xxmy=Zk5Q@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: BPF: Sign extend struct ops return values properly
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: chenhuacai@kernel.org, yangtiezhu@loongson.cn, jianghaoran@kylinos.cn, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	bpf@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 5:06=E2=80=AFAM Hengqi Chen <hengqi.chen@gmail.com>=
 wrote:
>
> The ns_bpf_qdisc selftest triggers a kernel panic:
>
>     [ 2738.595309] CPU 0 Unable to handle kernel paging request at virtua=
l address 0000000000741d58, era =3D=3D 90000000851b5ac0, ra =3D=3D 90000000=
851b5aa4
>     [ 2738.596716] Oops[#1]:
>     [ 2738.596980] CPU: 0 UID: 0 PID: 449 Comm: test_progs Tainted: G    =
       OE       6.16.0+ #3 PREEMPT(full)
>     [ 2738.597184] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
>     [ 2738.597265] Hardware name: QEMU QEMU Virtual Machine, BIOS unknown=
 2/2/2022
>     [ 2738.597386] pc 90000000851b5ac0 ra 90000000851b5aa4 tp 90000001076=
b8000 sp 90000001076bb600
>     [ 2738.597484] a0 0000000000741ce8 a1 0000000000000001 a2 90000001076=
bb5c0 a3 0000000000000008
>     [ 2738.597577] a4 90000001004c4620 a5 9000000100741ce8 a6 00000000000=
00000 a7 0100000000000000
>     [ 2738.597682] t0 0000000000000010 t1 0000000000000000 t2 9000000104d=
24d30 t3 0000000000000001
>     [ 2738.597835] t4 4f2317da8a7e08c4 t5 fffffefffc002f00 t6 90000001004=
c4620 t7 ffffffffc61c5b3d
>     [ 2738.597997] t8 0000000000000000 u0 0000000000000001 s9 00000000000=
00050 s0 90000001075bc800
>     [ 2738.598097] s1 0000000000000040 s2 900000010597c400 s3 00000000000=
00008 s4 90000001075bc880
>     [ 2738.598196] s5 90000001075bc8f0 s6 0000000000000000 s7 00000000007=
41ce8 s8 0000000000000000
>     [ 2738.598313]    ra: 90000000851b5aa4 __qdisc_run+0xac/0x8d8
>     [ 2738.598553]   ERA: 90000000851b5ac0 __qdisc_run+0xc8/0x8d8
>     [ 2738.598629]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=3DCC =
-WE)
>     [ 2738.598991]  PRMD: 00000004 (PPLV0 +PIE -PWE)
>     [ 2738.599065]  EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
>     [ 2738.599160]  ECFG: 00071c1d (LIE=3D0,2-4,10-12 VS=3D7)
>     [ 2738.599278] ESTAT: 00010000 [PIL] (IS=3D ECode=3D1 EsubCode=3D0)
>     [ 2738.599364]  BADV: 0000000000741d58
>     [ 2738.599429]  PRID: 0014c010 (Loongson-64bit, Loongson-3A5000)
>     [ 2738.599513] Modules linked in: bpf_testmod(OE) [last unloaded: bpf=
_testmod(OE)]
>     [ 2738.599724] Process test_progs (pid: 449, threadinfo=3D000000009af=
02b3a, task=3D00000000e9ba4956)
>     [ 2738.599916] Stack : 0000000000000000 90000001075bc8ac 900000008695=
24a8 9000000100741ce8
>     [ 2738.600065]         90000001075bc800 9000000100415300 90000001075b=
c8ac 0000000000000000
>     [ 2738.600170]         900000010597c400 900000008694a000 000000000000=
0000 9000000105b59000
>     [ 2738.600278]         90000001075bc800 9000000100741ce8 000000000000=
0050 900000008513000c
>     [ 2738.600381]         9000000086936000 0000000100094d4c fffffff40067=
6208 0000000000000000
>     [ 2738.600482]         9000000105b59000 900000008694a000 9000000086bf=
0dc0 9000000105b59000
>     [ 2738.600585]         9000000086bf0d68 9000000085147010 90000001075b=
e788 0000000000000000
>     [ 2738.600690]         9000000086bf0f98 0000000000000001 000000000000=
0010 9000000006015840
>     [ 2738.600795]         0000000000000000 9000000086be6c40 000000000000=
0000 0000000000000000
>     [ 2738.600901]         0000000000000000 4f2317da8a7e08c4 000000000000=
0101 4f2317da8a7e08c4
>     [ 2738.601007]         ...
>     [ 2738.601062] Call Trace:
>     [ 2738.601135] [<90000000851b5ac0>] __qdisc_run+0xc8/0x8d8
>     [ 2738.601396] [<9000000085130008>] __dev_queue_xmit+0x578/0x10f0
>     [ 2738.601482] [<90000000853701c0>] ip6_finish_output2+0x2f0/0x950
>     [ 2738.601568] [<9000000085374bc8>] ip6_finish_output+0x2b8/0x448
>     [ 2738.601646] [<9000000085370b24>] ip6_xmit+0x304/0x858
>     [ 2738.601711] [<90000000853c4438>] inet6_csk_xmit+0x100/0x170
>     [ 2738.601784] [<90000000852b32f0>] __tcp_transmit_skb+0x490/0xdd0
>     [ 2738.601863] [<90000000852b47fc>] tcp_connect+0xbcc/0x1168
>     [ 2738.601934] [<90000000853b9088>] tcp_v6_connect+0x580/0x8a0
>     [ 2738.602019] [<90000000852e7738>] __inet_stream_connect+0x170/0x480
>     [ 2738.602103] [<90000000852e7a98>] inet_stream_connect+0x50/0x88
>     [ 2738.602175] [<90000000850f2814>] __sys_connect+0xe4/0x110
>     [ 2738.602244] [<90000000850f2858>] sys_connect+0x18/0x28
>     [ 2738.602320] [<9000000085520c94>] do_syscall+0x94/0x1a0
>     [ 2738.602399] [<9000000083df1fb8>] handle_syscall+0xb8/0x158
>     [ 2738.602502]
>     [ 2738.602546] Code: 4001ad80  2400873f  2400832d <240073cc> 001137ff=
  001133ff  6407b41f  001503cc  0280041d
>     [ 2738.602724]
>     [ 2738.602916] ---[ end trace 0000000000000000 ]---
>     [ 2738.603210] Kernel panic - not syncing: Fatal exception in interru=
pt
>     [ 2738.603548] Kernel relocated by 0x83bb0000
>     [ 2738.603622]  .text @ 0x9000000083db0000
>     [ 2738.603699]  .data @ 0x9000000085690000
>     [ 2738.603753]  .bss  @ 0x9000000087491e00
>     [ 2738.603900] ---[ end Kernel panic - not syncing: Fatal exception i=
n interrupt ]---
>
> The bpf_fifo_dequeue prog returns a skb which is a pointer.
> The pointer is treated as a 32bit value and sign extend to
> 64bit in epilogue. This behavior is right for most bpf prog
> types but wrong for struct ops which requires LoongArch ABI.
>
> So let's sign extend struct ops return values according to
> the return value spec in function model.
>
> Fixes: 6abf17d690d8 ("LoongArch: BPF: Add struct ops support for trampoli=
ne")
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  arch/loongarch/net/bpf_jit.c | 47 ++++++++++++++++++++++++++++++------
>  1 file changed, 40 insertions(+), 7 deletions(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index abfdb6bb5c38..4077565c9934 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1361,7 +1361,8 @@ static void restore_args(struct jit_ctx *ctx, int n=
args, int args_off)
>  }
>
>  static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l=
,
> -                          int args_off, int retval_off, int run_ctx_off,=
 bool save_ret)
> +                          const struct btf_func_model *m, int args_off,
> +                          int retval_off, int run_ctx_off, bool save_ret=
)
>  {
>         int ret;
>         u32 *branch;
> @@ -1425,13 +1426,14 @@ static int invoke_bpf_prog(struct jit_ctx *ctx, s=
truct bpf_tramp_link *l,
>  }
>
>  static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_lin=
ks *tl,
> -                              int args_off, int retval_off, int run_ctx_=
off, u32 **branches)
> +                              const struct btf_func_model *m, int args_o=
ff,
> +                              int retval_off, int run_ctx_off, u32 **bra=
nches)
>  {
>         int i;
>
>         emit_insn(ctx, std, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_FP, -retval=
_off);
>         for (i =3D 0; i < tl->nr_links; i++) {
> -               invoke_bpf_prog(ctx, tl->links[i], args_off, retval_off, =
run_ctx_off, true);
> +               invoke_bpf_prog(ctx, tl->links[i], m, args_off, retval_of=
f, run_ctx_off, true);
>                 emit_insn(ctx, ldd, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -=
retval_off);
>                 branches[i] =3D (u32 *)ctx->image + ctx->idx;
>                 emit_insn(ctx, nop);
> @@ -1448,6 +1450,30 @@ void arch_free_bpf_trampoline(void *image, unsigne=
d int size)
>         bpf_prog_pack_free(image, size);
>  }
>
> +/*
> + * Sign-extend the register if necessary
> + */
> +static int sign_extend(struct jit_ctx *ctx, int r, u8 size)
> +{
> +       switch (size) {
> +       case 1:
> +               emit_insn(ctx, sllid, r, r, 56);
> +               emit_insn(ctx, sraid, r, r, 56);
> +               return 0;
> +       case 2:
> +               emit_insn(ctx, sllid, r, r, 48);
> +               emit_insn(ctx, sraid, r, r, 48);
> +               return 0;
> +       case 4:
> +               emit_insn(ctx, addiw, r, r, 0);
> +               return 0;
> +       case 8:
> +               return 0;
> +       default:
> +               return -1;
> +       }
> +}
> +
>  static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf=
_tramp_image *im,
>                                          const struct btf_func_model *m, =
struct bpf_tramp_links *tlinks,
>                                          void *func_addr, u32 flags)
> @@ -1602,8 +1628,8 @@ static int __arch_prepare_bpf_trampoline(struct jit=
_ctx *ctx, struct bpf_tramp_i
>         }
>
>         for (i =3D 0; i < fentry->nr_links; i++) {
> -               ret =3D invoke_bpf_prog(ctx, fentry->links[i], args_off, =
retval_off,
> -                                     run_ctx_off, flags & BPF_TRAMP_F_RE=
T_FENTRY_RET);
> +               ret =3D invoke_bpf_prog(ctx, fentry->links[i], m, args_of=
f, retval_off,
> +                             run_ctx_off, flags & BPF_TRAMP_F_RET_FENTRY=
_RET);
>                 if (ret)
>                         return ret;
>         }
> @@ -1612,7 +1638,7 @@ static int __arch_prepare_bpf_trampoline(struct jit=
_ctx *ctx, struct bpf_tramp_i
>                 if (!branches)
>                         return -ENOMEM;
>
> -               invoke_bpf_mod_ret(ctx, fmod_ret, args_off, retval_off, r=
un_ctx_off, branches);
> +               invoke_bpf_mod_ret(ctx, fmod_ret, m, args_off, retval_off=
, run_ctx_off, branches);
>         }
>
>         if (flags & BPF_TRAMP_F_CALL_ORIG) {
> @@ -1638,7 +1664,8 @@ static int __arch_prepare_bpf_trampoline(struct jit=
_ctx *ctx, struct bpf_tramp_i
>         }
>
>         for (i =3D 0; i < fexit->nr_links; i++) {
> -               ret =3D invoke_bpf_prog(ctx, fexit->links[i], args_off, r=
etval_off, run_ctx_off, false);
> +               ret =3D invoke_bpf_prog(ctx, fexit->links[i], m, args_off=
,
> +                                     retval_off, run_ctx_off, false);
>                 if (ret)
>                         goto out;
>         }
> @@ -1657,6 +1684,12 @@ static int __arch_prepare_bpf_trampoline(struct ji=
t_ctx *ctx, struct bpf_tramp_i
>         if (save_ret) {
>                 emit_insn(ctx, ldd, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -=
retval_off);
>                 emit_insn(ctx, ldd, regmap[BPF_REG_0], LOONGARCH_GPR_FP, =
-(retval_off - 8));
> +               if (is_struct_ops) {
> +                       move_reg(ctx, LOONGARCH_GPR_A0, regmap[BPF_REG_0]=
);
> +                       ret =3D sign_extend(ctx, LOONGARCH_GPR_A0, m->ret=
_size);
> +                       if (ret)
> +                               goto out;
> +               }
>         }
>
>         emit_insn(ctx, ldd, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg_off=
);
> --
> 2.43.5
>

Tested-by: Vincent Li <vincent.mc.li@gmail.com>

 [root@fedora bpf]# ./test_progs -t struct_ops -d struct_ops_multi_pages
#15/1    bad_struct_ops/invalid_prog_reuse:OK
#15/2    bad_struct_ops/unused_program:OK
#15      bad_struct_ops:OK
#408/1   struct_ops_autocreate/cant_load_full_object:OK
#408/2   struct_ops_autocreate/can_load_partial_object:OK
#408/3   struct_ops_autocreate/autoload_and_shadow_vars:OK
#408/4   struct_ops_autocreate/optional_maps:OK
#408     struct_ops_autocreate:OK
#409/1   struct_ops_kptr_return/kptr_return:OK
#409/2   struct_ops_kptr_return/kptr_return_fail__wrong_type:OK
#409/3   struct_ops_kptr_return/kptr_return_fail__invalid_scalar:OK
#409/4   struct_ops_kptr_return/kptr_return_fail__nonzero_offset:OK
#409/5   struct_ops_kptr_return/kptr_return_fail__local_kptr:OK
#409     struct_ops_kptr_return:OK
#410/1   struct_ops_maybe_null/maybe_null:OK
#410/2   struct_ops_maybe_null/maybe_null_fail:OK
#410     struct_ops_maybe_null:OK
#411/1   struct_ops_module/struct_ops_load:OK
#411/2   struct_ops_module/struct_ops_not_zeroed:OK
#411/3   struct_ops_module/struct_ops_incompatible:OK
#411/4   struct_ops_module/struct_ops_null_out_cb:OK
#411/5   struct_ops_module/struct_ops_forgotten_cb:OK
#411/6   struct_ops_module/test_detach_link:OK
#411/7   struct_ops_module/unsupported_ops:OK
#411     struct_ops_module:OK
#413/1   struct_ops_no_cfi/load_bpf_test_no_cfi:OK
#413     struct_ops_no_cfi:OK
#414/1   struct_ops_private_stack/private_stack:SKIP
#414/2   struct_ops_private_stack/private_stack_fail:SKIP
#414/3   struct_ops_private_stack/private_stack_recur:SKIP
#414     struct_ops_private_stack:SKIP
#415/1   struct_ops_refcounted/refcounted:OK
#415/2   struct_ops_refcounted/refcounted_fail__ref_leak:OK
#415/3   struct_ops_refcounted/refcounted_fail__global_subprog:OK
#415/4   struct_ops_refcounted/refcounted_fail__tail_call:OK
#415     struct_ops_refcounted:OK
Summary: 8/25 PASSED, 3 SKIPPED, 0 FAILED
[root@fedora bpf]#
[root@fedora bpf]#
[root@fedora bpf]# ./test_progs -t struct_ops -a fentry_test/fentry
#15/1    bad_struct_ops/invalid_prog_reuse:OK
#15/2    bad_struct_ops/unused_program:OK
#15      bad_struct_ops:OK
#109/1   fentry_test/fentry:OK
#109     fentry_test:OK
#408/1   struct_ops_autocreate/cant_load_full_object:OK
#408/2   struct_ops_autocreate/can_load_partial_object:OK
#408/3   struct_ops_autocreate/autoload_and_shadow_vars:OK
#408/4   struct_ops_autocreate/optional_maps:OK
#408     struct_ops_autocreate:OK
#409/1   struct_ops_kptr_return/kptr_return:OK
#409/2   struct_ops_kptr_return/kptr_return_fail__wrong_type:OK
#409/3   struct_ops_kptr_return/kptr_return_fail__invalid_scalar:OK
#409/4   struct_ops_kptr_return/kptr_return_fail__nonzero_offset:OK
#409/5   struct_ops_kptr_return/kptr_return_fail__local_kptr:OK
#409     struct_ops_kptr_return:OK
#410/1   struct_ops_maybe_null/maybe_null:OK
#410/2   struct_ops_maybe_null/maybe_null_fail:OK
#410     struct_ops_maybe_null:OK
#411/1   struct_ops_module/struct_ops_load:OK
#411/2   struct_ops_module/struct_ops_not_zeroed:OK
#411/3   struct_ops_module/struct_ops_incompatible:OK
#411/4   struct_ops_module/struct_ops_null_out_cb:OK
#411/5   struct_ops_module/struct_ops_forgotten_cb:OK
#411/6   struct_ops_module/test_detach_link:OK
#411/7   struct_ops_module/unsupported_ops:OK
#411     struct_ops_module:OK
do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 nsec
do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
#412/1   struct_ops_multi_pages/multi_pages:FAIL
#412     struct_ops_multi_pages:FAIL
#413/1   struct_ops_no_cfi/load_bpf_test_no_cfi:OK
#413     struct_ops_no_cfi:OK
#414/1   struct_ops_private_stack/private_stack:SKIP
#414/2   struct_ops_private_stack/private_stack_fail:SKIP
#414/3   struct_ops_private_stack/private_stack_recur:SKIP
#414     struct_ops_private_stack:SKIP
#415/1   struct_ops_refcounted/refcounted:OK
#415/2   struct_ops_refcounted/refcounted_fail__ref_leak:OK
#415/3   struct_ops_refcounted/refcounted_fail__global_subprog:OK
#415/4   struct_ops_refcounted/refcounted_fail__tail_call:OK
#415     struct_ops_refcounted:OK

All error logs:
do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 nsec
do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
#412/1   struct_ops_multi_pages/multi_pages:FAIL
#412     struct_ops_multi_pages:FAIL
Summary: 9/26 PASSED, 3 SKIPPED, 1 FAILED
[root@fedora bpf]#
[root@fedora bpf]#
[root@fedora bpf]# ./test_progs -t struct_ops -a fexit_sleep
#15/1    bad_struct_ops/invalid_prog_reuse:OK
#15/2    bad_struct_ops/unused_program:OK
#15      bad_struct_ops:OK
#111     fexit_sleep:OK
#408/1   struct_ops_autocreate/cant_load_full_object:OK
#408/2   struct_ops_autocreate/can_load_partial_object:OK
#408/3   struct_ops_autocreate/autoload_and_shadow_vars:OK
#408/4   struct_ops_autocreate/optional_maps:OK
#408     struct_ops_autocreate:OK
#409/1   struct_ops_kptr_return/kptr_return:OK
#409/2   struct_ops_kptr_return/kptr_return_fail__wrong_type:OK
#409/3   struct_ops_kptr_return/kptr_return_fail__invalid_scalar:OK
#409/4   struct_ops_kptr_return/kptr_return_fail__nonzero_offset:OK
#409/5   struct_ops_kptr_return/kptr_return_fail__local_kptr:OK
#409     struct_ops_kptr_return:OK
#410/1   struct_ops_maybe_null/maybe_null:OK
#410/2   struct_ops_maybe_null/maybe_null_fail:OK
#410     struct_ops_maybe_null:OK
#411/1   struct_ops_module/struct_ops_load:OK
#411/2   struct_ops_module/struct_ops_not_zeroed:OK
#411/3   struct_ops_module/struct_ops_incompatible:OK
#411/4   struct_ops_module/struct_ops_null_out_cb:OK
#411/5   struct_ops_module/struct_ops_forgotten_cb:OK
#411/6   struct_ops_module/test_detach_link:OK
#411/7   struct_ops_module/unsupported_ops:OK
#411     struct_ops_module:OK
do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 nsec
do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
#412/1   struct_ops_multi_pages/multi_pages:FAIL
#412     struct_ops_multi_pages:FAIL
#413/1   struct_ops_no_cfi/load_bpf_test_no_cfi:OK
#413     struct_ops_no_cfi:OK
#414/1   struct_ops_private_stack/private_stack:SKIP
#414/2   struct_ops_private_stack/private_stack_fail:SKIP
#414/3   struct_ops_private_stack/private_stack_recur:SKIP
#414     struct_ops_private_stack:SKIP
#415/1   struct_ops_refcounted/refcounted:OK
#415/2   struct_ops_refcounted/refcounted_fail__ref_leak:OK
#415/3   struct_ops_refcounted/refcounted_fail__global_subprog:OK
#415/4   struct_ops_refcounted/refcounted_fail__tail_call:OK
#415     struct_ops_refcounted:OK

All error logs:
do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 nsec
do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
#412/1   struct_ops_multi_pages/multi_pages:FAIL
#412     struct_ops_multi_pages:FAIL
Summary: 9/25 PASSED, 3 SKIPPED, 1 FAILED
[root@fedora bpf]#
[root@fedora bpf]# ./test_progs -t struct_ops -a test_overhead
#15/1    bad_struct_ops/invalid_prog_reuse:OK
#15/2    bad_struct_ops/unused_program:OK
#15      bad_struct_ops:OK
#408/1   struct_ops_autocreate/cant_load_full_object:OK
#408/2   struct_ops_autocreate/can_load_partial_object:OK
#408/3   struct_ops_autocreate/autoload_and_shadow_vars:OK
#408/4   struct_ops_autocreate/optional_maps:OK
#408     struct_ops_autocreate:OK
#409/1   struct_ops_kptr_return/kptr_return:OK
#409/2   struct_ops_kptr_return/kptr_return_fail__wrong_type:OK
#409/3   struct_ops_kptr_return/kptr_return_fail__invalid_scalar:OK
#409/4   struct_ops_kptr_return/kptr_return_fail__nonzero_offset:OK
#409/5   struct_ops_kptr_return/kptr_return_fail__local_kptr:OK
#409     struct_ops_kptr_return:OK
#410/1   struct_ops_maybe_null/maybe_null:OK
#410/2   struct_ops_maybe_null/maybe_null_fail:OK
#410     struct_ops_maybe_null:OK
#411/1   struct_ops_module/struct_ops_load:OK
#411/2   struct_ops_module/struct_ops_not_zeroed:OK
#411/3   struct_ops_module/struct_ops_incompatible:OK
#411/4   struct_ops_module/struct_ops_null_out_cb:OK
#411/5   struct_ops_module/struct_ops_forgotten_cb:OK
#411/6   struct_ops_module/test_detach_link:OK
#411/7   struct_ops_module/unsupported_ops:OK
#411     struct_ops_module:OK
do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 nsec
do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
#412/1   struct_ops_multi_pages/multi_pages:FAIL
#412     struct_ops_multi_pages:FAIL
#413/1   struct_ops_no_cfi/load_bpf_test_no_cfi:OK
#413     struct_ops_no_cfi:OK
#414/1   struct_ops_private_stack/private_stack:SKIP
#414/2   struct_ops_private_stack/private_stack_fail:SKIP
#414/3   struct_ops_private_stack/private_stack_recur:SKIP
#414     struct_ops_private_stack:SKIP
#415/1   struct_ops_refcounted/refcounted:OK
#415/2   struct_ops_refcounted/refcounted_fail__ref_leak:OK
#415/3   struct_ops_refcounted/refcounted_fail__global_subprog:OK
#415/4   struct_ops_refcounted/refcounted_fail__tail_call:OK
#415     struct_ops_refcounted:OK
#452     test_overhead:OK

All error logs:
do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 nsec
do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
#412/1   struct_ops_multi_pages/multi_pages:FAIL
#412     struct_ops_multi_pages:FAIL
Summary: 9/25 PASSED, 3 SKIPPED, 1 FAILED
[root@fedora bpf]#
[root@fedora bpf]#
[root@fedora bpf]# ./test_progs -t struct_ops -a trampoline_count
#15/1    bad_struct_ops/invalid_prog_reuse:OK
#15/2    bad_struct_ops/unused_program:OK
#15      bad_struct_ops:OK
#408/1   struct_ops_autocreate/cant_load_full_object:OK
#408/2   struct_ops_autocreate/can_load_partial_object:OK
#408/3   struct_ops_autocreate/autoload_and_shadow_vars:OK
#408/4   struct_ops_autocreate/optional_maps:OK
#408     struct_ops_autocreate:OK
#409/1   struct_ops_kptr_return/kptr_return:OK
#409/2   struct_ops_kptr_return/kptr_return_fail__wrong_type:OK
#409/3   struct_ops_kptr_return/kptr_return_fail__invalid_scalar:OK
#409/4   struct_ops_kptr_return/kptr_return_fail__nonzero_offset:OK
#409/5   struct_ops_kptr_return/kptr_return_fail__local_kptr:OK
#409     struct_ops_kptr_return:OK
#410/1   struct_ops_maybe_null/maybe_null:OK
#410/2   struct_ops_maybe_null/maybe_null_fail:OK
#410     struct_ops_maybe_null:OK
#411/1   struct_ops_module/struct_ops_load:OK
#411/2   struct_ops_module/struct_ops_not_zeroed:OK
#411/3   struct_ops_module/struct_ops_incompatible:OK
#411/4   struct_ops_module/struct_ops_null_out_cb:OK
#411/5   struct_ops_module/struct_ops_forgotten_cb:OK
#411/6   struct_ops_module/test_detach_link:OK
#411/7   struct_ops_module/unsupported_ops:OK
#411     struct_ops_module:OK
do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 nsec
do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
#412/1   struct_ops_multi_pages/multi_pages:FAIL
#412     struct_ops_multi_pages:FAIL
#413/1   struct_ops_no_cfi/load_bpf_test_no_cfi:OK
#413     struct_ops_no_cfi:OK
#414/1   struct_ops_private_stack/private_stack:SKIP
#414/2   struct_ops_private_stack/private_stack_fail:SKIP
#414/3   struct_ops_private_stack/private_stack_recur:SKIP
#414     struct_ops_private_stack:SKIP
#415/1   struct_ops_refcounted/refcounted:OK
#415/2   struct_ops_refcounted/refcounted_fail__ref_leak:OK
#415/3   struct_ops_refcounted/refcounted_fail__global_subprog:OK
#415/4   struct_ops_refcounted/refcounted_fail__tail_call:OK
#415     struct_ops_refcounted:OK
#469     trampoline_count:OK

All error logs:
do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 nsec
do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
#412/1   struct_ops_multi_pages/multi_pages:FAIL
#412     struct_ops_multi_pages:FAIL
Summary: 9/25 PASSED, 3 SKIPPED, 1 FAILED
[root@fedora bpf]#
[root@fedora bpf]#
[root@fedora bpf]# ./test_progs -t struct_ops -a fexit_test/fexit
#15/1    bad_struct_ops/invalid_prog_reuse:OK
#15/2    bad_struct_ops/unused_program:OK
#15      bad_struct_ops:OK
#113/1   fexit_test/fexit:OK
#113     fexit_test:OK
#408/1   struct_ops_autocreate/cant_load_full_object:OK
#408/2   struct_ops_autocreate/can_load_partial_object:OK
#408/3   struct_ops_autocreate/autoload_and_shadow_vars:OK
#408/4   struct_ops_autocreate/optional_maps:OK
#408     struct_ops_autocreate:OK
#409/1   struct_ops_kptr_return/kptr_return:OK
#409/2   struct_ops_kptr_return/kptr_return_fail__wrong_type:OK
#409/3   struct_ops_kptr_return/kptr_return_fail__invalid_scalar:OK
#409/4   struct_ops_kptr_return/kptr_return_fail__nonzero_offset:OK
#409/5   struct_ops_kptr_return/kptr_return_fail__local_kptr:OK
#409     struct_ops_kptr_return:OK
#410/1   struct_ops_maybe_null/maybe_null:OK
#410/2   struct_ops_maybe_null/maybe_null_fail:OK
#410     struct_ops_maybe_null:OK
#411/1   struct_ops_module/struct_ops_load:OK
#411/2   struct_ops_module/struct_ops_not_zeroed:OK
#411/3   struct_ops_module/struct_ops_incompatible:OK
#411/4   struct_ops_module/struct_ops_null_out_cb:OK
#411/5   struct_ops_module/struct_ops_forgotten_cb:OK
#411/6   struct_ops_module/test_detach_link:OK
#411/7   struct_ops_module/unsupported_ops:OK
#411     struct_ops_module:OK
do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 nsec
do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
#412/1   struct_ops_multi_pages/multi_pages:FAIL
#412     struct_ops_multi_pages:FAIL
#413/1   struct_ops_no_cfi/load_bpf_test_no_cfi:OK
#413     struct_ops_no_cfi:OK
#414/1   struct_ops_private_stack/private_stack:SKIP
#414/2   struct_ops_private_stack/private_stack_fail:SKIP
#414/3   struct_ops_private_stack/private_stack_recur:SKIP
#414     struct_ops_private_stack:SKIP
#415/1   struct_ops_refcounted/refcounted:OK
#415/2   struct_ops_refcounted/refcounted_fail__ref_leak:OK
#415/3   struct_ops_refcounted/refcounted_fail__global_subprog:OK
#415/4   struct_ops_refcounted/refcounted_fail__tail_call:OK
#415     struct_ops_refcounted:OK

All error logs:
do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 nsec
do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
#412/1   struct_ops_multi_pages/multi_pages:FAIL
#412     struct_ops_multi_pages:FAIL
Summary: 9/26 PASSED, 3 SKIPPED, 1 FAILED
[root@fedora bpf]#
[root@fedora bpf]#
[root@fedora bpf]# ./test_progs -t struct_ops -a fentry_fexit
#15/1    bad_struct_ops/invalid_prog_reuse:OK
#15/2    bad_struct_ops/unused_program:OK
#15      bad_struct_ops:OK
#108     fentry_fexit:OK
#408/1   struct_ops_autocreate/cant_load_full_object:OK
#408/2   struct_ops_autocreate/can_load_partial_object:OK
#408/3   struct_ops_autocreate/autoload_and_shadow_vars:OK
#408/4   struct_ops_autocreate/optional_maps:OK
#408     struct_ops_autocreate:OK
#409/1   struct_ops_kptr_return/kptr_return:OK
#409/2   struct_ops_kptr_return/kptr_return_fail__wrong_type:OK
#409/3   struct_ops_kptr_return/kptr_return_fail__invalid_scalar:OK
#409/4   struct_ops_kptr_return/kptr_return_fail__nonzero_offset:OK
#409/5   struct_ops_kptr_return/kptr_return_fail__local_kptr:OK
#409     struct_ops_kptr_return:OK
#410/1   struct_ops_maybe_null/maybe_null:OK
#410/2   struct_ops_maybe_null/maybe_null_fail:OK
#410     struct_ops_maybe_null:OK
#411/1   struct_ops_module/struct_ops_load:OK
#411/2   struct_ops_module/struct_ops_not_zeroed:OK
#411/3   struct_ops_module/struct_ops_incompatible:OK
#411/4   struct_ops_module/struct_ops_null_out_cb:OK
#411/5   struct_ops_module/struct_ops_forgotten_cb:OK
#411/6   struct_ops_module/test_detach_link:OK
#411/7   struct_ops_module/unsupported_ops:OK
#411     struct_ops_module:OK
do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 nsec
do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
#412/1   struct_ops_multi_pages/multi_pages:FAIL
#412     struct_ops_multi_pages:FAIL
#413/1   struct_ops_no_cfi/load_bpf_test_no_cfi:OK
#413     struct_ops_no_cfi:OK
#414/1   struct_ops_private_stack/private_stack:SKIP
#414/2   struct_ops_private_stack/private_stack_fail:SKIP
#414/3   struct_ops_private_stack/private_stack_recur:SKIP
#414     struct_ops_private_stack:SKIP
#415/1   struct_ops_refcounted/refcounted:OK
#415/2   struct_ops_refcounted/refcounted_fail__ref_leak:OK
#415/3   struct_ops_refcounted/refcounted_fail__global_subprog:OK
#415/4   struct_ops_refcounted/refcounted_fail__tail_call:OK
#415     struct_ops_refcounted:OK

All error logs:
do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 nsec
do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
#412/1   struct_ops_multi_pages/multi_pages:FAIL
#412     struct_ops_multi_pages:FAIL
Summary: 9/25 PASSED, 3 SKIPPED, 1 FAILED
[root@fedora bpf]#
[root@fedora bpf]#
[root@fedora bpf]# ./test_progs -t struct_ops -a modify_return
#15/1    bad_struct_ops/invalid_prog_reuse:OK
#15/2    bad_struct_ops/unused_program:OK
#15      bad_struct_ops:OK
#204     modify_return:OK
#408/1   struct_ops_autocreate/cant_load_full_object:OK
#408/2   struct_ops_autocreate/can_load_partial_object:OK
#408/3   struct_ops_autocreate/autoload_and_shadow_vars:OK
#408/4   struct_ops_autocreate/optional_maps:OK
#408     struct_ops_autocreate:OK
#409/1   struct_ops_kptr_return/kptr_return:OK
#409/2   struct_ops_kptr_return/kptr_return_fail__wrong_type:OK
#409/3   struct_ops_kptr_return/kptr_return_fail__invalid_scalar:OK
#409/4   struct_ops_kptr_return/kptr_return_fail__nonzero_offset:OK
#409/5   struct_ops_kptr_return/kptr_return_fail__local_kptr:OK
#409     struct_ops_kptr_return:OK
#410/1   struct_ops_maybe_null/maybe_null:OK
#410/2   struct_ops_maybe_null/maybe_null_fail:OK
#410     struct_ops_maybe_null:OK
#411/1   struct_ops_module/struct_ops_load:OK
#411/2   struct_ops_module/struct_ops_not_zeroed:OK
#411/3   struct_ops_module/struct_ops_incompatible:OK
#411/4   struct_ops_module/struct_ops_null_out_cb:OK
#411/5   struct_ops_module/struct_ops_forgotten_cb:OK
#411/6   struct_ops_module/test_detach_link:OK
#411/7   struct_ops_module/unsupported_ops:OK
#411     struct_ops_module:OK
do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 nsec
do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
#412/1   struct_ops_multi_pages/multi_pages:FAIL
#412     struct_ops_multi_pages:FAIL
#413/1   struct_ops_no_cfi/load_bpf_test_no_cfi:OK
#413     struct_ops_no_cfi:OK
#414/1   struct_ops_private_stack/private_stack:SKIP
#414/2   struct_ops_private_stack/private_stack_fail:SKIP
#414/3   struct_ops_private_stack/private_stack_recur:SKIP
#414     struct_ops_private_stack:SKIP
#415/1   struct_ops_refcounted/refcounted:OK
#415/2   struct_ops_refcounted/refcounted_fail__ref_leak:OK
#415/3   struct_ops_refcounted/refcounted_fail__global_subprog:OK
#415/4   struct_ops_refcounted/refcounted_fail__tail_call:OK
#415     struct_ops_refcounted:OK

All error logs:
do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 nsec
do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
#412/1   struct_ops_multi_pages/multi_pages:FAIL
#412     struct_ops_multi_pages:FAIL
Summary: 9/25 PASSED, 3 SKIPPED, 1 FAILED

