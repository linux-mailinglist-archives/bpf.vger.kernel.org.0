Return-Path: <bpf+bounces-58733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD77AC104D
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 17:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815031BC405F
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 15:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E150299A9E;
	Thu, 22 May 2025 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLMTk1AE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD6B28A1F4;
	Thu, 22 May 2025 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929094; cv=none; b=cBs3PNK+AiGxBIeVJFOOSoFBhRJ7dvAPw+5F2z0ICIa8tHh+CgvLWs6q+hyr7hhZySfNYDNNxWzYS+aP6vZOT2BZdM7svt0sI+HH9R8pIRCagj5yGJOo+LItxynrOih/7D19ZhPj0VMKqjOKcXexExDsi/CL1JOr8syrP5H7LnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929094; c=relaxed/simple;
	bh=4bsemptlDhAI0PArtZ/1WVn71Ejo102Rs0+uUxAyVtw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9KmflbIQPpmKgFT0W+FSru9M7ZmFP+oWbw7OH8nN6LG1tSsGo4w7yIOl0rloWi8kuhwrrKnKWfLWyGkK8+Rt3j7vN7JyUVS+xlSYc6VSrZVN6nYW+ldzc5In2ue3Bgd8xQcga1fGtnqf3/gelNbqoEJ+ehmDneOrWeK2KOQBgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLMTk1AE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11353C4CEE4;
	Thu, 22 May 2025 15:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747929094;
	bh=4bsemptlDhAI0PArtZ/1WVn71Ejo102Rs0+uUxAyVtw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MLMTk1AEu8d2ysl/M00IMCFHW5ItgCvdQhwysT4XE6r95O6HRNTtWE1mDslyOeztJ
	 yOeMlCYfnGDar7Yub2dmH8hWGjCJZwnPGFOn9tWFf1hFylyskS+atEgDEMAWK2lX2u
	 MSgTepovETCWUpHReRspHL+qh88uCbGDStbVK8WdinwvNBunX3V6nARuQCGjVjgDMp
	 +sXAwX19iktzg14NSM+0KOI64aGB2sgQamB15OdWw4+7McJsCa2n6kMh3+/vSwmzgs
	 QMX622jhCVN84f+2LI4YjNAf3tqKelkEmiK6OOmbT1NNn+OCOh2aSEPUm/tgrGMzeA
	 NEJFQ7YjwcZHQ==
Date: Thu, 22 May 2025 08:51:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
 <leon@kernel.org>, "Saeed Mahameed" <saeedm@nvidia.com>, "Richard Cochran"
 <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>
Subject: Re: [PATCH net-next 0/5] net/mlx5: Convert mlx5 to netdev instance
 locking
Message-ID: <20250522085132.177d7a16@kernel.org>
In-Reply-To: <1747829342-1018757-1-git-send-email-tariqt@nvidia.com>
References: <1747829342-1018757-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 May 2025 15:08:57 +0300 Tariq Toukan wrote:
> This series by Cosmin converts mlx5 to use the recently added netdev
> instance locking scheme.

Are you planning to re-submit this as a PR?
The subject tag and Leon's reviews being present makes me think
that applying directly is fine, but I wanted to confirm..

