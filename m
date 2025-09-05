Return-Path: <bpf+bounces-67523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330D3B44B39
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 03:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13FB73A77A1
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 01:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4CC1EB19B;
	Fri,  5 Sep 2025 01:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9O+86H1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3156D72625
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 01:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757035499; cv=none; b=XJ10IkoALj/BBwFspzCkvE5re5A6ck/fZ/Up+Eyb1Fpa2ki/VcXBiTshpe4e8Bh0XfLoE05+QoFIsk7EwEd5gVbkTZxSYw3AbQguL7IkD/5GJ6buhFCrrtj3EM++uvuZaZTiPqSC0YmvzQ42dblNXJxkJjVc0jpkaOkMDuMPWPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757035499; c=relaxed/simple;
	bh=tyOp0Y/bEvDcwTRdQil+jK/vgslY1ISt7Xk9hPsylnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfu2IXKfvGI905D97PXR/hIr/VTqXczwaG17jt7UG09wuQcFA+ZgdgauAq+nAT0CwRuGipB8PEbSLgT0lUH6sWIXeqI76oXHyJR25esKuxXOfEAKD1BdyeIro7fpkanp+Y5H+1vDVRK8SK77yZfwko6iASv2nmcCLj3MmQXYjik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9O+86H1; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-30cce5be7d0so892785fac.0
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 18:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757035497; x=1757640297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbDS5g4NNZgHnjVgnigWbyZSWjs/7JYU6RpJNLXiAHI=;
        b=O9O+86H1aqfXhW/KJ8LFOeNYxQfmxI5QMxndVjtXUOaBDAvGt7xgk0/YB41aMZZ/1Y
         ycGzj+hVzLCSoo81amFK4gDPLaz3u6eSZI27fhWSGr6VEW24p/J/CaU7uZ+LW51GUnUU
         aSAcu/tDnAi0eTVo0cVJVjUMi8MFqs0kXetb99sJ/M2xa96f8B2gsyWz0uYURSYvzcB+
         tyYPqN4tnJYUq7wpvS77/vXrvwtr5nO+AdytI1CiBh586Ntrw+E2g53arqEfM/hXK0GQ
         V9uGqN4dwGPa0BOYmf/HiObTpUWPyyiueqki2UYmvOxhjXsEyKN7LGRjIVgkSUeVFvSb
         nHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757035497; x=1757640297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbDS5g4NNZgHnjVgnigWbyZSWjs/7JYU6RpJNLXiAHI=;
        b=QeSjASzGqDpvOlCqp33QtVivxzFPf6q2HjPH9g2B13hLMPUlxKX7rdG7hrgVLGE91U
         txTs4NvF0Mq1n79otxTdg47EJb7dN5Ta3kZaEhxfhqcwTWkrYiFP9pEJ52jKgro3MkNX
         b/OCvyxd+aJPWrtvspaoHD2m3FG0vbsfy4uIQ+wGkBfOdJh9BWHZEtbm54qCDU+J+Zjs
         zjZEx8oj0rQX9dDnMpTiTp3GxJrJ1Ej1ht1ZRZ1c6ErZit8Tg6kxwWHAmD/WAVBctaOU
         kRzoo4HxGf1jHr9ZZD1CeY1wvAkRArhEP9KOKOk6NF5TVOQqpyXjM1Sack9SHOKj9qeb
         /Rig==
X-Forwarded-Encrypted: i=1; AJvYcCVEonvn6yGDci0XmXTOhisyd5j2ige/NDzL4WC3+kPQ+m4J3FDz0ARay+ddzlmU6vWqwEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhPeS5/1CmujS43WRdRc+9KygT5BY2Nf3BEWdyT1FEq0oCeGQ1
	9VFNRMo1AMYq3IsaiVeTuBO/gv/MXCCJ3XkV97lWIuUVD0vU+Y0nYy1xwEqkCZMnv0Y+xNKteL4
	KZKQqkxe1BzxKKOca88Q0A6mhxjrsVBM=
X-Gm-Gg: ASbGncsp8bULm2C2aoehSA1fuBI/w2aFrNlvSFwLEaydkhfi5n4L97PrwKtpzmFOe3H
	M3ZkMGYPxgvM+Rmcf8DcEY/rHevZ9Wre9nuJ8DHD0Jp8WrIGVoUdumHPm/YRXE1D/MkEwfOkRr/
	34xGy87uXf6asDIuTNAQtJtR6Q2YHrBnQgVQxJccQ11/VVxfiTod7GAlUEHST5vj3ziMa9DPK1B
	WbSe/4=
