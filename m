Return-Path: <bpf+bounces-53886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5B9A5DC88
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 13:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D64FE3A6FD3
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 12:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3DF242900;
	Wed, 12 Mar 2025 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8d1l4KI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6134223F387;
	Wed, 12 Mar 2025 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741782373; cv=none; b=eQ2uekZ6qNrkqOIc2EeVPXRX/Eih4CRHXE4tnJ8ffneBDKkV9rfl4+9V7YrgXU8HeOkC1oXz/w4ooQaE4+VKR2GgNaUEw0/cZacJDu3MG7SxpynKiI3pN7zkhg1PBMVEATg8pO93eb8w3GUzLS11DxV3TPsvXceimqlC3eCA0hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741782373; c=relaxed/simple;
	bh=Ua0UmxOb+ZROksG8fotyV5KfxdhXw1sq9u9jSAigQHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/nODSrnvhzJa+Kic68dxGXY5OfI6Wz/D19ubXzH6+2ygOnfr7Knr9Oek85FMJUBbiAyla20/mSODmOjqvTxkzBlTanWUYHmZEkNtEZJYDuu17wVWxzB9nGzv0cX26ItCFeE85bDJa7++dj61hzh+ikSf+ei1io17HL/p0XCc6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8d1l4KI; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3cf880d90bdso20647705ab.3;
        Wed, 12 Mar 2025 05:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741782371; x=1742387171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiGeVOzvh7Hi2MVVeNQQQNYnGFd+aA2n3AELBo7vFzs=;
        b=a8d1l4KIqRPoehtSlMqjzGIf+GzCNMQoicvwEcBFIPPaOADKhy1JB/TaBDM8VL4bGe
         QV5HEEBEqZ/+7VkqIKkv6A3EppCSaSjFrwIgajUm4PLaw7/uyfxu3Pvv26dqmLxj3xD/
         vBX1yJbsaTumtsmXgHb+uCVK1qpQmMBSLPnEpDKtS2umrV8ghhXnPe0HVf9rdWTtWnJn
         v9wz7RzeW7OJWR32Ilpr2KN4RT9wUYfHKKxopJ3dngxxvtxgkKIyqPxhTtnaup6RzB7Y
         LGJ1AbxyBG9MECJaFA80BZQ0eSbrYBOfmsg4gxNwlxiMr4CRw274gBqRM/EiI5l4i6LN
         xgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741782371; x=1742387171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CiGeVOzvh7Hi2MVVeNQQQNYnGFd+aA2n3AELBo7vFzs=;
        b=mv1jPLUPaQ6+3WkIyQtSZbzl9BYkGPcap/gXi/w46VjehNfZHgztvoawxkuwim/lYT
         uiE/FKfWaFudxQS7RjeyRtw/kvozmo6mfkoCyUEDUK26f7HK0IxggQVOCNAR5aLqzaWq
         xd5yS/0ryVawdMQR212QSIbhcl259LputiF8WRBTey1yQemPqK5Xig+yevgG/HvbiLbe
         zIjURjnCZ9ETod2V+THbpbnM3PW9QCH8ETT1DBRoeldxMr9C1SSwMUV+Wg9ZEDePnHja
         0iUO+Kb5Xwrs5TngomTuWirlQinbGcebZwmGlHCoJOZhGdZsUF5c3roRKKj8P2ylJy5z
         UcfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrXK0l08bYo8sPNEh4CdR3wQiBel74V3f0w4bUyQoYFZ7VD0mhwdx0EPkRBZEcC/FLTp4=@vger.kernel.org, AJvYcCXBe6P4ZJFj4ugShFh31wKt/jHegWA5bRwjbl3QsA481YpFCH5ORYUXyObpNeeNfDKpXIYN47Ci@vger.kernel.org
X-Gm-Message-State: AOJu0YxpiMT6bt30jkRKhelQZB3tMO2Tw088ZNOk934/Qu2fVl6oke1v
	yS2WqFCIoxzSFz0C0+ZRPhO/Zgjw6re2SE1oHVcvud3PYYTHdQWLZOyOCHXdiNIBWrzJXL0O2xv
	4cBvQO6262S8VabN4JuZ69LdgHao=
X-Gm-Gg: ASbGncsoAAm1HOLc9KIe33R7+HL9l1KgJ3gpT0fTJh2ESyuRsh07UokqwD+KWMf1BES
	bhras0MDIgt7F3ErBc6eTqNaHjgYShA/nZxPZICTENnCkkKCXt4riHsNFzuuzS91x5t2HQyPmPs
	wIvhsO157l4qGKqf/IaKW7xWqt
