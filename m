Return-Path: <bpf+bounces-11533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B15C7BB495
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 11:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 420051C20A45
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 09:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A85514288;
	Fri,  6 Oct 2023 09:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AGTn51nc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7163134A1;
	Fri,  6 Oct 2023 09:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0376C433C7;
	Fri,  6 Oct 2023 09:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696586050;
	bh=1xkOaZgWTt8wM/d9FQ2QJPZz89Bgl30gT4xlvIoDSR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AGTn51ncWAoBhlIUu33RX+rKn2oQQgVhGVeCpcshlIqYB1rBwr5ngl/4+VJkeXiXf
	 kLgJhsj74qQC1qhpAf76lusF2fBpNk4UIcY/XSIpEPBPtZoivBL+jmB1fie62e241P
	 JD618flh3vleOkj5QJE5EyI04iXSTY/Q6PBdAe9o=
Date: Fri, 6 Oct 2023 11:54:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Hou Tao <houtao1@huawei.com>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, bpf <bpf@vger.kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Subject: Re: [PATCH 6.5 000/321] 6.5.6-rc1 review
Message-ID: <2023100643-unicycle-plenty-f4a3@gregkh>
References: <20231004175229.211487444@linuxfoundation.org>
 <CA+G9fYuE9Pu3QCVDywA8Ss-41jVfiy2e2kpxjhpTe3CRgmZkBw@mail.gmail.com>
 <CA+G9fYvHPnba-0=uGS70EjcPgHht13j3s-_fmd2=srL0xyPjNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvHPnba-0=uGS70EjcPgHht13j3s-_fmd2=srL0xyPjNg@mail.gmail.com>

On Thu, Oct 05, 2023 at 08:25:02PM +0530, Naresh Kamboju wrote:
> On Thu, 5 Oct 2023 at 11:05, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > On Wed, 4 Oct 2023 at 23:53, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 6.5.6 release.
> > > There are 321 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.6-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > The following kernel warning was noticed on qemu-armv7 while booting
> > with kselftest merge configs enabled build on stable-rc 6.5.6-rc1.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > > Hou Tao <houtao1@huawei.com>
> > >     bpf: Ensure unit_size is matched with slab cache object size
> >
> >
> > bpf: Ensure unit_size is matched with slab cache object size
> > [ Upstream commit c930472552022bd09aab3cd946ba3f243070d5c7 ]
> >
> > [    2.525383] ------------[ cut here ]------------
> > [    2.525743] WARNING: CPU: 0 PID: 1 at kernel/bpf/memalloc.c:385
> > bpf_mem_alloc_init+0x3b0/0x3b4
> > [    2.527241] bpf_mem_cache[0]: unexpected object size 128, expect 96
> 
> 
> Anders investigated this report and picked up the following patches to
> solve the reported problem.
> 
> d52b59315bf5e bpf: Adjust size_index according to the value of KMALLOC_MIN_SIZE
> b1d53958b6931 bpf: Don't prefill for unused bpf_mem_cache
> c930472552022 bpf: Ensure unit_size is matched with slab cache object size

Those do not all apply cleanly to the tree, so I've dropped the one
offending commit instead for 6.5.y and 6.1.y.

thanks,

greg k-h

