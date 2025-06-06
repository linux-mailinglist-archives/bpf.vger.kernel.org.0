Return-Path: <bpf+bounces-59938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5F9AD0958
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD16B170034
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C923222586;
	Fri,  6 Jun 2025 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rjshIgDG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA5E221DB6
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 21:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749244070; cv=none; b=dsu9KMGk3+CGNtsM+2+ZioMsEKNZg/LY7LcqOYTR/3ABUeOIOBJiWnHCPymyhvEUCqDMZw7omjCq8EZPo1U698yBlU9yFpblQafKid+HeLlsY4qlznwYNBCHHRgdJri1s4kadRrFMLw+VSX9NBHYyyBZdWpr6kMSpj+lT/ZhXC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749244070; c=relaxed/simple;
	bh=oYvImI87ZwK1+8Epiw2C+eaTq7mhyhmpSEcpLdClPlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ScnX31WG8LBW4jDJ5m44UZkiHaCfGZmQ5bVmTbP+qFR3FhIpHsG5Q7nOkvCO0N18fM7KVxZ7qaPSJNUO0OU4RbP7nzfC4UBtbrXT86p631+E2VWTyKTqTX6hgQqHcD/9bQt4Zc5l35W8T2FqrOufLUtAHckExuTSD7jOk5pHUfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rjshIgDG; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3ddc5084952so9300305ab.2
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 14:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749244066; x=1749848866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cp7UGG+KTG1wD09K844XDRVXwMgGVHgZtytJ6OGTY2s=;
        b=rjshIgDGzFhwHmr6x1XgNKLnUVTIjI+Ud8QKjs4CVlvBED+PdkQEltq7q2T4BTBmj1
         L0B/hwCgCoR3FEdkDr1vn5fvJvF++0R29XxB/anKLVkbDJ9iFOYT0nJdttj9yYXdG/yO
         38MzsldLvANODC81jbBw9wbTSu+9HQT8tuJFtjKah/1EbliWakGVftGoQvtY17EvfZUL
         Lyyt8nbZNPfAkoTM9acnkT7daVkypAIjJwYsr2I1Jkh2Oe8ngHAbsTtB9+n+yNDcPqZn
         pl4dZDBAaHV+fv6jMrko7+SlPri6cjCpvUeF0WSi7DfU0DdsrTsGiYC7SdROgkqWvsxk
         VBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749244066; x=1749848866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cp7UGG+KTG1wD09K844XDRVXwMgGVHgZtytJ6OGTY2s=;
        b=NAcYuYh9zuGWDyPOt/ZLC+S5iIKSONJ/x7+aOxoxzts24j9IR6a0fRII9rRZJDXFRk
         9+dl/KWduEE1h4Wc3H2Ze1Uzuy1PZemdf6Xzq4BsGssqurP07HeFTI1TwcNDD54Zauzh
         fwrBtlQD6p3y2mDp+fc3beTYVehXlzUvDowK90XGZQbetJo0Tn2eKfu1vTI5frS1pBGO
         A/Fw5BslHFFQrRevk8tm0I1SoLS7YF4HD3XV/dFov9jg5uCm2RgUQg74DPukQSBncF5M
         ar3QpL0C0c00m3r5CuB/jJSOlOUrgokyZ9YvihATMjWBC7zGpNTryr4PU22b9+7YyfJH
         5HyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+m8/2dpOFFkx/T+J5M5gcmNo4Owk/PoPnWukni2na2GjRZHu73yIIxQODcViOOPIj0Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzov1i7XgUVakUQ884tm8/tjQRpUSBWwofgwreY9cB6baA2lKXf
	gAzWFccHNYma0NeJarNJ45DFnNd+s8lIdCArQFfd+HT5Sc3/AqhR7A4AAhc4fYp31eY=
