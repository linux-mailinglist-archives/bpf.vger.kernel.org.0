Return-Path: <bpf+bounces-28224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE7A8B67AB
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 03:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80DA0B20F9E
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 01:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F2853A7;
	Tue, 30 Apr 2024 01:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rwk/plWi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7978205E3C;
	Tue, 30 Apr 2024 01:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714441737; cv=none; b=COOv379kfHAI15R8R41uHxZNlsYMS8LZgO8GQWpYwza3x5J7SX5fdzClo4oAl8JaJfofufwfxfPWmKbmhspPnOr2r4bam/RN6yfK079pVepDuOcaWA/1a2EbhzGZeGLntaKoL7zt4DclCHmUObPPnWMFusvtmNGnf2PSXHMeno4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714441737; c=relaxed/simple;
	bh=c7QzoCOujtAxbTC0elHaSUaFysScZ8hXHLPiQh+BjXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7zSb7F4hFGhwuQM4Njne79Dv9SuM3r3To6SalnxWSdGWngAQ6QMjkhkDZ1MVbRQoePjmceiKlVwzNO1+5AaT/p7ch+UnLP3P3sxJqhYJQmCMSRQft356O1RpkjyZH4/3ixWp6NyEgikufkhqIV0yJSMyybfae0obEkf6yytlv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rwk/plWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77E1C116B1;
	Tue, 30 Apr 2024 01:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714441737;
	bh=c7QzoCOujtAxbTC0elHaSUaFysScZ8hXHLPiQh+BjXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rwk/plWivRvxtyN78BMVb2XoOsELsLIR+aErjqj2rVheUi/FaWJxTgvxW0/T+8fSH
	 6jIcT+QXtvW2LOxlHcr8p69xdyPZrFDNjY8JA1JsIbUZb1f8s5GH1V81fb+1BlbqOr
	 mNBOYdU2q53f4YUuGN+eOdtxlBF4CbqDYCA2caP+aMy8RqIveNGubW6RLKSGxRYyjd
	 tzh2UcP0tIfGT+rJ39pn58yns306motc80r4Egy3kPgDkrKGRvFdAG8svOcjTE9Wix
	 GdV6V2niZodhkgH9enJ5XQaOYJOhEhzaa5NqgK+yMKKy8hhHPytu7pRlCap0Weyo8Y
	 gCv7a2VynhYng==
Date: Mon, 29 Apr 2024 18:48:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@google.com>, Amritha
 Nambiar <amritha.nambiar@intel.com>, Larysa Zaremba
 <larysa.zaremba@intel.com>, Sridhar Samudrala
 <sridhar.samudrala@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, virtualization@lists.linux.dev,
 bpf@vger.kernel.org, Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v7 0/8] virtio-net: support device stats
Message-ID: <20240429184855.0d8d1eef@kernel.org>
In-Reply-To: <20240426033928.77778-1-xuanzhuo@linux.alibaba.com>
References: <20240426033928.77778-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Apr 2024 11:39:20 +0800 Xuan Zhuo wrote:
> As the spec:
> 
> https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
> 
> The virtio net supports to get device stats.

These got marked as "not applicable" in netdev pw over the weekend, but
I think net-next is the right target here. So unless someone disagrees
or we need more reviews we shall apply these tomorrow.


