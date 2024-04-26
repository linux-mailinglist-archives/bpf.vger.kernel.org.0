Return-Path: <bpf+bounces-27953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9D08B3DBF
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 19:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1E71C20B61
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 17:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1910315B579;
	Fri, 26 Apr 2024 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3XmdSwJ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43AE14535A
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152100; cv=none; b=pzug8zTuqta/ljc/xS7dJR0L45iahkyLgFo7+HACt8lb7gQ68tijJJCw5rVvkvnAJjW+vuLsCE5tZnZXO0zNkfRK2kVvhudVPQMf9+fUgesffJKGNcjZ7nmT70ZcK3bFARSFqzl3lUrRrK6+sn++xcGo6ELVW5cYG9WSm0f1kBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152100; c=relaxed/simple;
	bh=yKV0VoJs4ORfQpeL+ajT3XCGNNNwEfYviwnsoThqRO0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HWzRe+nnyTrnXGbluclI4JgOnkutx6kDaC9vw6Hq//0j1IPsdEWMT5FRw98C5rlztHc+Y72IwjiEewXxK1U8YF51S/qw4FuYRQ7DmBPenyg68l38RNDOoWYYLEYgvRQEp3EH4pkjiv2eX8kMmlUf2Eo9YutpixcH/59hVbclhPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V3XmdSwJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714152097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ElpPpdwl99f9ByaBbxwf3DApfqevABJ+vg82WNYz79s=;
	b=V3XmdSwJ3eh0s65eQMpLwLw4F6rUq82DcEf88ANBC+t+K2xQjkSPIDG+zN+WfRxO6JE38c
	j3VFAFqtMPmX9u9pUwkWO5aG8e9hhXA2/MGtChBOs5MRTSQIkJ8TiciP9rD5t+zmxLRX1q
	2NbeSjxlYH4QaP0AweXBfSeWlgPzNhU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-GyojCYCgMfCvhQ8Rc040_g-1; Fri, 26 Apr 2024 13:21:36 -0400
X-MC-Unique: GyojCYCgMfCvhQ8Rc040_g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34c5ed73e41so78238f8f.0
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 10:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714152095; x=1714756895;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ElpPpdwl99f9ByaBbxwf3DApfqevABJ+vg82WNYz79s=;
        b=Bs5kuh6SWRm2o6sxzjQRABuSBgGdzmITFguGn9hE9F+JW4avWfOhTqcCxjd9l+1+62
         c5aJ/w3CvLLV4rhJ92Osq/SE5DASz25CwcJCwECMt03s3KP/+eLloV8ZC/WpNuxgH9tO
         PgajnNnjeVLDokB0yObnDMcotTqqIZVz0U3Ox++TIRyvxligR3i9JIjz47xVwHNhN6Ma
         s5TG1VywmQVF9HIpdFppG70a+mC/0ePX02rDhA+zEEhfo7o1KUbJUJ1/gBoZtZb8y08v
         pjfvmoV4c+QhXKiSO9dc8TZYqmBqwCGKiEGbUCIgEmcrZVz47b94XS24KmKO3bBgrs1J
         Q19g==
X-Forwarded-Encrypted: i=1; AJvYcCVXD74ZWQ4jexu691BAhn/xuMIfC5cNy8h32y+hGordSvbwgYrIqpQjRz7mqxGKgmLOP5Z1bVIdOavgESa9sOt3aPPM
X-Gm-Message-State: AOJu0Yyfk8HD51kGxSOr3LtgUkZrfaWRHL/TqIrzj5I2cZn5xlIMRi5O
	3+UGmbEF7vmZ4wK0+XcECP8EZzliUd2oi+6HPLP5VXkHWuGbrxGJuUOYEJKaUzMp0ntHm//QU3q
	Tc1ASNWkchCGvyri0vZuAY3YdVuE68UJskQ1fUEwgZAYJ2CYF9w==
X-Received: by 2002:a5d:5f8a:0:b0:346:7f4d:e80f with SMTP id dr10-20020a5d5f8a000000b003467f4de80fmr3311046wrb.1.1714152095290;
        Fri, 26 Apr 2024 10:21:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGopNVNkYHnINqwJe/vN5Bwpw0x7p9b0cLQ+3EHESyfNV74Sqs8Ldp/eLXPcRIpEWWlU37EMg==
X-Received: by 2002:a5d:5f8a:0:b0:346:7f4d:e80f with SMTP id dr10-20020a5d5f8a000000b003467f4de80fmr3311025wrb.1.1714152094816;
        Fri, 26 Apr 2024 10:21:34 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:171d:a510::f71])
        by smtp.gmail.com with ESMTPSA id b16-20020a5d4d90000000b0034c59c41f45sm1914944wru.7.2024.04.26.10.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 10:21:34 -0700 (PDT)
