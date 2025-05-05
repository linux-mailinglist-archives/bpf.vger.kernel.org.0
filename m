Return-Path: <bpf+bounces-57372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2740BAA9D84
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 22:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C9F1A8165D
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 20:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C7320966B;
	Mon,  5 May 2025 20:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqD7tais"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698955680;
	Mon,  5 May 2025 20:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746477975; cv=none; b=NkR3xp2wsiVloX2vgdm68i0Uw9EZlBvffOZJhr1FAHZGLzekFNwyApghzVziFIHwv4cEY2l68yiR157vnEtrKqimGNr60CIavlY76ZSF6ywkUzbgrleli3QB2wtcOot6sbmmxf7kMDn4c5lWI2M6we5YJ9DPdewKKgSMjaCatYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746477975; c=relaxed/simple;
	bh=GYCgYxHNKqU6EEr7JY7HlY6hgLPVmcWr69EXEM+HrQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghfzqchFZfjoNXqwO/sBNcmIDue4Jv/28ciYOSm3Zn1jlL3+rpHItWNg1r0OyjQeP9sjH7G5ciPu9/lFVV9ccCNkLqfQXrbTwMSj9+86yBMCbUrFyF8aZG2F2zhq6zPsVRGMB8sJa/lubXrCBwlcn008L4sR5MTVoImrSdUhohM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqD7tais; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-acb39c45b4eso785329566b.1;
        Mon, 05 May 2025 13:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746477972; x=1747082772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tybCDQgbYv/YcqEFOas0tcjmYlNZGGrI6YJEE/TM6nk=;
        b=MqD7taisksdcWw062hZrMFlwLet9a1iKtdFZSe0ut6uuoE7M6KkyBFb+L/svpp6V48
         AFltEqUIXlXFfBVdUXhUaVfwOSwXG09Njqio/Vhm80HD0QfFPOzJrAGCTekn91GLbXIS
         3JpJeD0YdfqH3mBzDyQi9IcXWtqAp7NTrikotnEHpq+WZNdyZb69GpgC/qumnCAApZo9
         OF95/sKnFvQZidBWQ1+dAT35EH4sEJRgCB7XQ+/CCjFJGOGJOrLg4e2ujvE7JGmjmTn1
         QrxyRJi72HiAOI0TJhCWjoEqATG2dxUDE+y94F1hP1YECMzcsL4T70oZSZAx4Z8czokC
         rMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746477972; x=1747082772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tybCDQgbYv/YcqEFOas0tcjmYlNZGGrI6YJEE/TM6nk=;
        b=qynrM4LBXRlFF0ASKZltSjQ7RHHRhSNnvxh37EqXMCafitzlInl6fMHuZ4hwaAMnQ2
         5xeW2iYrZNsWHeIhkCszkKEx3JMI9RK3fotVkoW7nRw6zIkfhx+ZKvGf0UfLE9yuzs/h
         6zItjKay+C3rZpZNypyeGEgLVjdJa592Yff044MprmIg1shH4tPLi3GwhqSCgsg7op7O
         51+cJU8c4/dOzVRHKP/bLmJCb/WY/PQQvaYOfZURR7uj9HJJaB+1DO80mihjXfWutkIl
         a1YWWvSPPqQpEX4l8bdvOU/dszaEAijQELLs53q5H5/WbFWca/dLNXkLYJuQnETa/uo8
         ahSg==
X-Forwarded-Encrypted: i=1; AJvYcCVpVt9+DjESJ7bTr5vn9ZtgcEJu9jXq8NABn5ACv9jEa7Flp1Vypp+tIPvcLM75Sz0cCy0=@vger.kernel.org, AJvYcCWRp1mFYV6DeSc6ocuFJNoOn/Fx2KH8rc9kVRwn7ppAU8rY13PELcvUUbt9rnIGZ0qx27AVZzmjALkRo9H7@vger.kernel.org
X-Gm-Message-State: AOJu0YzQOQ6imKAAGfqbea/CWjAc9Fnq9AigXazah3G/xoI6awqD7Sd9
	WmkfpurFqArq79Zp0oHp0tgYKFcpLEyfWdopL8w6I8OdYWOtS2u4sgDDAJkH+aJqwOID7YQW/PH
	UToNCExlR0+V7hiDXZ8hKD0zeaTQHZ5TU
X-Gm-Gg: ASbGnctHFs4o8t9NZlQkmri9TBJ3Btzj70yZiqJSb9Il5dmZdN5dCbIBtHH9kR3+EMk
	cLecmqkL7oLjjc2GSMVs+EawiqPYL9jOfvpkXwlUizN2A43p+gyerfwzdjp4NTr6l5TKpaTvYTZ
	Uzqi6Pt/DtAea5T8DBc7VCYFhuyeOMRpHUvKlowlgIKxfOSJrJiYmm58RT
