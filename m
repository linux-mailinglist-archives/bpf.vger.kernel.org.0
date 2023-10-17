Return-Path: <bpf+bounces-12433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB377CC729
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 17:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A47D7B2111A
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 15:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31D444482;
	Tue, 17 Oct 2023 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXlNQiby"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1908943A95;
	Tue, 17 Oct 2023 15:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED79C433C8;
	Tue, 17 Oct 2023 15:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697555584;
	bh=JJc9uTY6VESHKtR5Rwh2zpqzChvYnI7TdKWdn6WPs14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MXlNQibyA6fZX59FsDqAImWdfJ2ih+TXCnscodf3g8+R9omBLcX/s62+o+7WAuzU/
	 FICPLw0vFyVsL3tAaDzuf5HsyiBSc9j6Q5YgaDcyLt0VKOzF51lZpt5DnQOrIutWdA
	 eotRndq9Lp3W+l0OUaWmHbOzcqWuZYUfNBBsQ05hbxUsYEwnKAzvQP0/2NDTc+k695
	 xShDcSzo2Bp+t8bIfyYhUxBLd4lbsbIuT1RTmCcDkVO6A++OL4IPUZ6q97npihxVXq
	 4kDcI2SMPSH6qdwZkopC/EGxghJNwo8hoUZ5vG4JfANfyvey4SUcj/kHOSxIPOLSUj
	 Wt2lTDHetvlrA==
Date: Tue, 17 Oct 2023 08:13:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, <bpf@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, Alexander Duyck
 <alexander.duyck@gmail.com>
Subject: Re: [PATCH net-next v11 0/6] introduce page_pool_alloc() related
 API
Message-ID: <20231017081303.769e4fbe@kernel.org>
In-Reply-To: <2059ea42-f5cb-1366-804e-7036fb40cdaa@huawei.com>
References: <20231013064827.61135-1-linyunsheng@huawei.com>
	<20231016182725.6aa5544f@kernel.org>
	<2059ea42-f5cb-1366-804e-7036fb40cdaa@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Oct 2023 15:56:48 +0800 Yunsheng Lin wrote:
> > And I can't figure out now what the "cache" in the name is referring to.
> > Looks like these are just convenience wrappers which return VA instead
> > of struct page..  
> 
> Yes, it is corresponding to some API like napi_alloc_frag() returning va
> instead of 'struct page' mentioned in patch 5.
> 
> Anyway, naming is hard, any suggestion for a better naming is always
> welcomed:)

I'd just throw a _va (for virtual address) at the end. And not really
mention it in the documentation. Plus the kdoc of the function should
say that this is just a thin wrapper around other page pool APIs, and
it's safe to mix it with other page pool APIs?

