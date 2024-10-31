Return-Path: <bpf+bounces-43661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EBC9B7FDC
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 17:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 409511C21B6E
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 16:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A4D1BBBE0;
	Thu, 31 Oct 2024 16:19:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B51D1A7065
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391561; cv=none; b=X9M3upfOjp3FnmZKE73it/TziqFy7kvTEB8l2OmqnE/UIyaGdx29cyio0LSxo5ZJUpYHZt/JN4BQzUKvqQUqLTHBHU9ZWrvZzWhlR20wQuKi+dDKWPE2a8B6AqGrdT7wcT+9+bzOn/lpv1DvCa8uSGjjBFmwuu9WwHu+RRZJSbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391561; c=relaxed/simple;
	bh=7cl0hhyAvQdRnf+86U9hQgoHrD6DSMqwdyEbE7SKAMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TSp7XECWcvEHPnkQG0lkVetW6wRy4DK0lDkSfIf9XJFWirS/LOqasjBC+q+2ULYzDPI6XVglQiyv/jU4qkVO8H31Cspychc5/xNndbStTSiMgc1u4DfoOqX+F0d0E1TlxX10In0h2130piKmV3fMY5bjm3fgjZxazYmWLDW0O6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4XfTdg2JtdzYlNgG;
	Fri,  1 Nov 2024 00:16:39 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 1 Nov
 2024 00:19:15 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 1 Nov
 2024 00:19:15 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <houtao@huaweicloud.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <billy@starlabs.sg>,
	<bpf@vger.kernel.org>, <feng.han@honor.com>, <liulu.liu@honor.com>,
	<ramdhan@starlabs.sg>, <yipengxiang@honor.com>, <zhongjinji@honor.com>
Subject: Re: [PATCH] bpf: smp_wmb before bpf_ringbuf really commit
Date: Fri, 1 Nov 2024 00:19:11 +0800
Message-ID: <20241031161911.11260-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <12bc3982-5738-5cf5-7dba-f3512a6dfac5@huaweicloud.com>
References: <12bc3982-5738-5cf5-7dba-f3512a6dfac5@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w011.hihonor.com (10.68.20.122) To a018.hihonor.com
 (10.68.17.250)

>It seems you didn't use the ringbuf related APIs (e.g.,
>ring_buffer__consume()) in libbpf to access the ring buffer. In my
>understanding, the "xchg(&hdr->len, new_len)" in bpf_ringbuf_commit()
>works as the barrier to ensure the order of committed data and hdr->len,
>and accordingly the "smp_load_acquire(len_ptr)" in
>ringbuf_process_ring() in libbpf works as the paired barrier to ensure
>the order of hdr->len and the committed data. So I think the extra
>smp_wmb() in the kernel is not necessary here. Instead, you should fix
>your code in the userspace.
>>
>> Signed-off-by: zhongjinji <zhongjinji@honor.com>
>> ---
>>  kernel/bpf/ringbuf.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
>> index e1cfe890e0be..a66059e2b0d6 100644
>> --- a/kernel/bpf/ringbuf.c
>> +++ b/kernel/bpf/ringbuf.c
>> @@ -508,6 +508,10 @@ static void bpf_ringbuf_commit(void *sample, u64 flags, bool discard)
>>  	rec_pos = (void *)hdr - (void *)rb->data;
>>  	cons_pos = smp_load_acquire(&rb->consumer_pos) & rb->mask;
>>  
>> +	/* Make sure the modification of data is visible on other CPU's
>> +	 * before consume the event
>> +	 */
>> +	smp_wmb();
>>  	if (flags & BPF_RB_FORCE_WAKEUP)
>>  		irq_work_queue(&rb->work);
>>  	else if (cons_pos == rec_pos && !(flags & BPF_RB_NO_WAKEUP))

well, I missed the implementation of __smp_store_release in the x86 architecture,
it is not necessary because __smp_store_release has a memory barrier in x86,
but it can't guarantee the order of committed data in arm64 because
__smp_store_release does not include a memory barrier, and it just ensure
the variable is visible. The implementation of ARM64 is as follows,
in common/arch/arm64/include/asm/barrier.h

#define __smp_load_acquire(p)						\
({									\
	union { __unqual_scalar_typeof(*p) __val; char __c[1]; } __u;	\
	typeof(p) __p = (p);						\
	compiletime_assert_atomic_type(*p);				\
	kasan_check_read(__p, sizeof(*p));				\
	switch (sizeof(*p)) {						\
	case 1:								\
		asm volatile ("ldarb %w0, %1"				\
			: "=r" (*(__u8 *)__u.__c)			\
			: "Q" (*__p) : "memory");			\
		break;							\
	case 2:								\
		asm volatile ("ldarh %w0, %1"				\
			: "=r" (*(__u16 *)__u.__c)			\
			: "Q" (*__p) : "memory");			\
		break;							\
	case 4:								\
		asm volatile ("ldar %w0, %1"				\
			: "=r" (*(__u32 *)__u.__c)			\
			: "Q" (*__p) : "memory");			\
		break;							\
	case 8:								\
		asm volatile ("ldar %0, %1"				\
			: "=r" (*(__u64 *)__u.__c)			\
			: "Q" (*__p) : "memory");			\
		break;							\
	}								\
	(typeof(*p))__u.__val;						\
})

