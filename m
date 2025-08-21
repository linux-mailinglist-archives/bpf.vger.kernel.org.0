Return-Path: <bpf+bounces-66140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C515DB2EA8B
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 03:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88ED1C82CEE
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 01:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5B51F4281;
	Thu, 21 Aug 2025 01:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M95Al+Xu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44E01A9F93
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 01:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739237; cv=none; b=HOq47vdqv06ePI2Ojdv282+sEeze9cBSSw8/qqMxaZcvb3g9D2bu6PGB5s1Syna1tLp9C0kyTr5Ly8lCgrelITbCt3aMXB958aT/a/UpwD7BY11u4JP/L7eBgXmR923KaCY3UzoMecbqTa5FlHSrilo0GwlxO4N2t81SkpVrsHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739237; c=relaxed/simple;
	bh=OQOtns8VpjfB6BamHbSfDa22z5gODqM1kBfEVHVkTiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8H8g/pbGYEO+nLRQyc6sQTPt3JiFhoCW1VLwzdE9+yIGo9HRI6zpOH2jWkDp23ZXEUfmI10BK45SCZwOrQBXJePaEjm/j3oLG7qpKytJlnnzis5mi7TOz4bugie3d9aweaWWA3yUCGpA/tQDNqF461A2Ye5oSx+n6BTUhPlKUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M95Al+Xu; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-435de764e08so320204b6e.1
        for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 18:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755739235; x=1756344035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKO86G8bZiV5nYz1IZ3EKBDLLqKvZOVbqY3pnFOM1Z8=;
        b=M95Al+XugbIvnwc/Af32+q532K+dfhPBwumdeZdil2VVH4j8PTDNx1kgPQ/r1X8YL6
         5YqD4gaBKHweVY9RxiVxZn4iUNHwuxpb8dZeZc6KgGwWrxinx3YzV8a7xdcEXfMMO/aX
         fXzMbJx9epijR674SAXcsKhYQBvqw6iDy5cSHnS1zspXHeLrzAhtIBttfjrM9Np8ahG8
         d3w5udNlXsfEaTsKHbyVbqI6a8F77rzkTXK8HxudUzbcbsaIqT5hQOisRB5qEgNo6r/u
         rfdsSjoY4DXiyxVIXbOyUDs309v3/HGqG4dHyQOjcCCzrwByy++i0UFuBxyFBOuWEZnN
         SM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755739235; x=1756344035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKO86G8bZiV5nYz1IZ3EKBDLLqKvZOVbqY3pnFOM1Z8=;
        b=Whsp1HSO2+pyEOg5XOMDSDACJDabaTjdJI8qPen9k1p6tvGyXC3Aob9txGj/qGQsJG
         yQjx5MAv8DLIa12UpdWlCVdOAC67cwLkNQgcvb3jqz5Cqw+3oXSmR8TNIMgTTa6j1Ymj
         EqGc6aQVRIUzRZIxEM3jHTSLjrp52gVANy/NSqTRfbAtBfNOCQH06imFjXZobE30DSdP
         vWbhhF56w3N6ypW7SQTxDcUVctiCAr2sYG6J1ntP+SleL6Uz2QOH2ATAGtcEZjF8DQC1
         klXQx8K3ZnVtJU875zvds/PaHhzCgioMjwBLkMGRrrTPRIR+57+7bcS6yhSVytTxsZYX
         NoNg==
X-Forwarded-Encrypted: i=1; AJvYcCWpucM1kvZHeDePmysxK/j/mMTtFXK8Utq8XQYehX06Yp9+dY6XHrZRNHD/FzpQG5DbTrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfPd0ZjJCYVPMGjr4dWCyZ1P9tl1IO72pmMYkf4vLn6gP+cpei
	MbpF3hGJC9FHvACiJo53W4o7nrTeHKVf5yZXphpfZPZKaYvhVO3LV6ir+2xy9pbFeodadVTKFMs
	DRMXL27Qy+MqPOWd1ss8p8TWiEbiV5RQiAZg8DjMz1A==
