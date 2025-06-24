Return-Path: <bpf+bounces-61360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B046FAE6081
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 11:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B22717922A
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 09:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DCD27C844;
	Tue, 24 Jun 2025 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RbbkKlNS"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D0027A103
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750756546; cv=none; b=gBj9DGYXnj9+Ds8+UqamgSSTIIdEj2y34T/kxjIpjVnY8ot32H98yk+3AIgwguPg6hGTuQYHkkPDbevOwDYpXIU1BQ30W75oiaSaUvbvVAlNvA7mTBuDuiPdh4DMdmgN624Wt0kwM8oYY7hh7WQNQtTwLZSuSx/Ir9H0IGnbHtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750756546; c=relaxed/simple;
	bh=9HAJo4Nztr+xAPzMhs7zhUBdvj45BI5IMJo9NMRd+AY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfBLfDO1C+i8PDFydJvMcnp6PguTglixyINbH3OTl21Txg0Px4NpevjJy8JEx8G8eH6pWa2deQbuuckoCFfma+0kKtwI255PGF/MwW0SxRFV8pQYm4WjefP2toIVrS11Qio6go2i0PTm5Jw/dRVx40ziFTmOP9qS3+Fv7/db8Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RbbkKlNS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750756543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I/9VM/crfSC4YXKxEDdN+WDYjHySqznHwZy2cCNJiso=;
	b=RbbkKlNS5ts726t6yW+8qHwIHP+AeBShuhOfOOfNlHFZeDZ5LORzoyhLwfrReC+7xlAaZ3
	vOsLtiQWJuRup02wPL9zfQEds1Nc7DRpB1HArWWXYKMN9LPIwQsLxt3sucnNVaJ0xfxsOw
	X2yelk8Mocj9efQ/4PnkZenLBhnfCEA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-fGNbUvQSPzuK8lCZtQ28Wg-1; Tue, 24 Jun 2025 05:15:41 -0400
X-MC-Unique: fGNbUvQSPzuK8lCZtQ28Wg-1
X-Mimecast-MFC-AGG-ID: fGNbUvQSPzuK8lCZtQ28Wg_1750756540
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-450de98b28eso27274335e9.0
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 02:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750756540; x=1751361340;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/9VM/crfSC4YXKxEDdN+WDYjHySqznHwZy2cCNJiso=;
        b=Guop96oKLe3JPr4RoNzhEUYuKXlroXLj752ZFXzv5FBBEyIGGULDpUvkirUCSQP5P+
         y0j/5VSiqE3EPAQdRZS72oDfK6C5CZ5g0bYX2/YwosM153R2by1DbjIrG0p5GBJZPDHy
         VEV4rY6GiDhH5oIp4adWKxiCOQ2hM5CmTKgsx1iCS01znyQ/F2CC4p2reyD5Hxe52aTo
         AlbwXVeFQtHeH8uRE/IviUOKzdrRjTHcxuWl/y2K7VS2kja3+uOMO3ZHasJZymYUpHrt
         bIDtltuZ1SshEtSa0H5WxxGmkLv0cmdBZt4B1a1L0K4Lld+pQSZJQTCFiCBqd/wu/9k8
         x7YQ==
X-Gm-Message-State: AOJu0YyCvzjZntIU9xkLBNYTB3x8pJRbA/Pn97yEAI0WY27Z4A90Hesv
	tvNUwM88vkCAqkdYIJZW0m5uA/EbZ4RSGfvm0V5X56Sb0WN1td5iBMml/p9kv1X0zK8U0xTyN1L
	NJcrcvcRdegI8fmstRDhZB5RBjowuyS7h3k8QT0heVhFFELr+qZee
