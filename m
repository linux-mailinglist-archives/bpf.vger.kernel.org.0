Return-Path: <bpf+bounces-43831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5289BA582
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 14:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD21DB211C6
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 13:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCFA175D39;
	Sun,  3 Nov 2024 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B57W/QIl"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0CE23774
	for <bpf@vger.kernel.org>; Sun,  3 Nov 2024 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730638912; cv=none; b=u4W0nHRn+nG00QBZsQlbaOTREzyCCGF2BQVwPpZkbZ+0RNfXSr2FQuoz2jiitkufkTFs2vbX/meHPzTTsfNCix2YGGNQvm2dK4vZi2OgB8QGy4DTNXV+wj6b44Mt4cWAjG530MwnyWkVO49SJJrCvpaHH35VaXCfK/Uf/xbOLck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730638912; c=relaxed/simple;
	bh=VwMBJ2K2+XANpk9Usn57k6DX/DB71GOxMHVlly/+dw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pj8m+vLIcHkGMlGxbRlSIPWn2ipYY2mi9U/5UD6CIYLNwF/kJs3nGCteoB5ofN3ohUk0A95J2TJSBEmII+pkCNZD/eveObutWSoBmTM1JmpflDx7w/Hb9h0d7/+ecyInA9cZZiv2GMmC/jbP8fQiJJ9Xe7BRngEU+jl9ZN8+fnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B57W/QIl; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8c06240b-540b-472f-974f-d2db80d90c22@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730638904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ReGYHVYD8E6M3nWSfKDR+gV/Sseh9igwmx9QD3ig80M=;
	b=B57W/QIlF/4PlN1s8QLuCxcq2PE+PlbFrDtUs23zr2HmlDSeUnB1AuQDe85dfBPMDq0xhk
	AqnvByMS9EFlNGHhXyCoA7t25eqPAnLqGosyIoLhAkFba4DfxshUO3i+h/32XssbjQGKYM
	/YUtEjua1h7Ensvjk4rZeCGygSXbXoE=
Date: Sun, 3 Nov 2024 14:01:35 +0100
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1729737768-124596-5-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/10/24 4:42, D. Wythe 写道:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> This PATCH adds a tiny selftest for bpf_smc_ops, to verify the ability
> to attach and write access.
> 
> Follow the steps below to run this test.
> 
> make -C tools/testing/selftests/bpf
> cd tools/testing/selftests/bpf
> sudo ./test_progs -t smc

Thanks a lot.

# ./test_progs -t smc
#27/1    bpf_smc/load:OK
#27      bpf_smc:OK
Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

The above command is based on several kernel modules. After these 
dependent kernel modules are loaded, then can run the above command 
successfully.

Zhu Yanjun

> 
> Results shows:
> Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> 
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>   .../selftests/bpf/prog_tests/test_bpf_smc.c        | 21 +++++++++++
>   tools/testing/selftests/bpf/progs/bpf_smc.c        | 44 ++++++++++++++++++++++
>   2 files changed, 65 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
>   create mode 100644 tools/testing/selftests/bpf/progs/bpf_smc.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c b/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
> new file mode 100644
> index 00000000..2299853
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +
> +#include "bpf_smc.skel.h"
> +
> +static void load(void)
> +{
> +	struct bpf_smc *skel;
> +
> +	skel = bpf_smc__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "bpf_smc__open_and_load"))
> +		return;
> +
> +	bpf_smc__destroy(skel);
> +}
> +
> +void test_bpf_smc(void)
> +{
> +	if (test__start_subtest("load"))
> +		load();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/bpf_smc.c b/tools/testing/selftests/bpf/progs/bpf_smc.c
> new file mode 100644
> index 00000000..ebff477
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_smc.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct smc_bpf_ops_ctx {
> +	struct {
> +		struct tcp_sock *tp;
> +	} set_option;
> +	struct {
> +		const struct tcp_sock *tp;
> +		struct inet_request_sock *ireq;
> +		int smc_ok;
> +	} set_option_cond;
> +};
> +
> +struct smc_bpf_ops {
> +	void (*set_option)(struct smc_bpf_ops_ctx *ctx);
> +	void (*set_option_cond)(struct smc_bpf_ops_ctx *ctx);
> +};
> +
> +SEC("struct_ops/bpf_smc_set_tcp_option_cond")
> +void BPF_PROG(bpf_smc_set_tcp_option_cond, struct smc_bpf_ops_ctx *arg)
> +{
> +	arg->set_option_cond.smc_ok = 1;
> +}
> +
> +SEC("struct_ops/bpf_smc_set_tcp_option")
> +void BPF_PROG(bpf_smc_set_tcp_option, struct smc_bpf_ops_ctx *arg)
> +{
> +	struct tcp_sock *tp = arg->set_option.tp;
> +
> +	tp->syn_smc = 1;
> +}
> +
> +SEC(".struct_ops.link")
> +struct smc_bpf_ops sample_smc_bpf_ops = {
> +	.set_option         = (void *) bpf_smc_set_tcp_option,
> +	.set_option_cond    = (void *) bpf_smc_set_tcp_option_cond,
> +};


