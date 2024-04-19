Return-Path: <bpf+bounces-27247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B13B68AB4B0
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 20:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9A71F21A50
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 18:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4224B13AD37;
	Fri, 19 Apr 2024 18:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="fsog5Vf/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E311E502
	for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713549700; cv=none; b=NDGSbtNoG5zjdU1+OX8LYIwrLbTWiEqu0lYhbT2y5d5XXn5M8e6FibE3ilJWAltb3D7jUo+v2I1b0tCS6XfN25K8rLmhXFdu78oWIKwAM/Q5eZfUn0eNGTfftxahJaWNvT09W4VMY+wDPoDgmZn8hzTeAfVisur1svzrVsYr/wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713549700; c=relaxed/simple;
	bh=8kekxm8Yx3Geb4y9E0X0FQ1vYR/DYIP6a1bEnb/VXBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UwCr8Ciba7OVQ+4Dw5JGA6zzGCL/w/Zlt6XcPeH5EJV2ogkS1viAecDCtIfl3DnwXanQ7gk6Vygi83mR2cJbzP0swzY81YpIceLY+9hgQGwjTJMXk6DCNwTsTurjhllA/b97Pre+Hm8XPCELpAT6MjxeVPa8f8Fecx5KtmrOUzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=fsog5Vf/; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-ddda842c399so2386895276.3
        for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 11:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1713549698; x=1714154498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZKv0qPX0PLba9CuD+UmXo7c2QNHJRapFN8pMZZC9+0=;
        b=fsog5Vf/qFYrJTN2++K50UXBd8Vf3NZcmwtMxrlI/ASjHcPoSajczk7yofyKeG34OY
         jLcvUaq3BxNY08dOfmkFsVogda7CLvTWOibVqJGA6YjISpGz4A4k54dGuhbJhfCYCFj3
         97P8mdjmlTH1p8wiRt1+kRGi9ZpU8sWbNiT9dQ0sxcm7Mv369L5BY+mf/LX6ATQ9azh9
         J5dVQ4tim2BGMQPToUFPAtS5B7ZUWJMrkFRtVi+Fbyuw1fegMJWpjNxWrc/CaM1q716B
         va6UgYKG5ySmLUxzVwiZrgbj0IhL7L4rHoCSerJlclQh1fHhzdqeHUllXCKj9SRhmGRG
         zW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713549698; x=1714154498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZKv0qPX0PLba9CuD+UmXo7c2QNHJRapFN8pMZZC9+0=;
        b=ZoWM4QaQvIkpsYxsDBApwvZMb2GnE124r3i2WIvCvQnPDW7QP3oSQN0Y+2+wPVyKiD
         X6JBKINSlTE6LHxn8t8HeEfRK2NbPVdHxwIGatN09IIWGtYehY9vKfqgV5zng8aD9Ds3
         o1UbYOBzCPf3oXwGeKPbS6vmnitasm6Hl0D3woPXDojnx3kXbXT7bl5X3HiodWQiaX0o
         forcKGm/tIWgMm4BoNYMsgYfMl/O1kGlBC0HKkH08bfpXzzNlHTbJkljQ03RIoRbpIhH
         KXw0fPKO4eR+vYCw1z0Rm8biB5/A29tVtd5NZPdoZolZwpEeDNpvphcWDxxqb0NHU/wn
         dd8A==
X-Forwarded-Encrypted: i=1; AJvYcCXPAozaCo6z3PYHGccBTkl8qRw8J6sommu/+KKfIIMSpTPO7O46kHUOOflPzSzuvtKU7XPLxnT1T9mG12/q7EAtW9AZ
X-Gm-Message-State: AOJu0Yyvx3AtXazTa5eAVvqHzT862H4KYZLjw4MNoSFHJTgVsEJstpLD
	VHCtvQKiRuZUyKzmN+P3VMr+hILr2jIzJ1esg2AsJg3CEKceUrjzfTBF3FAeVmE1fgdeo3SZsHQ
	M+gmwxwchdaJJpcePGREWJTYFVCgBdE8HeNSQ
