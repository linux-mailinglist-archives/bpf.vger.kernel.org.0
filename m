Return-Path: <bpf+bounces-19352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD8C82A5AB
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 02:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F102284304
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 01:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4D4807;
	Thu, 11 Jan 2024 01:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBkx//Re"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAE27ED
	for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 01:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5f69383e653so50120737b3.1
        for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 17:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704937858; x=1705542658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mLQ2Camh48mLWWN4hephUD+TLzX5ShJOpFW1YgDQOUc=;
        b=KBkx//ReCZSjs26njmtN/UEZIgmJyCvglPVYraEVVzBe2LxiYsLQsKb/mde42MiPf9
         /lNu+RZIvJmbBs9sDxRBtgIpeIA6mmapNs6ldrw20AzoLlMgkPqH6Jcdjj4z/BCvrJLD
         dp8ul20LDEqmsk0xtd2iOFODm4DcxcAeFT0WbIsk3wOemoPKxsmmdO5ZCyGfBnJYwYuK
         UkqiSJ8IDIzIkThGZHKhiA1DY5S/4GYf68JImhXsj0trIE8NoO7mW4Zqf0Ej6W/3SO7i
         VEP/wojdNX3H+mIpgO68hmgTb4r21s+81cgSiqtQ52r/Xru/XPVmX5bYSFa1LAnLGcWq
         m6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704937858; x=1705542658;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mLQ2Camh48mLWWN4hephUD+TLzX5ShJOpFW1YgDQOUc=;
        b=pRUdOzRZzRNhkPR0z9K4Hi+d0wLr5KpNQxUCQ8EUJFiDNzOQJvmG5ZByjFgwqU2ZJH
         UJ0c0jIKWZvh7dYLSRRK2nrFGfcRsyo9J9Xquhz6pB36TUo1zBtoOUxyxEap91cWZorQ
         JfS5XB7bW4qeCdd+0q1ZiSfCMV5YvKTRbpYHpQxK6shvxwDXp5dIdisCM/ZCODAis5//
         iBmtYwcqIX6PibWDDiJ6fyWEKOjIX6w0duPZSDZaAAfIPC1ufcCKjrIzjW45iTHtRdZb
         d4inbRTe52Mk7XhT/ASeyJLWB4J+J3V1wlL5sl/EHbdU8auqNWhG5qEstMiLDvFZfTvP
         247A==
X-Gm-Message-State: AOJu0Yykoc2cGSDLkmNFqiXKcrwrfXqUf/6YGffBCZ+kDd0i96emi2kE
	aS6gy4846/RmEhPx7oOz7OM=
X-Google-Smtp-Source: AGHT+IF8iPuhB5cbGoa08NGs5+z1ZCxT+Szujp8q+2XI3lX9qxkBv3cYIC9+3ol5OAFlp7+t1Yzn1g==
X-Received: by 2002:a0d:eb8b:0:b0:5f6:dd94:38f2 with SMTP id u133-20020a0deb8b000000b005f6dd9438f2mr551338ywe.6.1704937858147;
        Wed, 10 Jan 2024 17:50:58 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:b02f:5810:3abc:c82? ([2600:1700:6cf8:1240:b02f:5810:3abc:c82])
        by smtp.gmail.com with ESMTPSA id u80-20020a818453000000b005e7467eaa43sm14368ywf.32.2024.01.10.17.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 17:50:57 -0800 (PST)
Message-ID: <0dd5949b-b6f8-4d88-88ba-cc079096ce32@gmail.com>
Date: Wed, 10 Jan 2024 17:50:56 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next] bpf, selftests/bpf: Support PTR_MAYBE_NULL for
 struct_ops arguments.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, davemarchevsky@meta.com,
 dvernet@meta.com
References: <20240110221750.798813-1-thinker.li@gmail.com>
 <55ada30c-039d-4121-a4d2-efda578f600f@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <55ada30c-039d-4121-a4d2-efda578f600f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/10/24 15:44, Martin KaFai Lau wrote:
> On 1/10/24 2:17 PM, thinker.li@gmail.com wrote:
>> The proposed solution here is to add PTR_MAYBE_NULL annotations to
>> arguments
> 
> [ ... ]
> 
>> == Future Work ==
>>
>> We require an improved method for annotating arguments. Initially, we
>> anticipated annotating arguments by appending a suffix to argument names,
>> such as arg1__maybe_null. However, this approach does not function for
>> function pointers due to compiler limitations. Nevertheless, it does work
>> for functions. To resolve this, we need compiler support to enable the
>> inclusion of argument names in the DWARF for function pointer types.
> 
> After reading the high level of the patch,
> while it needs compiler work to support decl tagging (or arg name) in a 
> struct_ops's func_proto, changing the info->reg_type of a struct_ops's 
> argument have been doable in the ".is_valid_access" without new kernel 
> code change in verifier/btf.c.

btf_ctx_access() mentioned in the original message is a help function
called by the implementation of .is_valid_access. So, just like you
said, they definitely can be handled by .is_valid_access it-self.

Do you prefer to let developers to handle it by themself instead of
handling by the helpers?

> 
> Take a look at the bpf_tcp_ca_is_valid_access() which promotes the 
> info->btf_id to "struct tcp_sock". The same could be done for 
> info->reg_type (e.g. adding PTR_MAYBE_NULL).

