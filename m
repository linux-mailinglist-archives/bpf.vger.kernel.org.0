Return-Path: <bpf+bounces-67316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7061CB426E6
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 18:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1254B3AA761
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 16:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4F82EBDE5;
	Wed,  3 Sep 2025 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="X8jd2hW9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636F52D63E4
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916920; cv=none; b=I9N5jAF+O4C7/WafJIaU7nTGshLie6UjpurVdMzbAmeLbdbcEAVrzXGOvuy8B0zL/IgtP3s090wSaTNhN6d+saWHxIVwhwFHgMuu+pQB92OYh0C6ksYc+n/l/7TR6V5v35wJR8If3R3797JCFwXqsulCf2IPiNWOPC25puaUNSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916920; c=relaxed/simple;
	bh=SW86Pa8tL9jJvB1VD8DVFwCip3xXCPxw502oGPadup0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnCfKueFYlhmajGn7SIlmRDVClPUlvhzyvDVj/ev+Nq93rEQJeJOE721I+C8yxkdMwt9vd1HBaLvefx5cjT84l5a9nw/TSGsuUqpRxBiFyKhfOCE/S0rzEHTA4WC1Orgz+I7LSMJ3Fg3pFB+imAdn2y+WStDhc32dMFfRzOjLhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=X8jd2hW9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-248df8d82e2so1273575ad.3
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 09:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756916918; x=1757521718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwqVHQFmjaqzjJdUzru33mMJyAwAPUHjB9ickCmO2M0=;
        b=X8jd2hW9Mbcx4ryn09yBy79c/ozwuKMdnaUtolfmV2EGfCgsZVNRLvlthOPZnLjM/t
         QwBG02nCI/DqTeHDQSjMx968nuVeWNGIQNQMQ8u8teqtNtkhIcyr/v3X03y4JMowBaSz
         JuO6Pjk5zMxN+GGxT3xPxGsumpA/ffk2l2TOBlmauFlB9Ay2apewBNb87ru6ZEji8dU5
         fLJ3OFoVaheX+rM30o270oKRF0Bd4x/uzDVjXSAmNK0sghkxI9WGmBxsdJ1s44emsvWg
         cU2qEADyKvkO/dZZC6h6B6U7TThAzEwp0bOTRWCVdbGNgp/d3aLKKzltda3HpNckGeHL
         XCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756916918; x=1757521718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwqVHQFmjaqzjJdUzru33mMJyAwAPUHjB9ickCmO2M0=;
        b=Sgc9Ce2BnUPOKXIG9L8ibFgsR0MBDJDFN5eJYlkQBXDZd1qEfGfJh9Dsh4kOo+PGNz
         0WOvzhRGxUFCs1SDLEwBAkOl6LC2D/JK2lmLEHdXSG/qdK/TnR5K8xeFzrlKVHY4W5xZ
         Eh5Hoc+ddxXXstJacQOwk5vP8meik1dGl1HL1WbGjQv4rm6B1RqQcbSv7dg/uaC2zP9F
         bWY5ICBvtHctxqzF/h97Dxu/UgAgEFzGF9cUCix3OgqlRkwHVE4p6AB4WTM9JR+4g6Dp
         i4F9P9a5OuIsMrpqORV/BExYX+IjXhaW38Ls51w4L/z5E0nIMYwsdJPN+VgpadhbEosx
         qcFQ==
X-Gm-Message-State: AOJu0Yz2uD1oulWx/GKKVtgF3eB5cLirinqWSa5YZvhXMA27Hy9tHKzy
	uspNRtT1G2iFNzF2AMFzDSdwMEkJGN9S3Rx+MIMF8vDWt6pANuqfDqQc9LIK334BOwoHKE6Arni
	rZbHi8ffNplWBK3kkPXO7tfxxYzPtkrzqZ7rdgZW4
