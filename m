Return-Path: <bpf+bounces-17962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4237B8141DD
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 07:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C1FCB2109F
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 06:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0A8CA6B;
	Fri, 15 Dec 2023 06:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YURSuVHP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C72FCA64
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 06:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3b9f8c9307dso354884b6e.0
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 22:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702622230; x=1703227030; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=whK72q5+6sWngI0W57PiBzq7Y6B836ek51+hDtN0bh4=;
        b=YURSuVHPbAMwUQwNebp5+ncRgfr+Vxrtv+7iqa/SDTveCpvv0QLaKHODuML/DlPpI0
         l1QugwqhYk96fIvNLv1zhKl0NQfs0Xvh8gNq4FZ3GAjXh6ZtaOvzJo5Ovb6MUKJNaldA
         ZCGm2kRo1u00TzvR2iBsxGRGx6nqsqMoEZT8w/v7A0vljJaE5/tufTBU/xb7PcXCw+UD
         D4kDEVEuwMl9tt4QCNRefxlyzWXeB6uhQ6KNnTunWUoGZrv7L8Cb4drq5ff6Vw5CFQZr
         Z2anMJSwTcYE3RxRs06XLCCMQxXkcB1J8cyr7i90srdgnXRszlw2g1Ijx2WIMvZhKj1B
         Waxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702622230; x=1703227030;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=whK72q5+6sWngI0W57PiBzq7Y6B836ek51+hDtN0bh4=;
        b=Xz3pAcQKnXHplNenwwedN3U3kaXXsukGZd2XNdm4VRXoGcUuTwz/KrdASd4Q9Em8xg
         bA+IomXpamzfXhdXVw+RkmI07/jnr70nxqlfpuUrBJ27L4G6C+nFBYEDfhjlDDDbb/wO
         3VW2kiJRZltLY9avJdkRgxxUQA8khCokV+q7V0LgX/5WuN4P9C1IRV8E2grKioWl9Oue
         GdV4QjS2b2x/tVtXZs7h0m8VJdZhPrRJgGqDsSzvIxUg88XSUOW33zm3rKlSDeqB4Na+
         Qq1fkXX+9Q1HGjrVAhuL3jdGcTjDQx45V8IzIWvZrCczd4sfrx7jDkaPNwv6QQRh/q6+
         KQbQ==
X-Gm-Message-State: AOJu0YyAidO1VgnAr4qxMi21QOL4bBCU/qG2GtMXbsTYBDg6Z4j9cHHC
	VXMTudQgpbsmRXb8ENSWqBM=
X-Google-Smtp-Source: AGHT+IGXEJ9oGkq0vPeSLyGX7COdfoY4oxVtEbOYibTR1tRuoxL5QI5TU0JUJswLBGb5r40GYmFUsQ==
X-Received: by 2002:a05:6808:1786:b0:3b9:cc1e:4726 with SMTP id bg6-20020a056808178600b003b9cc1e4726mr14466623oib.75.1702622230250;
        Thu, 14 Dec 2023 22:37:10 -0800 (PST)
Received: from surya ([2600:1700:3ec2:2011:267b:5fd0:9667:5cbd])
        by smtp.gmail.com with ESMTPSA id h2-20020a056a00170200b006cea0054b9esm12606875pfc.213.2023.12.14.22.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 22:37:09 -0800 (PST)
Date: Thu, 14 Dec 2023 22:37:07 -0800
From: Manu Bretelle <chantr4@gmail.com>
To: Quentin Monnet <quentin@isovalent.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v1 bpf-next 1/9] bpftool: add testing skeleton
Message-ID: <ZXv0E0+npdrWNEvh@surya>
References: <20231116194236.1345035-1-chantr4@gmail.com>
 <20231116194236.1345035-2-chantr4@gmail.com>
 <CAADnVQ+Mb-eQUxp-0c_C_nVme0Sqy7CST_vaCiawefjTb5spiw@mail.gmail.com>
 <a9ac8c82-7b97-4001-a839-215eb4cc292f@isovalent.com>
 <CAADnVQ+f80KNBcjYRzBJw4zhYfhYa=Cw9bdQEe+Z1=CnQaa9Gw@mail.gmail.com>
 <4aa42cb9-a03b-403c-976b-a1426a2fcdc4@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4aa42cb9-a03b-403c-976b-a1426a2fcdc4@isovalent.com>

On Mon, Nov 27, 2023 at 05:07:15PM +0000, Quentin Monnet wrote:
> 2023-11-21 16:42 UTC+0000 ~ Alexei Starovoitov
> <alexei.starovoitov@gmail.com>
> > On Tue, Nov 21, 2023 at 8:26 AM Quentin Monnet <quentin@isovalent.com> wrote:
> >>
> >>>
> >>> Does it have to leave in the kernel tree?
> >>> We have bpftool on github, maybe it can be there?
> >>> Do you want to run bpftool tester as part of BPF CI and that's why
> >>> you want it to be in the kernel tree?
> >>
> >> It doesn't _have_ to be in the kernel tree, although it's a nice place
> >> where to have it. We have bpftool on GitHub, but the CI that runs there
> >> is triggered only when syncing the mirror to check that mirroring is not
> >> broken, so after new patches are applied to bpf-next. If we want this on
> >> GitHub, we would rather target the BPF CI infra.
> >>
> >> A nice point of having it in the repo would be the ability to add tests
> >> at the same time as we add features in bpftool, of course.
> > 
> > Sounds nice in theory, but in practice that would mean that
> > every bpftool developer adding a new feature would need to learn rust
> > to add a corresponding test?
> > I suspect devs might object to such a requirement.
> 
> True. I've been hoping the tests would look easy enough that devs could
> update them without being particularly versed in Rust, but this is
> probably wishful thinking, and prone to getting bugs in the tests.
> 
> I don't have a good proposal to address this, so I agree, this is
> probably not a reasonable requirement.
> 
> > If tester and bpftool are not sync then they can be in separate repos.
> 
> Makes sense. I'd like to have the tests in the same repo, but for this
> time, let's focus on getting these Rust tests added to the BPF CI infra
> instead, if there's no easy way to switch to a more consensual language.
> Manu, thoughts?

I am fine with that, the work I have done cleaning my original code for this
series is (or at least with minimal changes) self-contained.
Having them hosted outside the tree and used is likely better than nothing.
People can still build upon, and experience will help informing if we should
eventually try to merge this back in.


Manu
> 
> Quentin

