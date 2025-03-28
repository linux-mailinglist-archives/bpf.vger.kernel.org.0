Return-Path: <bpf+bounces-54859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB76BA74D9C
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 16:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A84B175ED7
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 15:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87C114D70E;
	Fri, 28 Mar 2025 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lqUw2Q+T"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7881DA4E
	for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743175175; cv=none; b=cYL+AMAXxlqHXtfLpThjqRaBadTRCk6UDhqnjWbEIuEysZVhRBGYgsnqqg66/SjFnGiRK4bdcdrUqalATfVavIuTkIG3pm0OyEywHZuualCmFC/nCer0J+m0f4DqZJYpsQOS0dXvkc+2XsAp5eiXAuRLjaM0ACgfr6L6NFqew+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743175175; c=relaxed/simple;
	bh=fxZCLV8naClLk0aWX5RfGrSNISKmuMfNpeQcSU2Cx7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ka9ZarCs3YYAk9Z31HUgZNWGyUh+HKDZnxCYNZIHHTFH9PGY3Y/Ok0DUt2Sb5vzySmGXvxe5PxPcoukSlsebG4p8lNOXaTQ5CCJwefXYgjWbHRq4kN2+H/2l173LJ3sAFr2dSfUjpx6No7R7N7F9WmQL3qQW4zOw26QiciLyfs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lqUw2Q+T; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4c60f56a-8505-49f3-872b-d485d65813d7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743175167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iSngOmVMoweaaJAhBuXF0RhHXq8OxThWJRjs/X3LC3A=;
	b=lqUw2Q+TLgVHyUO7wc+z9fqTaCjFaLUf/tY9mI7WWb5CAb8jGfhKYsXXWL6m0DOu/dATGG
	HD69Ds5unoyNRq02SvIku80BQGUtZwCq9xEpWXhy6GriCid6Btw9KVb/L2H6lN8G6GMIN+
	hHxAlbvADNtLnOYZ5GX/Q9GiOy5mo3c=
Date: Fri, 28 Mar 2025 23:19:09 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Question: fentry on kernel func optimized by compiler
To: Song Liu <song@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>
References: <7e46c811-e85b-4001-8fac-b16aa0e9815f@linux.dev>
 <CAPhsuW46kTsSzc+B5pE+kM24nc+OUXXGnkgSgZbu+T55HSJb7w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAPhsuW46kTsSzc+B5pE+kM24nc+OUXXGnkgSgZbu+T55HSJb7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/3/28 01:19, Song Liu 写道:
> Hi Tao,
> 
> Compiler optimizations can cause issues for tracing kernel functions. Please
> refer to Yonghong and Alan's presentation [1] for various cases.
> 
> Thanks,
> Song
> 
> [1] https://lpc.events/event/18/contributions/1945/
> 
>

Hi Song,

Thank you for the materials you provided. I'll take a look at them.

> On Thu, Mar 27, 2025 at 9:03 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> Hi,
>>
>> I recently encountered a problem when using fentry to trace kernel
>> functions optimized by compiler, the specific situation is as follows:
>> https://github.com/bpftrace/bpftrace/issues/3940
>>
>> Simply put, some functions have been optimized by the compiler. The
>> original function names are found through BTF, but the optimized
>> functions are the ones that exist in kallsyms_lookup_name. Therefore,
>> the two do not match.
>>
>>           func_proto = btf_type_by_id(desc_btf, func->type);
>>           if (!func_proto || !btf_type_is_func_proto(func_proto)) {
>>                   verbose(env, "kernel function btf_id %u does not have a
>> valid func_proto\n",
>>                           func_id);
>>                   return -EINVAL;
>>           }
>>
>>           func_name = btf_name_by_offset(desc_btf, func->name_off);
>>           addr = kallsyms_lookup_name(func_name);
>>           if (!addr) {
>>                   verbose(env, "cannot find address for kernel function
>> %s\n",
>>                           func_name);
>>                   return -EINVAL;
>>           }
>>
>> I have made a simple statistics and there are approximately more than
>> 2,000 functions in Ubuntu 24.04.
>>
>> dylane@2404:~$ cat /proc/kallsyms | grep isra | wc -l
>> 2324
>>
>> So can we add a judgment from libbpf. If it is an optimized function,
>> pass the suffix of the optimized function from the user space to the
>> kernel, and then perform a function name concatenation, like:
>>
>>           func_name = btf_name_by_offset(desc_btf, func->name_off);
>>          if (optimize) {
>>                  func_name = func_name + ".isra.0"
>>          }
>>           addr = kallsyms_lookup_name(func_name);
>>
>> --
>> Best Regards
>> Tao Chen
>>


-- 
Best Regards
Tao Chen

