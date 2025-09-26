Return-Path: <bpf+bounces-69860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B3FBA4F3D
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 21:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF5756360D
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 19:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E8C2798E8;
	Fri, 26 Sep 2025 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K5uNgAWd"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640C2202976;
	Fri, 26 Sep 2025 19:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758914277; cv=none; b=QlGv7mWhYNhTnePu+Dkd9imxFINrodR5bJ5fw7fLykmECXSuoWtBDMngEFCzCjRW4qzfAkdzWqzyIU+ZD7nLFDQNzAmyIg1dleT9pdy6B0d+ANhaqoLxTbpzI4n36YzAP225rQdmL53WGUE1yp8xUOWmd4CNwLb53TAy7z8Dbns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758914277; c=relaxed/simple;
	bh=EwVtoJZqWLnBrAqj0Ezf+s1cWup/1nT/Eh21YLCibzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swxMC9sz2xXvvGgdHT4MX2E0ksHHDi4H8y784l2FE29Dk59lfkNG5Io2PDp22aUlaiifoNhJBvUXlBgF+U0DF8hRWG3hvMlah6xackhVdnaj3hFL8pPADJy0NzBeDtqLQccsZsRBfapEfv7dwJztl+M3xOEC4mF3aTUl8sCLUso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K5uNgAWd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=yhLPxwL+DQHqKGTW1ubEYzyPgce3kGbV8vk9hn+L5lY=; b=K5uNgAWdwN9hMMfTQv1hxsa30n
	VLs5wbbT9ezEb4qbUhg6z5vLWUbhU7Pdwm48QOEYhV+8p4XQKXQEs+cJSVcsPkO5s+L43+QMUgwgQ
	B3o6Cq4F+78eC97uURqPOdc0y14x4M0G8kBR8/AbflwMdadWJ5QhiL1jubP9yrKTTOOpA5K/UewAg
	RGVTzjzCg9BZMwMYple2oYAu6nfAbTU3Mzx7VTXYJwJEyeLIAlJs9R5i8MvnEceGJcGEoZ2xgVQ89
	ksMAJym7/p2wfU75+a/y3s5k6AXqv6iKgFO2VhpBjbY+5KmgfQ2cWJZr7k9QKdrLe7CnTMoSPFXl9
	5ehk4QeA==;
Received: from [50.53.25.54] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2Dww-00000003suW-2zZW;
	Fri, 26 Sep 2025 19:17:46 +0000
Message-ID: <a5015724-a799-4151-bcc4-000c2c5c7178@infradead.org>
Date: Fri, 26 Sep 2025 12:17:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 mm-new 04/12] mm: thp: add support for BPF based THP
 order selection
To: Usama Arif <usamaarif642@gmail.com>, Yafang Shao <laoar.shao@gmail.com>,
 akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, hannes@cmpxchg.org, gutierrez.asier@huawei-partners.com,
 willy@infradead.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
 21cnbao@gmail.com, shakeel.butt@linux.dev, tj@kernel.org,
 lance.yang@linux.dev
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250926093343.1000-1-laoar.shao@gmail.com>
 <20250926093343.1000-5-laoar.shao@gmail.com>
 <073d5246-6da7-4abb-93d6-38d814daedcc@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <073d5246-6da7-4abb-93d6-38d814daedcc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/26/25 8:13 AM, Usama Arif wrote:
>> +config BPF_THP_GET_ORDER_EXPERIMENTAL
>> +	bool "BPF-based THP order selection (EXPERIMENTAL)"
>> +	depends on TRANSPARENT_HUGEPAGE && BPF_SYSCALL
>> +
>> +	help
>> +	  Enable dynamic THP order selection using BPF programs. This
>> +	  experimental feature allows custom BPF logic to determine optimal
>> +	  transparent hugepage allocation sizes at runtime.
>> +
>> +	  WARNING: This feature is unstable and may change in future kernel
>> +	  versions.
>> +
> I am assuming this series opens up the possibility of additional hooks being added in
> the future. Instead of naming this BPF_THP_GET_ORDER_EXPERIMENTAL, should we
> name it BPF_THP? Otherwise we will end up with 1 Kconfig option per hook, which
> is quite bad.
> 
> Also It would be really nice if we dont put "EXPERIMENTAL" in the name of the defconfig.
> If its decided that its not experimental anymore without any change to the code needed,
> renaming the defconfig will break it for everyone.

s/defconfig/Kconfig symbol/

Otherwise agreed.
Thanks.
-- 
~Randy


