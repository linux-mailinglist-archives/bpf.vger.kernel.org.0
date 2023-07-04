Return-Path: <bpf+bounces-4000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D76747947
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 22:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF13728109C
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 20:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2348494;
	Tue,  4 Jul 2023 20:48:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1133D79CC
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 20:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9CEC433C8;
	Tue,  4 Jul 2023 20:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688503737;
	bh=za+CAfYB+aFtoqGr9CgvQWZEZ8vUe0tG0AU+RZx6wk0=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=gfbMHxA2JabY5+dspp4AszO+onHu4bQ3+Ex9KIS9MOFwuFoHFOJB8I3VSwfNsQR/u
	 VEM0XJeJ7/HpNSUq8B2e4gLeG9QZ5+dM0lWPwbYLlhc6FcMDX2wU+o5ZKDUcKK2Wp6
	 QvzYEH98vcHhsaHP8ZB4rkCaRysMuKYGltPJjRbZ/zGlNwaWgMb8ss92qYKsVXFrY9
	 kseJOlQHgjL3YQJ70StH5OLMcJNf2LwJJ53sVvZYxJLV1GEz6jQG1Kgu0QFmcHY2+S
	 A2dQ64Kx3evwhIpja+1req8xLOQPleWL4pKCBqbdSbtmTTYyXHZ7f/HGRnTIgCeuVt
	 ZMPwMvf42yWEQ==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id 1251F27C005B;
	Tue,  4 Jul 2023 16:48:56 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Tue, 04 Jul 2023 16:48:56 -0400
X-ME-Sender: <xms:t4WkZIhuAjoFqZTAghHdN5-BgU3z4_mlAXZmUfekv_lekDnr2XSBvw>
    <xme:t4WkZBBcrf9Nys-2MerBk53maTnqsuDqhlyoUd3jsKyLY5DwP6ifP7G1JU4l4_CI4
    oQHRbPNmJiXykxUaw8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeggdduhedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeduveffvdegvdefhfegjeejlefgtdffueekudfgkeduvdetvddu
    ieeluefgjeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:t4WkZAHrplOO6VuYClISj62XAN290MCMAYhEfHZGzAOugyGfc23ksg>
    <xmx:t4WkZJRhBF02ICsYhaWkUvEV9f8Z8UHRMrzuLcRlS0fDyoaXL5m7GQ>
    <xmx:t4WkZFxIPBP0K8LGM_rngs5lPuPp0tKPKAtZH8RVnEVRHPOYVRePUQ>
    <xmx:uIWkZMmVWp8HXf6S3NTLSEIkI3D7q2yRcDVmZU6pUuKfg29A_axt3g>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5995931A0063; Tue,  4 Jul 2023 16:48:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-527-gee7b8d90aa-fm-20230629.001-gee7b8d90
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <640eeef7-48df-464e-a49f-d7ee31193e04@app.fastmail.com>
In-Reply-To: <77fc8c9b-220f-da93-c6b8-a8f36eb1086f@iogearbox.net>
References: <20230607235352.1723243-1-andrii@kernel.org>
 <c1a8d5e8-023b-4ef9-86b3-bdd70efe1340@app.fastmail.com>
 <CAEf4BzazbMqAh_Nj_geKNLshxT+4NXOCd-LkZ+sRKsbZAJ1tUw@mail.gmail.com>
 <a73da819-b334-448c-8e5c-50d9f7c28b8f@app.fastmail.com>
 <CAEf4Bzb__Cmf5us1Dy6zTkbn2O+3GdJQ=khOZ0Ui41tkoE7S0Q@mail.gmail.com>
 <5eb4264e-d491-a7a2-93c7-928b06ce264d@redhat.com>
 <bc4f99af-0c46-49b2-9f2d-9a01e6a03af3@app.fastmail.com>
 <5a75d1f0-4ed9-399c-4851-2df0755de9b5@redhat.com>
 <CAEf4Bza9GvJ0vw2-0M8GKSXmOQ8VQCmeqEiQpMuZBjwqpA03vw@mail.gmail.com>
 <82b79e57-a0ad-4559-abc9-858e0f51fbba@app.fastmail.com>
 <9b0e9227-4cf4-4acb-ba88-52f65b099709@app.fastmail.com>
 <173f0af7-e6e1-f4b7-e0a6-a91b7a4da5d7@iogearbox.net>
 <fe47aeb6-dae8-43a6-bcb0-ada2ebf62e08@app.fastmail.com>
 <8340aaf2-8b4c-4f7d-8eed-f72f615f6fd0@app.fastmail.com>
 <77fc8c9b-220f-da93-c6b8-a8f36eb1086f@iogearbox.net>
Date: Tue, 04 Jul 2023 13:48:35 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii.nakryiko@gmail.com>,
 "Maryam Tahhan" <mtahhan@redhat.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, "Kees Cook" <keescook@chromium.org>,
 "Christian Brauner" <brauner@kernel.org>, lennart@poettering.net,
 cyphar@cyphar.com, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Mon, Jun 26, 2023, at 8:23 AM, Daniel Borkmann wrote:
