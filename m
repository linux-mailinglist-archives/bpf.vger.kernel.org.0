Return-Path: <bpf+bounces-54755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73FFA71973
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 15:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1743178319
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 14:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9700A1F3BAC;
	Wed, 26 Mar 2025 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+URllHj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7F31EEA36;
	Wed, 26 Mar 2025 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000583; cv=none; b=R9Nu9KBuqbb/6Mw+uITlj8WnDxo4DeYImVPS5nYxX+8zhdWZNuEhafRe/PYuDC6BsFRlamHe1ii1oH+c2VrlnyO4hWp67xTaQxpBrTMEiVSLlLOPCovOw+k0c0ZidDaH3U4L5yfZAG7VOHsNgPfz2cONGaJniQmaDPtwn1GBwus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000583; c=relaxed/simple;
	bh=ZnDrF3Qjo625zVHuG+CN09ZKhta1GQvCWyZ70ZYEOP0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OsxPhIjsu9T0IG+2yfdLi3es+FcQ1NQJOOxPaHhyuCtOMSczoioampslxicfVT1lCqHI374fB3PFDCHALCAnQzMyVHeTnKXkSHxYXA4S4laJcNq52SHlO67Osa7FBVBAjnKBo9vMpVcXQSwf1z1b9xsJwICqubeokcD1o0WGsTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+URllHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D37FC4CEE2;
	Wed, 26 Mar 2025 14:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743000582;
	bh=ZnDrF3Qjo625zVHuG+CN09ZKhta1GQvCWyZ70ZYEOP0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d+URllHjTgNNd+zMlhSpLFTbYcErr05+eEI76//gFvOEZcpDQPExXW1I8nbjV+wd0
	 07cwnoDHJv0aSKCm2cibS03/9ZtTu0kPE3zJl3mjIMhzUgRXTZttTH3LGy8ZVKr/8v
	 0GCPfgE8CRJ/u7NTAugG0nDS7/jw/weZ4oIipKqP587f5P6bQoGkaq7r6eo2RCEZl0
	 K0DqqNJDypkGmVQoUWG8bkkZYAbu1RYAn4DtzytnWPTGJmP8IU92HzTgGA/MDVoVEJ
	 g1tJSv6alDaQRJsM359xdHwN/XsE4DSmM1BPSNlyXBkHfrJfYKTagzSNy+nTD/vLie
	 uBBgmy6z+G5eQ==
Date: Wed, 26 Mar 2025 07:49:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mina
 Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>
Subject: Re: [PATCH net-next v3 0/3] Fix late DMA unmap crash for page pool
Message-ID: <20250326074940.0a224403@kernel.org>
In-Reply-To: <874izgq8yy.fsf@toke.dk>
References: <20250326-page-pool-track-dma-v3-0-8e464016e0ac@redhat.com>
	<20250326044855.433a0ed1@kernel.org>
	<874izgq8yy.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Mar 2025 13:20:37 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > maybe rebase/repost after Linus pull net-next, in case something
> > conflicts on the MM side =20
>=20
> As in, you want to wait until after the merge window? Sure, can do.

I think we can try in this merge window, just after our first big PR
which will hopefully come out today.

