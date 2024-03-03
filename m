Return-Path: <bpf+bounces-23273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C29E86F618
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 17:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC60D28616D
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 16:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700B46E5ED;
	Sun,  3 Mar 2024 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipanda-io.20230601.gappssmtp.com header.i=@sipanda-io.20230601.gappssmtp.com header.b="gXgPcIyh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12466D1BC
	for <bpf@vger.kernel.org>; Sun,  3 Mar 2024 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709483486; cv=none; b=Ag3aLuELOHTnlJ6irwhC8OzjvfENcalyQuM/HXnuycF0HsCOHiuSyHPyaM3rV5A1qlDxbvjMQ3zog/uXahb661V7Htqhp4JWnIJ/LfWwNQlY0gyckmFxhGc0UOhPdhSoHiCdBd8m6DfDQ8IMKf5C2X4JzBm20tlqQMjkZCRUMB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709483486; c=relaxed/simple;
	bh=M4CH3FnjamkLjBU9rjNyNRsPEYihXS/mhC+4kUHl38o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtBIWc4MGOGJtTFaCXO8XxJBvlDhPOL8VCCsAbRh5R7EgXLQ8oJInLP4zr+KGyYeDP/Csf3eJUoXznYJ2bnVluqs8GrpXoEwh1mMPeQr57uAOTzp/QbGR1x6N4XH3wYgQP49sCtnyzCdmren0gOHMN+A8Cc7PJIihq/2FcVXrsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sipanda.io; spf=pass smtp.mailfrom=sipanda.io; dkim=pass (2048-bit key) header.d=sipanda-io.20230601.gappssmtp.com header.i=@sipanda-io.20230601.gappssmtp.com header.b=gXgPcIyh; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sipanda.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipanda.io
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e4e8cb8472so1685a34.3
        for <bpf@vger.kernel.org>; Sun, 03 Mar 2024 08:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sipanda-io.20230601.gappssmtp.com; s=20230601; t=1709483483; x=1710088283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4CH3FnjamkLjBU9rjNyNRsPEYihXS/mhC+4kUHl38o=;
        b=gXgPcIyhHQ6/B/36pNevfN0WcPz3VWytukLrNUZNNdLnZLT8GUgO+ZpcPlcHGGJw1D
         VmdACIcnhohP0xrdFgKWvKA6abfs35L8gr1A4aFi/PZUi9OBbZeSabMpFSE28lVHqhJY
         dwq5ytTFDoCmRxgjy7rcukQuMp4V8PlqD5GYkCXijE7h8fGC483IbhjLVpl/eDp4k1ug
         qiewFmXgj0yEykUFK0kuWmb1Sm2jkbguyO6UGUN23uJYypUgZAKupDzmes8FH7HY19C6
         TUCnrCdDqCa1Tv+0gTto5+FTZSdYA0J9Uuphn8hPwD10QBbMAtzKLF0P5GMOy4R6LGBl
         5Spw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709483483; x=1710088283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4CH3FnjamkLjBU9rjNyNRsPEYihXS/mhC+4kUHl38o=;
        b=l7Bar3YVA/8UMl9A5ydBxY3hYObeDv/J5+wGMAkyHwdPg42XT959GT3/p7RX7chVeF
         eKFjKNEH2/LhCcioqFSe//2wc7Z7PAUHMSSw7/Ta+T7LDxT2I1L9152XT1PaStC7lHs3
         6YfI8r/9pEKl5EHG4OTiKyQoUDNaVrJjw//zF4/VNtF611N22AmwjoINPaJOAjpfqiO8
         AFdyzV14Wt26VLZhwxwZ/pef+DOzOy9HE4i6pmIrslyQ2J6UTQpxl/OiBzv9VmtqSP7A
         uyYyKLs2PSSOhPiplYCV12p0skDHs+55tWf7SdZd2+6pMK2MlC4OjCd7KdlN7EuSA6SC
         XegQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+8K1ZzssYrjQo9oQCZWYuq0v0K4Kak8VNerYZjW8UuLrQaTZP/B9CchOB684zoLOshw60is0ySnhCmIRkwzzFQ1PE
X-Gm-Message-State: AOJu0Yx9Ed4D8yoLvD+bYM+FA6+zvMkJGEwOQmJpucn+uSYot1E8gnRk
	MG1NgB2bXgRP/TCObv0uLsSikDMZpospmuDiXMUzsPWZTLQ2/dGQBJI3HgCSfq80WBI0OxHYXT/
	pOqiIW1Wg9gnnd37zG6HDM+DoN7JEz+zE3Vx25A==
X-Google-Smtp-Source: AGHT+IHXPYgX24IKlsJON9UI1ZIU4CDHT+FjkldDEdDndBggEN9zJs3yuLfiltg9eaMhPWaHk8ApMO5/GwJcw85FXuA=
X-Received: by 2002:a9d:73cc:0:b0:6e4:d884:40d0 with SMTP id
 m12-20020a9d73cc000000b006e4d88440d0mr3383074otk.0.1709483482934; Sun, 03 Mar
 2024 08:31:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225165447.156954-1-jhs@mojatatu.com> <b28f2f7900dc7bad129ad67621b2f7746c3b2e18.camel@redhat.com>
 <CO1PR11MB49931E501B20F32681F917CD935F2@CO1PR11MB4993.namprd11.prod.outlook.com>
 <65e106305ad8b_43ad820892@john.notmuch> <CAM0EoM=r1UDnkp-csPdrz6nBt7o3fHUncXKnO7tB_rcZAcbrDg@mail.gmail.com>
 <CAOuuhY8qbsYCjdUYUZv8J3jz8HGXmtxLmTDP6LKgN5uRVZwMnQ@mail.gmail.com>
 <20240301090020.7c9ebc1d@kernel.org> <CAM0EoM=-hzSNxOegHqhAQD7qoAR2CS3Dyh-chRB+H7C7TQzmow@mail.gmail.com>
 <20240301173214.3d95e22b@kernel.org> <CAOuuhY8fnpEEBb8z-1mQmvHtfZQwgQnXk3=op-Xk108Pts8ohA@mail.gmail.com>
 <20240302191530.22353670@kernel.org>
