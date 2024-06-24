Return-Path: <bpf+bounces-32954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14369159BA
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 00:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C631C2226C
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 22:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006B31A2556;
	Mon, 24 Jun 2024 22:17:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4673C17BCC;
	Mon, 24 Jun 2024 22:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267449; cv=none; b=klTvfKSqS9t4xrAAD6j9HvRM4w6Z1N49RPzjKiwOSZ/6N26X97ET6A0D7wlv1F11dSZEjPtz3SnGlHEUVlf7tzL1PujSJgLSw/BRdnqeQIjxsLkvrE8E+bZV3fRFApr2HUL/p4SS+zf4j9ej8ke1SobOA2EQHdKODDNG1/P0Tyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267449; c=relaxed/simple;
	bh=JtDlVshImC/ubfnasOtZZKH2pVFETAv8XKa6Ny9arVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJf8QBm9yfqnn5wqMaVGL7H8gGb/hGt4n8822J9vhsU9PRR+nIP9uzknKwyNe3wxfsOS4Iclc870RuMxmMDau+btx/MhSJqq3BZH2C+DbokHlc46Bep4zqLZiRyYAGc6OdYJmgqdTPIrSYTqUyZkzqU5lUBZZY6yuULEz8VHAmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7953f1dcb01so478870785a.3;
        Mon, 24 Jun 2024 15:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719267446; x=1719872246;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kCuC52LGe/0E5NBNEQJUYGoftakhn30jEGOd6x1MTk=;
        b=gcXSkg+m+HfMIiVn0zFp2OFak3gaTxNwZUUKbN4n3n9ojeHMvVsMM8Alc5Z1ggW+mE
         vsKlz6wnJsFmh83+nxj4f6VTcQee5sM1qHJfr5fz2exNPZhFDlZzy+aEjpH60swaLsMo
         sujk2nU1wtyjuPgOQmq1gaYA3KUvdV/DLVFlBHisZvjLVzZ2BcENyYgjmoD4RkOBAXkQ
         wMROwmCRccIyvX/5DbjiFuL6mNIL3yhaGY6zxV8bbs3OwXIMlikNVrqKSPtSJjXGPKw9
         P24O3Md7mFGpJzbawmUSH2CfkKbcZlEQ9j0cCQW+vxafy7G1pskAERJIsCG244w3tbyq
         Gg+w==
X-Forwarded-Encrypted: i=1; AJvYcCV5wNyeb1dLoQIWxy1I71Ps56QiR3uuq95dMNNnRiFUJdBVB57nJSoAVru1q1V56mCdoJBMGTuGThUQIwtrebCoUhBl1ZZMnHCz+FC9eFi0ejPnhTSCDo+XzdaSwGp09AQu
X-Gm-Message-State: AOJu0Yxe9jBhjfz4/Tham0txEhGp0amipUzFTp2vM4SfIoHTRc5bHAQ6
	NSZnHNXh9cOR/H+6xvmZ4rdjl1pr3GYoJYFknyVq3tMrCwhLr8yv
X-Google-Smtp-Source: AGHT+IGMWepWo4S7wLVAXbO2YIxxcF/fHNS+GXJMH1/AiP5jXmMHvsSmhvhMtxFPJqfAX6Ea5RokZQ==
X-Received: by 2002:a05:620a:2944:b0:795:5bb9:3323 with SMTP id af79cd13be357-79be6e917f7mr802587585a.13.1719267445860;
        Mon, 24 Jun 2024 15:17:25 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce8b2badsm351999985a.46.2024.06.24.15.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 15:17:25 -0700 (PDT)
