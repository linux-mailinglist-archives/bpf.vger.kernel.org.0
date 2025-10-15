Return-Path: <bpf+bounces-71056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F5EBE0DF0
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 23:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 834A84ED3EC
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 21:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75A8303A2E;
	Wed, 15 Oct 2025 21:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3YgdjFM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CBD2EB5D2
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 21:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760565031; cv=none; b=BTT3U1EDf6ocgVIcHXVRA4c3NIOWLUJvQTtaKB57nGGhnLDbgZP7c0VPWkyNvKBvCif4U72WK1yWd4X2G8RAvXmKFerwQaHZngpz1wCMVapmYcI5kUSiJbPbwfZMEKPiXyWSP7m9BZESSu5qmBq5+zqU9vwnji+xgThLw03L8sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760565031; c=relaxed/simple;
	bh=foz2Iq5/vtgpfR7EJfJNxQqS9HEPzkPzfQ1JsQ7Som4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lGwF0uNy+lWIf5VIdFw20PSOQmx+5socf3fphSP54jmOfypYD5uV04W2vLofYF8PD/9vS8GOIasw2E6CB7KYlLfYkhu4kAC4ZWA8hDuUv+opdJXL77f2HnZnOTdDL0C0Ujp7UW3cvgM9C7y8Q12juuBYLGvX1TIF5NFh6yzo+3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3YgdjFM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e37d6c21eso481665e9.0
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 14:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760565028; x=1761169828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9rli9UGEje1nbHPaAjALjZBaGfGiTpXq4LGKty6e+Z8=;
        b=F3YgdjFMuLsSlMlNbDGIBkNMyDZVX8fNvAjFRK2COQmiHJady+Xnbbzz8J8Bpsvode
         DzsuVYdQFomFJ29HPAHpqDntLR5nZUCZjSEVTM4FgW0c6mbpTozpjTrgFDc9U+SSecAb
         yTFk1HhT5Nz/U9V5fqdw/TiT+sqpYTcGuPws4a9T0bmeaT+y9e9q7rgno4yhINCKkNFT
         0cap6NRJkgHUkOo2TPlMI0BffK9X9Xr/1X5U+0ix6V+L3yH2D9JNEo9PguMWsOMSFLJD
         0LTY3uK1a6hzBfG1EaUrpkBL7D8BoGJQDizZlPBqu6o444QrXhOXW1/O+pfTBKnNR+pQ
         cZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760565028; x=1761169828;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rli9UGEje1nbHPaAjALjZBaGfGiTpXq4LGKty6e+Z8=;
        b=wA1/CYpm0I9dXby4o+uM/ExV3j318vW8fKq92ACq9Dpe1EPw34e9dZq+tmnKolAV6P
         7n0FXiicDCYOnl87IM7MRP+HP3eRpHIyBwewgxlLdvOKZhglXpLcMOCFMdPoCbt2dn1w
         s1ZNoRvvuj132Q52jn9VH9WbjjnfCmnDn0r79SjH6JRs7g0fa2R7JV2W8kX2u/OzEkRe
         BxNsBfruiJh3j4vG6BqyKeTqvwhF0xAbjpkXU8oeTihvnJGsUkGie4yDORBSaEahxJDQ
         ckHxmSeQpTh8hQcgRM/7RCu7xX1g8BENq4LJ8qZPJcyXwhUFBhCObkRelnFtxQDj5Ddt
         ANqg==
X-Forwarded-Encrypted: i=1; AJvYcCUX5rsXRWDXrvj2QjsezZB1a5MKnaeDSAjLn/a8vGWI3yc4n0VdX33nynhB+RACglrSjis=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB0xRkZsSFZvgnwBYuaiPmHhmTDaJXrSFmVhMUAX2KrmOTtkBS
	TYJls48sBhh5V2+BY+dBa4XTvyMa02T5riC7cF+5QKm5E+ZfuC3mUJyb
X-Gm-Gg: ASbGncvsjAkYJUiS2/fp5rG02e4vkHkC00DYoTfvyK1Sax2e/UGxeQH0ES18o+93Nwk
	9wW3WHRSv3TlGhQZjWw7xB7I/gnjKyDaDZEqFN1nMGbMoNMkRvWhzzzkSGCwwAaBwTvDXukDRON
	u4DDABp9I9VAiVh+rnvEU4tNDtvIeyIyxpSKP8F+ykgnABPs+KIBtQxNmxW2UIRZIlLsCRbxYvW
	FJ02Go/svCGHd12SdinpKmG9wZB7MsAEV84rzWy761wdzOaOUuB8Tmtmgmb76a2u48qnGd2TW1C
	7aQwo4Ps3G/SQl1dcHGLLAmNyLb4h1bpMRYMiA/q0juw+TrvG8i/AJyWJ9Xw5Z4wkDsbH0kNXZL
	sH5XZspuiBTwQfvj8vKqhE5sPGJi5r+65gB67Elq9lbG9VIsbg/OjMOxXBxtcLt8MzN6wzHajEh
	8CFQnyPECKMBBNwDrwwVPCoA19p0hC4pYsi8ftW8Mc6VhFRHSaL2WPiuFWPtpAV+KaEctsPO5C1
	Y9yBO88ptwrlQ==
X-Google-Smtp-Source: AGHT+IHkesmVeZL642Nc6/9ieRVrzbxOQ1U+0iXJ1qS2BlYGLwpY9LHPkUN3mxbV3CbHarBPYZB05A==
X-Received: by 2002:a05:600c:c165:b0:46f:c4a1:1d9c with SMTP id 5b1f17b1804b1-46fc4a11ee7mr112004475e9.3.1760565027826;
        Wed, 15 Oct 2025 14:50:27 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce583424sm30489469f8f.21.2025.10.15.14.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 14:50:27 -0700 (PDT)
Message-ID: <076ff101-06cb-4db7-8a66-63c2d68ea752@gmail.com>
Date: Wed, 15 Oct 2025 22:50:26 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/11] bpf: Introduce file dynptr
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
 <066d090c7f0b9e2f3ba815b366396a96146ae5cc.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <066d090c7f0b9e2f3ba815b366396a96146ae5cc.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/15/25 19:40, Eduard Zingerman wrote:
> On Wed, 2025-10-15 at 17:11 +0100, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> This series adds a new dynptr kind, file dynptr, which enables BPF
>> programs to perform safe reads from files in a structured way.
>> Initial motivations include:
>>   * Parsing the executable’s ELF to locate thread-local variable symbols
>>   * Capturing stack traces when frame pointers are disabled
>>
>> By leveraging the existing dynptr abstraction, we reuse the verifier’s
>> lifetime/size checks and keep the API consistent with existing dynptr
>> read helpers.
>>
>> Technical details:
>> 1. Reuses the existing freader library to read files a folio at a time.
>> 2. bpf_dynptr_slice() and bpf_dynptr_read() always copy data from folios
>> into a program-provided buffer; zero-copy access is intentionally not
>> supported to keep it simple.
>> 3. Reads may sleep if the requested folios are not in the page cache.
>> 4. Few verifier changes required:
>>    * Support dynptr destruction in kfuncs
>>    * Add kfunc address substitution based on whether the program runs in
>>    a sleepable or non-sleepable context.
>>
>> Testing:
>> The final patch adds a selftest that parses the executable’s ELF to
>> locate thread-local symbol information, demonstrating the file dynptr
>> workflow end-to-end.
> Nit: could you please include summary of changes between patch-set
>       versions in the cover letter?
Thanks for the reminder, I messed it up.

