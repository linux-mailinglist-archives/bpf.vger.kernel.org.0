Return-Path: <bpf+bounces-30521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B894A8CEA02
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 20:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCCAB1C21DCB
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 18:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8AE3FBB3;
	Fri, 24 May 2024 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="T7i5tDEb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5015043AA5
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 18:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716576374; cv=none; b=MpbXrd/UFpjOHVgGROeG7FrJFoVjDjHKy9ewXTlN5TJCvmUMk2eq5vPVHzcvRJjoLoMiV10XqusSNeiIKAJkUbNVVSSTrJa5jAMcDFDg1hOwQ1I0Z483NEDqMpcJpxzbEFmfU+t4+ihrAzUoCScz7tUx9psT3YcqPHuFx0jFwfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716576374; c=relaxed/simple;
	bh=oCcHEioeUHWeB+rCTGFAQCXqnucRBC66uUbp/f59S88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OLI2HpmC/e/aC9ixYox6xRJLOdjbKaGSQ893xOWggn5LxXQWx0bRUVhIssHZEHO/3ICM0ovQqOaSJM8nWO1Y++dZ4ZEmC/ct0jUQQVcW9T/8OcfDCclSgI7xYmQVyq5/59E1Rie/skJJL8EdErFdTgLoX3/NvBFNDS6wGPPXsdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=T7i5tDEb; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-62a0849f8e5so12059117b3.2
        for <bpf@vger.kernel.org>; Fri, 24 May 2024 11:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1716576371; x=1717181171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2FWXBCNPyQsEnwltCWlP5sfOQFKqhWQbJhPVoTrj0E=;
        b=T7i5tDEbfhUHxLAB/IftmrSpYUZXmd4XFJcpT1WVDBjb80w65mribSW0wVecqa0Tiz
         Z3f2uvACAvtUpfoFhqedyiVIH2OyvTJvrEazkbIO4OVIO7YoKD35YS1YwtqHk/HpSMuP
         0WjQLAJOR2VzbCcFuES2Xwa+6UnErI2mUSXbA0AkSECcPo+cXvLrUvBH3wB+kJaQ6i2Y
         TvznpbEzXk8sOp1Zs0eulkqYyQ5pz/o7lZgZBuMm+S04Y/vfz8P3QGTvM8Y2xCMcG/Lg
         /wthW8BtNQV6vKQ2XnQ5ZrFS56mteG3Rnb5WGMKfd+pKtpPLhfkQxNQHcJR7gi01aN3a
         wHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716576371; x=1717181171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2FWXBCNPyQsEnwltCWlP5sfOQFKqhWQbJhPVoTrj0E=;
        b=KGacT5OkrFPQBMPHdtrJ3BIBLntV0kwm6X+Oz56mUhTXiOJV0anfvoM8CAlwqxXh8n
         5UtrYLOZbXWNq5wFEXb81uuUqfO8brvz4uU0gqV/8uuunkMzQisZHpBrSM7pXCUMT95a
         FBWTickN3QSqOVHUJPXC3I0/l2iN2aOST1XR/3jSV1p5Ww9noEJ+IZMFtrVLuQzRtTUm
         D8QOHrE9Uu9ayTWgiS8IYK2W6DuBBGIKECrvDtd/VWuEkFhkAy2QHRJThviT8bwqSH3K
         1XKZySdC/EFgoQ55CXz9y52EQdOE8b/zTb95uZ/ddOpXTqSIOpRxCtfe3rqcdoP7gHWa
         oX5g==
X-Forwarded-Encrypted: i=1; AJvYcCU96ryb4NvwUsnjcgZAZCQ689+3nfjJJ8uvyqzQhucgv1ffNwbZCapXG7be6n7JxjQzKrXCklW0i0nUgmTW/f+t47U7
X-Gm-Message-State: AOJu0YyNDoc/SmDKBndgZUYQ7nmdNWfqdQrkD8sW35LOFiXE8EsLAPmL
	dK3A/u4LqKF2AzzTHCRJ45rma8Ydb4G7fndfaDidEo669lR7mjZfmhOjzwYImLIcXv3oKOclR4t
	ArOjDdszcP6WSr7zk6H2py+9/tQ2vD85JnF7E
