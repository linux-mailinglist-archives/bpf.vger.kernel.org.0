Return-Path: <bpf+bounces-46282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AA49E7522
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 17:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07887289AF7
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 16:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333C120CCD7;
	Fri,  6 Dec 2024 16:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4rKb0YF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E463BA20
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501354; cv=none; b=X50u0IZydOJNiOPudIY0FnP9K/sze9IBI0iylHPQOdd/jdo7wRiB3XTMdWXRD9XLBocWCalNSfnvUAwNlHnaiFzcw4/t+0E+yT7onnP8ReTw8RCPo+g9MMG+i4J2uNRmt113X7T8lcFYs3ZTC4gd+b6efEPs3yftrClC0c+wl+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501354; c=relaxed/simple;
	bh=nyz4cGVt64B4nS9D4fxFdx7z6QSehzcUv8RC8guMdVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIyxf3kISc60Teo8EEkgttwz59OpauQFblvndlI1GVAWc7edZmM3evZeirajIrDXVcedwAWrgacx5JZhAj6SMCTE4iyHTjZFqCl9ickgWhLLTxZiEDxzZS4lGKeMvXlmojW6eGpI4PX5H6s7kMplhl5fOvN9BNCKzzzd4gYe5C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4rKb0YF; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ef714374c0so564572a91.0
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 08:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733501352; x=1734106152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyz4cGVt64B4nS9D4fxFdx7z6QSehzcUv8RC8guMdVM=;
        b=d4rKb0YF2mZSepowy/HWqhrjvRf/SgfBMjktP3qYVaPsBrdys8r99mFW/8V5EVR2qq
         IbEWauIVNrfAJhIgT8wPcHT/ENH/X1+nSjA27GgW0wN4cZ4QThmifZHS/FB1tLRHQbkF
         F68AIEnTC8923h7kZ7kGO2zOH6UKtm64u1+sxoaxoDcoJzG9+MTCjHmpLJW5qN/fNQzD
         9fCEH3jeOGTcR9IDwo+nd+l3ZLCcMY9mN/LnmqUEuk+usfRy6j6jLP1XdgbOCCBuV03n
         CAxD7J+h+QCM3uai7PMv9u6uXOk4LbEMLfXxjWZSiSjI+aRGhZK6YCMmVisceFa2aJ6g
         QDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733501352; x=1734106152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyz4cGVt64B4nS9D4fxFdx7z6QSehzcUv8RC8guMdVM=;
        b=Ub2LRvm3Rqm3yIsC7v1MBd1qFBl5k5h9/RArwbahRYL1uRchYVhxwIHKIXM6Cnbzsr
         0SX9/+fLixZfueIw9ZzJOdC+NpJcPRQOHRN650khucF1jXEzdoJ7kEpPkVYAK8SKI4wL
         sHkpAs+H6jXHRuUAMHqp/boVzuQkTLpFBaH4zi7VAVTlm/Gu8xFoUGAcQO7kSLIkVb/c
         bznPHrWsuDbyTQQdO9j8Z+l//nYVUTWHwRsXAArrfRiFD2bTomYl4Egykez7YkL982g2
         LECjxK2lYsza6jH8JMuRvWfmrbpNUgw3xbi4siHiNtplLFFuV74oEX8lhR7evNL6RZet
         p18g==
X-Forwarded-Encrypted: i=1; AJvYcCUmwnWnzG9WiIpjAcnE4PdlJRUDfvZLJwiFmJ1mOEKjxP2SxtKiA7+JYlWoJpmPMQ2KF9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdgJ/b/3K2Xbz3xEXtHGCBWLqnMQMYZ3s2Qr3ku0119WcE3TAR
	OyhjZZ2ShKn1nrk2Gle88Z4cJ9Uf/He5XM96RbEBVMD1YOmBwFtPeTBVTdTUONlElokM/jOQ4iK
	4brie6vKKNIkhO79B4gkDmeFRP6E=
X-Gm-Gg: ASbGncuWg2m+FmNtOU5eigDGZD/IAR797111buiDMyS+PoYXle+/+5SeAgdx66apzOc
	1b3BoX/32DjZOg0HsxXyzjNEIMg2HtGdg
