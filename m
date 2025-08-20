Return-Path: <bpf+bounces-66093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F1DB2E131
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 17:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04EA217DDC3
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 15:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EE036CDFD;
	Wed, 20 Aug 2025 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiRWUVCe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FE936CDF1
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755703536; cv=none; b=YJSk1VxFMRLOvOaUpTwwM21hwrZIz1L6hM1WnDTeX/09ISUSyhU15QhQ8KRyEm/nfHRL5ZPl4DKAVgaAcCA7w+XHVm0H4S0cQOpKnEqj0NLaLzA9Yi3wuyL+sPkRIpth3NxMBwSM5sP5N0eWAzir5v/KisQB22AZm4IAU44Ij6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755703536; c=relaxed/simple;
	bh=T1OgEpdx9xxo3/oBUcnoTG9ivPMXST0XqhZy0Cg5kw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJVZIcf/tjfojIYXWSrUKtt+4mV2GxsIwErqdbL2LKMJkNFfxgiLmr7thYPnKyt0Y7Kcsq7kJsj3AuedGPoQuvTHIANlvxkj2H1nVd7SAzIe0KbdLJJp1l0OsOpcxS98vFost1ckgT7QgSRHGGRjP6E8B1/MWg/8Q0gqaBibOrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiRWUVCe; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b0faa6601cso13607211cf.1
        for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 08:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755703533; x=1756308333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wt5ydX6+hSxnt033IDJkbIiS777DXw3Z+EXFaQz81fo=;
        b=LiRWUVCe1LWBcJpX73wg3T5G20KuoYVGOTB5Q+Wqi00KVJ+oV2I17HFEwvagvd5boE
         evjBQd3VejS198VyfuDUJJ76vawZ28rPPDVmgFHLhleYi5SIdE04RN0DZXQv1vi2sC/R
         aT/QgxiHhCSXptX5vvU5h3ZDWyxD04RBz/CvdJa3QA+UreyM71IHOCLA9ExcuUqoEdHg
         0iQpnsoKXSh6rPG6igbqMB3lwbmzHJ0KuM289xh671HOYOGkOd4swiWsDoPwiTxR/6sW
         fB2nNrYafgtX7rVYQdZOhTo+XArxq5V6n2xPNXMUAosvsL5SGgYXlhV33HuRdcPZquT4
         ooqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755703533; x=1756308333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wt5ydX6+hSxnt033IDJkbIiS777DXw3Z+EXFaQz81fo=;
        b=gSJMU1K+az+w6fhCRhf3xIOQ4/aYlL//JJk+hQQgus+Erp6UvH6jH6FBMjg3jFbHuA
         +kFWJaPvqZOII8VrFAD+3n2ycrq/lPjQvlTpZsaGVRftX/ig6xcXwPk+hy+gJ3nGkQlX
         rzkkAaVaganoJnHf6X30x7NAjPrU1EuDCQjw99Lcc/odkbncBKg/tgmIINWOOQ0Ya72Q
         bRTJ2Ws5rkosULKB2HRITCYKdaJUEPozQrkxth9HRDDnnGEe4lRZnPm+uO97nn864Cm9
         6uhdHVhaD4WAjMXkL8Uyz79jtJRar4rAPpUz8NhPRu38yKY8m9MTAEtb77LubfJpMjzv
         JAKg==
X-Forwarded-Encrypted: i=1; AJvYcCUFMwGQs9kKzH2jG0dkXePudX7VsiCz14yt+VCzSsVXllMTCK2RYYaCxujvuKl/puXTPmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/qim118RlOob7SsJuoZpITL9S6PDkDc0sc7i9ODp0ODiYWz8O
	RcfKYjg5iR1tom6fd9Hs/99syPjcOzl1z9nu/m6/BBQwc99QHnWupCz2KM3KNw4RtEXKdyPW8I2
	he3V/IfGvEnvDoRGPQIh1+GvIDzQVJM0=
X-Gm-Gg: ASbGncsEfbz5Rboagy7BkmTxw5W4JgzsL/Eom4cKpXsnCIBdU9236hfjnnB/F7ePwdl
	ZVZxbL/RDm2SeDqdQjO50O5m6paHL7IiM8Bo9odawb+GoWr9WnVMnO8O8dq5FUdw11cpTW8pOb5
	EGhub0QwTIUedWvUE9mWxKYMLbAztFRYaf2xO06fOmp+M/8UccCB5fdWDv2wsGn92hYK07ZckEI
	Lj7an8=
X-Google-Smtp-Source: AGHT+IGtIIOGlC38l/y9XyDejG/I0ZS7TEf0AlxPvX2sB7yPPzPeDUwIAwWI+Z64Ah/xCmzF8ZQWZZ4JnK0mM0in4Ko=
X-Received: by 2002:a05:622a:2cd:b0:4ab:40d6:ba26 with SMTP id
 d75a77b69052e-4b29122c2cemr37565061cf.24.1755703532401; Wed, 20 Aug 2025
 08:25:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820103956.394955-1-hengqi.chen@gmail.com>
 <CAK3+h2zGKRLe4OHjEKf4aQZOFR6X9vFE+RRvDdm-9Xxmy=Zk5Q@mail.gmail.com> <CAK3+h2x0NWMiLQDJFdsoJ9MT8_ayDsb=VGzg=pJBct1axrsu6A@mail.gmail.com>
