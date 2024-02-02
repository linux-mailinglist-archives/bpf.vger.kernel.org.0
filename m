Return-Path: <bpf+bounces-21074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1589847672
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 18:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805021F22533
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 17:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9245D14E2C9;
	Fri,  2 Feb 2024 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XT5XuxCa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E5D14AD3E;
	Fri,  2 Feb 2024 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895735; cv=none; b=MUL3Jah+/iy/m15OolN+frvsQ70DXVayROFAQnIE0+Vg2dLXAKBO0Bx8iOotlu4Qn/Ce0onBEwD48I7kjVNckbicJoanq1lCJMdrPv1wH8FLjDhu81tNwbhteDYlB7yWlRmY5cmSDb5WRIOgWzQWygVQF6GEuIYyq27isRRqZ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895735; c=relaxed/simple;
	bh=UEGbiqyOGWOHIeI3GpSUM+EsevycrF3034xdOX/lang=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z0s9qcEa0sHsrOnIYzCjb1XCc8RbXmi0r9smP/Hcr/tzKxQAP+hMMou4vlAKtNhZqHh3z6afo7pYzfCvHJlkW2i5/JROa919vNSAN7l3E2yDacypdWFh/DLg54qze0Fw6ah+1/XJVkWIsxDYb5kzUIx3JufYnZ6iM7q0wbbXu3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XT5XuxCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102D5C433C7;
	Fri,  2 Feb 2024 17:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706895734;
	bh=UEGbiqyOGWOHIeI3GpSUM+EsevycrF3034xdOX/lang=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XT5XuxCaIX9dtL8BjUAOnS6tHB1RsEWTWtT6ai0gTBFiMwC7vWC2RuQH8QVw9KPfH
	 1sCGgk1pdHlwLWxdvz9OG7eUjSCJlq3rg8XgfX0iQZgiTnPnwhBqYFMr+zKyie17I2
	 eHRfkiCzqgp/1gfrxRIMtofcamDNMBiWyQu0BkQvWQ6CeMB+L7wyLtc0tBBm1Ds1EO
	 4u6NRbsBPuRNDaKC7VMtszUMBLhvj8E3uT0+ss7pKz7IrlgKAHJYFC9pJ4laYRcBDC
	 NAjb2Ypnv+zYTbwSOXq1FZGXNJTKuDsBBGiL/YYy6b393BQq+o6VAAVA4ZfIG6ZSwe
	 M6Tt6aS+hUMfQ==
Message-ID: <cb1785ed-6d9d-44fe-9a95-bcc38bc96727@kernel.org>
Date: Fri, 2 Feb 2024 18:42:10 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 3/4] xdp: add multi-buff support for xdp
 running in generic mode
Content-Language: en-US
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, bpf@vger.kernel.org,
 toke@redhat.com, willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 sdf@google.com, ilias.apalodimas@linaro.org, linyunsheng@huawei.com
References: <cover.1706861261.git.lorenzo@kernel.org>
 <35486ef21c3a74931e81b5e9c604734781ca1213.1706861261.git.lorenzo@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <35486ef21c3a74931e81b5e9c604734781ca1213.1706861261.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/02/2024 09.12, Lorenzo Bianconi wrote:
> Similar to native xdp, do not always linearize the skb in
> netif_receive_generic_xdp routine but create a non-linear xdp_buff to be
> processed by the eBPF program. This allow to add multi-buffer support
> for xdp running in generic mode.
> 
> Signed-off-by: Lorenzo Bianconi<lorenzo@kernel.org>
> ---
>   include/linux/skbuff.h |  2 +
>   net/core/dev.c         | 70 +++++++++++++++++++++++---------
>   net/core/skbuff.c      | 91 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 144 insertions(+), 19 deletions(-)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

