Return-Path: <bpf+bounces-75540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBDCC883D1
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 07:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6DA34354A21
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 06:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC713161A8;
	Wed, 26 Nov 2025 06:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KT+Qe8xZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pG8WQ0GE"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258E5246BB6
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764137815; cv=none; b=Q76vSJZjgZHhn2HuatjnSFNRfn+s0G/p38F+fZBVBYZVgG4pejJYvy0GoxfKJr4Riona2+s0ubSwnbVmTKIAnKBTb/wDyXp1OlK66Xs5UlQBmM5EiO91DrRtYMjUaCx8N5HuZtqIQJRAia3ebcxI+G/Msb64352FtgUKYzxRpVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764137815; c=relaxed/simple;
	bh=9eZFQ/q2ekN9iEIvDQdSQ38X/rI9wfSyOhAKw/Kv9D4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qEctBaTwx8IIJoAY24hLLuT1BohGjjV+ktxb9balU8ZDm2QjInJPXAWrwrLisqEXHx0/05yLBqRfjyCxr2K5RF7ty6fNzCdkBb4gHMB6L3ihYLN8GqQTmWqsdG80sJf6row1LenrmfV60Mq7rEqCddoRB/2jS+GyEZ1wz10C6ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KT+Qe8xZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pG8WQ0GE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764137813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o3+pnApkvuyBTQ8Q+gd0V8CxAyLJyzgJMoX4H7LnP6Q=;
	b=KT+Qe8xZcRQa7sopbi/VxBLmXFbsIwPzN5FvU0nJTAZgu6+22B7DTjkt6VpBqs4ygIMMCh
	MJYrPICU5wEtGcETAHXxj70mrR7OAblpmM98W3SpKw1Hs30/hzoIiXMkLlsuLSYYuxty7H
	GR4WOykaQjwJ/MoSv3v3RfZYgpZWFUo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-bpD3SyPTP5icWTe1EKMn9g-1; Wed, 26 Nov 2025 01:16:50 -0500
X-MC-Unique: bpD3SyPTP5icWTe1EKMn9g-1
X-Mimecast-MFC-AGG-ID: bpD3SyPTP5icWTe1EKMn9g_1764137810
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-640b8087663so9034711a12.3
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 22:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764137809; x=1764742609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o3+pnApkvuyBTQ8Q+gd0V8CxAyLJyzgJMoX4H7LnP6Q=;
        b=pG8WQ0GE1jW3XU+z9vw6vV+VbETeuBP/bpUG0CU8bYTuwywO9NqSvd9ci484K6F9q+
         VVYBbH0xlR/Dto+SVDkMOvfaV2Ql1yeR1hT6mBVp5RJwCwZCVf1avVLgfSPTtmuUe6O1
         t0pYkwtbv/RI3EZ4KHql2eGo6iF/D+DtAc4c6Z4Ys88ctiEMIL+VpP9y9v55hMXbel60
         Mdoiagi0H8d0a55ZmuurFWQ3+a1Swgomm8Ufe47hGz105pXQ5xYTCwClfPRt5gWRqQUY
         D1vNuIqsTI4/JuqNBvsF8yiWMVEqZ7esTGW3nzaaATtbG6aOf+Q2oqgvkFBOTwzuxY0g
         sj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764137809; x=1764742609;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o3+pnApkvuyBTQ8Q+gd0V8CxAyLJyzgJMoX4H7LnP6Q=;
        b=EQ6q61morcVnV8FysiTneFf9KW9RbSzT7idmIjQVyculB5eQc7OxvXWJ8643k/3LBE
         k6pGKWoOOmMfN24ZXkvXyI9Oi8l5vN+uJ9G97cBgYx2kxAAsDfNBXxfYEFkmgo127D9T
         WPr5UbxP/j+zphnEVJT319oA5Y1RFYgwgHEnP+ebgXXmwaL6IV8J5NAfm58pgw7ql0ht
         DsQBtDyNOBWqq1exg3wCZyFKDRR5Gbc4nFPnLy1ex5iwNFoSU57G+yQ1MaFGXM26eIAs
         IWGpcRj7pqrmM6BRcDy8NTQA0atD8mde6yWBvvy4BiJTn1su5ynoRdVPlhLKwUWfjiUi
         JlHw==
X-Gm-Message-State: AOJu0YzYCwdtrUdJwpBfyDEXLdMEJXgHlQCQ7DAMh7ExREsazd6z4oVj
	XFK6DY1VW07WUpxGVLJFOhIAjrhHtjqRhwz33t7q/pmi0RiX4E9GgSdwez8woJSbbJfTyEmRqh/
	wFTHLS6U7TBmJ5a3oAfsXUDonGUTjLg81Rv3togmiMG0Mw/3PhSb4
