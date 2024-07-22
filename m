Return-Path: <bpf+bounces-35267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCB99394A7
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 22:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05DDF281A26
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 20:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688B3200CD;
	Mon, 22 Jul 2024 20:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsX3+9RJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B831C280
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 20:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721678905; cv=none; b=rPXoh97QxaYfXVbC/0ISt1OvifHWxLOdOLvndopxR1jLm582IjB0L5YpUqjEsH3zABGUGV7Czz/I0Wa8fF4YFmRYWp3d4sRwtMXCbFPOrvlhbhrAWdNE4MkSh9wfNmgQHubCKisG41gvtfi4VFFwgs8KSGH8SitmbXPgvzpVDZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721678905; c=relaxed/simple;
	bh=7bvOrlgE+Zu28+rJZmpeYrZv9AvFlYrBgVWOlNnJW40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPOarRNKZqV1Pwhy+RzOT+YqfuUwQ3yV/uQJwf02sEhDYdu2X0y8enPT6ItJzhavizwGiynTeMGDQ/zJyyWXBaqq6suMT+LkFGu6Tm1+TQN7TZrsxBRrqFlKUO082/eMq31qnTQTNL0BPxOBGCLuIbMhbhQvTKu0NyLxObo9d68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsX3+9RJ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3686b554cfcso2218666f8f.1
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 13:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721678902; x=1722283702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rkk4zOm+O+vQ7/3ur7dyvdQjUcCUgRvOltGIQ3e2v38=;
        b=jsX3+9RJDyf3YMVpcytU9G36XbhonNz7dnR+fJCjtjxbZqNcYzXPqv3bB7rZ5VhV9q
         NqnWmDKMK/lpag8sU1D4+zBAuV8lIe11FrO/yRHU62iIwj87MJzwroBogtxmCOeQd/Jw
         gaosz3JWA27KbjQ0/i5ImwfQFj89Hm2yJ/sjctE9VFLDMeuMXSMl5kCZxw4rJR5ViGZT
         DyluXCkQUXoHdMyHNy2EMAAv7hpNfTXU6QCwhj2N3A/NI2IzUNU8M9kvuGuwCk2b/Z+i
         kXSHyLN7hDmTIJ8qnuUo+76ybAug0ZXB7v168qhIvb7aVfbBx5a05jZS7dVulTgrKoHI
         Zp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721678902; x=1722283702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rkk4zOm+O+vQ7/3ur7dyvdQjUcCUgRvOltGIQ3e2v38=;
        b=nVrquer6xTelrZ0goN/nyihNJNWaMPqFSq3cvnyo125d4kvcG0SFpIDFWX2cd6tqHy
         1YzqQRgVR5nq99ufsfLLeq74j0EAUoxqex2ACsLQaeiMVVy9l93zmJTdhkM9bjiN9Co6
         /FH6KZ8YAujlla8drXP0YgVmty6xNfQkERPaWyZZur2/UTL7HRUG0C0+jipNbvMK0zxP
         Jq8KuyK/OFhP4GxJGSz5AGh3xtTrbGMUdZCfgCEzaQ3GHVwtKcFmYY/4Q4PK8SNotk9X
         92scZTXEMMyHwXaVbRtDhqcf5rFKGN7oFi/zl4joJCRc6A1Bmycq6WgAQSrUR9UBi57S
         7iSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7yA0ZBRiz+TKeEfLxcukUuCLPVJCSXIGZNEAobetyXD6TTCl6nSNR4VluRC62rIPFdmvFZR4ZPB5S4Wktpnc9amr/
X-Gm-Message-State: AOJu0YyXWWQ8ax9Jfrl6jzM7FKFF4x9un08fBdArfD/Jocb+fZtAzZ1D
	vkglJwG1kS7BlmxQtHIH8fCePTRQZqorX4qjQomTaeyi61h/T/EGQvuQdSZ1rCBOFuA+EVzthDN
	3TXBsuK64sFiVVDB6xgAtcLQJiJo=
X-Google-Smtp-Source: AGHT+IGO6cLo3K7PIUF+uCGGiDcRk9z37NZjqfy3CQ7LqwDbFlZMv4FcOWA17Euo8hKmE/CTc9pd7HsBCypxg+3pgeA=
X-Received: by 2002:a5d:6b08:0:b0:367:f245:d847 with SMTP id
 ffacd0b85a97d-369dec047a7mr662387f8f.2.1721678901606; Mon, 22 Jul 2024
 13:08:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718205158.3651529-1-yonghong.song@linux.dev>
 <86b7ae7ea24239db646ba6d6b4988b4a5c8b30cd.camel@gmail.com>
 <CAADnVQLJrCv=2QKRr0g=cL3DzDBw5=tO=ufrA21KK-go-_y+Gw@mail.gmail.com> <49c7938cc9c3d6047efd8cf30eb66771a6f0fd8d.camel@gmail.com>
In-Reply-To: <49c7938cc9c3d6047efd8cf30eb66771a6f0fd8d.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Jul 2024 13:08:09 -0700
Message-ID: <CAADnVQ+Z7aqDUkDYwKr+kGaGe_j0w6FNTnNFUm5YJtpsnq8peg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Support private stack for bpf progs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 11:22=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Mon, 2024-07-22 at 10:51 -0700, Alexei Starovoitov wrote:
>
> [...]
>
> > It's not that simple.
> > Above sequence violates -mno-red-zone.
> > The part of the fix may look like:
> > movabs .., rax
> > add %gs.., rax
> > mov rbp, qword ptr [rax - ...]
> >
> > mov rax, rsp
> > mox rax, rbp
> > sub rsp, ...
> >
> > it's probably correct from mno-red-zone pov and
> > end result is maybe correct for stack unwind,
> > but if irq happens in the middle it won't crash,
> > but unwind will not work.
> > The main reason to use r9 is to have valid unwind
> > at any point of the prog.
>
> Oh, I see, bad things would happen if this sequence:
>
>       movabs $0x...,%rsp
>       add %gs:0x...,%rsp
>
> Would be split by an interrupt.
> However, I don't understand why 'push %rbp' violates red zone.
> In any case, the interrupt argument is sufficient,
> thank you for explaining.

push rbp itself doesn't break red-zone.
If we do:
movabs .., rax
add %gs.., rax
mov rax, rsp
push rbp


at the time of setting of rsp the unwind is broken.
hence the idea to mov rbp, qword ptr [rax - ...]
before setting rsp.
We have to maintain uwindable stack at all times.
But if we overwrite rsp it means everything will go into
this new memory.
We'd need another 16k of space in there for everything
that bpf prog can call, since kernel code will be using
that area from the moment of the switch.
At the end we'd have to restore to original stack somehow.
Instead of single 'leave' insn the sequence has to preserve
unwinding. It all looks very tricky and fragile.

