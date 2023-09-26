Return-Path: <bpf+bounces-10826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA927AE2DE
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 02:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3B3892816F1
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 00:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9852627;
	Tue, 26 Sep 2023 00:19:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C74367
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 00:19:45 +0000 (UTC)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BCE10C
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 17:19:44 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d84f18e908aso8322771276.1
        for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 17:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695687583; x=1696292383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s56RwOt/5lIHenhoefTmJkKgxIldQ1FMa/AhHgXGdS4=;
        b=lP6fMpdWaBhUdrFyEjA0PomjwtCQHgP4FlKoagIJar5MYVkSxB9RewU462nEOsWrq8
         heKISEaiGxV6epMg2wUXBA9zRODVYJUa9O41X9Iq7faj5/KLMu87TjJsdVr4y9tKXXpw
         i9EOsDPG0Lb/4KqqXk+9BsA2HmDMiGa/sHKyPCRWtwgtWR8QskROFbHbKYorS3DpnZ2X
         dU3aqkWBsIbMjob7DMJh1rJR88qzQzMarHExuE7yxB7/7dzTXpi2JYQZgBVNcWtcT0S0
         bSr1ofyG5M/5XE7Y7S9WhSeTeEFjHqcbIfS/kbJEubtGtziLcCbZ43J2KLV0FG4N8Lad
         ELfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695687583; x=1696292383;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s56RwOt/5lIHenhoefTmJkKgxIldQ1FMa/AhHgXGdS4=;
        b=qglAJDEIS9GtI3RIFUg42+5GSOGwiEf/Ni2qsdhZDw8b+X+gemCm5qcMDvWGEIW0g7
         SMJqdusIMwNx75v9l97LHykUFNiPn87CHSVxSD6tJTOTLBk+3Yopb/WUWcum7XWD6Imh
         YrhKqeydS8zKE7iKncUgnhXkJegq0wpvB2AuJ30wWlwjhVu+JWnypDrG1nLjnKkJiXnE
         nRHbOBE+/kbBOHelBVNmhkMV+GujzfVfN/HxUISg3XV4xk8ErtsrIkDBmCYDu8S3sgEd
         r4ZeiWB67XcgqoFuqufFGNMkkGbTLEkl86h6zOjNJfSe4orJdxU6hPLyDgh9mTlXHzYQ
         FiUQ==
X-Gm-Message-State: AOJu0YxQzFLSREhbcN3/nFZbTLrp0hh9NKn684WVuwb+uqkvcMS6ImD0
	XHpgQXtAoXQJjrGQTJWhK8z42sLnfGM=
X-Google-Smtp-Source: AGHT+IGjFRTutfoPCNqkAVJ72o9tzmaG8VU4HsR9RykBJZQo5axzxnorbgb/lUvIBgDmZchmO1RFcw==
X-Received: by 2002:a25:55d6:0:b0:d85:38:4577 with SMTP id j205-20020a2555d6000000b00d8500384577mr6527458ybb.19.1695687583339;
        Mon, 25 Sep 2023 17:19:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:f7cd:fd6d:2b89:f093? ([2600:1700:6cf8:1240:f7cd:fd6d:2b89:f093])
        by smtp.gmail.com with ESMTPSA id h13-20020a056902008d00b00d7497467d36sm2352852ybs.45.2023.09.25.17.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 17:19:42 -0700 (PDT)
Message-ID: <cbb84fbb-fc4c-69be-eb77-3f12d3dba98d@gmail.com>
Date: Mon, 25 Sep 2023 17:19:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC bpf-next v3 03/11] bpf: add register and unregister
 functions for struct_ops.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
References: <20230920155923.151136-1-thinker.li@gmail.com>
 <20230920155923.151136-4-thinker.li@gmail.com>
 <c757e1cc-2fc9-17e1-6d34-a15e4236fe12@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <c757e1cc-2fc9-17e1-6d34-a15e4236fe12@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/25/23 16:31, Martin KaFai Lau wrote:
> On 9/20/23 8:59 AM, thinker.li@gmail.com wrote:
>> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> 
> CONFIG_DEBUG_INFO_BTF_MODULES is probably too restrictive. bpf_tcp_ca 
> does not necessary need CONFIG_DEBUG_INFO_BTF_MODULES
> 
Make sense to me!

>> +int register_bpf_struct_ops(struct bpf_struct_ops_mod *mod);
>> +#endif
> 

