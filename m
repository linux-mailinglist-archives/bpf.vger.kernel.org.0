Return-Path: <bpf+bounces-54401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1839DA699A7
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 20:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E85F7AB4C5
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 19:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D792144C9;
	Wed, 19 Mar 2025 19:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lH6rwQhR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315561DE8BF;
	Wed, 19 Mar 2025 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742413450; cv=none; b=Ayd1GmVAvEuIJ4qGh7OwXy7rhoRKijqVXw1/pj/oQQn0rOrGeJAYv2Bmg5mCsUjmKowiwzsad52Y23JAZlpew7F/3AzLg7NrWdgXdfCwIcb/DWX1I6FO8vMjGvetqgyGch26iDvVIquYU55/kawBwQ5KLbQi0L7fZ7pJLsB2CMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742413450; c=relaxed/simple;
	bh=lLaat7az9MH7ezrPmTZOat/1ILwtVsbzCqb6WBBS0xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=peEx9nBrcVl8cN+CeIFSO0A/Hx4P9M2U5RLDow0HkUbHPU/OAKBAZ/zlrKCOW0WMEXJ9gWX9ImhNq10FSkCLXGRwCtJcf3IV97/PKDEhTucAmJOXxiRMqLnXNMhYx1o3QgDdVCwa1I2UbbHGQtBQYnQF7uvrtbAKE9XHSl0dbMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lH6rwQhR; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30761be8fcfso900111fa.0;
        Wed, 19 Mar 2025 12:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742413446; x=1743018246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhYCmAWKpYLqMT/P3WekE89t5CCM6z3es1ZH5Zq+OZE=;
        b=lH6rwQhRqerh4Is+DTiJ02aPWFisBvD6Qit2LeRTKMkx4DxS9tUvESarSidTFULtaa
         KyDwPDm2EiQJvJ1TfYtGnjiS4+gIxjlP3FyyzmiyhFUecLSf4T8badx+oThL9q+NPhdv
         4AM1TQVyouq7+CzeFablf0+klkhAIA75sWpFjM2vMsmXIjuj3V6QdhPef0FkvRCAvvwD
         RVh8/dwpEpkupx9vlB7bycVzxsLxn/sG0y7KjzP7UtFzzfBHSTzHYomW1OwiNMft0N/G
         YU7npD9BarQsXsl6wK+n3sobnYrOyUUKUzST2HW8JvartW16yWq7FNC0HjVxpMbROw31
         rDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742413446; x=1743018246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhYCmAWKpYLqMT/P3WekE89t5CCM6z3es1ZH5Zq+OZE=;
        b=NF0IxbWIvukcAHg12Nlyuna6izgv6APFfW3WLq0Or28W9xpvYj0vTBh5xALUWZQGZ2
         0NWEeHVmy3GtFNdSUoUJLslJFEn07Lz0oDjHJZuI44Y89E8WJPPPcFz4o/JamuBrerjq
         JMHEJwUUtV+MU7glIs/MDv+VKgcDm7PSwCKD11foRfTH9u0gFwoLd/XdpeSazJmjCn5L
         FwQWCH6HS5YfFDdtYZoH/YwYR8ek6nlXSIHlqta+fVMtFGF7G/qr/w1QrpvCIc3REIxG
         +tloAK/sAZeJb7lxwqBKmjZgTyWtIqr+YG79MDGH7tCSwPOH9Cew70cIgh1hUl/nzl1w
         CD4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIp0FfPmrSkNSuuO8OL2jKMc0S9r4+jjmw7Dkk1toyeIWG6ajw7MiM6gTvSsOY88hhFcoRyb77D2jGPQ==@vger.kernel.org, AJvYcCXFVZGbhfXAXWqUTsQaPJjIOXgobe3iumRA1J+2qKboliW6CtslbCJHnVrpvjquRVLXXmE=@vger.kernel.org, AJvYcCXSVrfNdRR1+1EolQiV3Oly5PS2BM8bM9Qkq/4wLku9D76JdUcsK7ynSEgRm7VyNq5Ltx0wuHGG@vger.kernel.org, AJvYcCXfFlIRME9iJ02AwKQwodCbW6nhPzl+guzriAENLbBJVySI+fq3OUId44SyOmAXA/fwkB0vAFulvoPrXGCe@vger.kernel.org
X-Gm-Message-State: AOJu0YyqBCN8RmWY4e33lXp8qxLR5ot3gRB/lBxgjmaWkBvrp0E4Q1pi
	704lpiT/itP6msAJU3msIS1NJIoylFQ6/DDMFzI5s/XllZZ2g5i+lBgXYxsqF4sM1sw9bVmbMMa
	aBPa5QDznTUIxkQReU3yhSf202+YhoeaJ2S7XpQ==
