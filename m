Return-Path: <bpf+bounces-33122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4255917649
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 04:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C4D1F23121
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 02:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3592B9C0;
	Wed, 26 Jun 2024 02:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e//p9XTJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C27E2B2DA
	for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 02:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719369832; cv=none; b=CpNIQkza8cnSi/8n/S+MD9mCX1xcVkME96KnT1gFl/C2HPCH7jHMtsvnFr3s6g58cDkRDWr7QCycOMfsYcU3AuHwzwEaLGAG+VFNTeAEr38JzlWgIg9mdrOSGDJkEC7u+qhOFuUcQk8wxSKewqm7H311Ifth/GUR88KA9YYcyqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719369832; c=relaxed/simple;
	bh=TzY9oXfU4TeXQZB7XaW00qJcluE2fxDXhq6G00qJFl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UqZqHBu3ZHdzeWUMGqhQ3wL6XkMbVPSor7gCw2rtSXbp4GjJ8w0BjwWPxLvOg0IqgUy0QkbmkFML4P42q6/IEPfmUh6MjT7WRFPF18awIoesPze+QC4MGAlmZHd7bruiPR8xum8mVGBTa+ikC8E+ScjMncXhE5YqZ1R1QEWlD3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e//p9XTJ; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5c22527f8d6so42309eaf.0
        for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 19:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719369830; x=1719974630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rG3w2INBk5u/Jo1IIm6PkNLzmbMpq9WYWJppu8bUdBY=;
        b=e//p9XTJ54aJLkhlgQepydYP6isnj74psUEsXbJFGGUoHHZZO6/m4SyNOfxeHp8/bb
         Wj6gpZklKHG2Xr9uVSAXP/ZxmcjvWO2YJbqXYomJ/wOvS11fTvrw4EifG9LvLvgAD8qp
         dNFVHSFBX58QLWnd2FbBUjpRTAHU2eJGR6vUJq7NbrF1JZoMO6+Q2W7P4wuPNYpsj02K
         ftB9qexGhvBgC5uGbn0214VnjOIdEaPmPJcqi96o71Bg4UQ01nRkbSIhqQSOzrVmhWZ2
         s6pdXnOKHltiMurlBy4gwTsJa7/VGPuBs49YEKX1T+kvp1dZ+nSe30DHIRhz06DN3/z+
         AAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719369830; x=1719974630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rG3w2INBk5u/Jo1IIm6PkNLzmbMpq9WYWJppu8bUdBY=;
        b=FfWRTM8XhVIlmjF8MKFOQwRQixDxc7Mxb3It4g1uiL+2bsfo3XXNW2++sQ8YnSlQJc
         Jl2py/BtSVvc8U7Rt52OavaPBSGkUMGtZaVd3sdmuHAPbkvTA8XKdCKzZsqkJQVOMrnq
         sKWbwE/FPGXSlFDKolMIAdvVd9KW/a36Y51kXv5/aTWpwYJRsdbAWNEuyUV/sN/cIX8W
         F6S+ezT8R+374xVbrl6y1reJSzw2IMuAGqTV9id2vMesvk4QiDLWe7UHNwSX0Q88TZKj
         cD34JwXm07KBLCxFy1Ko/50OBvyhAQZlwojkjyIvb958GsQLNuStua/4r6Bp/5WuaS01
         vQTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX8icR7oT7RMQQeKTnzG/G5JbBnISmIfNqhW2Q7FrHIOyX+vaQnY5HSr2HvORNchCaXoYRtNAL79hzdyl9gF6APCr3
X-Gm-Message-State: AOJu0YxAuIIiQeOHkNx+yb5Q6fJX7RvttZyKm6RAd1/ZAZf2auXDgf6u
	CL9cVsFWMCV9OMxepbp9aSODjELUVR9JnST5wj2nkmD8UzKaDhfQ
