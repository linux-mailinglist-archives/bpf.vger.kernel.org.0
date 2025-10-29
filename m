Return-Path: <bpf+bounces-72893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133F9C1D432
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 21:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517F63B4D81
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 20:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9720286D7E;
	Wed, 29 Oct 2025 20:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wsCcap6Y"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344D6359FAF
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761770696; cv=none; b=iJlQVTHCFAVnUUs1sw9IjvoM+Lebu88maseyLSKhsZKynSch37eIysmvKER2EaizUct/Ih83vcKvYcdSv9SJMKAsBmN3yP2+CiriisGH2dAuOXt4LXJ7t3nzRW7OVEgAIOkXnfnKsAk6cYvBtBgT30hM4RTiRDeqpROcuQ254vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761770696; c=relaxed/simple;
	bh=KdcO7dR6iOKxU3GwR6hgMJzc7tLPbW4Y9Tdmmzg0tzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bg3gBxvdsZ1m8phrKqatMFBbbz8KXYhmvMbNdiP845I71UZlmWy9KSAhBKI9IpDhFloyPKi6Yo5lxFmATJR9g2BhAacvnnpRqWdaWDtvoDV1khTqUB6byuljDEh6sVhYSNC1aGGj1afBaw8zHjTJRVgyQtZPUPthxAUlQq9v3hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wsCcap6Y; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7b25b8c3-af48-4f8d-9094-7fdbc71993aa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761770692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eW1AA5kfdr8lGTOD/a6CXcxjYs9RgvoOFvjzfthKVrA=;
	b=wsCcap6YnxtB7OTEYxnen1NgTbTxWTRQHrFI0w6u6iHbf4/JM4t7Yrw3yHwR0/rC4d50Rv
	x38Lk3pWhvJt/AgglrbJvXNAPQFXa/Ir5zU8gQ1MenNDyjqsu3V+/onxXVfK/ZqY8LhynA
	7vDxwrJOoQZmuu2Q1OBaermugGMqiUk=
Date: Wed, 29 Oct 2025 13:44:34 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 1/8] bpf: Add BTF_ID_LIST_END and
 BTF_ID_LIST_SIZE macros
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, andrii@kernel.org,
 ast@kernel.org
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org,
 eddyz87@gmail.com, tj@kernel.org, kernel-team@meta.com,
 daniel@iogearbox.net, martin.lau@kernel.org, yonghong.song@linux.dev,
 clm@meta.com
References: <20251029190113.3323406-2-ihor.solodrai@linux.dev>
 <3ff9f05dd90ecae535887b2b6ae14ab6b04fd28e8da22af874e917c5126cd803@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <3ff9f05dd90ecae535887b2b6ae14ab6b04fd28e8da22af874e917c5126cd803@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/29/25 12:41 PM, bot+bpf-ci@kernel.org wrote:
> 
> ```
> commit d616f53ce936875dd9f44cc77f9bed1198596463
> Author: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> bpf: Add BTF_ID_LIST_END and BTF_ID_LIST_SIZE macros
> 
> This commit adds two new preprocessor macros to btf_ids.h for
> calculating the size of BTF_ID_LIST arrays using pointer arithmetic
> between a list and its __end marker.
> 
>> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
>> index 139bdecec..27a4724d5 100644
>> --- a/include/linux/btf_ids.h
>> +++ b/include/linux/btf_ids.h
>> @@ -97,6 +97,16 @@ asm(							\
>>  __BTF_ID_LIST(name, local)				\
>>  extern u32 name[];
>>
>> +/*
>> + * The BTF_ID_LIST_END macro may be used to denote an end
>> + * of a BTF_ID_LIST. This enables calculation of the list
>> + * size with BTF_ID_LIST_SIZE.
>> + */
>> +#define BTF_ID_LIST_END(name) \
>> +BTF_ID_LIST(name##__end)
>> +#define BTF_ID_LIST_SIZE(name) \
>> +(name##__end - name)
>> +
> 
> Are the fallback definitions missing for CONFIG_DEBUG_INFO_BTF=n?

Indeed. Kernel build fails with CONFIG_DEBUG_INFO_BTF=n

Good bot.

> 
> Looking at the #else branch starting at line 228, all existing macros
> like BTF_ID_LIST, BTF_ID, BTF_SET_START, etc. have fallback definitions.
> These new macros BTF_ID_LIST_END and BTF_ID_LIST_SIZE only exist in the
> CONFIG_DEBUG_INFO_BTF=y path. When CONFIG_DEBUG_INFO_BTF is disabled,
> code using these macros will fail to compile.
> 
> While there's no current usage that would break, the API is incomplete
> compared to the established pattern in this header where every macro
> works in both config states.
> 
>>  #define BTF_ID_LIST_GLOBAL(name, n)			\
>>  __BTF_ID_LIST(name, globl)
> 
> 
> ```
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> In-Reply-To-Subject: `bpf: Add BTF_ID_LIST_END and BTF_ID_LIST_SIZE macros`
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18919699520


