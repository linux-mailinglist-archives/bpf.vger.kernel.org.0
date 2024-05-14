Return-Path: <bpf+bounces-29715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7478C5CE2
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 23:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C7F1C21168
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 21:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDBF181BB3;
	Tue, 14 May 2024 21:34:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77221180A6A;
	Tue, 14 May 2024 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715722450; cv=none; b=PiqddnZsfq9ymVhtGO8ghU5QWUPgqQ0FAj3BCvFFBHG+VreRPT4Eebieim0SadZl048rGyfoegp4DVC2zJeJq1fG1B3kN2BJz4gYdMvM5evkDj2RKbjFovVs4VRVOmMZ0YSyqhN/jN2bf1H5zk4PaxXr91W9ewAA9tfVllZpPLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715722450; c=relaxed/simple;
	bh=aOvD5c1w3OD7FSm91DdMADDEt40Tzq6gSaSq2UVOzHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROTwD6eLu/LrKdKP543la7xfGyTYboDVBUvlBzrqUG2p1YzXgTyq9FpjjPrBQCuKjW4MwslbOKVeQ4xivlGJARYDjZY9T+zArn/dwP5/QP1YzxWb8eaD6QDN7DjTbDCuXYdOkHuBRQy3birulUuoJbpmle9FeRw5MgSl9k7loIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43e1e98aaf0so12343091cf.2;
        Tue, 14 May 2024 14:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715722447; x=1716327247;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uEY0o+N8otrkUAfReflUQgEF27F7StLOiP6p52WPUw=;
        b=r3tXheUuj9wCWspRy2nZh7sAr0ISlSTZRcpA1iq4NDbK6cOBtDyLSIh/4KnL1AdlPv
         /PUB+C5w+OMo0SIVY0SUzu62UysTo/YoU+s3SrgC52jge9t5hLSCHfWm44NCt9ife/fp
         IYkEM1VR/OUfLK6JZPl4X0808P24JX4niEwi2E4upJvW51Ro0zPoRta1L0jn/LRrfdoH
         wblyk86RSUX5R+sT/jh8uKdJykrPWFz+rbhWMv1Nuq3/4M0/ZfOai/+wOvt0+5W/UZX3
         /RG40RRUi1FXYpzC7nNCON87lUgOfCXv4oFKXTG3zEBAoUhFkog52/iLXRPWOeji43Rf
         RtWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuDv6w35EmkFdnZmXwFR9/oeUw6jD1sdYZJ9Eo/m9gWNWu8VYkyW8gO/i/RxQ/o41W50PoaUeQedCAVGFqTS4bTsCZThoPYjn9mJ5fKRNPc8Nv+HvuB9ReR36gZDpTtd7x
X-Gm-Message-State: AOJu0Yz5a0KU9ocR+RVgT3yl5ceGiF6674t93XAanOOjB6JQqGwFZU2+
	+XgONMOax7jfjjYdNNgDh00B+efS3u1oWoP1H2T0c60UB4nbWa2R
X-Google-Smtp-Source: AGHT+IGauhC3LbaGgxTo/gcPUpOobwJQc4TsfarfLu3eY1Gz0/rRmrCeRyFgT83UoX7GNgq5LMSg0g==
X-Received: by 2002:ac8:588c:0:b0:43a:f13e:7d53 with SMTP id d75a77b69052e-43dfdaf45cdmr133326501cf.31.1715722447029;
        Tue, 14 May 2024 14:34:07 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df56d482fsm73271671cf.89.2024.05.14.14.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 14:34:06 -0700 (PDT)
Date: Tue, 14 May 2024 16:34:02 -0500
From: David Vernet <void@manifault.com>
To: Qais Yousef <qyousef@layalina.io>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
	torvalds@linux-foundation.org, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
	andrea.righi@canonical.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
Message-ID: <20240514213402.GB295811@maniforge>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240502084800.GY30852@noisy.programming.kicks-ass.net>
 <ZjPnb1vdt80FrksA@slm.duckdns.org>
 <20240503085232.GC30852@noisy.programming.kicks-ass.net>
 <ZjgWzhruwo8euPC0@slm.duckdns.org>
 <20240513080359.GI30852@noisy.programming.kicks-ass.net>
 <20240513142646.4dc5484d@rorschach.local.home>
 <20240514000715.4765jfpwi5ovlizj@airbuntu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hz23CNVhXOiH/3Uj"
Content-Disposition: inline
In-Reply-To: <20240514000715.4765jfpwi5ovlizj@airbuntu>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--Hz23CNVhXOiH/3Uj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 01:07:15AM +0100, Qais Yousef wrote:

[...]