X-Google-Smtp-Source: AGHT+IFaoqY71pVRRJ7P+HRGZj3SOTKvX2Bacc/R5kHHu8emAV4IQZMSOIuhMj/lCAmrBkYAx8BjwvJXUajJimq1MLs=
X-Received: by 2002:a17:907:7eaa:b0:ace:6703:3cd5 with SMTP id
 a640c23a62f3a-ad17b5aa887mr1473094466b.19.1746477971517; Mon, 05 May 2025
 13:46:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505063918.3320164-1-senozhatsky@chromium.org> <CAEf4BzZkVg39JqGeuAjypf=WXsOG8JVDS8SSkVLDjHUuHzxoow@mail.gmail.com>
In-Reply-To: <CAEf4BzZkVg39JqGeuAjypf=WXsOG8JVDS8SSkVLDjHUuHzxoow@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 5 May 2025 22:45:34 +0200
X-Gm-Features: ATxdqUGyV175Iz8wUrQeZgFbma2bBdb8CE0GxiTDzIoLvf4w6Vmp-tKnEzQZwmg
Message-ID: <CAP01T754qZJNS7N8Q3dTB-2ApCRPbG1sUU2RpxT4ePFbv9-8=g@mail.gmail.com>
Subject: Re: [PATCH] bpf: add bpf_msleep_interruptible()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 5 May 2025 at 21:57, Andrii Nakryiko <andrii.nakryiko@gmail.com> wr=
ote:
>
> On Sun, May 4, 2025 at 11:40=E2=80=AFPM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > bpf_msleep_interruptible() puts a calling context into an
> > interruptible sleep.  This function is expected to be used
> > for testing only (perhaps in conjunction with fault-injection)
> > to simulate various execution delays or timeouts.
>
> I'm a bit worried that we'll be opening a bit too much of an
> opportunity to arbitrarily slow down kernel in a way that would be
> actually pretty hard to detect (CPU profilers won't see this, you'd
> need to rely on off-CPU profiling, which is not as developed as far as
> profilers go).
>
> I understand the appeal, don't get me wrong, but we have no way to
> enforce "is expected to be used for testing only". It's also all too
> easy to sleep for a really long time, and there isn't really any
> reasonable limit that would mitigate this, IMO.
>
> If I had to do this for my own testing/fuzzing needs, I'd probably try
> to go with a custom kfunc provided by my small and trivial kernel
> module (modules can extend BPF with custom kfuncs). And see if it's
> useful.
>
> One other alternative to enforce the "for testing only" aspect might
> be a custom kernel config, that would be expected to not make it into
> production. Though I'd start with the kernel module approach first,
> probably.
>
> P.S. BPF's "sleepable" is really "faultable", where a BPF program
> might wait (potentially for a long time) for kernel to fault memory
> in, but that's a bit more well-defined sleeping behavior. Here it's
> just a random amount of time to put whatever task the BPF program
> happened to run in the context of, which seems like a much bigger
> leap. So while we do have sleepable BPF programs, they can't just
> arbitrarily and voluntarily sleep (at least today).
>
> P.P.S. And when you think about this, we do rely on sleepable/trace
> RCU grace periods to be not controlled so directly and arbitrarily by
> any one BPF program, while here with bpf_msleep_interruptible() we'll
> be giving a lot of control to one BPF program to delay resource
> freeing of all other BPF programs (and not just sleepable ones, mind
> you: think sleepable hooks running non-sleepable BPF programs, like
> with sleepable tracepoints of uprobes).
>

I agree with the sentiment, but I think it's already possible such that
adding this will neither worsen or improve the status quo.

You can have a userfaultfd in user space, and do a bpf_copy_from_user
on the address such that you can trap the fault for as long as you
wish (with rcu_tasks_trace read section open) [0]. I used it in the
past to reconstruct race conditions.

  [0]: https://lore.kernel.org/bpf/20220114163953.1455836-11-memxor@gmail.c=
om.

So we probably need a solution to this problem even for 'faulting'
sleep, perhaps by scoping the read section to the program with SRCU,
or something similar.


> >
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > ---
> >  include/linux/bpf.h            |  1 +
> >  include/uapi/linux/bpf.h       |  9 +++++++++
> >  kernel/bpf/helpers.c           | 13 +++++++++++++
> >  kernel/trace/bpf_trace.c       |  2 ++
> >  tools/include/uapi/linux/bpf.h |  9 +++++++++
> >  5 files changed, 34 insertions(+)
> >
>
> [...]
>