Date: Mon, 24 Jun 2024 17:17:21 -0500
From: David Vernet <void@manifault.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Chris Mason <clm@meta.com>, Tejun Heo <tj@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
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
Message-ID: <20240624221721.GA4942@maniforge>
References: <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>
 <87ed8sps71.ffs@tglx>
 <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
 <87bk3wpnzv.ffs@tglx>
 <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
 <878qz0pcir.ffs@tglx>
 <ZnSEeO8MHIQRJyt1@slm.duckdns.org>
 <87r0cqo9p0.ffs@tglx>
 <364ed9fa-e614-4994-8dd3-48b1d8887712@meta.com>
 <878qywyt1c.ffs@tglx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F5DrM9diCmshJWRE"
Content-Disposition: inline
In-Reply-To: <878qywyt1c.ffs@tglx>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--F5DrM9diCmshJWRE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thomas,

On Sun, Jun 23, 2024 at 10:14:55AM +0200, Thomas Gleixner wrote:
> Chris!
>=20
> On Fri, Jun 21 2024 at 17:14, Chris Mason wrote:
> > On 6/21/24 6:46 AM, Thomas Gleixner wrote:
> > I'll be honest, the only clear and consistent communication we've gotten
> > about sched_ext was "no, please go away".  You certainly did engage with
> > face to face discussions, but at the end of the day/week/month the
> > overall message didn't change.
>=20
> The only time _I_ really told you "go away" was at OSPM 2023 when you
> approached everyone in the worst possible way. I surely did not even say
> "please" back then.

Respectfully, you have seriously misrepresented the facts of how everything=
 has
played out over the last 18 months of this feature being proposed upstream.=
  I
think it's important to set the record straight here, so let's get concrete=
 and
look at the timeline for sched_ext's progress since its inception.

1. We actually first met at LPC in 2022, at which time I mentioned this pro=
ject
to you and asked if you had any thoughts about it. I understood your respon=
se
to be, essentially, , "I don't like BPF because it introduces UAPI constrai=
nts
on the entire kernel." My response was that struct_ops programs and kfuncs
aren't beholden to UAPI constraints as they're exclusively kernel APIs.

This was a random off-the-cuff discussion, and we had never met before, so I
don't fault you for not engaging on this specific point in future discussio=
ns.
I do, however, think it's important to highlight that we've been trying to
engage with you on this in one form or another for about 18 months at this
point.

2. The initial RFC [0] is sent out in late 2022. Peter to his credit did le=
ave
quite a few constructive comments that result in material improvements to t=
he
patch set, but the main takeaway was the thread in [1], which essentially
boiled down to, "Hard no to this whole patch set, stop trying to push BPF i=
nto
more places and ship random debug patches."

[0]: https://lore.kernel.org/all/20221130082313.3241517-1-tj@kernel.org/
[1]: https://lore.kernel.org/all/Y5b++AttvjzyTTJV@hirez.programming.kicks-a=
ss.net/

3. v2 [2] of the patch set is sent to the list in late January 2023. Nobody
=66rom the scheduler community responds.

[2]: https://lore.kernel.org/bpf/20230128001639.3510083-1-tj@kernel.org/

4. v3 [3] is sent in mid March. Again, no engagement from the scheduler
community.

[3]: https://lore.kernel.org/all/20230317213333.2174969-1-tj@kernel.org/

5. Peter sends this [4] email in a totally separate thread (which you were =
cc'd
on, and we were not) 2 weeks before OSPM:

[4]: https://lore.kernel.org/lkml/20230406103841.GJ386572@hirez.programming=
=2Ekicks-ass.net/

> I'm hoping inter-process UMCG can be used to implement custom libpthread =
that
> would allow running most of userspace under a custom UMCG scheduler and
> obviate the need for this horrible piece of shit eBPF sched thing.

Ok, it's LKML and people say things, but let's be honest here.  You're accu=
sing
_us_ of being malicious and not collaborating with anybody, while you guys =
are
not only ignoring our patch sets, but also slinging ad-hominems about the
project in completely unrelated threads without even cc'ing us.

6. Also before OSPM, Peter sends the initial EEVDF patch set [5]. I replied=
 [6]
