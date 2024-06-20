Return-Path: <bpf+bounces-32591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C309910383
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 13:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D49CB22E74
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 11:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEFA17C20A;
	Thu, 20 Jun 2024 11:58:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4944174ECD;
	Thu, 20 Jun 2024 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884693; cv=none; b=B+nHjG0notD3d1UOHhyDzjuXaqyhLK7izrtP0QLdGiB2GMt8kozjakh/yEZ9jAF65FnXSBtHxxeI6Ad7yjx+F8CkNm+dZPKYC2cq0XsPKAMDb9YkFJ1sbkMLhCzrsk6PqIwrxyy3FgMe9PwwkWCRliYl6H0O61kPVB42ZKB/wRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884693; c=relaxed/simple;
	bh=AMjY/VwTD+uEKB+oGE0aLxqqxjfZa0I4Uv1yLtm9Jfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=huyxzlLVZ10SDVzlBP8eCwLMw3HJZFnAJWQd5ewKHOxQc7tRZfmEHGf/eo/7c1UHJDTR8snv5Cbics/u5aOPIPGB36At2gVXAc8ZkeQpMz5RyPJLzLrdvFzU5eS0hlQsSCSrMIa0jN4KkFpU+LlTFdUF3DFr3Ao5RBj7eY9xSG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4W4f6f0kCKzPs2t;
	Thu, 20 Jun 2024 19:54:34 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 01BDC140158;
	Thu, 20 Jun 2024 19:58:08 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 19:58:07 +0800
Message-ID: <41d39908-aad2-22c2-c646-24d136b0b489@huawei.com>
Date: Thu, 20 Jun 2024 19:58:06 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH bpf-next] uprobes: Fix the xol slots reserved for
 uretprobe trampoline
To: Oleg Nesterov <oleg@redhat.com>
CC: <jolsa@kernel.org>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<nathan@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<mark.rutland@arm.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20240619013411.756995-1-liaochang1@huawei.com>
 <20240619143852.GA24240@redhat.com>
 <7cfa9f1f-d9ce-b6bb-3fe0-687fae9c77c4@huawei.com>
 <20240620083602.GB30070@redhat.com>
 <f0678e11-dd59-2e9b-56d5-cb28a20ffac7@huawei.com>
 <20240620105203.GE30070@redhat.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20240620105203.GE30070@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/6/20 18:52, Oleg Nesterov 写道:
> On 06/20, Liao, Chang wrote:
>>
>> 在 2024/6/20 16:36, Oleg Nesterov 写道:
>>> On 06/20, Liao, Chang wrote:
>>>>
>>>> However, when i asm porting uretprobe trampoline to arm64
>>>> to explore its benefits on that architecture, i discovered the problem that
>>>> single slot is not large enought for trampoline code.
>>>
>>> Ah, but then I'd suggest to make the changelog more clear. It looks as
>>> if the problem was introduced by the patch from Jiri. Note that we was
>>> confused as well ;)
>>
>> Perhaps i should use 'RFC' in the subject line, instead of 'PATCH'?
> 
> Well. IMO the changelog should explain that the current code is correct,
> but you are going to change arm64 and arch_uprobe_trampoline(psize) on
> arm64 can return with *psize > UPROBE_XOL_SLOT_BYTES.

You are absolutely right, Here is a draft of the revised changelog for your
suggestion:

    uprobes: Adjust the xol slots reserved for the uretprobe trampoline on arm64

    Adjust ixol slots reservation logic to ensure to accommodate the uretprobe
    trampoline on arm64, which is potentailly larger than single xol slot. This
    ensure the trampoline code fis within the reserved memory and avoids potential
    errors.

> 
> Oleg.
> 
> 

-- 
BR
Liao, Chang

