Return-Path: <bpf+bounces-36845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0E594E1F2
	for <lists+bpf@lfdr.de>; Sun, 11 Aug 2024 17:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DF991C20AD5
	for <lists+bpf@lfdr.de>; Sun, 11 Aug 2024 15:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC8014B948;
	Sun, 11 Aug 2024 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E4YPYUAg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CF522615;
	Sun, 11 Aug 2024 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723390864; cv=none; b=kfp13VoNDO6KqKPfpCHYGmJXu6X4vo+Y8jnMGvqGI/iG8udOOikUj+vbOQFRiRYNAyQSuOkZyPjWQErzjhFI3DnL8IAbBEzwPdVYXxTCz4NPh9ttMUL4/M1oVmSFnd+/IRZ3KsjU2c+XqybpvHFR63h1/47LcIBa/IrEewgFDqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723390864; c=relaxed/simple;
	bh=fA3nSkQj3+Amcf7/SmOiTUEfmHFc+E4ebSCfBjzYE2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3dmUFfe/6Ny/SxGgRruc4ZifiGnQ+6iClC55tvtZxVsC4qbS9tSQCudV+L9huNxtPDN1mE4dt0VjBpoE/AFKpH7AQJW2rG3X7RCb4wMDnPl0NJvQWoTAZr/tg4XzpGWAqmQbg6vDoB36CzHYU/EYxAjDJzcgR18qrh6qr1nX3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E4YPYUAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CB1C32786;
	Sun, 11 Aug 2024 15:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723390863;
	bh=fA3nSkQj3+Amcf7/SmOiTUEfmHFc+E4ebSCfBjzYE2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E4YPYUAgHYvTK4hXaONxDOHniF4k/U5+GW3TaWEGJXAsi2AXrqtdA9DT91wy50Ktx
	 G3E4j2Od+q/c/LrCXiEq3CaVKLq75DryL4rBUDZzO+sbOLUVKLjEQb6PuB6NOQeF0U
	 cebDIl93Oe1xTkPONvNgR8k6ReEZsl3Det66hsxM=
Date: Sun, 11 Aug 2024 17:40:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
	Akemi Yagi <toracat@elrepo.org>,
	Hardik Garg <hargar@linux.microsoft.com>,
	Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH 6.1 00/86] 6.1.104-rc1 review
Message-ID: <2024081143-grouped-blah-dd52@gregkh>
References: <20240807150039.247123516@linuxfoundation.org>
 <ZrPafx6KUuhZZsci@eldamar.lan>
 <2024081117-delusion-halved-9e9c@gregkh>
 <ZrjS0V-tCQ1tGkRu@eldamar.lan>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrjS0V-tCQ1tGkRu@eldamar.lan>

On Sun, Aug 11, 2024 at 05:03:45PM +0200, Salvatore Bonaccorso wrote:
> Hi Greg,
> 
> On Sun, Aug 11, 2024 at 12:09:30PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Aug 07, 2024 at 10:35:11PM +0200, Salvatore Bonaccorso wrote:
> > > Hi Greg,
> > > 
> > > On Wed, Aug 07, 2024 at 04:59:39PM +0200, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 6.1.104 release.
> > > > There are 86 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Fri, 09 Aug 2024 15:00:24 +0000.
> > > > Anything received after that time might be too late.
> > > 
> > > 6.1.103 had the regression of bpftool not building, due to a missing
> > > backport:
> > > 
> > > https://lore.kernel.org/stable/v8lqgl$15bq$1@ciao.gmane.io/
> > > 
> > > The problem is that da5f8fd1f0d3 ("bpftool: Mount bpffs when pinmaps
> > > path not under the bpffs") was backported to 6.1.103 but there is no
> > > defintion of create_and_mount_bpffs_dir(). 
> > > 
> > > it was suggested to revert the commit completely.
> > 
> > Thanks for this, I'll fix it up after this release.
> 
> Thanks! Note today Quentin Monnet proposed another solution by
> cherry-picking two commits:
> 
> https://lore.kernel.org/stable/67bfcb8a-e00e-47b2-afe2-970a60e4a173@kernel.org/

They don't apply cleanly, so I'll just add a revert...

thanks,

greg k-h