(again, before OSPM) explaining that it severely regresses one of our large=
st
and most critical workloads, and got no response from Peter.

Anecdotally, a lot of people have complained to me in private discussions at
various conferences that they're very unhappy about EEVDF, and have asked m=
e to
chime in and say something to prevent it from being merged. I decided not t=
o,
both because I didn't want to waste my time (Peter didn't respond when I
engaged before), and because I thought it would be in poor taste to publicly
try and derail Peter's project while at the same time expecting him to enga=
ge
with us on a project that I knew he wasn't happy about.

[5]: https://lore.kernel.org/lkml/20230328092622.062917921@infradead.org/
[6]: https://lore.kernel.org/lkml/20230410031350.GA49280@maniforge/

Anyways, with all that in mind, when you say this:

> The message people (not only me) perceived was:
>=20
>   "The scheduler sucks, sched_ext solves the problems, saves us millions
>    and Google is happy to work with us [after dropping upstream scheduler
>    development a decade ago and leaving the opens for others to mop up]."
>=20
> followed by:
>=20
>   "You should take it, as it will bring in fresh people to work on the
>    scheduler due to the lower entry barrier [because kernel hacking sucks=
].
>    This will result in great new ideas which will be contributed back to
>    the scheduler proper."
>=20
> That was a really brilliant marketing stunt and I told you so very bluntl=
y.
>=20
> It was presumably not your intention, but that's the problem of
> communication between people. Though I haven't seen an useful attempt to
> cure that.

It's really hard to assume good intent here. If we raise issues on the list,
we're ignored (yes, ignored, not oops it fell through my filter). If we bri=
ng
them up in in-person discussions, we're made out to be complainers who have=
 no
intention of contributing anything. My perception from having attended these
conferences is that there's literally nothing we can say that will make you
guys happy (beyond meekly agreeing to just scrap everything).

On that note, let's talk about OSPM:

7. Chris and I presented [7] at OSPM in mid-April. There was definitely some
useful discussion that took place, but the basic message we received from b=
oth
you and Peter was again, "No, go away." My recollection is that we were
essentially given the same non-technical talking point of, "People will use
this and it will fragment the scheduler space". By the way, Peter also appl=
ied
this "people shouldn't use it" perspective to the debugfs knobs like
migration_cost_ns, which we've also used to optimize our workloads by sever=
al %.

I'm not sure exactly what we're supposed to do with the feedback of,
(paraphrasing) "Just like the debugfs knobs, people will use this thing even
though they shouldn't be." From my perspective, we were just being told to =
not
do something that gives us massive performance wins, with no other suggesti=
ons
or attempts at collaboration. And no, I wouldn't count your suggestion of "=
have
user space send more information to the kernel scheduler" as something we c=
ould
practically use or apply. More on that specific point below.

[7]: https://www.youtube.com/watch?v=3Dw5bLDpVol_M

Now, I do agree with you that in general I could have delivered our message=
 a
bit better. Yes, I did try to make the argument that sched_ext would benefit
fair.c (which I really do still believe), but Juri also gave me feedback
afterwards that my talk probably would have gone over better if I'd first
submitted patches to fair.c to show some good will. Fair enough. I was still
very new to the Linux kernel world at that point, so I'll take the blame for
not really understanding how things are done. Mea culpa. That said, I did
attempt to submit a patch set that applies a lesson we learned from sched_e=
xt
to fair.c, but ultimately got nowhere with it (more on that below).

> After that clash, the room got into a lively technical discussion about t=
he
> real underlying problem, i.e. that a big part of scheduling issues comes
> from the fact, that there is not enough information about the requirements
> and properties of an application available. Even you agreed with that, if=
 I
> remember correctly.

