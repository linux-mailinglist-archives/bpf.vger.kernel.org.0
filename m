Return-Path: <bpf+bounces-14433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 384C17E47BA
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 19:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38BC281287
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 18:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B35F35896;
	Tue,  7 Nov 2023 18:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wygk6weT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B78734CF0;
	Tue,  7 Nov 2023 18:01:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3795FC433C8;
	Tue,  7 Nov 2023 18:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699380109;
	bh=vGJlW5EjtqEPrnkrsRnWWZXgMnwcYI2RmZWWh/4ej7Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wygk6weTx/+nbzMXUFJdK3ZauPXXHJTo0NfUNiXYx0nOM20C5fg1/NfcBpvNBM9Yt
	 El/eHEfiDnZ9/9xhTjQ3maiYCTRbiThs3/x5Hye9z7pcG98q3xFQ78sTmS/F7es7jS
	 zjh4hFoFDvaC46DZ1rccswbNCIP0+Nq5HPhN1ruB2iDNaOY/getx2TAzaLSkmMwSyV
	 Y6EvSFXvgk3Uqj352PWCSSKiA5ZOLY3o3RvKikfNMWK2SAXjtxj9HU5nM+u3NEA1DL
	 HglQfVg1KUmUjEXJeL6K9SvS4i1pZa9CrUIxh2le/gvSc87jbFSqCKOiik9i+vYwsz
	 +XOweqRPsnA7w==
Date: Tue, 7 Nov 2023 10:01:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, virtualization@lists.linux-foundation.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 00/21] virtio-net: support AF_XDP zero copy
Message-ID: <20231107100148.560d764a@kernel.org>
In-Reply-To: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Nov 2023 11:12:06 +0800 Xuan Zhuo wrote:
> Please review.

## Form letter - net-next-closed

The merge window for v6.7 has begun and we have already posted our pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Nov 12th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer

