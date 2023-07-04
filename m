Return-Path: <bpf+bounces-4001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 601B974796B
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 23:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22CB7280EB2
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 21:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40F4847C;
	Tue,  4 Jul 2023 21:05:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAF2EB8
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 21:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4EEC433C9;
	Tue,  4 Jul 2023 21:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688504730;
	bh=KybVYTt61qPnmhPxFn/Z7pbG7wxb/XkG0YZlw0Xrkfc=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=TN5b5B7R9pMZxafmMCIXYgUCqxhzGiczQ6sKta0yWMZTmaUN3SLNSGkmGtU8tUE3H
	 BaqlQszrc30HIwhJ3FMDj4yWEQk+/K5sOkKtgbjF336pf9RWXJO+c4zH4JzmWwWsvb
	 DC+lBXNqNUSuqx0fUi/znngsWoai/4JOe2gT9FctZmjD1/k+ZOg8uSb6uVGoa51CA5
	 JRyoAyGu2jW1p1B2ycH1Cm4SfyqAFE3S9TtQx25Z1b37o8ND7+r+QL3jgJZ6aeU8tc
	 bN9wrShDzGImyGoTsePTpk2av16U7CqN5fI/SiCxctJhy4jaxCmVV8XzXIN8oV0X3w
	 1j1OteGpN+ANg==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id 2B88627C0054;
	Tue,  4 Jul 2023 17:05:29 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Tue, 04 Jul 2023 17:05:29 -0400
X-ME-Sender: <xms:mImkZGJ5k9hL77kQnyTz_z5ePg_lsBWJXxdQ-0rLc2HpeDpVuJu6cQ>
    <xme:mImkZOLWJuCGvE7eeSDCwPbG6V4550uxfp5uKgfjLToQ-uO8TimyS2HRi3upbrLdH
    RuMRfrWTqcNGqXcKFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeggdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeduveffvdegvdefhfegjeejlefgtdffueekudfgkeduvdetvddu
    ieeluefgjeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:mImkZGviUGGkj8sjk2mxe56ydb6N_2Wb7wdcLR-kA7UgQ71w_Su3gg>
    <xmx:mImkZLb1Y-TnBa0ShA2017x0mihl7CGV7FIFj5tLkMIWo1dtPxPfbg>
    <xmx:mImkZNbmXKHvx076vG6qQ-O8oZ1b_hO6Ej7lmXjc4juIO79cvlVcRw>
    <xmx:mYmkZLM7eUcnL7JZ5CFJpa_BItNsPcqPt1P6LYEv2eJcdBjo1HP-zg>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id AAAD431A0063; Tue,  4 Jul 2023 17:05:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-527-gee7b8d90aa-fm-20230629.001-gee7b8d90
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <fe195986-2422-4bf2-9720-8e8e83509beb@app.fastmail.com>
In-Reply-To: 
 <CAEf4BzZ1cJDb2esPSMgEB7SsBm7e7tNQ69sPn7JuVkhqWsTSJw@mail.gmail.com>
References: <20230607235352.1723243-1-andrii@kernel.org>
 <c1a8d5e8-023b-4ef9-86b3-bdd70efe1340@app.fastmail.com>
 <CAEf4BzazbMqAh_Nj_geKNLshxT+4NXOCd-LkZ+sRKsbZAJ1tUw@mail.gmail.com>
 <a73da819-b334-448c-8e5c-50d9f7c28b8f@app.fastmail.com>
 <CAEf4Bzb__Cmf5us1Dy6zTkbn2O+3GdJQ=khOZ0Ui41tkoE7S0Q@mail.gmail.com>
 <5eb4264e-d491-a7a2-93c7-928b06ce264d@redhat.com>
 <CAEf4BzY2dKvMk_Mg2oLnD5a8aOhXCmU-0QD6sWGNZqkjbMrhBA@mail.gmail.com>
 <87wmztixr0.fsf@toke.dk>
 <CAEf4BzZ1cJDb2esPSMgEB7SsBm7e7tNQ69sPn7JuVkhqWsTSJw@mail.gmail.com>
Date: Tue, 04 Jul 2023 14:05:08 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: "Maryam Tahhan" <mtahhan@redhat.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, "Kees Cook" <keescook@chromium.org>,
 "Christian Brauner" <brauner@kernel.org>, lennart@poettering.net,
 cyphar@cyphar.com, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2023, at 3:08 PM, Andrii Nakryiko wrote:
> On Fri, Jun 23, 2023 at 4:07=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgens=
en <toke@redhat.com> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> >> applications meets the needs of these PODs that need to do
>> >> privileged/bpf things without any tokens. Ultimately you are trust=
ing
>> >> these apps in the same way as if you were granting a token.
>> >
>> > Yes, absolutely. As I mentioned very explicitly, it's the question =
of
>> > trusting application. Service vs token is implementation details, b=
ut
>> > the one that has huge implications in how applications are built,
>> > tested, versioned, deployed, etc.
>>
>> So one thing that I don't really get is why such a "trusted applicati=
on"
>> needs to be run in a user namespace in the first place? If it's trust=
ed,
>> why not simply run it as a privileged container (without the user
>> namespace) and grant it the right system-level capabilities, instead =
of
>> going to all this trouble just to punch a hole in the user namespace
>> isolation?
>
> Because it's still useful to provide isolation that user namespace
> provides in all other aspects besides BPF usage.
>
> The fact that it's a trusted application doesn't mean that bugs don't
> happen, or that some action that was not intended might be attempted
> (due to a bug, some deep unintended library "feature", or just because
> someone didn't anticipate some interaction).
>
> Trusted here means we believe our BPF usage is not going to spy on
> sensitive data, or attempt to disrupt other workloads, because of
> design and code reviews, and we intend to maintain that property. But
> people are still involved, of course, and bugs do happen. We'd like to
> get as much protection as possible, and that's what the user namespace
> is offering.
>

I'm wondering if your approach makes sense for Meta but maybe not outsid=
e Meta.  I think Meta is a bit unusual in that it operates a huge fleet,=
 but the developers of the software in that fleet are a fairly tight gro=
up.   (I'm speculating here.  I don't know much about what goes on insid=
e Meta, obviously.)

Concretely, you say "we believe our BPF usage is not going to spy on sen=
sitive data".  Who is this "we"?  The kernel developers?  The people dev=
eloping the BPF programs?  The people setting policy for the fleet?  The=
 people creating container images that want to use BPF and run within th=
e fleet?  Are these all the same "we"?

For a company with actual outside tenants, or a company that needs to co=
mply with various privacy rules for some, but not all, of its applicatio=
ns, there are a lot of "we"s involved.  Some group develops software (or=
 this is outsourced -- the BPF maintainership is essentially within Meta=
, after all).  Some group administers the fleet.  Some group develops BP=
F programs (or downloads them from outside and hopefully vets them).  So=
me group builds container images that want to use those programs.  Some =
group deploys these images via kubernetes or whatever.  Some group prepa=
res reports for that say that certain services offered comply with PCI o=
r HIPAA or FedRAMP or GDPR or whatever.  They're not all the same people.

Obviously bugs exist and mistakes happen.  But, at the end of the day, s=
omeone is going to read a BPF program (or a kernel module, or whatever) =
and take some degree of responsibility for saying "I read this thing, an=
d I approve its use in a certain context".  And then *that permission* s=
hould be granted.  With your patchset as it is, the permission granted i=
s not "run this program I approved" but rather "read all kernel memory".=
  And I don't think that will fly with a lot of potential users.

> For BPF-side of things, we have to trust the process because there is
> no technical solution. Running outside the user namespace we also
> don't have any guarantees about BPF. We just have even less protection
> in all other aspects outside of BPF. We are trying to improve our
> story with user namespace to mitigate what's mitigatable.

But there *are* technical solutions.  At least two broad types, as I've =
been trying to say.

1. Stronger and more flexible controls as to which specific programs can=
 be loaded and run.  The people doing the trusting may very well want to=
 trust specific things (and audit which things they've trusted, etc.)

2. Stronger and more flexible controls as to what programs can do.  Righ=
t now, bpf() can attach to essentially any cgroup or tracepoint if it ca=
n attach to any at all.  Programs can acccess all kernel memory (because=
 alternatives to bpf_probe_kernel_read() aren't really available, and th=
ere is no incentive right now to add them, because there isn't even a wa=
y AFAIK to turn off bpf_probe_kernel_read()).

Progress on either one of these could go a long way.

