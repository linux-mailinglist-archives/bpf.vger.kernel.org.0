Return-Path: <bpf+bounces-17832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 472ED8132A2
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 15:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB573B210E5
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 14:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0AB56473;
	Thu, 14 Dec 2023 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dtucker.co.uk header.i=@dtucker.co.uk header.b="HDsdFmsT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p290s2GI"
X-Original-To: bpf@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3AF9C
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 06:11:35 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 66A173200C5A;
	Thu, 14 Dec 2023 09:11:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 14 Dec 2023 09:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dtucker.co.uk;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1702563090; x=1702649490; bh=kcrX7JpmxQo51/yJIACKCi17I5nIWk5J
	XDnp2tFfeRI=; b=HDsdFmsTEnbSHOGxqckOtCFckOMZsPBymGtXAG+X1ugADM5I
	mrHnWyTt1nZeWnN7JsLvEBAGszPOw/UYEmrUl14kStyRS3p9+pLTFvrJqc3D098E
	QxgLEuOYXVspOhycPGwVTUM/cvQWYc/AJKlgjNtaVk/koQBH5+sKDFdoz1eu7E3l
	HF+0gdiih0vAI1G9KlKTPNFPQPej9FTkNkmX+6Fl18zF7XXEisNtn6petbPhP0aR
	Bk3J/syNQydPHTN4LyXGve+YUIEfj8mupBoEaUpRvYG4NcjuHQtb4UaugG/EPdn0
	G1yBzF5wSaEoFzSLRw5ek/YOWWY0imwTU/eBZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702563090; x=
	1702649490; bh=kcrX7JpmxQo51/yJIACKCi17I5nIWk5JXDnp2tFfeRI=; b=p
	290s2GIi5PbTiEexZF3pIL9GyBjqmaDnMFa8AMlzauOOiCH+I1rLKjO/vaDgfMPG
	MPOtiTkA1YscQm5X0eb+TbIPynv41PEIWptdgSv4Pppv37g9fpxNX5YCw61FTnr0
	ljGmj3SzHMTCrBqW/ezd1/Qe8IK6PWDARXCF2uUKV/bup221pQO6B4qDplFinqEP
	afBoQQZqr4goG0IhW7g67KXgOKoR/pw/QlET3DZa/UklDxDsgjdRyp05RmNu1vsN
	gX4E9lEV0caIIxqcEh8Y6GjjxuABojcYWDxoBoGxS4HD3BjAC4C3V1cf2RvkQUTC
	gUgfFwOM3rrFSi9zf4XGw==
X-ME-Sender: <xms:Eg17ZfKtkJEZhRaZ611AFCleeOVVDyujdype0RgomWNWrqN5-vHWqg>
    <xme:Eg17ZTKY73VUPpYHaC1jQ49yegtNbyS3UJGq90ix94ZvXLN58AhoMt5QnmQONw9ct
    sVybOSeJX7kV7dy_g>
X-ME-Received: <xmr:Eg17ZXsRORvxWyyhXzFdpjAQuCZbvGKxIl6jtHlYaaDi725f9lg1l2eCAR2TDyny0govOdmIy-0S7Z6-GIk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelledgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeffrghv
    vgcuvfhutghkvghruceouggrvhgvseguthhutghkvghrrdgtohdruhhkqeenucggtffrrg
    htthgvrhhnpeeivefgueeijedtffelhfevleettdfgueetteekfeetvedtveeuteetheeu
    hefggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gurghvvgesughtuhgtkhgvrhdrtghordhukh
X-ME-Proxy: <xmx:Eg17ZYZfSOkFFUfuz8JqMHm59gW7fYVdb-ioJqmxni8s-C0gUEO-Hw>
    <xmx:Eg17ZWbUbtnKFeQseEXIe6b6UBK61uPx07AJTeJnR4Kj-Mhxqf9agg>
    <xmx:Eg17ZcCv8ulP3rYeiSHn59fdsb0RwMyaMYTUXrXr-VRWWwlAcUfJoA>
    <xmx:Eg17ZYAylC1cvN61KQuliVGRnrvbDSkuRQKHiPNnOEB4LPZIKjbMpA>
