Return-Path: <bpf+bounces-3999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093BB7478FD
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 22:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F52280F9B
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 20:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54718495;
	Tue,  4 Jul 2023 20:27:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1502079CC
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 20:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3982FC433CA;
	Tue,  4 Jul 2023 20:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688502430;
	bh=iy5HUoGWTmpxSmUZjQ7hawlWnCOJsYYvnUq8MjJB9z8=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=Ci6kXfZf1O1MqOZcgOdTuORv5v8w6CmGXOKCzTuY88/inW894MEyA7DRy27w/3+4c
	 bbmiw7pj2zPj3ikbYw1J85MatELjtHtES8+3Zo7U8p1LFu6M3dHJbNMQapbmWSHpZq
	 qGn5kzZ55V2OhtDR6xrz5Qd9fTQ9FMTQor/I260tSYAmaFW1tvFmkXlZdGkxpS8WC/
	 ABWzssv0KeFdaBquM7j/4FaDpPpp7slap6ld0n8sxL3KNKnbAk3aFpar5G6CFuOiv0
	 G2uygMS+ovRqbgpGJdJgUU1+ceYYwJjT/CcSeuKp8UJNOKbQnmeprEXaqd1arfbELg
	 0CfDZxTzTVYng==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailauth.nyi.internal (Postfix) with ESMTP id 1C55027C0054;
	Tue,  4 Jul 2023 16:27:09 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 04 Jul 2023 16:27:09 -0400
X-ME-Sender: <xms:nICkZPRRjojFpFkJvcv0V_RqD_fzhm556pFt6nh4lSK-KZ778fiBSQ>
    <xme:nICkZAw5IG_B5ttc8MD18_fLjq3a2dt_hWuyFU8enJDwBu-U313l5L6dLqRWkaVnR
    48fUfa2VjrzVvc5F7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeggddugeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedvtddtffejfeeggefgleefgfeghfehfeefffetgffgleegudevveet
    hfefjeevkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvkeehudej
    tddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusg
    druggv
X-ME-Proxy: <xmx:nICkZE1qaTrVneGGwS-peGSGtKXmS6ILMKpioi0pWIyQFMAjOn-nLA>
    <xmx:nICkZPDcQp7soEz7_-_jthVNxii_9NrAOqfkaMhmVxB5h5YiQaxPrA>
    <xmx:nICkZIh2e35QQn6HG_6t33ZXHQTRI6GuLrcHw0IL_5gR_d8NABUzhA>
    <xmx:nYCkZEyr0iv-kgCEOc11Wgc6kQqDjSsuhakPjPse0bizQLO1ahbvnQ>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 88EECB60086; Tue,  4 Jul 2023 16:27:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-527-gee7b8d90aa-fm-20230629.001-gee7b8d90
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <753120c5-dcf4-46ff-9319-e8aa035e2488@app.fastmail.com>
In-Reply-To: 
 <CAF=yD-K7NiEROeHM5GzW2ArtprcYg7WFwPFz7+0LOOT2DCY_+A@mail.gmail.com>
References: <20230703175048.151683-1-jthinz@mailbox.tu-berlin.de>
 <64a33ce7b50d2_6520520875@john.notmuch>
 <bdffeca8e222b0126100dec5dcd9d9b186ea6905.camel@mailbox.tu-berlin.de>
 <CAF=yD-K7NiEROeHM5GzW2ArtprcYg7WFwPFz7+0LOOT2DCY_+A@mail.gmail.com>
Date: Tue, 04 Jul 2023 22:26:47 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 =?UTF-8?Q?J=C3=B6rn-Thorben_Hinz?= <jthinz@mailbox.tu-berlin.de>
Cc: "John Fastabend" <john.fastabend@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
 linux-kselftest@vger.kernel.org, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, shuah <shuah@kernel.org>,
 "Willem de Bruijn" <willemb@google.com>,
 "Deepa Dinamani" <deepa.kernel@gmail.com>
Subject: Re: [PATCH 0/2] bpf, net: Allow setting SO_TIMESTAMPING* from BPF
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 4, 2023, at 21:36, Willem de Bruijn wrote:
>> On Mon, 2023-07-03 at 14:25 -0700, John Fastabend wrote:
>> > J=C3=B6rn-Thorben Hinz wrote:
>> Yes, if there is no objection to making the added
>> getsockopt(SO_TIMESTAMPING_NEW) this tiny bit more =E2=80=9Cstrict=E2=
=80=9D, it=E2=80=99s just
>> a matter of modifying the if inserted in sk_getsockopt(). (And, well,
>> in the other case I would even remove this if.)
>
> The difference is in the struct that is returned, on 32-bit platforms.
> Both calls should always be allowed? See also
> put_cmsg_scm_timestamping64 vs put_cmsg_scm_timestamping.
>
> For the second patch: the _OLD/_NEW was introduced to work around
> limitations on 32-bit platforms. This is intended to be transparent to
> users, by defining SO_TIMESTAMPING accordingly.
>
> Can the new BPF code always enforce the 64-bit version, that is, only
> implement the _NEW variants? And perhaps just call it SO_TIMESTAMPING
> directly.

I guess that depends on how the returned timestamps are interpreted.

In normal userspace code, the 'struct scm_timestamping' is defined
in terms of the libc-provided 'struct timespec'. If this is a normal
glibc based distro binary, then it probably expects the old format.

OTOH, if the code reading the timestamp data is in BPF code itself,
it's probably safe to mandate that to use the time64 format and
define the timespec type as __kernel_timespec with 64-bit members.

     Arnd

