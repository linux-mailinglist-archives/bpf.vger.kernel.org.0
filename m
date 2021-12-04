Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F764684D6
	for <lists+bpf@lfdr.de>; Sat,  4 Dec 2021 13:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384934AbhLDMkv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Dec 2021 07:40:51 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:38502 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbhLDMkv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Dec 2021 07:40:51 -0500
Received: by mail-wm1-f45.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso6922514wms.3;
        Sat, 04 Dec 2021 04:37:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=JMTGL4aDDh/oM5Lx+zdqid80CKODx8RvS35FK7rI+EY=;
        b=H4ajX5UWNzjdxWMpVxmhRozj2oXBSk3z9XCMS0nZ74931GLkdQQANmP39D/EB6VnJ4
         DJRKWC4Ip9/1u8vRhnv2YwkiBHY5ibnXYdjnxkNKZftHZR0nTHksjkyt+k7/6fsEh5Tn
         ATafA8lfwIaHpCWRj6nxkU9LrSeTese+m8HSIeQJ6y1NFQ4jGwMYd17uTJ5DMhezKrPO
         KZchPvE/LqFnEeKHWOaghehNXgdpzpRDdeYly0Ix+8ktUXq7NX+NSctbfpOJ4XNluChj
         /DMnPg+kKj0SMN1kH4f0TBAAbXwQtm8fEk1Pl6A4lY19qr0w2DU8MmGXWhyQ0oX7JAmg
         YviQ==
X-Gm-Message-State: AOAM531wES9k86Vq4GSD7viywNnxSUvMqu1WzJIQ55rxnS29I8ZDmEvC
        r6K6oqxXJ+MOmD5p0xcR2AE=
X-Google-Smtp-Source: ABdhPJy9DoKeHpA1DLSMR1cWh3Ki+E8yerGb7AiYQQew+XoSLSaxSBFdbC1iKZ/nr+V+MiJtpSi+6Q==
X-Received: by 2002:a1c:9d03:: with SMTP id g3mr22432138wme.143.1638621444563;
        Sat, 04 Dec 2021 04:37:24 -0800 (PST)
Received: from localhost ([2a01:4b00:f41a:3600:df86:cebc:8870:2184])
        by smtp.gmail.com with ESMTPSA id n32sm9235060wms.1.2021.12.04.04.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 04:37:23 -0800 (PST)
Message-ID: <0079fd757676e62f45f28510a5fd13a9996870be.camel@debian.org>
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
Date:   Sat, 04 Dec 2021 12:37:19 +0000
In-Reply-To: <61aae2da8c7b0_68de0208dd@john.notmuch>
References: <20211203191844.69709-1-mcroce@linux.microsoft.com>
         <CAADnVQLDEPxOvGn8CxwcG7phy26BKuOqpSQ5j7yZhZeEVoCC4w@mail.gmail.com>
         <CAFnufp1_p8XCUf-RdHpByKnR9MfXQoDWw6Pvm_dtuH4nD6dZnQ@mail.gmail.com>
         <CAADnVQ+DSGoF2YoTrp2kTLoFBNAgdU8KbcCupicrVGCWvdxZ7w@mail.gmail.com>
         <86e70da74cb34b59c53b1e5e4d94375c1ef30aa1.camel@debian.org>
         <CAADnVQLCmbUJD29y2ovD+SV93r8jon2-f+fJzJFp6qZOUTWA4w@mail.gmail.com>
         <CAFnufp2S7fPt7CKSjH+MBBvvFu9F9Yop_RAkX_3ZtgtZhRqrHw@mail.gmail.com>
         <CAADnVQ+WLGiQvaoTPwu_oRj54h4oMwh-z5RV0WAMFRA9Wco_iA@mail.gmail.com>
         <61aae2da8c7b0_68de0208dd@john.notmuch>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-crIOEqa5c+934Qzf2TlR"
