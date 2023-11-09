Return-Path: <bpf+bounces-14613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEDB7E7109
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 19:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F10C281077
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 18:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17C331A75;
	Thu,  9 Nov 2023 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZSIlqZy"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C111F20B14
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 18:01:15 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C255B3AA8
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 10:01:14 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53d8320f0easo1829742a12.3
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 10:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699552873; x=1700157673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saUqnmKHeD41S4UoJkycnvIYF4FoNbegUO8cROYmSUg=;
        b=AZSIlqZywKNVH2uaHs5d4VLZbd0uQF5bCizosKnhRHQZW9Zk0+o56AuHcBxNcMCewF
         QoPe6RNJKwxp7ttKd3PZKZ13bhy9WvySlwvzuxPY3csz9RgZAt3U3Dmt3eDhppXWk0s4
         CHQi94/H7b7bLK/TnyrYwx+SVMpA2FWmDsCKozGx7ptEXVvTH7gKqI4EdajjTBuuWiev
         F6jB1F5iYK7q9ymSbIzvCHQHgDPS/1bVjJ7hLyoA7ZVwbTfsRX5mDbUrvIimyppqbODn
         ZK4Nk5laJSsPMV6EBwQk26+iK/nBMzVDAXfCn7il3v1Dldv5srTz79HCw2ZJvESrXyur
         4pEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699552873; x=1700157673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=saUqnmKHeD41S4UoJkycnvIYF4FoNbegUO8cROYmSUg=;
        b=jzz83cRoSZNd2ZNjADhjAT66jh9s3djM4JlpPW+He5aVuKGx5UnhcHYoUe0CE3fO74
         mTdIc/nNfD1rhslAK3Q2vYsK1Dmfbq2rRStF0Cc6pq/NrruWVvEb9OkkYfLhUfmNxQGh
         ZjrLkUSKVy9KNSRceqT0/T5Yz4QEnFCwdUNclxafybyOWo+gqn5iCAsAXHyJcrxTdWOc
         EjHELvyltuT56ShR3b4RVVVJg0otbLS4vi8S6WUXb4mWmvFt4a7S6ZejpN20ABaNFBUP
         10LFc6nXNMWH2W5kqEtTyGYgMkKKyhqpYqfabFbnsvughDKwreAwOnyspANox3/5nIYY
         Ut6w==
X-Gm-Message-State: AOJu0Yx5XfBR7r+IgecW/rOtADH5sh9A3zlfpYGR922AHzNtly6tVIjp
	FYfPk8CXWiZ0CSwEwbLux1Sm/ozAYAbWtY/vvtE=
X-Google-Smtp-Source: AGHT+IHpIjMIZBatJpbhsIxUORhv8WAY59Ex7Oz1Z4koUl5y/WmjC7um+9xPfazsKLAIIHoYCntR3ipqvYRCAjuISrQ=
X-Received: by 2002:a17:907:3d91:b0:9d3:85b9:afcf with SMTP id
 he17-20020a1709073d9100b009d385b9afcfmr4730832ejc.12.1699552873053; Thu, 09
 Nov 2023 10:01:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031050324.1107444-1-andrii@kernel.org> <20231031050324.1107444-4-andrii@kernel.org>
 <71cc364752f383559c7d7a570001fd353f0ca8aa.camel@gmail.com>
 <CAEf4BzY1-mcN5Wjf4-FOKQvnom+0EV=a=cGxvBO9=rbCS0kzwA@mail.gmail.com>
 <b335aa904dca981058e1db92b6270960f2a28948.camel@gmail.com>
 <CAEf4BzYHOMgxE1NitS_8YosrYWFzZ-BT8qL=Fnyna9tDA2M+2A@mail.gmail.com> <CAADnVQ+wMq36--Wp1COwbfUsCNo7q1JyHh+QzRvFNNmkvdsmEg@mail.gmail.com>
In-Reply-To: <CAADnVQ+wMq36--Wp1COwbfUsCNo7q1JyHh+QzRvFNNmkvdsmEg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Nov 2023 10:01:01 -0800
Message-ID: <CAEf4BzZDMHvBYKc+=jwdXBE36E=r8n5zzpvpzy5fTtL56d+2Cg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/7] bpf: enforce precision for r0 on callback return
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 9:58=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Nov 9, 2023 at 9:50=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > >
> > > The r0 returned from bpf_loop's callback says bpf_loop to stop iterat=
ion,
> > > bpf_loop returns the number of completed iterations. However, the ret=
urn
> > > value of bpf_loop modeled by verifier is unbounded scalar.
> > > Same for map's for each.
> >
> > return value of bpf_loop() is a different thing from return value of
> > bpf_loop's callback. Right now bpf_loop implementation in kernel does
> >
> > ret =3D callback(...);
> > /* return value: 0 - continue, 1 - stop and return */
> > if (ret)
> >    return i + 1;
> >
> > So yes, it doesn't rely explicitly on return value to be 1 just due to
> > the above implementation. But verifier is meant to enforce that and
> > the protocol is that bpf_loop and other callback calling helpers
> > should rely on this value.
> >
> > I think we have the same problem in check_return_code() for entry BPF
> > programs. So let me taking this one out of this patch set and post a
> > new one concentrating on this particular issue. I've been meaning to
> > use umin/umax for return value checking anyways, so might be a good
> > idea to do this anyways.
>
> Just like Ed I was also initially confused by this.
> As you said check_return_code() has the same problem.
> I think the issue this patch and similar in check_return_code()
> should be fixing is the case where one state went through
> ret code checking, but another state with potentially out-of-range
> r0 got state pruned since r0 wasn't marked precise.

Right.

> Not sure how hard it would be to come up with a selftest for such a scena=
rio.

Yep, I'll think of something. Lots of tests to come up with :)

