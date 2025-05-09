Return-Path: <bpf+bounces-57869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94900AB1AB8
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 18:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BEB6522D1E
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 16:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6392367CD;
	Fri,  9 May 2025 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuLSLMh4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC2F2356B1
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746808787; cv=none; b=jsfalPrzZwCU26gCpaOy/8y0wmxr8VOO7miYhFUgTI2Bfr8aLC4AvWggk0nksh0qi/gxXoKh6HIkigQRRxWZzD9hdEtoqJERiorLirNRqSyH9OSXiS+ffE0k/qpOGCy1YFOs/lxj7uhtmkrHloI57VntWRgF/Ixq+ovLrJw9BAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746808787; c=relaxed/simple;
	bh=px8lI6B1ic6OxgBYu4jqru0N7vvIJfN3VpsoThmsm+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CE/5AAmx6A2qxe7XfWEkxuZIUj/mP5V3DbY53FEEgpX2FU9aZzYZwl8hMW2Uyzxo5Sz/IbI3H2qAwpocI6y06dMDUYIEnmLDfIJFq2/rdwwuDqeoPfKH0NYBWeaK2SAgsVEc8HcAKbf5DjagPTJS2SWMNlyhPHy0BajltF+TPB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuLSLMh4; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3995ff6b066so1317220f8f.3
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 09:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746808784; x=1747413584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTaeGmXdrgzLK5TSft/2X4dPURBFf84KN2PZogtx3UU=;
        b=HuLSLMh4eLY2SGI4eH0e2m7scf4xRRrLKET2GEfhb99t9UtV+DgBZwx9ujxcNd0QC1
         hFVtFD/4YYpTtqrVS7HYl2g8z0wA3IXMCrNKPxVucQ1GtmMELLE1pPqIlNRjJzUE9UYA
         MZMUnMbSB5Yr3wD6d5OS2qt336P1g9iPuBRY/iXJ5ph2yexEPkzNWHMoG91JbiLIN3qG
         A5rq6lob/AkqF1IYekbNDpegIucyN8omnSOLOy7uPgcfIzpSa3mYSLoMCxyeoXHoWsqp
         kMSYfeGJuQB4QucNMNhiiL1GnIUFwc34VM3P3MN//2+ETemDPn23MoOx1auvc7uyBona
         73wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746808784; x=1747413584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTaeGmXdrgzLK5TSft/2X4dPURBFf84KN2PZogtx3UU=;
        b=fxz0d7rmeutqTyeHn8wjcokqfVuXUP3OhVnXTdSRm/VIPEvzi5/Kf3Sd90eFg4ff8k
         btPAcrZH6UKgCuYyzpqNlznp0sRlAd2oVvW+4ITqHzIgLXLUCjIizCGj4otNnN9jfkbz
         IMjQJsIHx1XPUIX4Wyya7ucSj/ySpSkmttnjhoR4mSKMbNv3iIuwpUvqoqILi7ebDWI8
         z/LH24wZ9oVhZPcUyVirmvQ2HDuQ6v3zHqCUbNGRbYrZCbN2vvg+ovro758KFjMnzLRM
         TnIN1C2ZbPh7ETYUAKYCG4PE1wOxDReIb4huxqgm1DhEz4b9y5SfgYAQOphMxIXBvBnV
         SRZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIZS9ug9Ik4mzlfr6ap+sdbte2guDa0fjKqsP3bQmM8BHPSV3ijvxzWBj2y/OHq46JbO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw91wNb6dh7opno5xJJMKjGVELjStYyqDV+CASNKsHc15Vc0Fw5
	XyC9Jsnl0Ao3nm/F/f4GMmNqJ4u8fs4i1tlFZrg/AhOXCdggrPfjOkowt9wH5/S9g/VktXrLrjE
	IDBUoQnvYof34fI3LuDa6JXye1y8=
X-Gm-Gg: ASbGncsw9PA2h2WhgWvpsGTcdm+o9rGVeypvSiZA0XOjfjpsKZUO6CR+w8T++DCxL2q
	IM3tsf6WnYaQKlWSfR4Fstxx8hkaq0diJr+MuRdp5SoC7/S2ZJFgwyjX+Vid3hfH/8I4R2L2Ys7
	xalOlMKSqEYaOYaef3t8D22pzv2mMwZS/zFeOZP27OflXFV4vx
X-Google-Smtp-Source: AGHT+IHAnglJGL5lczgcbsrr3wk8yFvvytSgrb02vhAqLF4zDdwTY8LHHmqYXYldaQmzOT4nBwBaf82WOoAk6qX4oVE=
X-Received: by 2002:a05:6000:40df:b0:390:f394:6271 with SMTP id
 ffacd0b85a97d-3a1f64d8170mr3255075f8f.43.1746808783891; Fri, 09 May 2025
 09:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1746598898.git.vmalik@redhat.com> <19913411da8c08170d959207e28262efc0a5d813.1746598898.git.vmalik@redhat.com>
 <aBx8Zjux0bSgtV04@google.com>