X-Gm-Gg: ASbGncu6c4fuUvli/cPj3yhuQJFEbFYwXQwqfpLsKQvY+YqOkTzg9jEnGM2MRftBall
	EELABy7f+F1oDuJHt247sVGUlK25CpuEnm+UNbiQaR11ptFUyvw8sgioEexirOw3YJAuS9qYhU0
	mKh2ygC74tvV2gd5f0XBMdmNRsbynIYCz3HuCe7M3fqL/bHgTFvqUnwja8mBABXMQHtDPQilQZ5
	SdwmQ==
X-Google-Smtp-Source: AGHT+IFZbH2Y/vIzpJfiWCH/faWdN235d0spCvSJDpyG3JHQzkZKff50xE1ACggbQzTuuHzQSEfWBxHKWqQbP9/U8H0=
X-Received: by 2002:a05:6808:4f13:b0:41d:c778:d855 with SMTP id
 5614622812f47-4377d803a30mr316783b6e.37.1755739234638; Wed, 20 Aug 2025
 18:20:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820103956.394955-1-hengqi.chen@gmail.com> <CAAhV-H7F+Sqt-w9fwd4mU+UoqES_XEJyZMshF5E2TSkUjmHH-A@mail.gmail.com>
In-Reply-To: <CAAhV-H7F+Sqt-w9fwd4mU+UoqES_XEJyZMshF5E2TSkUjmHH-A@mail.gmail.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Thu, 21 Aug 2025 09:20:23 +0800
X-Gm-Features: Ac12FXxfevMhuXVifZcBWTdrPrLK0cyWjfhnSpxaET6_v4qBuSPOm_Gz33qMuyQ
Message-ID: <CAEyhmHTwcGD2Sj=1=pNzQ8CqZ_ayyN1wQStM7K+Dh=kfRHYLsg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: BPF: Sign extend struct ops return values properly
To: Huacai Chen <chenhuacai@kernel.org>
Cc: yangtiezhu@loongson.cn, jianghaoran@kylinos.cn, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	vincent.mc.li@gmail.com, bpf@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 11:37=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org=
> wrote:
>
> Hi, Hengqi,
>
> On Wed, Aug 20, 2025 at 8:06=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.co=
m> wrote:
> >
> > The ns_bpf_qdisc selftest triggers a kernel panic:
> >
> >     [ 2738.595309] CPU 0 Unable to handle kernel paging request at virt=
ual address 0000000000741d58, era =3D=3D 90000000851b5ac0, ra =3D=3D 900000=
00851b5aa4
> >     [ 2738.596716] Oops[#1]:
> >     [ 2738.596980] CPU: 0 UID: 0 PID: 449 Comm: test_progs Tainted: G  =
         OE       6.16.0+ #3 PREEMPT(full)
> >     [ 2738.597184] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> >     [ 2738.597265] Hardware name: QEMU QEMU Virtual Machine, BIOS unkno=
wn 2/2/2022
> >     [ 2738.597386] pc 90000000851b5ac0 ra 90000000851b5aa4 tp 900000010=
76b8000 sp 90000001076bb600
> >     [ 2738.597484] a0 0000000000741ce8 a1 0000000000000001 a2 900000010=
76bb5c0 a3 0000000000000008
> >     [ 2738.597577] a4 90000001004c4620 a5 9000000100741ce8 a6 000000000=
0000000 a7 0100000000000000
> >     [ 2738.597682] t0 0000000000000010 t1 0000000000000000 t2 900000010=
4d24d30 t3 0000000000000001
> >     [ 2738.597835] t4 4f2317da8a7e08c4 t5 fffffefffc002f00 t6 900000010=
04c4620 t7 ffffffffc61c5b3d
> >     [ 2738.597997] t8 0000000000000000 u0 0000000000000001 s9 000000000=
0000050 s0 90000001075bc800
> >     [ 2738.598097] s1 0000000000000040 s2 900000010597c400 s3 000000000=
0000008 s4 90000001075bc880
> >     [ 2738.598196] s5 90000001075bc8f0 s6 0000000000000000 s7 000000000=
0741ce8 s8 0000000000000000
> >     [ 2738.598313]    ra: 90000000851b5aa4 __qdisc_run+0xac/0x8d8
> >     [ 2738.598553]   ERA: 90000000851b5ac0 __qdisc_run+0xc8/0x8d8
> >     [ 2738.598629]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=3DC=
C -WE)
> >     [ 2738.598991]  PRMD: 00000004 (PPLV0 +PIE -PWE)
> >     [ 2738.599065]  EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
> >     [ 2738.599160]  ECFG: 00071c1d (LIE=3D0,2-4,10-12 VS=3D7)
> >     [ 2738.599278] ESTAT: 00010000 [PIL] (IS=3D ECode=3D1 EsubCode=3D0)
> >     [ 2738.599364]  BADV: 0000000000741d58
> >     [ 2738.599429]  PRID: 0014c010 (Loongson-64bit, Loongson-3A5000)
> >     [ 2738.599513] Modules linked in: bpf_testmod(OE) [last unloaded: b=
pf_testmod(OE)]
> >     [ 2738.599724] Process test_progs (pid: 449, threadinfo=3D000000009=
af02b3a, task=3D00000000e9ba4956)
> >     [ 2738.599916] Stack : 0000000000000000 90000001075bc8ac 9000000086=
9524a8 9000000100741ce8
> >     [ 2738.600065]         90000001075bc800 9000000100415300 9000000107=
5bc8ac 0000000000000000
> >     [ 2738.600170]         900000010597c400 900000008694a000 0000000000=
000000 9000000105b59000
> >     [ 2738.600278]         90000001075bc800 9000000100741ce8 0000000000=
000050 900000008513000c
> >     [ 2738.600381]         9000000086936000 0000000100094d4c fffffff400=
676208 0000000000000000
> >     [ 2738.600482]         9000000105b59000 900000008694a000 9000000086=
bf0dc0 9000000105b59000
> >     [ 2738.600585]         9000000086bf0d68 9000000085147010 9000000107=
5be788 0000000000000000
> >     [ 2738.600690]         9000000086bf0f98 0000000000000001 0000000000=
000010 9000000006015840
> >     [ 2738.600795]         0000000000000000 9000000086be6c40 0000000000=
000000 0000000000000000
> >     [ 2738.600901]         0000000000000000 4f2317da8a7e08c4 0000000000=
000101 4f2317da8a7e08c4
> >     [ 2738.601007]         ...
> >     [ 2738.601062] Call Trace:
> >     [ 2738.601135] [<90000000851b5ac0>] __qdisc_run+0xc8/0x8d8
> >     [ 2738.601396] [<9000000085130008>] __dev_queue_xmit+0x578/0x10f0
> >     [ 2738.601482] [<90000000853701c0>] ip6_finish_output2+0x2f0/0x950
> >     [ 2738.601568] [<9000000085374bc8>] ip6_finish_output+0x2b8/0x448
> >     [ 2738.601646] [<9000000085370b24>] ip6_xmit+0x304/0x858
> >     [ 2738.601711] [<90000000853c4438>] inet6_csk_xmit+0x100/0x170
> >     [ 2738.601784] [<90000000852b32f0>] __tcp_transmit_skb+0x490/0xdd0
> >     [ 2738.601863] [<90000000852b47fc>] tcp_connect+0xbcc/0x1168
> >     [ 2738.601934] [<90000000853b9088>] tcp_v6_connect+0x580/0x8a0
> >     [ 2738.602019] [<90000000852e7738>] __inet_stream_connect+0x170/0x4=
80
> >     [ 2738.602103] [<90000000852e7a98>] inet_stream_connect+0x50/0x88
> >     [ 2738.602175] [<90000000850f2814>] __sys_connect+0xe4/0x110
> >     [ 2738.602244] [<90000000850f2858>] sys_connect+0x18/0x28
> >     [ 2738.602320] [<9000000085520c94>] do_syscall+0x94/0x1a0
> >     [ 2738.602399] [<9000000083df1fb8>] handle_syscall+0xb8/0x158
> >     [ 2738.602502]
> >     [ 2738.602546] Code: 4001ad80  2400873f  2400832d <240073cc> 001137=
ff  001133ff  6407b41f  001503cc  0280041d
> >     [ 2738.602724]
> >     [ 2738.602916] ---[ end trace 0000000000000000 ]---
> It is enough to end up here, and please remove the timestamp.

