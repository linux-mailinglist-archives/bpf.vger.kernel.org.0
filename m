Return-Path: <bpf+bounces-59865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F03AD0402
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 16:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B89174CF2
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 14:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F4A139D0A;
	Fri,  6 Jun 2025 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bECm3ooN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E93C1311AC
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749220095; cv=none; b=uomL/ghK2UJqrVvxt5A91vWIVSHTRirGRxy0GRLXa/yEX5EX0bVueOr3JaDkaPFQHvfxKWYUUEi0L3n/2tORre3x9jH9IAxa8+syPlb6+XxOgGt0RJyfGJdLojCanSJGTpe79Go/ug0JsJKVIIPvE9/aNmoMOoGETlGx/LihPOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749220095; c=relaxed/simple;
	bh=yGw2KCsyMGQhD+cV7Xq0jX7AcZgSEZyRWrXunzclL1s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZWaJV2NmJgWQBEYv3FT8MFS2CT/OLCQaRXdawVCXR0w9q3MWLlm3fRsp2ydue3kIu1k0it/iRzNnRAsXAMQklSIIPFSuJGkoXVu4D98gncjx7uZWA1pCHThoWTpJy8HsnPMb4r3g/irc3EGCS2DXuEJ4edh5dNHA33YmVHgqdvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bECm3ooN; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3dc9e7d10bdso7822465ab.2
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 07:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749220092; x=1749824892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3O04NlGxiolO1CmbKy++35ARtom08d+p1GVLWa2NnfA=;
        b=bECm3ooNqOr7ZBwPRk6qssZuPTq/SvT0mGTHY+CBUFRlVV/URBM25Vj9onOyrZrb+J
         QYqenh/1eLUU/W0kUWtA51gkAlXsFMAoLQHz3rPKi27xp21OwpVr/J5IjVJU2sdG4G1z
         blOw+eSjlymw2z6OjEQxCRUWNLmwst9+4wFxFIjr2bK8ZGezbr9So8eCSpEek0ql0MfF
         o8uxFN5dh/t0jMwI2TWkjLDLHbezOWfr9nOzVEcgS3fhgsl6gvey9xB65c+bwBGA1iOq
         vePUbVswkdHirTXLIYnjNH+bFtUDFiYUOZv1RyWjn3nXWiD95JmybEYWBY6H9jL2aygO
         Mwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749220092; x=1749824892;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3O04NlGxiolO1CmbKy++35ARtom08d+p1GVLWa2NnfA=;
        b=kuXkYDd5rFOKuNhYEf9l5WTgJ+0JMF7Fywvb/Z74FKQBKZQwfmHEKeG9XMvGkEpEso
         feMaNUiuu6ognhV96TAUEF4Oqd7GV1ym38qGClCZzduMMsJBRICTBTjar9s3FaC/DpLb
         TyPKJLRydBDa1QQe+zW4U16DBJmtknXfzVGy9QV6fBI03iSAHQTf5rTslcq6wazIiSDD
         zBeHBUJfra8zvOa+xO9p7EmwGRHb7sY1A+ZVRuny/ZFktmfWttH9kMSCS1T7m80Xz45f
         UeaCOy1awI+PPGVmqk4u2YQNnZt187VPt3azFOVGyCnN2Z8BRfeusX/p/+JDhcuDgUyZ
         kerg==
X-Forwarded-Encrypted: i=1; AJvYcCWFtC//oCzsx3CbewMvlg5beAPwnnl06Ce9vXgTYNAhmKtsEff8TwSkPPDsjAtYs3p6YcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/2SzLn0Vyv8Ddd1qphT0gfk8oFZ1fB2MZ33VXHnRg5jjbN0KB
	R7YqYJRSHr/t1ol0ySyrn8hQ9ZtdWOdCPSlD3SC/hUY/YBLkfDxT0HDuhTk97xf7Ee8nOoF7wMl
	hv35m
X-Gm-Gg: ASbGnctC/RM7ZEa+4H24Z3KCT9qvGi8QEENxkQOJiGSHMS53uaM8e8eVlUZOIwKrx2m
	zgXMknS90KwkJdR5sZmSSoadS0ev07+ds119vtdYCHtFo7mXDHrH4LPY83Ir2pA0J3kuzmlE9Ni
	071vSfhmkq9wCldGkvgOKLAquriPdgC5qXV8j769eolxGnrDOhRaQ7zRcP5Wrb5/PszTccnvaH3
	1Lu08hrQEYcoFYD5r5KxoKMQ+QGs8qLTs1BTD0B3qyqklp6QXPMqDPER/RUP61W06B9XDMvaRD0
	0ruh0R0/1Qmu0hROfQ7JtZbapkuuslZgyxeCK08SPJNc6jH8F0eST8fBvA==
X-Google-Smtp-Source: AGHT+IEDaUVHOPyyhzFPamWfZwsvgI1rLw4PRNRY6eDRtYy1d7W/lfguqrkX0/AWabqTCYiFnyX3HA==
X-Received: by 2002:a05:6e02:16c8:b0:3dd:b726:cc52 with SMTP id e9e14a558f8ab-3ddce3cd206mr20550835ab.5.1749220092612;
        Fri, 06 Jun 2025 07:28:12 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ddcf1582dfsm4388395ab.23.2025.06.06.07.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 07:28:12 -0700 (PDT)
Message-ID: <f6ae27ea-03b7-4fe9-bb6e-15b988f2a6b8@kernel.dk>
Date: Fri, 6 Jun 2025 08:28:11 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 2/5] io_uring/bpf: add stubs for bpf struct_ops
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1749214572.git.asml.silence@gmail.com>
 <e2cd83fa47ed6e7e6c4e9207e66204e97371a37c.1749214572.git.asml.silence@gmail.com>
 <783d14e8-0627-492d-b06f-f0adee2064d6@kernel.dk>
Content-Language: en-US
In-Reply-To: <783d14e8-0627-492d-b06f-f0adee2064d6@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/6/25 8:25 AM, Jens Axboe wrote:
> On 6/6/25 7:57 AM, Pavel Begunkov wrote:
>> diff --git a/io_uring/bpf.h b/io_uring/bpf.h
>> new file mode 100644
>> index 000000000000..a61c489d306b
>> --- /dev/null
>> +++ b/io_uring/bpf.h
>> @@ -0,0 +1,26 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#ifndef IOU_BPF_H
>> +#define IOU_BPF_H
>> +
>> +#include <linux/io_uring_types.h>
>> +#include <linux/bpf.h>
>> +
>> +#include "io_uring.h"
>> +
>> +struct io_uring_ops {
>> +};
>> +
>> +static inline bool io_bpf_attached(struct io_ring_ctx *ctx)
>> +{
>> +	return IS_ENABLED(CONFIG_BPF) && ctx->bpf_ops != NULL;
>> +}
>> +
>> +#ifdef CONFIG_BPF
>> +void io_unregister_bpf_ops(struct io_ring_ctx *ctx);
>> +#else
>> +static inline void io_unregister_bpf_ops(struct io_ring_ctx *ctx)
>> +{
>> +}
>> +#endif
> 
> Should be
> 
> #ifdef IO_URING_BPF
> 
> here.

CONFIG_IO_URING_BPF of course...

-- 
Jens Axboe


