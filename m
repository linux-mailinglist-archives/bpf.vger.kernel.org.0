Return-Path: <bpf+bounces-54952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3609CA7639E
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 11:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7176B188A0F4
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 09:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCE01DE887;
	Mon, 31 Mar 2025 09:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J9nktezE"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE84F15530C
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 09:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743414896; cv=none; b=MpMVXaCpeiioelVCbxdYEl/YAh8Uwp9TFLMZlY7YTnomJrY48w++sw9sq2DWOfJUYw5DRGaija9MQNcd10SsRP12bIB750BtVGXuYlwZCV9vxuNQ7/cARpIA89dG234uKSdqtVec+FcFqlh+nSeXmyMG4NUP7Ej7NlI/SbM23ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743414896; c=relaxed/simple;
	bh=/B5Wkn2ERhIJcrWZ1pSBQGH4Xjd54kaX3qokDhgQxl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mA4GPCRt7UMdd54daOnyJ2pZ+mWHZm/fEm2zQ3LW1Ls9ITfPMrLZXwruuDk9PsBJ2uFDVirXO4dQuwNG3hMB+waSDQ+Wg3hr8jXmmQO/aoogLQEcag8G2RmSn72YnunQ6Lh1JrhkGnhnVE7j9fTKvG59vom/TTIMRb7Kng85wTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J9nktezE; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f9dc7fcc-0ff1-4b9a-992a-d1d8c9c7dc14@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743414893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IX5GgdM/hSkMdMSyDwxEq1056Rord2VXHALCJ35TNks=;
	b=J9nktezE6zlh3lrqmC327EAZ44QjGaVaT66gZMI40JWr7hy9JHsxDoWnnrVktrlKPbeKO6
	HyLhY+ZeFO0z1h7G6/9w/JUbDDj6dHPPo48TdaVsgFFVZiBFYqozyq8o04lAc0JMEYV949
	VhuffgZZG14c48lgSpNBXyOGgNUlHnM=
Date: Mon, 31 Mar 2025 17:54:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Question: fentry on kernel func optimized by compiler
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 bpf <bpf@vger.kernel.org>
References: <7e46c811-e85b-4001-8fac-b16aa0e9815f@linux.dev>
 <CAEf4BzaEg1mPag0-bAPVeJhj-BL_ssABBAOc_AhFvOLi2GkrEg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzaEg1mPag0-bAPVeJhj-BL_ssABBAOc_AhFvOLi2GkrEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/3/29 01:21, Andrii Nakryiko 写道:

Hi Andrri,

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
> 
> No, we cannot. It's a different function at that point and libbpf
> isn't going to be in the business of guessing on behalf of the user
> whether it's ok to do or not.
> 
> But the user can use multi-kprobe with `prefix*` naming, if they
> encountered (or are anticipating) this situation and think it's fine
> for them.
> 

I will try multi-kprobe feature, and briefly checked and found that the 
multi-kprobe is implemented based on fprobe. Is its performance similar 
to that of fentry? Thanks.

> As for fentry/fexit, you need to have the correct BTF ID associated
> with that function anyways, so I'm not sure that currently you can
> attach fentry/fexit to such compiler-optimized functions at all
> (pahole won't produce BTF for such functions, right?).
>

Yes, it is.

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
>>


-- 
Best Regards
Tao Chen