X-Google-Smtp-Source: AGHT+IGSennbM7YvqfgcaeObBxPRBZDd1xaGv2TD3zbKwxgBJwpUVk/UODLUNieFIjb/K+xHK3VSPEbulmCWoBJ10Uw=
X-Received: by 2002:a0d:cc89:0:b0:627:970a:fc1 with SMTP id
 00721157ae682-62a08ec439fmr29819797b3.41.1716576371004; Fri, 24 May 2024
 11:46:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410140141.495384-1-jhs@mojatatu.com> <41736ea4e81666e911fee5b880d9430ffffa9a58.camel@redhat.com>
 <CAM0EoM=982OctjvSQpx0kR7e+JnQLhvZ=sM-tNB4xNiu7nhH5Q@mail.gmail.com>
 <CAM0EoM=VhVn2sGV40SYttQyaiCn8gKaKHTUqFxB_WzKrayJJfQ@mail.gmail.com>
 <87cf4830e2e46c1882998162526e108fb424a0f7.camel@redhat.com>
 <CAM0EoMkJwR0K-fF7qo0PfRw4Sf+=2L0L=rOcH5A2ELwagLrZMw@mail.gmail.com>
 <CAM0EoMmfDoZ9_ZdK-ZjHjFAjuNN8fVK+R57_UaFqAm=wA0AWVA@mail.gmail.com>
 <82ee1013ca0164053e9fb1259eaf676343c430e8.camel@redhat.com>
 <CAADnVQLugkg+ahAapskRaE86=RnwpY8v=Nre8pn=sa4fTEoTyA@mail.gmail.com>
 <CAM0EoM=2wHem54vTeVq4H1W5pawYuHNt-aS9JyG8iQORbaw5pA@mail.gmail.com>
 <CAM0EoMmCz5usVSLq_wzR3s7UcaKifa-X58zr6hkPXuSBnwFX3w@mail.gmail.com>
 <CAM0EoMmsB5jHZ=4oJc_Yzm=RFDUHWh9yexdG6_bPFS4_CFuiog@mail.gmail.com>
 <20240522151933.6f422e63@kernel.org> <CAM0EoMmFrp5X5OzMbum5i_Bjng7Bhtk1YvWpacW6FV6Oy-3avg@mail.gmail.com>
 <SN6PR17MB211069668AF4C8031B116B9D96EB2@SN6PR17MB2110.namprd17.prod.outlook.com>
 <CAOuuhY9b6WZd6eunVGr6QQ=sd7KLvx7OVn4ozzon3+ABRQaYeQ@mail.gmail.com>
 <CAM0EoMmXYL6DYc8UogPpS1W2rXyT0Z8JTewLonb9Eze=ofsYOg@mail.gmail.com>
 <SN6PR17MB2110A8E11C444ABF8167D12296F42@SN6PR17MB2110.namprd17.prod.outlook.com>
 <CAOuuhY9LOcuaP-fB+h+t6ABGvSTLvOfunSO14bADmc2NejAvjg@mail.gmail.com> <CAOuuhY_ggc-SvYXwkJ_eZpo-EOYtg8e13Vs8paKGQXepJPt_RA@mail.gmail.com>
