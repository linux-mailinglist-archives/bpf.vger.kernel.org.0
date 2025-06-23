Return-Path: <bpf+bounces-61281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4238CAE3FEB
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 14:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827953E0987
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 12:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439612376FF;
	Mon, 23 Jun 2025 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7xlO+Wp"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433332628D
	for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 12:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750681120; cv=none; b=sSrAoB/N7NtR5EQXBjPUL7oEb6DnUuLw2+EtgwTSrauZs4i7dijvWVlmgcJ4UDpgIp9LkyLK4d96rVtYINTx3I0x8bOYUB4xCHcIQGSReLRuFpGbBqn45nR17mo7ll6rImIEs9VFWNNQoLUOKSnW2hy4x2v/JuvYQXuiJ+ePxPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750681120; c=relaxed/simple;
	bh=1CG3QkUJa3nuEJ5lJZJwG9aL29Us1MdvTdDoK0ZKUIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EojjoX9CplK23h52giE2V6i9i5lvLbqUjNyDvFpSTmKBIMTAIhOiSeH+c478pExV+BV/C52ZgSDsnHpNAcBcO+K5PTuldskwII2DqttQ4X3ekX8w2gLru43QZQ/TbumYoQzjdWQfme3FZ5QGPBwi0om04wuC8myZY18lqDB2jew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H7xlO+Wp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750681118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SD5Y/Up57hPfCsbzYZFuaLjX6YVCYQqmMcrESiRiSLE=;
	b=H7xlO+WpIPcIYcRhfh0JyQdehaS3kxbX5C9fQJFzpyRP0u1EFGySPq/pOUKlKW1QHxePaR
	2P2/uQQqplG4RlPRTV7Gb17WZN7gVRCQ5ea08iNdNsV6bENF8PtDyBBRPNkNkc5a3PMQLX
	90aVsoLv6vl4wPilJCJqT9QOihI4AiU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-CBSDr9xKNjW8QrpbqPMtyw-1; Mon, 23 Jun 2025 08:18:32 -0400
X-MC-Unique: CBSDr9xKNjW8QrpbqPMtyw-1
X-Mimecast-MFC-AGG-ID: CBSDr9xKNjW8QrpbqPMtyw_1750681111
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-606aea61721so3672165a12.2
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 05:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750681111; x=1751285911;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SD5Y/Up57hPfCsbzYZFuaLjX6YVCYQqmMcrESiRiSLE=;
        b=g/RxMyKR35DCONGl17xUKvGWd+R1he5FVeIzaIp/TzrinfPUB4wCcTW6+Uhn7VBlS7
         CxtjpaCK4VNq2Y6Q6/0J5TYcRkCas23ZIO31dOJCBR1khMxYg/z5jW9I3H7vK6dNl3B5
         yV8TCzJ7o47bqhgXYpE/ssVXUgRdgLUJ1OZkHPBOdXrcGHimilFq6DycEQOVCoKykyWu
         qZZ3W3JlLb8LoIdJxokyG2NJxnvREpDVSFsPcmpL0m4q3h12PNDKw9+lBwGxmYdPpk9E
         s0Yf8QAHLIJnXZPepLkXwOgbAeavROu2HlE1PV2Uk500RKjmCAbLXsErP+pPdMnfPAbO
         HKSw==
X-Gm-Message-State: AOJu0YwRPkD5e66nlz7MZGDQjaDx5VvlbSbK8vETFYOPF8c09EuwIFkE
	CVBMzseHdnQntcHku4X0vuKLy3HFYYRAjTgr3hEBnrFpmtKi2zdFJ2vGeT+S7Rl8XcwxbVE1tJb
	hXkWK7TGssNUROgNBb3sMFWyC7gkSEkqK1UP+KUo93ZhUbflCSYt/
X-Gm-Gg: ASbGncu92rZecqDByZu1DmEqy+zJn0IXXREDJ+XpyHTesNJEcz4XfcY+2Hv2F8IniSe
	bkFR59qznXSnUYCzUL4M4NKo78Bczb/XXvLsV4FZvZwOcKFqLdCymD2ZpdN278JYox2LTrt6aSK
	B2MIdNKZIIt0CFuPwxB9cAK446/2x9j7air1vqM3xviV9ohMUAcAJ9VMTrSMwPeSIYb83aLVXFH
	VuxidMnxlXd+XtJKsz2brq+lznw/cTbGWSVBm8xl5a0JZxHs+/Ua/SzkYPCmA0Wzu0CHK3klBpi
	G5gPfZVxPgk6kFCke1uctf74GsXhs7nwLqXmggXUik+gvg3/lvvQuy8H