Well, we agreed with you that it might be a good path forward, but you were
also proposing a hand-wavey idea with nothing concrete and no code behind i=
t.
It felt like a deflection at the time, and it feels like one now. Also, let=
's
point out that you apparently didn't feel the need to say anything about how
applications should tell the scheduler about their needs for EEVDF. I'd lov=
e to
know why it wasn't relevant then (again, just two weeks before OSPM).

> sched_ext does not solve that problem. It just works around it by putting
> the requirements and properties of an application into the BPF scheduler
> and the user space portion of it. That works well in a controlled
> environment like yours, but it does not even remotely help to solve the
> underlying general problems. You acknowledged that and told: But we don't
> have it today, though sched_ext is ready and will help with that.
>=20
> The concern that sched_ext will reduce the incentive to work on the
> scheduler proper is not completely unfounded and I've yet to see the
> slightest evidence which proves the contrary.

I think there is a ton of evidence which proves the contrary (XDP, FUSE, et=
c),
but given that Linus already covered this I don=E2=80=99t think we need to =
repeat
ourselves.

Anyways, let's continue going over the timeline.

9. An RFC [8] for the shared wakequeue (later called shared runqueue) patch=
es
is sent in June 2023. This patch set was based on experiments conducted in
sched_ext, and I decided it was important to prioritize this based on the
feedback I was given at OSPM. Peter gave a lot of helpful feedback on this
patch set.

[8]: https://lore.kernel.org/lkml/20230613052004.2836135-1-void@manifault.c=
om/

10. v2 [9] of the SHARED_RUNQ patch set is sent in July 2023. Peter again g=
ives
a lot of useful feedback. The environment in general feels very productive =
and
collaborative, but the patch set isn't quite ready yet.

[9]: https://lore.kernel.org/lkml/20230710200342.358255-1-void@manifault.co=
m/

9. On the same day as the SHARED_RUNQ patches, v4 [10] of the sched_ext pat=
ch
set is sent. After two weeks of silence, Peter decides to respond [11] to t=
his
one with an official NAK, again with no technical or actionable feedback.

[10]: https://lore.kernel.org/lkml/20230711011412.100319-1-tj@kernel.org/
[11]: https://lore.kernel.org/lkml/20230726091752.GA3802077@hirez.programmi=
ng.kicks-ass.net/

10. SHARED_RUNQ v3 [12] is sent in early August. No response from Peter, de=
spite
requesting his input on one or two of the patches. This is an example of why
contributing to the core scheduler is such a pain. I spent at least 3-4 wee=
ks
of time on this patch set, and it ended up going nowhere, partly (but not
entirely) due to Peter disappearing. Frankly, it seems like it got even more
scrutiny than EEVDF did. Eventually, EEVDF ended up causing the feature to =
not
work as well on hackbench [13], so I stopped bothering.

[12]: https://lore.kernel.org/lkml/20230809221218.163894-1-void@manifault.c=
om/
[13]: https://lore.kernel.org/lkml/20231212003141.216236-1-void@manifault.c=
om/

11. I presented on sched_ext at Kernel Recipes [14] in September 2023, which
you attended. In a side-channel conversation that you and I had, you reiter=
ated
your point that you thought we were pushing the completely wrong message by
saying that we think this will help fair.c, and made the request that we do
more to make it clear that there won't be a maintenance burden on scheduler
maintainers and distros. In particular, you asked me to make it more obvious
when a sched_ext scheduler is loaded in the event of a system issue so that
scheduler maintainers and distros could ignore any bug reports that come in=
 for
those scenarios. If we did that, you said, you would work with Peter on com=
ing
up with an amicable solution that left everybody happy, and you would chime=
 in
on the list (just like you said you would to Tejun at the Maintainer's Summ=
it)
to make forward progress.

[14]: https://kernel-recipes.org/en/2023/schedule/sched_ext-pluggable-sched=
uling-in-the-linux-kernel/

