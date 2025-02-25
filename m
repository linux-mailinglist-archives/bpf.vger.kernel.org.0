Return-Path: <bpf+bounces-52487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C27A434C9
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 06:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896AD189D916
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 05:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8EE2566D1;
	Tue, 25 Feb 2025 05:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ef42IUr8"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5043A19CC08
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 05:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740462269; cv=none; b=M8E2UeReaGjQ/NagE/CIgBki5JN4TunB7PkFu6/6E94h5U1Y2/j8qLY9b2uzMxhiYcdNRDMTwBJ2/PTlJINeVKvq2hZZRPTeX6ToMXuuDyocCQz+FC5GtZnbzBZQrp2Zi7sumXzRu4MTYEB817OQgd/QpcSGUe+JcS0mpCCPhKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740462269; c=relaxed/simple;
	bh=YR6auw4bqXEXQ4lN3HdARvRbit10qylCF448um5Ywf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ba+Sy5kYUL3Yp5Ca331U+ZG39MW1ISJX6LBZ8a7n0OI9kUjihBOcDo1w4W3Bwl926Xz9GpMMnjNR0GXLs2PE3C7MDFq7dOg3Qm2y5o7u1VXD/nlx5ta8QyDrZJc8EPqcQ/kLIDZHTA2R9KuEJVdpyoOD3E8Gm1vOIQ8fM/u5V34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ef42IUr8; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d25b468f-0a84-45c9-b48e-9fd3b9f65b54@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740462255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZth+1J0qcG8af65YCaDKhN3YqIxKYuz0JmOjVxti1U=;
	b=Ef42IUr8rRA8r8MKIhzugtkBzzwgPhRpIASjRT0BJH/vU1p6IAXnK4wWR6135FSBHwfSss
	X51PDPNKwi5Z5Q1wilSx36TTNRtugn4rYdPFEuSeU6DvK7TOWr3BsKdVBIVpg1GKZNaqlC
	fu/lSUP7hLKj2KgF6pMXQdos+9EGBSc=
Date: Tue, 25 Feb 2025 13:44:04 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 4/5] libbpf: Init kprobe prog
 expected_attach_type for kfunc probe
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, chen.dylane@gmail.com
References: <20250224165912.599068-1-chen.dylane@linux.dev>
 <20250224165912.599068-5-chen.dylane@linux.dev>
 <CAEf4BzYz9_0Po-JLU+Z4kB7L5snuh2KFSTO0X9KK00GKSq91Sw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzYz9_0Po-JLU+Z4kB7L5snuh2KFSTO0X9KK00GKSq91Sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/2/25 09:15, Andrii Nakryiko 写道:
> On Mon, Feb 24, 2025 at 9:03 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> Kprobe prog type kfuncs like bpf_session_is_return and
>> bpf_session_cookie will check the expected_attach_type,
>> so init the expected_attach_type here.
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   tools/lib/bpf/libbpf_probes.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
>> index 8efebc18a215..bb5b457ddc80 100644
>> --- a/tools/lib/bpf/libbpf_probes.c
>> +++ b/tools/lib/bpf/libbpf_probes.c
>> @@ -126,6 +126,7 @@ static int probe_prog_load(enum bpf_prog_type prog_type,
>>                  break;
>>          case BPF_PROG_TYPE_KPROBE:
>>                  opts.kern_version = get_kernel_version();
>> +               opts.expected_attach_type = BPF_TRACE_KPROBE_SESSION;
> 
> so KPROBE_SESSION is relative recent feature, if we unconditionally
> specify this, we'll regress some feature probes for old kernels where
> KPROBE_SESSION isn't supported, no?
> 

Yeah, maybe we can detect the kernel version first, will fix it.

+               if (opts.kern_version >= KERNEL_VERSION(6, 12, 0))
+                       opts.expected_attach_type =BPF_TRACE_KPROBE_SESSION;

> pw-bot: cr
> 
>>                  break;
>>          case BPF_PROG_TYPE_LIRC_MODE2:
>>                  opts.expected_attach_type = BPF_LIRC_MODE2;
>> --
>> 2.43.0
>>


-- 
Best Regards
Tao Chen

