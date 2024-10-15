Return-Path: <bpf+bounces-41894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6E799DA93
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 02:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5E62830C7
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 00:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481BE3C3C;
	Tue, 15 Oct 2024 00:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KA8B/kcn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5195A29;
	Tue, 15 Oct 2024 00:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728951248; cv=none; b=SaOX523pkxF3SvnwTHR1mVC3Pz+22Vndjw1cMiSDYmbc9TU5QmeMzGcXi8ZSyjUU87NkMmKiLW8vqWI5nHLrpAta/2lUAVW19OV2dwfLEb2tdNjhbgRO9amseTbfhrA84O4799w5wtts/pHtC3xzZmm/azaPk4Kbdnxu+YGMU2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728951248; c=relaxed/simple;
	bh=vC2js+3LTh37+eK6v22mAPM7Aj/mMz6+h5IByLtkN9E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ax7cXifOTYNRGxrdq3Bpil1KO71iaja7Rx1D6lJ9lLe36y2QvxJbIGntBtpCmzmhXgmPOrkvl3FY84/5IG086SWAN2GZF2skOF6/Rt/KSQZ2Rmn1HAyUcGwyMS+cAeatQTh2diXfCPYaz6z5//yIo7/ZrqtPoy2hnas3MNAIMW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KA8B/kcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69880C4CEC3;
	Tue, 15 Oct 2024 00:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728951248;
	bh=vC2js+3LTh37+eK6v22mAPM7Aj/mMz6+h5IByLtkN9E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KA8B/kcn+CyFsGvB5lRCxHl/oMJ1/+ytr1xDfxtbTs2DknFuUjJajsNy0pBQtNinE
	 aBThc9YZ1cFhAt31Z5v+RM/dhm2JAPTKuGtyuje64hxEH/H5VEHEbjO4USBbUN1fAj
	 guPIt3CzR7l2Z+1Z0iyzUflxo7LwX4BZfgu0zRLrp0OQKlnGPZAWBX+nVhbl7Gsjv6
	 QUT/nM9S1klJHU1VYvDFpllFdm+q/ha04BQtbSPGDMqXRkoJOlhnkVy9vfNjYfYlgJ
	 jQjJ7ODdnQfVsF0VXXApSdXdP/on+vs9Gx0cHlCCgG8uaZ6zjBRSt7o7Mfyx1NvgCU
	 8QE2ujuElZjug==
Date: Mon, 14 Oct 2024 17:14:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <liuyonglong@huawei.com>,
 <fanghaiqing@huawei.com>, <zhangkun09@huawei.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, <netdev@vger.kernel.org>,
 <intel-wired-lan@lists.osuosl.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH net v2 0/2] fix two bugs related to page_pool
Message-ID: <20241014171406.43e730c9@kernel.org>
In-Reply-To: <b1fd5ece-b967-4e56-ad4f-64ec437e2634@huawei.com>
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
	<b1fd5ece-b967-4e56-ad4f-64ec437e2634@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Oct 2024 20:05:31 +0800 Yunsheng Lin wrote:
> 1. Semantics changing of supporting unlimited inflight pages
>    to limited inflight pages that are as large as the pool_size
>    of page_pool.

How can this possibly work?

The main thing stopping me from reposting my fix that it'd be nice to
figure out if a real IOMMU device is bound or not. If we don't have
real per-device mappings we presumably don't have to wait. If we can 
check this condition we are guaranteed not to introduce regressions,
since we would be replacing a crash by a wait, which is strictly better.

If we'd need to fiddle with too many internals to find out if we have
to wait - let's just always wait and see if anyone complains.

