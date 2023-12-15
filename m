Return-Path: <bpf+bounces-17961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964F28141CA
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 07:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B32101C22428
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 06:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3330C8471;
	Fri, 15 Dec 2023 06:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgCnOqUu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7544E79DB
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 06:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ceb93fb381so212365b3a.0
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 22:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702621607; x=1703226407; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SfjOGoBQM9YNVptNKFUpqQrNqMgVxNJ7Fk9FnoFnqZY=;
        b=HgCnOqUu2oT9S2606zWq+or9Lr/WoibOabmQ3yoIMlArDI1N8KryMSYRkB2rH3OZkU
         6R/FsDpPmvUPDcgS5uKF6SSF4qxcdVfYZceyMxeJsxGp8Ks0+ew/rXPTxCTm6v6iOIWI
         HK9J3s6iZreI3MeT/3cWktLkv8oQe/YManFTRd6Zv6vraJilxhARS1zGHlP5kyAWxaye
         rVNdMbWyigjskPRy1Xzv28cy7txTnbRDfOjR9ySxV5KGhwpyOZP//hKgYU+e6G0tZjq+
         42zjLaMryKxUa8KBevLyNjf0JMwyN5ziwEBG+U57wPKsL/M4hU0BVhUxRJnFy21o/5Mv
         cUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702621607; x=1703226407;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SfjOGoBQM9YNVptNKFUpqQrNqMgVxNJ7Fk9FnoFnqZY=;
        b=LjTVGwrZlB+lL+Uae0aLt8D6/Zo7Cnyx7ooPkfkzXJeBMp8KdlPli/rBuf+A4hgH3H
         grHwBTh8o4aEV2stgSpyDlJ8cO3/pI4N0TwMk7ECcpXzX73Rp4P+0bqXvrpDQa8B1aHo
         lDQL5eJwFJa1EONtSnrCEe/UtPqePqkH4JEvAROoZz4K7N0YppUk9nYNFDEhnhZueeIu
         P17KiD8lHlPpBwkoS6wP4+lJAFW6hSyuuYZ+Dt5NPf6m4m2AbVorMTQLfGMGy1FrQ1eO
         a/T/qk7fK8g0Z3QfpAX+G214wCQs1ObpgzOkfM5H21LtClmx1JgRmjJMecyHBVVwWiUQ
         r9zQ==
X-Gm-Message-State: AOJu0YxjXOfvLJCoiuBrNFTm3Rl3w2zXKl1sQwzl7ejyjQQM9NaL0pXS
	DRManiBQBE95Q1XJR9/grEY=
X-Google-Smtp-Source: AGHT+IE8H5Ep5gmeb7BFWGu0eGFGKDjHGuOV9DoEgRTuU70FB8kwxuRC8H12xNYMBWTTrNkyNF7uhw==
X-Received: by 2002:a05:6a00:1887:b0:6ce:787e:89bc with SMTP id x7-20020a056a00188700b006ce787e89bcmr17192633pfh.31.1702621606522;
        Thu, 14 Dec 2023 22:26:46 -0800 (PST)
Received: from surya ([2600:1700:3ec2:2011:267b:5fd0:9667:5cbd])
        by smtp.gmail.com with ESMTPSA id x22-20020a056a00271600b006be5af77f06sm12806584pfv.2.2023.12.14.22.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 22:26:46 -0800 (PST)
Date: Thu, 14 Dec 2023 22:26:16 -0800
From: Manu Bretelle <chantr4@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Quentin Monnet <quentin@isovalent.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v1 bpf-next 1/9] bpftool: add testing skeleton
Message-ID: <ZXvxiAihlzC6ylkD@surya>
References: <20231116194236.1345035-1-chantr4@gmail.com>
 <20231116194236.1345035-2-chantr4@gmail.com>
 <CAADnVQ+Mb-eQUxp-0c_C_nVme0Sqy7CST_vaCiawefjTb5spiw@mail.gmail.com>
 <a9ac8c82-7b97-4001-a839-215eb4cc292f@isovalent.com>
 <CAADnVQ+f80KNBcjYRzBJw4zhYfhYa=Cw9bdQEe+Z1=CnQaa9Gw@mail.gmail.com>
 <CAEf4BzZMDfBao58ynxAKys3bB=A+SRLORz65Ce4ron60m=NojQ@mail.gmail.com>
 <0ab6a40e-c1a7-4313-ad01-1d2d86835fb3@isovalent.com>
 <CAEf4Bzam5iYxoBeJgLO+cb0LuR2=LqN18OwVDxZwRBqfKVpBMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzam5iYxoBeJgLO+cb0LuR2=LqN18OwVDxZwRBqfKVpBMA@mail.gmail.com>

