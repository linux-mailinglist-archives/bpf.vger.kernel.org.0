Return-Path: <bpf+bounces-4620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7466074DD18
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 20:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CBCB28133D
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 18:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E0F14298;
	Mon, 10 Jul 2023 18:09:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE461427A;
	Mon, 10 Jul 2023 18:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E39FC433C8;
	Mon, 10 Jul 2023 18:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689012593;
	bh=FnP3de+Z8xupIA4NpipjHSHDDg43lHxK1c4KFYSXqgY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZaPLmDwlBEfLzjvoXukw7ao04it8OErMdkL9CroUbVFllIDrLTBk9JY7+Ygh8PgnQ
	 fRzWX+UVIjpe8KWXu5sJYYhVAppitSJ54F7PITFRuV7BQKiAaAHTJ3S+Hg9VKs7Kz1
	 FR7/72axhpBj3KK/VKT/huARe+mAhl5oWZ/Wl4H1T8lkmlWaNu7NwBMLTyLaPngHLQ
	 EKg4R+xUebwWWPO+Ouq3h5NhIQ0IbSkt7Z/BzDeDeAuxPD6OwtivTJw1aoEOr12lLh
	 jXR1/wuI7ZwhK7DEjnh6/SNBBm/mJYlPQLmlDroJFUt/q2pPhiY1Ua/mB0Q/BAVmcN
	 irhDLQqxvMO4Q==
Date: Mon, 10 Jul 2023 11:09:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gavin Li <gavinl@nvidia.com>
Cc: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
 <john.fastabend@gmail.com>, <jiri@nvidia.com>, <dtatulea@nvidia.com>,
 <virtualization@lists.linux-foundation.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [RESEND PATCH net-next-mlx5 V1 0/4] virtio_net: add per queue
 interrupt coalescing support
Message-ID: <20230710110952.30c4384c@kernel.org>
In-Reply-To: <20230710095850.2853-1-gavinl@nvidia.com>
References: <20230710095850.2853-1-gavinl@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jul 2023 12:58:46 +0300 Gavin Li wrote:
> Currently, coalescing parameters are grouped for all transmit and receive
> virtqueues. This patch series add support to set or get the parameters for
> a specified virtqueue.
> 
> When the traffic between virtqueues is unbalanced, for example, one virtqueue
> is busy and another virtqueue is idle, then it will be very useful to
> control coalescing parameters at the virtqueue granularity.

Why did you resend this, disobeying the posting rules:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

and what is net-next-mlx5? :|

