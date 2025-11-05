Return-Path: <bpf+bounces-73640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2706C35FBB
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 15:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4F53A6003
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 14:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA379329373;
	Wed,  5 Nov 2025 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v2VoqFwH"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683CB311955
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762351823; cv=none; b=NdiRlvqhXqx8CO9gjmLkY8/dhjsWDRy+UiTtZ2/SnRFkrommNQ2lJz5W0Z8T8H6hbZQolYc3mwSNTKdMlxtpdrOFAQN0C9qIXZ0TyCnNpYJvg3Cvl04J5grXySc8x0iV4goKDNYYM4ZL8H4nZnjQprcDWcwAKNEbkaaJV/tdwL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762351823; c=relaxed/simple;
	bh=GuO5f1PITMKK40xOY8hKZBftofSvfoaoksU+3KNxcE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChQ+PvFfyNYmdUwzlw9SqfLH6TB/EYjwLBFJzB3Egzp3rY2FI2rum7GXtD21IH64uwOH6z377QKfzfyzSZE6s0kWgcxrvilNZJ0mClF7H9k1YHa08PPBzpj3IQb5TAOC6jpu5yDSHHL/LYX7u2aL0GFjBHd8ODrTOMrmMSZ+3z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v2VoqFwH; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ca11cc02-0cf6-48aa-8840-1662fa61dbbc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762351807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KxhfdDNOoN0RhEK/rbfglH/AWsOBbZHhZn3FyhV0K/Q=;
	b=v2VoqFwHDODgvbSmiSJXsBDSRax9kankVfjlgFFBipFw3Rb7OjTqf8QMFNaQ27UOJ9lgjQ
	/+OcW0uFbg8GnbQhwsqg7MBHnqmcsml6aQfglscx4xEOu3mu6KASCAMNOMmZGswijUrcJD
	AxnPkN8wj38hldREuf5Q0oWgdO1uv1Y=
Date: Wed, 5 Nov 2025 22:09:49 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Add test to verify freeing
 the special fields when update [lru_,]percpu_hash maps
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bot+bpf-ci@kernel.org
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Amery Hung <ameryhung@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 kernel-patches-bot@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Chris Mason <clm@meta.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
References: <20251104142714.99878-3-leon.hwang@linux.dev>
 <6099162df8322a2198497a8a27e1b0e1e5c017aeb74b20fc1eecde1e67826900@mail.kernel.org>
 <CAADnVQJZbyQWaUTzB0=82mq+hSVqxGb679cW1=t=OFCRuCVdXQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQJZbyQWaUTzB0=82mq+hSVqxGb679cW1=t=OFCRuCVdXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/11/5 01:37, Alexei Starovoitov wrote:
> On Tue, Nov 4, 2025 at 6:52 AM <bot+bpf-ci@kernel.org> wrote:
>>
>>> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
>>> index 893a4fdb4..87b0cc018 100644
>>> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
>>> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
>>
>> [ ... ]
>>
>>> @@ -568,4 +568,64 @@ int BPF_PROG(rbtree_sleepable_rcu_no_explicit_rcu_lock,
>>>       return 0;
>>>  }
>>>
>>> +private(kptr_ref) u64 ref;
>>> +
>>> +static int probe_read_refcount(void)
>>> +{
>>> +     u32 refcount;
>>> +
>>> +     bpf_probe_read_kernel(&refcount, sizeof(refcount), (void *) ref);
>>> +     return refcount;
>>> +}
>>> +
>>> +static int __insert_in_list(struct bpf_list_head *head, struct bpf_spin_lock *lock,
>>> +                         struct node_data __kptr **node)
>>> +{
>>> +     struct node_data *n, *m;
>>> +
>>> +     n = bpf_obj_new(typeof(*n));
>>> +     if (!n)
>>> +             return -1;
>>> +
>>> +     m = bpf_refcount_acquire(n);
>>> +     n = bpf_kptr_xchg(node, n);
>>> +     if (n) {
>>> +             bpf_obj_drop(n);
>>> +             bpf_obj_drop(m);
>>> +             return -2;
>>> +     }
>>
>> In __insert_in_list(), after bpf_kptr_xchg() stores the new object in
>> the map and returns the old value in n, can the error path drop both
>> n and m? At this point, the new object (pointed to by m) is already
>> referenced by the map. Dropping m here would free an object that the
>> map still points to, leaving a dangling pointer.
> 
> AI is wrong, but I bet it got confused by reuse of variable 'n'.
> It's hard for humans too.
> Leon,
> please use a different var.
> n = bpf_kptr_xchg(node, n); is a head scratcher.

No problem.

I'll update the variable names in the next revision.

> 
> Also see Yonghong's comment on v4 which I suspect applies to v5.

That was actually a misunderstanding — he didn't run the newly added tests.

Still, I'll update the test name to include "refcounted_kptr" to make it
clearer and help avoid such confusion in the future.

Thanks,
Leon


