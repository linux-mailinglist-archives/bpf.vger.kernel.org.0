Return-Path: <bpf+bounces-3502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEA573EE67
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 00:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4B01C209C0
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 22:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8476615AEB;
	Mon, 26 Jun 2023 22:09:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEA515AC5
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 22:09:02 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFEE46B5;
	Mon, 26 Jun 2023 15:08:59 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3128fcd58f3so4630657f8f.1;
        Mon, 26 Jun 2023 15:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687817338; x=1690409338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JpDk0lWO2yYjsZuHqFqE08SzkepMeXcw7Z60u7yj8g=;
        b=UClIZo+wdy5Sqc+Ob687Vwm81vcEgcYk1hAT4/fauFWg6vxZ2wr2pdvO/R1tHx0Q/x
         RuhNjIZMnOJo5qGlNqz30H7FwN80yy66s0QnlTfUOs66A4Lh5XfwfWduVwATE6lW3IB2
         nQ81U3wcbmJ3rmzSLcHE+D2LWYeGIboEB2+2qZXy5m/RYzRKMP475M955hqBH77L9U4p
         FpepTbubX4/OeLMHqBwXuyhThG0pjZwXrGD7siMWu1rtl/UVqmxF84ENpBwR0bzkqQlG
         b2GjF9Nj9KWFWrDAVInhITet1lL/x2iR3qeIIRIsBoEto6UqEpVMHhAJdDatzhlRixVy
         xspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687817338; x=1690409338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JpDk0lWO2yYjsZuHqFqE08SzkepMeXcw7Z60u7yj8g=;
        b=NYxXNxg4P5KONSx7LfIUVe8jYmxOdF2ltJsgkq6lWEp1diQzWGeS9uYsazyhaKAtAz
         CXWfT9dSgC4YgafslyjBep+akGodYoJF+weJq0QX2WK5TwI0on/mgKofNEmjdC28myBc
         CsIII8Znjp34W732Tb38jVxnm8H0r/4z/4qw4bLCoHoCm/P+B9uPuUYX+qYXw9tdUMQp
         78C1apdLbH7gzuagJ4+PqwPmFzP4xJuYHS8uxqkgNqSb54RKi+pL9S71cVXkdo5sh8ud
         KmKfTP3OtOYP2IhpCKrw7VewX2+5PNm/TJH9hvp4LK/YqAdInYgKs4R3IV3EFkuTuMzi
         VOpQ==
X-Gm-Message-State: AC+VfDwFD1bBRnKVYqsWY/GCZyODSrLAr9XBYqji8EvLzO1t0WLt3VjI
	HInOg26FYNZXhkTitMdyvxLoiw2lms62x1OvYCQ=
X-Google-Smtp-Source: ACHHUZ6r7C0G7l9NXEurASmnJLYYI31K9n68x/o5tsLD5LWlyBe0zo1KIs6AkMd8w+kL8etsBlaIv9HrGLzeemdPXcc=
X-Received: by 2002:a1c:7212:0:b0:3f5:146a:c79d with SMTP id
 n18-20020a1c7212000000b003f5146ac79dmr24609196wmc.15.1687817337810; Mon, 26
 Jun 2023 15:08:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230607235352.1723243-1-andrii@kernel.org> <c1a8d5e8-023b-4ef9-86b3-bdd70efe1340@app.fastmail.com>
 <CAEf4BzazbMqAh_Nj_geKNLshxT+4NXOCd-LkZ+sRKsbZAJ1tUw@mail.gmail.com>
 <a73da819-b334-448c-8e5c-50d9f7c28b8f@app.fastmail.com> <CAEf4Bzb__Cmf5us1Dy6zTkbn2O+3GdJQ=khOZ0Ui41tkoE7S0Q@mail.gmail.com>
 <5eb4264e-d491-a7a2-93c7-928b06ce264d@redhat.com> <bc4f99af-0c46-49b2-9f2d-9a01e6a03af3@app.fastmail.com>
 <CAEf4BzZz2yOkHZSuzpYd2Hv_6pxDJt2GdGVnd3yG8AUj0tSudw@mail.gmail.com> <56ede337-4370-44c7-b461-806dabc6feee@app.fastmail.com>
