Return-Path: <bpf+bounces-17653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B3A810C96
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 09:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3A1281BDC
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 08:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5841EB2C;
	Wed, 13 Dec 2023 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vO3EpuSM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54FB2F44;
	Wed, 13 Dec 2023 08:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B13C433C7;
	Wed, 13 Dec 2023 08:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702456752;
	bh=rqWbtF/NxYXvBPFQFOh7+fSc22EYlFtkkZ1q8+1HHpg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vO3EpuSMPUKdH6YSXnpdHQY1/OD9Sz13+qESRvlFfyKShrJEzhy9vLcbZXJW25X9Y
	 ANHpdO0bL7jiRUR1oxUXpHZrjQelCzLZ/A8wOCkOY64dR41I+4zLNUnNIuajnYt+JN
	 CE3161OLG2rEUZODsfHcv3JOKzHFsxcc66PZuUy9R+gSotbaJtC+83ygUTfWyslraZ
	 lTZvLg3/5ZsVFGv1PUUqHxDR41U+WEoB9j9ZQ4zWx2xtw7b7womJ4Xcjx9OPDdH4ww
	 CdMTIk9R4jrphLTiYJP2Vr7mJ1cLZ+WmGcepVDXxDrDAnt1g0Bh5z6L4mWIOpBjD2H
	 V4gCglzWoYYGw==
Message-ID: <78c0072a-c084-4588-b973-ad4f80047914@kernel.org>
Date: Wed, 13 Dec 2023 09:39:08 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net, xdp: correct grammar
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
References: <20231213043735.30208-1-rdunlap@infradead.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231213043735.30208-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/12/2023 05.37, Randy Dunlap wrote:
> Use the correct verb form in 2 places.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: bpf@vger.kernel.org
> ---
>   include/net/xdp.h |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

> diff -- a/include/net/xdp.h b/include/net/xdp.h
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -16,7 +16,7 @@
>    *
>    * The XDP RX-queue info (xdp_rxq_info) is associated with the driver
>    * level RX-ring queues.  It is information that is specific to how
> - * the driver have configured a given RX-ring queue.
> + * the driver has configured a given RX-ring queue.
>    *
>    * Each xdp_buff frame received in the driver carries a (pointer)
>    * reference to this xdp_rxq_info structure.  This provides the XDP
> @@ -32,7 +32,7 @@
>    * The struct is not directly tied to the XDP prog.  A new XDP prog
>    * can be attached as long as it doesn't change the underlying
>    * RX-ring.  If the RX-ring does change significantly, the NIC driver
> - * naturally need to stop the RX-ring before purging and reallocating
> + * naturally needs to stop the RX-ring before purging and reallocating
>    * memory.  In that process the driver MUST call unregister (which
>    * also applies for driver shutdown and unload).  The register API is
>    * also mandatory during RX-ring setup.

