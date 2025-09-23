Return-Path: <bpf+bounces-69438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 954F1B968E6
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 17:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FAD7189A4C8
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 15:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7166255222;
	Tue, 23 Sep 2025 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zbav9WKD"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C644C8F0
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641003; cv=none; b=i24lEsE8aM5c67UVwRFbpOWnAHihl6eLzsb6Pjzj6xp+lN1HA4beRN8sNby/Otz3uc8iSXwCFzipKFn8XCPQNczFYUS4crS1swnGVS9D8ZMiS76ndR89jp6o/HgHwXAGJUjvWQXgUbXmaaRBW3XqLZ8gGfIYNmWigngMA/olzFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641003; c=relaxed/simple;
	bh=MUfH0DzxW1pxsge4c3EhxyOYeUy5B2/O8IWB+1EJIoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u6MLwLO6LVAkGgFqgjMrIJiDTZ3CBWecG4so6/Qn4D/BgdjiOKICuXvC1Do46k+le6+AnlJBFUgZ2BpwRqsv0yqgL25XQIvSa8s24ZVt763Pk2IrsNCAZDtx9bW4NWce5fxGgYQ1Rk1tZNAdSK3if+r4mBwzcqKllW6D8RzsCsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zbav9WKD; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1e96aece-794e-4d50-91d9-9a46bc1e365e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758640998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ww/sUbBYBw0ccvvMaM1dqBLZ+CIJAMWLYEauZyRnMs=;
	b=Zbav9WKDYGlXBgqA2leCvKfDKMNv8ipduv0Omg2y3akZwAWph44ky8le5Cd2BNyG2AW8tr
	W6c/BK3wU1gP7dJj3QRbQsw3S4Z1NyNjScZiGA5aUnzizvAcHfGtaYVQQiVvAcnEyLxLeK
	b0KKDhhCRWYXMVWqHbEg6R5dV4nMtP0=
Date: Tue, 23 Sep 2025 23:23:13 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v2 1/6] bpf: Extend bpf syscall with common
 attributes support
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, menglong8.dong@gmail.com
References: <20250911163328.93490-1-leon.hwang@linux.dev>
 <20250911163328.93490-2-leon.hwang@linux.dev>
 <CAEf4BzZAb1RFpJFLJLWLyV-r=yrKj1_tpjk1MSvx=uHC_DG=aA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzZAb1RFpJFLJLWLyV-r=yrKj1_tpjk1MSvx=uHC_DG=aA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/17 08:06, Andrii Nakryiko wrote:
> On Thu, Sep 11, 2025 at 9:33 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> This patch extends the 'bpf()' syscall to support a set of common
>> attributes shared across all BPF commands:
>>
>> 1. 'log_buf': User-provided buffer for storing logs
>> 2. 'log_size': Size of the log buffer
>> 3. 'log_level': Log verbosity level
>>
>> These common attributes are passed as the 4th argument to the 'bpf()'
>> syscall, with the 5th argument specifying the size of this structure.
>>
>> To indicate the use of these common attributes from userspace, a new flag
>> 'BPF_COMMON_ATTRS' ('1 << 16') is introduced. This flag is OR-ed into the
>> 'cmd' field of the syscall.
>>
>> When 'cmd & BPF_COMMON_ATTRS' is set, the kernel will copy the common
>> attributes from userspace into kernel space for use.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  include/linux/syscalls.h       |  3 ++-
>>  include/uapi/linux/bpf.h       |  7 +++++++
>>  kernel/bpf/syscall.c           | 19 +++++++++++++++----
>>  tools/include/uapi/linux/bpf.h |  7 +++++++
>>  4 files changed, 31 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>> index 77f45e5d44139..94408575dc49b 100644
>> --- a/include/linux/syscalls.h
>> +++ b/include/linux/syscalls.h
>> @@ -933,7 +933,8 @@ asmlinkage long sys_seccomp(unsigned int op, unsigned int flags,
>>  asmlinkage long sys_getrandom(char __user *buf, size_t count,
>>                               unsigned int flags);
>>  asmlinkage long sys_memfd_create(const char __user *uname_ptr, unsigned int flags);
>> -asmlinkage long sys_bpf(int cmd, union bpf_attr __user *attr, unsigned int size);
>> +asmlinkage long sys_bpf(int cmd, union bpf_attr __user *attr, unsigned int size,
>> +                       struct bpf_common_attr __user *attr_common, unsigned int size_common);
>>  asmlinkage long sys_execveat(int dfd, const char __user *filename,
>>                         const char __user *const __user *argv,
>>                         const char __user *const __user *envp, int flags);
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 233de8677382e..5014baccf065f 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1474,6 +1474,13 @@ struct bpf_stack_build_id {
>>         };
>>  };
>>
>> +struct bpf_common_attr {
>> +       __u64 log_buf;
>> +       __u32 log_size;
>> +       __u32 log_level;
>> +};
>> +
>> +#define BPF_COMMON_ATTRS (1 << 16)
>
> add this into enum bpf_cmd after __MAX_BPF_CMD (with a small comment
> about the purpose of this)? That will keep everything cmd-related in
> one place
>

Ack.

>>  #define BPF_OBJ_NAME_LEN 16U
>>
>>  enum {
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 3f178a0f8eb12..d49f822ceea12 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -5987,8 +5987,10 @@ static int prog_stream_read(union bpf_attr *attr)
>>         return ret;
>>  }
>>
>> -static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
>> +static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
>> +                    bpfptr_t uattr_common, unsigned int size_common)
>>  {
>> +       struct bpf_common_attr common_attrs;
>>         union bpf_attr attr;
>>         int err;
>>
>> @@ -6002,6 +6004,14 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
>>         if (copy_from_bpfptr(&attr, uattr, size) != 0)
>>                 return -EFAULT;
>>
>> +       memset(&common_attrs, 0, sizeof(common_attrs));
>> +       if (cmd & BPF_COMMON_ATTRS) {
>> +               cmd &= ~BPF_COMMON_ATTRS;
>> +               size_common = min_t(u32, size_common, sizeof(common_attrs));
>> +               if (uattr_common.user && copy_from_bpfptr(&common_attrs, uattr_common, size_common))
>> +                       return -EFAULT;
>
> use bpf_check_uarg_tail_zero() for extra checks, just like we do for uattr
>

Ack.

Thanks,
Leon

