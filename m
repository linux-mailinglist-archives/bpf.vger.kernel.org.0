Return-Path: <bpf+bounces-30814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B2B8D2A24
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 03:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EFBBB26A4F
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 01:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4119615AAD7;
	Wed, 29 May 2024 01:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipanda-io.20230601.gappssmtp.com header.i=@sipanda-io.20230601.gappssmtp.com header.b="I0rPraVk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040B713E41D
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 01:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716947745; cv=none; b=D/VNE/yAdezvebDG7ap7pbU+k1cNUFzdjON4tBe+FiZPa/AFzKysJXki8cT6vkFI+zZfIqj6bjJUTGV6+/mdExHW+Ub7jDq+rUUQP9ZPbzDSvK5HHkz6c3d2gDyYofS5/pXM9Xbr5ucaMFDWN0M6Rk+IQyjRjp/t6WZ+xmeKMNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716947745; c=relaxed/simple;
	bh=gl5d94vCrFp3d6iHTt10IDlGno2r7cIf6q1g+eLycX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apKi0RQp7zoEiLpbP6FPdXNFAh96SIciemU0cpppCnpUAqB3MpWie1xyidIpRjpQ9rW7sA4nVxTisKPSl2rSyd+vHU5oCrJwe8/37szeH96DLeDOwdzXyLQ9Ac42oJCV9P/v/xXK0Nbs1emYyukGOQL6Pt3p2vss+SZZwj1KNeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sipanda.io; spf=pass smtp.mailfrom=sipanda.io; dkim=pass (2048-bit key) header.d=sipanda-io.20230601.gappssmtp.com header.i=@sipanda-io.20230601.gappssmtp.com header.b=I0rPraVk; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sipanda.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipanda.io
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-804cb4ad47dso216418241.0
        for <bpf@vger.kernel.org>; Tue, 28 May 2024 18:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sipanda-io.20230601.gappssmtp.com; s=20230601; t=1716947743; x=1717552543; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e9VpmvbG8RAKWbbKskbeNWoxWX+Wed3L4uHFkBsflys=;
        b=I0rPraVkOp9SJ+/+04sar7z+NQuhwrRVKdyskRczuBcqdmx+jemeexDB95jOBVkHnv
         YbaXxp5lQLeBEqop+I6WMjFEn7e77CN4Wx1zsFALQRHLn+NBMKHF02+P8peVHIQZZ08W
         QDtRXV4O3KrjcHr/g9kwu2a8e9vFzNIIIRRwAxBn2ohfv0IR2ZrPwyDvrhafHq8spKet
         +oiHywdmrszvpuDZX6zUleFiPXpEk+0E00TaaQrzL4YUpSrOocRdS8PNYDU2O4B7Lq4j
         rOs4VAadiqLAUE4qYGYL7HThTgpoa46zAvHIFcK0y3MEoFArRcPtx7JSpYu/SplICs34
         0iwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716947743; x=1717552543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e9VpmvbG8RAKWbbKskbeNWoxWX+Wed3L4uHFkBsflys=;
        b=dduYHcY/NeksI+EnZkBpGQdIMFZ+4e4trebgBsC5qKwAFh3b81Q3b8ebmMcTExPuHR
         OiOwdPA6lauzp5BAE6kZ9gX4oXbU+QSv/NrzngGpZbw7drRz4n6W5/Ai0y+3WC6yyj+1
         olikjqvnSSnuq8wjTgJTepKH/un/bpCrnv+WsI7JM82DahMEQiztRmIGhF3n9Milrb3m
         9IR43aKdSvFYYOjfOmcm7cJ+Ho4KzdoFgril19DL9vB7aKh6tHo+5pfizc4zGTnAS631
         mS4IJG6AUsyguzPa53d2w7N2eamJVuoF4aM+T3gk37gg2dhBzSFxl0MB3ffiNwRGl0An
         juSg==
X-Forwarded-Encrypted: i=1; AJvYcCVefeh/qh5zIL5zuZy9901aJonpNOeBGNhbS1TPM2zm5jDgnbrcPqwWt9alMFDyDCVo4C3oWYBlpv4oOM/LvHuicuEM
X-Gm-Message-State: AOJu0YzI4RDBM0x/NJ90avMTWkG+QfRReCF+ruRUgnpwn7cVbR2djUrL
	0w9e1/wjpAQTzhiIG1pBmMS28pyf9lHvgyR0VkW3WaZLTlVrDM1xaOuTmglO6Qjji5PiJuugUgt
	XNpOI7yMz103CfNVBC5VCob6xmgNYI+CW7XEJWA==
X-Google-Smtp-Source: AGHT+IH0HQSeva4lisoe/8jexKhm+YJfWr9Hmhs8L8dSz4wr8FenbE0Zu9XFfBoSGGnEFw6pQzkeWSt11g57RTCTZ2o=
X-Received: by 2002:a67:c598:0:b0:48b:a0b2:f6f9 with SMTP id
 ada2fe7eead31-48ba0b2f842mr243749137.12.1716947741285; Tue, 28 May 2024
 18:55:41 -0700 (PDT)
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
 <CO1PR11MB499350FC06A5B87E4C770CCE93F42@CO1PR11MB4993.namprd11.prod.outlook.com>
 <MW4PR12MB71927C9E4B94871B45F845DF97F52@MW4PR12MB7192.namprd12.prod.outlook.com>
 <MW4PR12MB719209644426A0F5AE18D2E897F62@MW4PR12MB7192.namprd12.prod.outlook.com>
 <66563bc85f5d0_2f7f2087@john.notmuch> <CO1PR11MB49932999F5467416D4F7197693F12@CO1PR11MB4993.namprd11.prod.outlook.com>
 <66566c7c6778d_52e720851@john.notmuch>