OK.

>
> >     [ 2738.603210] Kernel panic - not syncing: Fatal exception in inter=
rupt
> >     [ 2738.603548] Kernel relocated by 0x83bb0000
> >     [ 2738.603622]  .text @ 0x9000000083db0000
> >     [ 2738.603699]  .data @ 0x9000000085690000
> >     [ 2738.603753]  .bss  @ 0x9000000087491e00
> >     [ 2738.603900] ---[ end Kernel panic - not syncing: Fatal exception=
 in interrupt ]---
> >
> > The bpf_fifo_dequeue prog returns a skb which is a pointer.
> > The pointer is treated as a 32bit value and sign extend to
> > 64bit in epilogue. This behavior is right for most bpf prog
> > types but wrong for struct ops which requires LoongArch ABI.
> >
> > So let's sign extend struct ops return values according to
> > the return value spec in function model.
> >
> > Fixes: 6abf17d690d8 ("LoongArch: BPF: Add struct ops support for trampo=
line")
> > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > ---
> >  arch/loongarch/net/bpf_jit.c | 47 ++++++++++++++++++++++++++++++------
> >  1 file changed, 40 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.=
c
> > index abfdb6bb5c38..4077565c9934 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -1361,7 +1361,8 @@ static void restore_args(struct jit_ctx *ctx, int=
 nargs, int args_off)
> >  }
> >
> >  static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link =
*l,
> > -                          int args_off, int retval_off, int run_ctx_of=
f, bool save_ret)
> > +                          const struct btf_func_model *m, int args_off=
,
> > +                          int retval_off, int run_ctx_off, bool save_r=
et)
> >  {
> >         int ret;
> >         u32 *branch;
> > @@ -1425,13 +1426,14 @@ static int invoke_bpf_prog(struct jit_ctx *ctx,=
 struct bpf_tramp_link *l,
> >  }
> >
> >  static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_l=
inks *tl,
> > -                              int args_off, int retval_off, int run_ct=
x_off, u32 **branches)
> > +                              const struct btf_func_model *m, int args=
_off,
> > +                              int retval_off, int run_ctx_off, u32 **b=
ranches)
> >  {
> >         int i;
> >
> >         emit_insn(ctx, std, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_FP, -retv=
al_off);
> >         for (i =3D 0; i < tl->nr_links; i++) {
> > -               invoke_bpf_prog(ctx, tl->links[i], args_off, retval_off=
, run_ctx_off, true);
> > +               invoke_bpf_prog(ctx, tl->links[i], m, args_off, retval_=
off, run_ctx_off, true);
> >                 emit_insn(ctx, ldd, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP,=
 -retval_off);
> >                 branches[i] =3D (u32 *)ctx->image + ctx->idx;
> >                 emit_insn(ctx, nop);
> > @@ -1448,6 +1450,30 @@ void arch_free_bpf_trampoline(void *image, unsig=
ned int size)
> >         bpf_prog_pack_free(image, size);
> >  }
> >
> > +/*
> > + * Sign-extend the register if necessary
> > + */
> > +static int sign_extend(struct jit_ctx *ctx, int r, u8 size)
> > +{
> > +       switch (size) {
> > +       case 1:
> > +               emit_insn(ctx, sllid, r, r, 56);
> > +               emit_insn(ctx, sraid, r, r, 56);
> > +               return 0;
> > +       case 2:
> > +               emit_insn(ctx, sllid, r, r, 48);
> > +               emit_insn(ctx, sraid, r, r, 48);
> > +               return 0;
> > +       case 4:
> > +               emit_insn(ctx, addiw, r, r, 0);
> > +               return 0;
> > +       case 8:
> > +               return 0;
> > +       default:
> > +               return -1;
> > +       }
> > +}
> Is it possible to rewrite like this?

I guess no. This is a precaution. There are return values like
int128_t or struct.
BTF_FMODEL_STRUCT_ARG is an example.

>
> +static void sign_extend(struct jit_ctx *ctx, int r, u8 size)
> +{
> + switch (size) {
> + case 1:
> + emit_insn(ctx, sllid, r, r, 56);
> + emit_insn(ctx, sraid, r, r, 56);
> + break;
> + case 2:
> + emit_insn(ctx, sllid, r, r, 48);
> + emit_insn(ctx, sraid, r, r, 48);
> + break;
> + case 4:
> + emit_insn(ctx, addiw, r, r, 0);
> + break;
> + case 8:
> + default:
> + break;
> + }
> +}
>
> Huacai
>
> > +
> >  static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct b=
pf_tramp_image *im,
> >                                          const struct btf_func_model *m=
, struct bpf_tramp_links *tlinks,
> >                                          void *func_addr, u32 flags)
> > @@ -1602,8 +1628,8 @@ static int __arch_prepare_bpf_trampoline(struct j=
it_ctx *ctx, struct bpf_tramp_i
> >         }
> >
> >         for (i =3D 0; i < fentry->nr_links; i++) {
> > -               ret =3D invoke_bpf_prog(ctx, fentry->links[i], args_off=
, retval_off,
> > -                                     run_ctx_off, flags & BPF_TRAMP_F_=
RET_FENTRY_RET);
> > +               ret =3D invoke_bpf_prog(ctx, fentry->links[i], m, args_=
off, retval_off,
> > +                             run_ctx_off, flags & BPF_TRAMP_F_RET_FENT=
RY_RET);
> >                 if (ret)
> >                         return ret;
> >         }
> > @@ -1612,7 +1638,7 @@ static int __arch_prepare_bpf_trampoline(struct j=
it_ctx *ctx, struct bpf_tramp_i
> >                 if (!branches)
> >                         return -ENOMEM;
> >
> > -               invoke_bpf_mod_ret(ctx, fmod_ret, args_off, retval_off,=
 run_ctx_off, branches);
> > +               invoke_bpf_mod_ret(ctx, fmod_ret, m, args_off, retval_o=
ff, run_ctx_off, branches);
> >         }
> >
> >         if (flags & BPF_TRAMP_F_CALL_ORIG) {
> > @@ -1638,7 +1664,8 @@ static int __arch_prepare_bpf_trampoline(struct j=
it_ctx *ctx, struct bpf_tramp_i
> >         }
> >
> >         for (i =3D 0; i < fexit->nr_links; i++) {
> > -               ret =3D invoke_bpf_prog(ctx, fexit->links[i], args_off,=
 retval_off, run_ctx_off, false);
> > +               ret =3D invoke_bpf_prog(ctx, fexit->links[i], m, args_o=
ff,
> > +                                     retval_off, run_ctx_off, false);
> >                 if (ret)
> >                         goto out;
> >         }
> > @@ -1657,6 +1684,12 @@ static int __arch_prepare_bpf_trampoline(struct =
jit_ctx *ctx, struct bpf_tramp_i
> >         if (save_ret) {
> >                 emit_insn(ctx, ldd, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP,=
 -retval_off);
> >                 emit_insn(ctx, ldd, regmap[BPF_REG_0], LOONGARCH_GPR_FP=
, -(retval_off - 8));
> > +               if (is_struct_ops) {
> > +                       move_reg(ctx, LOONGARCH_GPR_A0, regmap[BPF_REG_=
0]);
> > +                       ret =3D sign_extend(ctx, LOONGARCH_GPR_A0, m->r=
et_size);
> > +                       if (ret)
> > +                               goto out;
> > +               }
> >         }
> >
> >         emit_insn(ctx, ldd, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg_o=
ff);
> > --
> > 2.43.5
> >
> >

