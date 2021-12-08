Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0828046D812
	for <lists+bpf@lfdr.de>; Wed,  8 Dec 2021 17:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbhLHQ2k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Dec 2021 11:28:40 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:34473 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236849AbhLHQ2j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Dec 2021 11:28:39 -0500
Received: by mail-wm1-f51.google.com with SMTP id m25-20020a7bcb99000000b0033aa12cdd33so3675050wmi.1;
        Wed, 08 Dec 2021 08:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=1dq1PGR9a+dV9KxuHDbL+QAxY448etpnTQT/e0ZxtxA=;
        b=FbJtOD2p/ihA8C5jxsLFt330pWX1dybDcw4Q7CjiWOimEbActscG+VdCYeZjaX+7va
         y7E+/6bU10uXXzfrJkrLEFSi/XAAzsk+TjobBoRT2DYsMLoZ4iuP2Sw8bjr28sAodoiK
         EsYhg1YI8eEIcjndz0O1oT18kAZHVfwBV03fruMeM5TU3qFAqMP9PUpBIcGEq5BDgYDK
         lQb6mZJ2h7VsYt1D8YlLr4lirM1WHJ+r9L/ZmqqF6PQEo3aSXCKAJdNNcXkbid+S6dEG
         3XJLKwRc7mIf1viPtcKSogey4SSpFfQePX5CLDrCxru7Lf9dnuadk7rSM6aGej81T6ji
         2xLg==
X-Gm-Message-State: AOAM531tkFuNAOEuWfy6Fw+5BvHINsWhwdtNN330mHXSAqmxbIasSFCQ
        H10v61j/KFg4Ado8upJBL30=
X-Google-Smtp-Source: ABdhPJzva96+072aKMPj226m4z6yl0o0Xh4WXXH6Knb18w7eqLH6lrkrt28PU0isWK0xMDGK8bQJWw==
X-Received: by 2002:a1c:1bd8:: with SMTP id b207mr17388490wmb.114.1638980705449;
        Wed, 08 Dec 2021 08:25:05 -0800 (PST)
Received: from localhost ([137.220.125.106])
        by smtp.gmail.com with ESMTPSA id b188sm3224169wmd.45.2021.12.08.08.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 08:25:04 -0800 (PST)
Message-ID: <f63bef1a56b12a06ed980f9b5e094f84f2434333.camel@debian.org>
Subject: Re: [PATCH bpf-next 0/3] bpf: add signature
From:   Luca Boccassi <bluca@debian.org>
To:     John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@linux.microsoft.com>
Cc:     bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        keyrings@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Wed, 08 Dec 2021 16:25:02 +0000
In-Reply-To: <7ae146389b58f521166e9569be6c64f87359777a.camel@debian.org>
References: <20211203191844.69709-1-mcroce@linux.microsoft.com>
         <CAADnVQLDEPxOvGn8CxwcG7phy26BKuOqpSQ5j7yZhZeEVoCC4w@mail.gmail.com>
         <CAFnufp1_p8XCUf-RdHpByKnR9MfXQoDWw6Pvm_dtuH4nD6dZnQ@mail.gmail.com>
         <CAADnVQ+DSGoF2YoTrp2kTLoFBNAgdU8KbcCupicrVGCWvdxZ7w@mail.gmail.com>
         <86e70da74cb34b59c53b1e5e4d94375c1ef30aa1.camel@debian.org>
         <CAADnVQLCmbUJD29y2ovD+SV93r8jon2-f+fJzJFp6qZOUTWA4w@mail.gmail.com>
         <CAFnufp2S7fPt7CKSjH+MBBvvFu9F9Yop_RAkX_3ZtgtZhRqrHw@mail.gmail.com>
         <CAADnVQ+WLGiQvaoTPwu_oRj54h4oMwh-z5RV0WAMFRA9Wco_iA@mail.gmail.com>
         <61aae2da8c7b0_68de0208dd@john.notmuch>
         <0079fd757676e62f45f28510a5fd13a9996870be.camel@debian.org>
         <61ae75487d445_c5bd20827@john.notmuch>
         <7ae146389b58f521166e9569be6c64f87359777a.camel@debian.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-0Y5oZJfdkXaEQuFlRvRC"
