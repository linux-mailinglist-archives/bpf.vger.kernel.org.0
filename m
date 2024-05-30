Return-Path: <bpf+bounces-30948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAF38D4DBA
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 16:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3ED1F248AC
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 14:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0503176236;
	Thu, 30 May 2024 14:17:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2B21DA53
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717078630; cv=none; b=X8+nViYDQCtHdUwaaULmbyYnDfJfE5qrstVodsEz6MvzbDSyDc32Wt9kLqcru94mx8hlFEm08Qz/yoMe7pPOxcpHG6OOa+Sab0BiqLYt83xy5RSJXVB5k1LY2FWPOXA2H7NFMm81ZRaDI6oohoCP6us4G6y6lYa9ogbm7maiOh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717078630; c=relaxed/simple;
	bh=RVDNEhRQuKJ4hjJgFUO2EJUTFHrUxPH6KR4VhfykCvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMXVfGqzCrFvEyTC57lwgrs6ma8nQ2NAkXbIu2QifB0Va/Y4lXH9npB3tV2ZwPpRB7kb43c81CkIXmVrTHU/F3fV2b5HuEnq2bvEEkOH7u0kGrSr0kqBF9OU9hDVXPvVcao2CPWUGTTLzcBAYgeR/fLfVymS/mJju24Kp0WW8/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.net; spf=pass smtp.mailfrom=0pointer.net; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.net
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 2DCCCE801B0;
	Thu, 30 May 2024 16:17:04 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 4F715160185; Thu, 30 May 2024 16:17:03 +0200 (CEST)
Date: Thu, 30 May 2024 16:17:03 +0200
From: Lennart Poettering <mzxreary@0pointer.net>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: bpf kernel code leaks internal error codes to userspace
Message-ID: <ZliKX5EOU9eWhd2U@gardel-login>
References: <Zlb-ojvGgdGZRvR8@gardel-login>
 <Zlhupe1tXj8ZS1go@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zlhupe1tXj8ZS1go@krava>

On Do, 30.05.24 14:18, Jiri Olsa (olsajiri@gmail.com) wrote:

> > It seems that the bpf code in the kernel sometimes leaks
> > kernel-internal error codes, i.e. those from include/linux/errno.h
> > into userspace (as opposed to those from
> > include/uapi/asm-generic/errno.h which are public userspace facing
> > API).
> >
> > According to the comments from that internal header file: "These
> > should never be seen by user programs."
> >
> > Specifically, this is about ENOTSUPP, which userspace simply cannot
> > handle, there's no error 524 defined in glibc or anywhere else.
> >
> > We ran into this in systemd recently:
> >
> > https://github.com/systemd/systemd/issues/32170#issuecomment-2076928761
> >
> > (a google search reveals others were hit by this too)
> >
> > We commited a work-around for this for now:
> >
> > https://github.com/systemd/systemd/pull/33067
> >
> > But it really sucks to work around this in userspace, this is a kernel
> > internal definition after all, conflicting with userspace (where
> > ENOTSUPP is just an alias for EOPNOTSUPP), hence not really fixable.
> >
> > ENOSUPP is kinda useless anyway, since EOPNOTSUPP is pretty much
> > equally expressive, and something userspace can actually handle.
> >
> > Various kernel subsystems have been fixed over the years in similar
> > situations. For example:
> >
> > https://patchwork.kernel.org/project/linux-wireless/patch/20231211085121.3841b71c867d.Idf2ad01d9dfe8d6d6c352bf02deb06e49701ad1d@changeid/
> >
> > or
> >
> > https://patchwork.kernel.org/project/linux-media/patch/af5b2e8ac6695383111328267a689bcf1c0ecdb1.1702369869.git.sean@mess.org/
> >
> > or
> >
> > https://patchwork.ozlabs.org/project/linux-mtd/patch/20231129064311.272422-1-acelan.kao@canonical.com/
> >
> > I think BPF should really fix that, too.
>
> hm, I don't think we can change that, user space already depends
> on those values and we'd break it with new value

Are you sure about that? To be able to handle this situation that
userspace program whose existance you are indicating would have had to
go the extra mile to literally handle error code 524 that is not known
to userspace otherwise and handle it. If somebody goes the extra mile
to do that, what makes you think that they didn't just handle it as
equivalent to regular EOPNOSTUPP? In systemd at least that's what we
are doing.

Also: if various other subsystems (I linked examples from wireless,
media, mtd above) just fixed this, why not bpf, why is it special in
this regard?

AFAICS the man pages of most syscalls just list errnos that *can* be
returned, but usually doesn't list the precise conditions or makes
guarantees about it. This specific error is not listed at all on any
man page for the bpf() syscall, hence are you really sure this is
actually as set in stone as you think it is?

I mean, bpf() is still a bit of bleeding edge tech, and people playing
around with this probably tend to have quite new toolchains even, not
old, hard to fix code?

> it's unfortunate, but I don't think we can do much about that,
> other than enforcing EOPNOTSUPP for new code

I took the liberty to CC Linus on this:

Linus, what's the policy if some subsystem by mistake is leaking
internal kernel error codes (such as ENOTSUP) to userspace? Leave it
be as is (i.e. error number not defined in include/uapi/, not
documented, but still returned), or fix it to the closest matching
public error code (which is probably EOPNOTSUPP in this case)
accepting a – mild, I would say – compat break?

[BTW, wouldn't it make sense to add a BUG_ON or so on syscalls that
return an error number > 133 or so? This kind of issue is quite a
recurring theme, see the patches above, and such a BUG_ON would
probably catch 95% of all cases like this.]

Lennart

