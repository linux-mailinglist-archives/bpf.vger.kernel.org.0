Return-Path: <bpf+bounces-28002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2FB8B4336
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 02:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D914D1F24A3D
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 00:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6486FCB;
	Sat, 27 Apr 2024 00:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIbYCRqi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0466FA7;
	Sat, 27 Apr 2024 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714177206; cv=none; b=tp1ildRZkatK3/TV//+9EO4k4D7vXO2Yt6y4RysXsKkjrxI2iWrVwOvVu0gae8eagQYIW7xTg7tHMAcVegLIbgnE252xhF6fLpLjA5LrB8xbYccFiT3y9a/G/aOoawUSVadR5hP+nFrW/iEg0e0vgFdRD2CB62R0Wwg0IJpNzSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714177206; c=relaxed/simple;
	bh=Ki7gmJgdz2tdVE1JXZzVoyeFBjJjdGzsK7eK4zjp7EM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KURWLvl9AR4CJjRvQJ9/sG8ylSR2F6a4ukyYwJ4gyDXs/B9SIZXX+nFhp6n7wcBIz7wgbM1UTsRYR/r5nivWUw9numzoqyQcsQbvskPJwvzZzYa6nzBs1++nlCq1EjvwJBL1oIrz4m8NJYlHU/7PfSbCoTZHxEZnobsroCj0530=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIbYCRqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FABC113CD;
	Sat, 27 Apr 2024 00:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714177206;
	bh=Ki7gmJgdz2tdVE1JXZzVoyeFBjJjdGzsK7eK4zjp7EM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oIbYCRqiQhyXx3hOwmSrQHF59r+Hg3tT8cWfxiDUdh23sFFLUfwm6FcibzkXiUqFR
	 Mwi26Y7Z4MNcbGURTtV3efgEoRHii+CGH/GB+HDuSxD7o+snhpG+Uxspo60XuqHFjX
	 6YkQ/yvqJKn4fhXfRPgIf40nkt6uEx5tgX31w5qKCKRpHSad/oeCTYltLEfciN5OFI
	 9Is+7IliaKoqe1QYfbIHIdidGKO1xgH3Y5mjB1DOm/fWxZUczkMqskx0mT9Re4nzvI
	 cp1YQ9vqsAfRiZvVmwsBTZDj0XXhCQypAApZxivt6ArzJykldwk3qrwsD1qovTdasz
	 Ju6vSrhEgaGiA==
Date: Fri, 26 Apr 2024 17:20:04 -0700
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
Subject: Re: [PATCH net-next v7 7/8] netdev: add queue stats
Message-ID: <20240426172004.60145207@kernel.org>
In-Reply-To: <20240426033928.77778-8-xuanzhuo@linux.alibaba.com>
References: <20240426033928.77778-1-xuanzhuo@linux.alibaba.com>
	<20240426033928.77778-8-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Apr 2024 11:39:27 +0800 Xuan Zhuo wrote:
> These stats are commonly. Support reporting those via netdev-genl queue
> stats.
> 
> name: rx-hw-drops
> name: rx-hw-drop-overruns
> name: rx-csum-unnecessary
> name: rx-csum-none
> name: rx-csum-bad
> name: rx-hw-gro-packets
> name: rx-hw-gro-bytes
> name: rx-hw-gro-wire-packets
> name: rx-hw-gro-wire-bytes
> name: rx-hw-drop-ratelimits
> name: tx-hw-drops
> name: tx-hw-drop-errors
> name: tx-csum-none
> name: tx-needs-csum
> name: tx-hw-gso-packets
> name: tx-hw-gso-bytes
> name: tx-hw-gso-wire-packets
> name: tx-hw-gso-wire-bytes
> name: tx-hw-drop-ratelimits
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

