Return-Path: <bpf+bounces-37005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDDC94FD97
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 08:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592C9284220
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 06:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3EF3A8CE;
	Tue, 13 Aug 2024 06:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mbo+FdGG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CCD381C7;
	Tue, 13 Aug 2024 06:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723529284; cv=none; b=GKlC99ybedyiqCnajzlIPhm9lRof+hYbv3zAkrk+vVnvPSJGAboHlWB9Uh+i+o6TfOssE1FFDs4EDU3//GkT9VO275s/7QXClQ+m9ibS2eDKKWh3SA727iimpSVeFnnO1uKDgIiVEf+l3AQ/EyMYNlLS+2YmHdvDuYDFsNffxLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723529284; c=relaxed/simple;
	bh=s+FbbMRkTK3j4lNO4+/UV6/0a8n/2EulU//uAt2lfWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqdtFEpN8QjChzxXL686jG+0y/95gL4sPbLTQ3Ey2mUv0Xp7qXWA70eRL/vlBeGhfpoYsrzRqHSUMmol3xMu6oUOI/qy3kYjGO/IH33xnbpyBTGvgvuFoL5uLoiVQuDRtgtHshdoXkXe3zzORQfARDaOrZZYSkZIfY73K5cBkJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mbo+FdGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE48C4AF11;
	Tue, 13 Aug 2024 06:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723529284;
	bh=s+FbbMRkTK3j4lNO4+/UV6/0a8n/2EulU//uAt2lfWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mbo+FdGG5O5PCt+6E06Cr5+ZIZ7njV+E12wNvjuPH2GWlGAB96oEJgIp8RQ7uzDDG
	 g4QLOOz4PPQrXV6vcZWcfg/BHFX+mqpxNvKJX7tqJm00BkiXfRzYwDP/JEMhBfOP/o
	 1VR2PyxQohfgy24pu8cASVX2L7wWERWJ7Ok9CKCQ=
Date: Tue, 13 Aug 2024 08:08:01 +0200
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
Message-ID: <2024081350-reconcile-rubble-6bb3@gregkh>
References: <20240807150039.247123516@linuxfoundation.org>
 <ZrPafx6KUuhZZsci@eldamar.lan>
 <2024081117-delusion-halved-9e9c@gregkh>
 <ZrjS0V-tCQ1tGkRu@eldamar.lan>
 <2024081143-grouped-blah-dd52@gregkh>
 <ZrpLLoQeag1Fe_3r@eldamar.lan>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrpLLoQeag1Fe_3r@eldamar.lan>

On Mon, Aug 12, 2024 at 07:49:34PM +0200, Salvatore Bonaccorso wrote:
> Hi Greg,
> 
> On Sun, Aug 11, 2024 at 05:40:58PM +0200, Greg Kroah-Hartman wrote:
> > On Sun, Aug 11, 2024 at 05:03:45PM +0200, Salvatore Bonaccorso wrote:
> > > Hi Greg,
> > > 
> > > On Sun, Aug 11, 2024 at 12:09:30PM +0200, Greg Kroah-Hartman wrote:
> > > > On Wed, Aug 07, 2024 at 10:35:11PM +0200, Salvatore Bonaccorso wrote:
> > > > > Hi Greg,
> > > > > 
> > > > > On Wed, Aug 07, 2024 at 04:59:39PM +0200, Greg Kroah-Hartman wrote:
> > > > > > This is the start of the stable review cycle for the 6.1.104 release.
> > > > > > There are 86 patches in this series, all will be posted as a response
> > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > let me know.
> > > > > > 
> > > > > > Responses should be made by Fri, 09 Aug 2024 15:00:24 +0000.
> > > > > > Anything received after that time might be too late.
> > > > > 
> > > > > 6.1.103 had the regression of bpftool not building, due to a missing
> > > > > backport:
> > > > > 
> > > > > https://lore.kernel.org/stable/v8lqgl$15bq$1@ciao.gmane.io/
> > > > > 
> > > > > The problem is that da5f8fd1f0d3 ("bpftool: Mount bpffs when pinmaps
> > > > > path not under the bpffs") was backported to 6.1.103 but there is no
> > > > > defintion of create_and_mount_bpffs_dir(). 
> > > > > 
> > > > > it was suggested to revert the commit completely.
> > > > 
> > > > Thanks for this, I'll fix it up after this release.
> > > 
> > > Thanks! Note today Quentin Monnet proposed another solution by
> > > cherry-picking two commits:
> > > 
> > > https://lore.kernel.org/stable/67bfcb8a-e00e-47b2-afe2-970a60e4a173@kernel.org/
> > 
> > They don't apply cleanly, so I'll just add a revert...
> 
> FYI: Just realized that the breaking commit was as well queued for
> older series 5.15.y, 5.10.y and 5.4.y, so that needs to be dropped
> from those queues as well.

Good catch, I'll go drop it now from them, thanks!

greg k-h

