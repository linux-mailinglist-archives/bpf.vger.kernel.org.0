Return-Path: <bpf+bounces-2869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5019735D20
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 19:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE16D1C20ABB
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 17:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C29414268;
	Mon, 19 Jun 2023 17:40:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05CCC2C5
	for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 17:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FA7C433C9;
	Mon, 19 Jun 2023 17:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687196442;
	bh=sH9kiOaU4wCIs4WeyFId3eU6qGRkP8/+BEpkEEZLIgM=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=ooXDrBwOmWjxnX0vCA/nNLDqzeKQSY5gecC2l8TYj4AeLZ08S7IDhhI+4V3gwxyqJ
	 svFHFq53ECZwC3sL7Mo92JWVcdumAfCpgR2UWUaOt+wDX91eUSEPjUVWnxSW+KWl/C
	 FtsHBRy+2jxN5GmGbH0073EYBc2t3D76LLmNvlgK6bvW/oYPQiME98tY3ZRJKXAw+0
	 fX8wrRcEqJUaa3qfX8UqFzNaQ3kscczKPXrynPXbMOkLhroECgYaqUSw8iEqMEehms
	 gwQEBIzrgeoi2dqFgEafIIZVaUx1wxHk4aLglO1e66yG9esU5dJii7ylu13By/RGil
	 X9j9lAnvHMJhQ==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id C199927C0054;
	Mon, 19 Jun 2023 13:40:40 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Mon, 19 Jun 2023 13:40:40 -0400
X-ME-Sender: <xms:GJOQZDrFjQBSLD8v6l9jlNxQCcDAuUFaC8_myq-N9ys3ILPbyOl-xA>
    <xme:GJOQZNox_QBqGJHtm912hiJzLlimwFL50VRMOvsDnHiR3661XgMt5YUaLjkCSy_gZ
    gAe31es-NbzZK7gf2E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefvddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehnugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqne
    cuggftrfgrthhtvghrnhepudevffdvgedvfefhgeejjeelgfdtffeukedugfekuddvtedv
    udeileeugfejgefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudei
    udekheeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlih
    hnuhigrdhluhhtohdruhhs
X-ME-Proxy: <xmx:GJOQZANu8N4m1mMAuS4yamMLNs4I5uZVHLYGY7fCqq71dlyTQC6RPA>
    <xmx:GJOQZG713DhZxFOdgeDSXB_jyWz5SK6ItuebDBY3Fkg8PEoWyU24Eg>
    <xmx:GJOQZC4YQZyH3UkH01n7t2xuqvgNurSFXrDKUTJjhMH8f8PF5XhALQ>
    <xmx:GJOQZPvsPgkpLn9Ahdtqp6FPC3_4ZUUqIUT70MhAfBlzx5OFPYZDOQ>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 30FF031A0063; Mon, 19 Jun 2023 13:40:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-496-g8c46984af0-fm-20230615.001-g8c46984a
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <a73da819-b334-448c-8e5c-50d9f7c28b8f@app.fastmail.com>
In-Reply-To: 
 <CAEf4BzazbMqAh_Nj_geKNLshxT+4NXOCd-LkZ+sRKsbZAJ1tUw@mail.gmail.com>
References: <20230607235352.1723243-1-andrii@kernel.org>
 <c1a8d5e8-023b-4ef9-86b3-bdd70efe1340@app.fastmail.com>
 <CAEf4BzazbMqAh_Nj_geKNLshxT+4NXOCd-LkZ+sRKsbZAJ1tUw@mail.gmail.com>
Date: Mon, 19 Jun 2023 10:40:19 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, "Kees Cook" <keescook@chromium.org>,
 "Christian Brauner" <brauner@kernel.org>, lennart@poettering.net,
 cyphar@cyphar.com, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Fri, Jun 9, 2023, at 12:08 PM, Andrii Nakryiko wrote:
> On Fri, Jun 9, 2023 at 11:32=E2=80=AFAM Andy Lutomirski <luto@kernel.o=
rg> wrote:
>>
>> On Wed, Jun 7, 2023, at 4:53 PM, Andrii Nakryiko wrote:
>> > This patch set introduces new BPF object, BPF token, which allows t=
o delegate
>> > a subset of BPF functionality from privileged system-wide daemon (e=
.g.,
>> > systemd or any other container manager) to a *trusted* unprivileged
>> > application. Trust is the key here. This functionality is not about=
 allowing
>> > unconditional unprivileged BPF usage. Establishing trust, though, is
>> > completely up to the discretion of respective privileged applicatio=
n that
>> > would create a BPF token.
>> >
>>
>> I skimmed the description and the LSFMM slides.
>>
>> Years ago, I sent out a patch set to start down the path of making th=
e bpf() API make sense when used in less-privileged contexts (regarding =
access control of BPF objects and such).  It went nowhere.
>>
>> Where does BPF token fit in?  Does a kernel with these patches applie=
d actually behave sensibly if you pass a BPF token into a container?
>
> Yes?.. In the sense that it is possible to create BPF programs and BPF
> maps from inside the container (with BPF token). Right now under user
> namespace it's impossible no matter what you do.

I have no problem with creating BPF maps inside a container, but I think=
 the maps should *be in the container*.

My series wasn=E2=80=99t about unprivileged BPF per se.  It was about up=
dating the existing BPF permission model so that it made sense in a cont=
ext in which it had multiple users that didn=E2=80=99t trust each other.

>
>> Giving a way to enable BPF in a container is only a small part of the=
 overall task -- making BPF behave sensibly in that container seems like=
 it should also be necessary.
>
> BPF is still a privileged thing. You can't just say that any
> unprivileged application should be able to use BPF. That's why BPF
> token is about trusting unpriv application in a controlled environment
> (production) to not do something crazy. It can be enforced further
> through LSM usage, but in a lot of cases, when dealing with internal
> production applications it's enough to have a proper application
> design and rely on code review process to avoid any negative effects.

We really shouldn=E2=80=99t be creating new kinds of privileged containe=
rs that do uncontained things.

If you actually want to go this route, I think you would do much better =
to introduce a way for a container manager to usefully proxy BPF on beha=
lf of the container.

>
> So privileged daemon (container manager) will be configured with the
> knowledge of which services/containers are allowed to use BPF, and
> will grant BPF token only to those that were explicitly allowlisted.


