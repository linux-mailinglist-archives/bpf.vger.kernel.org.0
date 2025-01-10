Return-Path: <bpf+bounces-48558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD322A092DD
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 15:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE43D3AA82F
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 14:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F152920FAA8;
	Fri, 10 Jan 2025 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1UgEq73O"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F9720E31A;
	Fri, 10 Jan 2025 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736517770; cv=none; b=tJUwmB059zBahWJPkrV6zXn/nzHDAhtK1LyafDLYjTgRzRc7crZ1j48aLkEXD8+14tGvTUwbll5S/pbH93JpqfF9Ez1/oQgS0kwhWjDjswYNJj4M7wrpwSnjQgW+5xCoE08QvmY61ej2ROsQ8pvM+M7a9OL+cueZvKcQFZqFoH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736517770; c=relaxed/simple;
	bh=PiHOuTmg4zVKpJegF6ABeMDuMTjgr4kkSmGq4TpISGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7ZTKsesnPf+87V/TP/y/MMeWc1alOv27L3K4NhjvhBQ4VWm3hPRI74n2MBE3qFIFlC9THWdAiMqJ0s5QFt/McsJFjGhcjW1ahxDrnmI5p1ABwxLlrw+Yk2D/ZQ9/ScWLas9TZs9bkMi0yCw9nY66+fZC3766l907Q1/uulPyRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1UgEq73O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F6AC4CED6;
	Fri, 10 Jan 2025 14:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736517770;
	bh=PiHOuTmg4zVKpJegF6ABeMDuMTjgr4kkSmGq4TpISGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1UgEq73O4FHpe2ME6QHxe7teMM6bDpyu8MXMdN9O8AaLkv60GwON/KHpjZUgYVvmR
	 Ry1Dhq+iyNhko0bi34d1pq+B+TjcxHfguJ0Ye49THfp7BuRgEtJt5K+Ap9BrbOlPnI
	 aeoCFckJv7amvcq7csX9bujUVnd56/4c9I2Y0wo8=
Date: Fri, 10 Jan 2025 15:02:46 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-modules@vger.kernel.org,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] sysfs: constify bin_attribute argument of
 sysfs_bin_attr_simple_read()
Message-ID: <2025011017-tubeless-hanky-0e99@gregkh>
References: <20241228-sysfs-const-bin_attr-simple-v2-0-7c6f3f1767a3@weissschuh.net>
 <CAADnVQ+E0z8mY4BF9qamPh1XV9qs2jZ03bfYz2tVw8E4nFVWBw@mail.gmail.com>
 <0cbfd352-ee3b-4670-afae-8e56d888e8c3@t-8ch.de>
 <CAADnVQJMV-zRcDKftZ-MbKEJQ7XGmPteMYCS0Bm5siBEXUK=Fw@mail.gmail.com>
 <2025010914-gangly-trodden-aa96@gregkh>
 <Z3-DcbY60SxoM0dN@infradead.org>
 <2025010930-resurrect-attest-94c9@gregkh>
 <Z3-HZT5kwt18QSQn@infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3-HZT5kwt18QSQn@infradead.org>

On Thu, Jan 09, 2025 at 12:23:01AM -0800, Christoph Hellwig wrote:
> On Thu, Jan 09, 2025 at 09:12:03AM +0100, Greg Kroah-Hartman wrote:
> > > Hey, when I duplicated the method to convert sysfs over to a proper
> > > seq_file based approach that avoids buffer overflows you basically
> > > came up with the same line that Alexei had here.
> > 
> > I did?  Sorry about that, I don't remember that.
> 
> It's been a while..
> 
> > As for seq_file for sysfs, is that for binary attributes only, or for
> > all?  I can't recall that at all.
> 
> Non-binary ones.

Ah, yeah, well the churn for "one single value" sysfs files would be
rough and seq_file doesn't really do much, if anything, for them as they
should be all simple strings that never overflow or are complex.

Yes, there are exceptions, so maybe for just them?  I don't want to make
it easier to abuse sysfs files, but if you feel it would really help
out, I'm willing to reconsider it.

thanks,

greg k-h


> 