X-Google-Smtp-Source: AGHT+IEHKE3mkY41ExHHzu9FKKI0rKZxFft1TQpFw2fdluwirxG5oWVZDePAqVE9t6iBCjRipWwUe0A4rwe32XitJ6o=
X-Received: by 2002:a5b:64a:0:b0:dcc:ae3:d8a0 with SMTP id o10-20020a5b064a000000b00dcc0ae3d8a0mr3348467ybq.48.1713549698080;
 Fri, 19 Apr 2024 11:01:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410140141.495384-1-jhs@mojatatu.com> <41736ea4e81666e911fee5b880d9430ffffa9a58.camel@redhat.com>
 <CAM0EoM=982OctjvSQpx0kR7e+JnQLhvZ=sM-tNB4xNiu7nhH5Q@mail.gmail.com>
 <CAM0EoM=VhVn2sGV40SYttQyaiCn8gKaKHTUqFxB_WzKrayJJfQ@mail.gmail.com> <87cf4830e2e46c1882998162526e108fb424a0f7.camel@redhat.com>
In-Reply-To: <87cf4830e2e46c1882998162526e108fb424a0f7.camel@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 19 Apr 2024 14:01:26 -0400
Message-ID: <CAM0EoMkJwR0K-fF7qo0PfRw4Sf+=2L0L=rOcH5A2ELwagLrZMw@mail.gmail.com>
Subject: Re: [PATCH net-next v16 00/15] Introducing P4TC (series 1)
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, 
	toke@redhat.com, victor@mojatatu.com, pctammela@mojatatu.com, 
	Vipin.Jain@amd.com, dan.daly@intel.com, andy.fingerhut@gmail.com, 
	chris.sommers@keysight.com, mattyk@nvidia.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 1:20=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Fri, 2024-04-19 at 08:08 -0400, Jamal Hadi Salim wrote:
> > On Thu, Apr 11, 2024 at 12:24=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> > >
> > > On Thu, Apr 11, 2024 at 10:07=E2=80=AFAM Paolo Abeni <pabeni@redhat.c=
om> wrote:
> > > >
> > > > On Wed, 2024-04-10 at 10:01 -0400, Jamal Hadi Salim wrote:
> > > > > The only change that v16 makes is to add a nack to patch 14 on kf=
uncs
> > > > > from Daniel and John. We strongly disagree with the nack; unfortu=
nately I
> > > > > have to rehash whats already in the cover letter and has been dis=
cussed over
> > > > > and over and over again:
> > > >
> > > > I feel bad asking, but I have to, since all options I have here are
> > > > IMHO quite sub-optimal.
> > > >
> > > > How bad would be dropping patch 14 and reworking the rest with
> > > > alternative s/w datapath? (I guess restoring it from oldest revisio=
n of
> > > > this series).
> > >
> > >
> > > We want to keep using ebpf  for the s/w datapath if that is not clear=
 by now.
