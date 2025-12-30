Return-Path: <bpf+bounces-77530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B503CEA6AA
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 19:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DA61302035B
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 18:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7B7280018;
	Tue, 30 Dec 2025 18:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVIXveq9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB8A26056D
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 18:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767118027; cv=none; b=A1Izo9mcDubJFGXDDqKNvyNfIJf0+ZKAyp6xZtUZVjGxdCLIx0vgNzGzmXTyeu6tnO+QvnAR2d3GeI37BrTPY6b7c619od6SX8A8qNxKFA1x9ijUFMSCIA5+VxAv181cWE0qDHdM8XDab3aVkltIS1yGY+TOz9D/UpFQb8URAp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767118027; c=relaxed/simple;
	bh=if7BGCUQC4lDEzFB6sz4KoqdG/WVlgI7PdhKYoSdwbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rt7HjfnI6nI3644no8NLqki4Qj84W4pYlee61dJLGEV00L/Al4Qfj8vV6r7+1tSW3qpwNApFZoEAxNWil5ti2bbpif6AHAMJn+0foQCq2QnfA6PLpXdySkHM0UjAGCqr/H6bCP1cCEEYKzZ8ric01vkWZp4HfOQvxcPrDRFB3j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVIXveq9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47d1d8a49f5so49114495e9.3
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 10:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767118024; x=1767722824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzjmgwRv2p2iqnj4MbLcXnHMXE50+6aC73Sel7gltN4=;
        b=jVIXveq9kS+8YyxkPYasvxhOos+Hj1qV8gKsdov10wdMNlNZe219H5V7HURYQbhZZW
         1OlvZuJqFIKILS7ynIvTXyEYHFv0YKAiPT6Ib0oyUKD9xSs/QtoOLSxYJZTPUwNxzrry
         XIXACDXe4CjmUZf7oNpYwwaZ1exwGi9Lsq7I+rArGNJBowM9A71TgFA+waUIYqV2uAx8
         8ut7wafDkAtJEBBNVuOFLOAnrQNW9ufHspNyp3ogK6Hbqp7AxP2+IQRe+GulQdQ7qcFm
         UEK+eAfAWx202UdgTFXEapCcQkRxn+Fa3TLsu+5XvjfLv4urgmQtdEyPhLD5LQSx93/l
         EHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767118024; x=1767722824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jzjmgwRv2p2iqnj4MbLcXnHMXE50+6aC73Sel7gltN4=;
        b=HItTrc7pmdpjTNaujjUogMjYGLOKu/GSqoej9PZvWoRhDMu5FuwKRLR9a3lEozkg+r
         FF248fwsVMG6KnmtmzGV/+egEgyxP0yopw+BtIcMr4xTJguuF3ywJ1Hsn7XB5swJkLyb
         A3sKn43uZb6KrZqbC6DWMQC8X6SJBd/jSJpI/b6Copfejqft3duzvANsgyRYhvRjud/K
         8SU5HhpTCy3fkAJBC/Vst5yRj/EoEdy9rZSvsyIZzXjdAjj26qXNlkbyDDKPbKW1l8ac
         Z1BlpkSVIOt0yPY6ar7DDFC8f6T09knPuP3luE6HfrhrDJkOG0uityLPcThdDXCWVKOL
         xH5A==
X-Forwarded-Encrypted: i=1; AJvYcCU7oS6QW85coTFzsjMipnzdRrftPlDJrFQVU3o/qQAcMwHFbOLkAPuAfdvlUopZn/M32Fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRQ7B+ceRJAxF3VsdIe4BvngjtcqhtqgU/egSkjzdU8wpx92I3
	zcEfEKAbKVdDk9dog+YfrRDta2jAWuoYh4Iju9q00RuYc6QGryShFz4CAj1ubec2lplZaVX/elV
	azmkBWH2s1In8R1LjaHuj0QFdSv7xbfc=
X-Gm-Gg: AY/fxX7Y9pFJGMmSzps241AaaetjtwC0/AslIeEyYgVR18sdZh46m5ba2Q2nO7jnkzR
	Mz4fdxRNIjpN1/r/cJz6t/OMK7OhpZnIV7uYWy7PSwFuRe4l14curCj4c38DCOhlf+zvyHWNEDG
	Y3zkQoNrdJ/rWk/Dx043ZgdYQ6m4NAWoUUfa+FJmcDLBL9eswbNEm8aofbuskHIjYH8f/TcbAzv
	Rh55y0/8kJAJxo1SRmVadIYrP42G+0hFk+nxQ3+MVewucAwH+tzI7wrb0JsVYcMOqGhspGgbtQW
	gg+r/GUyBdgh7tqQmUpjUMHXG/df
