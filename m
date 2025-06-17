Return-Path: <bpf+bounces-60858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C3AADDE81
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 00:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C691895D78
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 22:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F8729293F;
	Tue, 17 Jun 2025 22:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D9/lvRGQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BA4169AE6
	for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 22:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750198192; cv=none; b=ur+2fgQjMHfz7sxRc7cLeOWAQR4xy9/s2wm4NYARsIdRHEHyrz8P6lQ7Y6os9PdipXE5f2H9FQnYXJZIGhUfLQqARdGJl4VU5gb4F5FcwTuT9WD4Hy9qA0jYnkjOGjUHUqABVJY6nTNdoqQCuzkhXW30Ynnsyy1ia8jctVlUF1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750198192; c=relaxed/simple;
	bh=md5ltiwqeUfrAI/H1uP9NmLu2Y+ryVbLw3ocw5PnKmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+8vG3b5i0ZAoushaKATcOtxkhiVq8x7Yx3nss5h2Fjiqj4vP0MPE3LpnfNmO0waGVpHz78vb1VWbuwRJF4/coAxVSOALcfnhSOwk0HxxUDkxNT/hLAKpZZH8fYatz7MoP3SjJUjKyKHmf7AEjZhETSTlQbJOAVM0E4ViQoM0Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D9/lvRGQ; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <88cdbd9d-e0cf-443d-b3a2-28aa7e5d896c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750198188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TsMXzQXhQLFm9pTr9bci1vqfLwP8c5etCiCzRZNSYFA=;
	b=D9/lvRGQYvSGw9GZtzyiUks0WuYvCOf1rTo9QFmCK3/HTnXQLq7v3aA/Ox4CjEi7cXHxZv
	+9ip72z53WxGSBJKA/Boa6E9e+3L0hYs+umZG7aq+8j1xamW3xqyDJ2e55HmGuT423wfML
	y/Pj61rjT9tqGdTHRaOhChlC1pIxz2Q=
Date: Tue, 17 Jun 2025 15:09:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix RELEASE build failure with
 gcc14
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250617044956.2686668-1-yonghong.song@linux.dev>
 <CAADnVQKiTOst_qaN2azvg9JXqQPJ8SqE7LMPTWve6Omo=ZhLNw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQKiTOst_qaN2azvg9JXqQPJ8SqE7LMPTWve6Omo=ZhLNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/17/25 10:24 AM, Alexei Starovoitov wrote:
> On Mon, Jun 16, 2025 at 9:50 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> With gcc14, when building with RELEASE=1, I hit four below compilation
>> failure:
>>
>> Error 1:
>>    In file included from test_loader.c:6:
>>    test_loader.c: In function ‘run_subtest’: test_progs.h:194:17:
>>        error: ‘retval’ may be used uninitialized in this function
>>     [-Werror=maybe-uninitialized]
>>      194 |                 fprintf(stdout, ##format);           \
>>          |                 ^~~~~~~
>>    test_loader.c:958:13: note: ‘retval’ was declared here
>>      958 |         int retval, err, i;
>>          |             ^~~~~~
>>
>>    The uninitialized var 'retval' actaully could cause incorrect result.
> actually
>
>> Error 2:
>>    In function ‘test_fd_array_cnt’:
>>    prog_tests/fd_array.c:71:14: error: ‘btf_id’ may be used uninitialized in this
>>        function [-Werror=maybe-uninitialized]
>>       71 |         fd = bpf_btf_get_fd_by_id(id);
>>          |              ^~~~~~~~~~~~~~~~~~~~~~~~
>>    prog_tests/fd_array.c:302:15: note: ‘btf_id’ was declared here
>>      302 |         __u32 btf_id;
>>          |               ^~~~~~
>>
>>    Changing ASSERT_GE to ASSERT_EQ can fix the compilation error. Otherwise,
>>    there is no functionality change.
>>
>> Error 3:
>>    prog_tests/tailcalls.c: In function ‘test_tailcall_hierarchy_count’:
>>    prog_tests/tailcalls.c:1402:23: error: ‘fentry_data_fd’ may be used uninitialized
>>        in this function [-Werror=maybe-uninitialized]
>>       1402 |                 err = bpf_map_lookup_elem(fentry_data_fd, &i, &val);
>>            |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>>    The code is correct. The change intends to slient gcc errors.
> to silence.
>
> Fixed the typos while applying.
> Pls use spell check.

Sorry about typo's. Will pay attention to spell check for later patches.


