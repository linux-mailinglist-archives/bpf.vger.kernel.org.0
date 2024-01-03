Return-Path: <bpf+bounces-18879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B000E823427
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 19:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2EBD1C23CD3
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 18:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F7A1C68D;
	Wed,  3 Jan 2024 18:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l6hK0Wvl"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76031C687
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3ac01843-9dbf-4c5b-a1ac-9acda8c47f19@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704305718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ePo2e7VahwNsJqqP8C5+eRFkn+vsnHXsUq4BXBIX04=;
	b=l6hK0WvlDNApC2jS75NwrGEgce2p9BbUcRUd0tHdWHaP/o/qu4GB3udOFxKFOH4YhsudX1
	rJALU2JTg6zKVMwnn8uAQPHSyyNJEDMIgsxnM7sVtjxfnwgxeAUnB65EAc/zL2Fy0hp6O4
	35qBRWQePQit3jrIj74OYWy4roWfvJE=
Date: Wed, 3 Jan 2024 10:15:10 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 2/3] selftests/bpf: Double the size of test_loader log
Content-Language: en-GB
To: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
References: <20240102193531.3169422-1-iii@linux.ibm.com>
 <20240102193531.3169422-3-iii@linux.ibm.com>
 <6f05eb0d-4807-4eef-99ba-2bfa9bd334af@linux.dev>
 <958781f9b02cb1d5ef82a0d78d65ecdbb3f26893.camel@linux.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <958781f9b02cb1d5ef82a0d78d65ecdbb3f26893.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/2/24 11:05 PM, Ilya Leoshkevich wrote:
> On Tue, 2024-01-02 at 16:41 -0800, Yonghong Song wrote:
>> On 1/2/24 11:30 AM, Ilya Leoshkevich wrote:
>>> Testing long jumps requires having >32k instructions. That many
>>> instructions require the verifier log buffer of 2 megabytes.
>>>
>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> ---
>>>    tools/testing/selftests/bpf/test_loader.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/test_loader.c
>>> b/tools/testing/selftests/bpf/test_loader.c
>>> index 37ffa57f28a1..b0bfcc8d4638 100644
>>> --- a/tools/testing/selftests/bpf/test_loader.c
>>> +++ b/tools/testing/selftests/bpf/test_loader.c
>>> @@ -12,7 +12,7 @@
>>>    #define str_has_pfx(str, pfx) \
>>>          (strncmp(str, pfx, __builtin_constant_p(pfx) ? sizeof(pfx)
>>> - 1 : strlen(pfx)) == 0)
>>>    
>>> -#define TEST_LOADER_LOG_BUF_SZ 1048576
>>> +#define TEST_LOADER_LOG_BUF_SZ 2097152
>> I think this patch is not necessary.
>> If the log buffer size is not enough, the kernel
>> verifier will wrap around and overwrite some initial states,
>> but all later states are still preserved. In my opinion,
>> there is really no need to increase the buffer size in this case,
>> esp. it is a verification success case.
> What I observed in this case was that bpf_check() still returned
> -ENOSPC and failed the prog load. IIUC you are referring to the
> functionality introduced by the following commit:
>
> commit 1216640938035e63bdbd32438e91c9bcc1fd8ee1
> Author: Andrii Nakryiko <andrii@kernel.org>
> Date:   Thu Apr 6 16:41:49 2023 -0700
>
>      bpf: Switch BPF verifier log to be a rotating log by default
>
> The commit message says, among other things:
>
>      The only user-visible change is which portion of verifier log user
>      ends up seeing *if buffer is too small*.
>
> So if we don't increase the log size, we would still have to deal with
> -ENOSPC. An alternative would be to reallocate the log buffer and try
> again. But I thought that for the test code we better keep it as simple
> as possible.

Okay, thanks for the explanation. I applied the patch set to
my local env and indeed, with this patch, I can see libbpf returns
an error. So as you suggested, let us increase the buffer size to
avoid extra handling in test_progs. So

Acked-by: Yonghong Song <yonghong.song@linux.dev>

>   
>>>    #define TEST_TAG_EXPECT_FAILURE "comment:test_expect_failure"
>>>    #define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"

