Return-Path: <bpf+bounces-69716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F12B9F77D
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 15:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86FC1C21095
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 13:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F91221FB8;
	Thu, 25 Sep 2025 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lh9f1CVu"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039E9219302
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 13:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805994; cv=none; b=fk2jJusklMB0LQGdJpvmmVZ44EYYhpGpBQM/1UYb2efm5YMkzdgvYN0n6JIa83oHegRk6bVKKtrRi3sD7ib2M+f2IPZAoGxvolN9dkg6vRlObb/CcLqjz+Qvk/9hA4DL+vYT//5IUAIV7UnURLFGpkDH14dbnmsWZ+2FyP+khAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805994; c=relaxed/simple;
	bh=fWBsE6zVoN9rM7k7n4xfsruaaKtxN6aWR/4GOoG/wuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ruhIwPsGkjK2PA+bAuYIddQ5k6HuBxMs7FIdGgr5w002ZLfKElZIVI95PredIHLaCxJqjaQOYH3gsy0hAG+VgTvQziSnj2EyL/OlIAz/G4kqpkXHUtttCP78FoO51FPGSb1lto2ByMhOVWyI/85XnMHCLIudXFc02pTZiCgiC2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lh9f1CVu; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3a4b33a0-955d-421f-ac93-fae7fc91a565@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758805990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=09NKtGFrfQ6h43UBpmzJak6ZaXR+v7c7u8uT+wcViPw=;
	b=lh9f1CVuYU4RF3BTsuxTRIfXiTrQDCDDCYBxcObZyBErKC7PG/0rEVcUlzI39i1c4UFcUh
	+2T57oNhUJJcJmoIG2oRKhZ8YyLkDbP6S0s8Lm9teA5UuIOQEF8ouemjlnV6YMsdY0/8+g
	ybinMZ2RFeQtuoRTL4CA9ul3Y5kM/FU=
Date: Thu, 25 Sep 2025 21:12:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 3/3] selftests/bpf: Add stacktrace map
 lookup_and_delete_elem test case
To: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250923165849.1524622-1-chen.dylane@linux.dev>
 <20250923165849.1524622-3-chen.dylane@linux.dev>
 <00b1a35f-f944-47a6-9195-52438753c051@iogearbox.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <00b1a35f-f944-47a6-9195-52438753c051@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/9/25 20:09, Daniel Borkmann 写道:
> On 9/23/25 6:58 PM, Tao Chen wrote:
>> Add tests for stacktrace map lookup and delete:
>> 1. use bpf_map_lookup_and_delete_elem to lookup and delete the target
>>     stack_id,
>> 2. lookup the deleted stack_id again to double check.
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   .../testing/selftests/bpf/prog_tests/stacktrace_map.c | 11 ++++++++++-
>>   tools/testing/selftests/bpf/progs/stacktrace_map.c    |  2 ++
>>   2 files changed, 12 insertions(+), 1 deletion(-)
> BPF CI fails with:
> 
> Notice: Success: 644/5645, Skipped: 82, Failed: 1
> Error: #402 stacktrace_map_raw_tp
>    Error: #402 stacktrace_map_raw_tp
>    libbpf: elf: failed to open ./test_stacktrace_map.bpf.o: -ENOENT
>    test_stacktrace_map_raw_tp:FAIL:prog_load raw tp err -2 errno 2
> Test Results:
>               bpftool: PASS
>            test_progs: FAIL (returned 1)
> Error: Process completed with exit code 1.
> 
> https://github.com/kernel-patches/bpf/actions/runs/17993777572

Hi Daniel,

It seems that stacktrace_map_raw_tp will use test_stacktrace_map.bpf.c,
which is renamed to stacktrace_map.c in my patch, i will fix it, thanks.

tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c:8: 
const char *file = "./test_stacktrace_map.bpf.o";

-- 
Best Regards
Tao Chen

