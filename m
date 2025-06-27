Return-Path: <bpf+bounces-61711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20F9AEABFA
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 02:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1EF175C07
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 00:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C078342AA6;
	Fri, 27 Jun 2025 00:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTI9STuF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCDC219E8;
	Fri, 27 Jun 2025 00:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750985391; cv=none; b=lGx63vOH+5zbJYAg+3OpqBbLRLwchVGSe+K8ZENfrKrtSNkDhI9Z/1Dnr+2QOYrXqQThpa3jE06xA17G1f+f6Hg2tEKoQGItB6nR6RbavNuzqbGu8A4ItKvCYDWB9AZZEFD9ARiKYmOfnXfBa2dn4qXZKe1wFCmNAjvxuV+Z19o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750985391; c=relaxed/simple;
	bh=2mFT3JPm8NqU5vwR61bPE8xlg3A57QqzEU7GhQm5UYI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g4wDkCD6MC2lohuXA+QY/RgvsyVRlXVYL2bbGRaBqyoPM2OEMeekN+kExYTleOU7wbGlThOAeGiJ5+gmhEipa2XrTV3BpXmN7uJq24nmw5uWW6TtBCtvm1hAljEpPUBDlV4PDBcQzi1EqaDtKeT+D+TIRGBBqFr9NDCSv9drZtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTI9STuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCC2C4CEEB;
	Fri, 27 Jun 2025 00:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750985390;
	bh=2mFT3JPm8NqU5vwR61bPE8xlg3A57QqzEU7GhQm5UYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cTI9STuFEmWrxrUScipw1SpUTxIcKU1+qT6CWh0gVIMz4rOoJkysBarsmb4pT80VR
	 YGSaurNmFEJJrQD6gwIF32KNfyZR5uRwAA86wUrCQna45hkkDRAjXoq5cWCRqzZ7aC
	 kBgS7xhraFFzbmFS2+VlE1thlNHsq1aQz2D3PnJ1LpvHRMvxk3akRDHdJo69gg8+wC
	 ewgNJudm1FuRXo65uUU+IE6DM5kxBhKt8MT7a0gJw0EVfUS9MHVTPwl180rRndQ5c3
	 GY/PsbOOFb3eyHYV7R33bdeDvC0piMx6ptBcfCOZuDwKIBkz3MxZkUv/T165mQ4FeH
	 /nTlQjnQrKyJQ==
Date: Thu, 26 Jun 2025 17:49:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 almasrymina@google.com, ilias.apalodimas@linaro.org, harry.yoo@oracle.com,
 hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net,
 john.fastabend@gmail.com, andrew+netdev@lunn.ch, asml.silence@gmail.com,
 toke@redhat.com, tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
 jackmanb@google.com
Subject: Re: [PATCH net-next v7 7/7] netmem: introduce a netmem API,
 virt_to_head_netmem()
Message-ID: <20250626174948.1fa2ce34@kernel.org>
In-Reply-To: <20250625043350.7939-8-byungchul@sk.com>
References: <20250625043350.7939-1-byungchul@sk.com>
	<20250625043350.7939-8-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 13:33:50 +0900 Byungchul Park wrote:
> To eliminate the use of struct page in page pool, the page pool code
> should use netmem descriptor and APIs instead.
> 
> As part of the work, introduce a netmem API to convert a virtual address
> to a head netmem allowing the code to use it rather than the existing
> API, virt_to_head_page() for struct page.

nit: this one needs a caller for the new function to be merged