User-Agent: Evolution 3.42.1-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--=-crIOEqa5c+934Qzf2TlR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-12-03 at 19:39 -0800, John Fastabend wrote:
> Alexei Starovoitov wrote:
> > On Fri, Dec 3, 2021 at 4:42 PM Matteo Croce
> > <mcroce@linux.microsoft.com> wrote:
> > >=20
> > > On Fri, Dec 3, 2021 at 11:20 PM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >=20
> > > > On Fri, Dec 3, 2021 at 2:06 PM Luca Boccassi <bluca@debian.org>
> > > > wrote:
> > > > >=20
> > > > > On Fri, 2021-12-03 at 11:37 -0800, Alexei Starovoitov wrote:
> > > > > > On Fri, Dec 3, 2021 at 11:36 AM Matteo Croce
> > > > > > <mcroce@linux.microsoft.com> wrote:
> > > > > > >=20
> > > > > > > On Fri, Dec 3, 2021 at 8:22 PM Alexei Starovoitov
> > > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > > >=20
> > > > > > > > On Fri, Dec 3, 2021 at 11:18 AM Matteo Croce
> > > > > > > > <mcroce@linux.microsoft.com> wrote:
> > > > > > > > >=20
> > > > > > > > > From: Matteo Croce <mcroce@microsoft.com>
> > > > > > > > >=20
> > > > > > > > > This series add signature verification for BPF files.
> > > > > > > > > The first patch implements the signature validation
> > > > > > > > > in the
> > > > > > > > > kernel,
> > > > > > > > > the second patch optionally makes the signature
> > > > > > > > > mandatory,
> > > > > > > > > the third adds signature generation to bpftool.
> > > > > > > >=20
> > > > > > > > Matteo,
> > > > > > > >=20
> > > > > > > > I think I already mentioned that it's no-go as-is.
> > > > > > > > We've agreed to go with John's suggestion.
> > > > > > >=20
> > > > > > > Hi,
> > > > > > >=20
> > > > > > > my previous attempt was loading a whole ELF file and
> > > > > > > parsing it in
> > > > > > > kernel.
> > > > > > > In this series I just validate the instructions against a
> > > > > > > signature,
> > > > > > > as with kernel CO-RE libbpf doesn't need to mangle it.
> > > > > > >=20
> > > > > > > Which suggestion? I think I missed this one..
> > > > > >=20
> > > > > > This talk and discussion:
> > > > > > https://linuxplumbersconf.org/event/11/contributions/947/
> > > > >=20
> > > > > Thanks for the link - but for those of us who don't have ~5
> > > > > hours to
> > > > > watch a video recording, would you mind sharing a one line
> > > > > summary,
> > > > > please? Is there an alternative patch series implementing BPF
> > > > > signing
> > > > > that you can link us so that we can look at it? Just a link
> > > > > or
> > > > > googlable reference would be more than enough.
> > > >=20
> > > > It's not 5 hours and you have to read slides and watch
> > > > John's presentation to follow the conversation.
> > >=20
> > > So, If I have understood correctly, the proposal is to validate
> > > the
> > > tools which loads the BPF (e.g. perf, ip) with fs-verity, and
> > > only
> > > allow BPF loading from those validated binaries?
> > > That's nice, but I think that this could be complementary to the
> > > instructions signature.
> > > Imagine a validated binary being exploited somehow at runtime,
> > > that
> > > could be vector of malicious BPF program load.
> > > Can't we have both available, and use one or other, or even both
> > > together depending on the use case?
> >=20
> > I'll let John comment.
>=20
> I'll give the outline of the argument here.
>=20
> I do not believe signing BPF instructions for real programs provides
> much additional security. Given most real programs if the application
> or loader is exploited at runtime we have all sorts of trouble. First
> simply verifying the program doesn't prevent malicious use of the
> program. If its in the network program this means DDOS, data
> exfiltration,
> mitm attacks, many other possibilities. If its enforcement program
> most enforcement actions are programmed from this application so
> system
> security is lost already.=C2=A0 If its observability application simply
> drops/manipulates observations that it wants. I don't know of any
> useful programs that exist in isolation without user space input
> and output as a critical component. If its not a privileged user,
> well it better not be doing anything critical anyways or disabled
> outright for the security focused.
>=20
> Many critical programs can't be signed by the nature of the program.
> Optimizing network app generates optimized code at runtime.
> Observability
> tools JIT the code on the fly, similarly enforcement tools will do
> the
> same. I think the power of being able to optimize JIT the code in
> application and give to the kernel is something we will see more and
> more of. Saying I'm only going to accept signed programs, for a
> distribution or something other than niche use case, is non starter
> IMO because it breaks so many real use cases. We should encourage
> these optimizing use cases as I see it as critical to performance
> and keeping overhead low.
>=20
> From a purely security standpoint I believe you are better off
> defining characteristics an application is allowed to have. For
> example allowed to probe kernel memory, make these helpers calls,
> have this many instructions, use this much memory, this much cpu,
> etc. This lets you sandbox a BPF application (both user space and
> kernel side) much nicer than any signing will allow.
>=20
> If we want to 'sign' programs we should do that from a BPF program
> directly where other metadata can be included in the policy. For
> example having a hash of the program loaded along with the calls
> made and process allows for rich policy decisions. I have other
> use cases that need a hash/signature for data blobs, so its on
> my todo list but not at the top yet.=C2=A0 But, being able to verify
> arbitrary blob of data from BPF feels like a useful operation to me
> in general. The fact in your case its a set of eBPF insns and in
> my case its some key in a network header shouldn't matter.
>=20
> The series as is, scanned commit descriptions, is going to break
> lots of in-use-today programs if it was ever enabled. And
> is not as flexible (can't support bpftrace, etc.) or powerful
> (can't consider fine grained policy decisions) as above.
>=20
> Add a function we can hook after verify (or before up for
> debate) and helpers to verify signatures and/or generate
> hashes and we get a better more general solution. And it can
> also solve your use case even if I believe its not useful and
> may break many BPF users running bpftrace, libbpf, etc.
>=20
> Thanks,
> John

Hello John,

Thank you for the summary, this is much clearer.

First of all, I think there's some misunderstanding: this series does
not enable optional signatures by default, and does not enable
mandatory signatures by default either. So I don't see how it would
break existing use cases as you are saying? Unless I'm missing
something?

There's a kconfig to enable optional signatures - if they are there,
they are verified, if they are not present then nothing different
happens. Unless I am missing something, this should be backward
compatible. This kconfig would likely be enabled in most use cases,
just like optionally signed kernel modules are.

Then there's a kconfig on top of that which makes signatures mandatory.
I would not imagine this to be enabled in may cases, just in custom
builds that have more stringent requirements. It certainly would not be
enabled in generalist distros. Perhaps a more flexible way would be to
introduce a sysctl, like fsverity has with
'fs.verity.require_signatures'? That would be just fine for our use
case. Matteo can we do that instead in the next revision?

Secondly, I understand that for your use case signing programs would
not be the best approach. That's fine, and I'm glad you are working on
an alternative that better fits your model, it will be very interesting
to see how it looks like once implemented. But that model doesn't fit
all cases. In our case at Microsoft, we absolutely want to be able to
pre-define at build time a list of BPF programs that are allowed to be
loaded, and reject anything else. Userspace processes in our case are
mostly old and crufty c++ programs that can most likely be pwned by
looking at them sideways, so they get locked down hard with multiple
redundant layers and so on and so forth. But right now for BPF you only
have a "can load BPF" or "cannot load BPF" knob, and that's it. This is
not good enough: we need to be able to define a list of allowed
payloads, and be able to enforce it, so when (not if) said processes do
get tricked into loading something else, it will fail, despite having
the capability of calling bpf(). Trying to define heuristics is also
not good enough for us - creative malicious actors have a tendency to
come up with ways to chain things that individually are allowed and
benign, but combined in a way that you just couldn't foresee. It would
certainly cover a lot of cases, but not all. A strictly pre-defined
list of what is allowed to run and what is not is what we need for our
case, so that we always know exactly what is going to run and what is
not, and can deal with the consequences accordingly, without nasty
surprises waiting around the corner. Now in my naive view the best way
to achieve this is via signatures and certs, as it's a well-understood
system, with processes already in place to revoke/rotate/etc, and it's
already used for kmods. An alternative would be hard-coding hashes I
guess, but that would be terribly inflexible.

Now in terms of _how_ the signatures are done and validated, I'm sure
there are multiple ways, and if some are better than what this series
implements, then that's not an issue, it can be reworked. But the core
requirement for us is: offline pre-defined list of what is allowed to
run and what is not, with ability for hard enforcement that cannot be
bypassed. Yes, you lose some features like JIT and so on: we don't
care, we don't need those for our use cases. If others have different
needs that's fine, this is all intended to be optional, not mandatory.
There are obviously trade-offs, as always when security is involved,
and each user can decide what's best for them.

Hope this makes sense. Thanks!

--=20
Kind regards,
Luca Boccassi

--=-crIOEqa5c+934Qzf2TlR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE6g0RLAGYhL9yp9G8SylmgFB4UWIFAmGrYP8ACgkQSylmgFB4
UWLJvAgAiNTM+Wuz9ey4Fwz7HSpZd3qNX0Peast5rARfdue2DsqYAHVTtb1ZjhiL
glXQOA1YGhv8tEOG6Mg7jj8R9x716nwP34G5Y4yCueUOgsDnvz/xM7IUJDIAo+OZ
cr4bu4YNeiRmMZ2yb86zFuqoB6CsSi0jks0VXm70Yf9zlCjlNjhq9levnrbYpDYN
HFRb011hUY6NZIcnX75o2vu5Lt3N/csM9NuFkmh3pbuP/Mb5JdPOwEykAYCotyPp
dTIWs57YozQacgnKJWALP8JUnsnfeqDV0FW07ImNsXfPszBdKXHE/gUf3n2jdfDY
eSFrSF+HjgrynbpMoNsvFpdH9PU8lA==
=rr01
-----END PGP SIGNATURE-----

--=-crIOEqa5c+934Qzf2TlR--