X-Gm-Gg: ASbGnctrSNYnqImFmNxdEQFKIRi566W6a6314FoL68/qC3lnGKTmtyt29TnQhHc3HhJ
	EsbDGh1La7Nvkyy0O8qCJhzTBrg1X8zA06kRuNGDIt79AOAIRHMw6C+rrjLelgOOs7b4ikxLMIo
	mq7I7N45P9Pi1Y2EbX7bfYo1YC1m3/phc8sHzAx5ume4Iq9tE4V6WaRwsv45SsQFYu6r1L5udcC
	34+4tGSuYy9/am1E3bcUXr0F69UWj9WXUGFAbQUc1K/b2zLltHb7/g4w6u6118T0dpr2+n/COVn
	55i9CDD7e1UJFfuqlQdAH7JZF3Em8de8KXhEZ9Hm3104rOzUa4DT1Z6L
X-Received: by 2002:a05:600c:190a:b0:442:f4a3:a2c0 with SMTP id 5b1f17b1804b1-4537b79b8e6mr25318825e9.13.1750756540240;
        Tue, 24 Jun 2025 02:15:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSeP7GOnY6RUoSQ/Ih22bvSOTYoZMGXWEWr2cRSNOTpzSajg+dLNI3ZOrc0lB1syARB3eMxw==
X-Received: by 2002:a05:600c:190a:b0:442:f4a3:a2c0 with SMTP id 5b1f17b1804b1-4537b79b8e6mr25318345e9.13.1750756539707;
        Tue, 24 Jun 2025 02:15:39 -0700 (PDT)
Received: from [192.168.0.102] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e811039csm1394342f8f.89.2025.06.24.02.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 02:15:39 -0700 (PDT)
Message-ID: <30b84faa-98bf-403c-91ad-4fa5d1caa6bb@redhat.com>
Date: Tue, 24 Jun 2025 11:15:38 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 2/4] bpf: Add kfuncs for read-only string
 operations
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <cover.1750681829.git.vmalik@redhat.com>
 <1b75082af9f349a0c20aa49a47d003fc1b81e5f5.1750681829.git.vmalik@redhat.com>
 <CAADnVQKZfUOd62wc9wP7UtnxFfiJE+E_563PHU-n-f5esaOfFw@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAADnVQKZfUOd62wc9wP7UtnxFfiJE+E_563PHU-n-f5esaOfFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/23/25 18:42, Alexei Starovoitov wrote:
> On Mon, Jun 23, 2025 at 6:48 AM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> +/* Kfuncs for string operations.
> 
> Pls use normal kernel style comments instead of old networking.
> That's what we prefer for all new code.
> 
>> + *
>> + * Since strings are not necessarily %NUL-terminated, we cannot directly call
>> + * in-kernel implementations. Instead, we open-code the implementations using
>> + * __get_kernel_nofault instead of plain dereference to make them safe.
>> + */
>> +
>> +/**
>> + * bpf_strcmp - Compare two strings
>> + * @s1__ign: One string
>> + * @s2__ign: Another string
>> + *
>> + * Return:
>> + * * %0       - Strings are equal
>> + * * %-1      - @s1__ign is smaller
>> + * * %1       - @s2__ign is smaller
> 
> Here -1 and 1 return values are probably ok, since they match
> traditional strcmp.
> 
>> + * * %-EFAULT - Cannot read one of the strings
>> + * * %-E2BIG  - One of strings is too large
>> + * * %-ERANGE - One of strings is outside of kernel address space
>> + */
> 
> ...
> 
>> +/**
>> + * bpf_strnchr - Find a character in a length limited string
>> + * @s__ign: The string to be searched
>> + * @count: The number of characters to be searched
>> + * @c: The character to search for
>> + *
>> + * Note that the %NUL-terminator is considered part of the string, and can
>> + * be searched for.
>> + *
>> + * Return:
>> + * * >=0      - Index of the first occurrence of @c within @s__ign
>> + * * %-1      - @c not found in the first @count characters of @s__ign
>> + * * %-EFAULT - Cannot read @s__ign
>> + * * %-E2BIG  - @s__ign is too large
>> + * * %-ERANGE - @s__ign is outside of kernel address space
>> + */
> 
> but here and in a few other places returning -1 is effectively
> returning -EPERM for "not found".
> Which is odd.
> Maybe let's return -ENOENT instead ?

Yes, that was my other alternative, I'll change it.

Thanks.


