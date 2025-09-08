Return-Path: <bpf+bounces-67805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60192B49CDA
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 00:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 190913B94C0
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 22:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D155F211A14;
	Mon,  8 Sep 2025 22:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXV1eVSV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B788620C001
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 22:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757370878; cv=none; b=b3+6uvDW+IQ2IrAUnhxpNWPWmG1uVNAyec5a+UwNpzxX03i5J6oMLGCh1iCVixFxF4uaGfPKSKQc5ToBeSABmUO+4Yotgt3WGy89VuZfsj83GmzdwAlJNEb+5EtRndh6nazCx5mNY/TpU+UhkTrgC9D8zxzdTh6rIGVO9+GN6eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757370878; c=relaxed/simple;
	bh=Dwg3DLnHMCV8GGsNwrHRL2KaNMiND3kaSrV2dA5axRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jbJzYHEuEjgwPNNNVDiW+vwWa34FRNlEBOay8c5XS30J7IBRwTgswg4MkqweMDfKFI9DthFyvKRXMohYXHDLCM2tB960ILT5mt2h4L0MVVFyBYe3B0xY93QyLKMQwBWnViuRgs1Gme/JxJ37LaXaZI15r+UbemBxuaN7wZMiutw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXV1eVSV; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d60504788so41379277b3.2
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 15:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757370876; x=1757975676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjt7DDjX972By2stpkZpYIsKdYZGTii1n0cqsdLOGiE=;
        b=FXV1eVSV07xxz/kUAwZ4OcpjlMWMOtuIgewdfaJVhk1aYEqeI65whB67BCQttb9b5l
         RdB/E3zv30GwKNsOQM9wkOBu/frUjXHN7WnJAiFQ3q3AF2cnfXCSv768lVpI/mwxK4dU
         KwgQTjbQbR0wAWPpuVARLvI1lx1s43O6hp7Pn7kwVU7sTsfQRi75/0xpqC24TreHdt12
         ZjHemG0M7iK0YgOKtUKhSEisU2Nl13BlGMDF3GeS/u56ij1s9e0s3ZP6NuWCk4uL0xnq
         VV+SQoj/vzuPtNdQrcDsnDu6/B3snMzrFqMNYk6OO7MQuZ6kZATmpmkxl0By8IBmb/Cp
         M7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757370876; x=1757975676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjt7DDjX972By2stpkZpYIsKdYZGTii1n0cqsdLOGiE=;
        b=oUfuskUJgQR8R7aNj5ywcm7lPnQffFP63Cf7X5Ebsc8kIN/+mDgfnVLZA/o5IJju/0
         //nUxHwi2OnniPfIiiB+ztrV5xYnSpB6V3OjKQjIofjUwBfmeVLcWQuLMFL1tPUdjS08
         xQ0MYfCe5VJgLqoTtzmnnKWTLFtN10KI+ydZg3bsYaS5VUfzKP6tEMNouNm81teHswA6
         /ijLl62VytP+uDnnajxPPoCBQdvDt40jywlmBjVZu9gu8dym8TbxxJAyKcCqmO4wN5Ml
         U5im+jiqcP/w5bDar0mWo4h7ZARdgAzB1ONHx41rvH3f6i1dNu9aiibN9jdWZmGwp+tn
         5u5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTvln8VgTiH414cVqyRsnJRE0EPmhlFwu/qtXoeopJstD9Z9zdhNm8EaNwilXcZEmZbZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhokk8Og8BerulozdK+0eOjGIw8nW8Nv5AFbg3p/uD+Ka9+6kT
	57+Q6EdqMfMIxaQZY+L2Am6L0/xymmmAoF9ZK1T7hNk77qSy0xjvJ4UqLpVQaMYqWJmL9y5x28+
	CP11/Z2UinLAPVaPDwiw52HsAbbatbpw=
X-Gm-Gg: ASbGncv8uY+JM9Sp5HaT0/zZ+sUaC3z8UEFoUtB0UE/PQ2uv5GRCKU8oOJ64oFB9iXj
	UwBDHFrR4gB7JT8cX34MLFKALj7U5PvcLjk8C2V5Jabb/WBkKTJ4gTXca8oBfrp5AgLIphpZoMN
	T45DPRLlMtmzF9Hxzd5Cc63CB0mhxemjYMOkPubcya0ZSnAu01BIFQYa1hAQZQ1noAWDYT0dv2f
	0prm7gP
