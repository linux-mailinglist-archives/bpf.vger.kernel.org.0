Return-Path: <bpf+bounces-21073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0512C847653
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 18:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98BA41F27C3E
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 17:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3838014A4E9;
	Fri,  2 Feb 2024 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmZUxUNN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3512145B2D;
	Fri,  2 Feb 2024 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895556; cv=none; b=IlLL0exETQD9qUJjy3EJRtvjYaR79DSWfiULhyDWxJYSLpdts5NQJh4F4ANIyFlt2KSsY96vNMAN2PWPl+UTJBAEeldGf66aZJmq43IrYrzG8kyyRAzhe0o0drXKutkz+R1nAQEhv1+g7xEojFW/NfWB8Pizi9TV8v+nCQ9Ceyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895556; c=relaxed/simple;
	bh=UGJAJ1IN3ZTMG/eqmF/Fgku/fPVq6CzcbCAkNY6+BeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KgkeovF+0+dreSyuvQYFtM0AFslHKjETzxslTs3O4MaFNBMFOcCdGC48aPMfKkRmLtz22tbMtuP9bE6cP5ihnGQ66xXmi7RgGY39XCwd/lZg4SWf3qWd4ZwMtfFbRTPHyhQ60c7X4lz0DMQZEJTz/kEsiMlaupxQYmLe8NuRVKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmZUxUNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CC5C433F1;
	Fri,  2 Feb 2024 17:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706895556;
	bh=UGJAJ1IN3ZTMG/eqmF/Fgku/fPVq6CzcbCAkNY6+BeU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MmZUxUNNxJZjKiDu+CCmoLGLLLrBh8UfcTaHGco6Xb4G0E3CMSQyOcB3/F+PgdYft
	 ZsGB8rPHhIfvwz4a/JD6+XWuiBS+qVZg3qCBPibxmr9PcVZnwQk4eEQ/lD6awyPSfX
	 dXlkTXWTZqdgFpaljgbooU8KelT6QiqDSbsOTcMSbI7MiuHCR3J44XI8FVPoOCFSSh
	 HkNMbqCbuPSxXo6sIM7Vk2Y9oHNLzbtjr55+x6HJMmfyLAywhzgqFal74auv47evEV
	 DzuwsqbFJ/uR7wSqhXAuVQP8SRryHdpGuUbf8NMQF59l062eq4YnOSGrFmL6sSCuPV
	 OzyxHZdsrZHlQ==
Message-ID: <c9f2946b-2075-4006-86a6-1e7852dd6cc6@kernel.org>
Date: Fri, 2 Feb 2024 18:39:11 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 4/4] veth: rely on skb_cow_data_for_xdp
 utility routine
Content-Language: en-US
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, bpf@vger.kernel.org,
 toke@redhat.com, willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 sdf@google.com, ilias.apalodimas@linaro.org, linyunsheng@huawei.com
References: <cover.1706861261.git.lorenzo@kernel.org>
 <a9e7f6c9c3f14b43e9f963d767d396f0eb611c5f.1706861261.git.lorenzo@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <a9e7f6c9c3f14b43e9f963d767d396f0eb611c5f.1706861261.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/02/2024 09.12, Lorenzo Bianconi wrote:
> Rely on skb_cow_data_for_xdp utility routine and remove duplicated
> code.
> 
> Signed-off-by: Lorenzo Bianconi<lorenzo@kernel.org>
> ---
>   drivers/net/veth.c | 79 +++-------------------------------------------
>   1 file changed, 5 insertions(+), 74 deletions(-)

Nice to see removal of this duplicated code!

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

