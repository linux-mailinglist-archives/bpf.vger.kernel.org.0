Return-Path: <bpf+bounces-61178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AFFAE1E19
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 17:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 988031BC11D9
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 15:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712682BDC04;
	Fri, 20 Jun 2025 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/IphfbZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6832B229B1E
	for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432187; cv=none; b=jWWz1pL4A7gilcWyUDHcseuryWTsnvMOKLx5MR557Q4aAHQMYp/pMAIqp1CRf/0cKF7B0qilWKc71s9WcRPh5rdk7iPn6RMvyPsUrbLHWeQT3yIrxQS9G3GM1mKYFlWTn3PWIA+hC61CjaoadlaClr+QEht0EoKpYBw7KBXjROM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432187; c=relaxed/simple;
	bh=K4rYfCtV01OS+NIiIFApBwBdCLBp1/9hRrq2Axyhhpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tpqo4dTmdrNj0+9SAII/X7wjEzQ+SsValcnxiGEksh7SgzqCW7hpo2LIgtg4yFdBXyqp/y+b15xFrD0qk4g8s5+SMWYg84alNeWkfofUdVV/K+3s+a+v/NDGOHv2lKnZhj43hPnEUqO8TxGX8R7nHnqQS6mInfyxMrrKncSjaKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/IphfbZ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso1710816f8f.1
        for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 08:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750432184; x=1751036984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rYyvXMbJXor6V2Ow4j71k65zrZ6bx5mkBv6C+ZvskzI=;
        b=L/IphfbZTgOxM4lckx7M8FwANlpdwDuPp071MVz3cMO0IpxOh37yTlPCsGxtB6nz3D
         7Q2RI/Xn/1bPEO0FnN9fNH+t1G+oJ6Tr0jT44JBKDSKfxMuD6nOxEbIcAx1egT6+Y1CH
         TXtyA2Duq6bWAIC37KMuJekYF6A7BOKfk3//Kxa8o1dZJcl1U4eYikRg2aXqNeRlMVuX
         U0MMQDX+JnvOX6fuINbGjrQRnFkhrDtZo0l7aghcALx5LaglsYryL27yGk0wa08XF80+
         mGCwnzRpCNaCZ/Wlc9gLccHa5KGLdy2lmzCnC7IZbZVyPYAhNiUpuypHd8Z2T3amxy8s
         cybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750432184; x=1751036984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rYyvXMbJXor6V2Ow4j71k65zrZ6bx5mkBv6C+ZvskzI=;
        b=O1+zQfThqYr+B8fa/ND1jXMoE9Qtr6PY+ecMnd+5fDUjsGqRZBctkakRzZFUeUi2o4
         VmilHpeP5wTyneG4lqgnZSR34l2P5d9LxuMoUWeZnt2EIEqzWXKNXb2Zw9CSfjAUpPiB
         ptjj2ofx/r6VPsw5g1GFjuk7UncBCT1xVqnDZdp+gU+dhCpfTGHIrTIWZPMnmS2e0p57
         iUnY9MUlCPm5iuGg28fLsorwCU2HkDQz0towBnpOX+Ea2qjaWdi1EVj2kQwUlJmyZ/u6
         C0tkc5pchgXDasPe7YZgAHTfRuDjpl4sKG8HnKFZ2NNF220GxMh/35IPM1Vu8RG3tdgR
         lPcg==
X-Gm-Message-State: AOJu0YyxiE3cktNNYeBYCwzhLMhCyzQr01rF9F+5r9YhEe2QfVLQF7Fh
	N4nsT1Ju7GyBKwH38CfVJfMT5ACwIHzKlIrZl/51/EwvJ59xYYSg+RzT
X-Gm-Gg: ASbGncsQuQvRkQwsca2Hrc1N2wPjnqs0nrdqYfQWPn1hiKKwpiDyDS4JZLdduuv8jJ6
	zkDEzF0CKFgOb0O9zj1gAok/R7ZJVsGRPhxhpNgJ5JdYhwbs+4qnBWb3kG4Ic06+guZKlVy3zxt
	bUKp3oLp1t1ws0MynSARBsh3E+PNlS/FJ8n0dip2QxEpuFy3VwKV9efGD95aDUNgkb2dgsDxQs0
	zDSGEljkU3PS5iJr2uoOl0HC1zQlcxNJEXwnVdMYFEuhEDwRpLIDIKQUJe9voVpHNwxKwv9tXJh
	ZXmY7FZXzY+EPmHxLQY7oLFce3J6RLwi9CAgEqPwn0ku7Dqkzoo32ct37fmjACQskhDe502ii/6
	5QDJPGGKl7gptYrsJrLpkijsaGMrIJKSNN6KRRpIrsGjUCA==
X-Google-Smtp-Source: AGHT+IGGWJ64Tc0bQMCSXfJ9GMiAdM3qQAT1y3tCGsKcsqVNthVWqaFh9a7CreroUTP6KS2wPWCWSA==
X-Received: by 2002:a05:6000:178f:b0:3a4:f038:af76 with SMTP id ffacd0b85a97d-3a6d1331ef9mr2962337f8f.53.1750432183255;
        Fri, 20 Jun 2025 08:09:43 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bf28:2e00:106b:a16d:4d49:8ce9? ([2a01:4b00:bf28:2e00:106b:a16d:4d49:8ce9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d117c5f2sm2409290f8f.55.2025.06.20.08.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 08:09:41 -0700 (PDT)
Message-ID: <4c236e03-f63e-413d-86dd-15288f4c61ee@gmail.com>
Date: Fri, 20 Jun 2025 16:09:40 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_dynptr_memset() kfunc
To: Eduard Zingerman <eddyz87@gmail.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, andrii@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 mykolal@fb.com, kernel-team@meta.com
References: <20250618223310.3684760-1-isolodrai@meta.com>
 <b35ce32e-a5e7-4589-ab16-d931194a32bb@gmail.com>
 <45390c6c-bd2a-4962-8222-1ad346f9908c@linux.dev>
 <7852f30ba177dc5b811bb0840ca0f301df2a8b58.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <7852f30ba177dc5b811bb0840ca0f301df2a8b58.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/19/25 18:19, Eduard Zingerman wrote:
> On Thu, 2025-06-19 at 10:09 -0700, Ihor Solodrai wrote:
>
> [...]
>
>> But then, does memset even make sense for xdp/skb buffers?
> Why not?
>
>> Maybe -ENOTSUPP is more appropriate?
>>
>> I'd appreciate any hints.
> I think Mykyta has kernel/trace/bpf_trace.c:__bpf_dynptr_copy_str() in mind.
>
Right, similarly to `__bpf_dynptr_copy` from bpf_trace.c: fast path if 
destination has enough contiguous memory,
just call memset.
Slow path - use temp buffer, that you can memset once and then 
__bpf_dynptr_write it in a loop. __bpf_dynptr_write
handles the trickiness of the non-contiguous buffers.


