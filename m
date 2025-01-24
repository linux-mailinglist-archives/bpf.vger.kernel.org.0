Return-Path: <bpf+bounces-49650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA832A1AFAC
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 06:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBF4A188EB22
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 05:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D063D1D6DA1;
	Fri, 24 Jan 2025 05:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPEEjMuY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71B3380
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 05:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737695309; cv=none; b=mFKdwlS7Zm3IZQru3jFTNUwmVJK5Z9+VR+6xJUBrC9/tu/R7rl23BwhBQXoKKAiz1HPO9gm79FB+MwGyXGOmvjM85FCXzxegOrqoXq8glNJp3Yww4ayYZSdz8Dpg8D6mkkj0HpOPsz1h+qoQQeCyXilZAI4rY5LEy62BIXNLh9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737695309; c=relaxed/simple;
	bh=maf37QmpuqjmXuvsuCiUbcbWdhF6P4uKpve+TSVHbEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzJIqcmhVpxxNCAO5FFtGr1q5w1DGn3+z0kgafAKJLD23I7sNIaS9fx1SVQ/8v0cTrc8jJSH1X+WM+peoLTbZL5lhhzE/brpw2gOlHtV+FGr1i4mJEN/LTYzQy+yXZl1FU728WPDrmnhJ1SscJmYcMRN0X1RpdKeWeop3JsT83U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPEEjMuY; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-386329da1d9so912431f8f.1
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 21:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737695306; x=1738300106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyNDXJzU8DeJKX9wCGxfOko42mfcETSRY65b87hvaIc=;
        b=aPEEjMuYvr3o97HoMN0on4KhY1+45XD85JomAHWuy2/O/3sg2OcBWb99lcdKzwd3mE
         sI0Tq5tDXRH8JVEWLiOuydrOALJbmHcRVohJuriKj1lvQZ8Ti/V7h+g3qVUwvBg4vc2i
         yF91PXW41bBZlpxwUisczwhTofcGoQG/Irf9Br5ylXGM7YdnT+MQwsUJ9dIz3EKxarmy
         lJEg6wpK5XdUIMgXRUefAOo0Ukbqy8Fchu3/QytKXAO4l7oLHwrTtHgdu/DyEiIVTny/
         t+OIz3DurcOSYZSUUhZ3v9BrKdXsdJeTG6k76Nv2UKr9/qdSi8MAapBuqEEb/FrjRGjU
         qn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737695306; x=1738300106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyNDXJzU8DeJKX9wCGxfOko42mfcETSRY65b87hvaIc=;
        b=KJbmWPw8lNzT1yGnRhv961bsDkD40PIjUQhc3atqzfnKF7r99DJ6DNIHJol+Hyx5+w
         KFKHropLVf+6eMwZpMsqU5s71sOrHy7fir0ZWqPI/ZJEwNvNPFxy9yRp5CcPRzEbr0lg
         4TQZ8427odPFunlLeOelLRXW7lZ690n8UaCmiM1M5sjUU23bDMp3CA0ZReYG0THw4OZ8
         QpvS8hyZBRJkqI6BTERBbSAAMjkM1Ucd0SPtoH5uU94Jh4K/9cayDkaTi3xzmRI0hPQY
         EA236ioaqaM4u7B3D5+3FVTNdz9X7Jtt33pVY439vcDbV7FkdzoblDqjK3VgKpBSKTGb
         kgPA==
X-Gm-Message-State: AOJu0YxzH72mdHz64Fi7JvmuvD0RWjfhcEHNZ3xkw06rJQm1gVA9dpg6
	3iMHq/c3ImLMtxiNG/vQUA0Jiv+TW5eX+oAFlYkDzHM6kQbiJ8f0YI+P3ElGRuJiOgvPTv5bdzz
	B/FwSB48qT6BM4vJ3ncvZnRrFvKs=
X-Gm-Gg: ASbGncs81mMk+ZGdI0pMgr6x2jEPNsEI5qpHUtAJ19wEail/CPsQkpxq9YMSEuMZ44d
	kID5cjCY4geaqlcZaKStuqGQhyXsCsTa/wpajSfITj4mLOvyMOghy3URCBvgwVTjvRLgBqVX5Yl
	Qtgk6bQvLU2HbgMfEPyA==
