Return-Path: <bpf+bounces-12434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858267CC72E
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 17:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77C61C20BA2
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 15:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3420344483;
	Tue, 17 Oct 2023 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGH3tU2b"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B42A41234;
	Tue, 17 Oct 2023 15:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998C4C433C7;
	Tue, 17 Oct 2023 15:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697555661;
	bh=07bS9mjKy4+gkFRB2bhOqp3nya+agZd4rUe4PVcLCoc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MGH3tU2bF16vI+HxyH3Oww2Ok3BYK7j15PslIN9/EcokOgotGNQTFS4GUB8AAMUjB
	 m0nx9yTVZ7u0dbbYeACVxvOSXgpbCUicqUJXKX+AK+5xhUKELY+PuZPcN1kAHn+AuN
	 g6JfFTl98ZXfTaVOUzuTubsSyZFVGS0syv+aPdRu+P3U/PYAozYoNLWs01qOQhUozE
	 uX76FszfwhtrOhvv5LQtVbxM0jmYbX6MGUdgtolPCHZSh98mIcQSupl1swWH/rHIKe
	 bFXg5nqobDByGUpTwC5Sx6wrIBrdsB0PsBY0Vcpnn+yJWvumOEgYM8wOTTpu8Btz3t
	 25pL5AU2xxJJQ==
Date: Tue, 17 Oct 2023 08:14:19 -0700
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
Message-ID: <20231017081419.5e9d7247@kernel.org>
In-Reply-To: <20231017081303.769e4fbe@kernel.org>
References: <20231013064827.61135-1-linyunsheng@huawei.com>
	<20231016182725.6aa5544f@kernel.org>
	<2059ea42-f5cb-1366-804e-7036fb40cdaa@huawei.com>
	<20231017081303.769e4fbe@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Oct 2023 08:13:03 -0700 Jakub Kicinski wrote:
> I'd just throw a _va (for virtual address) at the end

To be clear I mean:
  page_pool_alloc_va()
  page_pool_dev_alloc_va()
  page_pool_free_va()

