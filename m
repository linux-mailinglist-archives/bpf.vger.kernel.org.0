Return-Path: <bpf+bounces-38911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFBA96C673
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 20:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25C428808F
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 18:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617C51E410D;
	Wed,  4 Sep 2024 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ih7DV+zp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B091E203D;
	Wed,  4 Sep 2024 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725474599; cv=none; b=G9FQFlILrL2CY/5qEuv7Yt/ICC0zpKWEU6eauYfvmT4Ry2DiwnterMad/kp6Oh4+QLIM8joOeV6KmWSq1yMqfZg4cHpsErgEQb88rzQkTkYSqaSakG83ZSBL3gm/6bpH0ntz5uChOpt1qIFDT0CD/WyeGoP/ImvfPbN4DwzRC+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725474599; c=relaxed/simple;
	bh=3osTPUwTmGcKwPH//xm+7vmLa4zw4IUoIj5wosRXRz8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fHf0xXbLd4PFm8GHCIpv3L2EUslArZdhMOI7y8jku+DKpqYOmrd01yxlHEPi07nMuBaYC/+D4EEpGiUeImC2SJADlItjQL0jNQ65THWA++gExFMQizp2/P6UjnyuDRAYzEFGUN6Mu2KHrAxzS/gAVdFGp1l1zWOMLKQsMmIjp14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ih7DV+zp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCACC4CEC6;
	Wed,  4 Sep 2024 18:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725474599;
	bh=3osTPUwTmGcKwPH//xm+7vmLa4zw4IUoIj5wosRXRz8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ih7DV+zpB9TOtau5uTgvSF3mLuNm286RYOZhYn8xv0aC59XfUJMNiHPNE7a5OSTfC
	 +c7sugu3Gp4ProSoUZmnzAZ2wSvT89khm8HKvsdfRedjlpwrlG7QEd5zNOkYwCyOpL
	 zWcSTJaCtSk4EmnJvF0HVEfAFxwR/qcqGDTJCYCXWpSCWzioQ0qw7c1S0PcnLnsFen
	 eej7v5viNV5x2dm5diii+e+PHrLoUPesbwU+zBOVE00K0M/DUNJ8+oGIzaQaX+Lltm
	 nivJFQ0yV8CptgeVIko+jJHy9itRq2d+Tq7zVgq2zwPg5nLMDWu1NajMJTouQDAJBp
	 9BW8ud+/G311g==
Date: Wed, 4 Sep 2024 11:29:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, John Fastabend
 <john.fastabend@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 0/9] bpf: cpumap: enable GRO for XDP_PASS
 frames
Message-ID: <20240904112957.3aaaa734@kernel.org>
In-Reply-To: <03634fe4-8c2f-432e-ae6e-08928d167b1f@intel.com>
References: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
	<20240903135158.7031a3ab@kernel.org>
	<f23131c1-aae2-4c04-a60e-801ed1970be8@intel.com>
	<20240904075041.2467995c@kernel.org>
	<03634fe4-8c2f-432e-ae6e-08928d167b1f@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Sep 2024 17:13:59 +0200 Alexander Lobakin wrote:
> >> I could say that gro_cells also "abuses" NAPI the same way, don't you
> >> think?  
> > 
> > "same way"? :] Does it allocate a fake netdev, use NAPI as a threading
> > abstraction or add extra fields to napi_struct ?   
> 
> Wait wait wait, you said "NAPI IRQ related logics doesn't fit here". I
> could say the same for gro_cells -- IRQ related NAPI logics doesn't fit
> there. gro_cells is an SW abstraction.

Yes, that 1/4th of my complaint does indeed apply :)

> A fake netdev is used by multiple drivers to use GRO, you know that
> (popular for wireless drivers). They also conflict with the queue config
> effort.

And it did cause us some issues when changing netdev_priv() already.

