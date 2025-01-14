Return-Path: <bpf+bounces-48859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02758A1130B
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 22:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE52016306E
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 21:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EE620F997;
	Tue, 14 Jan 2025 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7Np/olG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6071FECC8
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 21:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736890164; cv=none; b=VpI/gwR0qqfwhZNRgCIeHVdSPCIls4qHN6Pl5Zg0BqBSsU9j5juIN9tlvKEi+v5Z4iAMom2p1z/s6bPGTUmp8h1e5Kdy2SEwCx7NxSeNKB7yo5XSFERXI1Aoj+ui6rk5FWETxDj/kutqHiXKLhNFoe956AE21sDb4MK42QNiBno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736890164; c=relaxed/simple;
	bh=qSeKf/sw2lbVVQ/U/mm/YT4N5DMer1R313KgsTl2jv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I97q7elJ+1YtJxB5oglDqwS/5mZ0bUvU9pY2ZH0eY2XeM+EeDh9j9j3omPiMPYcmd5PKqpyqs6l0STLL9+I9IK0BLc9ZaEJsNI5prs1j09o8wVWIr4hMbTKOdPLtpWObzxlNYtNHCV9Vk1y5MOgMoCsfGE9hsjCqsFO7aVJnniI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7Np/olG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C33C4CEE3
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 21:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736890163;
	bh=qSeKf/sw2lbVVQ/U/mm/YT4N5DMer1R313KgsTl2jv8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h7Np/olGj9Ro5/4vR5KjpobnDYOz3lfzkG1Cq3xYlhxXtmQhpTYu4WadbmUl/fa4F
	 Gp23rDZ3G6Yn77SLYAmS4A15KtbV7bTN7q4yC5kv6l/FtXZgstAMaZnvYeNt+Wpav+
	 hubSsIbOKbFEHpbxVzS4eyO8jrbCw/9TVLY3qG3rNp/Tg7/QSSykhO76vas4SJHED9
	 0YAUNE3wQJoM8cjxwN6WM6LDESSyKxUjq7pUkBPJc4pl7T/EljvSztTXOMKtDoUidO
	 mRtm/98R/Ycihv0ixZjSwiM5a4Cc6siZMW0lrMfS6124Kkb1Z5/9g9yzlFAHrUUOJ/
	 h6xBz3rGYbFWw==
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a9d9c86920so15957055ab.2
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 13:29:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXITYZaWbP5ZS8koiMhOW4xnpwVRxI9FZ2Y6cjaKd2zFYJlzdyKswVBtoV1/FzKDduZU5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE6fF9ULkr15Z/nq78I/zPDSWVwWOdR42frkw5pgnVPK3Q8PhT
	nj1En4c0XPQWgoa8SGubWteBh/LT+wt0uQhferVS1e47tavmAXCcsd2PF6fygqIwxDaAIdL/sgG
	lLTXxEbVjU2gXayVUVFwre0p5lyI=
X-Google-Smtp-Source: AGHT+IHHG6FPQ8IDrvWZxi4YRM+qdsakyt8ABVE+a6wiTX5ytvrnMTuzNvQks+HqYH2wqUWSfJzW447UwhWZHCWUoio=
X-Received: by 2002:a92:c26d:0:b0:3a7:6566:1e8f with SMTP id
 e9e14a558f8ab-3ce3a8bb66emr180162635ab.16.1736890162921; Tue, 14 Jan 2025
 13:29:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <nahst74z46ov7ii3vmriyhk25zo6tkf2f3hsulzjzselvobbbu@pqn6wfdibwqb>
 <CAPhsuW5cLXSjQetTrcEFMAwnjjd1pGR3rLwVBuHkHMuK6xqwMA@mail.gmail.com> <az6mn2geqofoma4yzioyd5cvarb57mxatm2izupvq3bn4f5wbf@bv7au62xzv4l>
In-Reply-To: <az6mn2geqofoma4yzioyd5cvarb57mxatm2izupvq3bn4f5wbf@bv7au62xzv4l>
From: Song Liu <song@kernel.org>
Date: Tue, 14 Jan 2025 13:29:11 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6Dm0zLzaa+yx_cC2tWy8M-jv0=VpdZWY=oh=MVV+z1hw@mail.gmail.com>
X-Gm-Features: AbW1kvYsDgj8SC_4IR2owVgpxRv-k-Q_t5PVXXo6-YjYSlKC4keYvhGGTPzA29o
Message-ID: <CAPhsuW6Dm0zLzaa+yx_cC2tWy8M-jv0=VpdZWY=oh=MVV+z1hw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Modular BPF verifier
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Tue, Jan 14, 2025 at 1:02=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Hi Song,
>
> On Mon, Jan 13, 2025 at 03:32:59PM -0800, Song Liu wrote:
> > On Fri, Jan 10, 2025 at 1:23=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote=
:
[...]
> >
> > Maintaining out-of-tree kernel modules is a lot of work. I wonder wheth=
er
> > the benefit would justify this extra work. There are other ways to make
> > small changes to the built-in verifier, i.e. kernel live patch.
>
> The goal (in my mind) is not to maintain a full out-of-tree module.
> Rather, it'd be to do a 1-way sync out of the kernel and potentially
> apply some out-of-tree compatability patches. Same idea as libbpf:
> https://github.com/libbpf/libbpf.

The idea can be practical if we can support the verifier with the same
model as libbpf. But I am not sure whether this is possible.

> Verifier development should still happen in kernel tree. For folks who
> do not care about modular verifier, life should go on same as before.
>
> w.r.t. KLP, I'm not sure KLP satisfies the use case. For example, it
> seems unwieldy to potentially live-patch hundreds to thousands of
> patches. And since verifier is an algorithm heavy construct, we cannot
> get away from data structure changes -- IIUC something KLP is not good
> at.

It is correct that it is only practical to make small changes with KLPs. Bu=
t I
wonder how often we do need major changes to the verifier.

> >
> > >
> > > On top of delivering newer verifiers to older kernels, the facade ope=
ns the
> > > door to running the verifier in userspace. If the verifier becomes su=
fficiently
> > > portable, we can implement a userspace facade and plug the verifier i=
n. A
> > > possible use case could be integrating the verifier into Clang [3] fo=
r tightly
> > > integrated verifier feedback. This would address a long running pain =
point with
> > > BPF development. This is a lot easier said than done, so consider thi=
s highly
> > > speculative.
> >
> > I think we don't need the verifier to be a LKM to do verification in us=
er
> > space. Instead, we just need a mechanism to bypass (some logic of)
> > the verifier. Would this work?
>
> It's the other way around. The goal is not to _move_ verification into
> userspace but rather pre-verify. That way when the kernel verifies it
> you have a lot more confidence it will succeed.

I think we had the pre-verify idea for quite some time. It will be
valuable if we can manage it without much extra effort. (Development
happens in the kernel, etc.)

Thanks,
Song

