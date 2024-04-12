Return-Path: <bpf+bounces-26632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142198A33EC
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 18:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F561C21E3F
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 16:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5570714BF97;
	Fri, 12 Apr 2024 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWRFnku7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A4214B078
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712939551; cv=none; b=g1+nc943UKOdZw0UBIf9MfHlj7ynT1lTVS7EIqTMbGLudR9nGuSfLKPJDS/Llelzte571+CRsu32M4SYs1BcJYFO2L50/aO18yVPMCEYI1KCz227tKmZtsZ1O3osbBwj4lU7RY7UbKY9yYqixe6KoDde5NY28NBPUf7p8Im2GvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712939551; c=relaxed/simple;
	bh=NpOq3hyx4ZTBMUwoBNtlfRvBk0jkGtxcyGjyVTsrxaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPQF1dVnODilahXEoyUN6afTQnrZ7fngbNfPTCmI2+5YBZxHSc66qixMgBzfhV5WhSwK62b5iKE12AyChfpT+ZrHl7/lM4XLULWuVbIOcqX+1gccieNk+7u8Kc99gzsUhGM40pjiHCfj3AUx2F8WzKG6vQezw5YDH56ioLv5B18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWRFnku7; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2330f85c2ebso672304fac.1
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 09:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712939549; x=1713544349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+HuPeLQZlKZNfjh5TlRH7FxcFzqRl9ypV+kbsRraCxk=;
        b=nWRFnku76nh0pjT2nYV7nCIzq3ReMRb1PL4W84eqsmfWeLPUaOeSmOknk8dZfgrnJt
         mnLVnhJpZClg0UbFXeQKHBJ3mCPI5SraesgW/FzwHo43gZdbeWVwsROM3RM5/eX0ksIS
         IMA6f7cYV+gTKj7N+v1wITaPozPTqTGWPWVH0vbaxJ+D9SYM4cKbyolcoF7zO5QQhSVb
         +UuD80CnwniIni9SPOs9cIxvbZuxPd+AF/y6ZipFhDAeg+3S239LvqrTu9sJZIt9ms2e
         y1x80QRS82ooJ+BTisfz1uTnVzm6OF0ZXlyChiFyxzYqU13TF72Y/xfHGlT8nF/HDToL
         XB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712939549; x=1713544349;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+HuPeLQZlKZNfjh5TlRH7FxcFzqRl9ypV+kbsRraCxk=;
        b=LkT4f7XLROcm4s72KOk4zc0rjNAjJEXM4chKv7rfyuSqTAzC7TGtxnYuT9wTyD4w7E
         xUcAsw5Rc0C5WkoZRzwGCzFReKYaN0ngNuv4iiTq+s62rpQ3XiSy40P98qV9y+tiz/4Y
         l2/sQ4P44fbq81O85ioz9dWmljliNOgAImGyjnpg+HfpAYSipsJbDnHjtRd7JDVXdY/w
         4OeW/O/12rmgh/WycWHoO0rtKQp9teJBMx9x+EMlbUSfJrtFK+1dH/wGjiY5ciWXVdN2
         4IeYjkHx5ZcTWYPrOhksk4W4xVnXtGoTh/mxhIpMY19nh+ESzFt4hiLg7vGZsyxTlkwL
         uT0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVg/dxFsWlDePDvaRhbBKp4TfBDrj/KyhHMaiNBnJcwyVf92b5MtK2jxoD907MW07MqCdUlnOxSig5iHJ/NPd7AZhx
X-Gm-Message-State: AOJu0Yw9RyRqSipugAx5UPC1dgEDjc1ShVE+OhnGl4cIfhUcG1QfpiXx
	ITcC6wte4+Lua9jjiCo3o9DS9iYaRTpB0uV5QhojMK91h4Wv+dTfV4OX4w==
X-Google-Smtp-Source: AGHT+IHD3RJBYdHqD+iZukErTmXPcIOpAWCcVAJLxO8wvpCj6IrtA7Cof2IBpiVho6fVKlXetOlouA==
X-Received: by 2002:a05:6870:24a9:b0:22a:7899:37c4 with SMTP id s41-20020a05687024a900b0022a789937c4mr3610840oaq.20.1712939549573;
        Fri, 12 Apr 2024 09:32:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:a1a1:7d97:cada:fa46? ([2600:1700:6cf8:1240:a1a1:7d97:cada:fa46])
        by smtp.gmail.com with ESMTPSA id gb17-20020a056870671100b0022275702b8asm902635oab.44.2024.04.12.09.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 09:32:29 -0700 (PDT)
Message-ID: <edea9980-f29f-4589-9a39-d92a715822ce@gmail.com>
Date: Fri, 12 Apr 2024 09:32:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 07/11] bpf: check_map_access() with the knowledge
 of arrays.
To: Eduard Zingerman <eddyz87@gmail.com>, Kui-Feng Lee
 <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: kuifeng@meta.com
References: <20240410004150.2917641-1-thinker.li@gmail.com>
 <20240410004150.2917641-8-thinker.li@gmail.com>
 <c89a020a219dd2d6e781dce9986d46cbafd6499c.camel@gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <c89a020a219dd2d6e781dce9986d46cbafd6499c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/11/24 15:14, Eduard Zingerman wrote:
> On Tue, 2024-04-09 at 17:41 -0700, Kui-Feng Lee wrote:
> [...]
> 
>> Any access to elements other than the first one would be rejected.
> 
> I'm not sure this is true, could you please point me to a specific
> check in the code that enforces access to go to the first element?
> The check added in this patch only enforces correct alignment with
> array element start.

I mean accessing to elements other than the first one would be rejected
if we don't have this patch.

Before the change, it enforces correct alignment with the start of the
whole array.  Once the array feature is enabled, the "size" of struct
btf_field will be the size of entire array. In another word, accessing
to later elements, other than the first one, doesn't align with the
beginning of entire array, and will be rejected.


> 
> Other than this, the patch looks good to me.
> 
> [...]
> 
>> @@ -5448,7 +5448,10 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
>>   					verbose(env, "kptr access cannot have variable offset\n");
>>   					return -EACCES;
>>   				}
>> -				if (p != off + reg->var_off.value) {

Here "p" is the start of the entire array. If access any elements other
than the first one, it should return -EACCES.

>> +				var_p = off + reg->var_off.value;
>> +				elem_size = field->size / field->nelems;
>> +				if (var_p < p || var_p >= p + field->size ||
>> +				    (var_p - p) % elem_size) {
>>   					verbose(env, "kptr access misaligned expected=%u off=%llu\n",
>>   						p, off + reg->var_off.value);
>>   					return -EACCES;
> 
> 