X-Google-Smtp-Source: AGHT+IHhU5fmdlLT7CW+9DMblEOyayACAAy+yDx4WO6dXLslZFhPyrmnXd975hHJHnURba98TebwKDOVA9c2dLUmAUg=
X-Received: by 2002:a5d:64a1:0:b0:38a:39ad:3e2f with SMTP id
 ffacd0b85a97d-38bf565573dmr25097007f8f.2.1737695305664; Thu, 23 Jan 2025
 21:08:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
 <CAADnVQLxgD_7GYWZZ49aY2LqVYOy4uGvK2ikm7MJ1Cj60VPNaw@mail.gmail.com>
 <87ikqm45da.fsf@microsoft.com> <CAADnVQLYeV8-nJ-=_4p8U=xax99-i5QavJrQ=hnKS0EK1ZjecA@mail.gmail.com>
 <87sepl5k4z.fsf@microsoft.com>
In-Reply-To: <87sepl5k4z.fsf@microsoft.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 23 Jan 2025 21:08:14 -0800
X-Gm-Features: AWEUYZknCXvCm8M2f4rlQFIcbdjfGUoXjq4f69XDkceLFfMO5zb2Vw9mC46inOs
Message-ID: <CAADnVQJtbMCVJ4WfNk44QEh0oVRTYqUMBn3zFAgrVP469k7v2g@mail.gmail.com>
Subject: bpf signing. Re: [POC][RFC][PATCH] bpf: in-kernel bpf relocations on
 raw elf files
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: bpf <bpf@vger.kernel.org>, nkapron@google.com, 
	Matteo Croce <teknoraver@meta.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Moore <paul@paul-moore.com>, code@tyhicks.com, 
	Francis Laniel <flaniel@linux.microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 10:24=E2=80=AFAM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> It looks like they are done in the kernel and not necessarily by the
> kernel? The relocation logic is emitted by emit_relo* functions during
> skeleton generation and the ebpf program is responsible for relocating
> itself at runtime, correct? Meaning that the same program is going to
> appear very different to the kernel if it's loaded via lskel or libbpf?

Looks like you're reading the code without actually trying to run it.

> >> Would it be amenable to possibly alter the light skeleton generation
> >> code to pass btf and some other metadata into the kernel along with
> >> instructions or are you trying to avoid any sort of fixed dependencies
> >> on anything in the kernel other than the bpf instrucion set itself?
> >
> > BTF is passed in the lskel.
> > There are few relocation-like things that lskel doesn't support.
> > One example is __kconfig, but so far there was no request to support th=
at.
> > This can be added when needs arise.
>
> Yes, I ran into the lskel generator doing fun stuff like:
>
> libbpf: extern (kcfg) 'LINUX_KERNEL_VERSION': set to 0x6080c
>
> Which caused some concern. Is the feature set for the light skeleton
> generator and the feature set for libbpf is expected to drift, whereas
> new features will get added to libbpf but they will get added to the
> lskel generator if and only if someone requests support for it?

Correct.

> Ancillary, would there be opposition to passing the symbol table into
> the kernel via the light skeleton?

Yes, if by "symbol table" you mean ELF symbol table.

> I couldn't find anything tangible related to a 'gate keeper' on the bpf
> mailing list and haven't attended the conferences.  Are you going to
> shoot down all attempts at code signing of eBPF programs in the kernel?

gate keeper concept is the sign verification by the kernel.

> Internally, we want to cryptographically verify all running kernel code
> with a proper root of trust. Additionally we've been looking into
> NIST-800-172 requirements. That's currently making eBPF a no-go.  Root
> and userspace are not trusted either in these contexts, making userspace
> gate-keeper daemons unworkable.

The idea was to add LSM-like hook in the prog loading path where
"gate keeper" bpf program loaded early during the boot
(without any user space) would validate the signature attached
to lskel and whatever other prog attributes it might need.

KP proposed:
https://lore.kernel.org/bpf/CACYkzJ6xSk_DHO+3JoCYpGrXjFkk9v-LOSWW0=3D0KLwAj=
1Gc0SA@mail.gmail.com/

iirc John had the whole design proposal written somewhere,
but I cannot find it now.

John,
can you summarize how gate keeper bpf prog would work?