In-Reply-To: <56ede337-4370-44c7-b461-806dabc6feee@app.fastmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 26 Jun 2023 15:08:45 -0700
Message-ID: <CAEf4BzYKUhA2syLTsAR9rn_QQqi+gkgW_-dPK2Z57xFqcDusrg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
To: Andy Lutomirski <luto@kernel.org>
Cc: Maryam Tahhan <mtahhan@redhat.com>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Christian Brauner <brauner@kernel.org>, lennart@poettering.net, cyphar@cyphar.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 8:29=E2=80=AFPM Andy Lutomirski <luto@kernel.org> w=
rote:
>
> On Thu, Jun 22, 2023, at 12:05 PM, Andrii Nakryiko wrote:
> > On Thu, Jun 22, 2023 at 9:50=E2=80=AFAM Andy Lutomirski <luto@kernel.or=
g> wrote:
> >>
> >>
> >>
> >> On Thu, Jun 22, 2023, at 1:22 AM, Maryam Tahhan wrote:
> >> > On 22/06/2023 00:48, Andrii Nakryiko wrote:
> >> >>
> >> >>>>> Giving a way to enable BPF in a container is only a small part o=
f the overall task -- making BPF behave sensibly in that container seems li=
ke it should also be necessary.
> >> >>>> BPF is still a privileged thing. You can't just say that any
> >> >>>> unprivileged application should be able to use BPF. That's why BP=
F
> >> >>>> token is about trusting unpriv application in a controlled enviro=
nment
> >> >>>> (production) to not do something crazy. It can be enforced furthe=
r
> >> >>>> through LSM usage, but in a lot of cases, when dealing with inter=
nal
> >> >>>> production applications it's enough to have a proper application
> >> >>>> design and rely on code review process to avoid any negative effe=
cts.
> >> >>> We really shouldn=E2=80=99t be creating new kinds of privileged co=
ntainers that do uncontained things.
> >> >>>
> >> >>> If you actually want to go this route, I think you would do much b=
etter to introduce a way for a container manager to usefully proxy BPF on b=
ehalf of the container.
> >> >> Please see Hao's reply ([0]) about his and Google's (not so rosy)
> >> >> experiences with building and using such BPF proxy. We (Meta)
> >> >> internally didn't go this route at all and strongly prefer not to.
> >> >> There are lots of downsides and complications to having a BPF proxy=
.
> >> >> In the end, this is just shuffling around where the decision about
> >> >> trusting a given application with BPF access is being made. BPF pro=
xy
> >> >> adds lots of unnecessary logistical, operational, and development
> >> >> complexity, but doesn't magically make anything safer.
> >> >>
> >> >>    [0] https://lore.kernel.org/bpf/CA+khW7h95RpurRL8qmKdSJQEXNYuqSW=
nP16o-uRZ9G0KqCfM4Q@mail.gmail.com/
> >> >>
> >> > Apologies for being blunt, but  the token approach to me seems to be=
 a
> >> > work around providing the right level/classification for a pod/conta=
iner
> >> > in order to say you support unprivileged containers using eBPF. I th=
ink
> >> > if your container needs to do privileged things it should have and b=
e
> >> > classified with the right permissions (privileges) to do what it nee=
ds
> >> > to do.
> >>
> >> Bluntness is great.
> >>
> >> I think that this whole level/classification thing is utterly wrong.  =
Replace "BPF" with basically anything else, and you'll see how absurd it is=
.
> >
> > BPF is not "anything else", it's important to understand that BPF is
> > inherently not compratmentalizable. And it's vast and generic in its
> > capabilities. This changes everything. So your analogies are
> > misleading.
> >
>
> file descriptors are "vast and generic" -- you can open sockets, files, t=
hings in /proc, things in /sys, device nodes, etc.  They are infinitely ext=
ensible.  They work in containers.
>
> What is so special about BPF?

Socket with a well-defined and constrained interface that defines what
you can do with it (send and receive bytes, in a controlled fashion),
and BPF programs that intentionally are allowed to have an almost
arbitrarily complex control flow *controlled by user*, and can combine
dozens if not hundreds of "building blocks" (BPF helpers, kfuncs,
various BPF maps, etc) and that could be activated at various points
deep in the kernel (and run that custom user-provided code in kernel
space). I'd say that yeah, BPF is on another level as far as
genericity goes, compared to other interfaces.

And that's BPF's goal and appeal, nothing wrong with it. But I do
think BPF and sockets, files, things in /proc, etc are pretty
different in terms of how they can be proved and enforced to be
sandboxed.

>
> >>
> >> "the token approach to me seems like a work around providing the right=
 level/classification for a pod/container in order to say you support unpri=
