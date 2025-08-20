Return-Path: <bpf+bounces-66094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E526B2E159
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 17:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2BC188BD18
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 15:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F488261B6C;
	Wed, 20 Aug 2025 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EieItNSg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F6C2222CB
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 15:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755704237; cv=none; b=ZarfHWKlrOtK31IAGudowJJMZhSAAGGm9JZnmImgF8oAiGWCiGvTeAfwF/sU4qjqpX15/pneuPR9BdLqGflrhflw0S/BjMYouJTco0LA4TnJPsmvjYlR8LuAGG/yw+FyFGkgftU32c6kdjJFOF/q9GXsTZYWA5pjDrp9cGCCq80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755704237; c=relaxed/simple;
	bh=Jbdn0bWrNkflcCFo1DGmSO2SnzGxNiFiVCklr+/biQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPVRAuI3sOq1ciWn6Awe3Ei2PfRyt2fSwIc0C2k5Mn6cnSdOWhxJJSFeD/slrkHJyNlp1a/Vq8Dtv0Ax5p1S7PONyWnhY+BDH0P8GGC7eusgOMdHcGSMzRJdQwaj4Ti9pPdt+0lis155kFKPuo3ShZfdImZDMhdLp4NRFt0BMT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EieItNSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900E6C4AF0B
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 15:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755704236;
	bh=Jbdn0bWrNkflcCFo1DGmSO2SnzGxNiFiVCklr+/biQI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EieItNSgW9w5jaf4AwOqWpM3V3pC6dDPMXF6tva3xdunPdkkDc/zW02q7UtvIINAz
	 sYvfJD6HXWAi/yR3R1tY0mzVYL1HtI/SueKSh9+rSoYR5/Vb40r2fFUQtYrhvGtRTa
	 FYZeh2BfcdfOhQhyPlgD7xG7UaWQxJAubLDW+3swemhU4g1BVTdirjX8pSevhMcKzy
	 JrKTHtEB0Axeh+vqshl90uVBbV8+hI+mSCg8ZULnhEznSNg6hMryHI+Utopdbf6z+7
	 fceJYd3I1C0UDcEM2t/lLvylWg+K6xHahvd1OoTT1ccUFDKNmORuqWj37IrusRBFHK
	 asYPd1iyMhm/Q==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61a99d32a84so46742a12.1
        for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 08:37:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvLnn6jxmuSY36jdkXwRzpzrQlcoByhPPgPKi3B08R8ryaoNMOV8/KDOC92JxGEzwnzjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzMWBv8DS8u9PiyNNaQDsyqk3/LFA8zizckeyZeLj1UpDzG4u6
	UAXxBUfUmKG2+LJBc3eVQzp+SUnC8wTZsgQCw9E3+KXR7c1ewbTSW1Igjzri0IrNhIkHt0lQsVr
	1y9Tnwnv1LN2wk9ZQi4CURXe3P10I8Js=
X-Google-Smtp-Source: AGHT+IF36AB6FZzxI+6v61ZTbuAoXuI8dVIaLAQ4i7hKJSXzPMtclXMsIprue2QnVr/w58Mlvs/FQxoiHtvkFA1dcg0=
X-Received: by 2002:a50:cdd9:0:b0:618:6585:ba2e with SMTP id
 4fb4d7f45d1cf-61b2abba796mr8657a12.14.1755704235100; Wed, 20 Aug 2025
 08:37:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820103956.394955-1-hengqi.chen@gmail.com>
In-Reply-To: <20250820103956.394955-1-hengqi.chen@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 20 Aug 2025 23:37:03 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7F+Sqt-w9fwd4mU+UoqES_XEJyZMshF5E2TSkUjmHH-A@mail.gmail.com>
X-Gm-Features: Ac12FXwxaNcu54xqiBthFbC6A1dnPkNsEEjLbSn0Z59gCSbtyHo8uyG4SUeBFaI
Message-ID: <CAAhV-H7F+Sqt-w9fwd4mU+UoqES_XEJyZMshF5E2TSkUjmHH-A@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: BPF: Sign extend struct ops return values properly
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: yangtiezhu@loongson.cn, jianghaoran@kylinos.cn, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	vincent.mc.li@gmail.com, bpf@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Hengqi,

On Wed, Aug 20, 2025 at 8:06=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com>=
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
It is enough to end up here, and please remove the timestamp.

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
Is it possible to rewrite like this?

+static void sign_extend(struct jit_ctx *ctx, int r, u8 size)
+{
+ switch (size) {
+ case 1:
+ emit_insn(ctx, sllid, r, r, 56);
+ emit_insn(ctx, sraid, r, r, 56);
+ break;
+ case 2:
+ emit_insn(ctx, sllid, r, r, 48);
+ emit_insn(ctx, sraid, r, r, 48);
+ break;
+ case 4:
+ emit_insn(ctx, addiw, r, r, 0);
+ break;
+ case 8:
+ default:
+ break;
+ }
+}

Huacai

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
>