X-Google-Smtp-Source: AGHT+IH0sYORq9CF7IyIvrTs9g/pykq2xTGAGTnhL7EN34gCGzwPvB/XesSoNyOkErYPGNELZXrFKgySaB6IXGcqPEc=
X-Received: by 2002:a05:6e02:1c0b:b0:3a7:87f2:b010 with SMTP id
 e9e14a558f8ab-3d4419712a9mr238183455ab.5.1741782371298; Wed, 12 Mar 2025
 05:26:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311085437.14703-1-kerneljasonxing@gmail.com>
 <80e745a45391cb8bb60b49978c0a9af5f51bec183f01a7b8f300992a4b14aa6f@mail.kernel.org>
 <CAL+tcoD8TAWT-_mU8wMT3zt-Thh5ZVfmBear5m=G4MbCbBS9XA@mail.gmail.com>
 <5e9fc094-8baf-4b67-b58e-dae5ff9ce350@linux.dev> <c6aec870-5c13-4d84-bca2-3b77513071b7@linux.dev>
 <CAL+tcoB7ZaYYyYsvR2QwAh8twEkoKjwn-gFZzsY3xM0VSsNJVQ@mail.gmail.com>
In-Reply-To: <CAL+tcoB7ZaYYyYsvR2QwAh8twEkoKjwn-gFZzsY3xM0VSsNJVQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 12 Mar 2025 13:25:34 +0100
X-Gm-Features: AQ5f1Jodu1ngKFXzJBua5J-EFX8zdfkeSzkGSDbj2PmVMr1vdVZJdWVEV23dFfk
Message-ID: <CAL+tcoBiLEJCY==xkxTBAvNSZ2P4-16nZpELkgq=sdB-=kM1Yw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/6] tcp: add some RTO MIN and DELACK MAX
 {bpf_}set/getsockopt supports
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bot+bpf-ci@kernel.org, kernel-ci@meta.com, andrii@kernel.org, 
	daniel@iogearbox.net, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 7:50=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Tue, Mar 11, 2025 at 7:44=E2=80=AFPM Martin KaFai Lau <martin.lau@linu=
x.dev> wrote:
> >
> > On 3/11/25 11:39 AM, Martin KaFai Lau wrote:
> > > On 3/11/25 4:07 AM, Jason Xing wrote:
> > >> On Tue, Mar 11, 2025 at 10:26=E2=80=AFAM <bot+bpf-ci@kernel.org> wro=
te:
> > >>>
> > >>> Dear patch submitter,
> > >>>
> > >>> CI has tested the following submission:
> > >>> Status:     FAILURE
> > >>> Name:       [bpf-next,v2,0/6] tcp: add some RTO MIN and DELACK MAX =
{bpf_}set/
> > >>> getsockopt supports
> > >>> Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?
> > >>> series=3D942617&state=3D*
> > >>> Matrix:     https://github.com/kernel-patches/bpf/actions/runs/1378=
4214269
> > >>>
> > >>> Failed jobs:
> > >>> test_progs-aarch64-gcc: https://github.com/kernel-patches/bpf/actio=
ns/
> > >>> runs/13784214269/job/38548852334
> > >>> test_progs_no_alu32-aarch64-gcc: https://github.com/kernel-patches/=
bpf/
> > >>> actions/runs/13784214269/job/38548853075
> > >>> test_progs-s390x-gcc: https://github.com/kernel-patches/bpf/actions=
/
> > >>> runs/13784214269/job/38548829871
> > >>> test_progs_no_alu32-s390x-gcc: https://github.com/kernel-patches/bp=
f/actions/
> > >>> runs/13784214269/job/38548830246
> > >>
> > >> I see https://netdev.bots.linux.dev/static/nipa/942617/apply/desc th=
at
> > >
> > > It cannot apply, so it applied to bpf-next/net.
> > >
> > > I just confirmed by first checking this:
> > > https://github.com/kernel-patches/bpf/pulls
> > >
> > > then find your patches and figure out bpf-net_base:
> > > https://github.com/kernel-patches/bpf/pull/8649
> > >
> > >> says the patch can not be applied. Could it be possible that CI
> > >> applied it on the wrong branch? I targeted the net branch.
> > >>
> > >> I have no clue this series is affecting the following tests
> > >
> > > The test is changing the exact same test setget_sockopt and it failed=
, so it
> > > should be suspicious enough to look at the details of the bpf CI repo=
rt.
> > >
> > > The report said it failed in aarch64 and s390 but x86 seems to be fin=
e.
> > > When the test failed, it pretty much failed on all tests. It looks li=
ke some of
> > > the new set/getsockopt checks failed in these two archs. A blind gues=
s is the
> > > jiffies part.
> >
> > and forgot to mention that you can run bpf CI before posting. This may =
be easier
> > to test other archs. Take a look at Documentation/bpf/bpf_devel_QA.rst.=
 The
> > section "How do I run BPF CI on my changes before sending them out for =
review?"
>
> Thanks for the pointer.
>
> Let me try one patch by one patch. Having checked the series itself, I
> still have no clue. You said jiffies part. What is that? Could you
> please point out a file name or configuration so that I can follow you
> and then do some tests?

Oh, I realized that. Maybe I need to adjust the test and expected
value in the selftests to make it compatible with different HZ values
in those arch configs.

Thanks,
Jason