X-Google-Smtp-Source: AGHT+IGoZcTWd/GPs5VbkaDpyGGNUiEMOa5TrD1+NjbPsAN4xpn0v0Y0Eop+NY/MlgWZ+YudhgKbFng93dfHVhqkvRQ=
X-Received: by 2002:a05:690c:62c1:b0:726:76f0:4b89 with SMTP id
 00721157ae682-727f505434fmr88421927b3.22.1757370875500; Mon, 08 Sep 2025
 15:34:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904103806.18937-1-hengqi.chen@gmail.com> <5829abcf-f1b9-4fb0-8811-b6098fdd8a29@gmail.com>
 <CAEyhmHQebTd1+XojM3M9K7VYESQYLKsmkH4DbQfERFBP_E3WLA@mail.gmail.com>
In-Reply-To: <CAEyhmHQebTd1+XojM3M9K7VYESQYLKsmkH4DbQfERFBP_E3WLA@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 8 Sep 2025 15:34:24 -0700
X-Gm-Features: Ac12FXyYIw_KCLdrWjdZaTuagcQZ9L9HxDRNeratvFaEeepMp1sMwsmGXhGX5Bo
Message-ID: <CAMB2axMZ6M8X1PABsQ9k=K6uQt0jSXo_21pRDmcsQkDFg4QeGg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] riscv, bpf: Sign extend struct ops return
 values properly
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, bjorn@kernel.org, pulehui@huawei.com, 
	puranjay@kernel.org, bpf@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 6:24=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com> =
