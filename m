Return-Path: <bpf+bounces-18046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EC4815203
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 22:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5C31F24DC8
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 21:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47C2482C8;
	Fri, 15 Dec 2023 21:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRdzvT42"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECD748CC5
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 21:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dbcc9d4b1aeso925057276.2
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 13:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702676553; x=1703281353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gyIfNZRu2UHjBXarwqYzWBZVMN5KSNav7tsxECgI84Q=;
        b=CRdzvT42zq7N22aXPzAUlcahQLcP8a4nVy04VRE6BBm4v9ixstp4YMHApYD30R7h4I
         yxBlaN/MA6VKRxhiD889TjrRJIrOm5wKvZDBkqggWlZLM1AZHYJeWfBX7JZZQq99f2hL
         w88i+gtJvXAmJ0mRfNQHd+K40rThAjzZBnd2HltPHA7OuJovxNjW/9QqTpGHlan6pces
         1iDKA94EEAKUHId67LvTz7ubWR4QI0Lxy2g2/RVIQZc6JuHuOoXi667LJlg6/3Td7kv7
         FT1KTdviaf1ZaP4gse/hCCQ0e+l0SYQgsrgrY2DT5lMLgm8OSjgdnmORjIGqIkbG4ObU
         HPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702676553; x=1703281353;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyIfNZRu2UHjBXarwqYzWBZVMN5KSNav7tsxECgI84Q=;
        b=uVtUugKYPBTr+dQzAyxI+iHy5rsMvp3XTAUpXpIULCKgnkvlPzoWaeWozAX+kKFnpv
         xb8zASSfkpWYZRSB0udiWPzca5ViRLvUzPK72nJQJ3qdzYtZymjWOhzpUrVwARDB63Ls
         2NMrs53tYDSL0wEpGNKxD/+X0OBqDLc2HqsIroAHbPrOhQr6PYbsEPhde6RecPwpEmx9
         eqcD9DEO/9Eh8WROciczpo/D/3XJc5WsERV2US+Vm14MK/5P/jwiDoF/S/x26KCWSuKM
         I0mGc8wOOBfZtJT+kpM9McUCyWp4neZe6blYq/yynfJ3eMFvjPh/+NKfnV5KhZs4W6xQ
         JjWQ==
X-Gm-Message-State: AOJu0YzUD+ftWe06eGqtWPDuAK6yC+PhOkdwbWOkevrSUI9vOYput0QW
	f36eFqTfwrs5kdCSowEXKf4=
X-Google-Smtp-Source: AGHT+IHDCeycs5QWaY1Xi6nmqn138Vds4iCgxJptXnLYhgspfv2D/CeenAE3QhAXR6H/drAq6Qc8CQ==
X-Received: by 2002:a25:582:0:b0:dbd:250:7419 with SMTP id 124-20020a250582000000b00dbd02507419mr931128ybf.34.1702676552762;
        Fri, 15 Dec 2023 13:42:32 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:cff8:4904:6a61:98b6? ([2600:1700:6cf8:1240:cff8:4904:6a61:98b6])
        by smtp.gmail.com with ESMTPSA id n188-20020a25dac5000000b00dbcc7e5ef47sm2518020ybf.2.2023.12.15.13.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 13:42:32 -0800 (PST)
Message-ID: <fc15849b-2f71-420e-aab4-7a20014cba49@gmail.com>
Date: Fri, 15 Dec 2023 13:42:31 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v13 04/14] bpf: add struct_ops_tab to btf.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231209002709.535966-1-thinker.li@gmail.com>
 <20231209002709.535966-5-thinker.li@gmail.com>
 <466399be-c571-48af-8f48-8365689d4d20@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <466399be-c571-48af-8f48-8365689d4d20@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/14/23 18:22, Martin KaFai Lau wrote:
> On 12/8/23 4:26 PM, thinker.li@gmail.com wrote:
>> +const struct bpf_struct_ops_desc *btf_get_struct_ops(struct btf *btf, 
>> u32 *ret_cnt)
>> +{
>> +    if (!btf)
>> +        return NULL;
>> +    if (!btf->struct_ops_tab)
> 
>          *ret_cnt = 0;
> 
> unless the later patch checks the return value NULL before using *ret_cnt.
> Anyway, better to set *ret_cnt to 0 if the btf has no struct_ops.
> 
> The same should go for the "!btf" case above but I suspect the above 
> !btf check is unnecessary also and the caller should have checked for 
> !btf itself instead of expecting a list of struct_ops from a NULL btf. 
> Lets continue the review on the later patches for now to confirm where 
> the above !btf case might happen.

Checking callers, I didn't find anything that make btf here NULL so far.
It is safe to remove !btf check. For the same reason as assigning
*ret_cnt for safe, this check should be fine here as well, right?

I don't have strong opinion here. What I though is to keep the values
as it is without any side-effect if the function call fails and if
possible. And, the callers should not expect the callee to set some
specific values when a call fails.

> 
>> +        return NULL;
>> +
>> +    *ret_cnt = btf->struct_ops_tab->cnt;
>> +    return (const struct bpf_struct_ops_desc *)btf->struct_ops_tab->ops;
>> +}
> 