In-Reply-To: <CAOuuhY_ggc-SvYXwkJ_eZpo-EOYtg8e13Vs8paKGQXepJPt_RA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 24 May 2024 14:45:59 -0400
Message-ID: <CAM0EoM=xgsuLKUkeU-3iQRvrXp=_JPX=0P+NtbTfok4cX2eN0w@mail.gmail.com>
Subject: Re: DSL vs low level language WAS(Re: On the NACKs on P4TC patches
To: Tom Herbert <tom@sipanda.io>
Cc: Chris Sommers <chris.sommers@keysight.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Network Development <netdev@vger.kernel.org>, "Chatterjee, Deb" <deb.chatterjee@intel.com>, 
	Anjali Singhai Jain <anjali.singhai@intel.com>, "Limaye, Namrata" <namrata.limaye@intel.com>, 
	Marcelo Ricardo Leitner <mleitner@redhat.com>, "Shirshyad, Mahesh" <Mahesh.Shirshyad@amd.com>, 
	"Osinski, Tomasz" <tomasz.osinski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Cong Wang <xiyou.wangcong@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Khalid Manaa <khalidm@nvidia.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	"Jain, Vipin" <Vipin.Jain@amd.com>, "Daly, Dan" <dan.daly@intel.com>, 
	Andy Fingerhut <andy.fingerhut@gmail.com>, Matty Kadosh <mattyk@nvidia.com>, bpf <bpf@vger.kernel.org>, 
	"lwn@lwn.net" <lwn@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 12:50=E2=80=AFPM Tom Herbert <tom@sipanda.io> wrote=
:
>
> Hi Chris,
>
> P4 was created to support programming the hardware data path in high
> end routers, but P4-TC would enable the use of P4 across all Linux
> devices. Since this is potentially a lot of code going into the kernel
> to support it, I believe it's entirely fair for us to evaluate and
> give feedback on the P4 language and its suitability for the broader
> user community including environments where there will never be a need
> for P4 hardware. Note that I am questioning the design decisions of P4
> in the context of supporting a DSL in the kernel via P4-TC, if the
> P4->eBPF compiler is used then then these concerns are less pertinent.
> Nevertheless, I would suggest that the P4 folks take the points being
> raised as constructive feedback on the language.
>

A lot of misleading info there. The P4 PNA architecture is for end
hosts not routers. For some NIC vendors you can go as far as writting
hardware GRO or TSO offload or variations of your liking  using P4
(cretainly not a middle feature). That notwithstanding the idea of
offloading match-action via TC is not new and has been widely
used/adopted for end hosts.

Tom, you want to perhaps disclose that you have a competing product?
That will help provide better context on your angle.
TBH, I am confused by what your end game is - is your view that a
crusade against P4 will make you sell more of your product? I have 3
NICs here with me (from 2 vendors) that are P4 programmable. You can
be as negative as you want about P4 but you are not going to make it
go away, sorry.

I will let Chris or whoever else on Cc respond to the P4 bits if they
wishe because there's misunderstanding there as well.

cheers,
jamal


> I took a cursory look at several P4 programs including tutorials,
> switch code, firewalls, etc. I have particular interest in variable
> length headers, so I'll use
> https://github.com/jafingerhut/p4-guide/blob/master/checksum/checksum-ipv=
4-with-options.p4
> as a reference.
>
> The first thing I noticed about P4 is that almost everything is
> expressed as a bit field. Like bit<8> and bit<32>. I suppose this
> arises from the fact that P4 was originally intended to run in non-CPU
> hardware where there's no inherent unit of data like bytes. But, CPUs
> don't work that way; CPUs work ordinal types of bytes, half words,
> words, double words, etc. (__u8, __u16, __u32, __u64). That means that
> all mainstream computer languages fundamentally operate on ordinal
> types even if the variable types are explicitly declared. If someone
> programming in P4 needs to map original types to bit fields in P4, so
> if they want a __u32 they need to use a bit<32> in P4 (except they're
> not exactly equivalent, a __u32 in C is guaranteed to be byte aligned
> and I'm assuming in P4 bit<32> is not guaranteed to be byte aligned--
> this seems like it might be susceptible to programming errors). I'd
> also point out that networking protocols are also defined using
> ordinal type fields, there are some exceptions, but for the most part
> protocol fields try to be in units of bytes (or octets if you want to
> be old school!). I believe life would be easier for the programmer if
> they could just define variables and fields with ordinal types, the
> fix here seems simple enough just add typedefs to P4 like "typedef
> __u32 bit<32>".
>
> In the IP header definition there's "varbit<320>  options;". It took
> me several seconds to decode this and realize this is space for forty
> bytes of IP options (i.e. 8 * 40 =3D=3D 320). I suppose this follows the
> design of using bit fields for everything, but I think this is more
> than just an annoyance like the bit fields for ordinal types are.
> First off, it's not very readable. I've never heard anyone say that
> there's 320 bits of IP options, or seen an RFC specify that. Likewise,
> the standard Ethernet MTU is 1500 bytes, not 12,000 bits which would
> seem to be how that would be expressed in P4. So this seems very
> unreadable to me and potentially prone to errors. The fix for this
> also seems easy, why not just add varbyte to P4 so we can do
> varbyte<40>, varbyte<87>, varbyte<123>, etc.?
>
> The next thing I notice about the P4 programs I surveyed is that all
> of them seem to define the protocol headers within the protocol. Every
> program seems to have "header ethernet_t" and "header ipv4_t" and
> other protocols that are used and protocol constants like Ethertypes
> also seem to be spelled out in each program. Sometimes these are in
> include files within the program. What I don't see is that P4 has a
> standard set of include files for defining protocol headers. For
> instance, in Linux C we would just do "#include <linux/if_ether.h>"
> and "#include <linux/ip.h>" to get the definitions of the Ethernet
> header and IPv4 header. In fact, if someone were to submit a patch to
> Netdev that included its own definition of Ethernet or an IP header
> structure they would almost certainly get pushback. It's a fundamental
> programming principle, not just in networking but pretty much
> everywhere, to not continuously redefine common and standard
> constructs-- just put common things in header files that can be shared
> by multiple programs (to do otherwise substantially increases the
> possibility of errors, bloats code, and reduces readability).
>
> Marshalling up common definitions into header files that are common in
> the P4 development environment seems simple enough (maybe it's already
> done?), but I would also point out that Linux has included files that
> describe protocol formats and header structures for almost every
> protocol under the sun that are well tested. It would be great if
> somehow we could somehow leverage that work. For instance, in the P4
> samples I looked at srcAddr and dstAddr are defined for IP addresses,
> but in linux/ip.h their saddr and daddr are the respective field
> names. Why not just base the P4 definition on the Linux one? Then when
> someone is porting code from Linux to P4 they can use the same field
> names-- this makes things a lot easier on the programmer! I'll also
> mention that we wrote a little Python script to generate P4 header and
> constant definitions from Linux headers. It almost worked, the snag we
> hit was that P4 has some limits on nesting structures and unions so we
> couldn't translate some of the C structures to P4 (if you're
> interested I can provide the details on the problem we hit).
>
> The IPv4 header checksum code was a real head scratcher for me. Do we
> really need to state each field in the IP header just to compute the
> checksum? (and not just do this once, but twice :-( ). See code below
> for verifyChecksum and updateChecksum.
>
> In C, verifying and setting the IP header checksum is really easy:
>
> if (checksum(iphdr, 0, iphdr->ihl << 4))
>     goto bad_csum;
>
> ip->csum =3D checksum(iphdr, 0, iphdr->ihl << 4);
>
> Relative to the C code, the P4 code seems very convoluted to me and
> prone to errors. What if someone accidentally omits a field? What if
> fields become slightly out of order? Also, no one would ever describe
> the IPv4 checksum as taking the checksum over the IHL, diffserv,
> totalLen, ... That is *way* too complicated for an algorithm that is
> really simple-- from RFC791: "The checksum field is the 16 bit one's
> complement of the one's complement sum of all 16 bit words in the
> header.". Reverse engineering the design, the clue seems to be
> HashAlgorithm.csum16. Maybe in P4 the IP checksum is just considered
> another form of hash, and I suspect the input to hash computation is
> specified as sort of data structure to make things generic (for
> instance, how we create a substructure in flow keys in flow_dissector
> to compute a SipHash over the TCP and UDP tuple). But, the IPv4
> checksum isn't just another hash-- on a host, we need to compute the
> checksum for *every* IPv4 packet. This has to be fast and simple, we
> can do this in as few as five instructions or less. So even if the
> code below is correct, I have to wonder how easy it is to emit an
> efficient executable. Would a compiler easily realize that all the
> fields in the pseudo structure are contiguous without holes such that
> it can omit those five instructions?
>
> I don't know how prevalent this method of listing all the fields in a
> data structure as arguments to a function is in P4, but, by almost any
> objective measure, I have to say that the code below is bad and
> bloated. Maybe there's a better way to do it in P4, but if there's not
> then this is a deficiency in the P4 language.
>
> Tom
>
> control verifyChecksum(inout headers hdr,
>                        inout metadata meta)
> {
>     apply {
>         // There is code similar to this in Github repo p4lang/p4c in
>         // file testdata/p4_16_samples/flowlet_switching-bmv2.p4
>         // However in that file it is only for a fixed length IPv4
>         // header with no options.
>         verify_checksum(true,
>             { hdr.ipv4.version,
>                 hdr.ipv4.ihl,
>                 hdr.ipv4.diffserv,
>                 hdr.ipv4.totalLen,
>                 hdr.ipv4.identification,
>                 hdr.ipv4.flags,
>                 hdr.ipv4.fragOffset,
>                 hdr.ipv4.ttl,
>                 hdr.ipv4.protocol,
>                 hdr.ipv4.srcAddr,
>                 hdr.ipv4.dstAddr
> #ifdef ALLOW_IPV4_OPTIONS
>                 , hdr.ipv4.options
> #endif /* ALLOW_IPV4_OPTIONS */
>             },
>             hdr.ipv4.hdrChecksum, HashAlgorithm.csum16);
>     }
> }
>
> control updateChecksum(inout headers hdr,
>                        inout metadata meta)
> {
>     apply {
>         update_checksum(true,
>             { hdr.ipv4.version,
>                 hdr.ipv4.ihl,
>                 hdr.ipv4.diffserv,
>                 hdr.ipv4.totalLen,
>                 hdr.ipv4.identification,
>                 hdr.ipv4.flags,
>                 hdr.ipv4.fragOffset,
>                 hdr.ipv4.ttl,
>                 hdr.ipv4.protocol,
>                 hdr.ipv4.srcAddr,
>                 hdr.ipv4.dstAddr
> #ifdef ALLOW_IPV4_OPTIONS
>                 , hdr.ipv4.options
> #endif /* ALLOW_IPV4_OPTIONS */
>             },
>             hdr.ipv4.hdrChecksum, HashAlgorithm.csum16);
>     }
> }
>
> On Wed, May 22, 2024 at 8:34=E2=80=AFPM Tom Herbert <tom@sipanda.io> wrot=
e:
> >
> > On Wed, May 22, 2024 at 7:30=E2=80=AFPM Chris Sommers
> > <chris.sommers@keysight.com> wrote:
> > >
> > > > On Wed, May 22, 2024 at 8:54=E2=80=AFPM Tom Herbert <mailto:tom@sip=
anda.io> wrote:
> > > > >
> > > > > On Wed, May 22, 2024 at 5:09=E2=80=AFPM Chris Sommers
> > > > > <mailto:chris.sommers@keysight.com> wrote:
> > > > > >
> > > > > > > On Wed, May 22, 2024 at 6:19=E2=80=AFPM Jakub Kicinski <mailt=
o:kuba@kernel.org> wrote:
> > > > > > > >
> > > > > > > > Hi Jamal!
> > > > > > > >
> > > > > > > > On Tue, 21 May 2024 08:35:07 -0400 Jamal Hadi Salim wrote:
> > > > > > > > > At that point(v16) i asked for the series to be applied d=
espite the
> > > > > > > > > Nacks because, frankly, the Nacks have no merit. Paolo wa=
s not
> > > > > > > > > comfortable applying patches with Nacks and tried to medi=
ate. In his
> > > > > > > > > mediation effort he asked if we could remove eBPF - and o=
ur answer was
> > > > > > > > > no because after all that time we have become dependent o=
n it and
> > > > > > > > > frankly there was no technical reason not to use eBPF.
> > > > > > > >
> > > > > > > > I'm not fully clear on who you're appealing to, and I may b=
e missing
> > > > > > > > some points. But maybe it will be more useful than hurtful =
if I clarify
> > > > > > > > my point of view.
> > > > > > > >
> > > > > > > > AFAIU BPF folks disagree with the use of their subsystem, a=
nd they
> > > > > > > > point out that P4 pipelines can be implemented using BPF in=
 the first
> > > > > > > > place.
> > > > > > > > To which you reply that you like (a highly dated type of) a=
 netlink
> > > > > > > > interface, and (handwavey) ability to configure the data pa=
th SW or
> > > > > > > > HW via the same interface.
> > > > > > >
> > > > > > > It's not what I "like" , rather it is a requirement to suppor=
t both
> > > > > > > s/w and h/w offload. The TC model is the traditional approach=
 to
> > > > > > > deploy these models. I addressed the same comment you are mak=
ing above
> > > > > > > in #1a and #1b  (https://urldefense.com/v3/__https://github.c=
om/p4tc-dev/pushback-patches__;!!I5pVk4LIGAfnvw!kaZ6EmPxEqGLG8JMw-_L0BgYq48=
Pe25wj6pHMF6BVei5WsRgwMeLQupmvgvLyN-LgXacKBzzs0-w2zKP2A$).
> > > > >> >
> > > > > > > OTOH, "BPF folks disagree with the use of their subsystem" is=
 a
