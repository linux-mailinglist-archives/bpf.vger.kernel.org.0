Return-Path: <bpf+bounces-58311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64300AB8669
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 14:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1461B61B69
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 12:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23A4298C18;
	Thu, 15 May 2025 12:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+dEWkou"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9362253EB
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747312378; cv=none; b=mJRigcy4FYC9eKzLyJjCw1069GkePN8FCdnqwXUJYk47i1Yns4jgqbIBu6h36CNKq+Xag9F2MB539oL1jlK6suC48kTKl9ipJmaGjHSXLwRf24zQ+tDzKDxi2PhHi5Ayskc0Y2a86+L83ITNiG22Hak6dbsRKM1BnJ7Y2lPNLpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747312378; c=relaxed/simple;
	bh=Ru8Q+vxiBUt18ff6W0rMlzot8mq65vIxv9ktb/fBs80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XeWAWh87aPc7yJlL5F+eTXturiUIvP86MrMjRCa/1B2I/jp1dUd9VHCNjxSL0tV3axlOmYIt6Sq4t/iBFQEafp9qIWw+jWRVtKIpZjLcZpLePrp5FK6jQfRgcNmwPvM1DsKNo0y7/eyUVfYa6He/JVuGEW8T0/ZGcEwQeqYG93Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+dEWkou; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747312375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pf8QjtSq6fGylXwoO4koU2e1Iva2rtNjkaDEcgV89/0=;
	b=O+dEWkouMwvl5KfJ2fxaJF4n2XKaHj93zfyhFAmZMiOgAacBXv/UfwoZBKf2z/7x9cmudd
	wdQB6K/isR4GjJfB9QabG7ps+FARaUPUB+uMEjXsIQYAxcA90R2m2XJejea5eJuiU9iRt9
	cPCu8Rh56h/U2S3z+51GTHCIY0be3kQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-r-aEmfWkNy-ORP5ohdyKNg-1; Thu, 15 May 2025 08:32:54 -0400
X-MC-Unique: r-aEmfWkNy-ORP5ohdyKNg-1
X-Mimecast-MFC-AGG-ID: r-aEmfWkNy-ORP5ohdyKNg_1747312373
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a0db717b55so594073f8f.3
        for <bpf@vger.kernel.org>; Thu, 15 May 2025 05:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747312373; x=1747917173;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pf8QjtSq6fGylXwoO4koU2e1Iva2rtNjkaDEcgV89/0=;
        b=TwjAhPjQqJBqSz9NA640f4b9HSmVYObpUxjPbrUOri4JJ5kyX5qB2eir1KSdlTh4Fj
         TKBSrJneLgLirpv7lahyXzwK/npDuVMKxinoiFf7h7H1ooySyfOxqXRcp0Z5vCjnRvzc
         O0nVU6URhU4vhuXm96HcQAcWOA4AyhGqrM1tOTvFR4iYs1KTSqZOt4OMuNxUWRZFc5uk
         jLZCKeiUYJepsE7Q5snaw1U7gzHSFRtSk1CEMFs8wyrVB/fRO9Y5dYFNHrvY2LvDbKNz
         IGyxNF2Mm/v94+Wpvvixqk07NiLL47Z6VOYJRK2cLTBffrGJUGrRCblyzq8BbUB2jcUr
         GUag==
X-Gm-Message-State: AOJu0Yz5DlSIYtly8IrdoVe49br3ooFvvtuTEuFLtTj5+AZys55o7iEp
	cS0UGnXzn6RkrtvFDawh1dSjjFo1C04wli6x2aMh+SKpneyfCvk0lJ2zpqQJ8n/Hwpmyx04Lsn1
	TwMJ2oCb2lNr99HFNw6KPZ8GqRy4MQgtAcA2QkOjyJUk5aCKr
X-Gm-Gg: ASbGncspvOlstRvAqwo2F5Oi8cjbnPF7cCQKty2tNQWUc6/Z8FwBPARMPArvmwDo2s5
	vPII+kIuMs9+eZPKmdAA3QPhT9MQFjIKX/oFgHaPgj/74iwwB1Ydoh9xJnvoz5CPXmkspiwN7+w
	BdDxgEFbmRWQrmDx+q9eO8IW5BmoasLf8sDgBLNf6TEgr4+wdjIiGqME7H5NmoNF7ER7uRsjALK
	SDPpsXSVxJb49l+il3/IOeq/9F9UhKweIEgc4NA59lMbS2rIQ/jDoQA8sJu1XbqM4ACQERgm9Gy
	9E+ChjdLvT/MoOiT/gr7uAnMOSQPkO6/5WXYaUhcd9mtYg==