X-Gm-Gg: ASbGnctA8hpIlaeRyLmUpnT0Tm0FA8KPNvjwlgFC5l70OJg7PL5oHK+Dj6fJGN98tWt
	X4sCsZk3zMd2F8ZtIhq02wdnVphnsxFuAmPAvlpq8NzhItJBwp50p7uIZE95/xiCJUiGB+OR0bO
	EbOfu8qaPr4d8nvCkQKiyMLX4rNoP0XrxJPr7ruMrMPWD/fGgSFqaluSEAWRBupYSk2cP9q21NC
	vgCDW4LSm3ye+tv6Qn1gfxe+ipTGOYSI6s4sirFaPoEY7SbEiUwJO9RT3XKPF51PbT9ielIBHBh
	MKGwx+agGrIaBa3KYvqPz5HkBBiVGU6kuYZZsNuz8equOqWXSJkAHIZOImc=
X-Google-Smtp-Source: AGHT+IE69PpGWrIKfyhUPVdTEvtXRbHnKXqo21mxoAqyj1x89jdHRK1iXq5VkzfQ7maktedb60dqBQ==
X-Received: by 2002:a05:6e02:156c:b0:3dd:cacd:8fd3 with SMTP id e9e14a558f8ab-3ddce4c2e56mr61684385ab.22.1749244066532;
        Fri, 06 Jun 2025 14:07:46 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ddcf253162sm5782575ab.48.2025.06.06.14.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 14:07:45 -0700 (PDT)
Message-ID: <3f3e1bb3-70cd-4e7c-b217-373f5c18e0db@kernel.dk>
Date: Fri, 6 Jun 2025 15:07:45 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 3/5] io_uring/bpf: implement struct_ops registration
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1749214572.git.asml.silence@gmail.com>
 <f43e5d4e5e1797312ef3ee7986f4447bddac1d3c.1749214572.git.asml.silence@gmail.com>
 <9b9199f0-347b-42fb-984a-761f0e738837@kernel.dk>
 <4efddaee-3d1c-4953-a64d-bbe69f837955@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4efddaee-3d1c-4953-a64d-bbe69f837955@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/6/25 2:00 PM, Pavel Begunkov wrote:
> On 6/6/25 15:57, Jens Axboe wrote:
> ...>> @@ -50,20 +52,83 @@ static int bpf_io_init_member(const struct btf_type *t,
>>>                      const struct btf_member *member,
>>>                      void *kdata, const void *udata)
>>>   {
>>> +    u32 moff = __btf_member_bit_offset(t, member) / 8;
>>> +    const struct io_uring_ops *uops = udata;
>>> +    struct io_uring_ops *ops = kdata;
>>> +
>>> +    switch (moff) {
>>> +    case offsetof(struct io_uring_ops, ring_fd):
>>> +        ops->ring_fd = uops->ring_fd;
>>> +        return 1;
>>> +    }
>>> +    return 0;
>>
>> Possible to pass in here whether the ring fd is registered or not? Such
>> that it can be used in bpf_io_reg() as well.
> 
> That requires registration to be done off the syscall path (e.g. no
> workers), which is low risk and I'm pretty sure that's how it's done,
> but in either case that's not up to io_uring and should be vetted by
> bpf. It's not important to performance, and leaking that to other
> syscalls is a bad idea as well, so in the meantime it's just left
> unsupported.

Don't care about the performance as much as it being a weird crinkle.
Obviously not a huge deal, and can always get sorted out down the line.

>>> +static int io_register_bpf_ops(struct io_ring_ctx *ctx, struct io_uring_ops *ops)
>>> +{
>>> +    if (ctx->bpf_ops)
>>> +        return -EBUSY;
>>> +    if (!(ctx->flags & IORING_SETUP_DEFER_TASKRUN))
>>> +        return -EOPNOTSUPP;
>>> +
>>> +    percpu_ref_get(&ctx->refs);
>>> +    ops->ctx = ctx;
>>> +    ctx->bpf_ops = ops;
>>>       return 0;
>>>   }
>>
>> Haven't looked too deeply yet, but what's the dependency with
>> DEFER_TASKRUN?
> Unregistration needs to be sync'ed with waiters, and that can easily
> become a problem. Taking the lock like in this set in not necessarily
> the right solution. I plan to wait and see where it goes rather
> than shooting myself in the leg right away.

That's fine, would be nice with a comment or something in the commit
message to that effect at least for the time being.

-- 
Jens Axboe