> > > > > > > problematic statement. Is BPF infra for the kernel community =
or is it
> > > > > > > something the ebpf folks can decide, at their whim, to allow =
who they
> > > > > > > like to use or not. We are not changing any BPF code. And the=
re's
> > > > > > > already a case where the interfaces are used exactly as we us=
ed them
> > > > > > > in the conntrack code i pointed to in the page (we literally =
copied
> > > > > > > that code). Why is it ok for conntrack code to use exactly th=
e same
> > > > > > > approach but not us?
> > > > > > >
> > > > > > > > AFAICT there's some but not very strong support for P4TC,
> > > > > > >
> > > > > > > I dont agree. Paolo asked this question and afaik Intel, AMD =
(both
> > > > > > > build P4-native NICs) and the folks interested in the MS DASH=
 project
> > > > > > > responded saying they are in support. Look at who is being Cc=
ed. A lot
> > > > > > > of these folks who attend biweekly discussion calls on P4TC. =
Sample:
> > > > > > > https://urldefense.com/v3/__https://lore.kernel.org/netdev/IA=
0PR17MB7070B51A955FB8595FFBA5FB965E2@IA0PR17MB7070.namprd17.prod.outlook.co=
m/__;!!I5pVk4LIGAfnvw!kaZ6EmPxEqGLG8JMw-_L0BgYq48Pe25wj6pHMF6BVei5WsRgwMeLQ=
upmvgvLyN-LgXacKBzzs09TFzoQBw$
> > > > >> >
> > > > > > +1
> > > > > > > > and it
> > > > > > > > doesn't benefit or solve any problems of the broader networ=
king stack
> > > > > > > > (e.g. expressing or configuring parser graphs in general)
> > > > > > > >
> > > > > > >
> > > > > >
> > > > > > Huh? As a DSL, P4 has already been proven to be an extremely ef=
fective and popular way to express parse graphs, stack manipulation, and st=
ateful programming. Yesterday, I used the P4TC dev branch to implement some=
thing in one sitting, which includes parsing RoCEv2 network stacks. I just =
cut and pasted P4 code originally written for a P4 ASIC into a working P4TC=
 example to add functionality. It took mere seconds to compile and launch i=
