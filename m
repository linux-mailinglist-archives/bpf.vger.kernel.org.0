Return-Path: <bpf+bounces-71555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1996FBF656A
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 14:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33DB19A303E
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 12:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C71C32F76D;
	Tue, 21 Oct 2025 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FG/BLJ8M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E2432F763
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047965; cv=none; b=pBmxNpquLRUzankRggngQoZDvTiZJdKv7XofENs19g9VpFY0Zp5i5VBUVXRo/VxdsEhkrNRrMsBpucAvSrKbILLrcNdEq30Lr+w6QIs+SibhzNprN8VXCvp04HMc7kS31YsEsbfp/t5/uchoEgsoLLB02SQToE7yr4MXGZ2uA7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047965; c=relaxed/simple;
	bh=J7Ulolm4JsI5khtidb2gJNmzrjEEWbhnN3+I9Rt/mm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kfUIpvZxUXJ7ldKMGMTlnIvYbzKesmkxNl6/u2RdEy8fBURZiA+37CfpPA8O4+qklyiIFSmnc+G+VEruaJrvJ3sgyEAjfXfOKOKJ/S7255z2nNuiSEQwdjWKzY4ERbCk3Z3q1yZ3gVM4nxHcRw6bCyp7txtwb1f4S3XDIPoCjE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FG/BLJ8M; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4710a1f9e4cso40960675e9.0
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 04:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761047961; x=1761652761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h9hpfYt5EFzc02ERX1hD5+rSyqsCx124+1sgPY772PY=;
        b=FG/BLJ8MqimtStdMdgu4Xjp0rSTqm2o1IbC1BB8YW/10unHl/anM1m8vNq8TdRTGWg
         DdlXZl5cgl+FgsoTWEYdGD4kdkKR2YP9fiMqS+0eA3Rz+JtEUzmJjY7zI9HsxyOoAIlt
         CSf0qEhEevdnQVpKGmbBkR3odEEfeOelFkJDBo9wvRTggbzgTWMNiy6BnJravXDooD6B
         HDYv002wm9HRXjVcn/Ymzz43qtIicFq/J29Qt+6uCEysbchzjJSYGKI2z/WAgHhZAv0Q
         ppB7IyEfwxB3Hx9oqxcmCKm6nbkmf949vRF2U39c9IGmskLe3nb/eZqQSMZfSf/hhz7F
         ZQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761047961; x=1761652761;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h9hpfYt5EFzc02ERX1hD5+rSyqsCx124+1sgPY772PY=;
        b=b4my5DtwR9tipESNqF3ElXho6YiekQvV96TPXvPtXERtDGZI37WWkvfUz/4I9eJsXo
         4uvkPRBLL6sU7uLe8sZojSvbM8OuXnV1s2yD21VXxg8jmc7pLRAWNYYhDxC/JK9rycrM
         VjEh3GtyJSK/11I0Vo7Ue3Vmcmfex6qFtWHmRFiLT++TAuGAEha5zeugyYjdcwpNtBg3
         IomJuXwLiBOoTsfacbMVtv3S44/KbNxhaNchP2gKzGvY0RBSAE3hsoGnkKRCs72sS2e3
         soDh/MZTHVcdbN9/WhLl51pPvMtdzhO30TKyGgHCwwlosZKqsVqbc0Jp45UA0Ugc/bLf
         AH3g==
X-Forwarded-Encrypted: i=1; AJvYcCUOJwOFXzo8KtebKDVGUmR1ChLEI+YjZPT/Uxp727sQa1HD3PgpDBFMeSz7nPex4lD6fWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws8DDg1jxCBoM+V9mLfpUz6y7hQNV4m2DHOQncoCEuWPcB1vGM
	fHUI9S3g3GpLRO4X6WLI4FmesAOI9cL7fu0lLG1JoFQC3IOJZvjCVK+h
X-Gm-Gg: ASbGnctyUo70oKwpgpP39k1709eREPmmEyN4f2w4lyXiasivUwa/YwuO/eYkQ4p5qZL
	pEBjfOcsgbIR5D+ChOnayX0NJyllcX1AvxP02DMFU8cv/jbALEi7UFImE2FBi8XHPFwHHBF2wk3
	9EWbtMoyQODr/ZgcvVOP6LGQSfMvjmKd63Rwr2PQ2T2U+6kiCay82ejAL27CKzTaIP0XWUULwEC
	LDId/+VlQe0J6pjrs7q3Wer7G1913irHFDdCJIq9wwn3OjkiDP+mKjUI7VWzd7yApNXOEHegzkQ
	+0zoeWdRHW5ZtejRdYzv5GF0tlptuRDzizbseSjiroa+oAdlFRDsTwI13d1REtmBHH79OOFVmtM
	rHrVMFPN5PvyJggrG35jN8WL9DLWGH/bPQ5cdkz/dOm9GyxCMWRulCjWuKS5CsPDBJar3w8YZpM
	TWLj1hVGheqV/URxNusubDnIuuLFyrv0JvvDEnL+tL
X-Google-Smtp-Source: AGHT+IEFzO9DuAcUCZ77by9/Qtc9pNvIUJ7swtZeETWh7I+s4Pb62jaP0wVe6PyeSjmrEVy1hIR5/Q==
X-Received: by 2002:a05:600c:310e:b0:471:14f5:1268 with SMTP id 5b1f17b1804b1-47117907a77mr127571345e9.25.1761047961325;
        Tue, 21 Oct 2025 04:59:21 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:4c57:4e9:b55b:f327? ([2620:10d:c092:500::6:c0ff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144b5c29sm280456455e9.12.2025.10.21.04.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 04:59:20 -0700 (PDT)
Message-ID: <aaa45f2c-749b-44bb-8ccc-fe5dfed2eadc@gmail.com>
Date: Tue, 21 Oct 2025 12:59:15 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 02/10] bpf: widen dynptr size/offset to 64 bit
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20251020222538.932915-1-mykyta.yatsenko5@gmail.com>
 <20251020222538.932915-3-mykyta.yatsenko5@gmail.com>
 <6bf95bb54fdc4048854951270fc22972da1e1b4f.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <6bf95bb54fdc4048854951270fc22972da1e1b4f.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/21/25 00:01, Eduard Zingerman wrote:
> On Mon, 2025-10-20 at 23:25 +0100, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Dynptr currently caps size and offset at 24 bits, which isn’t sufficient
>> for file-backed use cases; even 32 bits can be limiting. Refactor dynptr
>> helpers/kfuncs to use 64-bit size and offset, ensuring consistency
>> across the APIs.
>>
>> This change does not affect internals of xdp, skb or other dynptrs,
>> which continue to behave as before, and does not break binary
>> compatibility.
>>
>> The widening enables large-file access support via dynptr, implemented
>> in the next patches.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
> Hi Mykyta,
>
> Please don't drop acks.  Each time you drop ack, I need to compare old
> and new patch versions to see if anything changed.
>
> And I'll repeat myself, in case there would be a v4:
>
>    > Nit: still think that mentioning that this change does not break
>           binary compatibility is important.
>
> This was a question we had to think through before taking this route.
> And given that AI got confused with v2 regarding this, the fact is not
> obvious.
>
> Thanks,
> Eduard
>
> [...]
Hey, sorry for dropping that ack. I did mention binary
compatibility in the commit summary.

