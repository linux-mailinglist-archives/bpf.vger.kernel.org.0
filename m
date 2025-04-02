Return-Path: <bpf+bounces-55147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547DEA78DF6
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 14:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61BC53B173F
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 12:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EB8238D42;
	Wed,  2 Apr 2025 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7Om3u2q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB252356DF;
	Wed,  2 Apr 2025 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596023; cv=none; b=JiS+CNvDkZDrhIaU0jOjHCCyUymkPmjOdHqJ9gW0akGs+AROlQEkCLNi2nZUt6APXNhhdv7yVMKIMhn96XB2dVDhGZZTAeZRtKexizcAExtMtIuxhpASvs4Vgx7gabJDZlUdcH0ekc25ZlXD9xYC8BIyy3kFTBYc7yT1DYdHOeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596023; c=relaxed/simple;
	bh=O7oesmgNvnpeMIG+T0CoO9IemBq179dATBp4McwmeYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KEihw0jJGM0RPGgG3zukZVDF2IetefjFU0tNUtFbaf2+ae1fwE+sVDnQJmssDO4lAeoGmlqaDEzm+fYTbcRx9fQEGffYiuhm/1GJ/ryCZoybq6bJfL25JfDLNFT9rqY3Io9WLNJwsKC43elCzomR+Hg9j8mIyiTnPcVq/RXPy6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7Om3u2q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D08C4CEDD;
	Wed,  2 Apr 2025 12:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743596022;
	bh=O7oesmgNvnpeMIG+T0CoO9IemBq179dATBp4McwmeYY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q7Om3u2qOXHzmCKvzl9SNmhsvqIglkLX1PkahL07EHm7zSQpi6dW1zTwhYqk8ZHmM
	 x6DNred9+HEQYWmXIYOHr57SFmRQtzrdjLXlJc2Y3ZF7XTyZzR9fQ8Qr0nVyjZSudi
	 fIYtm0cRR3ac/1lGXMvT4+Dshb55UoAuLZCuQMD5IN6CoQhxVkZdoasZNNKrhhVVsB
	 ZHIGSvVXXRDIeNPo9ID0pIV9QF7ileqKyQh6PgZR+QkfI2Fl0tDeLupw7WGa1hpfs4
	 vYMgEh7qRm0ABFLDbep4yM9YdaC4sztiHoTMtcO+9omJ9MSyuODqGXQk54fyvoG0BV
	 m8KO/ji5p/lVA==
Message-ID: <a6f3b75c-2781-4d77-a5fb-ebf5d4a36c4a@kernel.org>
Date: Wed, 2 Apr 2025 15:13:35 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] net: ti: icssg-prueth: Fix kernel warning
 while bringing down network interface
To: Meghana Malladi <m-malladi@ti.com>, dan.carpenter@linaro.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 namcao@linutronix.de, javier.carrasco.cruz@gmail.com, diogo.ivo@siemens.com,
 horms@kernel.org, jacob.e.keller@intel.com, john.fastabend@gmail.com,
 hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>, danishanwar@ti.com
References: <20250328102403.2626974-1-m-malladi@ti.com>
 <20250328102403.2626974-2-m-malladi@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20250328102403.2626974-2-m-malladi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28/03/2025 12:24, Meghana Malladi wrote:
> During network interface initialization, the NIC driver needs to register
> its Rx queue with the XDP, to ensure the incoming XDP buffer carries a
> pointer reference to this info and is stored inside xdp_rxq_info.
> 
> While this struct isn't tied to XDP prog, if there are any changes in
> Rx queue, the NIC driver needs to stop the Rx queue by unregistering
> with XDP before purging and reallocating memory. Drop page_pool destroy
> during Rx channel reset as this is already handled by XDP during
> xdp_rxq_info_unreg (Rx queue unregister), failing to do will cause the
> following warning:
> 
> warning logs: https://gist.github.com/MeghanaMalladiTI/eb627e5dc8de24e42d7d46572c13e576
> 
> Fixes: 46eeb90f03e0 ("net: ti: icssg-prueth: Use page_pool API for RX buffer allocation")
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Roger Quadros <rogerq@kernel.org>