X-Google-Smtp-Source: AGHT+IGxbWxByoZ4qZ/OqL8mjdsrQMy92tVBLl9MjFLHEOnJKjjhUcOloNpJLabmWZ5pi2qCG4otOqUFlDI6aYUHKaY=
X-Received: by 2002:a05:600c:4e42:b0:477:7d94:5d0e with SMTP id
 5b1f17b1804b1-47d1958fcbcmr387049085e9.27.1767118023902; Tue, 30 Dec 2025
 10:07:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222185813.150505-1-mahe.tardy@gmail.com> <CAADnVQLF+ihK16J3x5pQcJY0t2_gUHiur7ENZNqJdazzr+f8Pg@mail.gmail.com>
 <aUprAOkSFgHyUMfB@gmail.com> <4eec6b7605d007c6f906bf9a4cd95f2423781b0a.camel@gmail.com>
 <CAADnVQLsJeSjwFVE=gcnVzh7HftDqZJM+xByr2cD6TRmTRGLsA@mail.gmail.com> <62ba00524aa7afd5e1f76a5a2f4c06899bf2dd64.camel@gmail.com>
In-Reply-To: <62ba00524aa7afd5e1f76a5a2f4c06899bf2dd64.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 30 Dec 2025 10:06:52 -0800
X-Gm-Features: AQt7F2rFwT6fM6gxicD6MQVtd1_S2xt4YwCocqXTjEfnpu5AW8H1smHjds6mqC0
Message-ID: <CAADnVQLDfmLSuvXJFLHM=tOfViSvwPBUyGGZN8OhDP5dRy1_NQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] verifier: add prune points to live registers print
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mahe Tardy <mahe.tardy@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Paul Chaignon <paul.chaignon@gmail.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 5:13=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2025-12-29 at 16:42 -0800, Alexei Starovoitov wrote:
>
> [...]
>
> > > Imo, it would be indeed more interesting to print where checkpoint
> > > match had been attempted and why it failed, e.g. as I do in [1].
> > > Here is a sample:
> > >
> > >   cache miss at (140, 5389): frame=3D1, reg=3D0, spi=3D-1, loop=3D0 (=
cur: 1) vs (old: P0)
> > >   from 5387 to 5389: frame1: R0=3D1 R1=3D0xffffffff ...
> > >
> > > However, in the current form it slows down log level 2 output
> > > significantly (~5 times). Okay for my debugging purposes but is not
> > > good for upstream submission.
> > >
> > > Thanks,
> > > Eduard.
> > >
> > > [1] https://github.com/kernel-patches/bpf/commit/65fcd66d03ad9d6979df=
79628e569b90563d5368
> >
> > bpf_print_stack_state() refactor can land.
> > While the rest potentially bpfvv can do.
> > With log_level=3D=3D2 all the previous paths through particular instruc=
tion
> > will be in the log earlier, so I can imagine clicking on an insn
> > and it will show current and all previous seen states.
> > The verifier heuristic will drop some of them, so it will show more
> > than actually known during the verification, but that's probably ok
> > for debugging to see why states don't converge.
> > bpfvv can make it easier to see the difference too instead of
> > "frame=3D1, reg=3D0, spi=3D-1, loop=3D0 (cur: 1) vs (old: P0)"
> > which is not easy to understand.
> > Only after reading the diff I realized that reg R0 is the one
> > that caused a mismatch.
>
> In theory this can be handled in post-processing completely,
> however I'd expect mirroring states-equal logic in bpfvv
> (or any other tool) to be error prone. Which is very undesirable when
> you are debugging. To make post-processing simpler I'd print:
> - state id upon state creation
> - state ids upon cache miss + register or spi number.
>
> This way post-processing tool would only need to collect register
> values for state ids in question.

that will make post processing easier, but print on every miss
will greatly increase log_level=3D2 size, right ?
and whole new concept of state ids just to make a post processing
better. I'm not convinced it's worth doing.