After Kernel Recipes, I implemented your request in [15] (see [16] for the
patch in the latest patch set). So your claim that we never did anything to
meet you guys half way on anything is not true. Not only did we actually
implement one of your requests, but our one request to you (to chime in on =
the
list), you never did.

You've said in other threads that you didn't have cycles for 7 months. Ok, =
it
happens and ultimately we=E2=80=99re all volunteers when it comes to upstre=
am work, but
frankly I find it very hard to believe that you had literally no time in a 7
month window to review the patch set. Hearing you say that, while also at t=
he
same time trying to accuse us of being non-collaborative and malicious, fee=
ls a
bit hypocritical to say the least.

[15]: https://github.com/sched-ext/sched_ext/pull/66
[16]: https://lore.kernel.org/bpf/20240618212056.2833381-15-tj@kernel.org/

12. v5 [17] of the series is sent in early November 2023. Once again, we ge=
t no
feedback from anyone in the scheduler community.

[17]: https://lore.kernel.org/bpf/20231111024835.2164816-1-tj@kernel.org/

13. Maintainers Summit 2023 [18] happens. You, Tejun, and Alexei discussed =
the
current situation with sched_ext. You raise some issues you have with
integration, and you agree to bring the discussion to the list, which as we=
 all
know at this point, never happened. You also request that we fix the cgroup
hierarchical scheduling mess, even though our only involvement was updating=
 the
existing CPU controller to use cgroup v2 APIs. This was proposed as a trade=
 for
you talking to Peter and letting sched_ext go in. While we didn=E2=80=99t f=
eel great
about a quid-pro-quo for getting sched_ext merged, we agreed to discuss it =
with
Google and get back to you.

[18]: https://lwn.net/Articles/951847/

14. After maybe 6-ish weeks, we aligned with Google about dedicating resour=
ces
to fixing the cgroup hierarchical scheduling mess, purely as a token of
goodwill to you and Peter. At this point we started trying to send you priv=
ate
pings to coordinate (obviously we weren=E2=80=99t about to sink a ton of ti=
me into it
without circling back with you first). We sent you several private pings
between this point and when v6 landed, with no responses.

> Don't tell me that this is impossible because sched_ext is not yet
> upstream. It's used in production successfully as you said, so there
> clearly must be something to learn from which could be shared at least in
> form of data. OSPM24 would have been a great place for that especially as
> the requirements and properties discussion was continued there with a pla=
n.

15. You can't be serious.

Firstly, sched_ext was discussed at OSPM 2024. Andrea Righi presented [19] =
on
scx_rustland. I wasn't able to attend because I had other obligations, but =
it
was certainly discussed. Also, if you had replied to any of our private pin=
gs
and asked to meet at OSPM 2024, we could have absolutely made time for it.

[19]: https://www.youtube.com/watch?v=3DHQRHo8E_4Ks

But regardless, let's take a moment to reflect on what you're trying to cla=
im
here and in your other emails about our supposed lack of collaboration.  Yo=
u=E2=80=99re
saying we should have used sched_ext to help solve the underlying problems =
in
the scheduler, and that it was a mistake to not attend OSPM 2024?  Here's a
list of what we have done over the last 18 months:

- I've been attending Steven Rostedt's monthly scheduler meeting regularly,=
 and
  have discussed sched_ext at length with many people there; such as Juri,
  Daniel Bristot de Oliveira, Joel Fernandes, Steven, and Youssef Esmat. We=
=E2=80=99ve
  also discussed EEVDF, and possible improvements that could be implemented
  following fruitful sched_ext experiments.
- I've attended and presented at a multitude of other conferences, including
  OSPM 2023, LSFMM (multiple years), KR, and LPC
- Tejun attended the Maintainers Summit in 2023
- We cc'd Peter on every single patch set
- We sent you many private emails

