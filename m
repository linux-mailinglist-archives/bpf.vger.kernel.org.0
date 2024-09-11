Return-Path: <bpf+bounces-39643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F70975978
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 19:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A42F6B21B84
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 17:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBFD1B3B27;
	Wed, 11 Sep 2024 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JswkxbU2"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAA719CC15
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726076045; cv=none; b=iI/+ikTMFFYLj7p6XL/KUoYDBSzZ1rOVZilEX0i6jbx43rWnDKr0UDCVHIUm/dYtaqA7Ora1VrX12wVnNVrPSlAUdlB6kJ9SYsIal80ytMr5p/obUC7CmSTX1M7klzX8ENhgerB9DD25tK9N3K/RfJC9JNtlsyV/m1MUHGOhqrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726076045; c=relaxed/simple;
	bh=ADWMV/I7PLbTMRzO2ohvog05sKANIhJw045KoKiwBzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fu7ZY1sOf91l35oDCd5+Txu5xqK6J0hcYYClcc6y7g4dC7oG9yuuC/jfr2qA/bywEuEh2EnZPwMwuXVIzPcOdDIPjXssVjmlcO0GIbfU2Z4WDZs1s6tRPG9gTAVo3ainJxKFXWMR3DsPcR3nGt6d8VbNfgdw8tcht5y/w8YFyzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JswkxbU2; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8047db0c-39eb-4b98-89e4-f0822805c309@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726076040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XHalqKbvZbOtWyamwKtGLymNQ5l/tzEX6wRT+G1VD8U=;
	b=JswkxbU25MFkIWcSkH0RXhnzmZRmEClO+nWuNt8VfY5NR99TnGeP3iicd8FRhyNEyGEx03
	CPn7+Kn4y/YXMT5luiRCeneDVNlBLz4+Bqb53w1PWjAyDCbsXwOeB3AujiiFCWhbPxHkMu
	qJDl64Ay8Dw/iAF+FsISwgp+ynH25NY=
Date: Wed, 11 Sep 2024 10:33:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 5/5] selftests/bpf: Expand skb dynptr
 selftests for tp_btf
To: Philo Lu <lulie@linux.alibaba.com>
Cc: bpf@vger.kernel.org, edumazet@google.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com, shuah@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 thinker.li@gmail.com, juntong.deng@outlook.com, jrife@google.com,
 alan.maguire@oracle.com, davemarchevsky@fb.com, dxu@dxuuu.xyz,
 vmalik@redhat.com, cupertino.miranda@oracle.com, mattbobrowski@google.com,
 xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20240911033719.91468-1-lulie@linux.alibaba.com>
 <20240911033719.91468-6-lulie@linux.alibaba.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240911033719.91468-6-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/10/24 8:37 PM, Philo Lu wrote:
> Add 3 test cases for skb dynptr used in tp_btf:
> - test_dynptr_skb_tp_btf: use skb dynptr in tp_btf and make sure it is
>    read-only.
> - skb_invalid_ctx_fentry/skb_invalid_ctx_fexit: bpf_dynptr_from_skb
>    should fail in fentry/fexit.
> 
> In test_dynptr_skb_tp_btf, to trigger the tracepoint in kfree_skb,
> test_pkt_access is used for its test_run, as in kfree_skb.c. Because the
> test process is different from others, a new setup type is defined,
> i.e., SETUP_SKB_PROG_TP.
> 
> The result is like:
> $ ./test_progs -t 'dynptr/test_dynptr_skb_tp_btf'
>    #84/14   dynptr/test_dynptr_skb_tp_btf:OK
>    #84      dynptr:OK
>    #127     kfunc_dynptr_param:OK
>    Summary: 2/1 PASSED, 0 SKIPPED, 0 FAILED
> 
> $ ./test_progs -t 'dynptr/skb_invalid_ctx_f'
>    #84/85   dynptr/skb_invalid_ctx_fentry:OK
>    #84/86   dynptr/skb_invalid_ctx_fexit:OK
>    #84      dynptr:OK
>    #127     kfunc_dynptr_param:OK
>    Summary: 2/2 PASSED, 0 SKIPPED, 0 FAILED
> 
> Also fix two coding style nits (change spaces to tabs).
> 
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> ---
>   .../testing/selftests/bpf/prog_tests/dynptr.c | 36 +++++++++++++++++--
>   .../testing/selftests/bpf/progs/dynptr_fail.c | 25 +++++++++++++
>   .../selftests/bpf/progs/dynptr_success.c      | 23 ++++++++++++
>   3 files changed, 82 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> index 7cfac53c0d58d..ba40be8b1c4ef 100644
> --- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
> +++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> @@ -9,6 +9,7 @@
>   enum test_setup_type {
>   	SETUP_SYSCALL_SLEEP,
>   	SETUP_SKB_PROG,
> +	SETUP_SKB_PROG_TP,
>   };
>   
>   static struct {
> @@ -28,6 +29,7 @@ static struct {
>   	{"test_dynptr_clone", SETUP_SKB_PROG},
>   	{"test_dynptr_skb_no_buff", SETUP_SKB_PROG},
>   	{"test_dynptr_skb_strcmp", SETUP_SKB_PROG},
> +	{"test_dynptr_skb_tp_btf", SETUP_SKB_PROG_TP},
>   };
>   
>   static void verify_success(const char *prog_name, enum test_setup_type setup_type)
> @@ -35,7 +37,7 @@ static void verify_success(const char *prog_name, enum test_setup_type setup_typ
>   	struct dynptr_success *skel;
>   	struct bpf_program *prog;
>   	struct bpf_link *link;
> -       int err;
> +	int err;
>   
>   	skel = dynptr_success__open();
>   	if (!ASSERT_OK_PTR(skel, "dynptr_success__open"))
> @@ -47,7 +49,7 @@ static void verify_success(const char *prog_name, enum test_setup_type setup_typ
>   	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
>   		goto cleanup;
>   
> -       bpf_program__set_autoload(prog, true);
> +	bpf_program__set_autoload(prog, true);
>   
>   	err = dynptr_success__load(skel);
>   	if (!ASSERT_OK(err, "dynptr_success__load"))
> @@ -87,6 +89,36 @@ static void verify_success(const char *prog_name, enum test_setup_type setup_typ
>   
>   		break;
>   	}
> +	case SETUP_SKB_PROG_TP:
> +	{
> +		struct __sk_buff skb = {};
> +		struct bpf_object *obj;
> +		int aux_prog_fd;
> +
> +		/* Just use its test_run to trigger kfree_skb tracepoint */
> +		err = bpf_prog_test_load("./test_pkt_access.bpf.o", BPF_PROG_TYPE_SCHED_CLS,
> +					 &obj, &aux_prog_fd);
> +		if (!ASSERT_OK(err, "prog_load sched cls"))
> +			goto cleanup;
> +
> +		LIBBPF_OPTS(bpf_test_run_opts, topts,
> +			    .data_in = &pkt_v4,
> +			    .data_size_in = sizeof(pkt_v4),
> +			    .ctx_in = &skb,
> +			    .ctx_size_in = sizeof(skb),
> +		);
> +
> +		link = bpf_program__attach(prog);
> +		if (!ASSERT_OK_PTR(link, "bpf_program__attach"))
> +			goto cleanup;
> +
> +		err = bpf_prog_test_run_opts(aux_prog_fd, &topts);

bpf_link__destroy(link) is needed. I fixed it and applied. Thanks.

> +
> +		if (!ASSERT_OK(err, "test_run"))
> +			goto cleanup;
> +
> +		break;
> +	}
>   	}

