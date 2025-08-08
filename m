Return-Path: <bpf+bounces-65242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87F2B1DFF0
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 02:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D5A582AA5
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 00:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A90224D7;
	Fri,  8 Aug 2025 00:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TA+jMehR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F6453A7
	for <bpf@vger.kernel.org>; Fri,  8 Aug 2025 00:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754613020; cv=none; b=ehgAt54WZjn38AvKMfU5sAnDZjI6wugNBtQd1PB2YhiAY0S7hGOVqplcqquQcomKW4rAa0dkyoPwq0OSUWOfbDgsn079PTB9DkWJIrr7yRjV68X3CeHNqwzswc+c/VYoJPaKjKCCBBU7mKhlykeyjUHqGj9v0dovrR8y13vB7J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754613020; c=relaxed/simple;
	bh=WUprLhfPPd2be1aidNOaf90wJq6v+8opxku3Lj9Jzkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iWeGxkEdbOK7vLemIJ3E6SCgLf/CpXSjuztyhsL9t/IBYgo43XGSiyvYK4kKtfUVvSU71foWVvUQ11X8ytLMuWdVKeF3e0vGHixmfco8Y08z4tnPI6FeR+mKJIwfksTauQ4pU+0pGZef0zcmH6fF5/CqM8gZigm5T2CJbaOC0yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TA+jMehR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-458b2d9dba5so10054325e9.1
        for <bpf@vger.kernel.org>; Thu, 07 Aug 2025 17:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754613016; x=1755217816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mQarBLrNQMM6QHawlDw0jmzvW+6FdaMt47GktVHJ/2s=;
        b=TA+jMehR46x/jtG/jigL/gZr4bxqDEEIv3TWyMMuGDMjkmewDQtYiNof6uZQ4V3CWL
         Icd6sGkBVyjIiLN46RyioibyTtoiQOxcpzg21kDP8gPRJ9ZceRrN25xc4gaUPrWyQQoM
         qhHjN3KKyT8aQBA3B0/7dw5EjDB9NBmjDOF2OTTTW3mBFUaNdV0K9adxOEvXsLwONVx8
         +UcO2bH/gEj+jCvWFgPPX4cO9dd2ZQ996OldWkXnkctLwm/dqUXmZAxpkNGinf/DB53D
         WdDMFNpweYgcAHW+mbnhd8aQzD6UlDfJTLMncC0qC7Y5inkuyBOnVuXHss6g1RCkFqg8
         Z+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754613016; x=1755217816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQarBLrNQMM6QHawlDw0jmzvW+6FdaMt47GktVHJ/2s=;
        b=BaMfAw3v9ooRCc6rxo7+lLArlGBOaZEmEBXtdE+R30PuK0FXRDbbKS6ebg/NWRzlZV
         V2WU7H3STHUoMvoR9y1FpY/SryX2Rdxt4ARDIhMO/vl7ARMvqkUo8ieOsURroVNoqlpB
         VD2ahSvk3xQJwagqqCCKaTHSJL9WNayJXoEHR01PbM+FBoTWgGr6sQEFxdXQGtfoHuv/
         Sd478hdkeaiBm0X1jmNW7ftEoVimindgFQBWdFhuHckGDl2fN1eQCdeza8YsWvICasCF
         1iqJNnVL7f9OMakX7fogQtt0/16VoqOgxyaIofFaSjuNai+HDhfSsra7zAw43jjzIlrE
         dOUA==
X-Gm-Message-State: AOJu0YwcuF0GSsN6LEpGYARmbvBDO54aBCU67G+apZBtkKGuH+pEUeI1
	r7X0zWCJ+DlzXvFUEC8BQjua5SGQp4pnoT/p5Doz+FTPzEbEm1bwhj3c
X-Gm-Gg: ASbGncsJdgJUJfx/dK1KpShXZkVm0i9VHo/3B1rQYPSUr8U4TEPeMYgbPGiIQSUsKwp
	IS+berKJbDxOErXHlcwMilSoeeby16711betwxDdkfuX9LSu2H5kgQjYvTnSiIX2QNZrWEeInNw
	cK3iegOoKiX9ugDN8gmUwz0LAKEY8sNVdksQ99ZB1TFLlWQ4au7NniG+yKDA6k50iQQ7QHM9Fbb
	Hkag9KLo7/bJ4BOAHPUwGI2tmQHk0C+VHqr1EeU3A/q7yQTn4gJ8xJkizGav/CWd8LFTohS83fY
	wxmhVg62NiAIg0e6nc6AVgWllQb7lTi8HBlpb9fCIdILr+SWZ/qhaasszXF3fmbJXqR6ZhfD1iZ
	ddsrDX4C/0TsoAYaIxGixTmJUn6Nh2ViVxteyJEnei7T0emUpGwwv+baY3g1tSbPUnY+c/dU+IG
	2A/WMV6g==
X-Google-Smtp-Source: AGHT+IH1B0Ghpl6b48izGso2hAxg1+coa1dDuSWqeIgAjqmBFEyns+QTUYaMSDjGSpF/IQ49H7nxNQ==
X-Received: by 2002:a05:600c:348a:b0:459:d709:e5cf with SMTP id 5b1f17b1804b1-459f5a99721mr3881425e9.3.1754613015456;
        Thu, 07 Aug 2025 17:30:15 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bf28:2e00:106b:a16d:4d49:8ce9? ([2a01:4b00:bf28:2e00:106b:a16d:4d49:8ce9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c45346asm28412136f8f.39.2025.08.07.17.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 17:30:14 -0700 (PDT)
Message-ID: <d1dcd73a-b056-4713-8cef-83a0e0b97690@gmail.com>
Date: Fri, 8 Aug 2025 01:30:14 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/4] bpf: task work scheduling kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin Lau <kafai@meta.com>, Kernel Team <kernel-team@meta.com>,
 Eduard <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
References: <20250806144554.576706-1-mykyta.yatsenko5@gmail.com>
 <20250806144554.576706-4-mykyta.yatsenko5@gmail.com>
 <CAADnVQJy0tAj9jkLrD1cBFkLK-DayjG6uNGZ3OBQh4V5Zt=WnQ@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAADnVQJy0tAj9jkLrD1cBFkLK-DayjG6uNGZ3OBQh4V5Zt=WnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/7/25 18:27, Alexei Starovoitov wrote:
> On Wed, Aug 6, 2025 at 7:46 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> +
>> +struct bpf_task_work_context {
>> +       /* map that contains this structure in a value */
>> +       struct bpf_map *map;
>> +       /* bpf_task_work_state value, representing the state */
>> +       atomic_t state;
> a hole
>
>> +       /* bpf_prog that schedules task work */
>> +       struct bpf_prog *prog;
>> +       /* task for which callback is scheduled */
>> +       struct task_struct *task;
>> +       /* notification mode for task work scheduling */
>> +       enum task_work_notify_mode mode;
> another hole
>
>> +       /* callback to call from task work */
>> +       bpf_task_work_callback_t callback_fn;
>> +       struct callback_head work;
>> +       struct irq_work irq_work;
>> +} __aligned(8);
> and
> +struct bpf_task_work {
> +       __u64 __opaque[16];
> +} __attribute__((aligned(8)));
>
> This is way too fragile.
> A bunch of data structures in above are not in our control
> and might be changed without any one mentioning anything
> on the bpf mailing list, and things will break.
> If all of the fields were plain pointers we could consider
> placing bpf_task_work inline in the map value,
> but with inlined irq_work is imo no go.
> Indirection is the only option here.
Thanks for taking a look, makes sense we can't embed irq_work and
callback_head into the map value.

