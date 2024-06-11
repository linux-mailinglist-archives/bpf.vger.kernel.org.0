Return-Path: <bpf+bounces-31854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 984D6904170
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 18:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2460B1F22D30
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 16:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEE844C6E;
	Tue, 11 Jun 2024 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipanda-io.20230601.gappssmtp.com header.i=@sipanda-io.20230601.gappssmtp.com header.b="QeAZmlSm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09737433D8
	for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718123684; cv=none; b=ZyyPXo474fuz0h+8i2ZmXp5NbqQTwdtrJw1JfRP35L4c5YCnrInZ1vGcgtvQNsHJaJrU776GImhVkwbm48Mk1zN4IUGuwGo05XkZraYOMMpov2++lki5BCp/nUGFQ4WeGlWFg9MN0iANbW36ozLzTwWxD/Lv9xPVHkQ6TkQWtSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718123684; c=relaxed/simple;
	bh=8Ulo7ggOWrqywEhniqqpoRZWbsLDBzQE9PCy3Vb0/4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFkHF/8nvGYv4jzf1igHI2QuETwc96UNSdqL2MT32P9W94+oTWM9DH29Ady0YaWEJ+Uss0PRI0DgWtMsE49WJuvVs0AZ7de8kyUsERCkkejotlNAV4qZYvtjSa/Rny4Op5SJE2PCnZgcoBBm0LBjHWptw7qcDXqCLoJPAdMZHxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sipanda.io; spf=pass smtp.mailfrom=sipanda.io; dkim=pass (2048-bit key) header.d=sipanda-io.20230601.gappssmtp.com header.i=@sipanda-io.20230601.gappssmtp.com header.b=QeAZmlSm; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sipanda.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipanda.io
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-80b13c93a0eso5579241.0
        for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 09:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sipanda-io.20230601.gappssmtp.com; s=20230601; t=1718123682; x=1718728482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ulo7ggOWrqywEhniqqpoRZWbsLDBzQE9PCy3Vb0/4Q=;
        b=QeAZmlSmaRbXG0qsIGgK01YfaP5GzVKIQL+X6SpKTfbWQujB0SbZCqHWHAe0GpZ9J5
         uwavvTbPQn4G70S1Z9XkH9hfC0qq8GlatgP+G7WSEBUC+slgIR6QF0XoK/jEk9TXMoBu
         sjx92ZkEIQM9zf9YU9gYyF1DoKO2LQFylvTZPhS9pc2Wtt8TZ92J5O3TAj1oQUeOtYwa
         NffXQ/b8ovgJWCqIQTlmYKYoR4rlFXG5ouJ23kBUkzzUP5Tp4YbNPvOWzJiHPuCEv7Rn
         nmg8oi3mOwptdldNJeaAkvpiA10nTFbpQeJ1VCf8H3Nfao+cZ6vfZSHrQ6Obs8lL2ap4
         Iejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718123682; x=1718728482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ulo7ggOWrqywEhniqqpoRZWbsLDBzQE9PCy3Vb0/4Q=;
        b=Swa6HTaYBQd2O/SjjyS2KhNcaYftvuwLgwIZhwoQ6Ujjt0DLtneAxBZzdfEWxIywrn
         kPqUsBPDH+PELeBm/vsefvyqnTv3RxsRh8akWXLGw36C7HxMAVVa/U8XrDMcu9t3Ud/m
         fiPy4VtZguNgJBzgsihUnK+hvABIH6B8tlyMy60cfOSqXFlBKRIHFw8oUGYkPN5JwOUC
         U4FvABCRSFmS7WbB5QdBtxqYuFl2OYb62i2BRMZfB74uGfOtAGzU8ukhGJj6bm8d4a82
         S99CoBexzfXtsgJUh/5wt303vmbuRIC9qLajOrrPx04xm/aNRNgEt01nGQOaf0DiAU0m
         E1qA==
X-Forwarded-Encrypted: i=1; AJvYcCUDC7V+daKseyeg6Eebd3cwQiBW+QqZXQ1KQxEcIlD9RcxVBF9zmWKeGnB8YLybrB2GVhjdPx9BKI5NCpRzDIENdCR7
X-Gm-Message-State: AOJu0YxBpFO4qPBvKH1X2d9hLu3TzgfX9cIdrIX6Q4oOTcn/mUYyZ7dm
	C3Ro4kR4frjLIL5xxzXDeeeQlMy4a/VJOqLVDCBDTwLldjlAiOpYtJWLKGb1eccvLG4AzpD2Cw4
	XzWwMoGevEojdgNDDYcam3yzKSL9TlUFcjzo3yw==
