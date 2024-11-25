Return-Path: <bpf+bounces-45569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB3F9D855D
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 13:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51868B3C244
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 10:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125E2194A65;
	Mon, 25 Nov 2024 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AG/iqdDk"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED541946BC
	for <bpf@vger.kernel.org>; Mon, 25 Nov 2024 10:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531970; cv=none; b=bifZRHZM6pCqGZMFv9xXaPhSvnXt2bRZlKdy6SsXsakaznHgLBRACA8HtgFgYBacIx5WlR1bZwCn83+DtxtX7FZ+EZOtxLouyMbomPiTEQwDpfLSZCPyN5kXmqJ7Oy2cAuxjIPvYr2kv+wShMQZz1/sLHZTEn+VsDaeJiYi5aoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531970; c=relaxed/simple;
	bh=N5OJASuUNrxir7OkItusUNt/HE0H2KgHqM5QwkfAxB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBvXBeQlvh9FctLfqHJJu6qFzL8hg2XMIzd94xMpMvKusXLyehYuCOo5xrqTnH/Ox6A0XHdxCSpy9d5lDv9T3RlTqvSw4eMfIPAjTGFfkMSN8GApcaZWg5mRRoJN+qzBCMzC2hOInOoNU07yK+raSSyoIO8mIQ69d7RZMZDVxfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AG/iqdDk; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0a8c2285-29c2-4a79-b704-c2baeac90b70@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732531965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A1KpdPwnSbk5EQncnXyppapMggQ4L+h6E0nxjLIioNE=;
	b=AG/iqdDkm5jIIRtnb7xBAxMVoJGAo2sn3tvY6bD4JkeXlKoVRse76XaLuAX4yie46AGQGF
	JsH5Y15Jp4wqxOt8rbkiipPmGxsWxcOWOR6skMT7Feqmh3/hVHvqJzBAUC+swQLa3P6Xbn
	hxogJnIFHTnn1HgEfqI7udwg0HC99jw=
Date: Mon, 25 Nov 2024 11:52:41 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 4/4] bpf/selftests: add simple selftest for
 bpf_smc_ops
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 pabeni@redhat.com, song@kernel.org, sdf@google.com, haoluo@google.com,
 yhs@fb.com, edumazet@google.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, jolsa@kernel.org, guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 dtcccc@linux.alibaba.com
References: <1729737768-124596-1-git-send-email-alibuda@linux.alibaba.com>
 <1729737768-124596-5-git-send-email-alibuda@linux.alibaba.com>
 <8c06240b-540b-472f-974f-d2db80d90c22@linux.dev>
 <e8ba7dc0-96b5-4119-b2f6-b07432f65fdb@linux.alibaba.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <e8ba7dc0-96b5-4119-b2f6-b07432f65fdb@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 21.11.24 03:00, D. Wythe wrote:
>
>
> On 11/3/24 9:01 PM, Zhu Yanjun wrote:
>> 在 2024/10/24 4:42, D. Wythe 写道:
>>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>>
>>> This PATCH adds a tiny selftest for bpf_smc_ops, to verify the ability
>>> to attach and write access.
>>>
>>> Follow the steps below to run this test.
>>>
>>> make -C tools/testing/selftests/bpf
>>> cd tools/testing/selftests/bpf
>>> sudo ./test_progs -t smc
>>
>> Thanks a lot.
>>
>> # ./test_progs -t smc
>> #27/1    bpf_smc/load:OK
>> #27      bpf_smc:OK
>> Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>>
>> The above command is based on several kernel modules. After these 
>> dependent kernel modules are loaded, then can run the above command 
>> successfully.
>>
>> Zhu Yanjun
>>
>
> Hi, Yanjun
>
> This is indeed a problem, a better way may be to create a separate 
> testing directory for SMC, and we are trying to do this.

Got it. In the latest patch series, if a test program in sample/bpf can 
verify this bpf feature, it is better than a selftest program in the 
directory tools/testing/selftests/bpf.

I delved into this selftest tool. It seems that this selftest tool only 
makes the basic checks. A test program in sample/bpf can do more.

