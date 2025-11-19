Return-Path: <bpf+bounces-75105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA5CC70BA7
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 20:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A4BF4E1C77
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 19:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0FD31BCA9;
	Wed, 19 Nov 2025 19:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqyiI1T9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C283191B1
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763578854; cv=none; b=hJcopw3jQulOgJLqMdyyiySAEmJQUx13t+ElahqnCaXa2GypaBTskeKTVp/ltDKE+NaWRX3OpCgpFFlrtV/9G7+A/YEDAZiiT62zlkSYdrQCR/dWoZTdo4zC0n3C7zGzudVuCcBLBwCVRNK9Fwy1HhpzUlSBdZgWJK6VEY/5Mdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763578854; c=relaxed/simple;
	bh=yf4LyyvVlWQlF+UYEilqMI+US78Bu+F8MQVkqeVDQxo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=i7sK3NP+tNhZgc/qKVKf8zJXgFSuWmX39vH/rBTUYT46ElrKzFZwbNkWg8Fjc7V9L/sh/fXS1sImoJqiwtgmDqNMOl7TSL6zQ8arufKxwEftRMTJaGvo73BEYj/Cq+Yal6/eJXduG2d0iERr+hzBj2QrnseXwxlA8NrhamjlZVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqyiI1T9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so833065e9.0
        for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 11:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763578843; x=1764183643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qFwRgnhOH4KcFWEMp/9tsUsQL7kS/IiEkrujwfXANQs=;
        b=OqyiI1T92cAv1Dr0koyEKJXXs94hQ+CGoww9ZuHP78u9Wl2zd8OKmpGAYcoPR3EpJ2
         2XmNYz+1ylIMXRdAT/Y1QzfFdQ71U0q3z4HCOXIOjkWFwYgYTmAow/CnfPGJzQTMUSCK
         NJBncs9T4LKjjd/x5koB9vyFcD7eIQPxJIuJd5zLpQn2o0RhaQCtScoiYloPJuDCjpwZ
         oG+cosZc2rtpQm1NRXY8L08JJwOQA9VLMm0D76FTlvamSZVuN6sMjra967ge0WMLzBKO
         HTBwIk5FdW5j71MiLdNKA7qMlpDMKSXLlaqe2CmRCRelBCwcl2oUI+89jlQzW/9HHW5Y
         lT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763578843; x=1764183643;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qFwRgnhOH4KcFWEMp/9tsUsQL7kS/IiEkrujwfXANQs=;
        b=FmUW2o20Btebcu1GW46ESVcfWdaG7HzRiCBNPeEgqpkUSO6Q9rCNJRNvK1Rd9nBs1O
         42Cm7t8dvbwVkE/jE8deKfB3+n/cGG5tLnaQzD649Lh1VVo8hWAu/Q1BJNVaDEgz1aUX
         hmDD/JJOHqrOqk6UA6erQiyQMTckpV/UhL/VRfKkXhVbIVmpUxHEG/g0Z0Am937aCUv+
         PNC+9U9PW0NdZFSSsV0yYJeMHWx2sOSOM+tgDCM/uvTw8kQYiXkfQblphDhukd3EHdJa
         D/7Qoetwmh+SUt2DRQi3pZkJk0xbu/OcM1Z38/GXobygJgnjs2/InPtzXf39nvq2DEUa
         +lng==
X-Forwarded-Encrypted: i=1; AJvYcCX9VpPYwn9/CytnplmJOkx1w8rSlYpEwKYv4VbVTacdAnjziuUsPAEh+mgu/JuMSw6xRGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMmPkiR41KjnmZCXtlrePGVnvX+qQGvIOA6QdYQBwpHG2ems94
	YkdzGjlnOco9PQAP8m44gYV9PqNdHPZMrL7iAaQOeAweKGlBApcwhYFv
X-Gm-Gg: ASbGnctL3wSSn28IQrGCOxVOlwmAiBSozdpBrSfju2YpFNGveZjFgYZfOObic4qRN9t
	jfxDv/HtiXe7uq3DoCYckoZRn6gmppdu/XBXinwAZzo487TtmYCRbiGKpnBSqDLulwYJq4y1rV5
	kbUnzQgiWQk5uXjqmv/jG6Vxe+onJsRPkozl7c3KCFE5zsbT1fgiKQ9y7dgub3iMQcrAYUFo6m0
	ERGRIfs6hUcTwnZRkHJvJWJZKvBiM5u4PzDcoko4VPzFeBp6vcW83L8z5HDWVHPScHK6IvfALoE
	ltthbvkNNBwZwK/7lgM4f2lS2x3eh2kXSkEh9rKWjJ5cJ3N4ofdjt2SdByJn6PMqxOPWWaEm0I9
	bdWT13V83fHc+T5y55B1Da/oaAjudwM/kcxbDwCSTOJrWklCXUIU/cPO3i/AXCtJgHXck6BiaIu
	e/x5B7DuzXqbusAsPj0pIJzZfe9Af72OHK8m/86Zc560CpQ6WW4/sdDjSWuS3kLuLsESbF766fa
	FVJy+IcT38=
X-Google-Smtp-Source: AGHT+IGCe0gTeePeQC4mLZ4ePm5f0zDzhQlwMZyB9V0M/207bFFEDqn8Z39MIC1pmnaZNnQI+Ifdig==
X-Received: by 2002:a05:600c:450f:b0:477:7768:8da4 with SMTP id 5b1f17b1804b1-477b8671900mr3444735e9.7.1763578842970;
        Wed, 19 Nov 2025 11:00:42 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b106b10asm63098875e9.10.2025.11.19.11.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 11:00:42 -0800 (PST)
Message-ID: <82fe6ace-2cfe-4351-b7b4-895e9c29cced@gmail.com>
Date: Wed, 19 Nov 2025 19:00:41 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH v3 10/10] selftests/io_uring: add bpf io_uring selftests
To: Ming Lei <ming.lei@redhat.com>
Cc: io-uring@vger.kernel.org, axboe@kernel.dk,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>
References: <cover.1763031077.git.asml.silence@gmail.com>
 <6143e4393c645c539fc34dc37eeb6d682ad073b9.1763031077.git.asml.silence@gmail.com>
 <aRcp5Gi41i-g64ov@fedora>
Content-Language: en-US
In-Reply-To: <aRcp5Gi41i-g64ov@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/25 13:08, Ming Lei wrote:
> On Thu, Nov 13, 2025 at 11:59:47AM +0000, Pavel Begunkov wrote:
...
>> +	bpf_printk("queue nop request, data %lu\n", (unsigned long)reqs_to_run);
>> +	sqe = &sqes[sq_hdr->tail & (SQ_ENTRIES - 1)];
>> +	sqe->user_data = reqs_to_run;
>> +	sq_hdr->tail++;
> 
> Looks this way turns io_uring_enter() into pthread-unsafe, does it need to
> be documented?

Assuming you mean parallel io_uring_enter() calls modifying the SQ,
it's not different from how it currently is. If you're sharing an
io_uring, threads need to sync the use of SQ/CQ.

-- 
Pavel Begunkov


