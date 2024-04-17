Return-Path: <bpf+bounces-27026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ECC8A7D65
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 09:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3CF1F227D8
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 07:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C326F06B;
	Wed, 17 Apr 2024 07:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Esh0qFBT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920316CDA6;
	Wed, 17 Apr 2024 07:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713340265; cv=none; b=GtD5Ucx2ou+95xLZRcQl40qh3GZHU720aDJWsosLuQb/pDndZygBaymKREtoeDOeNCONIbIIuurqgbS3ecEbKmC/THkSxyILD8G+O40P2Mh0dCU4Y2l0wjmzLkmbDF8yf8C31JG3N5uRgRyUWo2xLxJW76xXCGms2hTwTECQAqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713340265; c=relaxed/simple;
	bh=jXXyD1I8CogloKubEo76l4oe31rDSKZyXzyr4ox5Chs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qlKIrHPS+Fh18fkDIkc0/bwXLZ2kh79YfELbwtX1a3wkiAbfbjQ0sCIHdZ89ZEmmAspnv2T9AJfEwRRTFlIiD8LWGNIlHWKPcyuwFW8ZouKAZKIj8PJGxRGmWN8BLDEk7XVEK+wMDOVgcu5bNx/Yba6prKJD8dvTc9zPsdenQXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Esh0qFBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BF3C072AA;
	Wed, 17 Apr 2024 07:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713340265;
	bh=jXXyD1I8CogloKubEo76l4oe31rDSKZyXzyr4ox5Chs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Esh0qFBTC6WJGlOzJkrP+JTkBripnOOtQuBMZsls0mEuf0mil8ecnLlwiRykAEvpM
	 8DJAFpfMI+0YCN8w0jaicczzOASwR5w+AEQrVdaXBpTO5idyGIsrpra494yRAct3GH
	 ZrwxGxB3tVTTDpUWzbkj6DEWrGK1xmN2E7fuYQ8C5axi6eq9ynqpH/sC2YKBLlN/6l
	 O2Pbbpj37INrAwvlzkHoTD0PBUaK5SS0PdiOlNwFB9qgD5c+D4Xh5GVH24ggew0njM
	 7uI3NMFgSNOdkVSTEc4XAj2pxCs5qivysGilYayaaI7ei28g4t+TfBbHUMSCxv7Qn+
	 nV3wLMd6VR6xw==
Message-ID: <3ed3c70c-0bc4-4ae3-92e5-ce5af1958deb@kernel.org>
Date: Wed, 17 Apr 2024 09:51:00 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9] virtio_net: Support RX hash XDP hint
To: Liang Chen <liangchen.linux@gmail.com>, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, hengqi@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, john.fastabend@gmail.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 ast@kernel.org
References: <20240417071822.27831-1-liangchen.linux@gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20240417071822.27831-1-liangchen.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/04/2024 09.18, Liang Chen wrote:
> The RSS hash report is a feature that's part of the virtio specification.
> Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhost
> (still a work in progress as per [1]) support this feature. While the
> capability to obtain the RSS hash has been enabled in the normal path,
> it's currently missing in the XDP path. Therefore, we are introducing
> XDP hints through kfuncs to allow XDP programs to access the RSS hash.
> 
> 1.
> https://lore.kernel.org/all/20231015141644.260646-1-akihiko.odaki@daynix.com/#r
> 
> Signed-off-by: Liang Chen<liangchen.linux@gmail.com>

LGTM

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

