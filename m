Return-Path: <bpf+bounces-29047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5FD8BF912
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 10:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319C51F23022
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 08:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632B853818;
	Wed,  8 May 2024 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsqk/DHR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A6246453;
	Wed,  8 May 2024 08:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715158393; cv=none; b=K+zU6OBW7v0NwPufjk02u4cUhY2bmZueDQJ8/SDA+qeX3PlEXUolghIdYFC9nd3Rckepk/TVYXjQXhqsMr/8Ub2Q4GmpVIbIePKIVIEQ/ZKc6Q/J9vwwsjg+AS2uD86dwWmRYf7dJU6aHzdi66QmMCRnT5s4TaLlCiGEfAfBYIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715158393; c=relaxed/simple;
	bh=W9i+0UwSIxGffCty/8mZuU1UQUdF5pVE6vy46XAO7Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uy8ScbICKCiNAezcPlJV3kmVUSc6m17PpRJbJ+i8PbIC8POIg/vV0pAQMhOqzma151I9tV7n42E+ygze6c/ZugKcpThZdmhqZ6nHVC5WTcgPidCQc9nwI9YyAim/OEeg5BJor+ZNuEmvUL3KUkDZuakJAC1ff7NCOdCNHgfaOoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsqk/DHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFECDC4AF17;
	Wed,  8 May 2024 08:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715158393;
	bh=W9i+0UwSIxGffCty/8mZuU1UQUdF5pVE6vy46XAO7Ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rsqk/DHRbmtn3hbdlXfqnusf9dj7a1WlTNJ/QFiBnEEpV00n8B5IxxSRf1/DqX3UA
	 ljpNm8TpcZFIkfTbtZuPNbVPgsqyUBhYtQNoLkRknk2V2eu+E/sCHlbNzp0AqJ9YKV
	 dDEmOfX9vwV+skVj9bjTOlV4d8LnqI50CKj4HPvn9UfXxDhoGZeaW4HoNJWNT/pPu7
	 WfJFkAEHWXLeNtGqBIxoIdtxvzCshq6v0lQTPNHodyHePhgkyVzPmnOVfSfSe5f6qa
	 B8QzL7Wo8SU6C7OQdtbFTBetsC++F/fZ/UFi9/3giy279ZLhcpaEwmUSsZWXo5WP0R
	 ts/am9tW7tmIA==
Date: Wed, 8 May 2024 09:53:08 +0100
From: Simon Horman <horms@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 0/7] virtnet_net: prepare for af-xdp
Message-ID: <20240508085308.GA1736038@kernel.org>
References: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com>

On Wed, May 08, 2024 at 04:05:07PM +0800, Xuan Zhuo wrote:
> This patch set prepares for supporting af-xdp zerocopy.
> There is no feature change in this patch set.
> I just want to reduce the patch num of the final patch set,
> so I split the patch set.
> 
> #1-#3 add independent directory for virtio-net
> #4-#7 do some refactor, the sub-functions will be used by the subsequent commits

Hi Xuan Zhuo,

This patch is targeted at net-next,
but unfortunately it does not apply to current net-next.
Please rebase and repost taking care to observe the 24h rule.

Link: https://docs.kernel.org/process/maintainer-netdev.html

-- 
pw-bot: changes-requested