X-Gm-Gg: ASbGnctEDVvNvKkmvKUCNaZhPVDEMG6SXHMJtiKTgiPdy5Co4Ll7JkjWMyx1cWXSr5S
	ELwJhpBR6KnOfdTrRdJ7AUTwck61IBVKbuv+bbNAWeYgyHJZ3Ibv9aBOCx7Jfkh2CmQszkRpPP4
	jc4W2stKHC/s9/6HFcVHZy5xzBvojeeZ7Wwgk6FQeRvFJa3RUUQKVxbDBVtdGE+w1fEaGl+tYjr
	7wGJNUqh3upIPJ7R/D7SEiCxkfYTULvpU3n7tOnZcBlZ3Z8J+gbNWu2rnaMcckDckO+8HKZ4y9k
	hoYJVZUVedDmDnkO5VBO+gQh8jQzuPwfuJbv9np8MFokEdQ27TIjGO32143e2bkN0Eae/sfSq3j
	3Bf/mNWmmKrXBcqa781wiQl9GecfMkdNveqZf20i32Yc=
X-Received: by 2002:a05:6402:909:b0:641:24cc:26d7 with SMTP id 4fb4d7f45d1cf-645eb23d89emr5073795a12.14.1764137809586;
        Tue, 25 Nov 2025 22:16:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6sQiMKowZpXuXDvXhg7pCLn/B03mdbNUfdFSc/JPw5sFieDhc6SZi6GKr3IsucbbmQ6hX5A==
X-Received: by 2002:a05:6402:909:b0:641:24cc:26d7 with SMTP id 4fb4d7f45d1cf-645eb23d89emr5073780a12.14.1764137809168;
        Tue, 25 Nov 2025 22:16:49 -0800 (PST)
Received: from [192.168.0.102] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6453642d321sm17101222a12.20.2025.11.25.22.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 22:16:48 -0800 (PST)
Message-ID: <bd4ed630-b370-4dea-aa19-5c3797106dce@redhat.com>
Date: Wed, 26 Nov 2025 07:16:46 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/4] bpf: crypto: Use the correct destructor
 kfunc type
To: Sami Tolvanen <samitolvanen@google.com>
Cc: bpf@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250728202656.559071-6-samitolvanen@google.com>
 <20250728202656.559071-7-samitolvanen@google.com>
 <2bcc2005-e124-455e-b4db-b15093463782@redhat.com>
 <CABCJKudpUh7i9PTWV_k5ZWehkyRvHcRTwSOWQu_1yjCE9h_bTg@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CABCJKudpUh7i9PTWV_k5ZWehkyRvHcRTwSOWQu_1yjCE9h_bTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/25/25 21:16, Sami Tolvanen wrote:
> Hi Viktor,
> 
> On Fri, Nov 21, 2025 at 8:06 AM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> On 7/28/25 22:26, Sami Tolvanen wrote:
>>> With CONFIG_CFI_CLANG enabled, the kernel strictly enforces that
>>> indirect function calls use a function pointer type that matches the
>>> target function. I ran into the following type mismatch when running
>>> BPF self-tests:
>>>
>>>   CFI failure at bpf_obj_free_fields+0x190/0x238 (target:
>>>     bpf_crypto_ctx_release+0x0/0x94; expected type: 0xa488ebfc)
>>>   Internal error: Oops - CFI: 00000000f2008228 [#1]  SMP
>>>   ...
>>>
>>> As bpf_crypto_ctx_release() is also used in BPF programs and using
>>> a void pointer as the argument would make the verifier unhappy, add
>>> a simple stub function with the correct type and register it as the
>>> destructor kfunc instead.
>>
>> Hi,
>>
>> this patchset got somehow forgotten and I'd like to revive it.
>>
>> We're hitting kernel oops when running the crypto cases from test_progs
>> (`./test_progs -t crypto`) on CPUs with IBT (Indirect Branch Tracking)
>> support. I managed to reproduce this on the latest bpf-next, see the
>> relevant part of dmesg at the end of this email.
>>
>> After applying this patch, the oops no longer happens.
>>
>> It looks like the series is stuck on a sparse warning reported by kernel
>> test robot, which seems like a false positive. Could we somehow resolve
>> it and proceed with reviewing and merging this?
> 
> I agree, it does look like a false positive.
> 
>> Since this resolves our issue, adding my tested-by:
>>
>> Tested-by: Viktor Malik <vmalik@redhat.com>
> 
> Thanks for testing! I can resend this series when I have a chance to
> put it back in the review queue. The CFI config option also changed
> from CONFIG_CFI_CLANG to just CONFIG_CFI since this was sent, so the
> commit message could use an update too.

That would be very useful, thanks Sami!

Viktor

> 
> Sami
> 


