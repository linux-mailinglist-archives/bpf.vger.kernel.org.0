Return-Path: <bpf+bounces-19906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF771832F60
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 20:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AA7BB23315
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 19:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF7F56455;
	Fri, 19 Jan 2024 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEfRnKa2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEDE38E
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 19:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705692719; cv=none; b=mk4Z28GL0gAlzNnFXYpLU2biatNdoUwYAdx7QeosnBZS+We0vNrwmE8pGr9Q+WhQWhR+2EE1w8hSnsMwXPLiXbx7m2/A+NavUf/ir1eK9EjthLxdtufOPvEwfKlFnN1/dIfU/A/hm1LUpqQYK0qTOvMu5HzcLs9oSwRmwZDFY7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705692719; c=relaxed/simple;
	bh=mbwLiA50iEukD8gddGv1alMIrh3u+4NaxkOpgoON4q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VUlyTs6gfAsoIn9aJqCH2/HC49JL6HL4N6sRWUX8d2xkWNT2U7AhekwbnUG6ZLxfsAQuPftMcBU4fTJsEuXjS9S5R7InK3s7fk74kZMIJhFYOqMIT5aT0C0kHU8IMTvKHe4XJEDuE3JQaMm5vOX+VZjDWrrHQROUFKSp4FIzxqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEfRnKa2; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc223d20a29so954486276.3
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 11:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705692717; x=1706297517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZc55FV2rKa+k+YDqY2pvQznM2AmLByREgW5Zz6+5lU=;
        b=fEfRnKa2s1w+o7FleDMrSqo8OSU1pgLZTBLDBRVZ61kXWwdoRqNypxk6lIwRfWJ4DS
         nvZv0CsytrLOxoAbWSX2ap4G+WiMfm5SuhzM5FeJhxDi8yanCgVrRU2v1vdoTjDt4UqZ
         GuznieDlDG9c/xg3tS+cxfuiN3lMMfi8STYx1sNaV3kvVv9jr/GmSQmdgzhivQPk6i9h
         rtKZgMWDJTSNwTE4cDTpGk42I61YpmkeucHbY0G6BLwVbMj8tVIEDWmu1OV4bKFqVa/5
         FcB/ziXLvq1x9iwk+Ek61YiOEAxhh8eZt4xVJbDtwTC3qYhZgyhxuVlkfHD0ae3enKpx
         NqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705692717; x=1706297517;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZc55FV2rKa+k+YDqY2pvQznM2AmLByREgW5Zz6+5lU=;
        b=ePZ93/wkm5sA8878gFPa7N22CON5uBMsZgg974rr+PV9DaH/SxXTJnJVXhzL+zYoVQ
         wfsgXhot+khwkXXJh5+cF07F+N4cLkar0w8XdjJcr6DzvMoCIh25r54jkLOrD3izHDkz
         iEKXFKKEpwNxG6zRJqpRErhOWM2Ie1csNlyR4VN2GSwfSyCqwgLBspT6QYKFre/YbLCz
         Z/Auu0utRsDzreO+2JjfQYj9qMzbNeRxvCTDfMJlZlrCBGBOwf9ZI/I64v5iuphBYCYM
         pQelrtsZ9EaMmcJ8DVe2DElHZXEE6zy/IvDPvHvYjCX2VFRi5zcOx4kGTY4tYRM5OCqX
         sERA==
X-Gm-Message-State: AOJu0YwRpgKHXXiFGY+KkPdPTakAXaQtLla23jesNoVUMNmS8QNWn9eR
	+ePk61Kl2107B0qifbLlnkqWnHiv4ZCg4h882GPaxXLOB81qfPdd
X-Google-Smtp-Source: AGHT+IG10GfmjaehRpzO1kUuUsg2FjY1DqqD51ONOcXu5+02J2/mPxhaf285v+1ujKGLI3LmYCGJqw==
X-Received: by 2002:a5b:90b:0:b0:dbd:b8fa:a0e9 with SMTP id a11-20020a5b090b000000b00dbdb8faa0e9mr359905ybq.66.1705692717529;
        Fri, 19 Jan 2024 11:31:57 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:c63b:9436:82f0:e71a? ([2600:1700:6cf8:1240:c63b:9436:82f0:e71a])
        by smtp.gmail.com with ESMTPSA id z10-20020a25ad8a000000b00dc252f785c3sm1520461ybi.17.2024.01.19.11.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 11:31:57 -0800 (PST)
Message-ID: <bf72f560-6810-40fc-a02e-ab61c2afce74@gmail.com>
Date: Fri, 19 Jan 2024 11:31:55 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v16 14/14] selftests/bpf: test case for
 register_bpf_struct_ops().
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20240118014930.1992551-1-thinker.li@gmail.com>
 <20240118014930.1992551-15-thinker.li@gmail.com>
 <df0c03f8-d510-4559-b1fe-7ef3991e6b8b@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <df0c03f8-d510-4559-b1fe-7ef3991e6b8b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/18/24 14:41, Martin KaFai Lau wrote:
> On 1/17/24 5:49 PM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Create a new struct_ops type called bpf_testmod_ops within the 
>> bpf_testmod
>> module. When a struct_ops object is registered, the bpf_testmod module 
>> will
>> invoke test_2 from the module.
> 
> lgtm. One very minor nit on the newly added copyright comment is to 
> s/2023/2024/. Thanks.

Ok!

> 
> [ ... ]
> 
>> diff --git 
>> a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c 
>> b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>> new file mode 100644
>> index 000000000000..333d70c5f708
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>> @@ -0,0 +1,75 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> 