X-Received: by 2002:a05:6000:4287:b0:39c:2669:d7f4 with SMTP id ffacd0b85a97d-3a3499224bfmr6859813f8f.43.1747312373110;
        Thu, 15 May 2025 05:32:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0Mp4vbvytfHk3Ets8amJbpg0wdaBqaxVBJjCN8eKTjE1/jxa7qH0pvbIYGhJMHzbrjLuQUw==
X-Received: by 2002:a05:6000:4287:b0:39c:2669:d7f4 with SMTP id ffacd0b85a97d-3a3499224bfmr6859779f8f.43.1747312372719;
        Thu, 15 May 2025 05:32:52 -0700 (PDT)
Received: from [192.168.0.102] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39e851bsm69623215e9.28.2025.05.15.05.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 05:32:52 -0700 (PDT)
Message-ID: <e347a73b-bacd-435b-bf9e-13db3b6be186@redhat.com>
Date: Thu, 15 May 2025 14:32:51 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 3/4] bpf: Add kfuncs for read-only string
 operations
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <cover.1746598898.git.vmalik@redhat.com>
 <19913411da8c08170d959207e28262efc0a5d813.1746598898.git.vmalik@redhat.com>
 <aBx8Zjux0bSgtV04@google.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <aBx8Zjux0bSgtV04@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/25 11:41, Matt Bobrowski wrote:
> On Wed, May 07, 2025 at 08:40:38AM +0200, Viktor Malik wrote:
>> String operations are commonly used so this exposes the most common ones
>> to BPF programs. For now, we limit ourselves to operations which do not
>> copy memory around.
>>
>> Unfortunately, most in-kernel implementations assume that strings are
>> %NUL-terminated, which is not necessarily true, and therefore we cannot
>> use them directly in the BPF context. Instead, we open-code them using
>> __get_kernel_nofault instead of plain dereference to make them safe and
>> limit the strings length to XATTR_SIZE_MAX to make sure the functions
>> terminate. When __get_kernel_nofault fails, functions return -EFAULT.
>> Similarly, when the size bound is reached, the functions return -E2BIG.
> 
> Curious, why was XATTR_SIZE_MAX chosen as the upper bounds here? Just
> an arbitrary value that felt large enough?

Yes, exactly that.

> 
>> At the moment, strings can be passed to the kfuncs in three forms:
>> - string literals (i.e. pointers to read-only maps)
>> - global variables (i.e. pointers to read-write maps)
>> - stack-allocated buffers
>>
>> Note that currently, it is not possible to pass strings from the BPF
>> program context (like function args) as the verifier doesn't treat them
>> as neither PTR_TO_MEM nor PTR_TO_BTF_ID.
>>
>> Suggested-by: Alexei Starovoitov <ast@kernel.org>
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> ---
>>  kernel/bpf/helpers.c | 440 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 440 insertions(+)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index e3a2662f4e33..8fb7c2ca7ac0 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/btf_ids.h>
>>  #include <linux/bpf_mem_alloc.h>
>>  #include <linux/kasan.h>
>> +#include <linux/uaccess.h>
>>  
>>  #include "../../lib/kstrtox.h"
>>  
>> @@ -3194,6 +3195,433 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned long *flags__irq_flag)
>>  	local_irq_restore(*flags__irq_flag);
>>  }
>>  
>> +/* Kfuncs for string operations.
>> + *
>> + * Since strings are not necessarily %NUL-terminated, we cannot directly call
>> + * in-kernel implementations. Instead, we open-code the implementations using
>> + * __get_kernel_nofault instead of plain dereference to make them safe.
>> + */
> 
> Returning an -EFAULT error code for supplied arguments which are
> deemed to be invalid is just a very weird semantic IMO. As a BPF
> program author, I totally wouldn't expect a BPF kfunc to return
> -EINVAL if I had supplied it something that it couldn't quite possibly
> handle to begin with. Look at the prior art, being pre-existing BPF
> kfuncs, and you'll see how they handle invalidly supplied arguments. I
> totally understand that attempting to dereference a NULL-pointer would
> ultimately result in a fault being raised, so it may feel rather
> natural to also report an -EFAULT error code upon doing some
> NULL-pointer checks that hold true, but from an API usability POV it
> just seems awkward and wrong.
> 
> Another thing that I noticed was that none of these BPF kfunc
> arguments make use of the parameter suffixes i.e. __str, __sz. Why is
> that exactly? Will leaning on those break you in some way?

The reason is that they both require literal values to be passed which
is a limitation that we don't want in these APIs.

Viktor


