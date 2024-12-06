Return-Path: <bpf+bounces-46245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FD59E6747
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 07:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DC5283989
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 06:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5071DB361;
	Fri,  6 Dec 2024 06:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2u6MaeU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E7617CA1D
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 06:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733466193; cv=none; b=dcvdCyfdD77fgnQLZ1y879X3k4zSpFQ6Vrr1i3IS6VpfrfNT0Bcc3LWTh4bYk8uqWqjb6epjndb7W2+BC/sYxUWE8YpbbyeYzsimNd0EKHLUC97gutEbDp3OMX3YzEU2NY3Xgc37h5iWnEEF5nPO7Imvf/EmadHysXk9JRpvZ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733466193; c=relaxed/simple;
	bh=3iNZCDSA9JXKxszVISOuoCBdKTqNBrPwf5exuYLtk18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWs+w2FHKr7BJxZtTeI62rDYDShXfri2zqR7nLL2ptRP1SoH5gTD95ZlOf9jmGc4E6qRdl+uo5O92BZa+TRD7MK/Prb5j91gvn6FRbpiSVa6WWap/V/Z8EGMSFBQ4laFynbqT3bIVAHFCDhDPRsIe1ZkZRrK2n+YDGq1NcGCecw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2u6MaeU; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7fc41b4c78bso1157936a12.3
        for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 22:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733466191; x=1734070991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iNZCDSA9JXKxszVISOuoCBdKTqNBrPwf5exuYLtk18=;
        b=A2u6MaeUoBRNrDfHLPaZ9OnvBN2z3YiD4/U76CVCZTp2GIPgJZe2CxawOvFbWJjMUV
         dbGhYpkOz6xYeuBJ5K8YG2FdtzEIxerkkFwe/KaFeFqy4Dm6CQqSFLjWCaJnvGo1dYRa
         dZzjk8tOJaWSbzybFrFx4ObR26ukrTEvm31TQ62UIAKSZX//oDrLvnbHH+/0Ypr3RH+v
         CreHe2RuZWZXx34NFSI5+6fT0BGaPMYd80C+qDeRJ1ItNqeZ4TmVwb5+VZ/6KSq6e19A
         UThUzJEtxBq3rz5/jQsaKaEDv9OIPB2qfzB8M6FPOSoFrNwKaV3y7HyYiK7KbSlu5dlc
         +qNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733466191; x=1734070991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3iNZCDSA9JXKxszVISOuoCBdKTqNBrPwf5exuYLtk18=;
        b=Reie0m38sIvAqGmGxv6MGPhHayPWsQ8s8MHS/Hk7f8dS5Xz7dRp9VihY6ZjqAk4oVm
         9V/w1NRM9jMWgWPl2jLTXrShg6om2FYy2R66U7bFBK/vpyzMG/0dYXhiH9jI+WxU9Xg4
         YULSJ4biy6sHzMu2AkbFK0pHGBPd3tuuZ8AaGMqXDVhszHJ2g1p6NFiFsrH+n5yiNd1t
         bOpdh3QOSDh58KH74eWUoqC8UA3kaABa31GZwDRWdjoV9Df1x5oaZVZmcQfXlnWZfvoT
         Fmq91KHlMlXlkrsJSbeETsQx6qfEoLQOyEOY8ZCA3yCEFHL34/gGDjBKnnUTMIgyUhgk
         ZlUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+ITs0Je6/MypPtdMk6DxWVDj2Jde0QQG58oWzABtO3ySnusHxvpDot2KKVXsZrtB3Nmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy20Nnxlwk5wq/4rv7PeuiPNVYvVg3CelQepxyxgSXwPN7OvJXx
	T+gq8zRIfD7caTZdM7EGiYZCJjkflikdks7FS18MRl4Jd6PVh08yjUccOEx3aC/hMaZlcYBoNgS
	JXeESdyBLAgqPJJtPbDQU+ONIUtE=
X-Gm-Gg: ASbGncsKdyXuXToIYdrX2eoFg32jqm8ndi4Z0PxkTuypKdY6IMi4lmb+MMsraPImo8c
	kAw319oiP8mfnu45z9FlZY8luA6AxhR5W
X-Google-Smtp-Source: AGHT+IFK9FfLxr4FhmqK1nQSazy7xhtzyGVno7LsksAmFTr1e+zUj4ipnZvSjT46/SEQFeiOnASX/u/+CH5BTSQhLZg=
X-Received: by 2002:a17:90b:4f46:b0:2ee:eb5b:6e06 with SMTP id
 98e67ed59e1d1-2ef6aaf3a46mr2965250a91.36.1733466191434; Thu, 05 Dec 2024
 22:23:11 -0800 (PST)
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
 <CAADnVQKscY7UC-5nAYxaEM4FQZGiFdLUv-27O+-qvQqQX0To5A@mail.gmail.com> <1f77772b8c8775b922ae577a6c3877f6ada4a0a1.camel@gmail.com>
In-Reply-To: <1f77772b8c8775b922ae577a6c3877f6ada4a0a1.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Dec 2024 22:22:59 -0800
Message-ID: <CAEf4BzZybLU0bmYJqH2XJYG_g8Pvm+STRdHBtE1c5zbhHvtrcg@mail.gmail.com>
Subject: Re: Packet pointer invalidation and subprograms
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	andrii <andrii@kernel.org>, Nick Zavaritsky <mejedi@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 8:07=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Thu, 2024-12-05 at 17:44 -0800, Alexei Starovoitov wrote:
> > On Thu, Dec 5, 2024 at 4:29=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > so I went ahead and the fix does look simple:
> > > https://github.com/eddyz87/bpf/tree/skb-pull-data-global-func-bug
> >
> > Looks simple enough to me.
> > Ship it for bpf tree.
> > If we can come up with something better we can do it later in bpf-next.
> >
> > I very much prefer to avoid complexity as much as possible.
>
> Sent the patch-set for "simple".
> It is better then "dumb" by any metric anyways.
> Will try what Andrii suggests, as allowing calling global sub-programs
> from non-sleepable context sounds interesting.
>

I haven't looked at your patches yet, but keep in mind another gotcha
with subprograms: they can be freplace'd by another BPF program
(clearly freplace programs were a successful reduction of
complexity... ;)

What this means in practice is whatever deductions you get out of
analyzing any specific original subprogram might be violated by
freplace program if we don't enforce them during freplace attachment.


Anyways, I came here to say that I think I have a much simpler
solution that won't require big changes to the BPF verifier: tags. We
can shift the burden to the user having to declare the intent upfront
through subprog tags. And then, during verification of that global
subprog, the verifier can enforce that only explicitly declared side
effects can be enacted by the subprogram's code (taking into account
lazy dead code detection logic).

We already take advantage of declarative tags for global subprog args
(__arg_trusted, etc), we can do the same for the function itself. We
can have __subprog_invalidates_all_pkt_pointers tag (and yes, I do
insist on this laconic name, of course), and during verification of
subprogram we just make sure that subprog was annotated as such, if
one of those fancy helpers is called directly in subprog itself or
transitively through any of *actually* called subprogs.

All this will preserve the lazy approach we have with no need to look
ahead into subprog's implementation. I'd keep the concept of global
subprog completely and exhaustively described with its type signature
and associated tags as much as possible.

P.S. We still need to keep in mind freplace complications, of course.