> > > I do not understand the obstructionism tbh. Are users allowed to use
> > > kfuncs as part of infra or not? My understanding is yes.
> > > This community is getting too political and my worry is that we have
> > > corporatism creeping in like it is in standards bodies.
> > > We started by not using ebpf. The same people who are objecting now
> > > went up in arms and insisted we use ebpf. As a member of this
> > > community, my motivation was to meet them in the middle by
> > > compromising. We invested another year to move to that middle ground.
> > > Now they are insisting we do not use ebpf because they dont like our
> > > design or how we are using ebpf or maybe it's not a use case they hav=
e
> > > any need for or some other politics. I lost track of the moving goal
> > > posts. Open source is about solving your itch. This code is entirely
> > > on TC, zero code changed in ebpf core. The new goalpost is based on
> > > emotional outrage over use of functions. The whole thing is getting
> > > extremely toxic.
> > >
> >
> > Paolo,
> > Following up since no movement for a week now;->
> > I am going to give benefit of doubt that there was miscommunication or
> > misunderstanding for all the back and forth that has happened so far
> > with the nackers. I will provide a summary below on the main points
> > raised and then provide responses:
> >
> > 1) "Use maps"
> >
> > It doesnt make sense for our requirement. The reason we are using TC
> > is because a) P4 has an excellent fit with TC match action paradigm b)
> > we are targeting both s/w and h/w and the TC model caters well for
> > this. The objects belong to TC, shared between s/w, h/w and control
> > plane (and netlink is the API). Maybe this diagram would help:
> > https://github.com/p4tc-dev/docs/blob/main/images/why-p4tc/p4tc-runtime=
-pipeline.png
> >
> > While the s/w part stands on its own accord (as elaborated many
> > times), for TC which has offloads, the s/w twin is introduced before
> > the h/w equivalent. This is what this series is doing.
> >
> > 2) "but ... it is not performant"
> > This has been brought up in regards to netlink and kfuncs. Performance
> > is a lower priority to P4 correctness and expressibility.
> > Netlink provides us the abstractions we need, it works with TC for
> > both s/w and h/w offload and has a lot of knowledge base for
> > expressing control plane APIs. We dont believe reinventing all that
> > makes sense.
> > Kfuncs are a means to an end - they provide us the gluing we need to
> > have an ebpf s/w datapath to the TC objects. Getting an extra
> > 10-100Kpps is not a driving factor.
> >
> > 3) "but you did it wrong, here's how you do it..."
> >
> > I gave up on responding to this - but do note this sentiment is a big
> > theme in the exchanges and consumed most of the electrons. We are
> > _never_ going to get any consensus with statements like "tc actions
> > are a mistake" or "use tcx".
> >
> > 4) "... drop the kfunc patch"
> >
> > kfuncs essentially boil down to function calls. They don't require any
> > special handling by the eBPF verifier nor introduce new semantics to
> > eBPF. They are similar in nature to the already existing kfuncs
> > interacting with other kernel objects such as nf_conntrack.
> > The precedence (repeated in conferences and email threads multiple
> > times) is: kfuncs dont have to be sent to ebpf list or reviewed by
> > folks in the ebpf world. And We believe that rule applies to us as
> > well. Either kfuncs (and frankly ebpf) is infrastructure glue or it's
> > not.
> >
> > Now for a little rant:
> >
> > Open source is not a zero-sum game. Ebpf already coexists with
> > netfilter, tc, etc and various subsystems happily.
> > I hope our requirement is clear and i dont have to keep justifying why
> > P4 or relitigate over and over again why we need TC. Open source is
> > about scratching your itch and our itch is totally contained within
> > TC. I cant help but feel that this community is getting way too
> > pervasive with politics and obscure agendas. I understand agendas, I
> > just dont understand the zero-sum thinking.
> > My view is this series should still be applied with the nacks since it
> > sits entirely on its own silo within networking/TC (and has nothing to
> > do with ebpf).
>
> It's really hard for me - meaning I'll not do that - applying a series
> that has been so fiercely nacked, especially given that the other
> maintainers are not supporting it.
>
> I really understand this is very bad for you.
>
> Let me try to do an extreme attempt to find some middle ground between
> this series and the bpf folks.
>
> My understanding is that the most disliked item is the lifecycle for
> the objects allocated via the kfunc(s).
>
> If I understand correctly, the hard requirement on bpf side is that any
> kernel object allocated by kfunc must be released at program unload
> time. p4tc postpone such allocation to recycle the structure.
>
> While there are other arguments, my reading of the past few iterations
> is that solving the above node should lift the nack, am I correct?
>
> Could p4tc pre-allocate all the p4tc_table_entry_act_bpf_kern entries
> and let p4a_runt_create_bpf() fail if the pool is empty? would that
> satisfy the bpf requirement?

Let me think about it and weigh the consequences.

> Otherwise could p4tc force free the p4tc_table_entry_act_bpf_kern at
> unload time?

This one wont work for us unfortunately. If we have entries added by
the control plane with skip_sw just because the ebpf program is gone
doesnt mean they disappear.

cheers,
jamal

 there are use cases where no entry is loaded by the s/w datap

> Thanks,
>
> Paolo
>
>

