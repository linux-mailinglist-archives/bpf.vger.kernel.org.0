Return-Path: <bpf+bounces-60311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A64AD5430
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 13:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ED2B7A76A7
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 11:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FC825BF0E;
	Wed, 11 Jun 2025 11:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYheEREL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25843242D99
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 11:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641925; cv=none; b=OEv680tkkZvdeTHRCgZrvxx7VGyAPQKJs9s5LC5pxuZEs1B2rFih6Y6w4imDYNN7XylU3Kw9xFqv0xR5wSmeTmU/28q0+btAvd0Hn1GpxQuteL3uJZZMa8NqY5Tpqc7SKINsx4HuC3rfvKfsJcQWnV06d8ALo429I2QMQ7Ckv6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641925; c=relaxed/simple;
	bh=Bq92rZ7ykYbrzlOTwGooCmchE8kqjwmXTD6s0VkCtck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kNKN2mkERtjQjyN9WZSbgX4olxrqbkeA8Iw4y4lr6BLlRxA2l8Oyq+2HgzYWLeNd475LZ2REtkb7sKU6zZBC+bO3x0i6RHH6Eb7KRtlhJbipHEhWljOuix6Lyshozn+FZvY2xBhzwvLc9rS6YWRlhqaH7G14vERCQU68XaUEu0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYheEREL; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a4fea34e07so3778641f8f.1
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 04:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749641922; x=1750246722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B6SEZdiLQw/RwNaBz2D/cGuEstSSncWshk0SDWhera4=;
        b=OYheERELEB6jdDqNeNR7yo1PUTmNr+DB7uSk29DrAam7hrU8MfWgv01jgxR+dsBCoU
         b1iRRbcbbxtH8zEwwxT1DGHubKQS4LCz9RvsJg3YbAfVBFSsZLX/M8B11h8BTxcVhOHO
         W51k43Z4NHGcTc9JY2FD/3yoCnhQh7fZYMitRXipnq+XQcU3wiJN7XH1UZTjVfWYU1AD
         jXKiO+k4F+VUCvdgTQOdDBNbovQ1N6F1ZvnwkRrBGLeCnK+05Erc7lI6HixThhQ9zFe5
         X5brt7EAX5eW2uI0Hi4T61egvUTgM/fWjGIwNqSRlfck/ETR9dnDHKWFSDUvmMc0WTpx
         cshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749641922; x=1750246722;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B6SEZdiLQw/RwNaBz2D/cGuEstSSncWshk0SDWhera4=;
        b=S50Ob2x3Fdvd+zCJKm+EvMasWttkWXKdQi4klmQdheSANd/HPP9EN8oh0rvbVaNbOh
         i45g0pi7lghedDTG0xAYmHiZljKY3M2nhz+dONNkfLW3jtP+b/QuSt0YznygI0tehLJ8
         JU1CaL7MSDAsxDpjeVJ5oleJd7gwatCq/W6aWxgzkMk6cFhqbpXrV0sfpGO0muf953lj
         bLk74/Cx1KoPwHGCyjeDRCK23u7qeOC3uxMgAfgi9hUV3tAoRZPtFrpfRN6oEz87l+g+
         veciRJj6lb53AXCnhq2LEOvBDPP28NbC4BRhKfnowYNff0UnmwCI6ItsgsStWPxkIqls
         zO0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdRd+Vfy7n4O8PNfEIxWDug+ToJ+LHDfBWiVaL4JeelUEQdFU8og/TO6+5/IsLgIR/pzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ0hfHuh+m/6XmRerOnkH6gnnFvTcPzVk9+vvkjzYDMw15BY+6
	1l4T3rI5UpA2ZHdX+xKcMwdnaMMNuxQcVZEOJQbl0FA89PLjBTZ+D7Gx
