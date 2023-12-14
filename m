Return-Path: <bpf+bounces-17746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFEF8123BD
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 01:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB179282877
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 00:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F5E389;
	Thu, 14 Dec 2023 00:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwtZnFtf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D2793
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 16:12:42 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-33642ab735dso702484f8f.0
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 16:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702512760; x=1703117560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AITTsgzKebJPE9iH4uhS3DRrLR8rSFHxKISxf0g6VbM=;
        b=HwtZnFtfzScFkCa4Ysz9TCDaGuqGhb65ytPcdMoHpYSWXBnfWZv2awp+4SfUidIcq+
         n4la4+ZDSNn8114uQhl9KNXN222ry9GNlEv3XGzYrgQNJCMlUBUOpYjQyWTYkrFj0JEF
         OlVU3i0XvXLnzkmWkCIrzP3fdSKZn8mf0/2OiAOqqT78SPc3KRRT4J8bIv8o8r1OLDFv
         soIUsuVfaEMVEE3/Y06feP7OydSjrsi9FRPCxsv9BrZPLmi6Yfmb4GH8/8tLW19I/rDP
         ENXg9LEll3pr89Pa/jzPI463AWAKdxjeyStSCSyQizKPF357opfKutsWXuTrGQBIYokh
         kllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702512760; x=1703117560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AITTsgzKebJPE9iH4uhS3DRrLR8rSFHxKISxf0g6VbM=;
        b=lhLkLskvKms+1FokbLM7szLTeDpseRWRr6XzPbzQXt63BFGKfKPnXSnCn5qFnJW4py
         1uXyey/DGZwUD1FV2+rVRE1nj93H/DmeMmRzNo5szgazCWq+af2JzJb509n/oFj2VZvN
         ljHVGYwR79FH5J1uCexAmIw1y+az8g1U+hvHl7wEE+s4wwLUnfsuwI1XPgW9yWq25YI5
         7CHoG+AM0BZtOsRQpOwvSOQvQbc9zppPm7DeKQLxwccW83Sb7oJW0mHurkZ1OiE1mKIc
         UUjjisVHJoK97srERDo9OnJC4xmAJd69JMQCUVUMWW6BbYxSRoEJRz8k0McEM5BxtTkQ
         ZZoQ==
X-Gm-Message-State: AOJu0Yz3dgelEXcYSo8JrlCPPsKeDAKycQZLpfvqgTIbaRJG+iBhQuWF
	2LTssuZLJP4zmcXIvPVUcZmHpqIaGsBAa+zdNx8=
X-Google-Smtp-Source: AGHT+IEXBiT9YVJZOOt/YR3L8JfnHSAhRTjZqCY5lNeuDZ8Rl84u5JwJzcTxjWfED8j45jL3OhW0/Ro+LyvDF5A3C6g=
X-Received: by 2002:adf:ec85:0:b0:336:424a:ebce with SMTP id
 z5-20020adfec85000000b00336424aebcemr332970wrn.274.1702512760209; Wed, 13 Dec
 2023 16:12:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127201817.GB5421@maniforge> <072101da2558$fe5f5020$fb1df060$@gmail.com>
 <20231207215152.GA168514@maniforge> <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com>
 <20231212214532.GB1222@maniforge> <157b01da2d46$b7453e20$25cfba60$@gmail.com>
 <CAADnVQKd7X1v6CwCa2MyJjQkN8hKsHJ_g9Kk5CwWSbp9+1_3zw@mail.gmail.com>
 <20231212233555.GA53579@maniforge> <CAADnVQJ-JwNTY5fW-oXdTur9aDrv2NQoreTH3yYZemVBVtq9fQ@mail.gmail.com>
 <20231213185603.GA1968@maniforge>
In-Reply-To: <20231213185603.GA1968@maniforge>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 13 Dec 2023 16:12:28 -0800
Message-ID: <CAADnVQLOjByUKJNyLdvDzwuegtjZFwrttHft_1o8BoyDCXQvDQ@mail.gmail.com>
Subject: Re: [Bpf] BPF ISA conformance groups
To: David Vernet <void@manifault.com>
Cc: Dave Thaler <dthaler1968@googlemail.com>, bpf@ietf.org, bpf <bpf@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 10:56=E2=80=AFAM David Vernet <void@manifault.com> =
wrote:
>
> Something I want to make sure is clearly spelled out: are you of the
> opinion that a program written for offload to a Netronome device cannot
> and should not ever be able to run on any other NIC with BPF offload?

It's certainly fine for vendors to try to replicate Netronome offload.
The point is that it was done before any standard existed.
If we add compliance groups to the standard now they won't fit
netronome and won't help anyone trying to be compatible with it.
See the point about compatibility with -mcpu=3Dv3 and not v1.

> Why else would they be asking for a standard if not to
> have some guidelines of what to implement?

Excellent question. I don't know why nvme folks need a standard.
Lack of standard didn't stop netronome.

>
> How do we know the semantics of the instructions won't be prohibitively
> expensive or impractical for certain vendors? What value do we get out
> of dictating semantics in the standard if we're not expecting any of
> these programs to be cross-compatible anyways?

and that's a problem. hw folks are not participating in this discussion.
Without implementers there is little chance to have successful guidelines
for compatibility levels.
per-instruction compatibility is already accomplished.
We don't need groups for that.

> > "Here is a standard. Go implement it" won't work.
>
> What is the point of a standard if not to say, "Here's what you should
> go implement"?

Rephrasing... "go implement it _all_" won't work.
The standard has value without insn groups.
Every instruction has specific meaning and encoding.
That's what compatibility is about. Both sw and hw need to
perform that operation.