I am going to start by apologizing for dropping the ball for so long... I
originally planned to get back to this after thanksgiving holidays... but weeks
snowballed one after the other.

On Mon, Nov 27, 2023 at 10:39:34AM -0800, Andrii Nakryiko wrote:
> On Mon, Nov 27, 2023 at 9:07 AM Quentin Monnet <quentin@isovalent.com> wrote:
> >
> > 2023-11-21 19:50 UTC+0000 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > On Tue, Nov 21, 2023 at 8:42 AM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > >>
> > >> On Tue, Nov 21, 2023 at 8:26 AM Quentin Monnet <quentin@isovalent.com> wrote:
> > >>>
> > >>>>
> > >>>> Does it have to leave in the kernel tree?
> > >>>> We have bpftool on github, maybe it can be there?
> > >>>> Do you want to run bpftool tester as part of BPF CI and that's why
> > >>>> you want it to be in the kernel tree?
> > >>>
> > >>> It doesn't _have_ to be in the kernel tree, although it's a nice place
> > >>> where to have it. We have bpftool on GitHub, but the CI that runs there
> > >>> is triggered only when syncing the mirror to check that mirroring is not
> > >>> broken, so after new patches are applied to bpf-next. If we want this on
> > >>> GitHub, we would rather target the BPF CI infra.
> > >>>
> > >>> A nice point of having it in the repo would be the ability to add tests
> > >>> at the same time as we add features in bpftool, of course.

Indeed, it does not have to live in the tree, while it could be more convenient
as Quentin highlighted, as much as running it on BPF CI we could be just fine
by having it hosted in a separate repo.
People can always have a clone of the repo and use it to validate the behaviour
has not changed, or changed in expected ways, and have a separate PR if tests
are added. Definitely not as convenient, but likely better than nothing.


> > >>
> > >> Sounds nice in theory, but in practice that would mean that
> > >> every bpftool developer adding a new feature would need to learn rust
> > >> to add a corresponding test?
> > >> I suspect devs might object to such a requirement.
> > >> If tester and bpftool are not sync then they can be in separate repos.
> > >
> > > I'm also wondering what Rust and libbpf-rs dependency adds here? It
> > > feels like bash+jq or Python script should be able to "drive" bpftool
> > > CLI and validate output, no?
> >
> > As I understand, one advantage is to get an easy way to tap into
> > libbpf's functions to load the objects we need in order to test the
> > different bpftool features. There are a number of program/map types that
> > we just cannot load with bpftool at this time, so we need to set up the
> > objects we need with another loader. Libbpf-rs allows to do that, and
> > the "cargo test" infra seems like a convenient way to focus on the tests
> > only. Bash+jq wouldn't allow to load objects unsupported by bpftool, for
> > example.

There were a couple of reasons that you correctly enumerated:
- having a built-in test runner (that could have been other languages)
- libbpf-{cargo,rs} was taking care of the machinery with skeleton, lifecycle of
  a BPF program.
- "native access" to access/manipulate BPF objects from the testing language and
  use bpftool as a blackbox.
- caring about writing the test, not a framework to run them.
- convenience of the rust toolchain to manage depedencies.
- the bells and whistles that come with the language that make formatting/linting
  a no-brainer.
- bash+jq would have probably either limited, or getting overly complex/brittle
  beyond basic checks, and hard to maintain as more tests get added.
- python would have been filling this gap, but without native interaction.

aside from that, another motivation that helped with the choice is that I
originally wrote this as a way to validate bpftool was meeting our requirements
internally as we sync and deploy it, and rust is one of the languages that is
supported to run in our internal vm testing framework.

> 
> Can we use veristat to load BPF object files? we might need some
> option to auto-pin programs in some directory or something to keep
> them live long enough, I suppose, but it's totally in our control.
> 

This probably solves the loading part, but we should also be able to do this
with bpftool too.

> >
> > Manu, did you have other reasons in mind?

