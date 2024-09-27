Return-Path: <bpf+bounces-40398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322AD988222
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 12:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD25B1F215FC
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 10:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077101BC067;
	Fri, 27 Sep 2024 10:02:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BF61BBBD3;
	Fri, 27 Sep 2024 10:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727431320; cv=none; b=iRx9PvR3RwgJpGrxE3wAM2lOJrAd4Ok3fp0+Qn8VWPAaT8aZGXufOPkgs3QNIcPVlWLfN4c0x3hi0MZobSLPglzfvkA96P5LU+Zeyy1zrQ34PrTGAY7Z5yB0s8AKbEZ51FO34e9pHfplMyQ75Wr9baku9dI3TvKaLr+Sam0fzPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727431320; c=relaxed/simple;
	bh=ht6fokgBdYVUP0yIwXleLxvN52k0ajk5Rwp9U1rQadM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ttKYFomj1oqMVR8riap1P91ToztnKdVeLm248mQUwpTn0eT1BU+vTnpaKp/DXBi3g++9GJynNJAO7GcigRSW8b7Pdm+qpaSdYr3xBzsmahLcGbeVo2goMQCzzE5EqqVtVaaNXIZ9ORTfMwsvG8yUX/LptnQsTEmbgZnGJE+BqDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XFQvv2JvVz1SBvB;
	Fri, 27 Sep 2024 18:00:59 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id C0E8214037C;
	Fri, 27 Sep 2024 18:01:49 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 27 Sep 2024 18:01:40 +0800
Message-ID: <e9a3066a-ff07-6d57-9b97-17ecebe95e59@huawei.com>
Date: Fri, 27 Sep 2024 18:01:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] uprobes: Improve the usage of xol slots for better
 scalability
To: Andi Kleen <ak@linux.intel.com>
CC: <mhiramat@kernel.org>, <oleg@redhat.com>, <andrii@kernel.org>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20240918012752.2045713-1-liaochang1@huawei.com>
 <87jzf9b12w.fsf@linux.intel.com>
 <7a6ba3f3-dffa-cdac-73c7-074505ea4b44@huawei.com> <ZuwoUmqXrztp-Mzh@tassilo>
 <0939300c-a825-5b46-d86f-72ce89b2b95f@huawei.com> <ZvH_LiUeOtAwommF@tassilo>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <ZvH_LiUeOtAwommF@tassilo>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/9/24 7:52, Andi Kleen 写道:
>> Thanks for the suggestions, I will experiment with a read-write lock, meanwhile,
>> adding the documentation and testing for the lockless scheme.
> 
> Read-write locks are usually not worth it for short critical sections,
> in fact they can be slower due to cache line effects.

OK, I will start from a simple spinlock.

> 
>> Sorry, I may not probably get the point clear here, and it would be very
>> nice if more details are provided for the concern. Do you mean it's necessary
>> to make the if-body excution exclusive among the CPUs? If that's the case,
>> I guess the test_and_put_task_slot() is the equvialent to the race condition
>> check. test_and_put_task_slot() uses a compare and exchange operation on the
>> slot_ref of utask instance. Regardless of the work type being performed by
>> other CPU, it will always bail out unless the slot_ref has a value of one,
>> indicating the utask is free to access from local CPU.
> 
> What I meant is that the typical pattern for handling races in destruction
> is to detect someone else is racing and then let it do the destruction
> work or reacquire the resource (so just bail out).

Agreed.

> 
> But that's not what you're doing here, in fact you're adding a
> completely new code path that has different semantics? I haven't checked
> all the code, but it looks dubious.

Andi, I've just sent v2. Looking forward to your feedback. Thanks.

  https://lore.kernel.org/all/20240927094549.3382916-1-liaochang1@huawei.com/

> 
> -Andi
> 

-- 
BR
Liao, Chang

