Return-Path: <bpf+bounces-66816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3672BB39AEB
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 13:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33FB41C24348
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 11:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CC530DD1E;
	Thu, 28 Aug 2025 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLZi5Gtt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC2A30CDB8
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 11:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756378997; cv=none; b=ADp3G+Eoec7tFu9k+g3oPYtREeF4q5vcjPqYxhvSXSVZq+GsO8wiNCEF8unm6tKm2ITu5yaTrjhHrZb1B3r6cWewz3kbyyQKMDelLhYabNCrYW0StoiSsEEMLe0pOjm8KDYZHylnphP9wXxynUIZWdYKyQhyXnjdi29xfCqAFb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756378997; c=relaxed/simple;
	bh=wu0eGOtLQwcAdT6QuDpvgBOribHmNMfpR8QQ8q0r2N4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9AjdGz4OuSjMfhoLenMgfbQrQdqjLdmaWM8nNDX062PzLB3k1JeXwmfkLHm7hNm1GvoYHN1gL91lgBSF08YpzTtLIZAuP+QIdNZtDhC11Dy8oI2RO3YrQvzJqKvD+BSNzapc64nf9pbUEHlFAdJ/tT52ptuHRVBW3+RFYA9UGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLZi5Gtt; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-61bf9ef4cc0so534397eaf.0
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 04:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756378995; x=1756983795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrM9QpUTzn4CSaH2DsTf4uTpIcPswtHld3abJL0GRLs=;
        b=NLZi5GttXGdmqYX9Ugle7bzsJ9u16tkztZSLzSqlhsy6EGBdB/LLyk1rRnD5pOk+xa
         FU8PjRsdKdvLefyJA4H8/oef15iCaOTd8OPCThYH9/Y/8zBSrBLIygRGPLDPoPbB9PI1
         7C8H9A3N4F00UsTySgHXRD+Jm1/+GPggp8STbUuH074Q/Y0DOb/nPHfiTMgx1+c8hQGY
         LH6RLiMmu74rjhimehueGzLrPecQTNwcxhtnnHwngf0r1mPmEqKfrC6jbGz0qOfiO1hr
         H+BWTJFNl1hr+0pxSehLw4A6ZtDj15ixRcP5eCAttZeVFzKDk0iQSCXjAVi+/z/khzCd
         4DIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756378995; x=1756983795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrM9QpUTzn4CSaH2DsTf4uTpIcPswtHld3abJL0GRLs=;
        b=Sqw1+ugQBGRFfeyohRPNzsUZ4wQXZs3PL8WN7Deko0reZYp0OglgKAAXkhq0E73Yck
         9Rptx/S50bXmmqU1pNLOwtVYVkFydDHGoxuB2BMjP3yhabsyPNK3ozcsuueKbcSZCIak
         wEXkxEqmoJCFxnXImPnRp1UApPHN78g8b101af81gHUwzepBRq6eEq7LHObOuD3VIo8a
         1aVRcQ8ePRpwQy48ClixB24raqMJqWd3c6CWhlNXcmggQGzoZmjILtBe+0uEZAZ3rzHe
         nqMSX1FDZ/BeBv8epRddFHUMv6XRZYD/ncXo6Kw0rnQ6bYUFE7niLmId9dvZvk71r7M1
         M7Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWD7t+o4nVXu28N7OJdn1f0k+n8bc628OitnJRAui9ijLdFVo8BCZHN3VptkSidBM/ktvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1calZfElnqkQ7o39JazRL2u6bk1EaGtzZNEeduNWjue/mEAP+
	Jus6cCxBA9J083hoHPE4uariZEl1TcYAERS95Xznia2wJmpJS78RfsPLTweejXuWfiQaJUsAeUS
	HFN4oHmh/kRfLv/iIfEkFne/vQ6405HndYvDkmQE=
X-Gm-Gg: ASbGnctnLzjp9TvWxfco6nhFKYZ8eAcv7picZLeryDdAz0QGSOLBUE2dMjezlWOgECo
	4rhvbWUWSNta89W1fct1sJPJ/GcRk62I0zxizBSccygw6+cEbU0EkO8q0iqE1YIxC1F6I6xVgpY
	XFV4WyFFkqLzcIb8qx7pKjVjPnJvFirjlhpNylidYP/5g36fG31IG6s1z2sZP0JkRgqbgAlKto0
	9TlAl+pTBADAPvI0778AV5rbKYM
X-Google-Smtp-Source: AGHT+IG3/EGbs6E+rFxF8ODPTUAD0rSIfCc8kzDOdTk6YkRf3D4jJklCPcrVpNUx6a0sWOYzbXwvDbV9Lbo654DxDaY=
X-Received: by 2002:a05:6808:190b:b0:437:e3d2:cb8c with SMTP id
 5614622812f47-437e3d2d28fmr120663b6e.4.1756378995145; Thu, 28 Aug 2025
 04:03:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827094733.426839-1-hengqi.chen@gmail.com>
 <20250827094733.426839-4-hengqi.chen@gmail.com> <CAAhV-H5sBUjPhuPgpsMV-ywiKJX2-C3D1Re60FGiD9b207NddQ@mail.gmail.com>
