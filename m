Return-Path: <bpf+bounces-7141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A37771C5C
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 10:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7052D1C20A33
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 08:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3A95C9B;
	Mon,  7 Aug 2023 08:35:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD21C210C;
	Mon,  7 Aug 2023 08:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E921C433CC;
	Mon,  7 Aug 2023 08:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691397312;
	bh=dQQYVCV202V1fkp+H9UYGcqK9NudKTkhkMb/AaQNtto=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=AHBpwm2yXk/zDdi/IuT5WptLqTuta3FroC6SuurxaOy3UnmeMYJzT2/FD+N7S1K99
	 VhT+tOE4K5IzfA7Fc+lS6dkK72uTWhw9BtgS+9LVnJRUeUxGgPNTMpySIt0JLqlEkV
	 CdHA10dcbgLn97pcYK+cxXKYzI2Ymw5wpMempKkf5GT8ZwG7JJ1iZDVlsBHVt011k1
	 Gy6JhhtpXZkdXr6F+4I6nCoRusAMES8rB2YZYQp3nVyWmkEoEDitjcx+MASrmXOVgu
	 g5mtLIEZOKj9z38imh4oKyzKDQdX+O5vjGrnlWeDICBFLN2uxAMHMj17h9WWWIHlJn
	 q//0thIlNzCyA==
Message-ID: <6f69bd92-a063-1934-2bd8-42a5950254a7@kernel.org>
Date: Mon, 7 Aug 2023 10:35:05 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: decui@microsoft.com, kys@microsoft.com, paulros@microsoft.com,
 olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net,
 wei.liu@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 leon@kernel.org, longli@microsoft.com, ssengar@linux.microsoft.com,
 linux-rdma@vger.kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 bpf@vger.kernel.org, ast@kernel.org, sharmaajay@microsoft.com,
 hawk@kernel.org, tglx@linutronix.de, shradhagupta@linux.microsoft.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6,net-next] net: mana: Add page pool for RX buffers
Content-Language: en-US
To: Haiyang Zhang <haiyangz@microsoft.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org
References: <1691181233-25286-1-git-send-email-haiyangz@microsoft.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <1691181233-25286-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/08/2023 22.33, Haiyang Zhang wrote:
> Add page pool for RX buffers for faster buffer cycle and reduce CPU
> usage.
> 
> The standard page pool API is used.
> 
> With iperf and 128 threads test, this patch improved the throughput
> by 12-15%, and decreased the IRQ associated CPU's usage from 99-100% to
> 10-50%.
> 
> Signed-off-by: Haiyang Zhang<haiyangz@microsoft.com>
> Reviewed-by: Jesse Brandeburg<jesse.brandeburg@intel.com>

For the record I want to provide my ACK as page_pool maintainer:

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

As patch was applied Sunday, my ACK will not reach the git tree
  https://git.kernel.org/netdev/net-next/c/b1d13f7a3b53

--Jesper

