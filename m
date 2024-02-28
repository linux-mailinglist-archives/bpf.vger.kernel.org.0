Return-Path: <bpf+bounces-22877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9183A86B1ED
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 15:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0E31C22582
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 14:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5825E15958B;
	Wed, 28 Feb 2024 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="X0XeIvHN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2940A1852
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131129; cv=none; b=jIA42YO1XYJBcuSB1yNtcykPrxUXpVuzx3njYiznKbD9HVmdN2t6O7c28k+cyx7YyerXAcOinehVAac/ULqgRnasIAAarROpAeV36+XhSAJhwkdFySCDTn0uM3toJW0vpxrSszcEoT/+FaB1xbxrc3DUmSpzXAzZYiiOom7z6OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131129; c=relaxed/simple;
	bh=ehnAQ9Uk+cmdFB8eEhfxHPixQwI/9Ksyt1XdugVVAVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EfcZx1za9SZASXihs82YFvJx4kTAvnvHADiMe7cNIHxNCaW956uA00/HM2vb3ap5SKZkBiqrNTX65krQczKdbZO4XwT+2DgPtscjaTTPNw93vanGr54DyX9Cq6hhFrtlWBQ1YyaSmTc22fIaLqDMCzebjNJsrac4UjR2ZN4ll80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=X0XeIvHN; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412b246b386so7468735e9.3
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 06:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1709131126; x=1709735926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nLWMXq65yFC7R3cB0pN8UmT5NHZrY6CCRN81VFTnD8g=;
        b=X0XeIvHNwZr+iekCa90jUsFnaPxycvWuWVLxEVZUoG9l/T82ictKa/jcLYfWiD2ntB
         HVn9ZvKXJYUDge09HCqdC14kcb5xB2NZhCFXzb/kvPX5BAMBenX8xQPVJa/UWCUIIceR
         QvKCzKwDzY0MwjCPnW7CWDEFWHlgE9M+IPF4ZXRPuv1ZG7sJBXKCx0Jli4iZoxvALzzf
         29otZIvmKV5EjWbhhf5i3hbonx4p+2pfX1VU2rAWD5JhprUZj+/K4YqExILCgphY8Iw4
         Rd+baAeN1ask5FBa/sfgdxLmAfEvJK4Kl0q+o+55G92xuSIGrxt16sKK9OjRxoG7yl+Y
         Qcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709131126; x=1709735926;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nLWMXq65yFC7R3cB0pN8UmT5NHZrY6CCRN81VFTnD8g=;
        b=wwsKikQZq8F6GQ2hqsMgVFY1vi8OR7UxqykOldwufkaTtKh/klrVRUWfESHgmz+xMJ
         6nxiF7CpaToEKvrxAGIM/yFIrvXFLjrMMP16WYoVDOWCXoUT83kpe9zHJEeyyLuykswU
         ngmCp0NpiQjUPySReldulaIrPjgkSwyNjlsqjdjfYLuV/pV6LJCGa0Ls+kl087F9SvGC
         PGUpYrgP5VuOxRz1EmNB5cIf6R/hNSLDS0dfmmLQFcCHcMDLRhx4bnnrSDVSuC6vvDXi
         pgHkehckAB8uF6CwJTnI69tQ3oB1kQNtI+oJIuZU1pwGu9bDotkEuv5f+3Am/W1WDEVp
         3T7w==
X-Forwarded-Encrypted: i=1; AJvYcCXlUXf4LzNeivAoPXvzXjZyBwY484rMaSxnkfdzngb61lQKP13RwewhvI4iG72bPjl/b0Z1jujq2KmVak7+zOUk1NcM
X-Gm-Message-State: AOJu0YzzqeHCmjZGCnvf/7sAwnvKVVOJhMRhu69UQE2cVp9XYpti7K2P
	DJYaT4K29wyRdPebDds8bALbLkqxYXF/7TJpPwg7cTxum6xl1Z1wxMeioG49LUk=
X-Google-Smtp-Source: AGHT+IHYS6JLzMyCCBUhEuSzV3L9KI/Xr9WNvvPERHYHbcbZ+EEUHmNdC+F92KwflbT/oxPW3uQKJA==
X-Received: by 2002:a05:6000:48:b0:33c:ec8f:7b51 with SMTP id k8-20020a056000004800b0033cec8f7b51mr9687128wrx.16.1709131126431;
        Wed, 28 Feb 2024 06:38:46 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:5379:cc82:ab28:8613? ([2a02:8011:e80c:0:5379:cc82:ab28:8613])
        by smtp.gmail.com with ESMTPSA id k6-20020a056000004600b0033d87f61613sm14637334wrx.58.2024.02.28.06.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 06:38:46 -0800 (PST)
Message-ID: <5e9bc786-60ef-4792-a3db-0981b1b14869@isovalent.com>
Date: Wed, 28 Feb 2024 14:38:44 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 1/6] libbpf: expose resolve_func_ptr() through
 libbpf_internal.h.
Content-Language: en-GB
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com
References: <20240227010432.714127-1-thinker.li@gmail.com>
 <20240227010432.714127-2-thinker.li@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20240227010432.714127-2-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-02-27 01:04 UTC+0000 ~ Kui-Feng Lee <thinker.li@gmail.com>
> bpftool is going to reuse this helper function to support shadow types of
> struct_ops maps.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>

Acked-by: Quentin Monnet <quentin@isovalent.com>