Feedback-ID: i559945a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Dec 2023 09:11:28 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH bpf-next v1] bpf: Include pid, uid and comm in audit
 output
From: Dave Tucker <dave@dtucker.co.uk>
In-Reply-To: <CALOAHbARerbgJy-ujXwbD=f4mqmO1WXTk+33Qjkhqg4rn_6nzg@mail.gmail.com>
Date: Thu, 14 Dec 2023 14:11:17 +0000
Cc: bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <10E0052D-E706-4395-A2EE-C1BD0BE54DD0@dtucker.co.uk>
References: <20231214120716.591528-1-dave@dtucker.co.uk>
 <CALOAHbDzZ_KU05jq+Z_j29gzfSFQTnspnGK3c0iH=4xRQ3ct8g@mail.gmail.com>
 <CALOAHbARerbgJy-ujXwbD=f4mqmO1WXTk+33Qjkhqg4rn_6nzg@mail.gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)



> On 14 Dec 2023, at 13:21, Yafang Shao <laoar.shao@gmail.com> wrote:
>=20
> On Thu, Dec 14, 2023 at 9:13=E2=80=AFPM Yafang Shao =
<laoar.shao@gmail.com> wrote:
>>=20
>> On Thu, Dec 14, 2023 at 8:07=E2=80=AFPM Dave Tucker =
<dave@dtucker.co.uk> wrote:
>>>=20
>>> Current output from auditd is as follows:
>>>=20
>>> time->Wed Dec 13 21:39:24 2023
>>> type=3DBPF msg=3Daudit(1702503564.519:11241): prog-id=3D439 op=3DLOAD
>>>=20
>>> This only tells you that a BPF program was loaded, but without
>>> any context. If we include the pid, uid and comm we get output as
>>> follows:
>>>=20
>>> time->Wed Dec 13 21:59:59 2023
>>> type=3DBPF msg=3Daudit(1702504799.156:99528): pid=3D27279 uid=3D0
>>>        comm=3D"new_name" prog-id=3D50092 op=3DUNLOAD
>>=20
>> Is it possible to integrate these common details like pid, uid, and
>> comm into the audit_log_format() function for automatic inclusion? Or
>> would it be more appropriate to create a new helper function like
>> audit_log_format_common() dedicated specifically to incorporating
>> these common details? What are your thoughts on this?

There's audit_log_task_info from audit.h which adds everything. My
concern was that it is very verbose and doesn=E2=80=99t appear to be =
widely
used. I don=E2=80=99t think it warrants a helper function just yet since
we=E2=80=99re only doing audit logging in this one function.

That said, I=E2=80=99m working on a patch series to add audit logging to
bpf_link attach and detach events. I=E2=80=99ll gladly turn that into a
helper then since it would be used in more than one place.

> BTW, bpf prog can be unloaded in irq context. Therefore we can't do it
> for BPF_AUDIT_UNLOAD.

I=E2=80=99ve been running this locally, and occasionally I see unload =
events
where the comm is =E2=80=9Ckworker/0:0=E2=80=9D - I assume that those =
are from within
the irq context.

type=3DBPF msg=3Daudit(1702504511.397:202): pid=3D1 uid=3D0
    comm=3D"systemd" prog-id=3D75 op=3DLOAD

type=3DBPF msg=3Daudit(1702504541.516:213): pid=3D23152 uid=3D0
    comm=3D"kworker/0:0" prog-id=3D75 op=3DUNLOAD

That looks ok to me, but it wouldn=E2=80=99t be too hard to skip adding =
this
information in the irq context if you=E2=80=99d rather.

- Dave=