X-Google-Smtp-Source: AGHT+IHLRAfRnVGeaP99D6Ed8C47lKkrRoSJqXwcEtivpWPgBwpJLUqGVL/NHD48yoRgcjXQPGyQrgwS6sFi5p2K96M=
X-Received: by 2002:a05:6122:1076:b0:4ec:fc6b:b473 with SMTP id
 71dfb90a1353d-4ecfc6bb6cbmr1420963e0c.8.1718123680568; Tue, 11 Jun 2024
 09:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410140141.495384-1-jhs@mojatatu.com> <20240611072107.5a4d4594@kernel.org>
 <CAM0EoMkAQH+zNp3mJMfiszmcpwR3NHnEVr8SN_ysZhukc=vt8A@mail.gmail.com>
 <20240611083312.3f3522dd@kernel.org> <CAM0EoMkgxXX4sFJ98n_UTLLFjP3KHx00aaq76t4zJJsO9zNO4A@mail.gmail.com>
In-Reply-To: <CAM0EoMkgxXX4sFJ98n_UTLLFjP3KHx00aaq76t4zJJsO9zNO4A@mail.gmail.com>
From: Tom Herbert <tom@sipanda.io>
Date: Tue, 11 Jun 2024 09:34:30 -0700
Message-ID: <CAOuuhY8+0eMJ_vQW=WgF1dCTLRaN+RARPB9q1RMqvRwv45awzw@mail.gmail.com>
Subject: Re: [PATCH net-next v16 00/15] Introducing P4TC (series 1)
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, deb.chatterjee@intel.com, 
	anjali.singhai@intel.com, namrata.limaye@intel.com, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, 
	toke@redhat.com, victor@mojatatu.com, pctammela@mojatatu.com, 
	Vipin.Jain@amd.com, dan.daly@intel.com, andy.fingerhut@gmail.com, 
	chris.sommers@keysight.com, mattyk@nvidia.com, bpf@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Oz Shlomo <ozsh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 8:53=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Tue, Jun 11, 2024 at 11:33=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >
> > On Tue, 11 Jun 2024 11:10:35 -0400 Jamal Hadi Salim wrote:
> > > > Before the tin foil hats gather - we have no use for any of this at
> > > > Meta, I'm not trying to twist the design to fit the use cases of bi=
g
> > > > bad hyperscalers.
> > >
> > > The scope is much bigger than just parsers though, it is about P4 in
> > > which the parser is but one object.
> >
> > For me it's very much not "about P4". I don't care what DSL user prefer=
s
> > and whether the device the offloads targets is built by a P4 vendor.
> >
>
> I think it is an important detail though.
> You wouldnt say PSP shouldnt start small by first taking care of TLS
> or IPSec because it is not the target.
>
> > > Limiting what we can do just to fit a narrow definition of "offload"
> > > is not the right direction.

Jamal,

I think you might be missing Jakub's point. His plan wouldn't narrow
the definition of "offload", but actually would increase applicability
and use cases of offload. The best way to do an offload is allow
flexibility on both sides of the equation: Let the user write their
data path code in whatever language they want, and allow them offload
to arbitrary software or programmable hardware targets.

For example, if a user already has P4 hardware for their high end
server then by all means they should write their datapath in P4. But,
there might also be a user that wants to offload TCP keepalive to a
lower powered CPU on a Smartphone; in this case a simple C program
maybe running in eBPF on the CPU should do the trick-- forcing them to
write their program in P4 or even worse force them to put P4 hardware
into their smartphone is not good. We should be able to define a
common offload infrastructure to be both language and target agnostic
that would handle both these use cases of offload and everything in
between. P4 could certainly be one option for both programming
language and offload target, but it shouldn't be the only option.

Tom

> >
> > This is how Linux development works. You implement small, useful slice
> > which helps the overall project. Then you implement the next, and
> > another.
> >
> > On the technical level, putting the code into devlink rather than TC
> > does not impose any meaningful limitations. But I really don't want
> > you to lift and shift the entire pile of code at once.
> >
>
> Yes, the binary blob is going via devlink or some other scheme.
>
> > > P4 is well understood, hardware exists for P4 and is used to specify
> > > hardware specs and is deployed(See Vipin's comment).
> >
> > "Hardware exists for P4" is about as meaningful as "hardware exists
> > for C++".
>
> We'll have to agree to disagree. Take a look at this for example.
> https://www.servethehome.com/pensando-distributed-services-architecture-s=
martnic/
>
> cheers,
> jamal

