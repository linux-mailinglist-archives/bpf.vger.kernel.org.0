Return-Path: <bpf+bounces-56757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AD4A9D63B
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 01:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B077F9C84D2
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 23:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B482973D8;
	Fri, 25 Apr 2025 23:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tia0CaSa"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5DF257AF8
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 23:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745623728; cv=none; b=LSVKFXypNnucJiUPQeYtHneo5dsBh25x4SygjuqvcrUHUuYmPo0zkCmT5ETosGdfAarsDabe+3mK0QqAiv5e9YnScAjkyomTzVJxAmktfPFWv87kEeivSFDX20kyK9enYr6VPzFKVegaYnUX1G2+mAlkLbNyL2OPOjFkXl/TjoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745623728; c=relaxed/simple;
	bh=/WdqUTHtFTLFoyqocHCShulzLEkSOeBVkLFH7+ygCQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PNfg3gWiOp+D+200/E68GAeJCGpSvpUjgE+5sVh4Xjjba2Gv8yAdte/TD94ak1/daUtm4cXsmn7KVsOpSMdCBqZWXOyexyJkZ4O7Q9r4IRR/cJfOGaQF5mEDti4mKkXHvPk8VxR5hpthL4zQeuTjO6VQcZj2pBK3qgpnh6/sx78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tia0CaSa; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dc0bb19e-31cc-4fa1-9057-a188403dd422@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745623723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gmKHadEdNb/DrpvRvNIIV8K1zswPTziNfpafUqor58g=;
	b=tia0CaSaOu+vXhEwvI/am249jByBNMUVPU85tBefVHZPSL4RXjQ/GosFXgBoNvRsny5GJJ
	qyIoM81wrDEKbBGpqK1Di+Bv64mjHg7jGi8W1yTFhaTqCnWjeS7Ft1b4jyOGeuhsRcQWMq
	xEecBi6jvVnyh4QH1UK9klb0GTM9nGA=
Date: Fri, 25 Apr 2025 16:28:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 10/12] selftests/bpf: Add test for
 bpf_list_{front,back}
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 netdev@vger.kernel.org, kernel-team@meta.com,
 Amery Hung <ameryhung@gmail.com>
References: <20250418224652.105998-1-martin.lau@linux.dev>
 <20250418224652.105998-11-martin.lau@linux.dev>
 <CAP01T76heQ9rV1sNdssBQ_mSeDk_yxwP-Binh_j-AfTtXFVPdw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAP01T76heQ9rV1sNdssBQ_mSeDk_yxwP-Binh_j-AfTtXFVPdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/21/25 8:08 PM, Kumar Kartikeya Dwivedi wrote:
> On Sat, 19 Apr 2025 at 00:48, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> From: Martin KaFai Lau <martin.lau@kernel.org>
>>
>> This patch adds a test for the new bpf_list_{front,back} kfunc.
>>
>> It also adds a test to ensure the non-owning node pointer cannot
>> be used after unlock.
>>
>> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
>> ---
>>   .../selftests/bpf/prog_tests/linked_list.c    |   2 +
>>   .../selftests/bpf/progs/linked_list_peek.c    | 104 ++++++++++++++++++
>>   2 files changed, 106 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/progs/linked_list_peek.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
>> index 77d07e0a4a55..559f45239a83 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
>> @@ -7,6 +7,7 @@
>>
>>   #include "linked_list.skel.h"
>>   #include "linked_list_fail.skel.h"
>> +#include "linked_list_peek.skel.h"
>>
>>   static char log_buf[1024 * 1024];
>>
>> @@ -804,4 +805,5 @@ void test_linked_list(void)
>>          test_linked_list_success(LIST_IN_LIST, false);
>>          test_linked_list_success(LIST_IN_LIST, true);
>>          test_linked_list_success(TEST_ALL, false);
>> +       RUN_TESTS(linked_list_peek);
>>   }
>> diff --git a/tools/testing/selftests/bpf/progs/linked_list_peek.c b/tools/testing/selftests/bpf/progs/linked_list_peek.c
>> new file mode 100644
>> index 000000000000..26c978091e5b
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/linked_list_peek.c
>> @@ -0,0 +1,104 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
>> +
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include "bpf_misc.h"
>> +#include "bpf_experimental.h"
>> +
>> +struct node_data {
>> +       struct bpf_list_node l;
>> +       int key;
>> +};
>> +
>> +#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
>> +private(A) struct bpf_spin_lock glock;
>> +private(A) struct bpf_list_head ghead __contains(node_data, l);
>> +
>> +#define list_entry(ptr, type, member) container_of(ptr, type, member)
>> +#define NR_NODES 32
>> +
>> +int zero = 0;
>> +
>> +SEC("syscall")
>> +__failure __msg("invalid mem access 'scalar'")
>> +long list_peek_unlock_scalar_node(void *ctx)
>> +{
>> +       struct bpf_list_node *l_n;
>> +       struct node_data *n;
>> +
>> +       bpf_spin_lock(&glock);
>> +       l_n = bpf_list_front(&ghead);
>> +       bpf_spin_unlock(&glock);
>> +
>> +       if (l_n) {
>> +               n = list_entry(l_n, struct node_data, l);
>> +               if (n->key == 0)
>> +                       return __LINE__;
>> +       }
>> +
>> +       return 0;
>> +}
> 
> Would be good to have tests explicitly asserting the type is
> non-owning ref (even though we indirectly do that by touching it after
> unlock, relying on invalidation logic.).

I will try to address the test suggestions in patch 6 and 10.

Thanks for the review!