> > >=20
> > > How does this BPF muck translate into better quality patches for me?
> >=20
> > Here's how we will be using it (we will likely be porting sched_ext to
> > ChromeOS regardless of its acceptance).
> >=20
> > Doing testing of scheduler changes in the field is extremely time
> > consuming and complex. We tested EEVDF vs CFS by backporting EEVDF to
> > 5.15 (as that is the kernel version we are using on the chromebooks we
> > were testing on), and then we need to add a user space "switch" to
> > change the scheduler. Note, this also risks causing a bug in adding
> > these changes. Then we push the kernel out, and then start our
> > experiment that enables our feature to a small percentage, and slowly
> > increases the number of users until we have a enough for a statistical
> > result.
> >=20
> > What sched_ext would give us is a easy way to try different scheduling
> > algorithms and get feedback much quicker. Once we determine a solution
> > that improves things, we would then spend the time to implement it in
> > the scheduler, and yes, send it upstream.
> >=20
> > To me, sched_ext should never be the final solution, but it can be
> > extremely useful in testing various changes quickly in the field. Which
> > to me would encourage more contributions.

Hello Qais,

[...]

> I really don't buy the rapid development aspect too. The scheduler was he=
avily

There are already several examples from users who have shown that the rapid
development and experimentation is extremely useful. Imagine if you're
iterating on the scheduler to improve p99 frame rates on the Steam Deck, as
Changwoo described. It's much more efficient to be able to just tweak and l=
oad
a BPF scheduler (that is safe and can't crash the machine) to try some rand=
om
idea out than it is to:

1. Tweak and recompile the kernel
2. Reinstall the kernel on the Steam Deck
3. Reboot the Steam Deck
4. Reload a game and let caches rewarm
5. Measure FPS

You're talking about a 5 second compile job + 1 second to reload a safe BPF
scheduler vs. having to do all of the above steps _and_ potentially making a
mistake that brings the machine down. These benefits are also extremely use=
ful
for testing workloads on production servers, etc. Let=E2=80=99s also not fo=
rget that
unlike many other kernel features, you probably can=E2=80=99t get reliable =
scheduling
results from running in a VM. The experimentation overhead is very real.

[...]

> influenced by the early contributors which come from server market that h=
ad
> (few) very specific workloads they needed to optimize for and throughput =
had
> a heavier weight vs latency. Fast forward to now, things are different. E=
ven on
> server market latency/responsiveness has become more important. Power and
> thermal are important on a larger class of systems now too. I'd dare say =
even
> on server market. How do you know when it's okay for an app/task to consu=
me too
> much power and when it is not? Hint hint, you can't unless someone in use=
rspace
> tells you. Similarly for latency vs throughput. What is the correct way to
> write an application to provide this info? Then we can ask what is missin=
g in
> the scheduler to enable this.

Hmm, you seem to be arguing that the way forward here is to have our one
general purpose scheduler be entirely driven by user space hinting. Assuming
I=E2=80=99m not misunderstanding you, I strongly disagree with this sentime=
nt.  User
space hinting can be powerful, but I think we need to have a general purpose
scheduler that's completely agnostic to whatever is running in user space.
We=E2=80=99ve also been able to get strong results from sched_ext scheduler=
s that don=E2=80=99t
use any user space hinting.

Also, even if this ended up being the way forward, I don=E2=80=99t see it b=
eing
practical to implement. Wouldn=E2=80=99t it require us to update all of use=
r space
globally just to update how it interfaces with the scheduler?

[...]

> Note the original min/wakeup_granularity_ns, latency_ns etc were tuned by
> default for throughput by the way (server market bias). You can manipulate
> those and get better latencies.

Those knobs aren't available anymore in EEVDF.
=20
[...]

> point IMO, not the scheduler algorithm. If the latter need to change, it =
needs
> to be as the result of this friction - which what EEVDF came about from t=
o my
> understanding. To enable implementing a latency interface easier. But Vin=
cent
> had a working implementation with CFS too which I think would have worked=
 fine
> by the way.

This friction is nothing new. It's why we already find ourselves in the
unfortunate position of having a large corpus of out of tree scheduler patc=
hes.
If there is a lot of performance being left on the table, vendors are going=
 to
find a way to get that performance. Corporations don't need our consent to =
ship
kernels with custom schedulers on their devices. They've already been doing=
 it
for years, and it's ultimately the users who suffer.

I genuinely believe that the fair.c scheduler will benefit from being able =
to
apply ideas conceived in a sched_ext scheduler which end up working well for
general use cases. For example, in scx_rusty, we=E2=80=99re able to get ver=
y good
interactivity [0] by determining a task=E2=80=99s deadline as a function of=
 its average
runtime (along with some other great ideas that Changwoo first added to
scx_lavd) rather than from its eligibility + slice as with what EEVDF does.
Over the course of a day or two, I tried way more ideas that didn=E2=80=99t=
 work than
would have been possible in that time frame than with a recompile-reboot cy=
cle,
and ended up finding one that seems to work very well. It would be awesome =
if
these ideas were added to EEVDF so that everyone can benefit.

[0]: https://drive.google.com/file/d/1fyHt9BYGha6apl7HAkibwpy52UTi8-AQ/view=
?usp=3Ddrive_link

Thanks,
David

--Hz23CNVhXOiH/3Uj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZkPYygAKCRBZ5LhpZcTz
ZF3EAP43Feg/GrZoMvbnVaeSJmbXJXAAa5HuWEa8ZTH19Hvk/wD3TlpIqdVQLkRT
hdPd5RRQEsadH/PKVkBXO3j96W3ECA==
=J3f2
-----END PGP SIGNATURE-----

--Hz23CNVhXOiH/3Uj--