In-Reply-To: <20240302191530.22353670@kernel.org>
From: Tom Herbert <tom@sipanda.io>
Date: Sun, 3 Mar 2024 08:31:11 -0800
Message-ID: <CAOuuhY_senZbdC2cVU9kfDww_bT+a_VkNaDJYRk4_fMbJW17sQ@mail.gmail.com>
Subject: Re: [PATCH net-next v12 00/15] Introducing P4TC (series 1)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, John Fastabend <john.fastabend@gmail.com>, 
	"Singhai, Anjali" <anjali.singhai@intel.com>, Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, "Chatterjee, Deb" <deb.chatterjee@intel.com>, 
	"Limaye, Namrata" <namrata.limaye@intel.com>, mleitner@redhat.com, Mahesh.Shirshyad@amd.com, 
	Vipin.Jain@amd.com, "Osinski, Tomasz" <tomasz.osinski@intel.com>, 
	Jiri Pirko <jiri@resnulli.us>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, edumazet@google.com, Vlad Buslov <vladbu@nvidia.com>, 
	horms@kernel.org, khalidm@nvidia.com, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Victor Nogueira <victor@mojatatu.com>, 
	"Tammela, Pedro" <pctammela@mojatatu.com>, "Daly, Dan" <dan.daly@intel.com>, andy.fingerhut@gmail.com, 
	"Sommers, Chris" <chris.sommers@keysight.com>, mattyk@nvidia.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 7:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 1 Mar 2024 18:20:36 -0800 Tom Herbert wrote:
> > This is configurability versus programmability. The table driven
> > approach as input (configurability) might work fine for generic
> > match-action tables up to the point that tables are expressive enough
> > to satisfy the requirements. But parsing doesn't fall into the table
> > driven paradigm: parsers want to be *programmed*. This is why we
> > removed kParser from this patch set and fell back to eBPF for parsing.
> > But the problem we quickly hit that eBPF is not offloadable to network
> > devices, for example when we compile P4 in an eBPF parser we've lost
> > the declarative representation that parsers in the devices could
> > consume (they're not CPUs running eBPF).
> >
> > I think the key here is what we mean by kernel offload. When we do
> > kernel offload, is it the kernel implementation or the kernel
> > functionality that's being offloaded? If it's the latter then we have
> > a lot more flexibility. What we'd need is a safe and secure way to
> > synchronize with that offload device that precisely supports the
> > kernel functionality we'd like to offload. This can be done if both
> > the kernel bits and programmed offload are derived from the same
> > source (i.e. tag source code with a sha-1). For example, if someone
> > writes a parser in P4, we can compile that into both eBPF and a P4
> > backend using independent tool chains and program download. At
> > runtime, the kernel can safely offload the functionality of the eBPF
> > parser to the device if it matches the hash to that reported by the
> > device
>
> Good points. If I understand you correctly you're saying that parsers
> are more complex than just a basic parsing tree a'la u32.

Yes. Parsing things like TLVs, GRE flag field, or nested protobufs
isn't conducive to u32. We also want the advantages of compiler
optimizations to unroll loops, squash nodes in the parse graph, etc.

> Then we can take this argument further. P4 has grown to encompass a lot
> of functionality of quite complex devices. How do we square that with
> the kernel functionality offload model. If the entire device is modeled,
> including f.e. TSO, an offload would mean that the user has to write
> a TSO implementation which they then load into TC? That seems odd.
>
> IOW I don't quite know how to square in my head the "total
> functionality" with being a TC-based "plugin".

Hi Jakub,

I believe the solution is to replace kernel code with eBPF in cases
where we need programmability. This effectively means that we would
ship eBPF code as part of the kernel. So in the case of TSO, the
kernel would include a standard implementation in eBPF that could be
compiled into the kernel by default. The restricted C source code is
tagged with a hash, so if someone wants to offload TSO they could
compile the source into their target and retain the hash. At runtime
it's a matter of querying the driver to see if the device supports the
TSO program the kernel is running by comparing hash values. Scaling
this, a device could support a catalogue of programs: TSO, LRO,
parser, IPtables, etc., If the kernel can match the hash of its eBPF
code to one reported by the driver then it can assume functionality is
offloadable. This is an elaboration of "device features", but instead
of the device telling us they think they support an adequate GRO
implementation by reporting NETIF_F_GRO, the device would tell the
kernel that they not only support GRO but they provide identical
functionality of the kernel GRO (which IMO is the first requirement of
kernel offload).

Even before considering hardware offload, I think this approach
addresses a more fundamental problem to make the kernel programmable.
Since the code is in eBPF, the kernel can be reprogrammed at runtime
which could be controlled by TC. This allows local customization of
kernel features, but also is the simplest way to "patch" the kernel
with security and bug fixes (nobody is ever excited to do a kernel
rebase in their datacenter!). Flow dissector is a prime candidate for
this, and I am still planning to replace it with an all eBPF program
(https://netdevconf.info/0x15/slides/16/Flow%20dissector_PANDA%20parser.pdf=
).

Tom

