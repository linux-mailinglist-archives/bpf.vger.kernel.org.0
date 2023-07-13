Return-Path: <bpf+bounces-4964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 175A975271C
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 17:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FDBF1C2112B
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 15:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315161ED5A;
	Thu, 13 Jul 2023 15:31:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63CA1ED43;
	Thu, 13 Jul 2023 15:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B949C433C7;
	Thu, 13 Jul 2023 15:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1689262270;
	bh=FiMNv6GuPmzcqm62REpDacT876SMRfV/Kt+uQ7F3tVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C/Qp+v/Kka9UlJlhXuT05kVORdlkTpXGhuc2SgtNo1uyVihbxO0rG/heUajAg8Cim
	 IpgvK1XtFYGBLiayPuojvjanlcxKHi6WpwJCqY5ykqqDaxspRzgwP9UZUmfigZ6Y1a
	 fyR8b5ck51BKpWQbFt/b55IQKDw7khg1eQ/P9CyA=
Date: Thu, 13 Jul 2023 17:31:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"saeed@kernel.org" <saeed@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	brouer@redhat.com, "maxtram95@gmail.com" <maxtram95@gmail.com>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>,
	"kheib@redhat.com" <kheib@redhat.com>,
	"ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
	"mkabat@redhat.com" <mkabat@redhat.com>,
	"atzin@redhat.com" <atzin@redhat.com>,
	"fmaurer@redhat.com" <fmaurer@redhat.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"jbenc@redhat.com" <jbenc@redhat.com>,
	"linyunsheng@huawei.com" <linyunsheng@huawei.com>,
	"ttoukan.linux@gmail.com" <ttoukan.linux@gmail.com>
Subject: Re: mlx5 XDP redirect leaking memory on kernel 6.3
Message-ID: <2023071357-unscrew-customary-fbae@gregkh>
References: <d862a131-5e31-bd26-84f7-fd8764ca9d48@redhat.com>
 <00ca7beb7fe054a3ba1a36c61c1e3b1314369f11.camel@nvidia.com>
 <6d47e22e-f128-ec8f-bbdc-c030483a8783@redhat.com>
 <cc918a244723bffe17f528fc1b9a82c0808a22be.camel@nvidia.com>
 <324a5a08-3053-6ab6-d47e-7413d9f2f443@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <324a5a08-3053-6ab6-d47e-7413d9f2f443@redhat.com>

On Thu, Jul 13, 2023 at 04:58:04PM +0200, Jesper Dangaard Brouer wrote:
> 
> 
> On 13/07/2023 12.11, Dragos Tatulea wrote:
> > Gi Jesper,
> > On Thu, 2023-07-13 at 11:20 +0200, Jesper Dangaard Brouer wrote:
> > > Hi Dragos,
> > > 
> > > Below you promised to work on a fix for XDP redirect memory leak...
> > > What is the status?
> > > 
> > The fix got merged into net a week ago:
> > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/drivers/net/ethernet/mellanox/mlx5/core?id=7abd955a58fb0fcd4e756fa2065c03ae488fcfa7
> > 
> > Just forgot to follow up on this thread. Sorry about that...
> > 
> 
> Good to see it being fixed in net.git commit:
>  7abd955a58fb ("net/mlx5e: RX, Fix page_pool page fragment tracking for
> XDP")
> 
> This need to be backported into stable tree 6.3, but I can see 6.3.13 is
> marked EOL (End-of-Life).
> Can we still get this fix applied? (Cc. GregKH)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

