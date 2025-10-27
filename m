Return-Path: <bpf+bounces-72361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 137A6C0FED2
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 19:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD893A425F
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 18:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7907B2D97B0;
	Mon, 27 Oct 2025 18:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFWtrsiH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE716236A73;
	Mon, 27 Oct 2025 18:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761589633; cv=none; b=uhSMG8IUVhgzsGnU6WEgF9pdKv7NV31PWFb99a4zdW+Pss1la4qYKYnHPRYFO5yHHMrglMdQfylESTa9yVdDocydE1Ips+32pOQBdP2L/D2axL00Zusw+qaWShtU7GEiRz1DhssFBdJ+Is1ecGWhG/X8++qgvShtiLjXEEwnsno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761589633; c=relaxed/simple;
	bh=giY2iJIh43yru3AntZowWLY3fxVorFh6FjnrC0IzCO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAyTABzV1bs5rbGCBuvJ8WUZoo+JMy9QY9miWIbOHm93d8dR0iGvvmPY8XkCTAig8loy5g7mJLkufqFcKxP9udF0IT+/g81dlsr8LNokL04CgQ1mnW8PWodK0/Eewuvt13fYXQ47u79uwFlcFYZrR/qkJMd7+VEf4slqOkt5+1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFWtrsiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2B9C4CEF1;
	Mon, 27 Oct 2025 18:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761589631;
	bh=giY2iJIh43yru3AntZowWLY3fxVorFh6FjnrC0IzCO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFWtrsiHFyOsLdmsgpS8c29DyUByFNpb24OHQmy9Ug5M5myVgJvB4ZFlXD7MR3/rw
	 utyGhBJfdgzsv4lVaUZESNx8hsyrK/QrduD9WucaIqJqlU4bXyXCHJFwzONOYFrWwv
	 9oY16YitC3OavOAK3nrZgJ6MDNryZBtj2CEWVksawl1+93S0nyHT9nOplbkfltRzIQ
	 81jMbrq274V5EIO1wM+G7Q2E+nxCOf01anF/ZOirBzhHW/9tnxs9q/gLanBVeyMWKT
	 FqbEe0F4+diuvMDu8D5l7+t98WPW0PKHLSc74OdYB+Xf2hhoi0nq6rsHlWqlaxxayv
	 iyGgOZKumKprQ==
Date: Mon, 27 Oct 2025 11:27:09 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [BUG] bpftool: Build failure due to opensslv.h
Message-ID: <aP-5fUaroYE5xSnw@google.com>
References: <aP7uq6eVieG8v_v4@google.com>
 <2cb226f8-a67c-4bdb-8c59-507c99a46bab@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2cb226f8-a67c-4bdb-8c59-507c99a46bab@kernel.org>

On Mon, Oct 27, 2025 at 11:41:01AM +0000, Quentin Monnet wrote:
> 2025-10-26 21:01 UTC-0700 ~ Namhyung Kim <namhyung@kernel.org>
> > Hello,
> > 
> > I'm seeing a build failure like below in Fedora 40 and others.  I'm not
> > sure if it's reported already but it failed to build perf tools due to
> > errors in the bootstrap bpftool.
> > 
> >     CC      /build/util/bpf_skel/.tmp/bootstrap/sign.o
> >   sign.c:16:10: fatal error: openssl/opensslv.h: No such file or directory
> >      16 | #include <openssl/opensslv.h>
> >         |          ^~~~~~~~~~~~~~~~~~~~
> >   compilation terminated.
> >   make[3]: *** [Makefile:256: /build/util/bpf_skel/.tmp/bootstrap/sign.o] Error 1
> >   make[3]: *** Waiting for unfinished jobs....
> >   make[2]: *** [Makefile.perf:1213: /build/util/bpf_skel/.tmp/bootstrap/bpftool] Error 2
> >   make[1]: *** [Makefile.perf:289: sub-make] Error 2
> >   make: *** [Makefile:76: all] Error 2
> > 
> > I think it's from the recent signing change.  I'm not familiar with
> > openssl but I guess there's a proper feature check for it.  Is this a
> > known issue?
> 
> 
> Hi Namhyung,

Hello!

> 
> This looks related to the program signing change indeed, commit
> 40863f4d6ef2 ("bpftool: Add support for signing BPF programs")
> introduced a dependency on OpenSSL's development headers for bpftool.
> It's not gated behind a feature check. On Fedora, I think the headers
> come with openssl-devel, do you have this package installed?

No I don't, but I guess it should be able to build on such systems.  Or
is it required for bpftool?  Anyway I feel like it should have a feature
check and appropriate error messages.

Thanks,
Namhyung


