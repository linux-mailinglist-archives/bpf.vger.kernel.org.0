Return-Path: <bpf+bounces-58587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E354EABDFF2
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 18:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0EC3A4BCC
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 16:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF47526A09A;
	Tue, 20 May 2025 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pdgs6/FI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38238241696;
	Tue, 20 May 2025 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757174; cv=none; b=DXbwuC5tyRuvSHpUwkG5o9dp1bc37cVg9B0TnjMR0ZfbK9ghtNriPWfWl3fjI45w/AApFM5UpVFw/JjzoEKdCQk3r+KbzuA8ry1HLNqS7bU9K4zJMRwkK7pHkGBd1OOpG50R3kUYoFUuvtRVDk5HjqWJifRIbBOdUiOevCifSQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757174; c=relaxed/simple;
	bh=LwPbqoIXOVyP2aQDPKPm6hmyDnm8quZTF2z+BUwu33w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPRcya/+75xXSZ8ZfgCOCw4CRonc92Jei31jpXQyEJCBXRVqxwkz16HcksjRw8mFmSiDmcahJtaaHacVvUuSxfb7WZ2MRTBfJRD1hoIq2HTFIUzn7DxX5CCCMp05f2olkH25EHmkEnyuv2SfoG9F0ttlzGJf/vfNs5+pLTqQw0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pdgs6/FI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C252C4CEE9;
	Tue, 20 May 2025 16:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747757173;
	bh=LwPbqoIXOVyP2aQDPKPm6hmyDnm8quZTF2z+BUwu33w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pdgs6/FIlZFOYSnMfFOajMq74ngEqAh6X37JSbg+2aZQuFBKu1sbR5fhBqs/913t3
	 AwGvai69zatfsOl/9eQ4Vz2u3B/rE3eHDhLDIkZbBEcZSy3w+NlqMIU6cMdSYyoRxu
	 C+NaBH4GcohDC1pIQv3AIHLU/jY4wN9r0D4UN2+kwkJ/Dhhhy3Cng1L0Gh4wXSyxZl
	 Zo0mtMiVhfaJV37T9GlA7XRetK+vukjVPBX83GusCB/+VdqK1CZ0CwvhOv3Q+UFrXw
	 7JdN0j73CAHmOxvqI4WF/p7wy0G0g1AO4Spma/GUAhoEniv8F8RLqPbBGewkyoC88Q
	 PKi8HawOmrwNg==
Date: Tue, 20 May 2025 09:06:10 -0700
From: Kees Cook <kees@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Erhard Furtner <erhard_f@mailbox.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/2] mm: vmalloc: Actually use the in-place vrealloc
 region
Message-ID: <202505200904.474938A8B5@keescook>
References: <20250515214020.work.519-kees@kernel.org>
 <202505191217.B047E005F2@keescook>
 <20250519170607.b8d9c23bb928935d19b333fa@linux-foundation.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519170607.b8d9c23bb928935d19b333fa@linux-foundation.org>

On Mon, May 19, 2025 at 05:06:07PM -0700, Andrew Morton wrote:
> On Mon, 19 May 2025 12:18:42 -0700 Kees Cook <kees@kernel.org> wrote:
> 
> > On Thu, May 15, 2025 at 02:42:14PM -0700, Kees Cook wrote:
> > > This fixes a performance regression[1] with vrealloc(). This needs to
> > > get into v6.15, which is where the regression originates, and then it'll
> > > get backport to the -stable releases as well.
> 
> No -stable backporting will be needed?

I think it will, since the vrealloc patches were backported
automatically, e.g. in v6.14.y: 0b391a520b4e ("mm: vmalloc: support more
granular vrealloc() sizing")

> > Andrew, can you get these to Linus this week?
> 
> Sure.

Thanks!

-- 
Kees Cook