vileged containers using files on disk"
> >>
> >> That's very 1990's.  Maybe 1980's.  Of *course* giving access to a fil=
esystem has some inherent security exposure.  So we can give containers acc=
ess to *different* filesystems.  Or we can use ACLs.  Or MAC policy.  Or wh=
atever.  We have many solutions, none of which are perfect, and we're doing=
 okay.
> >>
> >> "the token approach to me seems like a work around providing the right=
 level/classification for a pod/container in order to say you support unpri=
vileged containers using the network"
> >>
> >> The network is a big deal.  For some reason, it's cool these days to t=
reat TCP as highly privileged.  You can get secrets from your favorite (or =
least favorite) cloud provider with unauthenticated HTTP to a magic IP and =
port.  You can bypass a whole lot of authenticating/authorizing proxies wit=
h unauthenticated HTTP (no TLS!) if you're on the right network.
> >>
> >> This is IMO obnoxious, but we deal with it by having network namespace=
s and firewalls and rather outdated port <=3D 1024 rules.
> >>
> >> "the token approach to me seems like a work around providing the right=
 level/classification for a pod/container in order to say you support unpri=
vileged containers using BPF"
> >>
> >> My response is: what's wrong with BPF?  BPF has maps and programs and =
such, and we could easily apply 1990's style ownership and DAC rules to the=
m.
> >
> > Can you apply DAC rules to which kernel events BPF program can be run
> > on? Can you apply DAC rules to which in-kernel data structures a BPF
> > program can look at and make sure that it doesn't access a
> > task/socket/etc that "belongs" to some other container/user/etc?
>
> No, of course.
>
> If you have a BPF program that is granted the ability to read kernel data=
 structures or to run in response to global events like this, it's basicall=
y a kernel module.  It may be subject to a verifier that imposes much stron=
ger type safety than a kernel module is subject to, but it's still effectiv=
ely a kernel module.
>
> We don't give containers special tokens that let them load arbitrary modu=
les.  We should not give them special tokens that let them do things with B=
PF that are functionally equivalent to loading arbitrary kernel modules.
>
> But we do have ways that kernel modules (which are "vast and generic", to=
o) can expose their functionality safely to containers.  BPF can learn to d=
o this.
>
> >
> > Can we limit XDP or AF_XDP BPF programs from seeing and controlling
> > network traffic that will be eventually routed to a container that XDP
> > program "should not" have access to? Without making everything so slow
> > that it's useless?
>
> Of course you can -- assign an entire NIC or virtual function to a contai=
ner, and let the XDP program handle that.  Or a vlan or a macvlan or whatev=
er.  (I'm assuming XDP can be scoped like this.  I'm not that familiar with=
 the details.)
>
> >
> >> I even *wrote the code*.
> >
> > Did you submit it upstream for review and wide discussion?
>
> Yes.
>
> > Did you
> > test it and integrate it with production workloads to prove that your
> > solution is actually a viable real-world solution and not a toy?
>
> I did test it.  I did not integrate it with production workloads.
>

Real-world use cases are the ultimate test of APIs and features. No
matter how brilliant and elegant the solution is, if it doesn't work
with real-world applications, it's pretty useless.

It's not that hard to allow only a very limited and very restrictive
subset of BPF to be allowed to be loaded and attached from containers
without privileged permissions. But the point is to find a solution
that works for complicated (and sometimes very messy) real
applications that were validated by humans (to the best of their
abilities), but can't be proven to be contained within some container.


> > Writing the code doesn't mean solving the problem.
>
> Of course not.  My code was a little step in the right direction.  The BP=
F community was apparently not interested in it.
>
> >
> >> But for some reason, the BPF community wants to bury its head in the s=
and, pretend it's 1980, declare that BPF is too privileged to have access c=
ontrol, and instead just have a complicated switch to turn it on and off in=
 different contexts.
> >
> > I won't speak on behalf of the entire BPF community, but I'm trying to
> > explain that BPF cannot be reasonably sandboxed and has to be
> > privileged due to its global nature. And I haven't yet seen any
> > realistic counter-proposal to change that. And it's not about
> > ownership of the BPF map or BPF program, it's way beyond that..
> >
>
> It's really really hard to have a useful discussion about a security mode=
l when have, as what appears to be an axiom, that a security model can't be=
 created.
>
> If you actually feel this way, then I think you should not be advocating =
for allowing unprivileged containers to do the things that you think can't =
have a security model.
>
> I'm saying that I think there *can* be a security model.  But until the m=
aintainers start to believe that, there won't be one.

See above, whatever security model you have in mind, it should be
workable with real-world applications. Building some elegant system
that will work for just a (rather small) subset of use cases isn't
appealing.

