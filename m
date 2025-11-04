Return-Path: <bpf+bounces-73474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0216DC325BC
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 18:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E31F51887D6C
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 17:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7538E33509D;
	Tue,  4 Nov 2025 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oPpH7d3z"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8D11DDC0B
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277438; cv=none; b=W7ETPK1iRbitZZjHkyXeH1Oy0IxsX+fY/PXRWF5oKwZHdk5FyqIFgP7gkuX/bwDitDbQIPQ0tIhVwLvNtLeqp/h9lY+Og4qR9ey52fkLQxUHfUDadg3/I+7mOVFwnM9kt2OWTGlJVceAg3U4p2D0Cgg7yZUKOWHSIE4M4TN3MlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277438; c=relaxed/simple;
	bh=yhIX5TEclnoiBz0fg3JzhCQlxIO+UE1uYXZWYOI7Ttw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oyPd5fRpRT4a3/dXi2aE/uPU7u5XbOmZi+9b0jdiGOi0Ive2LHjW5FbQOhogNexD/mLk6ENS5XEJ2NLc/MLPXCukyYHyZlAui7HzO3x9FNhgHkSum+QOifGi/0knfejjU8gi2GQ30MbZ2V2HY6GGKQYBbhUmBeLLbVVY2PwBjQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oPpH7d3z; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <02b8c4ba-eb24-41e2-813c-98b83561ef9d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762277433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i9GlcllmqBesnpFx/wMZjPrsbZ2u3RkZOd65D+jcXkk=;
	b=oPpH7d3zsFAYQE1B5RXAd1xyooIs6iHMgJXIqfq2kthwGd7qq4uP2FxD72JYwZC4IKOh25
	bHc5IFVsOMlnWz3TJS2zuE4iM4TAWrHRwRN3SLygDRc3FODUNgHHXSUW3pSlVxeTabjNIG
	QGOLBxFLNtY80Fm/SNSD665z5VHIq6E=
Date: Tue, 4 Nov 2025 09:30:27 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 4/4] selftests/bpf: Add tests to verify
 freeing the special fields when update hash and local storage maps
Content-Language: en-GB
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, ameryhung@gmail.com,
 linux-kernel@vger.kernel.org, kernel-patches-bot@fb.com
References: <20251030152451.62778-1-leon.hwang@linux.dev>
 <20251030152451.62778-5-leon.hwang@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251030152451.62778-5-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/30/25 8:24 AM, Leon Hwang wrote:
> Add tests to verify that updating hash and local storage maps decrements
> refcount when BPF_KPTR_REF objects are involved.
>
> The tests perform the following steps:
>
> 1. Call update_elem() to insert an initial value.
> 2. Use bpf_refcount_acquire() to increment the refcount.
> 3. Store the node pointer in the map value.
> 4. Add the node to a linked list.
> 5. Probe-read the refcount and verify it is *2*.
> 6. Call update_elem() again to trigger refcount decrement.
> 7. Probe-read the refcount and verify it is *1*.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>

I applied this patch only (i.e., not including patches 1/2/3) to master
branch and do bpf selftest and all tests succeeded.

[root@arch-fb-vm1 bpf]# ./test_progs -t refcounted_kptr
#294/1   refcounted_kptr/insert_read_both: remove from tree + list:OK
...
#294/18  refcounted_kptr/pcpu_hash_refcount_leak:OK
#294/19  refcounted_kptr/check_pcpu_hash_refcount:OK
#294/20  refcounted_kptr/hash_lock_refcount_leak:OK
#294/21  refcounted_kptr/check_hash_lock_refcount:OK
#294/22  refcounted_kptr/rbtree_sleepable_rcu:OK
#294/23  refcounted_kptr/rbtree_sleepable_rcu_no_explicit_rcu_lock:OK
#294/24  refcounted_kptr/cgroup_storage_lock_refcount_leak:OK
#294/25  refcounted_kptr/check_cgroup_storage_lock_refcount:OK
...

Did I miss anything?

> ---
>   .../bpf/prog_tests/refcounted_kptr.c          | 134 +++++++++++++++++-
>   .../selftests/bpf/progs/refcounted_kptr.c     | 129 +++++++++++++++++
>   2 files changed, 262 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
> index d6bd5e16e6372..0ec91ff914af7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
> +++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
> @@ -3,7 +3,7 @@
>   
>   #include <test_progs.h>
>   #include <network_helpers.h>
> -
> +#include "cgroup_helpers.h"
>   #include "refcounted_kptr.skel.h"
>   #include "refcounted_kptr_fail.skel.h"
>   
> @@ -44,3 +44,135 @@ void test_refcounted_kptr_wrong_owner(void)
>   	ASSERT_OK(opts.retval, "rbtree_wrong_owner_remove_fail_a2 retval");
>   	refcounted_kptr__destroy(skel);
>   }
> +
> +static void test_refcnt_leak(struct refcounted_kptr *skel, int key, void *values, size_t values_sz,
> +			     u64 flags, struct bpf_map *map, struct bpf_program *prog_leak,
> +			     struct bpf_program *prog_check, struct bpf_test_run_opts *opts)
> +{
> +	int ret, fd;
> +
> +	ret = bpf_map__update_elem(map, &key, sizeof(key), values, values_sz, flags);
> +	if (!ASSERT_OK(ret, "bpf_map__update_elem init"))
> +		return;
> +
> +	fd = bpf_program__fd(prog_leak);
> +	ret = bpf_prog_test_run_opts(fd, opts);
> +	if (!ASSERT_OK(ret, "bpf_prog_test_run_opts"))
> +		return;
> +	if (!ASSERT_EQ(skel->bss->kptr_refcount, 2, "refcount"))
> +		return;
> +
> +	ret = bpf_map__update_elem(map, &key, sizeof(key), values, values_sz, flags);
> +	if (!ASSERT_OK(ret, "bpf_map__update_elem dec refcount"))
> +		return;
> +
> +	fd = bpf_program__fd(prog_check);
> +	ret = bpf_prog_test_run_opts(fd, opts);
> +	ASSERT_OK(ret, "bpf_prog_test_run_opts");
> +	ASSERT_EQ(skel->bss->kptr_refcount, 1, "refcount");
> +}
> +

[...]


