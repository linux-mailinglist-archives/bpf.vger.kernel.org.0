Return-Path: <bpf+bounces-14612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC507E7100
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 19:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2446328112F
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 18:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9704931A8B;
	Thu,  9 Nov 2023 18:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZ3O0ohz"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48003159F
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 18:00:05 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1DB3AA7
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 10:00:05 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9dd6dc9c00cso200271866b.3
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 10:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699552803; x=1700157603; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zfTSpZZfF59l1eauayuYmO67OitkdwzJLHLFvBeZPx0=;
        b=KZ3O0ohzmV0O6roVkzsno5EFh8EL6dpaYxnaYUGSwxgvD8bc7+9VwvxA0wQbmjYUX4
         n0qJ2yCWQXhtIcGd72AYXkD6ftFaE/vIkSoAEzWED9FgSvYEq1JdU96KWG3MddAzjIMt
         UDst7UOsoT06RRui9Tm9ngYvxvXcUTv0dcQfLY9bIoRUFBInWnM4fX9RGwbv6tEuy+5U
         rMyXCw5NseR2GBV5S6YOmI/U/i9dUYTt34D7Ku7OH5P/TX8VZxg0dNvVXbJehvXXfsr2
         K5Iqe9wDLIMZE4ZKPPd+71Rhp+etlCvvN3b/Bil3G+aZv3uXNeYM9CDd4FfMtp/mVisY
         /Jbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699552803; x=1700157603;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zfTSpZZfF59l1eauayuYmO67OitkdwzJLHLFvBeZPx0=;
        b=XCe3BxqCYCuBwn0QAoDt633UEPmMK0Le+Trq8fSQEymfanBislVP7BtOsA6X0+OBSg
         tUimgevEI83exlebxDSZp+u/1k4nBzvMPlWZT2FNIIeAaTp6fm0XHm/01l3aqh078FTP
         gZISjo5wSEMuYHu+sFv/M/bxLVg/RCGMWJNb+dtmj6uUsuZjjPRTzMWVx5mKRbspsUGp
         xQVBDweZkasueeZypKwktI6zcL7VJC3AOv9Eh/TOFonYMBMI2nTn6fjiZFNPkZAeOmz4
         qH8ZI12XUPK9nTnn7Buq1K5V2Xy8NOOE30J/MA2PSA1TTC2ztsnzS7pQ6phEMfz4w1lC
         J9lA==
X-Gm-Message-State: AOJu0Yysjs6rtZlwfuRmRwbonqVREQtG+ndFELmN5RFA82RLcV9jDGYq
	MJh4nbKJxPfYdyqwrAGFlyM=
X-Google-Smtp-Source: AGHT+IFsjerdvT0F4cng8uIOcNO/9J+pH4XXgIQqEGEi5PGECrYjSj1p+70xjURdxs2M9KFOQDwGCg==
X-Received: by 2002:a17:906:6a07:b0:9db:e02d:b72a with SMTP id qw7-20020a1709066a0700b009dbe02db72amr4869515ejc.6.1699552803412;
        Thu, 09 Nov 2023 10:00:03 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id i9-20020a1709064ec900b009a5f1d15642sm2828253ejv.158.2023.11.09.10.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 10:00:02 -0800 (PST)
Message-ID: <0a2b4002146fdd3338ccb01009e349338a806f3f.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/7] bpf: enforce precision for r0 on callback
 return
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com
Date: Thu, 09 Nov 2023 20:00:02 +0200
In-Reply-To: <CAEf4BzYHOMgxE1NitS_8YosrYWFzZ-BT8qL=Fnyna9tDA2M+2A@mail.gmail.com>
References: <20231031050324.1107444-1-andrii@kernel.org>
	 <20231031050324.1107444-4-andrii@kernel.org>
	 <71cc364752f383559c7d7a570001fd353f0ca8aa.camel@gmail.com>
	 <CAEf4BzY1-mcN5Wjf4-FOKQvnom+0EV=a=cGxvBO9=rbCS0kzwA@mail.gmail.com>
	 <b335aa904dca981058e1db92b6270960f2a28948.camel@gmail.com>
	 <CAEf4BzYHOMgxE1NitS_8YosrYWFzZ-BT8qL=Fnyna9tDA2M+2A@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-11-09 at 09:50 -0800, Andrii Nakryiko wrote:
> On Thu, Nov 9, 2023 at 9:38=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Thu, 2023-11-09 at 09:32 -0800, Andrii Nakryiko wrote:
> > > On Thu, Nov 9, 2023 at 7:20=E2=80=AFAM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > > >=20
> > > > On Mon, 2023-10-30 at 22:03 -0700, Andrii Nakryiko wrote:
> > > > > > Given verifier checks actual value, r0 has to be precise, so we=
 need to
> > > > > > propagate precision properly.
> > > > > >=20
> > > > > > Fixes: 69c087ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
> > > > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > >=20
> > > > I don't follow why this is necessary, could you please conjure
> > > > an example showing that current behavior is not safe?
> > > > This example could be used as a test case, as this change
> > > > seems to not be covered by test cases.
> > >=20
> > > We rely on callbacks to return specific value (0 or 1, for example),
> > > and use or might use that in kernel code. So if we rely on the
> > > specific value of a register, it has to be precise. Marking r0 as
> > > precise will have implications on other registers from which r0 was
> > > derived. This might have implications on state pruning and stuff. If
> > > r0 and its ancestors are not precise, we might erroneously assume som=
e
> > > states are safe and prune them, even though they are not.
> >=20
> > The r0 returned from bpf_loop's callback says bpf_loop to stop iteratio=
n,
> > bpf_loop returns the number of completed iterations. However, the retur=
n
> > value of bpf_loop modeled by verifier is unbounded scalar.
> > Same for map's for each.
>=20
> return value of bpf_loop() is a different thing from return value of
> bpf_loop's callback. Right now bpf_loop implementation in kernel does
>=20
> ret =3D callback(...);
> /* return value: 0 - continue, 1 - stop and return */
> if (ret)
>    return i + 1;
>=20
> So yes, it doesn't rely explicitly on return value to be 1 just due to
> the above implementation. But verifier is meant to enforce that and
> the protocol is that bpf_loop and other callback calling helpers
> should rely on this value.
>=20
> I think we have the same problem in check_return_code() for entry BPF
> programs. So let me taking this one out of this patch set and post a
> new one concentrating on this particular issue. I've been meaning to
> use umin/umax for return value checking anyways, so might be a good
> idea to do this anyways.

The precision mark is necessary if verifier makes some decisions
basing on the value. E.g. whether certain code path would be take or
whether specific value would be used as a pointer offset.
Neither is true for existing callbacks, value returned by callback
does not affect any verifier decisions.

