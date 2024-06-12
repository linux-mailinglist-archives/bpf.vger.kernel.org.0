Return-Path: <bpf+bounces-31988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236F4905F2A
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 01:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D88A1C2116B
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 23:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB86912F5B8;
	Wed, 12 Jun 2024 23:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYB0DRIQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D1412F36F;
	Wed, 12 Jun 2024 23:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718234619; cv=none; b=Ku9bYhj+ksPGh3Xm8dwv/WN2IYlaB10SHuOHgXOsbyjDiRM7PGBKerDKS1LuJyvKam1loL/pRWxlz+oqaRwcvjdjY/urJUGVqDvvedeyVoFmUpF361xEQXrYmUGhLsvDx5LTLOfY0uc6HiSz2MuoK6drbYzIKpVF+IU3EQsVD4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718234619; c=relaxed/simple;
	bh=BpwPyJrhH/UuQnPlNqnYogAAjWqdcslYAnlkZszGhPA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3VBA+amJTyzLcmeQnOfvH77OBaCA6FWRGsa/QC8JZ/jqboPlG3235TVoEk3E/4vhZoF1Ytk5xOoVrKPFhBhRRZMvALkefvygyx1mmc5ZcnpQw8UtMIZQwIxbpPpqSoWXuEuiDsMa+oBeR3qNEa8cwyJFaFNxJyei97l2GA+YFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYB0DRIQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368BEC116B1;
	Wed, 12 Jun 2024 23:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718234618;
	bh=BpwPyJrhH/UuQnPlNqnYogAAjWqdcslYAnlkZszGhPA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oYB0DRIQuMqWUfqrSxYVEbvnwlkaxqHB96owzjFlp+jj8BD6VuUeDIp+ZP/WQV5fS
	 L1YMX9+kxtpzh8XZclXcdtm/JxmsU/Tm/V6lxCljoTCs+90BI/lXRHiRc4vIShFo0Z
	 oWDHGBGvX+fllOyNtEJjPAQdzUe10PTDY4ONxt+z2GKJOHwyMPLNQjSzBVJ/hpslBb
	 Jxbj95Vhx07URCX34YV9rdrYUDsaT70ATkGs82UkOBpnBg9CpDykMMWxLWC6hMesRJ
	 lgtxvpPyN87Jix3+VZ85lRWOvYlIaCajkl18g9HdLDPLOST4AJt1nLirzRQzyrr1qa
	 WGIo+PnNcdjbw==
Date: Wed, 12 Jun 2024 16:23:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 08/15] virtio_net: sq support premapped mode
Message-ID: <20240612162337.137994bb@kernel.org>
In-Reply-To: <20240611114147.31320-9-xuanzhuo@linux.alibaba.com>
References: <20240611114147.31320-1-xuanzhuo@linux.alibaba.com>
	<20240611114147.31320-9-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 19:41:40 +0800 Xuan Zhuo wrote:
> +static int virtnet_sq_set_premapped(struct send_queue *sq, bool premapped)

Could you try to add __maybe_unused or some such and then remove it
in the patch which calls this function?  Having warnings during
bisection is not great.