t, and a few minutes to test it. I know of no other workflow which provides=
 such quick turnaround and is so accessible. I'd like it to be as ubiquitou=
s as eBPF itself.
> > > > >
> > > > > Chris,
> > > > >
> > > > > When you say "it took mere seconds to compile and launch" are you
> > > > > taking into account the ramp up time that it takes to learn P4 an=
d
> > > > > become proficient to do something interesting?
> > >
> > > Hi Tom, thanks for the dialog. To answer your question, it took secon=
ds to compile and deploy, not learn P4. Adding the parsing for several head=
ers took minutes. If you want to compare learning curve, learning to write =
P4 code and let the framework handle all the painful low-level Linux detail=
s is way easier than trying to learn how to write c code for Linux networki=
ng. It=E2=80=99s not even close. I=E2=80=99ve written C for 40 years, P4 fo=
r 7 years, and dabbled in eBPF so I can attest to the ease of learning and =
using P4. I=E2=80=99ve onboarded and mentored engineers who barely knew C, =
to develop complex networking products using P4, and built the automation A=
PIs (REST, gRPC) to manage them. One person can develop an entire commercia=
l product by themselves in months. P4 has expanded the reach of programmers=
 such that both HW and SW engineers can easily learn P4 and become pretty a=
dept at it. I would not expect even experienced c programmers to be able to=
 master Linux internals very quickly. Writing a P4-TC program and injecting=
 it via tc was like magic the first time.