X-Google-Smtp-Source: AGHT+IGpdsF17M8QNS7qTWsunMYjK1ObUyqjmf0rFP6ZIA7r5TBQD60ucmwAjvqjx6QeudgkKei5Ri0ehUc77CdDa3c=
X-Received: by 2002:a05:6871:b0e:b0:31d:6e43:8d33 with SMTP id
 586e51a60fabf-31d6e443596mr4286495fac.4.1757035497007; Thu, 04 Sep 2025
 18:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904103806.18937-1-hengqi.chen@gmail.com> <5829abcf-f1b9-4fb0-8811-b6098fdd8a29@gmail.com>
In-Reply-To: <5829abcf-f1b9-4fb0-8811-b6098fdd8a29@gmail.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Fri, 5 Sep 2025 09:24:46 +0800
X-Gm-Features: Ac12FXxtkjmX_aupc9uUOjwuZVl71OrAgC_yfCVyk0kI-YxPN56CLjpyDN13KnA
Message-ID: <CAEyhmHQebTd1+XojM3M9K7VYESQYLKsmkH4DbQfERFBP_E3WLA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] riscv, bpf: Sign extend struct ops return
 values properly
To: Amery Hung <ameryhung@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, bjorn@kernel.org, pulehui@huawei.com, 
	puranjay@kernel.org, bpf@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 6:42=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wro=
te:
>
>
>
> On 9/4/25 3:38 AM, Hengqi Chen wrote:
> > The ns_bpf_qdisc selftest triggers a kernel panic:
> >
> >      Unable to handle kernel paging request at virtual address ffffffff=
a38dbf58
> >      Current test_progs pgtable: 4K pagesize, 57-bit VAs, pgdp=3D0x0000=
0001109cc000
> >      [ffffffffa38dbf58] pgd=3D000000011fffd801, p4d=3D000000011fffd401,=
 pud=3D000000011fffd001, pmd=3D0000000000000000
