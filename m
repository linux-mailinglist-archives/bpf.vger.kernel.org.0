Return-Path: <bpf+bounces-60330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9686FAD5932
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 16:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA7B3A207E
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 14:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42F817B506;
	Wed, 11 Jun 2025 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fD4Glr51"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB60284682
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653131; cv=none; b=mEbqT3VbK/kQXbFDpim7CdPPPm71L00E3im6d1F8y5xNFN1HiePEOY2KdhxRqE9WX7Ci+O7PZnFgzxSkfajBxmIhyd46XYndbcL+E31Wdatgavz6Y0oSSapxXSk14L5YW6nHGHBRck769XNnmlBxtv+YMkfRpCdmVZNRnmjTfts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653131; c=relaxed/simple;
	bh=5VHxGroRuRm391u8BhsTPRQW9M6NX9bcClfVhDzNO0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b63Skn/+e6GvzFao9KxCqpKcGDzclsknYJG22tW7NL4rmrC3s+aj/12uVTIOSASC/GfQaoq7ouE31mKQOrBukDZ6Alo5DRXRXc+Kt/C8YWq7eGG5FAo35zbn5+3VI2iSRvLo69YhzyTOOxrJwctDtlFIVBK08q1UGMu2ysosKkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fD4Glr51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56D0C4CEF5
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 14:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749653130;
	bh=5VHxGroRuRm391u8BhsTPRQW9M6NX9bcClfVhDzNO0o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fD4Glr51h5qqjPwEf3dAnKCfaXM+acDehidO80eu3ckGvpgI89jJGlTRtaukmVQQ3
	 O5Qdzg1g0Yt17BsewFJUBmVwUp3Xj7iF8cmg1WFu7LH1yL/BTREH5OkHvqdkIWwhnG
	 cY4f7C1e5EENkmZsW2c+f5LDaTs6L4jTSTxjHj0eRHW7L/H3P2dLKhJodhTVP8JfeX
	 vI/5a52jktLrYWx38K0l3aE/0orl3kqK9Oa+jL0lWn0rJtHHqeN6/yd45MfnTwUY2c
	 bKWQBSiBCPHy3x0It8o8T1bhx7+5pY+o4hu4jDs0jK1ne+hKYgGHMm5zCPWtCy1wtS
	 HuwwYvwL2nRag==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-addda47ebeaso1295645766b.1
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 07:45:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/BOMR3p8A4xApKZgJ5QaaB0Qw5W1+M2rA7a83I5vLPxovmLNbEPbPs6uE+YKHhL3aydc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4eSBa+qIcS2ieZjz4HZ1U3ix/sPOEh3mW5P7z9nr+JTqf3Dhs
	wWL1WSWu9LvduNTFyKMDXWFkMOMgO0qt21nkVunod7zaiTftDctdsZQunrySPddH2Gb3vrj71L8
	CHxemWWm2jqXI6bgQfY83B3D+189x5yfSLiQw225y
X-Google-Smtp-Source: AGHT+IHH/RSWeCFyljxeeflZttHDDEwTP1h0nixjCalFERKbyAewsp04ybkVezs+u8zp1KcHf+CP1jhu9ruOLvPl4xI=
X-Received: by 2002:a17:907:c0c:b0:ad8:9466:3344 with SMTP id
 a640c23a62f3a-ade8c8993d1mr293077066b.43.1749653129219; Wed, 11 Jun 2025
 07:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-11-kpsingh@kernel.org>
 <87qzzrleuw.fsf@microsoft.com> <CACYkzJ6M7kA7Se4=AXWNVF1UyeHK3t+3Y_8Ap1L9pkUTbqys9Q@mail.gmail.com>
 <87o6uvlaxs.fsf@microsoft.com> <CACYkzJ74MJkwejki7kFNR4RWh+EnJ++0Vop8eRkSwY6pJepMEQ@mail.gmail.com>
 <8cf2c1cc15e0c5e4b87a91a2cb42e04f38ac1094.camel@HansenPartnership.com>
 <CACYkzJ6yNjFOTzC04uOuCmFn=+51_ie2tB9_x-u2xbcO=yobTw@mail.gmail.com>
 <6f8e0d217d02dc8327a2a21e8787d3aec9693c2c.camel@HansenPartnership.com>
 <CACYkzJ4T5ZFuY5PDKp1VZmsdEyEYUbbajAbhqr+5FE6tqy195A@mail.gmail.com>
 <fa526e6ed52e2c5f72aeb24fa24f3731bac6f74d.camel@HansenPartnership.com>
 <CACYkzJ4JYDXEkYpN=XBn4bOmv6Fg7bSgV-YAKHfEL2NxJiMh0A@mail.gmail.com> <3088dc5f59ab3bc8b0ed2a9a2800589bc1435b66.camel@HansenPartnership.com>
