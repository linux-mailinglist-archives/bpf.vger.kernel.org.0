Return-Path: <bpf+bounces-31897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5769047C5
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 01:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 617F8B22BE7
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 23:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739CE15622F;
	Tue, 11 Jun 2024 23:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="3P70Gy2S"
X-Original-To: bpf@vger.kernel.org
Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7254C3BB23;
	Tue, 11 Jun 2024 23:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718149622; cv=none; b=e0aVGlhsKDkG54M1ubn01hbYWigKqgt4bNiDqXYIh3GJWKMZC9Oq8lZF359XWefD/67L8Aa9k6mS5raplwFAYuIKQzXaIq8GmmWs/Xw5GxYJNnYGun1KPWmBCSu8Yudl0WR0VdEXvh0Vx6toyyddIsQZmG09Dvff09x97rQRydY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718149622; c=relaxed/simple;
	bh=aUwkgEHOy951h6OL8kXUngxLiEvTLbmvkD1a/Aad0Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7Nj4Z3vMDq7O1/seOc/BY6h2IEeK6Wgzf3Kr+pODQaOM7hNgWMq350GZk0rsOjTDG0nDYWcZ8q0B1rT7RxrYmEJxlEUOQIGtID2MRklnkmK680Lfp9IyEog8lBMGxHUlJ9m2EIAjPJMJDak/jty8a3NeJUjrcFMIjqLXzR5J4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=3P70Gy2S; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 4B9D914C1E1;
	Wed, 12 Jun 2024 01:46:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1718149616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E6gNsA/8fiPpd6nvUGnUpv1xGX9xlafW0dSbHI3zDI0=;
	b=3P70Gy2Sl2X6HhyjJYOZWl6BJm2hir0fH9jruyOHppQC8noAiraVU1ujofjQpuycTmrhtr
	TXsW430S/kxRaPCmiAGXHRaWz+xK9v7Fgh431jMU7soyXcwu2be7fIwr2GgtIEjm3NsORF
	Jee4hOqsdMkmmsB8rLeJn40FpPIk67EX9ySai89RCkcSxMCF+x89wYRo/PPP1dURthQt0Y
	1E0ibyrFVyU6qNFqOMwy12oxsrLTxA5eAXM738AspBeoc4qDpTJx6/1NIzdh/NekhTRiq5
	BAvf269yJ5V1ma+zj+3b8o6Kq82v/C/KYKYeXJPqG46biU1tk6M+US6PL4mwJQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id de3dff79;
	Tue, 11 Jun 2024 23:46:47 +0000 (UTC)
Date: Wed, 12 Jun 2024 08:46:32 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>, Jan Engelhardt <jengelh@inai.de>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Viktor Malik <vmalik@redhat.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jan Alexander Steffens <heftig@archlinux.org>,
	Domenico Andreoli <cavok@debian.org>,
	Dominique Leuenberger <dimstar@opensuse.org>,
	Daniel Xu <dxu@dxuuu.xyz>, Yonghong Song <yonghong.song@linux.dev>
Subject: Re: ANNOUNCE: pahole v1.27 (reproducible builds, BTF kfuncs)
Message-ID: <Zmjh2GER_MBB_dgT@codewreck.org>
References: <ZmjBHWw-Q5hKBiwA@x1>
 <ZmjDuv_zuhA3Xp2m@codewreck.org>
 <ZmjVHKLTP4_hnzug@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZmjVHKLTP4_hnzug@x1>

Arnaldo Carvalho de Melo wrote on Tue, Jun 11, 2024 at 07:52:12PM -0300:
> On Wed, Jun 12, 2024 at 06:38:02AM +0900, Dominique Martinet wrote:
> > It looks like the v1.27 tag has not been pushed to the git repos (either
> > this or github), we're using git snapshots for nixpkgs, so it'd be great
> > if a tag could be pushed out.
> 
> Done.
> 
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tag/?h=v1.27
> https://github.com/acmel/dwarves/releases/tag/v1.27

Thank you!

> > (I think some release monitoring tools left and right also use tags,
> > even if that's less important if you Cc other distro maintainers... I
> > just happened to see the mail on bpf@vger.)
> 
> May I add your e-mail here:
> 
> acme@x1:~/git/pahole$ cat PKG-MAINTAINERS 
[..]
> 
> So that on the next release I CC you?

Sure; in practice this shouldn't change much as package update is
semi-automated within a few days, but getting a heads up cannot hurt.

-- 
Dominique Martinet | Asmadeus

