Return-Path: <bpf+bounces-45322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E60969D45A3
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 03:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A73A428278B
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 02:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E498F136E21;
	Thu, 21 Nov 2024 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MCZN9h4v"
X-Original-To: bpf@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEDC2309A2;
	Thu, 21 Nov 2024 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732154429; cv=none; b=b7OxoJIDDDQlgbLcltEiiWzMu36VC97NFwzfetkAqC6EarFbftURkLkR0G1u1aiG3iFN2f8SRXvwSWiFxeuuoLO2CoevHRmP4zYRA1wxVZAv4rs3kl5ieAl0m5fjDoopYTk7ZNuIVobev6YekM9et0xfjqM4WxjoJ2Ncur+9HEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732154429; c=relaxed/simple;
	bh=xPcOqsgfWRP7fz7JFDU7Jg1juGljBjJgB+PKbapdhn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jsR4lJ1z3uJRasIwHQQ03P1Z5hTCE+lbXoceODTL/psrUj4NaS3SRIgp0IBb5UeYZmvBOglDr6EutAmJWGWYljkNnjBygrGeisM2OmxAyZ/i3blCxhMURWlNDjHzA8mML12EcgzreyDGkRDJIoGNcX7Yv44siEVshPw+nbGoAxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MCZN9h4v; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732154423; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xh5Bpj6oIo/uqbOf5Itvj/cPaIQp+JkS88W542IzEM8=;
	b=MCZN9h4vAdFjiZtaNKa4Z392ZjS7c4D3UJCyPzZ3Aaf/UnbDHtKYQG4+OIJLRsRe1PLLJGPlc7s3M7KN3Apn0UjeWUgO9aP/RSskfsLGkKIbK7L0Mk7kF5m6/3f2fQ+gKbxMqQxLWBax0z271zkguq1t3OPcqKt1B48v3UuzThU=
Received: from 30.221.147.241(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WJu1vbm_1732154420 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 21 Nov 2024 10:00:21 +0800
Message-ID: <e8ba7dc0-96b5-4119-b2f6-b07432f65fdb@linux.alibaba.com>
Date: Thu, 21 Nov 2024 10:00:20 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/4] bpf/selftests: add simple selftest for
 bpf_smc_ops
To: Zhu Yanjun <yanjun.zhu@linux.dev>, kgraul@linux.ibm.com,
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
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <8c06240b-540b-472f-974f-d2db80d90c22@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/3/24 9:01 PM, Zhu Yanjun wrote:
> 在 2024/10/24 4:42, D. Wythe 写道:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> This PATCH adds a tiny selftest for bpf_smc_ops, to verify the ability
>> to attach and write access.
>>
>> Follow the steps below to run this test.
>>
>> make -C tools/testing/selftests/bpf
>> cd tools/testing/selftests/bpf
>> sudo ./test_progs -t smc
> 
> Thanks a lot.
> 
> # ./test_progs -t smc
> #27/1    bpf_smc/load:OK
> #27      bpf_smc:OK
> Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> 
> The above command is based on several kernel modules. After these dependent kernel modules are 
> loaded, then can run the above command successfully.
> 
> Zhu Yanjun
> 

Hi, Yanjun

This is indeed a problem, a better way may be to create a separate testing directory for SMC, and we 
are trying to do this.

Best wishes,
D. Wythe

>>
>> Results shows:
>> Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>>
>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>> ---
>>   .../selftests/bpf/prog_tests/test_bpf_smc.c        | 21 +++++++++++
>>   tools/testing/selftests/bpf/progs/bpf_smc.c        | 44 ++++++++++++++++++++++
>>   2 files changed, 65 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/bpf_smc.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c 
>> b/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
>> new file mode 100644
>> index 00000000..2299853
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
>> @@ -0,0 +1,21 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <test_progs.h>
>> +
>> +#include "bpf_smc.skel.h"
>> +
>> +static void load(void)
>> +{
>> +    struct bpf_smc *skel;
>> +
>> +    skel = bpf_smc__open_and_load();
>> +    if (!ASSERT_OK_PTR(skel, "bpf_smc__open_and_load"))
>> +        return;
>> +
>> +    bpf_smc__destroy(skel);
>> +}
>> +
>> +void test_bpf_smc(void)
>> +{
>> +    if (test__start_subtest("load"))
>> +        load();
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/bpf_smc.c 
>> b/tools/testing/selftests/bpf/progs/bpf_smc.c
>> new file mode 100644
>> index 00000000..ebff477
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/bpf_smc.c
>> @@ -0,0 +1,44 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include "vmlinux.h"
>> +
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +struct smc_bpf_ops_ctx {
>> +    struct {
>> +        struct tcp_sock *tp;
>> +    } set_option;
>> +    struct {
>> +        const struct tcp_sock *tp;
>> +        struct inet_request_sock *ireq;
>> +        int smc_ok;
>> +    } set_option_cond;
>> +};
>> +
>> +struct smc_bpf_ops {
>> +    void (*set_option)(struct smc_bpf_ops_ctx *ctx);
>> +    void (*set_option_cond)(struct smc_bpf_ops_ctx *ctx);
>> +};
>> +
>> +SEC("struct_ops/bpf_smc_set_tcp_option_cond")
>> +void BPF_PROG(bpf_smc_set_tcp_option_cond, struct smc_bpf_ops_ctx *arg)
>> +{
>> +    arg->set_option_cond.smc_ok = 1;
>> +}
>> +
>> +SEC("struct_ops/bpf_smc_set_tcp_option")
>> +void BPF_PROG(bpf_smc_set_tcp_option, struct smc_bpf_ops_ctx *arg)
>> +{
>> +    struct tcp_sock *tp = arg->set_option.tp;
>> +
>> +    tp->syn_smc = 1;
>> +}
>> +
>> +SEC(".struct_ops.link")
>> +struct smc_bpf_ops sample_smc_bpf_ops = {
>> +    .set_option         = (void *) bpf_smc_set_tcp_option,
>> +    .set_option_cond    = (void *) bpf_smc_set_tcp_option_cond,
>> +};