In-Reply-To: <CAAhV-H5sBUjPhuPgpsMV-ywiKJX2-C3D1Re60FGiD9b207NddQ@mail.gmail.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Thu, 28 Aug 2025 19:03:04 +0800
X-Gm-Features: Ac12FXzQ_-Qw0m3pMGn3le3oJZOJlQ50pt_UmAwjftgORUwHrsH6RRf62KaKfhY
Message-ID: <CAEyhmHRo1UvSTf6RRKigBJcA1wWkffF6OojJncxud6Ff=A-WsA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] LoongArch: BPF: No support of struct argument in
 trampoline programs
To: Huacai Chen <chenhuacai@kernel.org>
Cc: yangtiezhu@loongson.cn, jianghaoran@kylinos.cn, duanchenghao@kylinos.cn, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	vincent.mc.li@gmail.com, bpf@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 5:26=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> On Wed, Aug 27, 2025 at 7:19=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.co=
m> wrote:
> >
> > The current implementation does not support struct argument.
> > This cause a oops when running bpf selftest:
> >
> >     $ ./test_progs -a tracing_struct
> >     CPU -1 Unable to handle kernel paging request at virtual address 00=
00000000000018, era =3D=3D 90000000845659f4, ra =3D=3D 90000000845659e8
> >     Oops[#1]:
> >     CPU -1 Unable to handle kernel paging request at virtual address 00=
00000000000018, era =3D=3D 9000000085bef268, ra =3D=3D 90000000844f3938
> >     rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> >     rcu:     1-...0: (19 ticks this GP) idle=3D1094/1/0x400000000000000=
0 softirq=3D1380/1382 fqs=3D801
> >     rcu:     (detected by 0, t=3D5252 jiffies, g=3D1197, q=3D52 ncpus=
=3D4)
> >     Sending NMI from CPU 0 to CPUs 1:
> >     rcu: rcu_preempt kthread starved for 2495 jiffies! g1197 f0x0 RCU_G=
P_DOING_FQS(6) ->state=3D0x0 ->cpu=3D2
> >     rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM i=
s now expected behavior.
> >     rcu: RCU grace-period kthread stack dump:
> >     task:rcu_preempt     state:I stack:0     pid:15    tgid:15    ppid:=
2      task_flags:0x208040 flags:0x00000800
> >     Stack : 9000000100423e80 0000000000000402 0000000000000010 90000001=
003b0680
> >             9000000085d88000 0000000000000000 0000000000000040 90000000=
87159350
> >             9000000085c2b9b0 0000000000000001 900000008704a000 00000000=
00000005
> >             00000000ffff355b 00000000ffff355b 0000000000000000 00000000=
00000004
> >             9000000085d90510 0000000000000000 0000000000000002 7b5d998f=
8281e86e
> >             00000000ffff355c 7b5d998f8281e86e 000000000000003f 90000000=
87159350
> >             900000008715bf98 0000000000000005 9000000087036000 90000000=
8704a000
> >             9000000100407c98 90000001003aff80 900000008715c4c0 90000000=
85c2b9b0
> >             00000000ffff355b 9000000085c33d3c 00000000000000b4 00000000=
00000000
> >             9000000007002150 00000000ffff355b 9000000084615480 00000000=
07000002
> >             ...
> >     Call Trace:
> >     [<9000000085c2a868>] __schedule+0x410/0x1520
> >     [<9000000085c2b9ac>] schedule+0x34/0x190
> >     [<9000000085c33d38>] schedule_timeout+0x98/0x140
> >     [<90000000845e9120>] rcu_gp_fqs_loop+0x5f8/0x868
> >     [<90000000845ed538>] rcu_gp_kthread+0x260/0x2e0
> >     [<900000008454e8a4>] kthread+0x144/0x238
> >     [<9000000085c26b60>] ret_from_kernel_thread+0x28/0xc8
> >     [<90000000844f20e4>] ret_from_kernel_thread_asm+0xc/0x88
> >
> >     rcu: Stack dump where RCU GP kthread last ran:
> >     Sending NMI from CPU 0 to CPUs 2:
> >     NMI backtrace for cpu 2 skipped: idling at idle_exit+0x0/0x4
> >
> > Reject it for now.
> Drop this patch or pick Tiezhu's patches as a single series?
> https://lore.kernel.org/loongarch/20250821144302.14010-1-yangtiezhu@loong=
son.cn/T/#t
>

Tiezhu's patch does not work for now unless we fix the module_attach issue.

> Huacai
>
> >
> > Fixes: f9b6b41f0cf3 ("LoongArch: BPF: Add basic bpf trampoline support"=
)
> > Acked-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > Tested-by: Vincent Li <vincent.mc.li@gmail.com>
> > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > ---
> >  arch/loongarch/net/bpf_jit.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.=
c
> > index c239e5ed0c92..66b102ed9874 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -1514,6 +1514,12 @@ static int __arch_prepare_bpf_trampoline(struct =
jit_ctx *ctx, struct bpf_tramp_i
> >         if (m->nr_args > LOONGARCH_MAX_REG_ARGS)
> >                 return -ENOTSUPP;
> >
> > +       /* don't support struct argument */
> > +       for (i =3D 0; i < m->nr_args; i++) {
> > +               if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
> > +                       return -ENOTSUPP;
> > +       }
> > +
> >         if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIF=
Y))
> >                 return -ENOTSUPP;
> >
> > --
> > 2.43.5
> >
> >
> >

