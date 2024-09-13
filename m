Return-Path: <bpf+bounces-39803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2198497780A
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 06:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09CF1F25B18
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 04:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166141D45F2;
	Fri, 13 Sep 2024 04:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="p3NOxoaU"
X-Original-To: bpf@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96F36EB4C;
	Fri, 13 Sep 2024 04:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726202590; cv=none; b=nG3GUzznxrGzBsFqycZUil3uZiz/a0p6xixlxIV27dkVtLYKz5RxN3MHEErz1LgisutNE37gptNvdNIetkvz5XV9R+R4MkpwUwXs6PshNl7OacOF4BKQZsDIZHGUKfjg8SxK3zLKzItWVFaYP43xKEgqnJSP1xdq/aIMCs7AAd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726202590; c=relaxed/simple;
	bh=AKLPPYm+6jdHIvY02rA2E5qqXhodiMUtGAGgWGCccdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKiTsBr68cGaXF5I5bfFdU6jEHNNdfORdRkH8ApPWTey/5Do4eQFCrh0/W43Xzzj3iU4XKylcPtYKAi0gH1E9ND+uWraI+B7cfiaUfVRH6ZexjUv2kUUfd1qe6+B4/flUFehvwr8WSZ8hKJHhQZhkPB05meuWZI1GPBvH4KUHW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=p3NOxoaU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GB+MKzmDyvafMVZlwBfvwAyG60Rf5lxn8o4RMGC5ew8=; b=p3NOxoaUVL0Tm61H/SLdyESx8v
	ZHs48asoNOFanm5vv0ZSZ49qzWMQfbyuRLZxjHiuycwWkURaceybOQLhzhhG2lW9Mxk5iEYS+iO6z
	96REL79fUYOQ3guW4qaR+M0XAm+Y+udO6taziwWEqvdfh2VshDeBrh0opDPFbgGCJpsAQS+WRnTi6
	KJglhQXupoqkIqG/TFbSzX9Ztw9LBO+2NK1apqe7LqvY+f6P0LZKmVhqiuynm9cceMK3XRcuxffqR
	vOaqSb8BKNnkMTVO+b6KDkns1pSz9jCakhrx/tPSCe6YWOKBfUMbPr0K9pIvZiw0qVNTiURl+9gbj
	FmTqO63g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1soy9A-0000000Bt99-2A9A;
	Fri, 13 Sep 2024 04:43:04 +0000
Date: Fri, 13 Sep 2024 05:43:04 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	David Chinner <david@fromorbit.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20240913044304.GB2825852@ZenIV>
References: <20240913135551.4156251c@canb.auug.org.au>
 <20240913040038.GA2825852@ZenIV>
 <CAEf4BzashWCozzD7KetgC0Wya-KqUzj0omguAOt+oUVDzHys=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzashWCozzD7KetgC0Wya-KqUzj0omguAOt+oUVDzHys=Q@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Sep 12, 2024 at 09:26:31PM -0700, Andrii Nakryiko wrote:

> Should I take out the following from bpf-next/for-next for now?
> 
> a8e40fd0f127 ("Merge branch 'bpf-next/struct_fd' into for-next")
> 
> Al, currently I'm basing my patches on top of your stable-struct_fd
> branch. If you need to update it, I think that's fine, I can rebase on
> top of the updated branch, given my patches weren't yet merged
> anywhere. Let me know.

al@duke:~/linux/trees/temp$ git describe for-next 
v6.11-rc1-3-gde12c3391bce
al@duke:~/linux/trees/temp$ git describe stable-struct_fd 
v6.11-rc1-3-gde12c3391bce

IOW, #for-next is currently identical to that branch (will grow a merge
shortly); no need to rebase anything.

