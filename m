Return-Path: <bpf+bounces-22177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C7A858617
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 20:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862171F23CCD
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 19:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C401369B4;
	Fri, 16 Feb 2024 19:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnExFBM8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2511369B0
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 19:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708111134; cv=none; b=aUinE8j6MfS1tT1FLcjoXoGnMK8THe9KipQv0jBetBynie/kdkzd/r/Doreug/qUQ71fBtx3ugtVvLTJtHPN68u2kWl25ZUVNqcWOW4nmc/yBBPfinvYHkQEiwiqySL9knjG/N12juWMmjyDi96YwgFX4k8lBFsxq50/0Eml5RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708111134; c=relaxed/simple;
	bh=9faHJXfcrUoTMgAIJowMdrGJI6970uiPBirXmv8DMdc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mbq/0rKHgZ60u1hmy4c2gLbsknFIqOG0HWSEVSb7v8swiQxLTHlnjK1dm1GzW18wetm5n536v1Ls1ZxQTV1FJM/czMz+jmR0TCtE0+byeqB/Ps8ri11jV2h5F93X3hJLb7dNuyW55yLt2sFoqNwRYqW19c/GKvgDOHjVl2AiMtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnExFBM8; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-607e707a7f1so18996147b3.2
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 11:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708111131; x=1708715931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1wFfQepBUhKUvNwBeHdJVJn7l0prYJ9oCeOA3hX+ddQ=;
        b=DnExFBM8cvRgeP/yWtBWhHoOYBdRmsdJ+tu1jnkwi8ZaWiTipxJEYvfWkoERRJkdCx
         agx934UX9iKCmNdsFs4MoOsNvIlF2d/tWtmt2LzySC/g7HVsJ849NGn7/+6cwPpEmaLG
         fBGAe5IasYj8jFeGC0bLij18qdmcMmG3bmeCifsXo0TFJfBBD/kBxtl1EDqVesCQ/huF
         ILr8iGppxST0cz8JXpytpcEdaqHJSGDoLjU0cpu6mpZ16oz2alvKYAWtBykGgOpGwWKB
         6G15gpCldwsQv6etYu2cjc60vbZ8X2UwAh/Et9VH9BvnncB1hDc/dYMklTDNdOLlI4dp
         Rasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708111131; x=1708715931;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1wFfQepBUhKUvNwBeHdJVJn7l0prYJ9oCeOA3hX+ddQ=;
        b=X/lvK1ZUL29SLQRq6KjrXu4y/JtW37IAEqpofRdJucvIU9K3cUZtjK7RzFJiLHwASV
         bcGAmoUJxxiSLxOz5Hf4CG0aLiXPwFObQ2/2MCdOMq8MRcsHGW+rPyYbXVrR9Yvb2qgD
         n2wuwg89XZks9xua2HETSKgCaK5PGfy0D18ibuoGq9rPbBUBj2qONHNNfsHgDeatrblC
         y87iI5Voc0J16TMq5qPFPJOTvtpaYB33RDgtCxEicFXtMetELHxNP4J/1KFiQhqo6SgT
         Fav0V6qtWQUFoF85Cc2xESE7Qfz9HiRU+zXZcXYtXtvNJ0/4YQom/5O9obx0hrg6YLPc
         wclA==
X-Forwarded-Encrypted: i=1; AJvYcCXrrNC1ukPg22HgsxKjw/kiS9BIBZfiJMYmEXoEc1RlHYcPs/gY/5mgVydfhCYXQVkvcAHXy1Ynnn2o+m6WjLea9N3P
X-Gm-Message-State: AOJu0YyKTmsPwmzSMRTm1S83No4NlAAFwm6oGkukzEb/cSfkYOnfVBZc
	mRruH9OKoLj8iHdin4eCLt0H+XLyeYc2Rj0WcmOGuotBtF6IAtrl
X-Google-Smtp-Source: AGHT+IFPuAqOv34c+4PtIzCCMp8OQqMTHHHTJi3ungghxx4X2B6408FTgDY2qG4vwp/xTWehENEDXw==
X-Received: by 2002:a0d:ca94:0:b0:5ff:6433:73d2 with SMTP id m142-20020a0dca94000000b005ff643373d2mr6869696ywd.8.1708111131344;
        Fri, 16 Feb 2024 11:18:51 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:6477:3a7d:9823:f253? ([2600:1700:6cf8:1240:6477:3a7d:9823:f253])
        by smtp.gmail.com with ESMTPSA id t17-20020a81c251000000b006049de6fa26sm458324ywg.57.2024.02.16.11.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 11:18:50 -0800 (PST)
Message-ID: <de618f02-8820-477b-ac9d-5842b9e6add4@gmail.com>
Date: Fri, 16 Feb 2024 11:18:49 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 0/2] Check cfi_stubs before registering a
 struct_ops type.
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
To: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: kuifeng@meta.com
References: <20240216020350.2061373-1-thinker.li@gmail.com>
 <6a994e6e-0e83-4242-aeab-94d9f3e5df8b@gmail.com>
In-Reply-To: <6a994e6e-0e83-4242-aeab-94d9f3e5df8b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Somehow, bpf_tcp_ca misses a stub function.
Will add it in the next version.

On 2/16/24 10:40, Kui-Feng Lee wrote:
> It fails on CI.
> I am fixing it.
> 
> On 2/15/24 18:03, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Recently, cfi_stubs were introduced. However, existing struct_ops
>> types that are not in the upstream may not be aware of this, resulting
>> in kernel crashes. By rejecting struct_ops types that do not provide
>> cfi_stubs properly during registration, these crashes can be avoided.
>>
>> ---
>> Changes from v1:
>>
>>   - Check *(void **)(cfi_stubs + moff) to make sure stub functions are
>>     provided for every operator.
>>
>>   - Add a test case to ensure that struct_ops rejects incomplete
>>     cfi_stub.
>>
>> v1: 
>> https://lore.kernel.org/all/20240215022401.1882010-1-thinker.li@gmail.com/
>>
>> Kui-Feng Lee (2):
>>    bpf: Check cfi_stubs before registering a struct_ops type.
>>    selftests/bpf: Test case for lacking CFI stub functions.
>>
>>   kernel/bpf/bpf_struct_ops.c                   | 14 +++
>>   tools/testing/selftests/bpf/Makefile          | 10 +-
>>   .../selftests/bpf/bpf_test_no_cfi/Makefile    | 19 ++++
>>   .../bpf/bpf_test_no_cfi/bpf_test_no_cfi.c     | 93 +++++++++++++++++++
>>   .../bpf/prog_tests/test_struct_ops_no_cfi.c   | 31 +++++++
>>   tools/testing/selftests/bpf/testing_helpers.c |  4 +-
>>   tools/testing/selftests/bpf/testing_helpers.h |  2 +
>>   7 files changed, 170 insertions(+), 3 deletions(-)
>>   create mode 100644 tools/testing/selftests/bpf/bpf_test_no_cfi/Makefile
>>   create mode 100644 
>> tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
>>   create mode 100644 
>> tools/testing/selftests/bpf/prog_tests/test_struct_ops_no_cfi.c
>>