In-Reply-To: <CAK3+h2x0NWMiLQDJFdsoJ9MT8_ayDsb=VGzg=pJBct1axrsu6A@mail.gmail.com>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Wed, 20 Aug 2025 08:25:20 -0700
X-Gm-Features: Ac12FXwwWj6laICq0TPY-qNkBPEwLCPrI0YViNp1sUNBw1rTIa92fwg2Ivvi5hw
Message-ID: <CAK3+h2yUAvq7JuxWmPoNU=O2aSXWkZQBUMEoxwTn5m8Dg5+9Hg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: BPF: Sign extend struct ops return values properly
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: chenhuacai@kernel.org, yangtiezhu@loongson.cn, jianghaoran@kylinos.cn, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	bpf@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 8:16=E2=80=AFAM Vincent Li <vincent.mc.li@gmail.com=
> wrote:
>
> On Wed, Aug 20, 2025 at 8:15=E2=80=AFAM Vincent Li <vincent.mc.li@gmail.c=
om> wrote:
> >
> > On Wed, Aug 20, 2025 at 5:06=E2=80=AFAM Hengqi Chen <hengqi.chen@gmail.=
com> wrote:
> > >
> > > The ns_bpf_qdisc selftest triggers a kernel panic:
> > >
> > >     [ 2738.595309] CPU 0 Unable to handle kernel paging request at vi=
rtual address 0000000000741d58, era =3D=3D 90000000851b5ac0, ra =3D=3D 9000=
0000851b5aa4
> > >     [ 2738.596716] Oops[#1]:
> > >     [ 2738.596980] CPU: 0 UID: 0 PID: 449 Comm: test_progs Tainted: G=
           OE       6.16.0+ #3 PREEMPT(full)
> > >     [ 2738.597184] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> > >     [ 2738.597265] Hardware name: QEMU QEMU Virtual Machine, BIOS unk=
nown 2/2/2022
> > >     [ 2738.597386] pc 90000000851b5ac0 ra 90000000851b5aa4 tp 9000000=
1076b8000 sp 90000001076bb600
> > >     [ 2738.597484] a0 0000000000741ce8 a1 0000000000000001 a2 9000000=
1076bb5c0 a3 0000000000000008
> > >     [ 2738.597577] a4 90000001004c4620 a5 9000000100741ce8 a6 0000000=
000000000 a7 0100000000000000
> > >     [ 2738.597682] t0 0000000000000010 t1 0000000000000000 t2 9000000=
104d24d30 t3 0000000000000001
> > >     [ 2738.597835] t4 4f2317da8a7e08c4 t5 fffffefffc002f00 t6 9000000=
1004c4620 t7 ffffffffc61c5b3d
> > >     [ 2738.597997] t8 0000000000000000 u0 0000000000000001 s9 0000000=
000000050 s0 90000001075bc800
> > >     [ 2738.598097] s1 0000000000000040 s2 900000010597c400 s3 0000000=
000000008 s4 90000001075bc880
> > >     [ 2738.598196] s5 90000001075bc8f0 s6 0000000000000000 s7 0000000=
000741ce8 s8 0000000000000000
> > >     [ 2738.598313]    ra: 90000000851b5aa4 __qdisc_run+0xac/0x8d8
> > >     [ 2738.598553]   ERA: 90000000851b5ac0 __qdisc_run+0xc8/0x8d8
> > >     [ 2738.598629]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=
=3DCC -WE)
> > >     [ 2738.598991]  PRMD: 00000004 (PPLV0 +PIE -PWE)
> > >     [ 2738.599065]  EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
> > >     [ 2738.599160]  ECFG: 00071c1d (LIE=3D0,2-4,10-12 VS=3D7)
> > >     [ 2738.599278] ESTAT: 00010000 [PIL] (IS=3D ECode=3D1 EsubCode=3D=
0)
> > >     [ 2738.599364]  BADV: 0000000000741d58
> > >     [ 2738.599429]  PRID: 0014c010 (Loongson-64bit, Loongson-3A5000)
> > >     [ 2738.599513] Modules linked in: bpf_testmod(OE) [last unloaded:=
 bpf_testmod(OE)]
