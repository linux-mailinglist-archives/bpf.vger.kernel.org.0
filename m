Return-Path: <bpf+bounces-60701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E88ADA9CE
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 09:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2B7C1888FB7
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 07:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A2920E717;
	Mon, 16 Jun 2025 07:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZB2rMIak"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A8620E00B;
	Mon, 16 Jun 2025 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750059926; cv=none; b=XzzLxUxYl/vGM3K1MFcjfro+WqUQJdEOa30xz/5NB8Ih1QnqhHCbSa262Zshdm05XlCIe3TAL8GChH2FSaw+NXbtvb1jroDc5UgSj2LxygjvbeK9dMMN2fLcEHRa/G17C14k3vOZPPdFAGt87x6wwiPr9ajYKXcpdoVB1JyvoZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750059926; c=relaxed/simple;
	bh=vHO6QCfc9duf+IwovLForDeOanm+zkghY5l8I2+xikM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4qCtk36sP+raoZsy2v3aTSJrJ02VvW44imP3KM6T5S2wcbTcEtuuBlCqF2kz+tOng+2PS7WgoGiIDNFxGjepqX9HcxgWaEsBK7wXzWtDFFfcoNkP5Bd1g22ZkaNbq2JybmT9uDbSUmL53Lcznc3iLychNsD61R1tiN9Q+s73f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZB2rMIak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAA0C4CEEA;
	Mon, 16 Jun 2025 07:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750059925;
	bh=vHO6QCfc9duf+IwovLForDeOanm+zkghY5l8I2+xikM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZB2rMIakqJgfKo62/tAMf5DkeFCIxlGjrc80HffKBy2eCBOf5Bxwr0xOBX4y7qQcK
	 ij67s4Q8l1+4LABueLyoPaflLEtqi6kx+t8EuEgSdGXRcrq9fBHZ+85zLGRCKiCQRQ
	 UeR4Ot73joKTCuresfP5hqsYw5RErjkWSKeck0O7GhRyv5lU2Aj03DW3DPG22VcaG/
	 ScjieMek8whWcLEevdAfHWVV6SQCKSF7a9xLzMAj+dayftBm2NkAsjTBGCwsTMuz6P
	 g/QbBzKyvoPDVn9UsfryoY1tK8YDYrB7xVMqtsSOyaFpUpwi3fHnXEfFBAwIP3vVEe
	 LTIOR9zH1ha4A==
Message-ID: <d90d71bd-229e-404a-8aeb-7ca7efaafad0@kernel.org>
Date: Mon, 16 Jun 2025 09:45:15 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/9] Split netmem from struct page
To: Mina Almasry <almasrymina@google.com>,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, ilias.apalodimas@linaro.org,
 harry.yoo@oracle.com, akpm@linux-foundation.org, davem@davemloft.net,
 john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com,
 tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 vishal.moola@gmail.com
References: <20250609043225.77229-1-byungchul@sk.com>
 <8c7c1039-5b9c-4060-8292-87047dfd9845@gmail.com>
 <CAHS8izNiFA71bbLd1fq3sFh1CuC5Zh19f53XMPYk2Dj8iOfkOA@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAHS8izNiFA71bbLd1fq3sFh1CuC5Zh19f53XMPYk2Dj8iOfkOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/06/2025 22.48, Mina Almasry wrote:
> On Wed, Jun 11, 2025 at 7:24 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 6/9/25 05:32, Byungchul Park wrote:
>>> Hi all,
>>>
>>> In this version, I'm posting non-controversial patches first.  I will
>>> post the rest more carefully later.  In this version, no update has been
>>> applied except excluding some patches from the previous version.  See
>>> the changes below.
>>
>> fwiw, I tried it with net_iov (zcrx), it didn't blow up during a
>> short test.
>>
> 
> FWIW, I ran my devmem TCP tests, and pp benchmark regression tests.
> Both look good to me. For the pp benchmark:

Thanks for verifying micro-benchmarks wasn't affected by this change.

> Before:
> 
> Fast path results:
> no-softirq-page_pool01 Per elem: 11 cycles(tsc) 4.337 ns
> 
> ptr_ring results:
> no-softirq-page_pool02 Per elem: 529 cycles(tsc) 196.073 ns

I'm surprised that ptr_ring return is this expensive on your system Mina.
I'll reply on the [v4] benchmark import patch, as this needs some more 
investigations.

[v4] 
https://lore.kernel.org/all/20250615205914.835368-1-almasrymina@google.com/

> slow path results:
> no-softirq-page_pool03 Per elem: 554 cycles(tsc) 205.195 ns
> 
> After:
> 
> Fast path results:
> no-softirq-page_pool01 Per elem: 11 cycles(tsc) 4.401 ns
> 
> ptr_ring results:
> no-softirq-page_pool02 Per elem: 530 cycles(tsc) 196.443 ns
> 
> slow path results:
> no-softirq-page_pool03 Per elem: 551 cycles(tsc) 204.287 ns
> 
> 
> 