In-Reply-To: <3088dc5f59ab3bc8b0ed2a9a2800589bc1435b66.camel@HansenPartnership.com>
From: KP Singh <kpsingh@kernel.org>
Date: Wed, 11 Jun 2025 16:45:17 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5GXqdcFx0za0aWpezLj5n5x61fuug5T+5dXmd2f9BEKw@mail.gmail.com>
X-Gm-Features: AX0GCFvo9EmlotBLU0VnmVvLfMVn7bQL-6F7VlvAdC8fXT56SAbCueNIbzxr24o
Message-ID: <CACYkzJ5GXqdcFx0za0aWpezLj5n5x61fuug5T+5dXmd2f9BEKw@mail.gmail.com>
Subject: Re: [PATCH 10/12] libbpf: Embed and verify the metadata hash in the loader
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 4:43=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Wed, 2025-06-11 at 15:41 +0200, KP Singh wrote:
> > On Wed, Jun 11, 2025 at 3:18=E2=80=AFPM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > On Wed, 2025-06-11 at 14:33 +0200, KP Singh wrote:
> > > > [...]
> > > > I have read and understood the code, there is no technical
> > > > misalignment.
> > > >
> > > > I am talking about a trusted user space loader. You seem to
> > > > confuse the trusted BPF loader program as userspace, no this is
> > > > not userspace, it runs in the kernel context.
> > >
> > > So your criticism isn't that it doesn't cover your use case from
> > > the signature point of view but that it didn't include a loader for
> > > it?
> > >
> > > The linked patch was a sketch of how to verify signatures not a
> > > full
> >
> > It was a non functional sketch that did not address much of the
> > feedback that was given, that's not how collaboration works.
>
> It was somewhat functional for the security use case but could be
> extended for yours and provably allowed both was the point of the
> sketch.  The feedback it addressed was your desire for a signed trusted
> loader.
>
> > > implementation.  The pieces like what the loader looks like and
> > > which keyring gets used are implementation details which can be
> > > filled in later by combining the patch series with review and
> > > discussion.  It's not a requirement that one person codes
> > > everyone's use case before they get theirs in, it's usually a
> > > collaborative effort ... I mean, why
> >
> > Yeah, it's surely a collaborative effort, but the collaboration has
> > been aggressive and tied to a specific implementation (at least from
> > some folks). Rather than working with the feedback received it has
> > been accusational of mandating and forcing.
>
> I don't see how that squares with producing a sketch that supports your
> use case ... clearly feedback has been incorporated.
>
> >  If the intent is to really collaborate, let's land this base
> > implementation and discuss further. I am not willing to add
> > additional stuff into this base implementation.
>
> Just so I'm clear: your definition of collaboration means Blaise takes
> feedback from you at all times but you don't take it from him until
> you've got your use case upstream?  This might be OK if the two use
> cases were thousands of lines apart, but, as I've said before, it seems
> to be less than a hundred lines which doesn't seem to be a huge
> integration burden given the size of the patch set you're trying to
> land.  I'm sure Blaise would be willing to produce the patch set that
> adds the incremental over what you've published here to demonstrate its
> smallness.
>
> > > would you want Microsoft coding up the loader?  If they don't have
> > > a use case for it they don't have much incentive to test it
> > > thoroughly whereas you do.
> >
> > It seems that your incentives are purely aligned with Microsoft and
> > not that of the BPF community at large (this is also visible from the
> > patches and the engagement).
>
> No, as has been stated many times before there are other companies than
> Microsoft who want supply chain integrity for BPF code which the data
> block hash chaining you proposed but didn't implement does perfectly.
> I shouldn't have to remind people that open source is about scratching
> your own itch and thus you can determine a company's investments in
> open source by its goals.   I've even given a few talks about this:
>
> https://archive.fosdem.org/2020/schedule/event/selfish_contributor/
>
> As a Linux community we're usually good at creaming off additional
> things around the edges,  such as integrating the two approaches, which
> I'm sure Microsoft will be happy to invest Blaise's time on, but I'm
> equally sure they won't invest huge amounts in testing the trusted
> loader until they have a use case for it.
>
> >  FWIW, There is no urgency for my employer to have signed BPF
> > programs, yet I am working on this purely to help you and the
> > community.
>
> From what I heard Google is using signed BPF internally but has no
> urgency to get it upstream.  However, in my experience Google always

This is incorrect.

> has a lack of upstream urgency until they run into a backporting
> problem, so I'm sure they'll give you credit for avoiding potential

Also not correct, please stop assuming things.

> future backport issues.



>
> Regards,
>
> James
>