> > >     [ 2738.599724] Process test_progs (pid: 449, threadinfo=3D0000000=
09af02b3a, task=3D00000000e9ba4956)
> > >     [ 2738.599916] Stack : 0000000000000000 90000001075bc8ac 90000000=
869524a8 9000000100741ce8
> > >     [ 2738.600065]         90000001075bc800 9000000100415300 90000001=
075bc8ac 0000000000000000
> > >     [ 2738.600170]         900000010597c400 900000008694a000 00000000=
00000000 9000000105b59000
> > >     [ 2738.600278]         90000001075bc800 9000000100741ce8 00000000=
00000050 900000008513000c
> > >     [ 2738.600381]         9000000086936000 0000000100094d4c fffffff4=
00676208 0000000000000000
> > >     [ 2738.600482]         9000000105b59000 900000008694a000 90000000=
86bf0dc0 9000000105b59000
> > >     [ 2738.600585]         9000000086bf0d68 9000000085147010 90000001=
075be788 0000000000000000
> > >     [ 2738.600690]         9000000086bf0f98 0000000000000001 00000000=
00000010 9000000006015840
> > >     [ 2738.600795]         0000000000000000 9000000086be6c40 00000000=
00000000 0000000000000000
> > >     [ 2738.600901]         0000000000000000 4f2317da8a7e08c4 00000000=
00000101 4f2317da8a7e08c4
> > >     [ 2738.601007]         ...
> > >     [ 2738.601062] Call Trace:
> > >     [ 2738.601135] [<90000000851b5ac0>] __qdisc_run+0xc8/0x8d8
> > >     [ 2738.601396] [<9000000085130008>] __dev_queue_xmit+0x578/0x10f0
> > >     [ 2738.601482] [<90000000853701c0>] ip6_finish_output2+0x2f0/0x95=
0
> > >     [ 2738.601568] [<9000000085374bc8>] ip6_finish_output+0x2b8/0x448
> > >     [ 2738.601646] [<9000000085370b24>] ip6_xmit+0x304/0x858
> > >     [ 2738.601711] [<90000000853c4438>] inet6_csk_xmit+0x100/0x170
> > >     [ 2738.601784] [<90000000852b32f0>] __tcp_transmit_skb+0x490/0xdd=
0
> > >     [ 2738.601863] [<90000000852b47fc>] tcp_connect+0xbcc/0x1168
> > >     [ 2738.601934] [<90000000853b9088>] tcp_v6_connect+0x580/0x8a0
> > >     [ 2738.602019] [<90000000852e7738>] __inet_stream_connect+0x170/0=
x480
> > >     [ 2738.602103] [<90000000852e7a98>] inet_stream_connect+0x50/0x88
> > >     [ 2738.602175] [<90000000850f2814>] __sys_connect+0xe4/0x110
> > >     [ 2738.602244] [<90000000850f2858>] sys_connect+0x18/0x28
> > >     [ 2738.602320] [<9000000085520c94>] do_syscall+0x94/0x1a0
> > >     [ 2738.602399] [<9000000083df1fb8>] handle_syscall+0xb8/0x158
> > >     [ 2738.602502]
> > >     [ 2738.602546] Code: 4001ad80  2400873f  2400832d <240073cc> 0011=
37ff  001133ff  6407b41f  001503cc  0280041d
> > >     [ 2738.602724]
> > >     [ 2738.602916] ---[ end trace 0000000000000000 ]---
> > >     [ 2738.603210] Kernel panic - not syncing: Fatal exception in int=
errupt
> > >     [ 2738.603548] Kernel relocated by 0x83bb0000
> > >     [ 2738.603622]  .text @ 0x9000000083db0000
> > >     [ 2738.603699]  .data @ 0x9000000085690000
> > >     [ 2738.603753]  .bss  @ 0x9000000087491e00
> > >     [ 2738.603900] ---[ end Kernel panic - not syncing: Fatal excepti=
on in interrupt ]---
> > >
> > > The bpf_fifo_dequeue prog returns a skb which is a pointer.
> > > The pointer is treated as a 32bit value and sign extend to
> > > 64bit in epilogue. This behavior is right for most bpf prog
> > > types but wrong for struct ops which requires LoongArch ABI.
> > >
> > > So let's sign extend struct ops return values according to
> > > the return value spec in function model.
> > >
> > > Fixes: 6abf17d690d8 ("LoongArch: BPF: Add struct ops support for tram=
poline")
> > > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > > ---
> > >  arch/loongarch/net/bpf_jit.c | 47 ++++++++++++++++++++++++++++++----=
--
> > >  1 file changed, 40 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_ji=
t.c
> > > index abfdb6bb5c38..4077565c9934 100644
> > > --- a/arch/loongarch/net/bpf_jit.c
> > > +++ b/arch/loongarch/net/bpf_jit.c
> > > @@ -1361,7 +1361,8 @@ static void restore_args(struct jit_ctx *ctx, i=
nt nargs, int args_off)
> > >  }
> > >
> > >  static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_lin=
k *l,
> > > -                          int args_off, int retval_off, int run_ctx_=
off, bool save_ret)
> > > +                          const struct btf_func_model *m, int args_o=
ff,
> > > +                          int retval_off, int run_ctx_off, bool save=
_ret)
> > >  {
> > >         int ret;
> > >         u32 *branch;
> > > @@ -1425,13 +1426,14 @@ static int invoke_bpf_prog(struct jit_ctx *ct=
x, struct bpf_tramp_link *l,
> > >  }
> > >
> > >  static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp=
_links *tl,
> > > -                              int args_off, int retval_off, int run_=
ctx_off, u32 **branches)
> > > +                              const struct btf_func_model *m, int ar=
gs_off,
> > > +                              int retval_off, int run_ctx_off, u32 *=
*branches)
> > >  {
> > >         int i;
> > >
> > >         emit_insn(ctx, std, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_FP, -re=
tval_off);
> > >         for (i =3D 0; i < tl->nr_links; i++) {
> > > -               invoke_bpf_prog(ctx, tl->links[i], args_off, retval_o=
ff, run_ctx_off, true);
> > > +               invoke_bpf_prog(ctx, tl->links[i], m, args_off, retva=
l_off, run_ctx_off, true);
> > >                 emit_insn(ctx, ldd, LOONGARCH_GPR_T1, LOONGARCH_GPR_F=
P, -retval_off);
> > >                 branches[i] =3D (u32 *)ctx->image + ctx->idx;
> > >                 emit_insn(ctx, nop);
> > > @@ -1448,6 +1450,30 @@ void arch_free_bpf_trampoline(void *image, uns=
igned int size)
> > >         bpf_prog_pack_free(image, size);
> > >  }
> > >
> > > +/*
> > > + * Sign-extend the register if necessary
> > > + */
> > > +static int sign_extend(struct jit_ctx *ctx, int r, u8 size)
> > > +{
> > > +       switch (size) {
> > > +       case 1:
> > > +               emit_insn(ctx, sllid, r, r, 56);
> > > +               emit_insn(ctx, sraid, r, r, 56);
> > > +               return 0;
> > > +       case 2:
> > > +               emit_insn(ctx, sllid, r, r, 48);
> > > +               emit_insn(ctx, sraid, r, r, 48);
> > > +               return 0;
> > > +       case 4:
> > > +               emit_insn(ctx, addiw, r, r, 0);
> > > +               return 0;
> > > +       case 8:
> > > +               return 0;
> > > +       default:
> > > +               return -1;
> > > +       }
> > > +}
> > > +
> > >  static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct=
 bpf_tramp_image *im,
> > >                                          const struct btf_func_model =
*m, struct bpf_tramp_links *tlinks,
> > >                                          void *func_addr, u32 flags)
> > > @@ -1602,8 +1628,8 @@ static int __arch_prepare_bpf_trampoline(struct=
 jit_ctx *ctx, struct bpf_tramp_i
> > >         }
> > >
> > >         for (i =3D 0; i < fentry->nr_links; i++) {
> > > -               ret =3D invoke_bpf_prog(ctx, fentry->links[i], args_o=
ff, retval_off,
> > > -                                     run_ctx_off, flags & BPF_TRAMP_=
F_RET_FENTRY_RET);
> > > +               ret =3D invoke_bpf_prog(ctx, fentry->links[i], m, arg=
s_off, retval_off,
> > > +                             run_ctx_off, flags & BPF_TRAMP_F_RET_FE=
NTRY_RET);
> > >                 if (ret)
> > >                         return ret;
> > >         }
> > > @@ -1612,7 +1638,7 @@ static int __arch_prepare_bpf_trampoline(struct=
 jit_ctx *ctx, struct bpf_tramp_i
> > >                 if (!branches)
> > >                         return -ENOMEM;
> > >
> > > -               invoke_bpf_mod_ret(ctx, fmod_ret, args_off, retval_of=
f, run_ctx_off, branches);
> > > +               invoke_bpf_mod_ret(ctx, fmod_ret, m, args_off, retval=
_off, run_ctx_off, branches);
> > >         }
> > >
> > >         if (flags & BPF_TRAMP_F_CALL_ORIG) {
> > > @@ -1638,7 +1664,8 @@ static int __arch_prepare_bpf_trampoline(struct=
 jit_ctx *ctx, struct bpf_tramp_i
> > >         }
> > >
> > >         for (i =3D 0; i < fexit->nr_links; i++) {
> > > -               ret =3D invoke_bpf_prog(ctx, fexit->links[i], args_of=
f, retval_off, run_ctx_off, false);
> > > +               ret =3D invoke_bpf_prog(ctx, fexit->links[i], m, args=
_off,
> > > +                                     retval_off, run_ctx_off, false)=
;
> > >                 if (ret)
> > >                         goto out;
> > >         }
> > > @@ -1657,6 +1684,12 @@ static int __arch_prepare_bpf_trampoline(struc=
t jit_ctx *ctx, struct bpf_tramp_i
> > >         if (save_ret) {
> > >                 emit_insn(ctx, ldd, LOONGARCH_GPR_A0, LOONGARCH_GPR_F=
P, -retval_off);
> > >                 emit_insn(ctx, ldd, regmap[BPF_REG_0], LOONGARCH_GPR_=
FP, -(retval_off - 8));
> > > +               if (is_struct_ops) {
> > > +                       move_reg(ctx, LOONGARCH_GPR_A0, regmap[BPF_RE=
G_0]);
> > > +                       ret =3D sign_extend(ctx, LOONGARCH_GPR_A0, m-=
>ret_size);
> > > +                       if (ret)
> > > +                               goto out;
> > > +               }
> > >         }
> > >
> > >         emit_insn(ctx, ldd, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg=
_off);
> > > --
> > > 2.43.5
> > >
> >
> > Tested-by: Vincent Li <vincent.mc.li@gmail.com>
> >
> >  [root@fedora bpf]# ./test_progs -t struct_ops -d struct_ops_multi_page=
s
> > #15/1    bad_struct_ops/invalid_prog_reuse:OK
> > #15/2    bad_struct_ops/unused_program:OK
> > #15      bad_struct_ops:OK
> > #408/1   struct_ops_autocreate/cant_load_full_object:OK
> > #408/2   struct_ops_autocreate/can_load_partial_object:OK
> > #408/3   struct_ops_autocreate/autoload_and_shadow_vars:OK
> > #408/4   struct_ops_autocreate/optional_maps:OK
> > #408     struct_ops_autocreate:OK
> > #409/1   struct_ops_kptr_return/kptr_return:OK
> > #409/2   struct_ops_kptr_return/kptr_return_fail__wrong_type:OK
> > #409/3   struct_ops_kptr_return/kptr_return_fail__invalid_scalar:OK
> > #409/4   struct_ops_kptr_return/kptr_return_fail__nonzero_offset:OK
> > #409/5   struct_ops_kptr_return/kptr_return_fail__local_kptr:OK
> > #409     struct_ops_kptr_return:OK
> > #410/1   struct_ops_maybe_null/maybe_null:OK
> > #410/2   struct_ops_maybe_null/maybe_null_fail:OK
> > #410     struct_ops_maybe_null:OK
> > #411/1   struct_ops_module/struct_ops_load:OK
> > #411/2   struct_ops_module/struct_ops_not_zeroed:OK
> > #411/3   struct_ops_module/struct_ops_incompatible:OK
> > #411/4   struct_ops_module/struct_ops_null_out_cb:OK
> > #411/5   struct_ops_module/struct_ops_forgotten_cb:OK
> > #411/6   struct_ops_module/test_detach_link:OK
> > #411/7   struct_ops_module/unsupported_ops:OK
> > #411     struct_ops_module:OK
> > #413/1   struct_ops_no_cfi/load_bpf_test_no_cfi:OK
> > #413     struct_ops_no_cfi:OK
> > #414/1   struct_ops_private_stack/private_stack:SKIP
> > #414/2   struct_ops_private_stack/private_stack_fail:SKIP
> > #414/3   struct_ops_private_stack/private_stack_recur:SKIP
> > #414     struct_ops_private_stack:SKIP
> > #415/1   struct_ops_refcounted/refcounted:OK
> > #415/2   struct_ops_refcounted/refcounted_fail__ref_leak:OK
> > #415/3   struct_ops_refcounted/refcounted_fail__global_subprog:OK
> > #415/4   struct_ops_refcounted/refcounted_fail__tail_call:OK
> > #415     struct_ops_refcounted:OK
> > Summary: 8/25 PASSED, 3 SKIPPED, 0 FAILED
> > [root@fedora bpf]#
> > [root@fedora bpf]#
> > [root@fedora bpf]# ./test_progs -t struct_ops -a fentry_test/fentry
> > #15/1    bad_struct_ops/invalid_prog_reuse:OK
> > #15/2    bad_struct_ops/unused_program:OK
> > #15      bad_struct_ops:OK
> > #109/1   fentry_test/fentry:OK
> > #109     fentry_test:OK
> > #408/1   struct_ops_autocreate/cant_load_full_object:OK
> > #408/2   struct_ops_autocreate/can_load_partial_object:OK
> > #408/3   struct_ops_autocreate/autoload_and_shadow_vars:OK
> > #408/4   struct_ops_autocreate/optional_maps:OK
> > #408     struct_ops_autocreate:OK
> > #409/1   struct_ops_kptr_return/kptr_return:OK
> > #409/2   struct_ops_kptr_return/kptr_return_fail__wrong_type:OK
> > #409/3   struct_ops_kptr_return/kptr_return_fail__invalid_scalar:OK
> > #409/4   struct_ops_kptr_return/kptr_return_fail__nonzero_offset:OK
> > #409/5   struct_ops_kptr_return/kptr_return_fail__local_kptr:OK
> > #409     struct_ops_kptr_return:OK
> > #410/1   struct_ops_maybe_null/maybe_null:OK
> > #410/2   struct_ops_maybe_null/maybe_null_fail:OK
> > #410     struct_ops_maybe_null:OK
> > #411/1   struct_ops_module/struct_ops_load:OK
> > #411/2   struct_ops_module/struct_ops_not_zeroed:OK
> > #411/3   struct_ops_module/struct_ops_incompatible:OK
> > #411/4   struct_ops_module/struct_ops_null_out_cb:OK
> > #411/5   struct_ops_module/struct_ops_forgotten_cb:OK
> > #411/6   struct_ops_module/test_detach_link:OK
> > #411/7   struct_ops_module/unsupported_ops:OK
> > #411     struct_ops_module:OK
> > do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 n=
sec
> > do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
> > #412/1   struct_ops_multi_pages/multi_pages:FAIL
> > #412     struct_ops_multi_pages:FAIL
> > #413/1   struct_ops_no_cfi/load_bpf_test_no_cfi:OK
> > #413     struct_ops_no_cfi:OK
> > #414/1   struct_ops_private_stack/private_stack:SKIP
> > #414/2   struct_ops_private_stack/private_stack_fail:SKIP
> > #414/3   struct_ops_private_stack/private_stack_recur:SKIP
> > #414     struct_ops_private_stack:SKIP
> > #415/1   struct_ops_refcounted/refcounted:OK
> > #415/2   struct_ops_refcounted/refcounted_fail__ref_leak:OK
> > #415/3   struct_ops_refcounted/refcounted_fail__global_subprog:OK
> > #415/4   struct_ops_refcounted/refcounted_fail__tail_call:OK
> > #415     struct_ops_refcounted:OK
> >
> > All error logs:
> > do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 n=
sec
> > do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
> > #412/1   struct_ops_multi_pages/multi_pages:FAIL
> > #412     struct_ops_multi_pages:FAIL
> > Summary: 9/26 PASSED, 3 SKIPPED, 1 FAILED
> > [root@fedora bpf]#
> > [root@fedora bpf]#
> > [root@fedora bpf]# ./test_progs -t struct_ops -a fexit_sleep
> > #15/1    bad_struct_ops/invalid_prog_reuse:OK
> > #15/2    bad_struct_ops/unused_program:OK
> > #15      bad_struct_ops:OK
> > #111     fexit_sleep:OK
> > #408/1   struct_ops_autocreate/cant_load_full_object:OK
> > #408/2   struct_ops_autocreate/can_load_partial_object:OK
> > #408/3   struct_ops_autocreate/autoload_and_shadow_vars:OK
> > #408/4   struct_ops_autocreate/optional_maps:OK
> > #408     struct_ops_autocreate:OK
> > #409/1   struct_ops_kptr_return/kptr_return:OK
> > #409/2   struct_ops_kptr_return/kptr_return_fail__wrong_type:OK
> > #409/3   struct_ops_kptr_return/kptr_return_fail__invalid_scalar:OK
> > #409/4   struct_ops_kptr_return/kptr_return_fail__nonzero_offset:OK
> > #409/5   struct_ops_kptr_return/kptr_return_fail__local_kptr:OK
> > #409     struct_ops_kptr_return:OK
> > #410/1   struct_ops_maybe_null/maybe_null:OK
> > #410/2   struct_ops_maybe_null/maybe_null_fail:OK
> > #410     struct_ops_maybe_null:OK
> > #411/1   struct_ops_module/struct_ops_load:OK
> > #411/2   struct_ops_module/struct_ops_not_zeroed:OK
> > #411/3   struct_ops_module/struct_ops_incompatible:OK
> > #411/4   struct_ops_module/struct_ops_null_out_cb:OK
> > #411/5   struct_ops_module/struct_ops_forgotten_cb:OK
> > #411/6   struct_ops_module/test_detach_link:OK
> > #411/7   struct_ops_module/unsupported_ops:OK
> > #411     struct_ops_module:OK
> > do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 n=
sec
> > do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
> > #412/1   struct_ops_multi_pages/multi_pages:FAIL
> > #412     struct_ops_multi_pages:FAIL
> > #413/1   struct_ops_no_cfi/load_bpf_test_no_cfi:OK
> > #413     struct_ops_no_cfi:OK
> > #414/1   struct_ops_private_stack/private_stack:SKIP
> > #414/2   struct_ops_private_stack/private_stack_fail:SKIP
> > #414/3   struct_ops_private_stack/private_stack_recur:SKIP
> > #414     struct_ops_private_stack:SKIP
> > #415/1   struct_ops_refcounted/refcounted:OK
> > #415/2   struct_ops_refcounted/refcounted_fail__ref_leak:OK
> > #415/3   struct_ops_refcounted/refcounted_fail__global_subprog:OK
> > #415/4   struct_ops_refcounted/refcounted_fail__tail_call:OK
> > #415     struct_ops_refcounted:OK
> >
> > All error logs:
> > do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 n=
sec
> > do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
> > #412/1   struct_ops_multi_pages/multi_pages:FAIL
> > #412     struct_ops_multi_pages:FAIL
> > Summary: 9/25 PASSED, 3 SKIPPED, 1 FAILED
> > [root@fedora bpf]#
> > [root@fedora bpf]# ./test_progs -t struct_ops -a test_overhead
> > #15/1    bad_struct_ops/invalid_prog_reuse:OK
> > #15/2    bad_struct_ops/unused_program:OK
> > #15      bad_struct_ops:OK
> > #408/1   struct_ops_autocreate/cant_load_full_object:OK
> > #408/2   struct_ops_autocreate/can_load_partial_object:OK
> > #408/3   struct_ops_autocreate/autoload_and_shadow_vars:OK
> > #408/4   struct_ops_autocreate/optional_maps:OK
> > #408     struct_ops_autocreate:OK
> > #409/1   struct_ops_kptr_return/kptr_return:OK
> > #409/2   struct_ops_kptr_return/kptr_return_fail__wrong_type:OK
> > #409/3   struct_ops_kptr_return/kptr_return_fail__invalid_scalar:OK
> > #409/4   struct_ops_kptr_return/kptr_return_fail__nonzero_offset:OK
> > #409/5   struct_ops_kptr_return/kptr_return_fail__local_kptr:OK
> > #409     struct_ops_kptr_return:OK
> > #410/1   struct_ops_maybe_null/maybe_null:OK
> > #410/2   struct_ops_maybe_null/maybe_null_fail:OK
> > #410     struct_ops_maybe_null:OK
> > #411/1   struct_ops_module/struct_ops_load:OK
> > #411/2   struct_ops_module/struct_ops_not_zeroed:OK
> > #411/3   struct_ops_module/struct_ops_incompatible:OK
> > #411/4   struct_ops_module/struct_ops_null_out_cb:OK
> > #411/5   struct_ops_module/struct_ops_forgotten_cb:OK
> > #411/6   struct_ops_module/test_detach_link:OK
> > #411/7   struct_ops_module/unsupported_ops:OK
> > #411     struct_ops_module:OK
> > do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 n=
sec
> > do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
> > #412/1   struct_ops_multi_pages/multi_pages:FAIL
> > #412     struct_ops_multi_pages:FAIL
> > #413/1   struct_ops_no_cfi/load_bpf_test_no_cfi:OK
> > #413     struct_ops_no_cfi:OK
> > #414/1   struct_ops_private_stack/private_stack:SKIP
> > #414/2   struct_ops_private_stack/private_stack_fail:SKIP
> > #414/3   struct_ops_private_stack/private_stack_recur:SKIP
> > #414     struct_ops_private_stack:SKIP
> > #415/1   struct_ops_refcounted/refcounted:OK
> > #415/2   struct_ops_refcounted/refcounted_fail__ref_leak:OK
> > #415/3   struct_ops_refcounted/refcounted_fail__global_subprog:OK
> > #415/4   struct_ops_refcounted/refcounted_fail__tail_call:OK
> > #415     struct_ops_refcounted:OK
> > #452     test_overhead:OK
> >
> > All error logs:
> > do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 n=
sec
> > do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
> > #412/1   struct_ops_multi_pages/multi_pages:FAIL
> > #412     struct_ops_multi_pages:FAIL
> > Summary: 9/25 PASSED, 3 SKIPPED, 1 FAILED
> > [root@fedora bpf]#
> > [root@fedora bpf]#
> > [root@fedora bpf]# ./test_progs -t struct_ops -a trampoline_count
> > #15/1    bad_struct_ops/invalid_prog_reuse:OK
> > #15/2    bad_struct_ops/unused_program:OK
> > #15      bad_struct_ops:OK
> > #408/1   struct_ops_autocreate/cant_load_full_object:OK
> > #408/2   struct_ops_autocreate/can_load_partial_object:OK
> > #408/3   struct_ops_autocreate/autoload_and_shadow_vars:OK
> > #408/4   struct_ops_autocreate/optional_maps:OK
> > #408     struct_ops_autocreate:OK
> > #409/1   struct_ops_kptr_return/kptr_return:OK
> > #409/2   struct_ops_kptr_return/kptr_return_fail__wrong_type:OK
> > #409/3   struct_ops_kptr_return/kptr_return_fail__invalid_scalar:OK
> > #409/4   struct_ops_kptr_return/kptr_return_fail__nonzero_offset:OK
> > #409/5   struct_ops_kptr_return/kptr_return_fail__local_kptr:OK
> > #409     struct_ops_kptr_return:OK
> > #410/1   struct_ops_maybe_null/maybe_null:OK
> > #410/2   struct_ops_maybe_null/maybe_null_fail:OK
> > #410     struct_ops_maybe_null:OK
> > #411/1   struct_ops_module/struct_ops_load:OK
> > #411/2   struct_ops_module/struct_ops_not_zeroed:OK
> > #411/3   struct_ops_module/struct_ops_incompatible:OK
> > #411/4   struct_ops_module/struct_ops_null_out_cb:OK
> > #411/5   struct_ops_module/struct_ops_forgotten_cb:OK
> > #411/6   struct_ops_module/test_detach_link:OK
> > #411/7   struct_ops_module/unsupported_ops:OK
> > #411     struct_ops_module:OK
> > do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 n=
sec
> > do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
> > #412/1   struct_ops_multi_pages/multi_pages:FAIL
> > #412     struct_ops_multi_pages:FAIL
> > #413/1   struct_ops_no_cfi/load_bpf_test_no_cfi:OK
> > #413     struct_ops_no_cfi:OK
> > #414/1   struct_ops_private_stack/private_stack:SKIP
> > #414/2   struct_ops_private_stack/private_stack_fail:SKIP
> > #414/3   struct_ops_private_stack/private_stack_recur:SKIP
> > #414     struct_ops_private_stack:SKIP
> > #415/1   struct_ops_refcounted/refcounted:OK
> > #415/2   struct_ops_refcounted/refcounted_fail__ref_leak:OK
> > #415/3   struct_ops_refcounted/refcounted_fail__global_subprog:OK
> > #415/4   struct_ops_refcounted/refcounted_fail__tail_call:OK
> > #415     struct_ops_refcounted:OK
> > #469     trampoline_count:OK
> >
> > All error logs:
> > do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 n=
sec
> > do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
> > #412/1   struct_ops_multi_pages/multi_pages:FAIL
> > #412     struct_ops_multi_pages:FAIL
> > Summary: 9/25 PASSED, 3 SKIPPED, 1 FAILED
> > [root@fedora bpf]#
> > [root@fedora bpf]#
> > [root@fedora bpf]# ./test_progs -t struct_ops -a fexit_test/fexit
> > #15/1    bad_struct_ops/invalid_prog_reuse:OK
> > #15/2    bad_struct_ops/unused_program:OK
> > #15      bad_struct_ops:OK
> > #113/1   fexit_test/fexit:OK
> > #113     fexit_test:OK
> > #408/1   struct_ops_autocreate/cant_load_full_object:OK
> > #408/2   struct_ops_autocreate/can_load_partial_object:OK
> > #408/3   struct_ops_autocreate/autoload_and_shadow_vars:OK
> > #408/4   struct_ops_autocreate/optional_maps:OK
> > #408     struct_ops_autocreate:OK
> > #409/1   struct_ops_kptr_return/kptr_return:OK
> > #409/2   struct_ops_kptr_return/kptr_return_fail__wrong_type:OK
> > #409/3   struct_ops_kptr_return/kptr_return_fail__invalid_scalar:OK
> > #409/4   struct_ops_kptr_return/kptr_return_fail__nonzero_offset:OK
> > #409/5   struct_ops_kptr_return/kptr_return_fail__local_kptr:OK
> > #409     struct_ops_kptr_return:OK
> > #410/1   struct_ops_maybe_null/maybe_null:OK
> > #410/2   struct_ops_maybe_null/maybe_null_fail:OK
> > #410     struct_ops_maybe_null:OK
> > #411/1   struct_ops_module/struct_ops_load:OK
> > #411/2   struct_ops_module/struct_ops_not_zeroed:OK
> > #411/3   struct_ops_module/struct_ops_incompatible:OK
> > #411/4   struct_ops_module/struct_ops_null_out_cb:OK
> > #411/5   struct_ops_module/struct_ops_forgotten_cb:OK
> > #411/6   struct_ops_module/test_detach_link:OK
> > #411/7   struct_ops_module/unsupported_ops:OK
> > #411     struct_ops_module:OK
> > do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 n=
sec
> > do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
> > #412/1   struct_ops_multi_pages/multi_pages:FAIL
> > #412     struct_ops_multi_pages:FAIL
> > #413/1   struct_ops_no_cfi/load_bpf_test_no_cfi:OK
> > #413     struct_ops_no_cfi:OK
> > #414/1   struct_ops_private_stack/private_stack:SKIP
> > #414/2   struct_ops_private_stack/private_stack_fail:SKIP
> > #414/3   struct_ops_private_stack/private_stack_recur:SKIP
> > #414     struct_ops_private_stack:SKIP
> > #415/1   struct_ops_refcounted/refcounted:OK
> > #415/2   struct_ops_refcounted/refcounted_fail__ref_leak:OK
> > #415/3   struct_ops_refcounted/refcounted_fail__global_subprog:OK
> > #415/4   struct_ops_refcounted/refcounted_fail__tail_call:OK
> > #415     struct_ops_refcounted:OK
> >
> > All error logs:
> > do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 n=
sec
> > do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
> > #412/1   struct_ops_multi_pages/multi_pages:FAIL
> > #412     struct_ops_multi_pages:FAIL
> > Summary: 9/26 PASSED, 3 SKIPPED, 1 FAILED
> > [root@fedora bpf]#
> > [root@fedora bpf]#
> > [root@fedora bpf]# ./test_progs -t struct_ops -a fentry_fexit
> > #15/1    bad_struct_ops/invalid_prog_reuse:OK
> > #15/2    bad_struct_ops/unused_program:OK
> > #15      bad_struct_ops:OK
> > #108     fentry_fexit:OK
> > #408/1   struct_ops_autocreate/cant_load_full_object:OK
> > #408/2   struct_ops_autocreate/can_load_partial_object:OK
> > #408/3   struct_ops_autocreate/autoload_and_shadow_vars:OK
> > #408/4   struct_ops_autocreate/optional_maps:OK
> > #408     struct_ops_autocreate:OK
> > #409/1   struct_ops_kptr_return/kptr_return:OK
> > #409/2   struct_ops_kptr_return/kptr_return_fail__wrong_type:OK
> > #409/3   struct_ops_kptr_return/kptr_return_fail__invalid_scalar:OK
> > #409/4   struct_ops_kptr_return/kptr_return_fail__nonzero_offset:OK
> > #409/5   struct_ops_kptr_return/kptr_return_fail__local_kptr:OK
> > #409     struct_ops_kptr_return:OK
> > #410/1   struct_ops_maybe_null/maybe_null:OK
> > #410/2   struct_ops_maybe_null/maybe_null_fail:OK
> > #410     struct_ops_maybe_null:OK
> > #411/1   struct_ops_module/struct_ops_load:OK
> > #411/2   struct_ops_module/struct_ops_not_zeroed:OK
> > #411/3   struct_ops_module/struct_ops_incompatible:OK
> > #411/4   struct_ops_module/struct_ops_null_out_cb:OK
> > #411/5   struct_ops_module/struct_ops_forgotten_cb:OK
> > #411/6   struct_ops_module/test_detach_link:OK
> > #411/7   struct_ops_module/unsupported_ops:OK
> > #411     struct_ops_module:OK
> > do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 n=
sec
> > do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
> > #412/1   struct_ops_multi_pages/multi_pages:FAIL
> > #412     struct_ops_multi_pages:FAIL
> > #413/1   struct_ops_no_cfi/load_bpf_test_no_cfi:OK
> > #413     struct_ops_no_cfi:OK
> > #414/1   struct_ops_private_stack/private_stack:SKIP
> > #414/2   struct_ops_private_stack/private_stack_fail:SKIP
> > #414/3   struct_ops_private_stack/private_stack_recur:SKIP
> > #414     struct_ops_private_stack:SKIP
> > #415/1   struct_ops_refcounted/refcounted:OK
> > #415/2   struct_ops_refcounted/refcounted_fail__ref_leak:OK
> > #415/3   struct_ops_refcounted/refcounted_fail__global_subprog:OK
> > #415/4   struct_ops_refcounted/refcounted_fail__tail_call:OK
> > #415     struct_ops_refcounted:OK
> >
> > All error logs:
> > do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 n=
sec
> > do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
> > #412/1   struct_ops_multi_pages/multi_pages:FAIL
> > #412     struct_ops_multi_pages:FAIL
> > Summary: 9/25 PASSED, 3 SKIPPED, 1 FAILED
> > [root@fedora bpf]#
> > [root@fedora bpf]#
> > [root@fedora bpf]# ./test_progs -t struct_ops -a modify_return
> > #15/1    bad_struct_ops/invalid_prog_reuse:OK
> > #15/2    bad_struct_ops/unused_program:OK
> > #15      bad_struct_ops:OK
> > #204     modify_return:OK
> > #408/1   struct_ops_autocreate/cant_load_full_object:OK
> > #408/2   struct_ops_autocreate/can_load_partial_object:OK
> > #408/3   struct_ops_autocreate/autoload_and_shadow_vars:OK
> > #408/4   struct_ops_autocreate/optional_maps:OK
> > #408     struct_ops_autocreate:OK
> > #409/1   struct_ops_kptr_return/kptr_return:OK
> > #409/2   struct_ops_kptr_return/kptr_return_fail__wrong_type:OK
> > #409/3   struct_ops_kptr_return/kptr_return_fail__invalid_scalar:OK
> > #409/4   struct_ops_kptr_return/kptr_return_fail__nonzero_offset:OK
> > #409/5   struct_ops_kptr_return/kptr_return_fail__local_kptr:OK
> > #409     struct_ops_kptr_return:OK
> > #410/1   struct_ops_maybe_null/maybe_null:OK
> > #410/2   struct_ops_maybe_null/maybe_null_fail:OK
> > #410     struct_ops_maybe_null:OK
> > #411/1   struct_ops_module/struct_ops_load:OK
> > #411/2   struct_ops_module/struct_ops_not_zeroed:OK
> > #411/3   struct_ops_module/struct_ops_incompatible:OK
> > #411/4   struct_ops_module/struct_ops_null_out_cb:OK
> > #411/5   struct_ops_module/struct_ops_forgotten_cb:OK
> > #411/6   struct_ops_module/test_detach_link:OK
> > #411/7   struct_ops_module/unsupported_ops:OK
> > #411     struct_ops_module:OK
> > do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 n=
sec
> > do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
> > #412/1   struct_ops_multi_pages/multi_pages:FAIL
> > #412     struct_ops_multi_pages:FAIL
> > #413/1   struct_ops_no_cfi/load_bpf_test_no_cfi:OK
> > #413     struct_ops_no_cfi:OK
> > #414/1   struct_ops_private_stack/private_stack:SKIP
> > #414/2   struct_ops_private_stack/private_stack_fail:SKIP
> > #414/3   struct_ops_private_stack/private_stack_recur:SKIP
> > #414     struct_ops_private_stack:SKIP
> > #415/1   struct_ops_refcounted/refcounted:OK
> > #415/2   struct_ops_refcounted/refcounted_fail__ref_leak:OK
> > #415/3   struct_ops_refcounted/refcounted_fail__global_subprog:OK
> > #415/4   struct_ops_refcounted/refcounted_fail__tail_call:OK
> > #415     struct_ops_refcounted:OK
> >
> > All error logs:
> > do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 n=
sec
> > do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
> > #412/1   struct_ops_multi_pages/multi_pages:FAIL
> > #412     struct_ops_multi_pages:FAIL
> > Summary: 9/25 PASSED, 3 SKIPPED, 1 FAILED
>
> oops, missed the ns_bpf_qdisc, here it is.
>
> [root@fedora bpf]# ./test_progs -a ns_bpf_qdisc
> #213/1   ns_bpf_qdisc/fifo:OK
> #213/2   ns_bpf_qdisc/fq:OK
> #213/3   ns_bpf_qdisc/attach to mq:OK
> #213/4   ns_bpf_qdisc/attach to non root:OK
> #213/5   ns_bpf_qdisc/incompl_ops:OK
> #213     ns_bpf_qdisc:OK
> Summary: 1/5 PASSED, 0 SKIPPED, 0 FAILED

extra test just for the later reference:

[root@fedora bpf]# ./test_progs -a fentry_attach_btf_presence
#106     fentry_attach_btf_presence:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
[root@fedora bpf]#
[root@fedora bpf]#
[root@fedora bpf]# ./test_progs -a fentry_attach_stress
#107     fentry_attach_stress:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
[root@fedora bpf]#
[root@fedora bpf]#
[root@fedora bpf]# ./test_progs -a fentry_test
#109/1   fentry_test/fentry:OK
fentry_many_args:PASS:fentry_many_args_skel_load 0 nsec
libbpf: prog 'test2': failed to attach: -ENOTSUPP
libbpf: prog 'test2': failed to auto-attach: -ENOTSUPP
fentry_many_args:FAIL:fentry_many_args_attach unexpected error: -524 (errno=
 524)
#109/2   fentry_test/fentry_many_args:FAIL
#109     fentry_test:FAIL

All error logs:
fentry_many_args:PASS:fentry_many_args_skel_load 0 nsec
libbpf: prog 'test2': failed to attach: -ENOTSUPP
libbpf: prog 'test2': failed to auto-attach: -ENOTSUPP
fentry_many_args:FAIL:fentry_many_args_attach unexpected error: -524 (errno=
 524)
#109/2   fentry_test/fentry_many_args:FAIL
#109     fentry_test:FAIL
Summary: 0/1 PASSED, 0 SKIPPED, 1 FAILED
[root@fedora bpf]#
[root@fedora bpf]#
[root@fedora bpf]# ./test_progs -a fexit_bpf2bpf
#110/1   fexit_bpf2bpf/target_no_callees:OK
#110/2   fexit_bpf2bpf/target_yes_callees:OK
#110/3   fexit_bpf2bpf/func_replace:OK
#110/4   fexit_bpf2bpf/func_replace_verify:OK
#110/5   fexit_bpf2bpf/func_sockmap_update:OK
#110/6   fexit_bpf2bpf/func_replace_return_code:OK
#110/7   fexit_bpf2bpf/func_map_prog_compatibility:OK
#110/8   fexit_bpf2bpf/func_replace_unreliable:OK
#110/9   fexit_bpf2bpf/func_replace_multi:OK
#110/10  fexit_bpf2bpf/fmod_ret_freplace:OK
#110/11  fexit_bpf2bpf/func_replace_global_func:OK
#110/12  fexit_bpf2bpf/fentry_to_cgroup_bpf:OK
#110/13  fexit_bpf2bpf/func_replace_progmap:OK
#110     fexit_bpf2bpf:OK
Summary: 1/13 PASSED, 0 SKIPPED, 0 FAILED
[root@fedora bpf]#
[root@fedora bpf]#
[root@fedora bpf]# ./test_progs -a fexit_sleep
#111     fexit_sleep:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
[root@fedora bpf]#
[root@fedora bpf]#
[root@fedora bpf]# ./test_progs -a fexit_stress
#112     fexit_stress:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
[root@fedora bpf]#
[root@fedora bpf]#
[root@fedora bpf]# ./test_progs -a fexit_test
#113/1   fexit_test/fexit:OK
fexit_many_args:PASS:fexit_many_args_skel_load 0 nsec
libbpf: prog 'test2': failed to attach: -ENOTSUPP
libbpf: prog 'test2': failed to auto-attach: -ENOTSUPP
fexit_many_args:FAIL:fexit_many_args_attach unexpected error: -524 (errno 5=
24)
#113/2   fexit_test/fexit_many_args:FAIL
#113     fexit_test:FAIL

All error logs:
fexit_many_args:PASS:fexit_many_args_skel_load 0 nsec
libbpf: prog 'test2': failed to attach: -ENOTSUPP
libbpf: prog 'test2': failed to auto-attach: -ENOTSUPP
fexit_many_args:FAIL:fexit_many_args_attach unexpected error: -524 (errno 5=
24)
#113/2   fexit_test/fexit_many_args:FAIL
#113     fexit_test:FAIL
Summary: 0/1 PASSED, 0 SKIPPED, 1 FAILED
[root@fedora bpf]#

