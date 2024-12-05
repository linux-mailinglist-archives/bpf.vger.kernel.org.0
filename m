Return-Path: <bpf+bounces-46143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8209E521F
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 11:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F1B1664F3
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 10:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C041F03E6;
	Thu,  5 Dec 2024 10:23:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982551DF971;
	Thu,  5 Dec 2024 10:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394201; cv=none; b=JtphxhoDOPJj4f8rUYZgo34NPTpwCVDqF/1Z3flg33VHz7COngazjn545rxBaRr3PtovTnYSixntIs7qDamgwXIdUQxjE/7RDJmRTjMVUUJRXwfMhl4WZVr/yv2soP7g+PDV2S4L2/ol/AsgBiEuYFJu6EFUYqzjUi4kjpwhE14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394201; c=relaxed/simple;
	bh=0XpPuK5VtPAblHD4SHKTto1uJ3DNZ6f5fRxYExWotbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USSFG0xboOwSPFHoPkhE3ay5vHH3tMVlrlkXiLoEsu0lhJWSA9OI8lm5vDvrD8m3ToJ4PTmsHcCn+bQCDU4wZobyooq26ulqTEKX3VmbMIACmXYRl+fEmvi88HVfnRd9r0sKW3ze4Wl+lOtS0vIC+dLIf1siR7A2o9ub8nEoSwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11BB7FEC;
	Thu,  5 Dec 2024 02:23:41 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93A703F5A1;
	Thu,  5 Dec 2024 02:23:12 -0800 (PST)
Date: Thu, 5 Dec 2024 10:23:10 +0000
From: Leo Yan <leo.yan@arm.com>
To: Quentin Monnet <qmo@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Nick Terrell <terrelln@fb.com>, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: Re: [PATCH] bpftool: Fix failure with static linkage
Message-ID: <20241205102310.GA2899345@e132581.arm.com>
References: <20241204213059.2792453-1-leo.yan@arm.com>
 <Z1DLYCha0-o1RWkF@google.com>
 <bf5da4d3-c317-4616-ac68-0d49bb5815c2@kernel.org>
 <Z1DW1aJ4rYlMI6S1@google.com>
 <d4d5e80d-1a95-4ef7-a83f-1303563a91eb@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4d5e80d-1a95-4ef7-a83f-1303563a91eb@kernel.org>

On Wed, Dec 04, 2024 at 10:55:32PM +0000, Quentin Monnet wrote:

[...]

> >>> I was about to report exactly the same. :)
> >>
> >> Thank you both. This has been reported before [0] but I didn't find the
> >> time to look into a proper fix.
> >>
> >> The tricky part is that static linkage works well without libzstd for
> >> older versions of elfutils [1], but newer versions now require this
> >> library. Which means that we don't want to link against libzstd
> >> unconditionally, or users trying to build bpftool may have to install
> >> unnecessary dependencies. Instead we should add a new probe under
> >> tools/build/feature (Note that we already have several combinations in
> >> there, libbfd, libbfd-liberty, libbfd-liberty-z, and I'm not sure what's
> >> the best approach in terms of new combinations).
> >
> > I think you can use pkg-config if available.
> >
> >   $ pkg-config --static --libs libelf
> >   -lelf -lz -lzstd -pthread
> 
> That's another dependency that I'd like to avoid if I can :)

Seems to me, pkg-config is the right tool for doing such kind thing -
not only it is nature for local building, it is also friendly for build
system (e.g. buildroot, OpenEmbedded / Yocto).  Though I have no deep
knowledge for building.

I am a bit confused why this issue is related to build features libbfd,
libbfd-liberty, libbfd-liberty-z.  Should not the issue is related to
libelf?  build/feature has several libelf checking, maybe we can add new
one libelf-zstd?

Thanks,
Leo