Yet, you=E2=80=99re trying to claim that we should have attended OSPM 2024 =
and shared
some data that could have been used to improve the scheduler, and because we
didn=E2=80=99t, _we=E2=80=99re_ the ones who don=E2=80=99t want to collabor=
ate? Sorry, but any
perceived lack of data sharing on our part is 100% due to your guys=E2=80=
=99 lack of
effort or desire to interact with us in literally any medium, or at any
location. It really feels like you just picked OSPM 2024 because you realiz=
ed
it was the one conference that neither Tejun nor I could attend. For the
record, you didn=E2=80=99t reach out to either of us to discuss meeting the=
re. I would
have made it work if it was important to you guys. Well, come to think of i=
t,
you hadn=E2=80=99t communicated with us in literally any capacity until Lin=
us agreed to
take the series in this patch set, so I guess it goes without saying that y=
ou
didn=E2=80=99t ping us for OSPM 2024.

16. We send out v6 [20], and get public support for the project from two
distros, Valve, Google, ChromeOS, etc. Linus decides that it's time to merge
the project, and now all of a sudden you come out of the woodwork and start
slinging mud and accusing us of not collaborating. And here we are now.

[20]: https://lore.kernel.org/bpf/20240501151312.635565-1-tj@kernel.org/

QED. _That=E2=80=99s_ what's actually happened over the last 18 months. We'=
ve made
repeated attempts to collaborate, even going so far as agreeing to your pri=
vate
request that we fix the cgroup hierarchical mess, in a desperate bid to try=
 and
somehow make you guys happy and enable us to work collaboratively. Yet only=
 now
do you join the conversation, after countless private pings and private
agreements that you didn't honor, once Linus _forced your hand_, only to ac=
cuse
us of being unwilling to cooperate?

If I sound indignant, it=E2=80=99s because I am. You guys made the decision=
 to approach
every single conversation with the singular purpose of trying to get the
project derailed. Fine, I understand that you don't like it, and that you
probably wouldn't have implemented pluggable scheduling with BPF if you had=
 a
choice. But to now come in at the 11th hour and try to blame _us_ for not
collaborating with you, when it was you who ignored emails, slung mud, and
failed to honor spoken agreements, is pretty brazen.

All of that said, we of course remain committed to all the things we've said
about working together with the community upstream. I actually totally agree
with you that it would be a good idea to clean up the integration points. As
we've said before, we didn't do that originally because we were trying to h=
ave
as small of a footprint as possible in code the that you guys would have to
deal with (which by the way was also in line with the feedback you gave me =
at
KR). But no worries, now that the record is cleared, we=E2=80=99re happy to=
 move
forward and work with you. It=E2=80=99s been our goal the entire time.

> At all other occasions, I sat down with people and discussed at a technic=
al
> level, but also clearly asked to resolve the social rift which all of this
> created.

As mentioned above, this was discussed in person, but you never met us half
way. There's only so much we can do if you choose to ignore all of our priv=
ate
email pings and ghost us for 7 months (actually closer to 10 months if you
count our discussion at KR 2023).

Chris responded to the rest of your email, so I'll cut my already excessive=
ly
long reply here. The one last thing that I do want to say that I really hop=
e we
can eventually put this ugliness behind us. I admire how you think about and
approach software engineering, and I would love for your input on how we ca=
n do
things better. I'm sorry that this reply had to be so serious and accusator=
y,
but you forced our hand by approaching this entire conversation this way, a=
nd
by being blatantly dishonest about our private discussions and private effo=
rts
to reach out to you to collaborate. Hopefully we can have beers in Vienna, =
and
move on.

Thanks,
David

--F5DrM9diCmshJWRE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZnnwcQAKCRBZ5LhpZcTz
ZAL7APwK7nbIt93zrwZgtahYXOJsF2wKLNLCRXIU2xaRUg6i5AD+OcQJrqh0rDKi
phTvWkF3rIsMgFx96koV8yPWRg/tgAQ=
=bstx
-----END PGP SIGNATURE-----

--F5DrM9diCmshJWRE--