In-Reply-To: <aBx8Zjux0bSgtV04@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 May 2025 09:39:32 -0700
X-Gm-Features: AX0GCFvmAdEr_vd55Lpb-nY1Pf_4PNLhg_X7zftmHqtt4lrV7cDqCtePDcDYEro
Message-ID: <CAADnVQ+pru+0cTbk-YXpAb4SdZeS+NL2TjLAXcrQya0RxBjFpg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/4] bpf: Add kfuncs for read-only string operations
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Viktor Malik <vmalik@redhat.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 2:42=E2=80=AFAM Matt Bobrowski <mattbobrowski@google=
.com> wrote:
>
> On Wed, May 07, 2025 at 08:40:38AM +0200, Viktor Malik wrote:
> > String operations are commonly used so this exposes the most common one=
s
> > to BPF programs. For now, we limit ourselves to operations which do not
> > copy memory around.
> >
> > Unfortunately, most in-kernel implementations assume that strings are
> > %NUL-terminated, which is not necessarily true, and therefore we cannot
> > use them directly in the BPF context. Instead, we open-code them using
> > __get_kernel_nofault instead of plain dereference to make them safe and
> > limit the strings length to XATTR_SIZE_MAX to make sure the functions
> > terminate. When __get_kernel_nofault fails, functions return -EFAULT.
> > Similarly, when the size bound is reached, the functions return -E2BIG.
>
> Curious, why was XATTR_SIZE_MAX chosen as the upper bounds here? Just
> an arbitrary value that felt large enough?
>
> > At the moment, strings can be passed to the kfuncs in three forms:
> > - string literals (i.e. pointers to read-only maps)
> > - global variables (i.e. pointers to read-write maps)
> > - stack-allocated buffers
> >
> > Note that currently, it is not possible to pass strings from the BPF
> > program context (like function args) as the verifier doesn't treat them
> > as neither PTR_TO_MEM nor PTR_TO_BTF_ID.
> >
> > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > Signed-off-by: Viktor Malik <vmalik@redhat.com>
> > ---
> >  kernel/bpf/helpers.c | 440 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 440 insertions(+)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index e3a2662f4e33..8fb7c2ca7ac0 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/btf_ids.h>
> >  #include <linux/bpf_mem_alloc.h>
> >  #include <linux/kasan.h>
> > +#include <linux/uaccess.h>
> >
> >  #include "../../lib/kstrtox.h"
> >
> > @@ -3194,6 +3195,433 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned=
 long *flags__irq_flag)
> >       local_irq_restore(*flags__irq_flag);
> >  }
> >
> > +/* Kfuncs for string operations.
> > + *
> > + * Since strings are not necessarily %NUL-terminated, we cannot direct=
ly call
> > + * in-kernel implementations. Instead, we open-code the implementation=
s using
> > + * __get_kernel_nofault instead of plain dereference to make them safe=
.
> > + */
>
> Returning an -EFAULT error code for supplied arguments which are
> deemed to be invalid is just a very weird semantic IMO. As a BPF
> program author, I totally wouldn't expect a BPF kfunc to return
> -EINVAL if I had supplied it something that it couldn't quite possibly
> handle to begin with. Look at the prior art, being pre-existing BPF
> kfuncs, and you'll see how they handle invalidly supplied arguments. I
> totally understand that attempting to dereference a NULL-pointer would
> ultimately result in a fault being raised, so it may feel rather
> natural to also report an -EFAULT error code upon doing some
> NULL-pointer checks that hold true, but from an API usability POV it
> just seems awkward and wrong.

I mostly agree with the above.

On the first look, all the checks like:
+       if (!s || !accept)
+               return ERR_PTR(-EFAULT);

looks like a premature optimization, since
__get_kernel_nofault() will handle it just fine.

But there is a different reason to do it and the error code
should probably be different.

Consider that copy_from_kernel_nofault() has the following check
that is meaningful on several architectures including x86:
        if (!copy_from_kernel_nofault_allowed(src, size))
                return -ERANGE;

It's there to avoid accidentally reading user addresses and
NULL is one such user address.

Doing it for every pointer inside the loop will hurt performance,
but doing it once in the beginning maybe ok?
If we want to optimize it we can introduce the helper:

static bool copy_maybe_allowed(const void *ptr)
{
#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
  if ((unsigned long)ptr < TASK_SIZE)
     return false;
#else
  if (!ptr)
     return false;
#endif
  return true;
}

and modify above as:
  if (!copy_maybe_allowed(s) || !copy_maybe_allowed(accept))
    return ERR_PTR(-ERANGE);

bikeshed: shorter/better name for helper..

