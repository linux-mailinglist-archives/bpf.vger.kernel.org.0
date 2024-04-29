Return-Path: <bpf+bounces-28058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA828B5022
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 06:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3ADB1C2148A
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 04:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58108F6C;
	Mon, 29 Apr 2024 04:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AChBo93C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC398257B
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 04:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714363574; cv=none; b=KTyjEsXB9ToyT+hp4GLZDqmSMfAAPNSUfbbaUnqbxl8kZlV9hOVfZz0FMtMFtv2EkwH1yojFLWixmhNqAORT+XB0VVSSvGjDEsySy9KJNToQTaBAeElWmNPvqWXFTNrWRuZF7Uv5KURSut76gT47WwjLtOVLSF8NIWDhL56ai/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714363574; c=relaxed/simple;
	bh=Bj++74XUw5MNjMM3kwACECsNbBT3w0YLTdee/vtGfCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVK/dBDthb9HeZeF2nwNoeyCzbkbgTCKHF1cfr3fRqpRsF5w16+3rAnapXhOlxn52Deiz2b8Kn9mJNach9QVjVjf71ej1BvFDNZimcAifLcOeYH0IZbBeJ2akixDRuyAX843d3BVisR5CJ0syNrmvc7XaNZOWkwNplDUV7eefrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AChBo93C; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-346359c8785so3517223f8f.0
        for <bpf@vger.kernel.org>; Sun, 28 Apr 2024 21:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714363571; x=1714968371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDt/zrDDTe2u1D66GSuafdEHTflggIlTXAijnvI3p8I=;
        b=AChBo93CI8I0OS4dSkUsiF9bRh5TuIQRhUbLwRezSf0jLW1a9Ih1V6jwg6urpEJTPc
         /CocIoBWVt/hCxnr5kVccDX5uyL0AJmL6R0sB6ZuquWY1C7jDaSfvwcVMo72sDhzTeox
         jl15/Jnf/8tuLzJY1XxFfuw2vyeAsXBRIaEGVXE8ZKKT9ZpdCLyQOT4xS+aAMzdYgxsO
         Wt7DmOLpp8Lkh4R4BQL/zKMgt7FNiJdbWmhQwtEIfF19aBHEuwRgmgxjDrrJhwh4WXMc
         nkRxiCq+4Wysed3psj6r31ZSnY7jlBQUZOPMCoQSoLZzcfXkKcHUprCZUUga57Jc4MkK
         iASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714363571; x=1714968371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDt/zrDDTe2u1D66GSuafdEHTflggIlTXAijnvI3p8I=;
        b=MoGJBvTRkJ3mJwNYjzcFrMSIaY+/jPpUuCz19S5NAn8UqQRUOPiSCJWnDNXhjKFNo4
         a8lGazMdIG2VLt20DJEFOpTStBxtHUFxMYBtCO8tXC4hdA6B791yl/2YmiJvxBQQeT58
         qV9F/tHcp/tVOL+50EBEkYy98QwecpxpEPmE5g2EqKctVh8ycOv9+S3leMdShA/VhTM3
         9tBLwLeTK1g3bBVn/Ab+ufnaX3fHTL25olezPd/vjOJWRBeJ0qoLOEbuUwsGJuDt8nHU
         PESKtk/c5KtOh+/H6KZtmeTlDCR5O3/lGpX4SBloy179E4c0kaZ9SF/6cwRS4X2DXmS2
         XafA==
X-Forwarded-Encrypted: i=1; AJvYcCXvTVnszbx3u04+p+h6G0A1BkKm/tEA7kOvPTg+I7TCAFVXFEAZW2ZdcSskksPIz7m0im1yb/k/FVaEGXAY4y2Ba0Dw
X-Gm-Message-State: AOJu0YwuEY4/swPGo/XA2MztpNGnw+/XL99aKsNpguppGA5WjgUe7jQ4
	hBkoLTt16BQ8eh/iSaSbVtYPgu5dOmlRfdJFhlfrLo7iyvZeN+f4G1YeVzgc5DdvAR66cF30fxo
	unhKlP4fgqCHUwl3AdveXHiWgs5s=
X-Google-Smtp-Source: AGHT+IGyZDG4cV7UN0t+gJR4hEdYYr2I2b/Cs2AtB+1kfi4p2ytzd6+nHFzGT+Vpq6/BVKD5qvvpkr8ISHkBpBkVXYY=
X-Received: by 2002:adf:f5cb:0:b0:342:a8db:603f with SMTP id
 k11-20020adff5cb000000b00342a8db603fmr6004640wrp.26.1714363570833; Sun, 28
 Apr 2024 21:06:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5c5936c9-f44c-45ba-920f-b07625b29071.bugreport@ubisectech.com>