X-Received: by 2002:a05:6402:27d2:b0:609:b8f6:7e83 with SMTP id 4fb4d7f45d1cf-60a1ccb423emr10751670a12.11.1750681110593;
        Mon, 23 Jun 2025 05:18:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM7ZxrypbGk1eO4cxPtQtqmnymae1+Q5CEYP+Y3Tf0UHJMp4FBGvASMJHhSrheMx46E7meog==
X-Received: by 2002:a05:6402:27d2:b0:609:b8f6:7e83 with SMTP id 4fb4d7f45d1cf-60a1ccb423emr10751636a12.11.1750681110166;
        Mon, 23 Jun 2025 05:18:30 -0700 (PDT)
Received: from [192.168.0.102] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60a18cba458sm6090606a12.59.2025.06.23.05.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 05:18:29 -0700 (PDT)
Message-ID: <cd1fe2d1-463f-4304-8576-95c5388c4ef3@redhat.com>
Date: Mon, 23 Jun 2025 14:18:27 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 4/4] selftests/bpf: Add tests for string
 kfuncs
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <cover.1750402154.git.vmalik@redhat.com>
 <17543560f4a1e269aec6596e72fe3fff8ef1dd2e.1750402154.git.vmalik@redhat.com>
 <fdbb8caa-77f6-4143-ad0b-4f32d9e6d8e6@redhat.com>
 <CAADnVQKj3iTJyhXiQbcSo=6rJarfY_uMQi9yhytmjX-y24GXkQ@mail.gmail.com>
 <6c716452-5743-4708-a0cc-34166a742c93@redhat.com>
 <46be3ce7314e2f41a34acf5b1c78cf1e4b7022cd.camel@linux.ibm.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <46be3ce7314e2f41a34acf5b1c78cf1e4b7022cd.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/23/25 14:12, Ilya Leoshkevich wrote:
> On Mon, 2025-06-23 at 08:05 +0200, Viktor Malik wrote:
>> On 6/20/25 20:06, Alexei Starovoitov wrote:
>>> On Fri, Jun 20, 2025 at 5:33 AM Viktor Malik <vmalik@redhat.com>
>>> wrote:
>>>>
>>>>> +SEC("syscall") __retval(USER_PTR_ERR) int
>>>>> test_strnstr_user_ptr2(void *ctx) { return bpf_strnstr("hello",
>>>>> user_ptr, 1); }
>>>>
>>>> For some reason, these tests are failing on s390x. I'll
>>>> investigate.
>>>
>>> I suspect this is the reason for failures:
>>>
>>> +char *user_ptr = (char *)1;
>>> +char *invalid_kern_ptr = (char *)-1;
>>
>> Actually, the kernel address works fine, it's the userspace addresses
>> causing the problem (user_ptr and NULL). On s390,
>> __get_kernel_nofault
>> always returns 0 for these addresses instead of going to the
>> exception
>> table.
>>
>>> Ilya,
>>>
>>> Please suggest user/kern addresses to use for these tests.
>>
>> FWIW, I've also tried a couple other random userspace addresses, for
>> all
>> of them __get_kernel_nofault returned 0.
>>
>> In string kfuncs, 0 is treated as the end of the string (not an
>> error),
>> so, unless some s390 expert has a better solution, the best I can
>> think
>> of here is to disable the userspace addresses tests on s390.
>>
>> Viktor
> 
> Unfortunately NULL is a valid kernel pointer on s390; this is very
> annoying, but unlikely to change any time soon.
> 
> Also, s390 has overlapping kernel and user address spaces. This means
> that you cannot deduce by the value of an address whether it's a
> kernel or a user address; something like 0x400000 can be both valid
> kernel and user address. Normal dereferences access the kernel address
> space; in order to access the user address space, one has to use magic
> machine instructions.
> 
> So I would disable both NULL and invalid user_ptr tests on s390, since
> they do not apply. I would still test for an invalid kernel_ptr though;
> accessing (char *)-1 should cause an exception on s390.

That is indeed the case.

Thanks for the clarification! I'll send v7 with the problematic tests
disabled for s390.