X-Gm-Gg: ASbGnctMkuGRRGMriK4LxGnxyR93yXkOGFrv8PH7dHdo5/tAvFCcgljoDiZDsDvmkUg
	nzJqljVDJubVXtbcfUKDU3uBYYg0vSNy+VzbWQuTIQgYelrnLAPtAkcaEVsTjFcJR2nKm6G1mDG
	7HltQKNKYV1cYOu9eM5hv8qVocY0m8lTHri1VhIeiox/mTJeFIKgfyjX7Zt0QmOOWT/bUYoO21d
	RmMCNOHIO1uR/r5EsHkA7UWv9uE0XAjk6py5CmK4zsGWMMLeJPKKnXgOcE8Z/jGlppnuFdxkH7N
	pl5keLUsZaS4nCptcWDhtKkh1zF38/brnmxuypmKsG6llIBCzHoZJtR6TFQBYnW3N7Jb9553U64
	t9C+Rw+JZFGhvMEwKXIPHXqHOnjvB/rqCT/iqiPdvBijvEQ==
X-Google-Smtp-Source: AGHT+IE5wV2W8YBfnh4M0jQOvGMg8cda9sDufhvl8CBBr/+7dQRHmOsNOIPWAz9EYvXw2ROek7p4ww==
X-Received: by 2002:a05:6000:188d:b0:3a4:edf5:b942 with SMTP id ffacd0b85a97d-3a558800b81mr2592647f8f.57.1749641922149;
        Wed, 11 Jun 2025 04:38:42 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bf28:2e00:106b:a16d:4d49:8ce9? ([2a01:4b00:bf28:2e00:106b:a16d:4d49:8ce9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53229de48sm15336059f8f.10.2025.06.11.04.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 04:38:41 -0700 (PDT)
Message-ID: <c1cb9bd3-c99d-4af3-bbcc-2ff3c2250ca1@gmail.com>
Date: Wed, 11 Jun 2025 12:38:41 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: support array presets in
 veristat
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250610190840.1758122-1-mykyta.yatsenko5@gmail.com>
 <20250610190840.1758122-3-mykyta.yatsenko5@gmail.com>
 <4ff2fafb99131f599901580eac96dca34ca20cc0.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <4ff2fafb99131f599901580eac96dca34ca20cc0.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/25 01:45, Eduard Zingerman wrote:
> On Tue, 2025-06-10 at 20:08 +0100, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Implement support for presetting values for array elements in
>> veristat.
>> For example:
>> ```
>> sudo ./veristat set_global_vars.bpf.o -G "arr[3] = 1"
>> ```
>> Arrays of structures and structure of arrays work, but each
>> individual
>> scalar value has to be set separately: `foo[1].bar[2] = value`.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
> A few nits regarding error reporting:
>
>    ./veristat -q -G ptr_arr[10]=0 set_global_vars.bpf.o
>    Unsupported array element type for variable ptr_arr. Only int, enum, struct, union are supported
>                                                                                                   ^^^
> 											 missing dot
>
>    ./veristat -G arr[[10]]=0 set_global_vars.bpf.o
>    Could not parse 'arr[[10]]'Failed to parse global variable presets: arr[[10]]=0
>    ^^^^^^^^^                ^^^                                                  ^^^
>    Can't ?		   dot or comma                                 missing dot
>
>    ./veristat -q -G "struct1[0] = 0" set_global_vars.bpf.o
>    Setting value for type Struct is not supported
>                                             ^^^^^^^^^
> 					   report full_name here?
>
> I applied a diff as in the attachment, to see what offsets are being assigned.
> Looks like this shows a bug:
>
>    ./veristat  -q -G "struct1[0].filler = 42" set_global_vars.bpf.o > /dev/null
>    setting struct1[0].filler: offset 54, kind int, value 42
>
> Shouldn't offset be 2 in this case?
>
> (maybe print such info in debug (-d) mode?)
>
> Unrelated to this patch, but still a bug:
>
>    # Catches range error:
>    ./veristat -q -G "struct1[0].filler2 = 100500" set_global_vars.bpf.o
>    Variable unsigned short value 100500 is out of range [0; 65535]
>    # Does not range error:
>    ./veristat -q -G "struct1[0].filler2 = -1" set_global_vars.bpf.o
Thanks for taking a look and checking few testcases.
I'll fix this one in the next patch, along with the error messages.
>    ... success ...
>
> [...]


