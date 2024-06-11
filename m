Return-Path: <bpf+bounces-31857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A90904255
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 19:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EB9BB21C5F
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 17:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37754CB55;
	Tue, 11 Jun 2024 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3+hILZ6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1590142067;
	Tue, 11 Jun 2024 17:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126512; cv=none; b=Vsi30QYBOomy2obtLs7ptu0H0DrM0ZtSweQwhiyFbZ74WptgoK3Ga8wT3Ebzm1lV54cOTrPV95DMSz5W2gvNt05GhVj30G+HW4VEwkQh8/BQO5EdtE9KISR0frnOYM42ghodvAy0hEc8zcc9K4trSapSS/MLKZ+0qzvLtF34Ll0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126512; c=relaxed/simple;
	bh=Re33Xs/eGONOEGzf6oFi4DaY7yzw/y2jsRmTz2KK+Hc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Eoue9Kxi8f1gqVOq6Plab2mamhbiy69Y+DzPccM6jQOjbAOXSyUT3YOgQd6ro+Sh/WZLWu31jawn/V/1zwbXPMrt2LL4SFcY8Kxrjy4Y+LcGhelUyUEk8yZ108MHaoXGqSo9b3gAaT0W6ADvJsqcyp7qaeU+UJ5+GPsp1prI+bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3+hILZ6; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-701b0b0be38so5534916b3a.0;
        Tue, 11 Jun 2024 10:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718126510; x=1718731310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Re33Xs/eGONOEGzf6oFi4DaY7yzw/y2jsRmTz2KK+Hc=;
        b=Z3+hILZ6/v7VcNBQucAXRg3frG7fS74rfgdp9Ejb4WUth6E5tbG8pUZXwmJDgt/t4e
         +QyroEUI8xnTkUcWs81YcNh+Klu5uxFTj+8+daSJ9PYmLxPbsc18cs3NbXQBjieScPWb
         UngfNUcszq91LzWrxe8txM6vpLVJ+x2C9uVAscXfOKq20hVav9ZyULxKtdKt4hW7LpyG
         j9m27JBrJyLGH+aoI4lzqHKTBnL+k7u5do4O317I9PgN/bo13fowRwnmdQz0+v/UDkEl
         SvARmLoGXtXKS4GwVLAoz1HwP182Msc2GqTgBjFp4RJ0uM3YQO46j6MxyW6ed47KrbnC
         VlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718126510; x=1718731310;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Re33Xs/eGONOEGzf6oFi4DaY7yzw/y2jsRmTz2KK+Hc=;
        b=dex0EDQfNFIgjOJwJAHyPCxysaf1hINgj0C3shr0K1sVbTukA93/78SYCRcoKJbxNe
         S9+zp8z9gxuUXEYBG1fHTMQkp/KRrsKYM6frgIepCsIvTPC7nUaz8p8YY4P2qf6IQCJl
         4DFnMSB9X6WlwZuq6MmZQcjZP47b6/caRndjjRIiNOU+OwLcCPSFn2uaH9dhzoEVvCgg
         2WuEWzDYEmXBwBj63H03onahYmhSYH+rL9ewkXcVQHQMRgvIqt/3E3hKXYLQKw+4QD/h
         CWVM8fFlEHySfDbRKCqrY6H3FXPeivCu9/VaGW4yeTWF9vVkAB3Y1AIQX09rkw90u8jz
         R85A==
X-Forwarded-Encrypted: i=1; AJvYcCVkNeWfYLUpWhneLd4/HV+rwfPtdr7bjbmpxCgBJAXW88O9PjsBfkRsHXVetIpDPq6++W8BzXooqGqMZ0JSVAA+Oal5WJnWllgLxbgVrQ805plZCBvCqkhH9jP9
X-Gm-Message-State: AOJu0YxTK8Qri/ca7M/EWhGmy6IpInjpncNLLjUkCR/7aRnqcycsYj/+
	e0DcBzFFibnYpwLHX/k/A97jPQDkcqH7OTowL4VOqD53j3EWrt97
X-Google-Smtp-Source: AGHT+IG4LG6usQD4ZAdGrE6mToPj3zpx5uhz5DOJ28iTI0S0JbVvwI3JW/h7ZYi+nK4WJfat9lhRFQ==
X-Received: by 2002:a05:6a00:3cd6:b0:705:b922:2810 with SMTP id d2e1a72fcca58-705b92228f0mr765451b3a.28.1718126510174;
        Tue, 11 Jun 2024 10:21:50 -0700 (PDT)