X-Google-Smtp-Source: AGHT+IEAJfL9AO239adRW3PUeR2S1E2q4x/mCTr8M4tiXAc5VJOu3PIHxtmC0hZKluFnXcQlzpmsJ+6cCtVwLACIxSw=
X-Received: by 2002:a17:90a:778a:b0:2ee:8253:9a9f with SMTP id
 98e67ed59e1d1-2ef41c71cb6mr12189385a91.11.1733501352162; Fri, 06 Dec 2024
 08:09:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com>
 <1b8e139bd6983045c747f1b6d703aa6eabab2c82.camel@gmail.com>
 <47f2a827d4946208e984110541e4324e653338e0.camel@gmail.com>
 <CAEf4BzZBPp40E-_itj1jFT2_+VSL9QcqjK4OQvt6sy5=iJx8Yw@mail.gmail.com>
 <4bbdf595be6afbe52f44c362be6d7e4f22b8b00f.camel@gmail.com>
 <CAADnVQKscY7UC-5nAYxaEM4FQZGiFdLUv-27O+-qvQqQX0To5A@mail.gmail.com>
 <1f77772b8c8775b922ae577a6c3877f6ada4a0a1.camel@gmail.com>
 <CAEf4BzZybLU0bmYJqH2XJYG_g8Pvm+STRdHBtE1c5zbhHvtrcg@mail.gmail.com> <1f49e00de4e5a17740e4e04ddb77b60e5ff46526.camel@gmail.com>
In-Reply-To: <1f49e00de4e5a17740e4e04ddb77b60e5ff46526.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Dec 2024 08:08:58 -0800
Message-ID: <CAEf4BzZ1239ec_J33jZj3Ji6-6W_PspVeKu05L6S729-_g6GMw@mail.gmail.com>
Subject: Re: Packet pointer invalidation and subprograms
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	andrii <andrii@kernel.org>, Nick Zavaritsky <mejedi@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 2:44=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Thu, 2024-12-05 at 22:22 -0800, Andrii Nakryiko wrote:
> > On Thu, Dec 5, 2024 at 8:07=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > On Thu, 2024-12-05 at 17:44 -0800, Alexei Starovoitov wrote:
> > > > On Thu, Dec 5, 2024 at 4:29=E2=80=AFPM Eduard Zingerman <eddyz87@gm=
ail.com> wrote:
> > > > >
> > > > > so I went ahead and the fix does look simple:
> > > > > https://github.com/eddyz87/bpf/tree/skb-pull-data-global-func-bug
> > > >
> > > > Looks simple enough to me.
> > > > Ship it for bpf tree.
> > > > If we can come up with something better we can do it later in bpf-n=
ext.
> > > >
> > > > I very much prefer to avoid complexity as much as possible.
> > >
> > > Sent the patch-set for "simple".
> > > It is better then "dumb" by any metric anyways.
> > > Will try what Andrii suggests, as allowing calling global sub-program=
s
> > > from non-sleepable context sounds interesting.
> > >
> >
> > I haven't looked at your patches yet, but keep in mind another gotcha
> > with subprograms: they can be freplace'd by another BPF program
> > (clearly freplace programs were a successful reduction of
> > complexity... ;)
>
> If there would be no general objections for the patch-set I posted,
> I'll do a v2 with an additional flag in bpf_prog_aux/bpf_func_info_aux
> to be checked when freplace attachment is done.
>
> > What this means in practice is whatever deductions you get out of
> > analyzing any specific original subprogram might be violated by
> > freplace program if we don't enforce them during freplace attachment.
> >
> >
> > Anyways, I came here to say that I think I have a much simpler
> > solution that won't require big changes to the BPF verifier: tags. We
> > can shift the burden to the user having to declare the intent upfront
> > through subprog tags. And then, during verification of that global
> > subprog, the verifier can enforce that only explicitly declared side
> > effects can be enacted by the subprogram's code (taking into account
> > lazy dead code detection logic).
>
> I considered tags, but didn't like it much for something so easily comput=
able.

The tags would be that generalizable side effect declaration approach,
so seems worth it to set a uniform approach.

> Please take a look at the patch, the change for check_cfg() is 32 lines.

I did, actually. And I already explained what I don't like about it:
eagerness. check_cfg() is not the right place for this, if we want to
support dead code elimination and BPF CO-RE-based feature gating.
Which your patches clearly violate, so I don't like them, sorry.

We made this eagerness mistake with global subprogs verification
previously, and had to switch it to lazy on-demand global subprog
validation. I think we should preserve this lazy approach going
forward.

>
> > We already take advantage of declarative tags for global subprog args
> > (__arg_trusted, etc), we can do the same for the function itself. We
> > can have __subprog_invalidates_all_pkt_pointers tag (and yes, I do
> > insist on this laconic name, of course), and during verification of
> > subprogram we just make sure that subprog was annotated as such, if
> > one of those fancy helpers is called directly in subprog itself or
> > transitively through any of *actually* called subprogs.
> >
> > All this will preserve the lazy approach we have with no need to look
> > ahead into subprog's implementation. I'd keep the concept of global
> > subprog completely and exhaustively described with its type signature
> > and associated tags as much as possible.
> >
> > P.S. We still need to keep in mind freplace complications, of course.
>
>