X-Gm-Gg: ASbGncsoM4uuZtXAQ9c+ZXGdKdzWYKG76GrKQHh6sXV128rEjIvYCIVLcBkIyDtv4xa
	P3mi07shB3dzrZMTMdziAxQq/1HGpsHfbftE0oXPi5oL+Yg1hLlGF1gml/KB5x/XooJEkmUCpMU
	IFmR7YWaeN01QaAJNrv7rWFeEVug==
X-Google-Smtp-Source: AGHT+IEqb8DYNNrbGP7rciW1niUuSjBxj6+DvYT/JveS26p0kxZ66Mnhoo+Sfd+hkXEbRXMLTPNGW4rQ78klTXJrpGI=
X-Received: by 2002:a05:651c:2119:b0:30b:bf6f:66a3 with SMTP id
 38308e7fff4ca-30d6a40c9b2mr17799441fa.17.1742413445934; Wed, 19 Mar 2025
 12:44:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319133309.6fce6404@canb.auug.org.au> <CAADnVQKotSrp8CkVpFw-y800NJ_R7An-iw-twrQZaOdYUeRtqQ@mail.gmail.com>
 <CAP01T76CqOxzEiMLKJ2y_YD=qDgWq+Fq5Zy-fnKP4AAyS30Dwg@mail.gmail.com>
 <CAP01T77_qMiMmyeyizud=-sbBH5q1jvY_Jkj-QLZqM1zh0a2hg@mail.gmail.com>
 <CAP01T77St7cpkvJ7w+5d3Ji-ULdz04QhZDxQWdNSBX9W7vXJCw@mail.gmail.com>
 <CAADnVQ+8apdQtyvMO=SKXCE_HWpQEo3CaTUwd39ekYEj-D4TQA@mail.gmail.com>
 <CAFULd4brsMuNX3-jJ44JyyRZqN1PO9FwJX7N3mvMwRzi8XYLag@mail.gmail.com> <CAADnVQ+7GTN0Tn_5XSZKGDwrjW=v3R6MyGrcDnos2QpkNSidAw@mail.gmail.com>
In-Reply-To: <CAADnVQ+7GTN0Tn_5XSZKGDwrjW=v3R6MyGrcDnos2QpkNSidAw@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 19 Mar 2025 20:43:53 +0100
X-Gm-Features: AQ5f1JoUJCMzHHENT_TDzaIDzJZhTJniayHR3OV_fr-rf4VmnbYHKYqMpdSbmXo
Message-ID: <CAFULd4aHiEaJkJANNGwv1ae7T0oLd+r9_4+tozgAq0EZhS16Tw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 7:56=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Mar 19, 2025 at 9:06=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> w=
rote:
> >
> > On Wed, Mar 19, 2025 at 3:55=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Mar 19, 2025 at 7:36=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > > >
> > > > > > I've sent a fix [0], but unfortunately I was unable to reproduc=
e the
> > > > > > problem with an LLVM >=3D 19 build, idk why. I will try with GC=
C >=3D 14
> > > > > > as the patches require to confirm, but based on the error I am =
99%
> > > > > > sure it will fix the problem.
> > > > >
> > > > > Probably because __seg_gs has CC_HAS_NAMED_AS depends on CC_IS_GC=
C.
> > > > > Let me give it a go with GCC.
> > > > >
> > > >
> > > > Can confirm now that this fixes it, I just did a build with GCC 14
> > > > where Uros's __percpu checks kick in.
> > >
> > > Great. Thanks for checking and quick fix.
> > >
> > > btw clang supports it with __attribute__((address_space(256))),
> > > so CC_IS_GCC probably should be relaxed.
> >
> > https://github.com/llvm/llvm-project/issues/93449
> >
> > needs to be fixed first. Also, the feature has to be thoroughly tested
> > (preferably by someone having a deep knowledge of clang) before it is
> > enabled by default.
>
> clang error makes sense to me.

It is not an error, but an internal compiler error. This should never happe=
n.

> What does it even mean to do addr space cast from percpu to normal addres=
s:
>
> __typeof__(int __seg_gs) const_pcpu_hot;
> void *__attribute____UNIQUE_ID___addressable_const_pcpu_hot612 =3D
>     (void *)(long)&const_pcpu_hot;

Please see [1] for an explanation.

[1] https://gcc.gnu.org/onlinedocs/gcc/Named-Address-Spaces.html#x86-Named-=
Address-Spaces

Uros.

