Return-Path: <bpf+bounces-9438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD7A797ADE
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 19:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469F02817BD
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 17:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2788F13AFA;
	Thu,  7 Sep 2023 17:53:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC25134B2
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 17:53:04 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67C019A5
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 10:52:42 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b962535808so22334901fa.0
        for <bpf@vger.kernel.org>; Thu, 07 Sep 2023 10:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1694109156; x=1694713956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hDkQ66F0t2DBT6ld7rUkD2AiaPRnoFJFHtAB4wHE4pw=;
        b=cHBX+NyRtrQvw81yXqq5zbRUcBBMhFmFIT/auANVAPA0ydgTJKdC3APplpxoCZKEXK
         uG+6LJ+Zvzmdtsrhf51N+7L8S8nOWWMB7xxWD7rZje+1MeVQM9wsImDrVmytbg/Z5Uhi
         BqhktNTYGPU6ASQX+fecV8zZ2dVDNkzKaBrBahSSsgpK6Owu/h84iN/wyTKC1AbfLuk2
         pbg1yoVdaVzQOtbjoptfhI2xKqzrZzK0oL14S6aWq4azha1KpZxCqlzZVWsoXc1VS4z4
         7QYsAMpNvpfFHryxD49op1QWHHNynXU0L5gxNHnT2Ho4c/JlhQOzcbdfNLoiPQ8GK13n
         ONLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694109156; x=1694713956;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hDkQ66F0t2DBT6ld7rUkD2AiaPRnoFJFHtAB4wHE4pw=;
        b=R/UC3OEUZIzChKV8Wg+c8mkY+mkUT2YTPni4L52Kpwer6piY7uMgFuiJyvUAe0TBl2
         po/F2PFgZIF1mMB1UZCSQ5azAymcYWo9gwW3pofwZP6hmI/RaoyCgmcBNmrcJDE7kMiF
         oPlZh4c5TUAKiYFe6xsf8bsBxs3WJa4tuE2l3w28fUT/v8FbAokvXvdSLozTkIqsuLNV
         fzAHWIqGPj5FhtHRMbJulPKeqn6um5Adt4Pzi20QI33EGFzfhukqOXN1Cj2MRLfrtCou
         vwxXMESlCbNlFd9fvjTw+Oh2T+dSyl2S/t7PiVgXOtlV3EDtLKbI2+qnNJnQPtMbSSV7
         ohcQ==
X-Gm-Message-State: AOJu0YzijBIzQGQqvlmJd0+A71F2pA/MOt/gq63bT7hfYpN7maZ9xcRz
	QkAfP/VUunvwUtDmMixuJG2Iqdo5cOPGaPnCpnAulg==
X-Google-Smtp-Source: AGHT+IGvuVRW4QDGJWbrzaBzVE7O1UV4/dy4mz+398NKCvbT0eIfFW9nayFN8gJFNwiFd8tJ4vzmzA==
X-Received: by 2002:a5d:670a:0:b0:319:7c1f:8dae with SMTP id o10-20020a5d670a000000b003197c1f8daemr4194474wru.3.1694077166108;
        Thu, 07 Sep 2023 01:59:26 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:ace0:3e80:4307:5b4b? ([2a02:8011:e80c:0:ace0:3e80:4307:5b4b])
        by smtp.gmail.com with ESMTPSA id f12-20020adffccc000000b003143c9beeaesm22642040wrs.44.2023.09.07.01.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 01:59:25 -0700 (PDT)
Message-ID: <15e73381-0ced-401b-b6b7-55b66f873dea@isovalent.com>
Date: Thu, 7 Sep 2023 09:59:24 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: fix -Wcast-qual warning
Content-Language: en-GB
To: "Denys Zagorui -X (dzagorui - GLOBALLOGIC INC at Cisco)"
 <dzagorui@cisco.com>, "alastorze@fb.com" <alastorze@fb.com>,
 "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "andrii@kernel.org" <andrii@kernel.org>,
 "martin.lau@linux.dev" <martin.lau@linux.dev>,
 "song@kernel.org" <song@kernel.org>,
 "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "kpsingh@kernel.org" <kpsingh@kernel.org>, "sdf@google.com"
 <sdf@google.com>, "haoluo@google.com" <haoluo@google.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <20230906111717.2876511-1-dzagorui@cisco.com>
 <3145d302-5ab2-4cd8-974c-6ae1fe436328@isovalent.com>
 <CY5PR11MB6187F0721793B24A00C0699FD9EEA@CY5PR11MB6187.namprd11.prod.outlook.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CY5PR11MB6187F0721793B24A00C0699FD9EEA@CY5PR11MB6187.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/09/2023 09:56, Denys Zagorui -X (dzagorui - GLOBALLOGIC INC at
Cisco) wrote:
>> If I follow correctly, the cast was added in bpftool in a6cc6b34b93e
>> ("bpftool: Provide a helper method for accessing skeleton's embedded ELF
>> data"), which mentions indeed:
>>
>>    The assignment to s->data is cast to void * to ensure no warning is
>>    issued if compiled with a previous version of libbpf where the
>>    bpf_object_skeleton field is void * instead of const void *
>>
>> but in libbpf, s->data's type had already been changed since commit
>> 08a6f22ef6f8 ("libbpf: Change bpf_object_skeleton data field to const
>> pointer"), part of libbpf 0.6, is this correct?
> yes, this is correct
> 


OK, thanks

Acked-by: Quentin Monnet <quentin@isovalent.com>