> >      Oops [#1]
> >      Modules linked in: bpf_testmod(OE) xt_conntrack nls_iso8859_1 dm_m=
od drm drm_panel_orientation_quirks configfs backlight btrfs blake2b_generi=
c xor lzo_compress zlib_deflate raid6_pq efivarfs [last unloaded: bpf_testm=
od(OE)]
> >      CPU: 1 UID: 0 PID: 23584 Comm: test_progs Tainted: G        W  OE =
      6.17.0-rc1-g2465bb83e0b4 #1 NONE
> >      Tainted: [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> >      Hardware name: Unknown Unknown Product/Unknown Product, BIOS 2024.=
01+dfsg-1ubuntu5.1 01/01/2024
> >      epc : __qdisc_run+0x82/0x6f0
> >       ra : __qdisc_run+0x6e/0x6f0
> >      epc : ffffffff80bd5c7a ra : ffffffff80bd5c66 sp : ff2000000eecb550
> >       gp : ffffffff82472098 tp : ff60000096895940 t0 : ffffffff8001f180
> >       t1 : ffffffff801e1664 t2 : 0000000000000000 s0 : ff2000000eecb5d0
> >       s1 : ff60000093a6a600 a0 : ffffffffa38dbee8 a1 : 0000000000000001
> >       a2 : ff2000000eecb510 a3 : 0000000000000001 a4 : 0000000000000000
> >       a5 : 0000000000000010 a6 : 0000000000000000 a7 : 0000000000735049
> >       s2 : ffffffffa38dbee8 s3 : 0000000000000040 s4 : ff6000008bcda000
> >       s5 : 0000000000000008 s6 : ff60000093a6a680 s7 : ff60000093a6a6f0
> >       s8 : ff60000093a6a6ac s9 : ff60000093140000 s10: 0000000000000000
> >       s11: ff2000000eecb9d0 t3 : 0000000000000000 t4 : 0000000000ff0000
> >       t5 : 0000000000000000 t6 : ff60000093a6a8b6
> >      status: 0000000200000120 badaddr: ffffffffa38dbf58 cause: 00000000=
0000000d
> >      [<ffffffff80bd5c7a>] __qdisc_run+0x82/0x6f0
> >      [<ffffffff80b6fe58>] __dev_queue_xmit+0x4c0/0x1128
> >      [<ffffffff80b80ae0>] neigh_resolve_output+0xd0/0x170
> >      [<ffffffff80d2daf6>] ip6_finish_output2+0x226/0x6c8
> >      [<ffffffff80d31254>] ip6_finish_output+0x10c/0x2a0
> >      [<ffffffff80d31446>] ip6_output+0x5e/0x178
> >      [<ffffffff80d2e232>] ip6_xmit+0x29a/0x608
> >      [<ffffffff80d6f4c6>] inet6_csk_xmit+0xe6/0x140
> >      [<ffffffff80c985e4>] __tcp_transmit_skb+0x45c/0xaa8
> >      [<ffffffff80c995fe>] tcp_connect+0x9ce/0xd10
> >      [<ffffffff80d66524>] tcp_v6_connect+0x4ac/0x5e8
> >      [<ffffffff80cc19b8>] __inet_stream_connect+0xd8/0x318
> >      [<ffffffff80cc1c36>] inet_stream_connect+0x3e/0x68
> >      [<ffffffff80b42b20>] __sys_connect_file+0x50/0x88
> >      [<ffffffff80b42bee>] __sys_connect+0x96/0xc8
> >      [<ffffffff80b42c40>] __riscv_sys_connect+0x20/0x30
> >      [<ffffffff80e5bcae>] do_trap_ecall_u+0x256/0x378
> >      [<ffffffff80e69af2>] handle_exception+0x14a/0x156
> >      Code: 892a 0363 1205 489c 8bc1 c7e5 2d03 084a 2703 080a (2783) 070=
9
> >      ---[ end trace 0000000000000000 ]---
> >
> > The bpf_fifo_dequeue prog returns a skb which is a pointer.
> > The pointer is treated as a 32bit value and sign extend to
> > 64bit in epilogue. This behavior is right for most bpf prog
> > types but wrong for struct ops which requires RISC-V ABI.
> >
> > So let's sign extend struct ops return values according to
> > the function model and RISC-V ABI([0]).
> >
> >    [0]: https://riscv.org/wp-content/uploads/2024/12/riscv-calling.pdf
> >
> > Fixes: 25ad10658dc1 ("riscv, bpf: Adapt bpf trampoline to optimized ris=
cv ftrace framework")
> > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > ---
> >   arch/riscv/net/bpf_jit_comp64.c | 38 ++++++++++++++++++++++++++++++++=
-
> >   1 file changed, 37 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_c=
omp64.c
> > index 549c3063c7f1..c7ae4d0a8361 100644
> > --- a/arch/riscv/net/bpf_jit_comp64.c
> > +++ b/arch/riscv/net/bpf_jit_comp64.c
> > @@ -954,6 +954,35 @@ static int invoke_bpf_prog(struct bpf_tramp_link *=
l, int args_off, int retval_of
> >       return ret;
> >   }
> >
> > +/*
> > + * Sign-extend the register if necessary
> > + */
> > +static int sign_extend(int rd, int rs, u8 size, u8 flags, struct rv_ji=
t_context *ctx)
> > +{
> > +     if (!(flags & BTF_FMODEL_SIGNED_ARG) && (size =3D=3D 1 || size =
=3D=3D 2))
> > +             return 0;
> > +
> > +     switch (size) {
> > +     case 1:
> > +             emit_sextb(rd, rs, ctx);
> > +             break;
> > +     case 2:
> > +             emit_sexth(rd, rs, ctx);
> > +             break;
> > +     case 4:
> > +             emit_sextw(rd, rs, ctx);
> > +             break;
> > +     case 8:
> > +             emit_mv(rd, rs, ctx);
> > +             break;
> > +     default:
> > +             pr_err("bpf-jit: invalid size %d for sign_extend\n", size=
);
> > +             return -EINVAL;
>
> Will this accidentally rejects struct_ops functions that return void?
>

No, see https://elixir.bootlin.com/linux/v6.16.4/source/kernel/bpf/bpf_stru=
ct_ops.c#L601-L602

> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >   static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
> >                                        const struct btf_func_model *m,
> >                                        struct bpf_tramp_links *tlinks,
> > @@ -1175,8 +1204,15 @@ static int __arch_prepare_bpf_trampoline(struct =
bpf_tramp_image *im,
> >               restore_args(min_t(int, nr_arg_slots, RV_MAX_REG_ARGS), a=
rgs_off, ctx);
> >
> >       if (save_ret) {
> > -             emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
> >               emit_ld(regmap[BPF_REG_0], -(retval_off - 8), RV_REG_FP, =
ctx);
> > +             if (is_struct_ops) {
> > +                     ret =3D sign_extend(RV_REG_A0, regmap[BPF_REG_0],
> > +                                       m->ret_size, m->ret_flags, ctx)=
;
> > +                     if (ret)
> > +                             goto out;
> > +             } else {
> > +                     emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
> > +             }
> >       }
> >
> >       emit_ld(RV_REG_S1, -sreg_off, RV_REG_FP, ctx);
>

