Return-Path: <bpf+bounces-40449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF986988C9D
	for <lists+bpf@lfdr.de>; Sat, 28 Sep 2024 00:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF85E1C20DA3
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 22:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0C51B5ED9;
	Fri, 27 Sep 2024 22:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBsYKI2R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9641B5ED4
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 22:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727477310; cv=none; b=KJZ+Y2lJBe6yatajsForaEKMzVqm/stekktX4+s7wrOPHzXWLEX5iq9Fe/+tmSLx/U0ojFoXCvh4Yibij8LbFbGdwlqHrQC3bWVriEA3MQ+UymIzFzppT0ywEOePmS8KodPtfeMWjFtssam+nLUud9sa0I/oDO+LIeALoUhxMkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727477310; c=relaxed/simple;
	bh=9NN6VbsRPAy5GwU6q/z1wEiREUUoRjjea/aUE5UR21o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbpR1/cmLvehHCKMmJsI4j3e6Ufqd2qA096LKeTbZuQyd+al6ktWhqr2CgAurqgCX0+uoaF7px8wLpCcYenzv6irqGdxbIFxBsunF/A9SsgsZ+1ZlLL0seAZi00z9rGQGXutb3vv4x2XIFlb4vNWB+kpdH/KzjR0A1POybeKka0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBsYKI2R; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e09a276ec6so2080468a91.0
        for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 15:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727477309; x=1728082109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqrVCWLT2Y7jc7iQ2NzMIo8gUo8tw8vrSs4UXb76dAc=;
        b=OBsYKI2RlzRzcvWgWR5VRH0SJcMJ0cUBo/2GNk+9A8OshtkyqRDzsBVJG8M8aIuVUN
         fGp2ASoKPzwK5GLn3TGZSwsEp86fGIRO71Hh72Stv3fVfaVQ90v2v4+BbfwuXB2ZVNK1
         CQV/nW+FDvNdcCQit+FSgdV9I3QV4XH37EIBQyvH4ymKoKCp+/h/KO5oHqSaAJPuWjOj
         OvaG9F522UvzzQ3MzVT4n2Smt6OFkA3josmQ+X+MM30um8PPbAJ8EL9PK42TvK84uL+T
         AwD5qy1cn9SEbJNdPnyNi8kCNb67YGDUI6kbb3uZrULIN4fcY2NZEbUtpCQpH4UA3ihy
         Keag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727477309; x=1728082109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqrVCWLT2Y7jc7iQ2NzMIo8gUo8tw8vrSs4UXb76dAc=;
        b=FMEBEn//bnyncpruqRTzB/yeqyNNnFIRvMFpGrvlsX09a5bbV/ZOeYMWeWzD+gqcN7
         ruMwfQaxmeXu5zYJ/07EKt5w3FgFttpyQ/F6BqEU7ZobQkcdekCULs500YRsSfgDin0t
         nITB4cH0fmfOWjWsARh87KZyXe3cbI3AOW/YxYQhYpcCgIY+agixbbwuL1tmxawcRvQ0
         y4IF3BLnNb3faKJman4q7XUXv51cNwDEQ/BvJp9jhawTD3ZJ1sIBil2mRKX4I/hl8zS3
         hGym9Kz5tTkWwkEbAnQQGynqFyfTaPaSVcdLR8QGvuoJ1hOmFAgEw06+r0X5cgGItEAp
         pxqg==
X-Forwarded-Encrypted: i=1; AJvYcCWb2ggauR9mGWP224vdkEGHcfCEMxshl7Y+z33lzabY3hGDxq6QbcUhD5ASPPhAORB0JKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw/uFHEnb2cbrWTSY/tAa/SLbWqzGa3kv19n0rVm6qol0YvRmw
	Q0g4mFQNfisKv24uLRxgF8GMbkDZUWwXGuO+fuU51MQ+oDfBosiwe19xo0lCTx2ORDsnGeCuaIA
	k8eLnEdEqtGrWwLKAEFuHarIlAKw=
X-Google-Smtp-Source: AGHT+IHn3vV6ktGaLt0JdMFTxdgGLcIVNv+QgiBg1nCknZAuU63gDVIlKYRzex4uGSbo/6CnqU0xy+A1ZPJ2r459+Ik=
X-Received: by 2002:a17:90a:ad8b:b0:2e0:9236:5bb1 with SMTP id
 98e67ed59e1d1-2e0b8ec017bmr5873671a91.30.1727477308721; Fri, 27 Sep 2024
 15:48:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918203925.150231-1-mykyta.yatsenko5@gmail.com>
 <2a5997cd-ef30-42e6-b89b-6a1841e0c822@linux.alibaba.com> <2b838e54-4515-432c-b492-ccc16e000e7e@gmail.com>
In-Reply-To: <2b838e54-4515-432c-b492-ccc16e000e7e@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 27 Sep 2024 15:48:16 -0700
Message-ID: <CAEf4BzYZQsr2RUYqsF2tCQ_aiWGPsQ-d_BvAs14S7mnj4yTDww@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: emit top frequent code lines
 in veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Philo Lu <lulie@linux.alibaba.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>, Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 5:08=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 19/09/2024 03:51, Philo Lu wrote:
> >
> > Hi Mykyta,
> >
> > On 2024/9/19 04:39, Mykyta Yatsenko wrote:
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Production BPF programs are increasing in number of instructions and
> >> states
> >> to the point, where optimising verification process for them is
> >> necessary
> >> to avoid running into instruction limit. Authors of those BPF programs
> >> need to analyze verifier output, for example, collecting the most
> >> frequent source code lines to understand which part of the program has
> >> the biggest verification cost.
> >>
> >> This patch introduces `--top-src-lines` flag in veristat.
> >> `--top-src-lines=3DN` makes veristat output N the most popular sorce c=
ode
> >> lines, parsed from verification log.
> >>
> >> An example:
> >> ```
> >> $ sudo ./veristat --log-size=3D1000000000 --top-src-lines=3D4
> >> pyperf600.bpf.o
> >> Processing 'pyperf600.bpf.o'...
> >> Top source lines (on_event):
> >>   4697: (pyperf.h:0)
> >>   2334: (pyperf.h:326)    event->stack[i] =3D *symbol_id;
> >>   2334: (pyperf.h:118)    pidData->offsets.String_data);
> >>   1176: (pyperf.h:92) bpf_probe_read_user(&frame->f_back,
> >> ...
> >> ```
> >
> > I think this is useful and wonder how can I use it. In particular, is
> > it possible to know the corresponding instruction number contributed
> > by the source lines?
> >
> No, as far as I know, we don't have that info, so we just use number of
> source lines as a proxy for number of instructions. Eduard suggested to
> collect
> instruction count per source line in verifier, maybe that actually what
> we should do.

Let's start simple and then build upon that. I'd rather finalize the
minimal first version before going down to assembly instruction
recording and counting.

> > Assume a prog is rejected due to instruction limit. I can optimize the
> > prog with `--top-src-lines`, but have to check the result with another
> > "load" to see the total instruction number (because I don't know how
> > many instructions reduced with the optimized src lines).
> >
> > Am I right? or is there any better method?
> Yes, you are right.
> >
> > Thanks.
>
>

