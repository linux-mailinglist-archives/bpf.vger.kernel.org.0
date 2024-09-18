Return-Path: <bpf+bounces-40051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA4497B6B0
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 04:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4B80B2490A
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 02:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8762913792B;
	Wed, 18 Sep 2024 02:05:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DE319A;
	Wed, 18 Sep 2024 02:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726625157; cv=none; b=ljmJFww6IZt2rQt7oUIeHu9iuB792ukgPNgQX0LNj/dHVwxmxef6Amuw2dj+nA79JMNoc51fOfJZEBfOaDgVb1dkJQp3TMUQm26LhMbuF1Y2bsjKzxur/05gs3ltBujaqwTkOW9WIShpI4O6BbLumExvkyg3LggqRxMoOVoVtAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726625157; c=relaxed/simple;
	bh=4+dJGOUZsRjxMOAMGxk+Fyd3gqVY6VFGfS7+fKcuSCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rGgCDGqnyC1seuwcrfQUJgDJ9mWr4lMYq9EjOstXZYRUfJKvMbcMDuCefLgpN7xN0YUUd1ohSqn3fw152opcSpgqHQ+ybBZJowuANrxz3H9Lq0n5/a9uVO6GIZgy+AFZS73Xahb0nVg1hVH07lBwbLJ8S3mqUr5RC923w6+36n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4X7hn43vGqzFqnF;
	Wed, 18 Sep 2024 10:05:12 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 048951402E0;
	Wed, 18 Sep 2024 10:05:26 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 18 Sep 2024 10:05:25 +0800
Message-ID: <c5765c03-a584-3527-8ca4-54b646f49433@huawei.com>
Date: Wed, 18 Sep 2024 10:05:24 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 0/2] uprobes: Improve scalability by reducing the
 contention on siglock
To: Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <bpf@vger.kernel.org>, Andrii Nakryiko
	<andrii@kernel.org>, Oleg Nesterov <oleg@redhat.com>
References: <20240815014629.2685155-1-liaochang1@huawei.com>
 <cfa88a34-617b-9a24-a648-55262a4e8a4c@huawei.com>
 <20240915151803.GD27726@redhat.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20240915151803.GD27726@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200013.china.huawei.com (7.221.188.133)

Hi, Peter and Masami

I look forward to your inputs on these series. Andrii has proven they are
hepful for uprobe scalability.

Thanks.

在 2024/9/15 23:18, Oleg Nesterov 写道:
> Hi Liao,
> 
> On 09/14, Liao, Chang wrote:
>>
>> Hi, Oleg
>>
>> Kindly ping.
>>
>> This series have been pending for a month. Is thre any issue I overlook?
> 
> Well, I have already acked both patches.
> 
> Please resend them to Peter/Masami, with my acks included.
> 
> Oleg.
> 
> 

-- 
BR
Liao, Chang