In-Reply-To: <5c5936c9-f44c-45ba-920f-b07625b29071.bugreport@ubisectech.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 28 Apr 2024 21:05:59 -0700
Message-ID: <CAADnVQ+EwjtL=OdSrhEHyXPuxdEStV4BQOS0ScN9KhFB2T03dA@mail.gmail.com>
Subject: Re: WARNING in bpf_map_delete_elem
To: Ubisectech Sirius <bugreport@ubisectech.com>, bpf <bpf@vger.kernel.org>
Cc: security <security@kernel.org>, ast <ast@kernel.org>, daniel <daniel@iogearbox.net>, 
	andrii <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 28, 2024 at 6:12=E2=80=AFPM Ubisectech Sirius
<bugreport@ubisectech.com> wrote:
>
> Hello.
> We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec.=
 Recently, our team has discovered a issue in Linux kernel 6.7. Attached to=
 the email were a PoC file of the issue.

This is not a vulnerability and not a security bug.
Cc-ing public bpf@vger list.

root triggering a warn at kernel/bpf/helpers.c:73
        WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &=
&
                     !rcu_read_lock_bh_held());
is just a bug,
and in this case it feels that it's a bug with your config,
since bpf_prog_test_run_syscall further down the stack does:
        rcu_read_lock_trace();
        retval =3D bpf_prog_run_pin_on_cpu(prog, ctx);
        rcu_read_unlock_trace();

so it shouldn't warn.

> Stack dump:
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 16824 at kernel/bpf/helpers.c:73 ____bpf_map_delete_=
elem kernel/bpf/helpers.c:73 [inline]
> WARNING: CPU: 0 PID: 16824 at kernel/bpf/helpers.c:73 bpf_map_delete_elem=
+0x94/0xb0 kernel/bpf/helpers.c:71
> Modules linked in:
> CPU: 0 PID: 16824 Comm: syz-executor.3 Not tainted 6.7.0 #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> RIP: 0010:____bpf_map_delete_elem kernel/bpf/helpers.c:73 [inline]
> RIP: 0010:bpf_map_delete_elem+0x94/0xb0 kernel/bpf/helpers.c:71
> Code: 89 ef 5b 5d 41 5c ff e0 cc 66 90 e8 66 04 e7 ff e8 a1 11 ce ff 31 f=
f 89 c3 89 c6 e8 f6 ff e6 ff 85 db 75 99 e8 4d 04 e7 ff 90 <0f> 0b 90 eb 8e=
 48 89 ef e8 3f bd 3d 00 eb a0 e8 38 bd 3d 00 eb b8
> RSP: 0018:ffffc90001ee7a90 EFLAGS: 00010212
> RAX: 0000000000000369 RBX: 0000000000000000 RCX: ffffc90011f07000
> RDX: 0000000000040000 RSI: ffffffff81a2f203 RDI: 0000000000000005
> RBP: ffff88801a226000 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffffc90001ee7b50
> R13: ffffffff81a2f170 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f1c460de640(0000) GS:ffff88802c600000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2c923000 CR3: 0000000053eec000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  ___bpf_prog_run+0x335f/0x95e0 kernel/bpf/core.c:1962
>  __bpf_prog_run32+0x9d/0xe0 kernel/bpf/core.c:2201
>  bpf_dispatcher_nop_func include/linux/bpf.h:1196 [inline]
>  __bpf_prog_run include/linux/filter.h:651 [inline]
>  bpf_prog_run include/linux/filter.h:658 [inline]
>  bpf_prog_run_pin_on_cpu include/linux/filter.h:675 [inline]
>  bpf_prog_test_run_syscall+0x3b5/0x790 net/bpf/test_run.c:1496
>  bpf_prog_test_run kernel/bpf/syscall.c:4040 [inline]
>  __sys_bpf+0x1295/0x4e00 kernel/bpf/syscall.c:5401
>  __do_sys_bpf kernel/bpf/syscall.c:5487 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5485 [inline]
>  __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5485
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x43/0x120 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7f1c4529002d
> Code: c3 e8 97 2b 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f1c460de028 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007f1c453cbf80 RCX: 00007f1c4529002d
> RDX: 000000000000000c RSI: 00000000200004c0 RDI: 000000000000000a
> RBP: 00007f1c452f14d0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007f1c453cbf80 R15: 00007f1c460be000
>  </TASK>
>
> Thank you for taking the time to read this email and we look forward to w=
orking with you further.

