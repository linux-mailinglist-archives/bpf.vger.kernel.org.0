Return-Path: <bpf+bounces-35797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A7F93DD23
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 05:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC00285000
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 03:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774551FC4;
	Sat, 27 Jul 2024 03:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SiguNCkc"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABCE1FA3
	for <bpf@vger.kernel.org>; Sat, 27 Jul 2024 03:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722051593; cv=none; b=B5Jy2JqiQAlrs3Tb32s1mcLYlu/UGkw72arxhOFaGYwFDItcHuHJLnIFNqIvOeEPqHK3y9mSOc0ujkm3WkWlcYqsBEDfw0wK0HM+HUS3uPXqsifMvPjAsUzFEpYcp9gMTrfRgnzpeVPuC3U1DAFTCA/Fn129gtsgd3Lc0XJAOgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722051593; c=relaxed/simple;
	bh=aSz2mxJTCMTF6TOge7XqENUhRsPJ++GTXyPJvR3DEzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQUTNIM+hwZFMBT2DDH/tQoNsKQixz/8YEbLJPqCwhN8PYxJYtjW2vDdIhja9eDceVCaeRjBKloR1B1vpIQtWfmrCFx8zZ28f2f1g9Zquiua3gUoaGmS1gMY1ahVXcqWkX23dd8H0VR7/7P3njTcb30xiHIT6FFQYO6XRn0P5YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SiguNCkc; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <92454234-b3fe-4910-88c6-9369de1b392b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722051589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WiJ8jbYTe5eg2vDTjMrxmyqUw31/RdNHeFcMLgQcLfg=;
	b=SiguNCkc6jnsIgK85xQwwZoVDKaBfSKnvaJWedW+zbQavJ32q7LB3WT0KF9kZNZd459RBd
	mTlC9tmL8Wa0QJIeZwpORHHprPyK5JsoDGZogV9cbq1z4AqWKtYMiOeD4COdfkzaakTSWP
	+AXhvgoW6KN15jfKvvhlR9RlGFHhoSg=
Date: Fri, 26 Jul 2024 20:39:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add testcase for updating
 attached freplace prog to prog_array map
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, eddyz87@gmail.com, wutengda@huaweicloud.com,
 kernel-patches-bot@fb.com
References: <20240726153952.76914-1-leon.hwang@linux.dev>
 <20240726153952.76914-3-leon.hwang@linux.dev>
 <562a4618-1f4e-4f1d-a0e4-7a3c52307100@linux.dev>
 <7a835744-055c-48e3-8592-c0208a7a63e0@linux.dev>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <7a835744-055c-48e3-8592-c0208a7a63e0@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/26/24 8:28 PM, Leon Hwang wrote:
>
> On 2024/7/27 03:38, Yonghong Song wrote:
>> On 7/26/24 8:39 AM, Leon Hwang wrote:
>>> Add a selftest to confirm the issue, which gets -EINVAL when update
>>> attached freplace prog to prog_array map, has been fixed.
>>>
>>> cd tools/testing/selftests/bpf; ./test_progs -t tailcalls
>>> 327/25  tailcalls/tailcall_freplace:OK
>>> 327     tailcalls:OK
>>> Summary: 1/25 PASSED, 0 SKIPPED, 0 FAILED
>>>
>>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> LGTM with some comments below.
>>
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>>
>>> ---
>>>    .../selftests/bpf/prog_tests/tailcalls.c      | 65 ++++++++++++++++++-
>>>    .../selftests/bpf/progs/tailcall_freplace.c   | 25 +++++++
>>>    .../testing/selftests/bpf/progs/tc_bpf2bpf.c  | 21 ++++++
>>>    3 files changed, 110 insertions(+), 1 deletion(-)
>>>    create mode 100644
>>> tools/testing/selftests/bpf/progs/tailcall_freplace.c
>>>    create mode 100644 tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
>>>
> [...]
>
>>> diff --git a/tools/testing/selftests/bpf/progs/tailcall_freplace.c
>>> b/tools/testing/selftests/bpf/progs/tailcall_freplace.c
>>> new file mode 100644
>>> index 0000000000000..2966efc06ae8f
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/progs/tailcall_freplace.c
>>> @@ -0,0 +1,25 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +#include <linux/bpf.h>
>>> +#include <bpf/bpf_helpers.h>
>>> +
>>> +struct {
>>> +    __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>>> +    __uint(max_entries, 1);
>>> +    __uint(key_size, sizeof(__u32));
>>> +    __uint(value_size, sizeof(__u32));
>>> +} jmp_table SEC(".maps");
>>> +
>>> +int count = 0;
>>> +
>>> +SEC("freplace")
>>> +int entry_freplace(struct __sk_buff *skb)
>>> +{
>>> +    count++;
>>> +
>> remove empty line here.
>>> +    bpf_tail_call_static(skb, &jmp_table, 0);
>>> +
>> remove empty line here.
>>> +    return count;
>>> +}
>>> +
>>> +char __license[] SEC("license") = "GPL";
>>> diff --git a/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
>>> b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
>>> new file mode 100644
>>> index 0000000000000..980bb810b481c
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
>>> @@ -0,0 +1,21 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +#include <linux/bpf.h>
>>> +#include <bpf/bpf_helpers.h>
>>> +
>>> +__noinline
>>> +int subprog(struct __sk_buff *skb)
>>> +{
>>> +    volatile int ret = 1;
>>> +
>> remove empty line here.
> Should we remove this empty line?
>
> ./scripts/checkpatch.pl:
>
> WARNING: Missing a blank line after declarations
> #158: FILE: tools/testing/selftests/bpf/progs/tc_bpf2bpf.c:11:
> +	int ret = 1;
> +	__sink(ret);
sorry, we should keep blank line between 'int ret = 1' and '__sink(ret)'.
>
>>> +    asm volatile (""::"r+"(ret));
>> remove above 'volatile' key word and replace asm volatile with __sink(ret).
>>> +    return ret;
>>> +}
>>> +
>>> +SEC("tc")
>>> +int entry_tc(struct __sk_buff *skb)
>>> +{
>>> +    return subprog(skb);
>>> +}
>>> +
>>> +char __license[] SEC("license") = "GPL";

