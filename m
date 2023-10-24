Return-Path: <bpf+bounces-13135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2785F7D5458
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 16:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3937B21015
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 14:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C4026285;
	Tue, 24 Oct 2023 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="UBaqi/2f"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B4730FB7
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 14:50:47 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03EAE8
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 07:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ynobowjWjM9urmG5Mx4oKRbqpVi5qzmiiD7NutdinS8=; b=UBaqi/2fQgWWHaCjAVaQpLGMAC
	j+x9XDu6z85o04+AroBvaLKsrXrm99xiXOIuqMhxZbnHPdGWMrcSCpYRP5zcn0lnOMb/+tv9hfVwM
	dkACMLgLac96GfByueWAaTvYW52BoJbAFaftqcKbRsn3307rGNs5m3VIbkl0bgmMcuWW63NH820/N
	9Uis71KGbyxnjGDwXw2MMUV/omfQ3SOtRW64kJlYCk1T/w0doOjOoTNF3gHrKif1CRgZcsmRqBkGO
	bAxf6daRRAo5eDjocFY0x7zjW7IlZh83XZS1AZ7fe0v8rddkrfY4dWCYFZpVi+o7dMiJJUyhNHieU
	P4tZqXHQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvIjx-000ABQ-EH; Tue, 24 Oct 2023 16:50:41 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvIjx-0007nA-25; Tue, 24 Oct 2023 16:50:41 +0200
Subject: Re: [PATCH v4 bpf-next 5/7] bpf: Add arch_bpf_trampoline_size()
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@kernel.org,
 kernel-team@meta.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 bjorn@kernel.org, xukuohai@huawei.com, pulehui@huawei.com
References: <20231018180336.1696131-1-song@kernel.org>
 <20231018180336.1696131-6-song@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <11402dc3-ea76-8d7a-e5c2-83401aeba4ac@iogearbox.net>
Date: Tue, 24 Oct 2023 16:50:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231018180336.1696131-6-song@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27071/Tue Oct 24 09:43:50 2023)

On 10/18/23 8:03 PM, Song Liu wrote:
> This helper will be used to calculate the size of the trampoline before
> allocating the memory.
> 
> arch_prepare_bpf_trampoline() for arm64 and riscv64 can use
> arch_bpf_trampoline_size() to check the trampoline fits in the image.
> 
> OTOH, arch_prepare_bpf_trampoline() for s390 has to call the JIT process
> twice, so it cannot use arch_bpf_trampoline_size().
> 
> Signed-off-by: Song Liu <song@kernel.org>
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>  # on s390x
> ---
>   arch/arm64/net/bpf_jit_comp.c   | 56 ++++++++++++++++++++++++---------
>   arch/riscv/net/bpf_jit_comp64.c | 22 ++++++++++---
>   arch/s390/net/bpf_jit_comp.c    | 56 ++++++++++++++++++++-------------
>   arch/x86/net/bpf_jit_comp.c     | 37 +++++++++++++++++++---
>   include/linux/bpf.h             |  2 ++
>   kernel/bpf/trampoline.c         |  6 ++++
>   6 files changed, 133 insertions(+), 46 deletions(-)

Readding Bjorn, Xu and Pu to Cc given they reviewed prior versions, would be nice
to get some more arch Acks in.

Thanks,
Daniel

