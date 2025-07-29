Return-Path: <bpf+bounces-64607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E34EB14C04
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 12:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47E9C7AF0D0
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 10:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DFE288CB7;
	Tue, 29 Jul 2025 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZRm++n9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157131D54F7;
	Tue, 29 Jul 2025 10:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753784134; cv=none; b=eeePFRnDLWZHxkAlSNz9Au7hp1xmAEACyaKPEfZ69oVsLHLTFd7Cw9IsqSFpzgDFU0AZAqw6OXb/jehNzCdLzsmMJ8arcxmiFFbcwnHkFyNvrxvw1nwCiPe9nwO90V/tuKMubjH6K6iDwW0z2BqXtzWlhePqxiW3MpVNsBcThXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753784134; c=relaxed/simple;
	bh=L0YRy8jHpIrww9oOg8kDytmNf+kzFY60V1Yp5wcWr1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=DboqiMvOfNP3nWHJwoBs8bix1EtlzpTixEF1f4e25vhubGv0OhZX3CbA3K+hMnoB5s0lmbuO6fL1F+NU6+QuosNoHdKkEeERzmQFfNGT4D+QWyrBtgt2vEsC5lhG3NAzxTr4fIMcJYmZPc9D8z9dG+7ioNGhzL3tiikfOjbqzBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZRm++n9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786CEC4CEEF;
	Tue, 29 Jul 2025 10:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753784133;
	bh=L0YRy8jHpIrww9oOg8kDytmNf+kzFY60V1Yp5wcWr1I=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=dZRm++n9Fi5uX9c5qiSa4x2loGBo+6goCRce5nsaedbyru1d8dM2SMyGi2CXDFvCE
	 0DWrvBNcuEES423fwtoKdlslyJoABgKbTGsiuHam/5PvDYc4Gk5VLKh5wkpMzDmEq/
	 Fqj/6HGJADYch8mYm7bVPwf1TdnegTn0eELBk1dq9zirM6iUt3/EqYtCj1pVZs00tA
	 C52Fdo597Z2C9/Y42E6FJYPm4CFAnTJ4irxXCpVMHakmgx0u9vWBAMQGYXGxrxkX42
	 414PLsirOO2/so/nfBOFDFEGbA/1Ah7XGKSdv+dur/wMFsAXDWg++KgxY0TTSgUhwM
	 EMTc0/0iR9rkA==
Message-ID: <73add9b2-2155-4c4f-92bb-8166138b226b@kernel.org>
Date: Tue, 29 Jul 2025 12:15:23 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: mana: Use page pool fragments for RX buffers
 instead of full pages to improve memory efficiency.
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>, horms@kernel.org,
 kuba@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 longli@microsoft.com, kotaranov@microsoft.com, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
 lorenzo@kernel.org, michal.kubiak@intel.com, ernis@linux.microsoft.com,
 shradhagupta@linux.microsoft.com, shirazsaleem@microsoft.com,
 rosenp@gmail.com, netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, ssengar@linux.microsoft.com,
 dipayanroy@microsoft.com
References: <20250723190706.GA5291@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
Cc: Chris Arges <carges@cloudflare.com>,
 kernel-team <kernel-team@cloudflare.com>, Tariq Toukan <tariqt@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Yunsheng Lin <linyunsheng@huawei.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250723190706.GA5291@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/07/2025 21.07, Dipayaan Roy wrote:
> This patch enhances RX buffer handling in the mana driver by allocating
> pages from a page pool and slicing them into MTU-sized fragments, rather
> than dedicating a full page per packet. This approach is especially
> beneficial on systems with large page sizes like 64KB.
> 
> Key improvements:
> 
> - Proper integration of page pool for RX buffer allocations.
> - MTU-sized buffer slicing to improve memory utilization.
> - Reduce overall per Rx queue memory footprint.
> - Automatic fallback to full-page buffers when:
>     * Jumbo frames are enabled (MTU > PAGE_SIZE / 2).
>     * The XDP path is active, to avoid complexities with fragment reuse.
> - Removal of redundant pre-allocated RX buffers used in scenarios like MTU
>    changes, ensuring consistency in RX buffer allocation.
> 
> Testing on VMs with 64KB pages shows around 200% throughput improvement.
> Memory efficiency is significantly improved due to reduced wastage in page
> allocations. Example: We are now able to fit 35 rx buffers in a single 64kb
> page for MTU size of 1500, instead of 1 rx buffer per page previously.
> 
> Tested:
> 
> - iperf3, iperf2, and nttcp benchmarks.
> - Jumbo frames with MTU 9000.
> - Native XDP programs (XDP_PASS, XDP_DROP, XDP_TX, XDP_REDIRECT) for
>    testing the XDP path in driver.
> - Page leak detection (kmemleak).
> - Driver load/unload, reboot, and stress scenarios.

Chris (Cc) discovered a crash/bug[1] with page pool fragments used from 
the mlx5 driver.
He put together a BPF program that reproduces the issue here:
- [2] https://github.com/arges/xdp-redirector

Can I ask you to test that your driver against this reproducer?


[1] https://lore.kernel.org/all/aIEuZy6fUj_4wtQ6@861G6M3/

--Jesper