I mean, it is very nice that a selftest tool can make selftest on smc 
bpf. But it is better that a test program in sample/bpf can make some 
parameter changes in smc.

These parameter changes are mentioned in the previous commits.

"

     As a subsequent enhancement, this patch introduces a new hook for eBPF
     programs that allows decisions on whether to use SMC or not at runtime,
     including but not limited to local/remote IP address or ports. In
     simpler words, this feature allows modifications to syn_smc through 
eBPF
     programs before the TCP three-way handshake got established.

"

Zhu Yanjun

>
> Best wishes,
> D. Wythe
>
>>>
>>> Results shows:
>>> Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>>>
>>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>>> ---
>>>   .../selftests/bpf/prog_tests/test_bpf_smc.c        | 21 +++++++++++
>>>   tools/testing/selftests/bpf/progs/bpf_smc.c        | 44 
>>> ++++++++++++++++++++++
>>>   2 files changed, 65 insertions(+)
>>>   create mode 100644 
>>> tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
>>>   create mode 100644 tools/testing/selftests/bpf/progs/bpf_smc.c
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c 
>>> b/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
>>> new file mode 100644
>>> index 00000000..2299853
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
>>> @@ -0,0 +1,21 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +#include <test_progs.h>
>>> +
>>> +#include "bpf_smc.skel.h"
>>> +
>>> +static void load(void)
>>> +{
>>> +    struct bpf_smc *skel;
>>> +
>>> +    skel = bpf_smc__open_and_load();
>>> +    if (!ASSERT_OK_PTR(skel, "bpf_smc__open_and_load"))
>>> +        return;
>>> +
>>> +    bpf_smc__destroy(skel);
>>> +}
>>> +
>>> +void test_bpf_smc(void)
>>> +{
>>> +    if (test__start_subtest("load"))
>>> +        load();
>>> +}
>>> diff --git a/tools/testing/selftests/bpf/progs/bpf_smc.c 
>>> b/tools/testing/selftests/bpf/progs/bpf_smc.c
>>> new file mode 100644
>>> index 00000000..ebff477
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/progs/bpf_smc.c
>>> @@ -0,0 +1,44 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +#include "vmlinux.h"
>>> +
>>> +#include <bpf/bpf_helpers.h>
>>> +#include <bpf/bpf_tracing.h>
>>> +
>>> +char _license[] SEC("license") = "GPL";
>>> +
>>> +struct smc_bpf_ops_ctx {
>>> +    struct {
>>> +        struct tcp_sock *tp;
>>> +    } set_option;
>>> +    struct {
>>> +        const struct tcp_sock *tp;
>>> +        struct inet_request_sock *ireq;
>>> +        int smc_ok;
>>> +    } set_option_cond;
>>> +};
>>> +
>>> +struct smc_bpf_ops {
>>> +    void (*set_option)(struct smc_bpf_ops_ctx *ctx);
>>> +    void (*set_option_cond)(struct smc_bpf_ops_ctx *ctx);
>>> +};
>>> +
>>> +SEC("struct_ops/bpf_smc_set_tcp_option_cond")
>>> +void BPF_PROG(bpf_smc_set_tcp_option_cond, struct smc_bpf_ops_ctx 
>>> *arg)
>>> +{
>>> +    arg->set_option_cond.smc_ok = 1;
>>> +}
>>> +
>>> +SEC("struct_ops/bpf_smc_set_tcp_option")
>>> +void BPF_PROG(bpf_smc_set_tcp_option, struct smc_bpf_ops_ctx *arg)
>>> +{
>>> +    struct tcp_sock *tp = arg->set_option.tp;
>>> +
>>> +    tp->syn_smc = 1;
>>> +}
>>> +
>>> +SEC(".struct_ops.link")
>>> +struct smc_bpf_ops sample_smc_bpf_ops = {
>>> +    .set_option         = (void *) bpf_smc_set_tcp_option,
>>> +    .set_option_cond    = (void *) bpf_smc_set_tcp_option_cond,
>>> +};

-- 
Best Regards,
Yanjun.Zhu