Message-ID: <82ee1013ca0164053e9fb1259eaf676343c430e8.camel@redhat.com>
Subject: Re: [PATCH net-next v16 00/15] Introducing P4TC (series 1)
From: Paolo Abeni <pabeni@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com,
 anjali.singhai@intel.com,  namrata.limaye@intel.com, tom@sipanda.io,
 mleitner@redhat.com,  Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com,
 jiri@resnulli.us,  xiyou.wangcong@gmail.com, davem@davemloft.net,
 edumazet@google.com,  kuba@kernel.org, vladbu@nvidia.com, horms@kernel.org,
 khalidm@nvidia.com,  toke@redhat.com, victor@mojatatu.com,
 pctammela@mojatatu.com, Vipin.Jain@amd.com,  dan.daly@intel.com,
 andy.fingerhut@gmail.com, chris.sommers@keysight.com,  mattyk@nvidia.com,
 bpf@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 26 Apr 2024 19:21:31 +0200
In-Reply-To: <CAM0EoMmfDoZ9_ZdK-ZjHjFAjuNN8fVK+R57_UaFqAm=wA0AWVA@mail.gmail.com>
References: <20240410140141.495384-1-jhs@mojatatu.com>
	 <41736ea4e81666e911fee5b880d9430ffffa9a58.camel@redhat.com>
	 <CAM0EoM=982OctjvSQpx0kR7e+JnQLhvZ=sM-tNB4xNiu7nhH5Q@mail.gmail.com>
	 <CAM0EoM=VhVn2sGV40SYttQyaiCn8gKaKHTUqFxB_WzKrayJJfQ@mail.gmail.com>
	 <87cf4830e2e46c1882998162526e108fb424a0f7.camel@redhat.com>
	 <CAM0EoMkJwR0K-fF7qo0PfRw4Sf+=2L0L=rOcH5A2ELwagLrZMw@mail.gmail.com>
	 <CAM0EoMmfDoZ9_ZdK-ZjHjFAjuNN8fVK+R57_UaFqAm=wA0AWVA@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-26 at 13:12 -0400, Jamal Hadi Salim wrote:
> On Fri, Apr 19, 2024 at 2:01=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >=20
> > On Fri, Apr 19, 2024 at 1:20=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > >=20
> > > On Fri, 2024-04-19 at 08:08 -0400, Jamal Hadi Salim wrote:
> > > > On Thu, Apr 11, 2024 at 12:24=E2=80=AFPM Jamal Hadi Salim <jhs@moja=
tatu.com> wrote:
> > > > >=20
> > > > > On Thu, Apr 11, 2024 at 10:07=E2=80=AFAM Paolo Abeni <pabeni@redh=
at.com> wrote:
> > > > > >=20
> > > > > > On Wed, 2024-04-10 at 10:01 -0400, Jamal Hadi Salim wrote:
> > > > > > > The only change that v16 makes is to add a nack to patch 14 o=
n kfuncs
> > > > > > > from Daniel and John. We strongly disagree with the nack; unf=
ortunately I
> > > > > > > have to rehash whats already in the cover letter and has been=
 discussed over
> > > > > > > and over and over again:
> > > > > >=20
> > > > > > I feel bad asking, but I have to, since all options I have here=
 are
> > > > > > IMHO quite sub-optimal.
> > > > > >=20
> > > > > > How bad would be dropping patch 14 and reworking the rest with
> > > > > > alternative s/w datapath? (I guess restoring it from oldest rev=
ision of
> > > > > > this series).
> > > > >=20
> > > > >=20
> > > > > We want to keep using ebpf  for the s/w datapath if that is not c=
lear by now.
> > > > > I do not understand the obstructionism tbh. Are users allowed to =
use
> > > > > kfuncs as part of infra or not? My understanding is yes.
> > > > > This community is getting too political and my worry is that we h=
ave
> > > > > corporatism creeping in like it is in standards bodies.
> > > > > We started by not using ebpf. The same people who are objecting n=
ow
> > > > > went up in arms and insisted we use ebpf. As a member of this
> > > > > community, my motivation was to meet them in the middle by
> > > > > compromising. We invested another year to move to that middle gro=
und.
> > > > > Now they are insisting we do not use ebpf because they dont like =
our
> > > > > design or how we are using ebpf or maybe it's not a use case they=
 have
> > > > > any need for or some other politics. I lost track of the moving g=
oal
> > > > > posts. Open source is about solving your itch. This code is entir=
ely
> > > > > on TC, zero code changed in ebpf core. The new goalpost is based =
on
> > > > > emotional outrage over use of functions. The whole thing is getti=
ng
> > > > > extremely toxic.
> > > > >=20
> > > >=20
> > > > Paolo,
> > > > Following up since no movement for a week now;->
> > > > I am going to give benefit of doubt that there was miscommunication=
 or
