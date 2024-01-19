Return-Path: <bpf+bounces-19869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708898322E5
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 02:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51908B2161D
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 01:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D79ECE;
	Fri, 19 Jan 2024 01:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqfGNb4x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F6A1362
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 01:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705626819; cv=none; b=XTpkzJLIR7nuM7s1/z2E6CME6qu8BlbTNqpe+GA42h0+9PLNalI/fh1VydNXhXpOy/plax3BMwU7Z+eLvF4NyY96xClFfvSA7RtrBOTaCenyssc8SuRQjtAG7LYec7Jpl9X6ZNqe4cfiLz9uITKFkcuDSU9DxQ2Pnl0a9F3P7vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705626819; c=relaxed/simple;
	bh=cOPWf40MjTz1piciNTSrCBYqLbTRTE5V2+iinSaapP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DnzKkpg177nYoa2wU4KU9Z2VISB/N+gmusu3cnOEuT3msFJyWHt2OXLWPwxkCTqrUJHzKlT86ui7kjm3fDR4/rdmRL1NpZRyUyctMnttojUapho5LFGJo3GRDJh4zBZIkHXoH+6++s6sn8sGdET3aRcScncU/T/Nps7YbQ2oC74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqfGNb4x; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc22ade26d8so274087276.1
        for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 17:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705626817; x=1706231617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ASiQqrVN74A+P/GQZsybJd+sUdgSAvDG/Plw+gx4fUg=;
        b=SqfGNb4xCep24zHHbe6VL56Vfl5JoGN8VUjk3faZEzz3p0+8i6Zu851t8ggk9tMY7L
         J4eDF57coeRy6m87TjGABYZ362/3fk6MUgoQEe4kD7Q83f0CBQ6YoMvbao/COus40KJ6
         DyY9gsapO5dG/YEwNmD0DY798jqVkCohIcaRQ2e2YwvpkQI9/74qs2D0fKQakmYfQGIk
         6qs4yvSipp/02QbemU7Xi0Y71d11OjgYPfsUx0KaA8ew9+rgFI0RmEh3R4r24Qvoy/WD
         lgeZN28UvYDqdlNqhNG7mgbkxMz7Hx4cbTqQ1AqnlV4D1ufO3/K6KrIcEz2mporSOV4C
         YrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705626817; x=1706231617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ASiQqrVN74A+P/GQZsybJd+sUdgSAvDG/Plw+gx4fUg=;
        b=GP+zX2eppZL0BI/z7FfF6BuT+XmKh8G2AtQJwPWWf5CO/bLA4li2mAr6/u9nwbn0DG
         IUuguN9MSwXslS2i4m9VGIb7btCWanziweso1GSgUzlCIGRIAoEFrEdE6hW279wby13D
         6eYoErwmGAlekk9z/oYN+OC+NTxbcSHNywKkokj1y7i5wGw1AYGqV3Kg4lTXltaMJhp/
         lqG4z/PBFDOoeZwxIph67/YXPGxXTEpwwJ5vv2Qe5CQn72tLbSoJIjyfJrp20zMXv5HC
         gFY0QJPIqrzVZQpvEpys5foiS/84rT9C6qEgEzxOGcnSNGmO7EG9L7WKBbJboA9Icvcx
         Z3ZA==
X-Gm-Message-State: AOJu0YxZ61Bwdl/mhLcIeU07X8AG+8w3DdPttfPQJjJ24uc+aXOk7el1
	+ef0nhiSgluiWTL4Pbe0H2j0aJIMOeMs2VNvJilED3oQb05+Z1Jq
X-Google-Smtp-Source: AGHT+IHE1o0X7uN70piYkLkyUFw8wsX/iu8ppaGe2az59GfuaHL65eFwzKB8K5AsJun8JhmWfjkg9A==
X-Received: by 2002:a25:d006:0:b0:dbd:2399:1411 with SMTP id h6-20020a25d006000000b00dbd23991411mr1531893ybg.66.1705626816909;
        Thu, 18 Jan 2024 17:13:36 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:989a:640b:aca2:a8fd? ([2600:1700:6cf8:1240:989a:640b:aca2:a8fd])
        by smtp.gmail.com with ESMTPSA id t2-20020a25f602000000b00dc237c2d43csm1940462ybd.49.2024.01.18.17.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 17:13:36 -0800 (PST)
Message-ID: <3f32dc15-17da-4d01-abc9-037ba93383e1@gmail.com>
Date: Thu, 18 Jan 2024 17:13:35 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v16 04/14] bpf: add struct_ops_tab to btf.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20240118014930.1992551-1-thinker.li@gmail.com>
 <20240118014930.1992551-5-thinker.li@gmail.com>
 <f9160cb0-c461-4006-bdea-0536cbaff917@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <f9160cb0-c461-4006-bdea-0536cbaff917@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/18/24 13:36, Martin KaFai Lau wrote:
> On 1/17/24 5:49 PM, thinker.li@gmail.com wrote:
>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>> index 1d852dad7473..a68604904f4e 100644
>> --- a/include/linux/btf.h
>> +++ b/include/linux/btf.h
>> @@ -584,4 +584,6 @@ static inline bool btf_type_is_struct_ptr(struct 
>> btf *btf, const struct btf_type
>>       return btf_type_is_struct(t);
>>   }
>> +struct bpf_struct_ops_desc;
> 
> A forward declaration at the end of a .h file is suspicious....
> Not needed also?

I will remove it.

> 
>> +
>>   #endif
> 

