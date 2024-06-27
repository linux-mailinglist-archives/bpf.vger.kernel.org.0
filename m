Return-Path: <bpf+bounces-33287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BAA91AFF7
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 21:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33861C22778
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 19:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6026019B590;
	Thu, 27 Jun 2024 19:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuvNfyC2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F6F22F1C;
	Thu, 27 Jun 2024 19:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719518315; cv=none; b=OMhqPV9qY0/vWGOufkWKNIh1Wu0lundo/IGjZFQrxR77cUs31EgNQViZy7LDosf9np+ZK+6B4NC1VBN9Ca53oywt5BNUxoLGRjngeUZfaad3MpAaP6oZp2Am5ZswbyTDKjLpUfDm5MvQG1RIEAsRA7jTfvePPuuijkGKxqHHVJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719518315; c=relaxed/simple;
	bh=S4yuJH7snXMiR4H/OcoIVrpDAluEUXsb8UuS8mgZbNo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqq+JO9OQTGcHqr+XKeZ4DIkiwB25mdZxg/R1xy7utf7EhmDZ4auHEPIU/0oQXS42YWId2WmsWF9cQbOc4IFxEeLNr5VnLKJh5ssUUetIh3VqTm7+ZKE8PrIvj72i7BwHeb1uGVgSdTlQygeUPZ30YLLzqxOIl5hg9t9Gk3hXYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuvNfyC2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA1EC2BD10;
	Thu, 27 Jun 2024 19:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719518315;
	bh=S4yuJH7snXMiR4H/OcoIVrpDAluEUXsb8UuS8mgZbNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AuvNfyC27xGCkLMmOnO0yt9tJuiixh4rKugekJ+ThS6gcDQNfPcQRzhmp0F9BK1F0
	 rqj/6KRf6AS8VV3xBsOVApfvH75zl3vTkJOY6j6CkLSSWet95WhHAPM1bxoyU4u9Je
	 8ARUNDWR/yLx4LkCq0rp2htOfOrUc9JNKo58FK6Jq2KozjWgpJtkjiTT3eOkxR8exd
	 WPfrhddRAX5A6FIV7udHiXBsjY/ctUlOHGU2/Sml8EgcBWcgJgykaUgpZnqXmGPDhN
	 +nTNHezL7DnzdHFaQOWZFOLh0eZPtGkRNBgiPfMtUqTO1gTwDd6D8mGTBTroX43mq/
	 i1p17HNpqZEjA==
Date: Thu, 27 Jun 2024 12:58:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Andrew Lunn <andrew@lunn.ch>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Alexander Duyck
 <alexander.duyck@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, <bpf@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH net-next v9 00/13] First try to replace page_frag with
 page_frag_cache
Message-ID: <20240627125834.3007120c@kernel.org>
In-Reply-To: <a051a277-a901-2cdb-72d0-716002593019@huawei.com>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
	<d2601a34-7519-41b6-89c6-b4aad483602b@lunn.ch>
	<a051a277-a901-2cdb-72d0-716002593019@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 19:16:22 +0800 Yunsheng Lin wrote:
> On 2024/6/27 1:12, Andrew Lunn wrote:
> > Silly nitpick, but maybe for the next version you change the Subject:
> > to Tenth try to replace page_frag with page_frag.... :-)  
> 
> Yes, it is somewhat confusing for the 'First try' part.
> I guess I can change it to highlight the effort and commitment behind
> the trying:-)

Sorry to ruin the slightly whimsical mood but if you do change it -
please don't include the version at all. Some automation matches
versions of patch sets together based on the title of the cover letter.

