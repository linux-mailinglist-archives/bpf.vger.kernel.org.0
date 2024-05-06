Return-Path: <bpf+bounces-28728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFA88BD6F0
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 23:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E071F21F5C
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 21:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B1715B97E;
	Mon,  6 May 2024 21:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IDSN7r1M"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B38513D2BC
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 21:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715031841; cv=none; b=BCgwzrH1KlOfvmOn6PQgMdvFdlpDvgBnyOGdAnK60lXvYfmob1bBuDCtp8fIFHZv/n/U7/QdehoXHA3TBPLN856oLsl8VbmqfFNGlOt7fRMiHSR8k3K+mC0wYPKiajmzxERpLfeP4Rzy7xNe9AlDwd99uZpaDVyNA5DA30jAc4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715031841; c=relaxed/simple;
	bh=TFwvAB/Q7sGWTCYjNrZaTCFE1HhRUyD2YqIY9PBHUk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YoeWQFOTPmiMlvH0otfhN/8xErkuUxzxfnY0wpnmPCQENKYjnwceecjXGZTju78ZCG+Y/1oy/XSXyj4R7wFPaM8h8FzQ8xNt8Xzr13XYBztRdr6aW2APlVouJgkDiogTPrTc1pL/c4nQngmw5OLDVfIHnErbF6Ku09BcBMJ1FoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IDSN7r1M; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5e3d1bd3-0893-41b0-89e1-9311d53c2198@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715031837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u2YU3J90CN6cEiW8+Xc5b+N+52V1jEgDXdQhL/NU8HU=;
	b=IDSN7r1MrM9r7TQ//ngSnuFbNbgAH/f4uZg7whmK7glcEf7loAC44GepFpkuxaD1qu+tjc
	oZ1+9v5tuAv8EY4s5L8UajECuC5fxYv9GqFJGeJjH4MWbRomWSed1ad3Gpe/oLc89yjJSW
	agiGPnenkwBs9HQ+KPc8DPaehSi9VB4=
Date: Mon, 6 May 2024 14:43:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Expand skb dynptr selftests
 for tp_btf
To: Philo Lu <lulie@linux.alibaba.com>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com,
 shuah@kernel.org, drosen@google.com, xuanzhuo@linux.alibaba.com,
 bpf@vger.kernel.org
References: <20240430121805.104618-1-lulie@linux.alibaba.com>
 <20240430121805.104618-3-lulie@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240430121805.104618-3-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/30/24 5:18 AM, Philo Lu wrote:
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
>    #77/14   dynptr/test_dynptr_skb_tp_btf:OK
>    #77      dynptr:OK
>    #120     kfunc_dynptr_param:OK
>    Summary: 2/1 PASSED, 0 SKIPPED, 0 FAILED
> 
> $ ./test_progs -t 'dynptr/skb_invalid_ctx_f'
>    #77/83   dynptr/skb_invalid_ctx_fentry:OK
>    #77/84   dynptr/skb_invalid_ctx_fexit:OK
>    #77      dynptr:OK
>    #120     kfunc_dynptr_param:OK
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
> index 7cfac53c0d58..ba40be8b1c4e 100644
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
> +
> +		if (!ASSERT_OK(err, "test_run"))
> +			goto cleanup;
> +
> +		break;
> +	}
>   	}
>   
>   	ASSERT_EQ(skel->bss->err, 0, "err");
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> index 7ce7e827d5f0..c438d1c3cac5 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> @@ -6,6 +6,7 @@
>   #include <stdbool.h>
>   #include <linux/bpf.h>
>   #include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
>   #include <linux/if_ether.h>
>   #include "bpf_misc.h"
>   #include "bpf_kfuncs.h"
> @@ -1254,6 +1255,30 @@ int skb_invalid_ctx(void *ctx)
>   	return 0;
>   }
>   
> +SEC("fentry/skb_tx_error")
> +__failure __msg("must be referenced or trusted")
> +int BPF_PROG(skb_invalid_ctx_fentry, struct __sk_buff *skb)
> +{
> +	struct bpf_dynptr ptr;
> +
> +	/* this should fail */
> +	bpf_dynptr_from_skb(skb, 0, &ptr);
> +
> +	return 0;
> +}
> +
> +SEC("fexit/skb_tx_error")
> +__failure __msg("must be referenced or trusted")
> +int BPF_PROG(skb_invalid_ctx_fexit, struct __sk_buff *skb)
> +{
> +	struct bpf_dynptr ptr;
> +
> +	/* this should fail */
> +	bpf_dynptr_from_skb(skb, 0, &ptr);
> +
> +	return 0;
> +}
> +
>   /* Reject writes to dynptr slot for uninit arg */
>   SEC("?raw_tp")
>   __failure __msg("potential write to dynptr at off=-16")
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
> index 5985920d162e..8faafab97c0e 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
> @@ -5,6 +5,7 @@
>   #include <stdbool.h>
>   #include <linux/bpf.h>
>   #include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
>   #include "bpf_misc.h"
>   #include "bpf_kfuncs.h"
>   #include "errno.h"
> @@ -544,3 +545,25 @@ int test_dynptr_skb_strcmp(struct __sk_buff *skb)
>   
>   	return 1;
>   }
> +
> +SEC("tp_btf/kfree_skb")
> +int BPF_PROG(test_dynptr_skb_tp_btf, struct __sk_buff *skb, void *location)

struct __sk_buff is the incorrect type. This happens to work but will be a 
surprise for people trying to read something (e.g. skb->len). The same goes for 
the ones in dynptr_fail.c.

> +{
> +	__u8 write_data[2] = {1, 2};
> +	struct bpf_dynptr ptr;
> +	int ret;
> +
> +	if (bpf_dynptr_from_skb(skb, 0, &ptr)) {
> +		err = 1;
> +		return 1;
> +	}
> +
> +	/* since tp_btf skbs are read only, writes should fail */
> +	ret = bpf_dynptr_write(&ptr, 0, write_data, sizeof(write_data), 0);
> +	if (ret != -EINVAL) {
> +		err = 2;
> +		return 1;
> +	}
> +
> +	return 1;
> +}


