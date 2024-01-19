Return-Path: <bpf+bounces-19864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03ED28322C0
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 01:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8966C28483B
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 00:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261B8ECE;
	Fri, 19 Jan 2024 00:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVCho6gh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB1FEC2;
	Fri, 19 Jan 2024 00:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705625258; cv=none; b=uRs3ZMVqCkUNIX42EDM5VYnPZAUccBpuEMoGHLiEoX/H7hDINttcbZXFrnnU5MJrgnoqfAs+PMK2PrD0WF3hbW+BWYovUpRDJ1r/19IIcQYkULF191heEIgjQ8zUutYMcHT0a9NWUdd0ltMvMQE1EUt+kQcE/tLlY7i/mrID4Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705625258; c=relaxed/simple;
	bh=DX9tWZcmCCEzxsJgFVvcXy7iwArn37KWesHEYi5XdNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWNn7pYcdiOni03RX8cT6Yu15fst2atXSSTuIGX8j816FVVHD70mZa2HfhLh+/rdC9RFLoCb4MiMshgAFDOtB+7tpJQXvRXTZ/3RG+6TvlDT2N9RfmT3N942OcNQMuHxxNl3aqroG323CFf/s1wZjVfGXmIp3gy0FJqbxgas+5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVCho6gh; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5f68af028afso1891777b3.2;
        Thu, 18 Jan 2024 16:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705625256; x=1706230056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I9Q1bWv6HPzmGtFsqAjOLSCmcG5CrPxJiSTOIdzdGos=;
        b=lVCho6ghIolitPEBe8QfFGAu02pvdO89Z/33fw7SRiW+vzO3L1SYCyFy4R/cowLSBn
         1T4r5pqQmv/b9reM36ioV3RnGDGoZapLmbQuJsWyCX00FdO0+KUYe3Fvpw3Ycb0fN+9b
         Qbb7IRGvXJQt9xwbO/OelFdGx/Lm8YWMt6hKbc7uEO29NgJadM75W1tf6bi8pHZwhtRy
         F03RJM6jI65BUnf23Yc2/RbRanaBV5ACTupI7Ztq/gU8FDYtLnhueNUv8SAdneVdVWgx
         laH6XkBCi4GJ3SCyvgm8OtxEMgMEkKPxsmi9LTR/30oqMwTMwiG/KAHoEb47b3Y4rtyk
         AvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705625256; x=1706230056;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9Q1bWv6HPzmGtFsqAjOLSCmcG5CrPxJiSTOIdzdGos=;
        b=Z3zOQWpZFgJtpVaGTkhzdFCrRnW3qEH8co4tzE8+f68BxNZlMskKJsxPF0v92SnF7O
         XAtwtpvCrRk9beNOx8CO8x2CF61mWiBp9MUGeba97G/XINny+6utiWW91NlzjfXoUIXj
         TjriZ4WKIPlJs89BQV/49liJnmPOiiTtBQlINyZtRzBGuRSgFPxcVpm7yRPEeJ01+Zmq
         oeErm32zl3WjJkZY2D5+juuemcx5jkVGC/g3bmVxS+5RnM11ane7t3k33E4e6Hr4GqAK
         x4EPyxURAQ8gGC53NZ3Xr8CNmI+gTVabyZSMZsHkYMaJPlYo9ug+oxMEyGBwaYDoZcIJ
         iabg==
X-Gm-Message-State: AOJu0YwiPaE1B1K+cb3qVnIkFBvRPUW5C3Dy5ZhvSj8rMpeTVmpmQTB8
	FPvh8mUwlliM3zJUP6SNbu6+KU6WR4WxE4OCUvnJ7hrceBlG/Kdl
X-Google-Smtp-Source: AGHT+IFyDyHd50/0W3YyM4AOwnImHR9gPZ/+OxyjX5lUv7bYjBgzVZZS03Ex+NPdJGq5WaCSEZG+Qw==
X-Received: by 2002:a0d:dfca:0:b0:5ff:7f45:3933 with SMTP id i193-20020a0ddfca000000b005ff7f453933mr1578888ywe.80.1705625255891;
        Thu, 18 Jan 2024 16:47:35 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:989a:640b:aca2:a8fd? ([2600:1700:6cf8:1240:989a:640b:aca2:a8fd])
        by smtp.gmail.com with ESMTPSA id u65-20020a818444000000b005ff83ceb44fsm1030037ywf.108.2024.01.18.16.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 16:47:35 -0800 (PST)
Message-ID: <99bad052-b28d-4ef3-8141-19620ca49451@gmail.com>
Date: Thu, 18 Jan 2024 16:47:34 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v16 03/14] bpf, net: introduce
 bpf_struct_ops_desc.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20240118014930.1992551-1-thinker.li@gmail.com>
 <20240118014930.1992551-4-thinker.li@gmail.com>
 <5c4ad938-eef4-4d6a-84e0-ffb10630fef9@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <5c4ad938-eef4-4d6a-84e0-ffb10630fef9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/18/24 13:30, Martin KaFai Lau wrote:
> On 1/17/24 5:49 PM, thinker.li@gmail.com wrote:
>> @@ -1750,11 +1755,6 @@ static inline int 
>> bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map,
>>   {
>>       return -EINVAL;
>>   }
>> -static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
>> -{
>> -    return -EOPNOTSUPP;
>> -}
>> -
> 
> This patch is about adding bpf_struct_ops_desc. Why the 
> bpf_struct_ops_link_create() is removed here?
> An unrelated (and unnecessary?) changes?

Sorry! It is a mistake causing by rebasing.