X-Gm-Gg: ASbGncu3lHloL4SfEjiYhRQ33KnTaPHTbVZg5FNiAQs8qz14rv0jYgj/RnImR7NRCPA
	9n+Yv4Kyc/tdcBvHXlln7I56o4mVPVVRpy52DC9hLT0ezaNgeLdQgk7exRkuRsVte9ReZNkTUb2
	ZTdKo5I1oEzkwa+A/lvLx4DBvzbBcUFlxK3tMVSdEyMsG6r7HFybxb3opV2ELVk0a5pnkqp4JJa
	AXugFMyycjJgBjPgw==
X-Google-Smtp-Source: AGHT+IEg1m77r/KZrAQ1g/BC3tPV7Agw+SDMjKj8dWXplLbw46Sop9bb5uq7HGh2DLyEfOxYx92HsTG6vMtNIW0KvCI=
X-Received: by 2002:a17:902:ec85:b0:248:f869:ffba with SMTP id
 d9443c01a7336-24944873f68mr228625935ad.5.1756916917508; Wed, 03 Sep 2025
 09:28:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813205526.2992911-1-kpsingh@kernel.org> <20250813205526.2992911-9-kpsingh@kernel.org>
 <CAHC9VhR=VQ9QB6YfxOp2B8itj82PPtsiF8K+nyJCL26nFVdQww@mail.gmail.com>
 <CACYkzJ7vBf3v-ezX1_xWp6HBJffDdUMHC3bgNUuSGUH-anKZKg@mail.gmail.com>
 <CAHC9VhT2Q4QOKq+mY9qWHz8pYg6GzUuhntg1Vd-cpGcQ7x6TLg@mail.gmail.com> <CAHC9VhTFF4gnc2Lu4XOkA+20sQtcvG3WgmJnXN4eiPSifc-+sg@mail.gmail.com>
In-Reply-To: <CAHC9VhTFF4gnc2Lu4XOkA+20sQtcvG3WgmJnXN4eiPSifc-+sg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Sep 2025 12:28:26 -0400
X-Gm-Features: Ac12FXw3pUtbxdE-NPYVAm9V8P0AYJYvjvRjNK_FU4WZldZSnpH1WaUicMUaZHk
Message-ID: <CAHC9VhRmx=tQoLOqVivXtkEpDRCQP6QAAEK6Lo0qd8ThkecuYg@mail.gmail.com>
Subject: Re: [PATCH v3 08/12] bpf: Implement signature verification for BPF programs
To: ast@kernel.org, KP Singh <kpsingh@kernel.org>, andrii@kernel.org, 
	daniel@iogearbox.net
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 3:19=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Wed, Aug 13, 2025 at 6:17=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Wed, Aug 13, 2025 at 5:37=E2=80=AFPM KP Singh <kpsingh@kernel.org> w=
rote:
> > > On Wed, Aug 13, 2025 at 11:02=E2=80=AFPM Paul Moore <paul@paul-moore.=
com> wrote:
> > > >
> > > > It's nice to see a v3 revision, but it would be good to see some
> > > > comments on Blaise's reply to your v2 revision.  From what I can se=
e
> > > > it should enable the different use cases and requirements that have
> > > > been posted.
> > >
> > > I will defer to Alexei and others here (mostly due to time crunch). I=
t
> > > would however be useful to explain the use-cases in which signed maps
> > > are useful (beyond being a different approach than the current
> > > delegated verification).
>
> I wanted to bring this up again as it has been another week with no
> comment from the BPF side of the house regarding Blaise's additions.
> As a reminder, Blaise's patch can be found here:
>
> https://lore.kernel.org/linux-security-module/87sei58vy3.fsf@microsoft.co=
m

Another gentle ping.  I realize everyone is busy, and August is a
popular month for holidays, but it has been a month since Blaise
posted his patch/snippet; it would be nice to get some feedback on the
basic idea.

https://lore.kernel.org/linux-security-module/87sei58vy3.fsf@microsoft.com

--=20
paul-moore.com

