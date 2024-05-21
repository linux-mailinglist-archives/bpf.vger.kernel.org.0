Return-Path: <bpf+bounces-30092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBD58CA8EF
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 09:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CEFC1C2113F
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 07:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A3C4EB31;
	Tue, 21 May 2024 07:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVFGgBl9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084A347A7C
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716276681; cv=none; b=c32HlCjXcemrA1lHolap67pbqH5F9j1GMeRAQLB+LsYudl8kEsDkj4jRNNGxkrSHAJCO8//ff2jS+tNlfmY9+f3gIAY5OCsRSUq5+JDtmni4QB9EO5WrZvFyvLZTkLDnMKYi5qWxL7HMx++ekxEQ2vi8vZSCtJZYbYVA3Y7S3GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716276681; c=relaxed/simple;
	bh=ElRWgPfCzecpdRkFyUpiTRfhURQJqOKEY8D1xjtbUBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Inx/rPI7cXoghodYBQPw/wEUhq9TTWefDMP10ybswCuyoowoNwgt24hdzobdn2sOeblaWhyfYbMbUMaYQrIXV+MZMVYTiLHRvpdhWO0QCRXxKHEKkYBPMoFKoiUbeD/aC130UybgQUG9yX365y8pOGAml2jU6NZMbfaon5ur+OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVFGgBl9; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-61ae4743d36so33486597b3.2
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 00:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716276679; x=1716881479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mgaQdT4HUrNAFJ7ZIiyBzhOYVNw0AiDfuK+SkKs4+Ok=;
        b=ZVFGgBl9O8R/6YfBP5rw70Ab71+fGzrvK2WoeF487ii7Hr6UNMEO4bpqopeUmokjRE
         VMAerqC0Zi08/v69j41KS8dutO2EGGGui5ZN+vE9v/89JKudG8hlYSUSujxk/7N0vIHg
         7OJEUufSzv4kND/j3pEsW7TUsDPmZC463O7+2LaSyoZ+RACaHD6zhiRPxmow3bRpzVPG
         ROo0v8oL/wHki8coWuXYzt/stmv1hWrZpMCql2dRbapLxAkEgTYvRBsVUDQ1NAuZIpcu
         +xnD2fbbbuRgloBOSRkKshWLoijlgmoLehEs/+mq5J3pH//w3xEQl72DqlG3xn+hTxfA
         H1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716276679; x=1716881479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mgaQdT4HUrNAFJ7ZIiyBzhOYVNw0AiDfuK+SkKs4+Ok=;
        b=c+YaWpvHUNdfB4lqLT3jnRhdJzjUJNJdbeyUCyXwTbPRzYK/xM2w7GNj8cSsKW3sgl
         T2xzgLuorybiCAD5RA2ZD5BOP9idaTfzMy6WD0L0x/O7agsYNnyZo6E7jKz8WAMAZ6kF
         OrmgIm91FkTJYy7GQkQmkt8LsMJYHKsvD38rcky9xof2dpwQ5MgedRquxPXVOYYlgz+n
         oOO4amQqApV3aR4bX+6u4h4eO7T0oFvA9R/0MxFI/zk9YSS6WTJ0UDwmiknWt5iJMU5i
         O3FKeWuXFVvXdd4EoK9G1f7fIW8MN/pqEQtuyfh51Dd7+AfgVGKaKEL1eJB5Krl8YWwG
         ODCA==
X-Forwarded-Encrypted: i=1; AJvYcCUHeRWrOVkGxWHcKqd2bezbqHoSE9a31pbUdZEZTcAxdPIWnKeL5PAhwiZ4vPeKCD/dzt+GaZ/vpjSEsJ/zJeZ4KFOV
X-Gm-Message-State: AOJu0YwJDZuzTk4LkQ8Qh/kIF4KBzlP07KpO1cecVj4cpRZ1f3WSCG76
	9TELKoXIxIX13wYYhoTBNwzIIAsMGYgQqFZk+wsodGXrpDFshFDy
X-Google-Smtp-Source: AGHT+IGG/uqXRHaXm0Xcf59xOBGBDh0bjaYGkyyaXG6XQkqFV671nRWTpFJT51KLmekBfXyovOnlxA==
X-Received: by 2002:a81:b04a:0:b0:61b:3364:d193 with SMTP id 00721157ae682-622b0147aa9mr281652507b3.40.1716276678961;
        Tue, 21 May 2024 00:31:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:b99a:bfaf:f0e4:a7d6? ([2600:1700:6cf8:1240:b99a:bfaf:f0e4:a7d6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e345d36sm52952217b3.88.2024.05.21.00.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 00:31:18 -0700 (PDT)
Message-ID: <41b07b48-f5db-49b3-b156-b3e192913712@gmail.com>
Date: Tue, 21 May 2024 00:31:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 3/7] bpf: support epoll from bpf struct_ops
 links.
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
References: <20240510002942.1253354-1-thinker.li@gmail.com>
 <20240510002942.1253354-4-thinker.li@gmail.com>
 <708a8b9f-45ce-48f1-9c6b-bbf226faf679@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <708a8b9f-45ce-48f1-9c6b-bbf226faf679@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/20/24 18:26, Martin KaFai Lau wrote:
> On 5/9/24 5:29 PM, Kui-Feng Lee wrote:
>> +static __poll_t bpf_struct_ops_map_link_poll(struct file *file,
>> +                         struct poll_table_struct *pts)
>> +{
>> +    struct bpf_struct_ops_link *st_link = file->private_data;
>> +
>> +    poll_wait(file, &st_link->wait_hup, pts);
>> +
>> +    return (st_link->map) ? 0 : EPOLLHUP;
> 
> nit. It should need a rcu_access_pointer(st_link->map).
> 
sure