In-Reply-To: <66566c7c6778d_52e720851@john.notmuch>
From: Tom Herbert <tom@sipanda.io>
Date: Tue, 28 May 2024 18:55:29 -0700
Message-ID: <CAOuuhY9SU5WbFjF2BjT3JgZ2Oz7Bm+ZtvA4RVdfV+WOV4j6n4g@mail.gmail.com>
Subject: IR for Programmable Datapaths [WAS Re: On the NACKs on P4TC patches]
To: John Fastabend <john.fastabend@gmail.com>
Cc: "Singhai, Anjali" <anjali.singhai@intel.com>, "Jain, Vipin" <Vipin.Jain@amd.com>, 
	"Hadi Salim, Jamal" <jhs@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Network Development <netdev@vger.kernel.org>, 
	"Chatterjee, Deb" <deb.chatterjee@intel.com>, "Limaye, Namrata" <namrata.limaye@intel.com>, 
	Marcelo Ricardo Leitner <mleitner@redhat.com>, "Shirshyad, Mahesh" <Mahesh.Shirshyad@amd.com>, 
	"Osinski, Tomasz" <tomasz.osinski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Cong Wang <xiyou.wangcong@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Khalid Manaa <khalidm@nvidia.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Victor Nogueira <victor@mojatatu.com>, "Tammela, Pedro" <pctammela@mojatatu.com>, 
	"Daly, Dan" <dan.daly@intel.com>, Andy Fingerhut <andy.fingerhut@gmail.com>, 
	"Sommers, Chris" <chris.sommers@keysight.com>, Matty Kadosh <mattyk@nvidia.com>, 
	bpf <bpf@vger.kernel.org>, "lwn@lwn.net" <lwn@lwn.net>, 
	Felipe Magno de Almeida <felipe@sipanda.io>, 
	Julio De Bastiani <julio.bastiani@expertisesolutions.com.br>
Content-Type: text/plain; charset="UTF-8"

> None of above requires P4TC. For different architectures you
> build optimal backend compilers. You have a Xilenx backend,
> an Intel backend, and a Linux CPU based backend. I see no
> reason to constrain the software case to map to a pipeline
> model for example. Software running on a CPU has very different
> characteristics from something running on a TOR, or FPGA.
> Trying to push all these into one backend "model" will result
> in suboptimal result for every target. At the end of the
> day my .02$, P4 is a DSL it needs a target dependent compiler
> in front of it. I want to optimize my software pipeline the
> compiler should compress tables as much as possible and
> search for a O(1) lookup even if getting that key is somewhat
> expensive. Conversely a TCAM changes the game. An FPGA is
> going to be flexible and make lots of tradeoffs here of which
> I'm not an expert. Also by avoiding loading the DSL into the kernel
> you leave room for others to build new/better/worse DSLs as they
> please.
>

I think the general ask here is to define an Intermediate
Representation that describes a programmed data path where it's a
combination of declarative and imperative elements (parsers and table
descriptions are better in declarative representation, functional
logic seems more imperative). We also want references to accelerators
with dynamic runtime binding to hardware (there are some interesting
tricks we can do in the loader for a CPU target-- will talk about at
Netdev). With a good IR we can decouple the frontend from the backend
target which enables mixing and matching programming languages with
arbitrary HW or SW targets. So a good IR potentially enables a lot of
flexibility and freedom on both sides of the equation.

An IR also facilitates reasonable kernel offload via signing images
with a hash of the IR. So for instance, a frontend compiler could
compile a P4 program into the IR. That code could then be compiled
into a SW target, say eBPF, and maybe P4 hardware. Each image has the
hash of the IR. At runtime, the eBPF code could be loaded into the
kernel. The hardware image can be loaded into the device using a side
band mechanism. To offload, we would query the device-- if the hash
reported by the device matches the hash in the eBPF then we know that
the offload is viable. No jits, no pushing firmware bits through the
kernel, no need for device capabilities flags, and avoids the pitfalls
of TC flower.

There is one challenge here in how to deal with offloads that are
already integrated into the kernel. I think GRO is a great example.
GRO has been especially elusive as an offload since it requires a
device to autonomously parse packets on input.  We really want a GRO
offload that parses the same exact protocols the kernel does
(including encapsulations), but also implements the exact same logic
in timers and pushing reassembled segments. So this needs to be
programmable. The problem with the technique I described is that GRO
is integrated into the kernel so we have no basis for a hash. I think
the answer here is to start replacing fixed kernel C code with eBPF
even in the critical path (we already talked about replacing flow
dissector with eBPF).

Anyway, we have been working on this. There's Common Parser
Representation in json (formerly known CPL that we talked about at
Netdev). For execution logic, LLVM IR seems fine (btrw, MLIR is really
useful by the way!). We're just starting to look at tables (probably
also json). If there's interest I could share more...

Tom