> > >
> > > >> Considering that P4
> > > > > syntax is very different from typical languages than networking
> > > > > programmers are typically familiar with, this ramp up time is
> > > > > non-zero. OTOH, eBPF is ubiquitous because it's primarily program=
med
> > > > > in Restricted C-- this makes it easy for many programmers since t=
hey
> > > > > don't have to learn a completely new language and so the ramp up =
time
> > > > > for the average networking programmer is much less for using eBPF=
.
> > >
> > > I think your statement about =E2=80=9Ctypical network programmers=E2=
=80=9D overlooks the fact that since P4 was introduced, it has been taught =
in many universities to teach networking and possibly enabled a whole new b=
reed of =E2=80=9Cnetwork engineers=E2=80=9D who can solve real problems wit=
hout even knowing C programming. Without P4 they might never have gone this=
 route. A class in network stack programming using c would have so many pre=
requisites to even get to parsing, compared to P4, where it could be demons=
trated in one lesson. These =E2=80=9Cnetworking programmers=E2=80=9D are no=
t typical by your standards, but there are many such. They have just as muc=
h claim to the title "network programmer=E2=80=9D as a C programmer. Simila=
rly, an assembly language programmer is no less than a C or Python programm=
er. People writing P4 are usually focused on applications, and it is very u=
seful and productive for that. Why should someone have to learn low-level C=
 or eBPF to solve their problem?