Received: from localhost ([98.97.41.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7041b841247sm7042938b3a.140.2024.06.11.10.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 10:21:49 -0700 (PDT)
Date: Tue, 11 Jun 2024 10:21:48 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Tom Herbert <tom@sipanda.io>, 
 Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, 
 deb.chatterjee@intel.com, 
 anjali.singhai@intel.com, 
 namrata.limaye@intel.com, 
 mleitner@redhat.com, 
 Mahesh.Shirshyad@amd.com, 
 tomasz.osinski@intel.com, 
 jiri@resnulli.us, 
 xiyou.wangcong@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 vladbu@nvidia.com, 
 horms@kernel.org, 
 khalidm@nvidia.com, 
 toke@redhat.com, 
 victor@mojatatu.com, 
 pctammela@mojatatu.com, 
 Vipin.Jain@amd.com, 
 dan.daly@intel.com, 
 andy.fingerhut@gmail.com, 
 chris.sommers@keysight.com, 
 mattyk@nvidia.com, 
 bpf@vger.kernel.org, 
 Jonathan Corbet <corbet@lwn.net>, 
 Oz Shlomo <ozsh@nvidia.com>
Message-ID: <666887ac7b76c_10ea2081a@john.notmuch>
In-Reply-To: <CAOuuhY8+0eMJ_vQW=WgF1dCTLRaN+RARPB9q1RMqvRwv45awzw@mail.gmail.com>
References: <20240410140141.495384-1-jhs@mojatatu.com>
 <20240611072107.5a4d4594@kernel.org>
 <CAM0EoMkAQH+zNp3mJMfiszmcpwR3NHnEVr8SN_ysZhukc=vt8A@mail.gmail.com>
 <20240611083312.3f3522dd@kernel.org>
 <CAM0EoMkgxXX4sFJ98n_UTLLFjP3KHx00aaq76t4zJJsO9zNO4A@mail.gmail.com>
 <CAOuuhY8+0eMJ_vQW=WgF1dCTLRaN+RARPB9q1RMqvRwv45awzw@mail.gmail.com>
Subject: Re: [PATCH net-next v16 00/15] Introducing P4TC (series 1)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tom Herbert wrote:
> On Tue, Jun 11, 2024 at 8:53=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> >
> > On Tue, Jun 11, 2024 at 11:33=E2=80=AFAM Jakub Kicinski <kuba@kernel.=
org> wrote:
> > >
> > > On Tue, 11 Jun 2024 11:10:35 -0400 Jamal Hadi Salim wrote:
> > > > > Before the tin foil hats gather - we have no use for any of thi=
s at
> > > > > Meta, I'm not trying to twist the design to fit the use cases o=
f big
> > > > > bad hyperscalers.
> > > >
> > > > The scope is much bigger than just parsers though, it is about P4=
 in
> > > > which the parser is but one object.
> > >
> > > For me it's very much not "about P4". I don't care what DSL user pr=
efers
> > > and whether the device the offloads targets is built by a P4 vendor=
.
> > >
> >
> > I think it is an important detail though.
> > You wouldnt say PSP shouldnt start small by first taking care of TLS
> > or IPSec because it is not the target.
> >
> > > > Limiting what we can do just to fit a narrow definition of "offlo=
ad"
> > > > is not the right direction.
> =

> Jamal,
> =

> I think you might be missing Jakub's point. His plan wouldn't narrow
> the definition of "offload", but actually would increase applicability
> and use cases of offload. The best way to do an offload is allow
> flexibility on both sides of the equation: Let the user write their
> data path code in whatever language they want, and allow them offload
> to arbitrary software or programmable hardware targets.

+1.
 =

> =

> For example, if a user already has P4 hardware for their high end
> server then by all means they should write their datapath in P4. But,
> there might also be a user that wants to offload TCP keepalive to a
> lower powered CPU on a Smartphone; in this case a simple C program
> maybe running in eBPF on the CPU should do the trick-- forcing them to
> write their program in P4 or even worse force them to put P4 hardware
> into their smartphone is not good. We should be able to define a
> common offload infrastructure to be both language and target agnostic
> that would handle both these use cases of offload and everything in
> between. P4 could certainly be one option for both programming
> language and offload target, but it shouldn't be the only option.

Agree major benefit of proposal here is it doesn't dictate the
language. My DSL preference is P4 but no need to push that here.

> =

> Tom

My $.02 Jakub's proposal is a very pragmatic way to get support for P4
enabled hardware I'm all for it. I can't actually think up anything
in the P4 hardware side that couldn't go through the table notion
in (7). We might want bulk updates and the likes at some point, but
starting with basics should be good enough.

> =

> > >
> > > This is how Linux development works. You implement small, useful sl=
ice
> > > which helps the overall project. Then you implement the next, and
> > > another.

+1.

> > >
> > > On the technical level, putting the code into devlink rather than T=
C
> > > does not impose any meaningful limitations. But I really don't want=

> > > you to lift and shift the entire pile of code at once.
> > >

devlink or an improved n_tuple (n_table?) mechanism would be great.
Happy to help here.

> >
> > Yes, the binary blob is going via devlink or some other scheme.
> >
> > > > P4 is well understood, hardware exists for P4 and is used to spec=
ify
> > > > hardware specs and is deployed(See Vipin's comment).
> > >
> > > "Hardware exists for P4" is about as meaningful as "hardware exists=

> > > for C++".
> >
> > We'll have to agree to disagree. Take a look at this for example.
> > https://www.servethehome.com/pensando-distributed-services-architectu=
re-smartnic/
> >
> > cheers,
> > jamal
> =