> On 6/24/23 5:28 PM, Andy Lutomirski wrote:
>> On Sat, Jun 24, 2023, at 6:59 AM, Andy Lutomirski wrote:
>>> On Fri, Jun 23, 2023, at 4:23 PM, Daniel Borkmann wrote:
>>>
>>> If this series was about passing a =E2=80=9Cmay load kernel modules=E2=
=80=9D token
>>> around, I think it would get an extremely chilly reception, even tho=
ugh
>>> we have module signatures.  I don=E2=80=99t see anything about BPF t=
hat makes
>>> BPF tokens more reasonable unless a real security model is developed
>>> first.
>>=20
>> To be clear, I'm not saying that there should not be a mechanism to u=
se BPF from a user namespace.  I'm saying the mechanism should have expl=
icit access control.  It wouldn't need to solve all problems right away,=
 but it should allow incrementally more features to be enabled as the ac=
cess control solution gets more powerful over time.
>>=20
>> BPF, unlike kernel modules, has a verifier.  While it would be a depa=
rture from current practice, permission to use BPF could come with an ex=
plicit list of allowed functions and allowed hooks.
>>=20
>> (The hooks wouldn't just be a list, presumably -- premission to insta=
ll an XDP program would be scoped to networks over which one has CAP_NET=
_ADMIN, presumably.  Other hooks would have their own scoping.  Attachin=
g to a cgroup should (and maybe already does?) require some kind of perm=
ission on the cgroup.  Etc.)
>>=20
>> If new, more restrictive functions are needed, they could be added.
>
> Wasn't this the idea of the BPF tokens proposal, meaning you could=20
> create them with
> restricted access as you mentioned - allowing an explicit subset of=20
> program types to
> be loaded, subset of helpers/kfuncs, map types, etc.. Given you pass i=
n=20
> this token
> context upon program load-time (resp. map creation), the verifier is=20
> then extended
> for restricted access. For example, see the=20
> bpf_token_allow_{cmd,map_type,prog_type}()
> in this series. The user namespace relation was part of the use cases,=20
> but not strictly
> part of the mechanism itself in this series.

Hmm. It's very coarse grained.

Also, the bpf() attach API seems to be largely (completely?) missing wha=
t I would expect to be basic access controls on the things being attache=
d to.   For example, the whole cgroup_bpf_prog_attach() path seems to be=
 entirely missing any checks as to whether its caller has any particular=
 permission over the cgroup in question.  It doesn't even check whether =
the cgroup is being accessed from the current userns (i.e. whether the f=
d refers to a struct file with f_path.mnt belonging to the current usern=
s).  So the API in this patchset has no way to restrict permission to at=
tach to cgroups to only apply to cgroups belonging to the container.

>
> With regards to the scoping, are you saying that the current design=20
> with the bitmasks
> in the token create uapi is not flexible enough? If yes, what concrete=20
> alternative do
> you propose?
>
>> Alternatively, people could try a limited form of BPF proxying.  It w=
ouldn't need to be a full proxy -- an outside daemon really could approv=
e the attachment of a BPF program, and it could parse the program, exami=
ne the list of function it uses and what the proposed attachment is to, =
and make an educated decision.  This would need some API changes (maybe)=
, but it seems eminently doable.
>
> Thinking about this from an k8s environment angle, I think this=20
> wouldn't really be
> practical for various reasons.. you now need to maintain two=20
> implementations for your
> container images which ships BPF one which loads programs as today, an=
d=20
> another one
> which talks to this proxy if available,=20

This seems fairly trivially solvable. Agree on an API, say using UNIX so=
ckets to /var/run/bpfd/whatever.socket.  (Or maybe /var/lib?  I=E2=80=99=
m not sure there=E2=80=99s universal agreement on where things like this=
 to.) The exact same API works uncontained (bpfd running, probably socke=
t-activated) from a binary in the system and as a bind-mount from outsid=
e.

I don=E2=80=99t know k8s well at all, but it looks like hostPath can do =
exactly this.  Off the top of my head, I don=E2=80=99t know whether syst=
emd=E2=80=99s .socket can be configured the right way so the same config=
uration would work contained and uncontained.  One could certainly work =
around *that* by having two different paths tried in succession, but tha=
t seems a bit silly.

This actually seems easier than supplying bpf tokens to a container.

> then you also need to=20
> standardize and support
> the various loader libraries for this, you need to deal with yet one=20
> more component
> in your cluster which could fail (compared to talking to kernel=20
> directly), and being
> dependent on new proxy functionality becomes similar as with waiting=20
> for new kernels
> to hit mainstream, it could potentially take a very long time until=20
> production upgrades.
> What is being proposed here in this regard is less complex given no=20
> extra proxy is
> involved. I would certainly prefer a kernel-based solution.

A userspace solution makes it easy to apply some kind of flexible approv=
al and audit policy to the BPF program. I can imagine all kinds of ways =
that a fleet operator might want to control what can run, and trying to =
stick it in the kernel seems rather complex and awkward to customize.

I suppose a bpf token could be set up to call out to its creator for per=
mission to load a program, which would involve a different set of tradeo=
ffs.