> > > > misunderstanding for all the back and forth that has happened so fa=
r
> > > > with the nackers. I will provide a summary below on the main points
> > > > raised and then provide responses:
> > > >=20
> > > > 1) "Use maps"
> > > >=20
> > > > It doesnt make sense for our requirement. The reason we are using T=
C
> > > > is because a) P4 has an excellent fit with TC match action paradigm=
 b)
> > > > we are targeting both s/w and h/w and the TC model caters well for
> > > > this. The objects belong to TC, shared between s/w, h/w and control
> > > > plane (and netlink is the API). Maybe this diagram would help:
> > > > https://github.com/p4tc-dev/docs/blob/main/images/why-p4tc/p4tc-run=
time-pipeline.png
> > > >=20
> > > > While the s/w part stands on its own accord (as elaborated many
> > > > times), for TC which has offloads, the s/w twin is introduced befor=
e
> > > > the h/w equivalent. This is what this series is doing.
> > > >=20
> > > > 2) "but ... it is not performant"
> > > > This has been brought up in regards to netlink and kfuncs. Performa=
nce
> > > > is a lower priority to P4 correctness and expressibility.
> > > > Netlink provides us the abstractions we need, it works with TC for
> > > > both s/w and h/w offload and has a lot of knowledge base for
> > > > expressing control plane APIs. We dont believe reinventing all that
> > > > makes sense.
> > > > Kfuncs are a means to an end - they provide us the gluing we need t=
o
> > > > have an ebpf s/w datapath to the TC objects. Getting an extra
> > > > 10-100Kpps is not a driving factor.
> > > >=20
> > > > 3) "but you did it wrong, here's how you do it..."
> > > >=20
> > > > I gave up on responding to this - but do note this sentiment is a b=
ig
> > > > theme in the exchanges and consumed most of the electrons. We are
> > > > _never_ going to get any consensus with statements like "tc actions
> > > > are a mistake" or "use tcx".
> > > >=20
> > > > 4) "... drop the kfunc patch"
> > > >=20
> > > > kfuncs essentially boil down to function calls. They don't require =
any
> > > > special handling by the eBPF verifier nor introduce new semantics t=
o
> > > > eBPF. They are similar in nature to the already existing kfuncs
> > > > interacting with other kernel objects such as nf_conntrack.
> > > > The precedence (repeated in conferences and email threads multiple
> > > > times) is: kfuncs dont have to be sent to ebpf list or reviewed by
> > > > folks in the ebpf world. And We believe that rule applies to us as
> > > > well. Either kfuncs (and frankly ebpf) is infrastructure glue or it=
's
> > > > not.
> > > >=20
> > > > Now for a little rant:
> > > >=20
> > > > Open source is not a zero-sum game. Ebpf already coexists with
> > > > netfilter, tc, etc and various subsystems happily.
> > > > I hope our requirement is clear and i dont have to keep justifying =
why
> > > > P4 or relitigate over and over again why we need TC. Open source is
> > > > about scratching your itch and our itch is totally contained within
> > > > TC. I cant help but feel that this community is getting way too
> > > > pervasive with politics and obscure agendas. I understand agendas, =
I
> > > > just dont understand the zero-sum thinking.
> > > > My view is this series should still be applied with the nacks since=
 it
> > > > sits entirely on its own silo within networking/TC (and has nothing=
 to
> > > > do with ebpf).
> > >=20
> > > It's really hard for me - meaning I'll not do that - applying a serie=
s
> > > that has been so fiercely nacked, especially given that the other
> > > maintainers are not supporting it.
> > >=20
> > > I really understand this is very bad for you.
> > >=20
> > > Let me try to do an extreme attempt to find some middle ground betwee=
n
> > > this series and the bpf folks.
> > >=20
> > > My understanding is that the most disliked item is the lifecycle for
> > > the objects allocated via the kfunc(s).
> > >=20
> > > If I understand correctly, the hard requirement on bpf side is that a=
ny
> > > kernel object allocated by kfunc must be released at program unload
> > > time. p4tc postpone such allocation to recycle the structure.
> > >=20
> > > While there are other arguments, my reading of the past few iteration=
s
> > > is that solving the above node should lift the nack, am I correct?
> > >=20
> > > Could p4tc pre-allocate all the p4tc_table_entry_act_bpf_kern entries
> > > and let p4a_runt_create_bpf() fail if the pool is empty? would that
> > > satisfy the bpf requirement?
> >=20
> > Let me think about it and weigh the consequences.
> >=20
>=20
> Sorry, was busy evaluating. Yes, we can enforce the memory allocation
> constraints such that when the ebpf program is removed any entries
> added by said ebpf program can be removed from the datapath.

I suggested the such changes based on my interpretation of this long
and complex discussion, I can have missed some or many relevant points.
@Alexei: could you please double check the above and eventually,
hopefully, confirm that such change would lift your nacked-by?

Thanks!

Paolo


