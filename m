Return-Path: <bpf+bounces-60429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E747FAD655D
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 03:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5503AD155
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 01:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553DB1C68A6;
	Thu, 12 Jun 2025 01:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DleGUbuh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FEC770FE;
	Thu, 12 Jun 2025 01:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749693512; cv=none; b=YyVF+s9Fg9qWincxg8wficANkcl6sceX4I7fNZJ8CkLQLULra9S7jAruDa/CokHxE0y1S+7QuVFE1VTc+V9Y8NnZg7j1ZfIXgNt0+0U37iSCbL3mX1GhUBPWkmHdakfZ76VbGKBHspd19992TdSZI7nmwR0gSZQUINr+sXd/waw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749693512; c=relaxed/simple;
	bh=dSkqTNBoCl147QkB605W0wiyyouC0ojBRVw5Y6U9CCI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZfrdhuWSvduSVAB5c8dbi64D+wRftHNogXEM11yussQh8xYB6vKmRLFjx2ROwxyter1PIhFqv870w5ipY0grjpAbHursHGLZB1Cx8rft+PyqMlrmRpK4U3yciDoowy9yZjzNrfbf3EocvvWwU/7iYVgw/fz89T25vO66dMVYGok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DleGUbuh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C274C4CEF0;
	Thu, 12 Jun 2025 01:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749693512;
	bh=dSkqTNBoCl147QkB605W0wiyyouC0ojBRVw5Y6U9CCI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DleGUbuhNKg7GSEBlX2p9TTO/xZ6Be4N1qGOQpfUDWGlvL8R68IrkqW9cXiIOblwn
	 HI7F+Af8mfolbRvLKxHEGIyr9+MAXGqF2WpWLcRlCMRPSbFi2Drsw0CyJ4w8Nfxrxl
	 4/rahSq2YDApVNgYb6TBfXvfEAOHniD28viXlXyCk1PcuI8JSQiyvcCJmmV/NbSZ2V
	 z1B44IJMZwrjRuAnfLu5FnJdn4+liUoF+KMbt4aZtnlm0ZUTnDrShT6McNwP+IiexX
	 yAVq6W5JLDtMCDKA9sdxwXhncPCESTQxiLtjD/pw7LBfXmUlRc7UTYdfdaQnYHazX9
	 dSadFD6F7xMEg==
Date: Wed, 11 Jun 2025 18:58:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: David Howells <dhowells@redhat.com>, Byungchul Park <byungchul@sk.com>,
 willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel_team@skhynix.com, ilias.apalodimas@linaro.org,
 harry.yoo@oracle.com, hawk@kernel.org, akpm@linux-foundation.org,
 davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch,
 asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Subject: Re: [PATCH net-next 1/9] netmem: introduce struct netmem_desc
 mirroring struct page
Message-ID: <20250611185830.47357d3d@kernel.org>
In-Reply-To: <CAHS8izP2Y4FMfHyTU6u5NRT45raM9isXJZPY4LMC8c03dGUPJQ@mail.gmail.com>
References: <20250609043225.77229-1-byungchul@sk.com>
	<20250609043225.77229-2-byungchul@sk.com>
	<20250609123255.18f14000@kernel.org>
	<CAHS8izP2Y4FMfHyTU6u5NRT45raM9isXJZPY4LMC8c03dGUPJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Jun 2025 13:53:51 -0700 Mina Almasry wrote:
> I think yes it would be good to get a reviewed-by or acked-by from
> Matthew or David to show that this approach is in line with their
> plans?

Yes, most definitely!

