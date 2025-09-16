Return-Path: <bpf+bounces-68495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2459DB59576
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 13:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50EC77B3B8C
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 11:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288CC3074BE;
	Tue, 16 Sep 2025 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/eFK+6M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2345225C70C
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758022992; cv=none; b=lxPPQzi+DiEQNnsawAFNttLhVK42a4RCXzFt1KCIxoYVFvRuqcC8LqTWlAntzD+ddSZEs5B7p2WGuloRJ4Tgxe1kC4txsniPwAf6EZjWwl4kvUwmKeEj4UqhKMMdg9w0/9bDKE0PJ3HdP3y/taQazj5WPASWVGf6wu3T8ERliok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758022992; c=relaxed/simple;
	bh=ipYtZDE0cVdd87O4uisJRIE3VDN+TVZ8qRQcdJMSCDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=szu5JNG5xurlEYQC+Nq0cEYtp4je2ZFoIDOiGCbzZZTY7b0mj42qPb+bnRejgBI+VWuNdcQtOfsW8VUwYCGpXrF/Pka/nyf9pF81ucZKl1boiXZncSK5VFYtOyALHvJ5R77TuyzY6b12RO6J9HmyrTz7hwx1Hl1YJ+5VmY10/hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/eFK+6M; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ec4d6ba0cdso783101f8f.2
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 04:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758022989; x=1758627789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ipYtZDE0cVdd87O4uisJRIE3VDN+TVZ8qRQcdJMSCDo=;
        b=a/eFK+6Matm32aM5wOJcYVbrdmPLp3BTHNIOfbRAnQSpsiU0DoNs2Kph7zFVsLglP7
         1n9pv0263uJYvK509ZbHU/31+8BliANbiRsx1p16GJU5wkcny7hKLbLQpqv43lTL0eme
         rZQZtd440XfnP4CIX41WbI3Qfy5R01SufWqpYnuslf5LpF13dsDAwlRO503hvIcz4gaL
         mJRrOlfcWgeHvIyJP1fVTO/SoUyRB+h4JycFGjCyQCzNMQYT3d08rasU80bGahkcliPq
         LoaGNCAwc/s+Hj4nRGLn1x9+/ZI8OOSSvWEfYLLorDSHmInVSDzAx+EAXr/culW/6hwj
         zYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758022989; x=1758627789;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ipYtZDE0cVdd87O4uisJRIE3VDN+TVZ8qRQcdJMSCDo=;
        b=fYkqlm0BN7GbThu9csoaqysTIIYhTOsZonD21pfok8HARN2q36JPhkYJsycIktul8T
         rRnpHvbOQkSDxEAWZV6AzT7bZKpndce5m6bvvbCIs7Xv8sjwAAUoJ0QYUAFWJw6eA3Nf
         EWjc9+LDidPkykyVgOdS+ovdDHUIsfW5dEHtjCfJib0bFbcfhiNzPzjcWcOXm9YsrSoi
         5Wr1froof98Lz8S5suZPc8JXFCSGQulp3IM6GTQUGgdJog+Ifn+sOY1WESSU2REdM5Sh
         4/hNrOvzHhpOuCaXyR0pmgHth+q7Vw/ag+8Byctfj57hPmRRSGJD4U1mo1alR7c8yLzi
         xZhw==
X-Forwarded-Encrypted: i=1; AJvYcCWapWW8El+9d7B+Ss44yFi0RTg9GYrnob8DjpzpxFH5p+zpI4COsZaEZbje9nMMO8gZTHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiwOBG47uVRN76OafF9Agjr+wXJZGBrhLxNcg1eQmZ6TraR1JV
	5mr06dlnK3VdVEJQLoYH4oIb8I95Csn9HE+psoXmbCVIah2Isn38bTTWx9diMg==
X-Gm-Gg: ASbGncs6HH9+gLcQdJI6t/F5JYtD2JJo8S8OOCE5sok+EcEQnExAZYnVyJuB6/D3HbF
	4pHb8EpEfqx+1GxvKALkiwDzxtiwjZ/+loPjBUslj26m8lE4pN02L9Ry8t3sPUoeVWaPj1HZK7E
	cyJHRuwcb0UxTSBlkm1kvwqHzc/pneuALXgYx9DeQvYYZ9SihZwfbmYugz6+hS5L7opB+zMDkVH
	INZjt4zMYmAJJ17Z+/2Lnzo2K4R58zscOQE8F2s2nuyQ+Mxzl3+QlHjYtzx+wd2T0on22mqLmWR
	AyDl8paGO8W1iiIX2Y+gKBfmR+JtYdAHB4oyco+oOh0+3o6FLpHPsD13IQ4RpXG+dm3rzW4vi+y
	PoYGC8pxHhuBhapp4+ANqzTOFTcTT7f8qQTv1sPWK6KI3IuHJ3LWThXhFlsIa
X-Google-Smtp-Source: AGHT+IF5fg+05gWCk3QexMzmattLtXrQl4P5qIKshIN0f6CodW6hGi5dAGqF9O7+0c4HnKYY9eTR1A==
X-Received: by 2002:a05:6000:2dc9:b0:3ec:a900:d770 with SMTP id ffacd0b85a97d-3eca900e236mr2075920f8f.40.1758022989250;
        Tue, 16 Sep 2025 04:43:09 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:e84a:8732:25b9:4aea? ([2620:10d:c092:500::4:ec8a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ea21a6e4basm9979452f8f.11.2025.09.16.04.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 04:43:08 -0700 (PDT)
Message-ID: <6c444693-d1ac-41b4-a5cc-40789286deb3@gmail.com>
Date: Tue, 16 Sep 2025 12:43:08 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/8] bpf: extract generic helper from
 process_timer_func()
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250915201820.248977-1-mykyta.yatsenko5@gmail.com>
 <20250915201820.248977-3-mykyta.yatsenko5@gmail.com>
 <2d82eb1161c26d2bed6b8cd0c12a9890211aad8f.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <2d82eb1161c26d2bed6b8cd0c12a9890211aad8f.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/25 22:19, Eduard Zingerman wrote:
> On Mon, 2025-09-15 at 21:18 +0100, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Refactor the verifier by pulling the common logic from
>> process_timer_func() into a dedicated helper. This allows reusing
>> process_async_func() helper for verifying bpf_task_work struct in the
>> next patch.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>> ---
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> Are you planning to follow this up by converting process_wq_func() to
> use check_map_field_pointer()?
yes.
>
> Just in case, note that it is possible to ditch last parameter of
> check_map_field_pointer() by using btf_field_type_name(field_type).
thanks!
>
> [...]


