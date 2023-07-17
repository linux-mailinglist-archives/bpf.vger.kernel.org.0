Return-Path: <bpf+bounces-5097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 102A77566B0
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 16:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 417CB1C209AA
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 14:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB95AD52;
	Mon, 17 Jul 2023 14:42:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204DE253A0;
	Mon, 17 Jul 2023 14:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CBCC433C7;
	Mon, 17 Jul 2023 14:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1689604922;
	bh=iRMCergF9pY20Qqnb4LRH1cqLhY+eRjsE2jBE0hrSiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2Qz9tux1d0SS+rYA6B1yNzl3P83qh1aFW58cAjzKCFqvmk1yiYjLxlIxd3UUozmkq
	 PguBmyUk7oZb2vFCbHA4Xv1gmH/7AsNwzUJEZ2ocRqSrIGqAQWIrgvLVyun9foqpVH
	 dO+XQjk0jk1lysTvlkN/ClqQ/yeBP8eU9i3IEhrY=
Date: Mon, 17 Jul 2023 16:42:00 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "jbrouer@redhat.com" <jbrouer@redhat.com>,
	"atzin@redhat.com" <atzin@redhat.com>,
	"linyunsheng@huawei.com" <linyunsheng@huawei.com>,
	"saeed@kernel.org" <saeed@kernel.org>,
	"ttoukan.linux@gmail.com" <ttoukan.linux@gmail.com>,
	"maxtram95@gmail.com" <maxtram95@gmail.com>,
	"kheib@redhat.com" <kheib@redhat.com>,
	"brouer@redhat.com" <brouer@redhat.com>,
	"jbenc@redhat.com" <jbenc@redhat.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"fmaurer@redhat.com" <fmaurer@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"mkabat@redhat.com" <mkabat@redhat.com>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>
Subject: Re: mlx5 XDP redirect leaking memory on kernel 6.3
Message-ID: <2023071705-senorita-unafraid-25b8@gregkh>
References: <d862a131-5e31-bd26-84f7-fd8764ca9d48@redhat.com>
 <00ca7beb7fe054a3ba1a36c61c1e3b1314369f11.camel@nvidia.com>
 <6d47e22e-f128-ec8f-bbdc-c030483a8783@redhat.com>
 <cc918a244723bffe17f528fc1b9a82c0808a22be.camel@nvidia.com>
 <324a5a08-3053-6ab6-d47e-7413d9f2f443@redhat.com>
 <2023071357-unscrew-customary-fbae@gregkh>
 <32726772de5996305d0cfd4b6948933c47cb7927.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32726772de5996305d0cfd4b6948933c47cb7927.camel@nvidia.com>

On Mon, Jul 17, 2023 at 02:37:44PM +0000, Dragos Tatulea wrote:
> On Thu, 2023-07-13 at 17:31 +0200, Greg KH wrote:
> > On Thu, Jul 13, 2023 at 04:58:04PM +0200, Jesper Dangaard Brouer wrote:
> > > 
> > > 
> > > On 13/07/2023 12.11, Dragos Tatulea wrote:
> > > > Gi Jesper,
> > > > On Thu, 2023-07-13 at 11:20 +0200, Jesper Dangaard Brouer wrote:
> > > > > Hi Dragos,
> > > > > 
> > > > > Below you promised to work on a fix for XDP redirect memory leak...
> > > > > What is the status?
> > > > > 
> > > > The fix got merged into net a week ago:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/drivers/net/ethernet/mellanox/mlx5/core?id=7abd955a58fb0fcd4e756fa2065c03ae488fcfa7
> > > > 
> > > > Just forgot to follow up on this thread. Sorry about that...
> > > > 
> > > 
> > > Good to see it being fixed in net.git commit:
> > >  7abd955a58fb ("net/mlx5e: RX, Fix page_pool page fragment tracking for
> > > XDP")
> > > 
> > > This need to be backported into stable tree 6.3, but I can see 6.3.13 is
> > > marked EOL (End-of-Life).
> > > Can we still get this fix applied? (Cc. GregKH)
> > 
> > <formletter>
> > 
> > This is not the correct way to submit patches for inclusion in the
> > stable kernel tree.  Please read:
> >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to do this properly.
> > 
> > </formletter>
> So...I am a bit confused: should I send the patch to stable for 6.13 according
> to the stable submission rules or is it too late?

There is no "6.13" kernel version yet, that should not happen for
another year or so.

If you mean the "6.3.y" tree, yes, there is nothing to do here as that
tree is end-of-life and you should have moved to the 6.4.y kernel tree
at this point in time.

What is preventing you from moving?

thanks,

greg k-h

