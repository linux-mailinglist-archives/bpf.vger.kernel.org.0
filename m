Return-Path: <bpf+bounces-69749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B51E8BA09F1
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 18:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D561319C4E69
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 16:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7432F5A12;
	Thu, 25 Sep 2025 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kULI3936"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91241D5CD9
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817995; cv=none; b=JZjY30I7NO64HsTDvj8eQssgBBt8Fcue6ARjqUdKMeFX+Ohuk3eXiH01lMgEMpVDCvuPXLDjY71yKmJKH1PrbnC9tTKI4kh06FSUXegs1PYq2G3/+g1KpuYZ+NunZ6v3xxdVjkAQum7v9Zg9o2vEPawzEAHxeCFMTLLsiKEeqEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817995; c=relaxed/simple;
	bh=S3NKEt4GRgoBwPONRw+g8M2LkQgCWtko1S2apP7hbdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sYXoQekesAA4cInfYMNWuJ/D4bFkWu1Rz1Ul+FOTTccFeW0uqR6oEMG6LupfsN6shbGU9lC7msudB0lVRlBa50dr58Vs5UQplpGxxdN22Y5ZHSrN1tO28jpeNgKRO6VjHZ5IBN3AmiHAeed7WE+SJob7azstVxJAHMOHcdfN27Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kULI3936; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <977e0020-fb79-4bf7-9349-cd99dc0d93d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758817981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XHyNLQlojJR72U3JVe8KHfwEXQ2ZW6KVB1AD3T02K0A=;
	b=kULI3936GhlERED/54S8LILzUfOPEmXkPI3zcfMSH4D1UNT8RO+Y5kfvLBfKFIrGOi7pqp
	U+eWD612LQdfa7XVAN/p9/cAKoybrJqMv3GHRejORIEeEf/SNcGThIZ5ntQEDZx4jxase9
	Prf8hO6CaJ13AFvK1ySlBv+HOElNBGc=
Date: Thu, 25 Sep 2025 09:32:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 5/6] bpf: mark bpf_stream_vprink kfunc with
 KF_IMPLICIT_PROG_AUX_ARG
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, dwarves <dwarves@vger.kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Eduard <eddyz87@gmail.com>,
 Tejun Heo <tj@kernel.org>, Kernel Team <kernel-team@meta.com>
References: <20250924211716.1287715-1-ihor.solodrai@linux.dev>
 <20250924211716.1287715-6-ihor.solodrai@linux.dev>
 <CAADnVQLVeZd0JOz-GBgZfi=t5kvtH_z1Ri2w6b-AW7DHgEBv5w@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQLVeZd0JOz-GBgZfi=t5kvtH_z1Ri2w6b-AW7DHgEBv5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 9/25/25 3:01 AM, Alexei Starovoitov wrote:
> On Wed, Sep 24, 2025 at 10:17 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> Update bpf_stream_vprink macro in libbpf and fix call sites in
> 
> 't' is missing in bpf_stream_vprintk().
> 
>> the relevant selftests.
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  kernel/bpf/helpers.c                            | 2 +-
>>  kernel/bpf/stream.c                             | 3 +--
>>  tools/lib/bpf/bpf_helpers.h                     | 4 ++--
>>  tools/testing/selftests/bpf/progs/stream_fail.c | 6 +++---
>>  4 files changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 6b46acfec790..875195a0ea72 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -4378,7 +4378,7 @@ BTF_ID_FLAGS(func, bpf_strnstr);
>>  #if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
>>  BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
>>  #endif
>> -BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
>> +BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS | KF_IMPLICIT_PROG_AUX_ARG)
> 
> This kfunc will be in part of 6.17 release in a couple days,
> so backward compat work is necessary.
> I don't think we can just remove the arg.

Acked.

> 
>> --- a/tools/lib/bpf/bpf_helpers.h
>> +++ b/tools/lib/bpf/bpf_helpers.h
>> @@ -316,7 +316,7 @@ enum libbpf_tristate {
>>  })
>>
>>  extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args,
>> -                             __u32 len__sz, void *aux__prog) __weak __ksym;
>> +                             __u32 len__sz) __weak __ksym;
> 
> CI is complaining of conflicting types for 'bpf_stream_vprintk',
> since it's using pahole master.
> It will stop complaining once pahole changes are merged,
> but this issue will affect all developers until they
> update pahole.
> Not sure how to keep backward compat.

Right.

One way to do it is to conditionalize new kfunc defitions under a
config flag similar to how we have CONFIG_PAHOLE_HAS_SPLIT_BTF and co.

But this seems like too much trouble for just a couple of kfuncs,
especially since we do not guarantee stable interface for kfuncs.

We could ask people to update pahole version if they run into
issues. And they shouldn't unless they are actually using the kfuncs,
or more specifically: have their own declarations of said kfuncs.

bpf_stream_vprintk() is a special case, because it is already in
libbpf.

