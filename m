Return-Path: <bpf+bounces-26482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B99AA8A0611
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 04:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4046B288CBC
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 02:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EDC13B2A9;
	Thu, 11 Apr 2024 02:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCLMROu9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BF313AD2E;
	Thu, 11 Apr 2024 02:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712803258; cv=none; b=O2rvKMpldb3ThP7fgS9rzYC5PUdyy/HBbodb6Oa400U334C87IeORHdK80Y+/9FDb2HOSaP+ZsDk7ADi6r2xazA6+Ns1ThtX3APK1fqDQ6SPs38BZmcN0sgdOsYZjHVM+Z2pqjrvgCLILcpnn7kfXuMdSf0qt2CjWGKrwPERO7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712803258; c=relaxed/simple;
	bh=Nbl2is2U3WrrBfLIDYACMv1pv0cSrz85+RNvb8hYl/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2QEkimqQ0Y0D2NTC+Cfg0tM/VewpJjBzTm8qNBKBV7CvkyBetzd31wCknPsHzGyMpR4Ius4pF7VeJVtpiYf7FQJODkIJjco9i685oJPUhsDVoMIfDZRElvzRHXnXrwLTL7cIU+m3AhWDO1DbvKdcDU6ysKXAd9oWXqjBVwvQoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCLMROu9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016A7C433C7;
	Thu, 11 Apr 2024 02:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712803257;
	bh=Nbl2is2U3WrrBfLIDYACMv1pv0cSrz85+RNvb8hYl/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CCLMROu97ipfxoLZXQkdGz6B7+EJ7xDeHjXUwaIqE17/hhV4kMbO3XZDWi0TgMhUU
	 yD8A7kqe2e35yzUKy/l+ZxEcq+TW/grmPx7yYPm2t9kPNnno2NGNLG7+kQiX4cCjSL
	 051gyG5uhSHwHp1/8nXsWoVdOBEMqY8N2G8K9JgMuIrm/2feEMoWhD6zozZYH69KsF
	 K4ov73CRpBrDBLGVsKdk3jX3a2rrTq1eVv0OTZ4rqXpRN0PH6ba5UXmHn2PJeJT2Dh
	 xdy3CyqBcqGZNQ3YdFUFHASc3mLkH8ZZ8NWk18f/+pnXT1mFqZzUcbDnXr6RbciwOS
	 JPYBy5CK3yW+w==
Date: Wed, 10 Apr 2024 19:40:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Camelia Groza <camelia.groza@nxp.com>
Cc: David Gouarin <dgouarin@gmail.com>, david.gouarin@thalesgroup.com,
 Madalin Bucur <madalin.bucur@nxp.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v4] dpaa_eth: fix XDP queue index
Message-ID: <20240410194055.2bc89eeb@kernel.org>
In-Reply-To: <20240409093047.5833-1-dgouarin@gmail.com>
References: <8edda7aa8ff27cee1b3fa60421734e508d319481.camel@redhat.com>
	<20240409093047.5833-1-dgouarin@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Apr 2024 11:30:46 +0200 David Gouarin wrote:
> Make it possible to bind a XDP socket to a queue id.
> The DPAA FQ Id was passed to the XDP program in the
> xdp_rxq_info->queue_index instead of the Ethernet device queue number,
> which made it unusable with bpf_map_redirect.
> Instead of the DPAA FQ Id, initialise the XDP rx queue with the queue number.

Camelia, looks good?

