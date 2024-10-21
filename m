Return-Path: <bpf+bounces-42610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 904879A67A4
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 14:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE361C21F58
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 12:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297C21EE029;
	Mon, 21 Oct 2024 12:09:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1291DC19E;
	Mon, 21 Oct 2024 12:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729512551; cv=none; b=DGkTZ8xoDG1XFjwPEFLYq89e7vlIU7z1xxPUO2VYgKNVotc9DVCL5AgFmDyfJa+hLnOaBRvTD0fkdMVQ5hwkF2rHCND2Y/81xqvGFQike8aFld2Ue5+9EUaUCocbvRFwr66nxo2RS10ax2pVy4PjjEQI5bitoyKOSPyUJlD+i9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729512551; c=relaxed/simple;
	bh=2sEnULcFJb/3dGio6LTiieNbuni/u28TOJxXiDgo9Pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YFiPV+wQor0lWB/uUQjGKYl1WfLDr9bWZfl3PQvdhwkhg/4+DNVfqFNsc4wU39W7G1ex05YkjXFb94DeUd3PWfkljQb7ENFIEJYgXETh9496+KyNgGapv+E5lTbsG1KNjMQj+hk8e7GK8nU+dxri9VVhUbesGK2FQJJsAak66vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XXDZz3Mbnz1SCSX;
	Mon, 21 Oct 2024 20:07:39 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id B27FF1A0188;
	Mon, 21 Oct 2024 20:09:00 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 21 Oct 2024 20:08:59 +0800
Message-ID: <56099e59-586d-4013-8262-a21a3ae473a4@huawei.com>
Date: Mon, 21 Oct 2024 20:08:59 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] uprobes: Improve the usage of xol slots for better
 scalability
To: Oleg Nesterov <oleg@redhat.com>
CC: <ak@linux.intel.com>, <mhiramat@kernel.org>, <andrii@kernel.org>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20240927094549.3382916-1-liaochang1@huawei.com>
 <20241001142935.GC23907@redhat.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20241001142935.GC23907@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/10/1 22:29, Oleg Nesterov 写道:
> On 09/27, Liao Chang wrote:
>>
>> The uprobe handler allocates xol slot from xol_area and quickly release
>> it in the single-step handler. The atomic operations on the xol bitmap
>> and slot_count lead to expensive cache line bouncing between multiple
>> CPUs.
> 
> Liao, could you please check if this series
> 
> 	[PATCH 0/2] uprobes: kill xol_area->slot_count
> 	https://lore.kernel.org/all/20241001142416.GA13599@redhat.com/
> 
> makes any difference performance-wise in your testing?

OK, I am ready to test this patch on my arm64 machine.

> 
> Oleg.
> 
> 

-- 
BR
Liao, Chang


