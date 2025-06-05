Return-Path: <bpf+bounces-59771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759A8ACF457
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 18:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F4DA7A82F9
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 16:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74D484039;
	Thu,  5 Jun 2025 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qhZIThZU"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E611448D5
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749141020; cv=none; b=eCqQwa8xk6cELyxF7iy0IDPXEyceTK+hb2keeGh3suIUedTv3+vjQh+iJmfcSISvip2pZa2EHjQuLC9K17xWun7cELq9MnWAfJ5IlL4RVi4ORnN8s725cWa6u3hZtP1PA8CNdlzDqcJt6CvfeQGsY40+gbQr8/SSO3wcLzw84fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749141020; c=relaxed/simple;
	bh=X/6a1vJgUlyg3FRP2DdtqlvbfRED2PbJbuph4Stx6R8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MeXmFm0th1Z7Mc+tfSsW2+GR7mmGzuHJGgccYszZDKkYslKIOkpyOs/RYolp6guTE2gTzAkWGOmnrunHmfAMkAcsdCVRkHDVNGO/IdKX2XkCymMpMsc3i1KSWqy1ldIkF46BURtJKIRs1Iqtspy42dyFRiZRiJVtB+/YZlpcVro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qhZIThZU; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <feb29bd3-eeee-4909-910b-f795a750d805@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749141014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3K0B4Zlq13YRzLXLe1eEwxxR/z2Yi2BW7CKWc5cZfuA=;
	b=qhZIThZU1k787xzxB5ROS/8XGmVq48GG37fP7WV2WxxVjn+UHS1VDXzS4opJNGtFRVfyp6
	TMkIgFXbmSXiaRigsMYvu5TVx3Dwq463hM7tnI4Z3PjyZwCem83NQ5tbzeDE0RR9tX4vXm
	LKijXxAU+r9KzCgqHcJTcOqgGS5JaDo=
Date: Thu, 5 Jun 2025 09:30:09 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: add
 cmp_map_pointer_with_const test
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com,
 yonghong.song@linux.dev, kernel-team@meta.com
References: <20250604222729.3351946-1-isolodrai@meta.com>
 <20250604222729.3351946-2-isolodrai@meta.com>
 <CAEf4BzaQbk6AAn-swV+2B6gmquEcKnW7haxhiO9sUHC30YfcCQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4BzaQbk6AAn-swV+2B6gmquEcKnW7haxhiO9sUHC30YfcCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/5/25 9:20 AM, Andrii Nakryiko wrote:
> On Wed, Jun 4, 2025 at 3:28 PM Ihor Solodrai <isolodrai@meta.com> wrote:
>>
>> Add a test for CONST_PTR_TO_MAP comparison with a non-0 constant. A
>> BPF program with this code must not pass verification in unpriv.
>>
>> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
>> ---
>>   .../selftests/bpf/progs/verifier_unpriv.c       | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
>> index 28200f068ce5..c4a48b57e167 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
>> @@ -634,6 +634,23 @@ l0_%=:     r0 = 0;                                         \
>>          : __clobber_all);
>>   }
>>
>> +SEC("socket")
>> +__description("unpriv: cmp map pointer with const")
>> +__success __failure_unpriv __msg_unpriv("R1 pointer comparison prohibited")
>> +__retval(0)
>> +__naked void cmp_map_pointer_with_const(void)
>> +{
>> +       asm volatile ("                                 \
>> +       r1 = 0;                                         \
> 
> Does this assignment serve any purpose?

I don't think so. This was copypasted from
cmp_map_pointer_with_zero. I'll try removing in both.

> 
>> +       r1 = %[map_hash_8b] ll;                         \
>> +       if r1 == 0xdeadbeef goto l0_%=;         \
>> +l0_%=: r0 = 0;                                         \
>> +       exit;                                           \
>> +"      :
>> +       : __imm_addr(map_hash_8b)
>> +       : __clobber_all);
>> +}
>> +
>>   SEC("socket")
>>   __description("unpriv: write into frame pointer")
>>   __failure __msg("frame pointer is read only")
>> --
>> 2.47.1
>>


