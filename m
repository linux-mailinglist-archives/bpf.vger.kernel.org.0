Return-Path: <bpf+bounces-33031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 631F2916106
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 10:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880AC1C22707
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 08:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93207148315;
	Tue, 25 Jun 2024 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELUQAKrG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76E822313
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719303907; cv=none; b=GR3Rl4J+9vXQJN9TWLt1pgKxzu7y0XsHFaSvmTH0dLfLaroqSJJf2inCz3oa3xlos5ZC0vHr8kqBZfPysCEef5PvSa1vx9Fq8/k4W2KaE0aJYdP/6rlhHu0LQvEYzddLR0PbKvhQXgi9bRgMY92sHIv3RtuMhEaLP1IGh4eA+Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719303907; c=relaxed/simple;
	bh=x9Xq4nJRhjjFa5IMN1qjncFsaG0ztpmFcergDKd1o2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RuE11oc432lW2v4ZsWhp0ZaRsCCxwfxhiVRWzFU47OYb6b/OcjTEeVtgZSUJbJUl6E5fRVGLnbcDngoy0LFpKlhvKy+QrTRzWS3avbSToArfQo+H3bWcCSp4kPFbQSj/ueZfBrPukxR6tUUAUGfK1NP2iOQ8SW5QqO+fOQIc2rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELUQAKrG; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5c200bee86aso821064eaf.1
        for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 01:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719303905; x=1719908705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ic0gR8lv1bzgi74/8//kPAW6gA0eMoG+p7FcgAs/fPw=;
        b=ELUQAKrGvvymybJCHTk09auXxYFdtQqTOkGUyqmM+Z56gexYd4QA2mrV+HkGH+n62r
         I2Phf9wz48kIFvI4Qxy4+eNFTdbrzAhk880AdxIY6Iulu/mLGLcoJgCHDmE7fw5gzgR8
         SbVcwn1cUdD7uTiBllAjKYRXdALSzkJ+qbBG16I/Zsq1M4XU8nAAI6ZBhHF5UxG/LI1V
         V9NHErECEL9HH89DrYij826SBaWF8OFPousQglFFPBXys1adjp2jOYWcm06W2RhK1iku
         uTjNqg3T9bokQsUV3iNoEOeKdYA0bbN+2GI0wB2ShnuwWXLuGK2CyeOgvrwiZ9s/aqlA
         zqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719303905; x=1719908705;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ic0gR8lv1bzgi74/8//kPAW6gA0eMoG+p7FcgAs/fPw=;
        b=G+39d3DWbOkCrAsRUrb7xEEjHNW82sFsGUWv960yGPcy2B11c92NW+pAhSPY83jE0N
         i0cAuk4mqEZ/R7xMLOy76kVA1+3iHCqybhX6zeO96PzpGBh00aYtkoZdK7sn5n0K0z2G
         nXat/h+x2g4ydxSfNAkAxolAmrIOLVfQNS5CM6EkApVi/dEapftDCtF9x+50JZYsq7Bj
         DU7np1LgiHnEOYMAw08uQe66QIe6iixSipFjDLlofFdQoOoFn3bsnOSGSlXDbIo1x8Rj
         hrAtWMSb7XQLL1VmAIsRnp9qNNJGtx85bjZPEpYxlCvgwiR+ch8OOHN7Mym7vXOuKBIy
         bPnw==
X-Forwarded-Encrypted: i=1; AJvYcCV2jlKqY2UEonMyN/AxOZHKqgwVTeR5vb6QtTHH7oUGmZKtCPoWqOz2/6o5n059kglxAvmWTXTBzjCtcOlfVK9xMeOm
X-Gm-Message-State: AOJu0YwVwNOnvXeRWLE5sCGJ6+6dMMRBlXWpUqBbH84MbaB8PoJAn/5e
	JLasyexUUgOya4W9OaSyl65BJGK6gB6mA24WhCJ2Dp/XcwioPGgq
X-Google-Smtp-Source: AGHT+IHHtCpPitKeFignih/Zbj7MxleXlHtKMu6APKY8FCO4SUGxC+GN7Lm7vSGr6hOFkVSmcD67Fw==
X-Received: by 2002:a05:6358:7e88:b0:1a4:617d:6fea with SMTP id e5c5f4694b2df-1a4617d7377mr119874755d.6.1719303904573;
        Tue, 25 Jun 2024 01:25:04 -0700 (PDT)
Received: from [10.22.68.7] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716bb041180sm6664845a12.80.2024.06.25.01.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 01:25:03 -0700 (PDT)
Message-ID: <ac402815-923c-49ec-b027-4f99b55c895e@gmail.com>
Date: Tue, 25 Jun 2024 16:25:00 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [bpf, x64] f663a03c8e:
 test-bpf.Tail_call_count_preserved_across_function_calls.fail
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
 Linux Memory Management List <linux-mm@kvack.org>,
 Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org
References: <202406251415.c51865bc-oliver.sang@intel.com>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <202406251415.c51865bc-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 25/6/24 14:55, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "test-bpf.Tail_call_count_preserved_across_function_calls.fail" on:
> 
> commit: f663a03c8e35c5156bad073a4a8f5e673d656e3f ("bpf, x64: Remove tail call detection")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master 62c97045b8f720c2eac807a5f38e26c9ed512371]
> 
> in testcase: test-bpf
> version: 
> with following parameters:
> 
> 	test: non-jit
> 
> 
> 
> compiler: gcc-13
> test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202406251415.c51865bc-oliver.sang@intel.com
> 
> 
> 
> [   43.913560] test_bpf: #0 Tail call leaf jited:1 5 PASS
> [   43.913572] test_bpf: #1 Tail call 2 jited:1 ret -1 != 3 FAIL
> [   43.914138] test_bpf: #2 Tail call 3 jited:1 ret -1 != 6 FAIL
> [   43.914756] test_bpf: #3 Tail call 4 jited:1 ret -1 != 10 FAIL
> [   43.915374] test_bpf: #4 Tail call load/store leaf jited:1 5 PASS
> [   43.915993] test_bpf: #5 Tail call load/store jited:1 ret -1 != 0 FAIL
> [   43.916636] test_bpf: #6 Tail call error path, max count reached jited:1 ret 1000 != 34000 FAIL
> [   43.917319] test_bpf: #7 Tail call count preserved across function calls jited:1 ret 1000 != 34000 FAIL
> [   43.918799] test_bpf: #8 Tail call error path, NULL target jited:1 5 PASS
> [   43.919720] test_bpf: #9 Tail call error path, index out of range jited:1 5 PASS
> [   43.920474] test_bpf: test_tail_calls: Summary: 4 PASSED, 6 FAILED, [10/10 JIT'ed]
> 

Hi,

May I request the source code of these test cases?
I do not find them in lkp-tests.

Thanks,
Leon

> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240625/202406251415.c51865bc-oliver.sang@intel.com
> 
> 
> 

