Return-Path: <bpf+bounces-77192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E8CCD15DB
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 19:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 346EC303582A
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 18:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A406734D90F;
	Fri, 19 Dec 2025 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bslw1DtJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EED34D4E8
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766168758; cv=none; b=Rjg42TfBmDUvaoAs/4GhNWL15fjGLfSE6i4VZW7EY09rModa2gbWeoZSVfz4Kgb69GGr0TvLmP1emlaKsLEULyyuisxft5Th3bAKmvunA/xCkwN/bGY1GKBjtyB+gLgfy4FD6oA4K+zOpgXdiz938z6sValyvZsDAqPVFMsidBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766168758; c=relaxed/simple;
	bh=mT1EC1eoa6YbQTCr43xAtv0MscRfx4tUzjnjhfDjzZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X8Yyuj8nqfMgCrEFsoPs9JqQjaXFlfqxVGHTWkFnZHbadBk6jvadJMHTOvPSjdAhVGvFqS28tx43SirgmwNgeN4zkCnE8bkVuFHHiz0vPY0oWy1dKg7lidMIiYZHVrntuJQVLn+ZhJOjDiRAsumHwJOR2/MVZKlkVinNBWobybU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bslw1DtJ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34c21417781so2069161a91.3
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 10:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766168756; x=1766773556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhOF0P3TA0VgAlDrFuCfFc13aLzGhlFUkxGfezQClao=;
        b=Bslw1DtJCzjUkospdHaovjdPC+IlWEJ4XuUa4oJT2Glmqj0fOo2mXBJ9wrqh9ItckO
         YqBVefsiRzCFDb2uSiI3MI826xy6hbKaJ9/0M/v3fpOesdfEM1Tx6dvoMvih7uKAs+Wg
         Xs4ZSHxgqEA2qy29b3OoBmDhC/fSHgtRXScx+Ux/1QkGSHAlOQrY6IR21UQKxwyPCQH2
         ojyzlEBx5WhIV15d0ETf9WnlbMF83fuF4eE1Ki6jNSCAWZj8A7294YI3csMEZw8M1gy1
         xbqFktfQge1zL4drGLghTq5DXsAfuNsLVhVJiDqUtdPtcUKmAPx0RIuvExGLV5gqI1Z+
         uCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766168756; x=1766773556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XhOF0P3TA0VgAlDrFuCfFc13aLzGhlFUkxGfezQClao=;
        b=nAbZ9AHqtuKGxtq989L38qBj6M6KFsSoTcGuNTcBCMAM/qYAL2plqCYCrbAFtak82z
         axoh5e3Yn7vEz8pSkBpbqQmgQ5ClUZIO0NpQch4F8ZKq7xOpbiSWpJfE/XAF0duud2jQ
         AV6e9PhGzcDNUKl6VHhgriKnIe7hB4P7TUWww4euu5vzILYCUhb3U9gDazNk2O4w5OrD
         Ce2JmNmhhY2e2oTTm2lTY2F1T4Vx5GSsOFL9qTlqt8RIHSFbswlNRo3LCQqBz+v1fPSr
         xqx0YzEbPQf2D3lngcVjLF5nX6t2/MV3CHfR6Oik0FD0ti285CPvsnXo/KYDE2PE2/oI
         TgAg==
X-Forwarded-Encrypted: i=1; AJvYcCUf8gBVrFFKRN2zdvdCcUoQ4qTBKLA2NnfDRauSNE64mdvlnHbxK81RnajRexzqc3/jT8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzykO1xkOVvyEYgF1MNMxUyC247riKTJhWHuKl4WNt4cCMJ8KQ6
	YAwqOiWdHShOQjOeHnxH7QDryUJfbQM2r8FTx0pia2K+HDFyscOPZsgX6DvzbeVCM6uURvr5YaW
	wY+W5LX0bZ0hDMcbVYkPHMd7y7eb6oJ8=
X-Gm-Gg: AY/fxX6HtHSrudvaljfDAXUwU6PcCqp3Cf0Uk2gFBTzPPiORApE88zYJBgIS0Vab8zQ
	C56wQFVNX1Utkbmc0EZU3hJS2lxIuq4DfIRXChLOsvh8BSkVnGnlmoCfbkw3BB0K0siMps7vqu0
	lABHMi6tmBW+vALvo3GONR8y3/s1AmbbQX0JBosRQVvKkH9A1y75GRS8oKgo2oZysy7RVhUlxF4
	ELtDg5HVe5enMlPPorXr6zcFTaXiimXVTegvyUXxjF5jyMUx0/VMYdeABnzm9JF6KQpOJU=
X-Google-Smtp-Source: AGHT+IFuZfvNJXvZZS1HlXgeccWILgULSwglw3eIa/khx/+P2XVIx6KJc41o3vOxdOWREz5fU9uuGgyPMLJj08pU8Cg=
X-Received: by 2002:a17:90b:2246:b0:32e:4924:6902 with SMTP id
 98e67ed59e1d1-34e921137a3mr3620243a91.3.1766168755839; Fri, 19 Dec 2025
 10:25:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219124748.81133-1-dongml2@chinatelecom.cn> <CAEf4BzZBoHvB0yY740zyZWYKAgCeTXjLvfJUebq5FRWmq=WBZA@mail.gmail.com>