> >
> > Hio Chris,
> >
> > You're comparing learning a completely new language versus programming
> > in a subset of an established language, they're really not comparable.
> > When one programs in Restricted-C they just need to understand what
> > features of C are supported.
> >
> > >
> > > > >
> > > > > This is really the fundamental problem with DSLs, they require
> > > > > specialized skill sets in a programming language for a narrow use=
 case
> > > > > (and specialized compilers, tool chains, debugging, etc)-- this m=
eans
> > > > > a DSL only makes sense if there is no other means to accomplish t=
he
> > > > > same effects using a commodity language with perhaps a specialize=
d
> > > > > library (it's not just in the networking realm, consider the
> > > > > advantages of using CUDA-C instead of a DLS for GPUs).
> > >
> > > A pretty strong opinion, but DSLs arise to fill a need and P4 did so.=
 It's still going strong.
> > >
> > > >> Personally, I
> > > > > don't believe that P4 has yet to be proven necessary for programm=
ing a
> > > > > datapath-- for instance we can program a parser in declarative
> > > > > representation in C,
> > > > > https://urldefense.com/v3/__https://netdevconf.info/0x16/papers/1=
1/High*20Performance*20Programmable*20Parsers.pdf__;JSUl!!I5pVk4LIGAfnvw!m9=
zrSDvddfzSt_sMBjOEvqw31RzAwWlEDM4ah5IJ2kqsmq6XtPIVJd-1_ZoGWBXKLyda77RYLvGR8=
3Ginw$.
> > >
> > > CPL (slide11) looks like a DSL wrapped in JSON to me. =E2=80=9CSoluti=
on: Common Parser Language (CPL); Parser representation in declarative .jso=
n=E2=80=9D So I am confused. It is either a new language a.k.a. DSL, or it'=
s not. Nothing against it, I'm sure it is great, but let's call it what it =
is.
> >
> > Correct, it's not a new language. We've since renamed it Common Parser
> > Representation.
> >
> > > We already have parser representations in declarative p4. And it's us=
ed and known worldwide. And has a respectable specification, any users and =
working groups. And it's formally provable (https://github.com/verified-net=
work-toolchain/petr4)
> > >
> > > > >
> > > > > So unless P4 is proven necessary, then I'm doubtful it will ever =
be a
> > > > > ubiquitous way to program the kernel-- it seems much more likely =
that
> > > > > people will continue to use C and eBPF, and for those users that =
want
> > > > > to use P4 they can use P4->eBPF compiler.
> > >
> > > =E2=80=9Cubiquitous way to program the kernel=E2=80=9D =E2=80=93 is n=
ot my goal. I don=E2=80=99t even want to know about the kernel when I am wr=
iting p4 - it's just a means to an end. I want to manipulate packets on a L=
inux host. P4DPDK, P4-eBPF, P4-TC =E2=80=93 all let me do that. I LOVE the =
fact that P4-TC would be available in every Linux distro once upstreamed. I=
t would solve so many deployment issues, benefit from regression testing, e=
tc. So much goodness
> > >
> > > " and for those users that want to use P4 they can use P4->eBPF compi=
ler." -I'd really like to choose for myself and not have someone make that =
choice for me. P4-TC checks all the boxes for me.
> >
> > Sure, but this is a lot of kernel code and that will require support
> > and maintenance. It needs to be justified, and the fact that someone
> > wants it just to have a choice is, frankly, not much of a
> > justification. I think a justification needs to start with "Why isn't
> > P4->eBPF sufficient?" (the question has been raised several times, but
> > it still doesn't seem like there's a strong answer).
> >
> > Tom
> > >
> > > Thanks for the point of view, it's healthy to debate.
> > > Cheers,
> > > Chris
> > >
> > > > >
> > > >
> > > > Tom,
> > > > I cant stop the distraction of this thread becoming a discussion on
> > > > the merits of DSL vs a lower level language (and I know you are not=
 a
> > > > P4 fan) but please change the subject so we dont loose the main foc=
us
> > > > which is a discussion on the patches. I have done it for you. Chris=
 if
> > > > you wish to respond please respond under the new thread subject.
> > > >
> > > > cheers,
> > > > jamal
> > >

