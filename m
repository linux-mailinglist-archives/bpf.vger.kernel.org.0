Return-Path: <bpf+bounces-69910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F79EBA64B9
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 01:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9043B7782
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 23:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B68623C4E0;
	Sat, 27 Sep 2025 23:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWOSGOaE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26F91C860C;
	Sat, 27 Sep 2025 23:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759014255; cv=none; b=mbsoVOLVq5FNDnuz0yegR8ccY5Z9jAyfKBxrZA7eDN0PXSeQ0KqNFNXqB0e7x215HSQlYJ4EU09H+ZD8WQJb8mAOy05QeUxjdYGR6fFtNCIGUIkD5RniPHy1kvPtxqlt0zR0GXno4SW5ws/jkIwjYfGDZSQNY9rWDm1oe4g8vYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759014255; c=relaxed/simple;
	bh=/ZC+X78Z59++cOjQ82yYqXuSRcY2nJRhaz1c6fgEAbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txgWqnbsbNnrq9bFBNc1lAbP58MsfM5kv7ogw4uw5GOYKYBINicUE42hhX4tHBVV1VE/vLK/XwjaPw3M4d7gwvDKLDDc4cDFkyf50ssq+ZyXigjGAWAaW1kOCVHn6cAElqSlhi0ylnMPrNXWFDXMmsPMursi+s29escroSXclwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWOSGOaE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C241C4CEE7;
	Sat, 27 Sep 2025 23:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759014255;
	bh=/ZC+X78Z59++cOjQ82yYqXuSRcY2nJRhaz1c6fgEAbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IWOSGOaE1/GVIj4OCPSOe5rpgKSsO04bL0jS62GaAQ/AyHY2ERj67WLVdW3Y7UL/j
	 +BAFYwCvgzp2fwsCVAXjEf6QjF/OgmHNC+k19s8TUbmIuO9znSJC8S1QiiOSCsEFGj
	 h6am2DdZg0EnTLjEyrRoXBbUeA0FHGeK74B19bZyCQ7KcY3hv2m6lzbVrBva7mV/4m
	 mCj5UxkMJN2Jm7O/i/j1xU1WxhChp8ekzFKTm4xMgR8uWYEpfj5rsk0eWp3jCM098R
	 vydxX6uHe3fbP7OLNyh9yduqclEAdfCsUB2KN/NXZlPlszvBDs3w7BIdO9OzDVnAET
	 yg1Hua12Zpvcg==
Date: Sat, 27 Sep 2025 16:04:12 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
	LSM List <linux-security-module@vger.kernel.org>,
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Paul Moore <paul@paul-moore.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v5 03/12] libbpf: Implement SHA256 internal helper
Message-ID: <20250927230412.GF9798@quark>
References: <20250921133133.82062-1-kpsingh@kernel.org>
 <20250921133133.82062-4-kpsingh@kernel.org>
 <20250927210345.GE9798@quark>
 <CAADnVQ+t6JJ9YgH_xgicbzvvP2WvEJWxi+hioQtFKrR6BLTsCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+t6JJ9YgH_xgicbzvvP2WvEJWxi+hioQtFKrR6BLTsCg@mail.gmail.com>

On Sat, Sep 27, 2025 at 11:33:12PM +0100, Alexei Starovoitov wrote:
> On Sat, Sep 27, 2025 at 10:03 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Sun, Sep 21, 2025 at 03:31:24PM +0200, KP Singh wrote:
> > > Use AF_ALG sockets to not have libbpf depend on OpenSSL. The helper is
> > > used for the loader generation code to embed the metadata hash in the
> > > loader program and also by the bpf_map__make_exclusive API to calculate
> > > the hash of the program the map is exclusive to.
> > >
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> >
> > Nacked-by: Eric Biggers <ebiggers@kernel.org>
> >
> > No more users of AF_ALG, please.  It's a huge mistake and has been
> > incredibly problematic over the years.
> 
> Lol. True, but good luck with that. AF_ALG is uapi and it will be removed
> only when the last user retires many years from now.

Many Linux systems never enabled AF_ALG in the first place, and those
that have it enabled often only have a few users of it or even none at
all.  Sure, AF_ALG support will remain in-tree for a very long time or
even forever.  But many systems can keep it disabled, or can disable it,
if new users are not introduced and existing users continue to be fixed.

Let's do the right thing here, instead of making the situation even
worse and also adding undocumented kconfig dependencies to libbpf.

> > If you don't want to depend on a library, then just include some basic
> > SHA-256 code, similar to what I'm doing for iproute2 and SHA-1 at
> > https://lore.kernel.org/netdev/20250925225322.13013-1-ebiggers@kernel.org/.
> > I'd even be glad to write the patch for you, if you want.
> 
> Yes. Please. If you can craft sha256 without external dependencies
> we can certainly use it.
> Certainly agree that it would be better than AF_ALG.

Sure, I'll do that.

- Eric

