Return-Path: <bpf+bounces-54727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CD9A70CB7
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 23:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23843ABA76
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 22:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4825269D15;
	Tue, 25 Mar 2025 22:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1aYRi3J"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3188D18DB03;
	Tue, 25 Mar 2025 22:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742941075; cv=none; b=mlpxjlMKP142TZt6XnfwFAhl0mLCI5DZ3x72nAwNe0B7ZXwoUA6rApFpwMuzefmzmkK7eL0IOcHiEoo5OY4cLAM8acLZJoCQBjt7JA/3H2g6quLoyxoPcL6uV1StJHbcd6Igz4R3ivsb/s43OU+zN7hNWIF92rfqjHcKD57bGIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742941075; c=relaxed/simple;
	bh=kzxh5F2gKKAO69jcdX6pCWM1eOL8ymIS83Aamiqd7kE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r0NCiRl658ELFFHTA+Wnsx88Tf7fFZJg/HvFfHi512HoK1fnax+Pr5cvE1l04Hi8F7AsnmWm0RE3OVWg/IcKrTg7A2S/iSnTSmmge/EZmx7kh6iNZbkHGfcIir9LxZEAcEsJ+zfl1IhwVNfz+6MN0C9Ef+hyXF97pfEKq1irGYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1aYRi3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0BDC4CEE4;
	Tue, 25 Mar 2025 22:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742941074;
	bh=kzxh5F2gKKAO69jcdX6pCWM1eOL8ymIS83Aamiqd7kE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r1aYRi3JuXd3kSdlB2S7dp/XNCAOoetrga+UUl9CZQQCwU3eVW6EnnvBH2n9OiM9S
	 obOLWutsYg2zodiKeOwYi9hFMfkLLbFsZKU4xhYcC62FJLmjRGC+7Kgasy9bo+LZqk
	 LeHFhEWDckel0YEIf3OD+9oFrfsH2MdWy322Ypo6n6BFdIcdEEoOK0g7a2anH1Xyif
	 KKBl7dc+bsAktAc8MyFcTIT7B9+X6FFrrOhdaMHI/bsXa4qS+MQCx9qb4gTjWUnjvi
	 NHCM2kdKFESIOekdtk2FhSj5ca5kGlZUllyC4OuVd9TwOAI1Otqf7Qsf/rgnmHjyiF
	 yTriR0CqYtvXA==
Date: Tue, 25 Mar 2025 15:17:43 -0700
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
 linux-mm@kvack.org
Subject: Re: [PATCH net-next v2 2/3] page_pool: Turn dma_sync and
 dma_sync_cpu fields into a bitmap
Message-ID: <20250325151743.7ae425c3@kernel.org>
In-Reply-To: <20250325-page-pool-track-dma-v2-2-113ebc1946f3@redhat.com>
References: <20250325-page-pool-track-dma-v2-0-113ebc1946f3@redhat.com>
	<20250325-page-pool-track-dma-v2-2-113ebc1946f3@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Mar 2025 16:45:43 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Change the single-bit booleans for dma_sync into an unsigned long with
> BIT() definitions so that a subsequent patch can write them both with a
> singe WRITE_ONCE() on teardown. Also move the check for the sync_cpu
> side into __page_pool_dma_sync_for_cpu() so it can be disabled for
> non-netmem providers as well.

Can we make them just bools without the bit width?
Less churn and actually fewer bytes.
I don't see why we'd need to wipe them atomically.
In fact I don't see why we're touching dma_sync_cpu, at all,
it's driver-facing and the driver is gone in the problematic
scenario.