In-Reply-To: <CAEf4BzZBoHvB0yY740zyZWYKAgCeTXjLvfJUebq5FRWmq=WBZA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Dec 2025 10:25:44 -0800
X-Gm-Features: AQt7F2pTD0PSroW9LtfM60H5vTK6kRKR-Lv2ixQmUmiXylMqKmxZFDM9yicG5Vg
Message-ID: <CAEf4BzYzenxqVUty4RL15fVBR_bNLLgMAWHeMUyDkAeWWqbYug@mail.gmail.com>
Subject: Re: [PATCH bpf] riscv, bpf: fix incorrect usage of BPF_TRAMP_F_ORIG_STACK
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bjorn@kernel.org, 
	pulehui@huawei.com, puranjay@kernel.org, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, jiang.biao@linux.dev, 
	bpf@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 10:06=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Dec 19, 2025 at 6:43=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > The usage of BPF_TRAMP_F_ORIG_STACK in __arch_prepare_bpf_trampoline() =
is
> > wrong, and it should be BPF_TRAMP_F_CALL_ORIG, which caused crash as
> > Andreas reported:
> >
> >   Insufficient stack space to handle exception!
> >   Task stack:     [0xff20000000010000..0xff20000000014000]
> >   Overflow stack: [0xff600000ffdad070..0xff600000ffdae070]
> >   CPU: 1 UID: 0 PID: 1 Comm: systemd Not tainted 6.18.0-rc5+ #15 PREEMP=
T(voluntary)
> >   Hardware name: riscv-virtio qemu/qemu, BIOS 2025.10 10/01/2025
> >   epc : copy_from_kernel_nofault+0xa/0x198
> >    ra : bpf_probe_read_kernel+0x20/0x60
> >   epc : ffffffff802b732a ra : ffffffff801e6070 sp : ff2000000000ffe0
> >    gp : ffffffff82262ed0 tp : 0000000000000000 t0 : ffffffff80022320
> >    t1 : ffffffff801e6056 t2 : 0000000000000000 s0 : ff20000000010040
> >    s1 : 0000000000000008 a0 : ff20000000010050 a1 : ff60000083b3d320
> >    a2 : 0000000000000008 a3 : 0000000000000097 a4 : 0000000000000000
> >    a5 : 0000000000000000 a6 : 0000000000000021 a7 : 0000000000000003
> >    s2 : ff20000000010050 s3 : ff6000008459fc18 s4 : ff60000083b3d340
> >    s5 : ff20000000010060 s6 : 0000000000000000 s7 : ff20000000013aa8
> >    s8 : 0000000000000000 s9 : 0000000000008000 s10: 000000000058dcb0
> >    s11: 000000000058dca7 t3 : 000000006925116d t4 : ff6000008090f026
> >    t5 : 00007fff9b0cbaa8 t6 : 0000000000000016
> >   status: 0000000200000120 badaddr: 0000000000000000 cause: 80000000000=
00005
> >   Kernel panic - not syncing: Kernel stack overflow
> >   CPU: 1 UID: 0 PID: 1 Comm: systemd Not tainted 6.18.0-rc5+ #15 PREEMP=
T(voluntary)
> >   Hardware name: riscv-virtio qemu/qemu, BIOS 2025.10 10/01/2025
> >   Call Trace:
> >   [<ffffffff8001a1f8>] dump_backtrace+0x28/0x38
> >   [<ffffffff80002502>] show_stack+0x3a/0x50
> >   [<ffffffff800122be>] dump_stack_lvl+0x56/0x80
> >   [<ffffffff80012300>] dump_stack+0x18/0x22
> >   [<ffffffff80002abe>] vpanic+0xf6/0x328
> >   [<ffffffff80002d2e>] panic+0x3e/0x40
> >   [<ffffffff80019ef0>] handle_bad_stack+0x98/0xa0
> >   [<ffffffff801e6070>] bpf_probe_read_kernel+0x20/0x60
> >
> > Just fix it.
> >
> > Fixes: 47c9214dcbea ("bpf: fix the usage of BPF_TRAMP_F_SKIP_FRAME")
> > Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> > Closes: https://lore.kernel.org/bpf/874ipnkfvt.fsf@igel.home/
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  arch/riscv/net/bpf_jit_comp64.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_c=
omp64.c
> > index 5f9457e910e8..09b70bf362d3 100644
> > --- a/arch/riscv/net/bpf_jit_comp64.c
> > +++ b/arch/riscv/net/bpf_jit_comp64.c
> > @@ -1134,7 +1134,7 @@ static int __arch_prepare_bpf_trampoline(struct b=
pf_tramp_image *im,
> >         store_args(nr_arg_slots, args_off, ctx);
> >
> >         /* skip to actual body of traced function */
> > -       if (flags & BPF_TRAMP_F_ORIG_STACK)
> > +       if (flags & BPF_TRAMP_F_CALL_ORIG)
> >                 orig_call +=3D RV_FENTRY_NINSNS * 4;
> >
> >         if (flags & BPF_TRAMP_F_CALL_ORIG) {
>
> move orig_call here, it's the same flags & BPF_TRAMP_F_CALL_ORIG check, n=
o?
>

ah, never mind, I see you send v2 adjusting this

> > --
> > 2.52.0
> >
> >

