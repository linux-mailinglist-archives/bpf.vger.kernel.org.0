Return-Path: <bpf+bounces-13772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CEF7DDA5E
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 01:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57AB728194B
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 00:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A8C65F;
	Wed,  1 Nov 2023 00:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iINE9xxh"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4269736B
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 00:48:22 +0000 (UTC)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66047F5
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 17:48:15 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5ac376d311aso63519547b3.1
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 17:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698799694; x=1699404494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HVdJ61Th2mnG6E/DildCIHsfb753DZdru8YOhdMIwpQ=;
        b=iINE9xxh08Mz27KFOo8HgF0CvF2JrKU0OZ+UiikypCfoBmEB+Wb1VpNz0p5R8sDLH5
         tgBxe3bXPslT4GIvKhfSzTajQZY5RIi2M66qnEtC3cYwhKFy5FiJkg5NMPMsUBLfE9TM
         3BZkKww+HcMteG2h0G84XKmaYhwFbU96OHqnDi8yqfEHdzVQLXMLSMrg/3Hyi4hjozGD
         n3RHYLIhBqbkRM45vBx5K8ExfwaLeH7DSWdQ8CsMs0pa3JedQK/kuFdG57WG/TbMsOmz
         2KFPtnG7D1Ajax+zFe65cw1aRXl3a342APm8VIBJKyCEwXyKriQmptuip3iRv9eL9dv0
         enwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698799694; x=1699404494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HVdJ61Th2mnG6E/DildCIHsfb753DZdru8YOhdMIwpQ=;
        b=u2N+K5jKxgiNqcMX7PV5W8ikZwg3nHEOMMsWqQl/hONO5SE6Mn+LolRvjczoHzcy1j
         DMfOf6yDuGKlTALnBGPlchBeGOg6KoXTn5G3opruOY45PiTIH1qiEUttNSmQcEAeYW7v
         tfK1xS/xP/w+13/wEYwy2Noh9dkf9ioOdNL3rFc2xsyedp6YxsanOlypOLDQckaOnRqQ
         4rgyl0psIDLqIp+QeeGNnBL7+wZXWYDlb9ZQeUBw6KJrRzlkXIyfF8rV/hux0FsJutct
         YW8pUxjaa4unuRyRevkE80ud/wYVd6gWC1SFgBnuf+3T2h/QKlwU6oGLRz6BK0FIQJeJ
         D8dg==
X-Gm-Message-State: AOJu0Yz7mmpW6K+Jk0GdDxVStxz8Lrs+O18yVPUR4esaO+KJwGbJjx90
	C1TlRNvzssQclEB52JlxSbE=
X-Google-Smtp-Source: AGHT+IHBfc+e8vk9lVq09ExP45xvNeW7GPTBmpK4nJtrn4cPA9DVn9TQIIy2AI6UjRqkyJjqWRJNsQ==
X-Received: by 2002:a25:cb47:0:b0:d9a:6855:14cd with SMTP id b68-20020a25cb47000000b00d9a685514cdmr13047826ybg.39.1698799694621;
        Tue, 31 Oct 2023 17:48:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:ac50:f3c6:2a0c:d29? ([2600:1700:6cf8:1240:ac50:f3c6:2a0c:d29])
        by smtp.gmail.com with ESMTPSA id k14-20020a5b0a0e000000b00d815cb9accbsm1429717ybq.32.2023.10.31.17.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 17:48:14 -0700 (PDT)
Message-ID: <57c8e622-f2eb-4f71-8016-166c8fd50fe9@gmail.com>
Date: Tue, 31 Oct 2023 17:48:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 00/10] Registrating struct_ops types from
 modules
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231030192810.382942-1-thinker.li@gmail.com>
 <ab5a1dcf-7a3f-bc42-a73c-292911d54c18@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <ab5a1dcf-7a3f-bc42-a73c-292911d54c18@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/31/23 13:45, Martin KaFai Lau wrote:
> On 10/30/23 12:28 PM, thinker.li@gmail.com wrote:
>> Changes from v5:
>>
>>   - As the 2nd patch, we introduce "bpf_struct_ops_desc". This change
>>     involves moving certain members of "bpf_struct_ops" to
>>     "bpf_struct_ops_desc", which becomes a part of
>>     "btf_struct_ops_tab". This ensures that these members remain
>>     accessible even when the owner module of a "bpf_struct_ops" is
>>     unloaded.
>>
>>   - Correct the order of arguments when calling
>>      in the 3rd patch.
>>
>>   - Remove the owner argument from bpf_struct_ops_init_one(). Instead,
>>     callers should fill in st_ops->owner.
>>
>>   - Make sure to hold the owner module when calling
>>     bpf_struct_ops_find() and bpf_struct_ops_find_value() in the 6th
>>     patch.
>>
>>   - Merge the functions register_bpf_struct_ops_btf() and
>>     register_bpf_struct_ops() into a single function and relocate it to
>>     btf.c for better organization and clarity.
>>
>>   - Undo the name modifications made to find_kernel_btf_id() and
> 
> The find_kernel_attach_btf_id name change is still in patch 8. tbh, I 
> don't have a strong preference on the name here. Could it be in a 
> separate patch for naming cleanup or at least mention it in the commit 
> message?
> 
> 
Sure! I will remove it.

