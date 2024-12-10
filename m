Return-Path: <bpf+bounces-46561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDF99EBAED
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 21:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 488A1167438
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 20:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562A122A1F4;
	Tue, 10 Dec 2024 20:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mD6SpiiU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF284964F;
	Tue, 10 Dec 2024 20:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733863402; cv=none; b=N96FhzaoGWLNMhuboeFdTVXZi8zqhZG8iR5qz8cG7UaD/vC6MIZ+pHxYnR2E++paxLyCT3cp0hbbU2sixl57BWZDHuwDm3bqeA7pGvAko6Os2LPOTW8Ty77VV/xtPrCLqx2oGuXJihTZlWQ8qXBmTqAAuQMkb73rq8Ln9dpRN7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733863402; c=relaxed/simple;
	bh=bGHhrprHjsToC4P72S/FLs8cS2mBs18/lgIPgsVAUBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbHXbwkE744cqIl183lkYfslDSVVgoHMfbgbjR/0+5RZgKzqLgQJXesD1q83fP3QsEXwH6JJiyYCG2T9tO0hTfAp2PzyHFwMCJn8vqkkKCRNMkX8GASHVKIY89SYI2rMt6CLuF41YyAUKUSnkhTeuROXQO93r0L0Lki7zwFTR5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mD6SpiiU; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso35016a12.1;
        Tue, 10 Dec 2024 12:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733863399; x=1734468199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7FUX9r36NLSxog04wPW5u0vmu66rr70tdVVE7HRO7I=;
        b=mD6SpiiU8oeluQ+KCQovl35HqcpQH6a3eyTcJE3wfB8frFV1S1ResuWBx/kbbxH1NK
         vVaIiRlINmVVh9SCooALMfePrzg4T/djT9fW1hk7Rr9ehgzcjM5pSRD5jXB6NLoqkyYd
         zvExIx4nXLIKJYZgLdA9OrByDHn2wITLnXJUhHnVrOc0r4FbSq1S2QeFtrtqpSMNYEwE
         DONtZV1+p6cXdCa7Y9FHivcITApbAI2uafUa9VgatloG7AtKfxYqwV9M9xaOq3ccar/+
         u6GeZSKglIcQYBkUaG/HKrkp5bymjZvf59/zbIFF37kvD/Wpv1GJi8EZvtxBztnUABCa
         4ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733863399; x=1734468199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7FUX9r36NLSxog04wPW5u0vmu66rr70tdVVE7HRO7I=;
        b=NVuorPeLIy9AZzoEnHyVhqedjWZ3QJufJDfNQLkZ6A4X1xPRoPYAvYxexy4vQJf+Dy
         jFBbWsIkceCGCwx71gYJM/ngUgD19/98FSdWyUsFWhBCDb4JYjvFKTlfeUaRBJd5VstF
         tj6NmP1G93IDDs2utI1R9HgmorX9hSm/CjNIH1PN/4BCGQBdRc7BaLTrDlTZIlrzTc1T
         bPvMKIAPwC3CJR5nfODZQdN3EJQaCOFZYqXO59EMXkIyDQsVNVOer0e8So1X2ZGv9iKZ
         M23R2jOJ3JQz8QgB1pXhPPaPs0QuNlFUWU5Kky9Jv34r2WQr5HfqqOyu8/pZsEDIJoZT
         nAug==
X-Forwarded-Encrypted: i=1; AJvYcCVRfMq9WVpH/Nw3IEhSpzS9uJmlKc6l+Ai+2vxBokBYIV5L4qbDb4mvjXARZshKdv+MHLE=@vger.kernel.org, AJvYcCWZU49eqVGGlAuGshmuq7Z50CFsyC06ia9e2LSULtILXUfUxj/lfINAeK9idXGhEnP9BgoiFw3BmeI+It03@vger.kernel.org
X-Gm-Message-State: AOJu0YyTPo9gf+fW54DvTz12+cLlqxyS2idKMdRB64M9/FTTFJHhFRyq
	yDSbtOtp1py906LkVlm1UE1GJ7fE07LYQO3DYStZLSKRV8i4agxEwjdCJMwD0e6pGmCkUrEAqoX
	JewL/W//yCoLyCe7tS/gEE0f1few=
X-Gm-Gg: ASbGncsG0JAS16J0lKOaWeDUWC8v63bnQ+kaFEl5o5A1nqnFhI++y9HniCJ3o1uBQmn
	psbhVn7oJu53DOOw6RReMZGRb5E4WWBf3tCVyDL2k8zwykMbPSlhxF3nHc5wSlykKQsNW