User-Agent: Evolution 3.38.3-1+plugin 
MIME-Version: 1.0
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--=-0Y5oZJfdkXaEQuFlRvRC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2021-12-06 at 22:59 +0000, Luca Boccassi wrote:
> On Mon, 2021-12-06 at 12:40 -0800, John Fastabend wrote:
> > Luca Boccassi wrote:
> >=20
> > cutting to just the relevant pieces here.
> >=20
> > [...]
> >=20
> > >=20
> > > > I'll give the outline of the argument here.
> > > >=20
> > > > I do not believe signing BPF instructions for real programs
> > > > provides
> > > > much additional security. Given most real programs if the
> > > > application
> > > > or loader is exploited at runtime we have all sorts of trouble.
> > > > First
> > > > simply verifying the program doesn't prevent malicious use of the
> > > > program. If its in the network program this means DDOS, data
> > > > exfiltration,
> > > > mitm attacks, many other possibilities. If its enforcement
> > > > program
> > > > most enforcement actions are programmed from this application so
> > > > system
> > > > security is lost already.=C2=A0 If its observability application
> > > > simply
> > > > drops/manipulates observations that it wants. I don't know of any
> > > > useful programs that exist in isolation without user space input
> > > > and output as a critical component. If its not a privileged user,
> > > > well it better not be doing anything critical anyways or disabled
> > > > outright for the security focused.
> > > >=20
> > > > Many critical programs can't be signed by the nature of the
> > > > program.
> > > > Optimizing network app generates optimized code at runtime.
> > > > Observability
> > > > tools JIT the code on the fly, similarly enforcement tools will
> > > > do
> > > > the
> > > > same. I think the power of being able to optimize JIT the code in
> > > > application and give to the kernel is something we will see more
> > > > and
> > > > more of. Saying I'm only going to accept signed programs, for a
> > > > distribution or something other than niche use case, is non
> > > > starter
> > > > IMO because it breaks so many real use cases. We should encourage
> > > > these optimizing use cases as I see it as critical to performance
> > > > and keeping overhead low.
> > > >=20
> > > > From a purely security standpoint I believe you are better off
> > > > defining characteristics an application is allowed to have. For
> > > > example allowed to probe kernel memory, make these helpers calls,
> > > > have this many instructions, use this much memory, this much cpu,
> > > > etc. This lets you sandbox a BPF application (both user space and
> > > > kernel side) much nicer than any signing will allow.
> > > >=20
> > > > If we want to 'sign' programs we should do that from a BPF
> > > > program
> > > > directly where other metadata can be included in the policy. For
> > > > example having a hash of the program loaded along with the calls
> > > > made and process allows for rich policy decisions. I have other
> > > > use cases that need a hash/signature for data blobs, so its on
> > > > my todo list but not at the top yet.=C2=A0 But, being able to verif=
y
> > > > arbitrary blob of data from BPF feels like a useful operation to
> > > > me
> > > > in general. The fact in your case its a set of eBPF insns and in
> > > > my case its some key in a network header shouldn't matter.
> > > >=20
> > > > The series as is, scanned commit descriptions, is going to break
> > > > lots of in-use-today programs if it was ever enabled. And
> > > > is not as flexible (can't support bpftrace, etc.) or powerful
> > > > (can't consider fine grained policy decisions) as above.
> > > >=20
> > > > Add a function we can hook after verify (or before up for
> > > > debate) and helpers to verify signatures and/or generate
> > > > hashes and we get a better more general solution. And it can
> > > > also solve your use case even if I believe its not useful and
> > > > may break many BPF users running bpftrace, libbpf, etc.
> > > >=20
> > > > Thanks,
> > > > John
> > >=20
> > > Hello John,
> > >=20
> > > Thank you for the summary, this is much clearer.
> > >=20
> > > First of all, I think there's some misunderstanding: this series
> > > does
> > > not enable optional signatures by default, and does not enable
> > > mandatory signatures by default either. So I don't see how it would
> > > break existing use cases as you are saying? Unless I'm missing
> > > something?
> > >=20
> > > There's a kconfig to enable optional signatures - if they are
> > > there,
> > > they are verified, if they are not present then nothing different
> > > happens. Unless I am missing something, this should be backward
> > > compatible. This kconfig would likely be enabled in most use cases,
> > > just like optionally signed kernel modules are.
> >=20
> > Agree, without enforcement things should continue to work.
> >=20
> > >=20
> > > Then there's a kconfig on top of that which makes signatures
> > > mandatory.
> > > I would not imagine this to be enabled in may cases, just in custom
> > > builds that have more stringent requirements. It certainly would
> > > not be
> > > enabled in generalist distros. Perhaps a more flexible way would be
> > > to
> > > introduce a sysctl, like fsverity has with
> > > 'fs.verity.require_signatures'? That would be just fine for our use
> > > case. Matteo can we do that instead in the next revision?
> >=20
> > We want to manage this from BPF side directly. It looks
> > like policy decision and we have use cases that are not as
> > simple as yes/no with global switch. For example, in k8s world
> > this might be enabled via labels which are user specific per
> > container
> > policy. e.g. lockdown some containers more strictly than others.
> >=20
> > >=20
> > > Secondly, I understand that for your use case signing programs
> > > would
> > > not be the best approach. That's fine, and I'm glad you are working
> > > on
> > > an alternative that better fits your model, it will be very
> > > interesting
> > > to see how it looks like once implemented. But that model doesn't
> > > fit
> > > all cases. In our case at Microsoft, we absolutely want to be able
> > > to
> > > pre-define at build time a list of BPF programs that are allowed to
> > > be
> > > loaded, and reject anything else. Userspace processes in our case
> > > are
> >=20
> > By building this into BPF you can get the 'reject anything else'
> > policy
> > and I get the metadata + reject/accept from the same hook. Its
> > just your program can be very simple.
> >=20
> > > mostly old and crufty c++ programs that can most likely be pwned by
> > > looking at them sideways, so they get locked down hard with
> > > multiple
> > > redundant layers and so on and so forth. But right now for BPF you
> > > only
> > > have a "can load BPF" or "cannot load BPF" knob, and that's it.
> > > This is
> > > not good enough: we need to be able to define a list of allowed
> > > payloads, and be able to enforce it, so when (not if) said
> > > processes do
> > > get tricked into loading something else, it will fail, despite
> > > having
> >=20
> > Yikes, this is a bit scary from a sec point of view right? Are those
> > programs read-only maps or can the C++ program also write into the
> > maps and control plane. Assuming they do some critical functions then
> > you really shouldn't be trusting them to not do all sorts of other
> > horrible things. Anyways not too important to this discussion.
> >=20
> > I'll just reiterate (I think you get it though) that simply signing
> > enforcement doesn't mean now BPF is safe. Further these programs
> > have very high privileges and can do all sorts of things to the
> > system. But, sure sig enforcement locks down one avenue of loading
> > bogus program.
>=20
> Oh it's terrifying - but business needs and all that.
> But Arnaldo is spot on - it's not strictly about what is more secure,
> but more about making it a known quantity. If we can prove what is
> allowed to run and what not before any machine has even booted (barring
> bugs in sig verification, of course) then the $org_security_team is
> satisfied and can sign off on enabling bpf. Otherwise we can keep
> dreaming.
>=20
> > > the capability of calling bpf(). Trying to define heuristics is
> > > also
> > > not good enough for us - creative malicious actors have a tendency
> > > to
> > > come up with ways to chain things that individually are allowed and
> > > benign, but combined in a way that you just couldn't foresee. It
> > > would
> >=20
> > Sure, but I would argue some things can be very restrictive and
> > generally useful. For example, never allow kernel memory read could
> > be
> > enforced from BPF side directly. Never allow pkt redirect, etc.
> >=20
> > > certainly cover a lot of cases, but not all. A strictly pre-defined
> > > list of what is allowed to run and what is not is what we need for
> > > our
> > > case, so that we always know exactly what is going to run and what
> > > is
> > > not, and can deal with the consequences accordingly, without nasty
> > > surprises waiting around the corner. Now in my naive view the best
> > > way
> > > to achieve this is via signatures and certs, as it's a well-
> > > understood
> > > system, with processes already in place to revoke/rotate/etc, and
> > > it's
> > > already used for kmods. An alternative would be hard-coding hashes
> > > I
> > > guess, but that would be terribly inflexible.
> >=20
> > Another option would be to load your programs at boot time,
> > presumably
> > with trusted boot enabled and then lock down BPF completely. Then
> > ensure all your BPF 'programs' are read-only from user<->kernel
> > interface and this should start looking fairly close to what you
> > want and all programs are correct by root of trust back to
> > trusted boot. Would assume you know what programs to load at boot
> > though. May or may not be a big assumption depending on your env.
>=20
> One of the use cases we have for BPF is on-demand diagnostics, so
> loading at boot and blocking afterwards would not work, I think.
> Environment is constrained in terms of resources, so don't want to load
> anything that is not needed.
>=20
> > >=20
> > > Now in terms of _how_ the signatures are done and validated, I'm
> > > sure
> > > there are multiple ways, and if some are better than what this
> > > series
> > > implements, then that's not an issue, it can be reworked. But the
> > > core
> > > requirement for us is: offline pre-defined list of what is allowed
> > > to
> > > run and what is not, with ability for hard enforcement that cannot
> > > be
> > > bypassed. Yes, you lose some features like JIT and so on: we don't
> > > care, we don't need those for our use cases. If others have
> > > different
> > > needs that's fine, this is all intended to be optional, not
> > > mandatory.
> > > There are obviously trade-offs, as always when security is
> > > involved,
> > > and each user can decide what's best for them.
> > >=20
> > > Hope this makes sense. Thanks!
> >=20
> > I think I understand your use case. When done as BPF helper you
> > can get the behavior you want with a one line BPF program
> > loaded at boot.
> >=20
> > int verify_all(struct bpf_prog **prog) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return verify_signature=
(prog->insn,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prog->len * sizeof(struct b=
pf_insn),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 signature, KEYRING, BPF_SIGTYPE)=
;
> > }
> >=20
> > And I can write some more specific things as,
> >=20
> > int verify_blobs(void data) {
> > =C2=A0 int reject =3D verify_signature(data, data_len, sig, KEYRING, TY=
PE);
> > =C2=A0 struct policy_key *key =3D map_get_key();
> >=20
> > =C2=A0 return policy(key, reject);=C2=A0=20
> > }
> >=20
> > map_get_key() looks into some datastor with the policy likely using
> > 'current' to dig something up. It doesn't just apply to BPF progs
> > we can use it on other executables more generally. And I get more
> > interesting use cases like, allowing 'tc' programs unsigned, but
> > requiring kernel memory reads to require signatures or any N
> > other policies that may have value. Or only allowing my dbg user
> > to run read-only programs, because the dbg maybe shouldn't ever
> > be writing into packets, etc. Driving least privilege use cases
> > in fine detail.
> >=20
> > By making it a BPF program we side step the debate where the kernel
> > tries to get the 'right' policy for you, me, everyone now and in
> > the future. The only way I can see to do this without getting N
> > policies baked into the kernel and at M different hook points is via
> > a BPF helper.
> >=20
> > Thanks,
> > John
>=20
> Now this sounds like something that could work - we can prove that this
> could be loaded before any writable fs comes up anywhere, so in
> principle I think it would be acceptable and free of races. Matteo, we
> should talk about this tomorrow.
> And this requires some infrastructure work right? Is there a WIP git
> tree somewhere that we can test out?
>=20
> Thank you!

One question more question: with the signature + kconfig approach,
nothing can disable the signature check. But if the signature checker
is itself a bpf program, is there/can there be anything stopping root
from unloading it?

--=20
Kind regards,
Luca Boccassi

--=-0Y5oZJfdkXaEQuFlRvRC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmGw3F8ACgkQKGv37813
JB4rwBAAoIH7ow4Du5ft00MPeurq7Z2qGirL4/buKLq7yPn9MRU/ou55DcwrACIY
L9k5uDIcj1s1zLBCgPOFLIXJDashq7KlxpfpSevJdcYEjNwH9VM8LLrujcmfmuIq
+U+NPv6mRrxJIJPGJ5urrM3v5QvTj/NBjUwqQRNbLWvZp7duKODyOCtHu8iCy0IO
nbqpQPI/x+OCMqNZEaMLm/BTRI53mWsHY92ZHFLBXb7tOsLnlW2QVJJ+Wa3q7O6l
OkVPFrDLMVZ2Qv9bvjbVw/Zy3X00FHBFPo8fJzricihvYBk96G5U0O0pU/6UOeix
UFjdCodssvY/NDodA4tv82uzYxfTTW41XPFF/6F9oOpE9xaZ62CoXqi8u6MY6pQO
g2GW4pmCjAcq0EPTfZFTwmPVEZUCry8X23zzjNS+K21tT7qwohsk+Iay2n3IXXqR
R2uyYZqKbgFWb9zjbVop/x3jpCrumawt5sEmC1e0kbYeCzUrHpjsmcX7eP6Z9eEp
WLQleIK85BkSHTu5RSqCVv77sF78HbOBvbFJ13qRc3pTo6ciGzMoH6HNr75ixZlu
9vg/GiZyoZjLAxrzAYqxWN75VPg6qx82WO3MzCHtk0D1SC716oJzjHH0ccnR8CQi
LgtHgIhs5S1UNDsOKY+RO2MOk4swXpq+lf1SxWCkKw6QT4NDAcs=
=/OoV
-----END PGP SIGNATURE-----

--=-0Y5oZJfdkXaEQuFlRvRC--
