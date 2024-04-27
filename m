Return-Path: <bpf+bounces-28003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B3A8B4339
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 02:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F801C22DF5
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 00:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BD57464;
	Sat, 27 Apr 2024 00:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jakSmq+7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979C64411;
	Sat, 27 Apr 2024 00:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714177413; cv=none; b=hQKlE8s3JVwwBRHGI0f/SzWr0eGw2krW5+VRAcc+8yH1W12gmU886/8fO9KTd4Nm+aP4jtF6Yt+A59NPstuenWBPJKblBKrfJMFZAwgyxzHmmcemX/Vl+eHU5EQCs/mT8fpkqU6WPS26ez71XlyEbMO5xtQZJjClvraCEJEZMmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714177413; c=relaxed/simple;
	bh=OCPTAWbirmcsVF3vbS8dhn4ErP4QkrYMXoRIxwSqmfo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1+PJnWiN4no5rG2OQPkV0dCyrGUkRBY32MCSzW2Mr3ZdHg/1n72Ov1yMjMSIaRk2xymNWMOuKJM6hMt4oh6RuYeH4z6qJeEX1132r8nHmdeUn+2bLmWowajhy6LvgwExWMf8WmWtOSN6ffNx5WoSDP91cdN/kKr4T9z1fXfT6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jakSmq+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E397C113CD;
	Sat, 27 Apr 2024 00:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714177413;
	bh=OCPTAWbirmcsVF3vbS8dhn4ErP4QkrYMXoRIxwSqmfo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jakSmq+7plxA0QNtb6K0UecmPgbw7QWfoyhBq0O8yQmS2FCrkvktBA1YSXobk//U5
	 jspH5iO5EDpi6dbsI9MBulkMQymE8RR2OUmJvQeYFTpE16jOZY+FMzfVVick+5akOl
	 cnzHh0M0vyfN5BwkMuvgE6ea1iLjQarjoc3gMnn6Vj+3TgN8Ap3kMrX/+o3/fuQ4qX
	 00Ovc3VBKMBZRNBRy4ulzzsdIMAgx3TgsQ04fPYjeB6lTV/8e/G2usJxb7Bgpz0djj
	 IxQwHzYmqlM9OuBl81KuJWFFOvwfi1+JrvUF12o920MRdfIVl9DoUnkrgcMRyCQD71
	 NJcfTYw/FkxUw==
Date: Fri, 26 Apr 2024 17:23:31 -0700
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
 bpf@vger.kernel.org
Subject: Re: [PATCH net-next v7 8/8] virtio-net: support queue stat
Message-ID: <20240426172331.174483e6@kernel.org>
In-Reply-To: <20240426033928.77778-9-xuanzhuo@linux.alibaba.com>
References: <20240426033928.77778-1-xuanzhuo@linux.alibaba.com>
	<20240426033928.77778-9-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Apr 2024 11:39:28 +0800 Xuan Zhuo wrote:
> To enhance functionality, we now support reporting statistics through
> the netdev-generic netlink (netdev-genl) queue stats interface. However,
> this does not extend to all statistics, so a new field, qstat_offset,
> has been introduced. This field determines which statistics should be
> reported via netdev-genl queue stats.
> 
> Given that queue stats are retrieved individually per queue, it's
> necessary for the virtnet_get_hw_stats() function to be capable of
> fetching statistics for a specific queue.
> 
> As the document https://docs.kernel.org/next/networking/statistics.html#notes-for-driver-authors
> 
> We should not duplicate the stats which get reported via the netlink API in
> ethtool. If the stats are for queue stat, that will not be reported by
> ethtool -S.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Thank you!