X-Google-Smtp-Source: AGHT+IH6/kVdCtFLUgKn/dMiQKnQ9X+KOaQspRb/5dceLHrlZ3p371HZVEd2uTvW2I21VnUEN5e5BjgD/7YKKFjempg=
X-Received: by 2002:a05:6402:3588:b0:5d3:d79a:6d6d with SMTP id
 4fb4d7f45d1cf-5d433023b05mr184216a12.0.1733863399397; Tue, 10 Dec 2024
 12:43:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113093703.9936-1-laura.nao@collabora.com>
 <20241115171712.427535-1-laura.nao@collabora.com> <Z1LvfndLE1t1v995@krava>
In-Reply-To: <Z1LvfndLE1t1v995@krava>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 10 Dec 2024 21:42:43 +0100
Message-ID: <CAP01T76qFo-fzRh2PjGPtWd-N4tgMyoh_rz2GdZwePy=dRHFgQ@mail.gmail.com>
Subject: Re: [REGRESSION] module BTF validation failure (Error -22) on next
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Laura Nao <laura.nao@collabora.com>, alan.maguire@oracle.com, bpf@vger.kernel.org, 
	chrome-platform@lists.linux.dev, kernel@collabora.com, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Dec 2024 at 13:37, Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Fri, Nov 15, 2024 at 06:17:12PM +0100, Laura Nao wrote:
> > On 11/13/24 10:37, Laura Nao wrote:
> > >
> > > Currently, KernelCI only retains the bzImage, not the vmlinux binary.=
 The
> > > bzImage can be downloaded from the same link mentioned above by selec=
ting
> > > 'kernel' from the dropdown menu (modules can also be downloaded the s=
ame
> > > way). I=E2=80=99ll try to replicate the build on my end and share the=
 vmlinux
> > > with DWARF data stripped for convenience.
> > >
> >
> > I managed to reproduce the issue locally and I've uploaded the vmlinux[=
1]
> > (stripped of DWARF data) and vmlinux.raw[2] files, as well as one of th=
e
> > modules[3] and its btf data[4] extracted with:
> >
> > bpftool -B vmlinux btf dump file cros_kbd_led_backlight.ko > cros_kbd_l=
ed_backlight.ko.raw
> >
> > Looking again at the logs[5], I've noticed the following is reported:
> >
> > [    0.415885] BPF:    type_id=3D115803 offset=3D177920 size=3D1152
> > [    0.416029] BPF:
> > [    0.416083] BPF: Invalid offset
> > [    0.416165] BPF:
> >
> > There are two different definitions of rcu_data in '.data..percpu', one
> > is a struct and the other is an integer:
> >
> > type_id=3D115801 offset=3D177920 size=3D1152 (VAR 'rcu_data')
> > type_id=3D115803 offset=3D177920 size=3D1152 (VAR 'rcu_data')
> >
> > [115801] VAR 'rcu_data' type_id=3D115572, linkage=3Dstatic
> > [115803] VAR 'rcu_data' type_id=3D1, linkage=3Dstatic
> >
> > [115572] STRUCT 'rcu_data' size=3D1152 vlen=3D69
> > [1] INT 'long unsigned int' size=3D8 bits_offset=3D0 nr_bits=3D64 encod=
ing=3D(none)
> >
> > I assume that's not expected, correct?
>
> yes, that seems wrong.. but I can't reproduce with your config
> together with pahole 1.24 .. could you try with latest one?
>

As a data point, I ran into this problem with pahole 1.27 on
bpf/master, I see the same rcu_data duplication.
For now I'm probably going to test patches with the latest pahole.

> jirka
>
> >
> > I'll dig a bit deeper and report back if I can find anything else.
> >
> > [1] https://people.collabora.com/~laura.nao/dbg-btf-mismatch-next-20241=
113/vmlinux
> > [2] https://people.collabora.com/~laura.nao/dbg-btf-mismatch-next-20241=
113/vmlinux.raw
> > [3] https://people.collabora.com/~laura.nao/dbg-btf-mismatch-next-20241=
113/cros_kbd_led_backlight.ko
> > [4] https://people.collabora.com/~laura.nao/dbg-btf-mismatch-next-20241=
113/cros_kbd_led_backlight.ko.raw
> > [5] https://pastebin.com/raw/FvvrPhAY
> >
> > Best,
> >
> > Laura
> >
>