wrote:
>
> On Fri, Sep 5, 2025 at 6:42=E2=80=AFAM Amery Hung <ameryhung@gmail.com> w=
rote:
> >
> >
> >
> > On 9/4/25 3:38 AM, Hengqi Chen wrote:
> > > The ns_bpf_qdisc selftest triggers a kernel panic:
> > >
> > >      Unable to handle kernel paging request at virtual address ffffff=
ffa38dbf58
> > >      Current test_progs pgtable: 4K pagesize, 57-bit VAs, pgdp=3D0x00=
000001109cc000
> > >      [ffffffffa38dbf58] pgd=3D000000011fffd801, p4d=3D000000011fffd40=
1, pud=3D000000011fffd001, pmd=3D0000000000000000
> > >      Oops [#1]
> > >      Modules linked in: bpf_testmod(OE) xt_conntrack nls_iso8859_1 dm=
_mod drm drm_panel_orientation_quirks configfs backlight btrfs blake2b_gene=
ric xor lzo_compress zlib_deflate raid6_pq efivarfs [last unloaded: bpf_tes=
tmod(OE)]
> > >      CPU: 1 UID: 0 PID: 23584 Comm: test_progs Tainted: G        W  O=
E       6.17.0-rc1-g2465bb83e0b4 #1 NONE
> > >      Tainted: [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> > >      Hardware name: Unknown Unknown Product/Unknown Product, BIOS 202=
4.01+dfsg-1ubuntu5.1 01/01/2024
> > >      epc : __qdisc_run+0x82/0x6f0
> > >       ra : __qdisc_run+0x6e/0x6f0
> > >      epc : ffffffff80bd5c7a ra : ffffffff80bd5c66 sp : ff2000000eecb5=
50
> > >       gp : ffffffff82472098 tp : ff60000096895940 t0 : ffffffff8001f1=
80
> > >       t1 : ffffffff801e1664 t2 : 0000000000000000 s0 : ff2000000eecb5=
d0
> > >       s1 : ff60000093a6a600 a0 : ffffffffa38dbee8 a1 : 00000000000000=
01
> > >       a2 : ff2000000eecb510 a3 : 0000000000000001 a4 : 00000000000000=
00
> > >       a5 : 0000000000000010 a6 : 0000000000000000 a7 : 00000000007350=
49
> > >       s2 : ffffffffa38dbee8 s3 : 0000000000000040 s4 : ff6000008bcda0=
00
> > >       s5 : 0000000000000008 s6 : ff60000093a6a680 s7 : ff60000093a6a6=
f0
> > >       s8 : ff60000093a6a6ac s9 : ff60000093140000 s10: 00000000000000=
00
> > >       s11: ff2000000eecb9d0 t3 : 0000000000000000 t4 : 0000000000ff00=
00
> > >       t5 : 0000000000000000 t6 : ff60000093a6a8b6
> > >      status: 0000000200000120 badaddr: ffffffffa38dbf58 cause: 000000=
000000000d
> > >      [<ffffffff80bd5c7a>] __qdisc_run+0x82/0x6f0
> > >      [<ffffffff80b6fe58>] __dev_queue_xmit+0x4c0/0x1128
> > >      [<ffffffff80b80ae0>] neigh_resolve_output+0xd0/0x170
> > >      [<ffffffff80d2daf6>] ip6_finish_output2+0x226/0x6c8
> > >      [<ffffffff80d31254>] ip6_finish_output+0x10c/0x2a0
> > >      [<ffffffff80d31446>] ip6_output+0x5e/0x178
> > >      [<ffffffff80d2e232>] ip6_xmit+0x29a/0x608
> > >      [<ffffffff80d6f4c6>] inet6_csk_xmit+0xe6/0x140
> > >      [<ffffffff80c985e4>] __tcp_transmit_skb+0x45c/0xaa8
> > >      [<ffffffff80c995fe>] tcp_connect+0x9ce/0xd10
> > >      [<ffffffff80d66524>] tcp_v6_connect+0x4ac/0x5e8
> > >      [<ffffffff80cc19b8>] __inet_stream_connect+0xd8/0x318
> > >      [<ffffffff80cc1c36>] inet_stream_connect+0x3e/0x68
> > >      [<ffffffff80b42b20>] __sys_connect_file+0x50/0x88
> > >      [<ffffffff80b42bee>] __sys_connect+0x96/0xc8
> > >      [<ffffffff80b42c40>] __riscv_sys_connect+0x20/0x30
> > >      [<ffffffff80e5bcae>] do_trap_ecall_u+0x256/0x378
> > >      [<ffffffff80e69af2>] handle_exception+0x14a/0x156
> > >      Code: 892a 0363 1205 489c 8bc1 c7e5 2d03 084a 2703 080a (2783) 0=
709
> > >      ---[ end trace 0000000000000000 ]---
> > >
> > > The bpf_fifo_dequeue prog returns a skb which is a pointer.
> > > The pointer is treated as a 32bit value and sign extend to
> > > 64bit in epilogue. This behavior is right for most bpf prog
> > > types but wrong for struct ops which requires RISC-V ABI.
> > >
> > > So let's sign extend struct ops return values according to
> > > the function model and RISC-V ABI([0]).
> > >
> > >    [0]: https://riscv.org/wp-content/uploads/2024/12/riscv-calling.pd=
f
> > >
> > > Fixes: 25ad10658dc1 ("riscv, bpf: Adapt bpf trampoline to optimized r=
iscv ftrace framework")
> > > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > > ---
> > >   arch/riscv/net/bpf_jit_comp64.c | 38 ++++++++++++++++++++++++++++++=
++-
> > >   1 file changed, 37 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit=
_comp64.c
> > > index 549c3063c7f1..c7ae4d0a8361 100644
> > > --- a/arch/riscv/net/bpf_jit_comp64.c
> > > +++ b/arch/riscv/net/bpf_jit_comp64.c
> > > @@ -954,6 +954,35 @@ static int invoke_bpf_prog(struct bpf_tramp_link=
 *l, int args_off, int retval_of
> > >       return ret;
> > >   }
> > >
> > > +/*
> > > + * Sign-extend the register if necessary
> > > + */
> > > +static int sign_extend(int rd, int rs, u8 size, u8 flags, struct rv_=
jit_context *ctx)
> > > +{
> > > +     if (!(flags & BTF_FMODEL_SIGNED_ARG) && (size =3D=3D 1 || size =
=3D=3D 2))
> > > +             return 0;
> > > +
> > > +     switch (size) {
> > > +     case 1:
> > > +             emit_sextb(rd, rs, ctx);
> > > +             break;
> > > +     case 2:
> > > +             emit_sexth(rd, rs, ctx);
> > > +             break;
> > > +     case 4:
> > > +             emit_sextw(rd, rs, ctx);
> > > +             break;
> > > +     case 8:
> > > +             emit_mv(rd, rs, ctx);
> > > +             break;
> > > +     default:
> > > +             pr_err("bpf-jit: invalid size %d for sign_extend\n", si=
ze);
> > > +             return -EINVAL;
> >
> > Will this accidentally rejects struct_ops functions that return void?
> >
>
> No, see https://elixir.bootlin.com/linux/v6.16.4/source/kernel/bpf/bpf_st=
ruct_ops.c#L601-L602

Ah, I see. Thanks for pointing it out.

>
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >   static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im=
,
> > >                                        const struct btf_func_model *m=
,
> > >                                        struct bpf_tramp_links *tlinks=
,
> > > @@ -1175,8 +1204,15 @@ static int __arch_prepare_bpf_trampoline(struc=
t bpf_tramp_image *im,
> > >               restore_args(min_t(int, nr_arg_slots, RV_MAX_REG_ARGS),=
 args_off, ctx);
> > >
> > >       if (save_ret) {
> > > -             emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
> > >               emit_ld(regmap[BPF_REG_0], -(retval_off - 8), RV_REG_FP=
, ctx);
> > > +             if (is_struct_ops) {
> > > +                     ret =3D sign_extend(RV_REG_A0, regmap[BPF_REG_0=
],
> > > +                                       m->ret_size, m->ret_flags, ct=
x);
> > > +                     if (ret)
> > > +                             goto out;
> > > +             } else {
> > > +                     emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx)=
;
> > > +             }
> > >       }
> > >
> > >       emit_ld(RV_REG_S1, -sreg_off, RV_REG_FP, ctx);
> >