X-Google-Smtp-Source: AGHT+IEjxmrGj+JcppGKsHuvAml5K0hl12hsilsm8VxYcrA9SLuZHhJ4SZn30SN7L3TgCQBWYTWv2A==
X-Received: by 2002:a05:6359:5fa9:b0:1a5:b0f7:259 with SMTP id e5c5f4694b2df-1a5b0f706b4mr62750055d.21.1719369829652;
        Tue, 25 Jun 2024 19:43:49 -0700 (PDT)
Received: from [10.22.68.7] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716b36487a9sm7856921a12.2.2024.06.25.19.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 19:43:49 -0700 (PDT)
Message-ID: <e84c7233-70cf-42d8-87f6-6ed6e40087c7@gmail.com>
Date: Wed, 26 Jun 2024 10:43:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [bpf, x64] f663a03c8e:
 test-bpf.Tail_call_count_preserved_across_function_calls.fail
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
 Linux Memory Management List <linux-mm@kvack.org>,
 Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org
References: <202406251415.c51865bc-oliver.sang@intel.com>
 <ac402815-923c-49ec-b027-4f99b55c895e@gmail.com>
 <Znt6wPH24lQlbYrO@xsang-OptiPlex-9020>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <Znt6wPH24lQlbYrO@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26/6/24 10:19, Oliver Sang wrote:
> hi, Leon Hwang,
> 
> On Tue, Jun 25, 2024 at 04:25:00PM +0800, Leon Hwang wrote:
>>
>>
>> On 25/6/24 14:55, kernel test robot wrote:
>>>
>>>
>>> Hello,
>>>
>>> kernel test robot noticed "test-bpf.Tail_call_count_preserved_across_function_calls.fail" on:
>>>
>>> commit: f663a03c8e35c5156bad073a4a8f5e673d656e3f ("bpf, x64: Remove tail call detection")
>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>>
>>> [test failed on linux-next/master 62c97045b8f720c2eac807a5f38e26c9ed512371]
>>>
>>> in testcase: test-bpf
>>> version: 
>>> with following parameters:
>>>
>>> 	test: non-jit
>>>
>>>
>>>
>>> compiler: gcc-13
>>> test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory
>>>
>>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>>>
>>>
>>>
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>>> | Closes: https://lore.kernel.org/oe-lkp/202406251415.c51865bc-oliver.sang@intel.com
>>>
>>>
>>>
>>> [   43.913560] test_bpf: #0 Tail call leaf jited:1 5 PASS
>>> [   43.913572] test_bpf: #1 Tail call 2 jited:1 ret -1 != 3 FAIL
>>> [   43.914138] test_bpf: #2 Tail call 3 jited:1 ret -1 != 6 FAIL
>>> [   43.914756] test_bpf: #3 Tail call 4 jited:1 ret -1 != 10 FAIL
>>> [   43.915374] test_bpf: #4 Tail call load/store leaf jited:1 5 PASS
>>> [   43.915993] test_bpf: #5 Tail call load/store jited:1 ret -1 != 0 FAIL
>>> [   43.916636] test_bpf: #6 Tail call error path, max count reached jited:1 ret 1000 != 34000 FAIL
>>> [   43.917319] test_bpf: #7 Tail call count preserved across function calls jited:1 ret 1000 != 34000 FAIL
>>> [   43.918799] test_bpf: #8 Tail call error path, NULL target jited:1 5 PASS
>>> [   43.919720] test_bpf: #9 Tail call error path, index out of range jited:1 5 PASS
>>> [   43.920474] test_bpf: test_tail_calls: Summary: 4 PASSED, 6 FAILED, [10/10 JIT'ed]
>>>
>>
>> Hi,
>>
>> May I request the source code of these test cases?
>> I do not find them in lkp-tests.
> 
> test-bpf doesn't have source code.
> 
> you could refer to
> https://github.com/intel/lkp-tests/blob/master/programs/test-bpf/run
> to see how it runs.
> 
> then
> https://github.com/intel/lkp-tests/blob/master/programs/test-bpf/parse
> to see how the results are parsed.
> 

I found their source code. Then I fixed it by "bpf: Fix tailcall cases
in test_bpf"[0].

[0] https://lore.kernel.org/bpf/20240625145351.40072-1-hffilwlqm@gmail.com/

Thanks,
Leon

