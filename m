Return-Path: <bpf+bounces-48512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A1BA08522
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 03:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2041C3A7FE7
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 02:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C81F1487CD;
	Fri, 10 Jan 2025 02:06:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B3618027
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 02:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736474812; cv=none; b=gfKCVGabWiY/dwe/+Kja+TcgYU9kkSritT18KTK6lrEpXUT5SEojb7223gSa3Nk3QSe4NXT6n96veUPWlU1QTcw6J6+nGXKcKmz1EC7jrN50faeqPNH/SnNenz+ZVuDIf5v6woWVn9v7YYInrxSPzz8O4un2j3sjrZuJADhKxqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736474812; c=relaxed/simple;
	bh=c+BNZKaKS26w52gjJR4X2vNUxkmfs60BNAmVMt3XgmM=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=U82PbvC4unQVctc1WuVBgHDdNnV4+I7QgD8Rrp4zMwPXv/HsjNGj88xNFpH7ceexV4TI0YtnjkMB/Dym4Y1lc/UD2RXPsmD0ZBk46IEjjbRIg3IHBNEEO7omCm0OcqgMWdtdaVGY7erjVzd/lyLUSJVSpI43Z/tnacBQlr31Nsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YTlLZ6ntKz1ky8N;
	Fri, 10 Jan 2025 10:03:34 +0800 (CST)
Received: from kwepemh200010.china.huawei.com (unknown [7.202.181.119])
	by mail.maildlp.com (Postfix) with ESMTPS id 4168E1400CA;
	Fri, 10 Jan 2025 10:06:38 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 kwepemh200010.china.huawei.com (7.202.181.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 10 Jan 2025 10:06:37 +0800
Subject: Re: status of BPF in conjunction with PREEMPT_RT for the 6.6 kernel?
To: Chris Friesen <chris.friesen@windriver.com>, <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
References: <48d18ecf-41eb-4025-9bec-1dc606f343c3@windriver.com>
From: Hou Tao <houtao1@huawei.com>
Message-ID: <d39cfb84-7b0e-e73b-f2ba-bee32e883a48@huawei.com>
Date: Fri, 10 Jan 2025 10:06:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <48d18ecf-41eb-4025-9bec-1dc606f343c3@windriver.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh200010.china.huawei.com (7.202.181.119)

Hi,

On 1/10/2025 6:21 AM, Chris Friesen wrote:
> Hi,
>
> Back in 2019 there were some concerns raised
> (https://lwn.net/ml/bpf/20191017090500.ienqyium2phkxpdo@linutronix.de/#t)
> around using BPF in conjunction with PREEMPT_RT.
>
> In the context of the 6.6 kernel and the corresponding PREEMPT_RT
> patchset, are those concerns still valid or have they been sorted out?
>
> Please CC me on replies, I'm not subscribed to the list.

Do you have any use case for BPF + PREEMPT_RT ?  I am not a RT expert,
however, In my understanding, BPF + PREEMPT_RT in the vanilla kernel
basically can work togerther basically. The memory allocation concern is
partially resolved and there is still undergoing effort trying to
resolve it [1]. The up_read_non_owner problem has been avoided
explicitly and the non-preemptible context for bpf prog has also been
fixed. Although the running of test_maps and test_progs under PREEMPT_RT
report some problems, I think these problem could be fixed. As for v6.6,
I think it may be OK for BPF + PREEMPT_RT case.

[1]:
https://lore.kernel.org/bpf/20241210023936.46871-1-alexei.starovoitov@gmail.com/
> Thanks,
> Chris Friesen
>
>
> .


