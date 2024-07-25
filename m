Return-Path: <bpf+bounces-35641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE45B93C324
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 15:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613001F226DE
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 13:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0404919B3C0;
	Thu, 25 Jul 2024 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HomBMwQd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA94C8DF;
	Thu, 25 Jul 2024 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721914740; cv=none; b=qnqam0LB+ngKGtHchc4u0Kg8XWHz7xvCcy+O5jq7d+GZrZodTemVJ5dcwANr8d9+Dn09ZN7Kr6g4T1abCckHdRfnNZ2OfWEOmPzOBqJuezFhofHq3CpSFJ1iFR7/ql6PYMZ+dAZS3nhO1wDuo7zMcCdxyC90n8abpflKgFyDcDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721914740; c=relaxed/simple;
	bh=uVSdiMT6CHreGqJ++OAGyCpMp24oqatww/pzSiiDJNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OLlUJJ/5Utgk2rSZXE1C63EmQI5tKBKgpSZU8jg44PxEo7OnEbGZS6m1cA63DOwRoOVvYuVgTnIhySQqIjVw6HTlDo5IHbqsh8T8bWjcQYNtX2MOh15cK4ruo3mrSgrS1lgdPl+btiROLJHWp3e5aw+CxC+z0qfPImeNZ8eNcn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HomBMwQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D55BC116B1;
	Thu, 25 Jul 2024 13:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721914740;
	bh=uVSdiMT6CHreGqJ++OAGyCpMp24oqatww/pzSiiDJNQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HomBMwQdzgpS3TLMUOocYLEafE2MSr26ytBH3GTAP9Pg5RyPimqZpXohZDY6ZHXu1
	 cPYAG9MqoqInYFqR78mganK7FGRNtOGl+XNW+QrAUrnvN//VZLHWU0eP40x/HN/Ez2
	 lnabVjECU3vfYsH6rTQLIqjRVwiz03v0s9WMaegtYN44at9vYnca/l4gCTfyQJ794G
	 maqG0raJfmgjm6YqsKLEcl49UdPI/QjHnFLUys6o1p8NePsQ9pJzDrkUQ09Ez1u1JJ
	 I3C0YJAcMqB92H8BP5ReF/N32DLs1HUpeX3V/7QLx3rve7fDY+kOAEvSWpWmLDv113
	 otFxAEZKjY3dQ==
Date: Thu, 25 Jul 2024 06:38:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
 <magnus.karlsson@intel.com>, <aleksander.lobakin@intel.com>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
 <john.fastabend@gmail.com>, <bpf@vger.kernel.org>, Shannon Nelson
 <shannon.nelson@amd.com>, Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: Re: [PATCH net 6/8] ice: improve updating ice_{t,
 r}x_ring::xsk_pool
Message-ID: <20240725063858.65803c85@kernel.org>
In-Reply-To: <ZqEieHlPdMZcPGXI@boxer>
References: <20240708221416.625850-1-anthony.l.nguyen@intel.com>
	<20240708221416.625850-7-anthony.l.nguyen@intel.com>
	<20240709184524.232b9f57@kernel.org>
	<ZqBAw0AEkieW+y4b@boxer>
	<20240724075742.0e70de49@kernel.org>
	<ZqEieHlPdMZcPGXI@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jul 2024 17:49:12 +0200 Maciej Fijalkowski wrote:
> > So if we are already in the af_xdp handler, and update patch sets pool
> > to NULL - the af_xdp handler will be fine with the pool becoming NULL?
> > I guess it may be fine, it's just quite odd to call the function called
> > _ONCE() multiple times..  
> 
> Update path before NULLing pool will go through rcu grace period, stop
> napis, disable irqs, etc. Running napi won't be exposed to nulled pool in
> such case.

Could you make it clearer what condition the patch is fixing, then?
What can go wrong without this patch?

