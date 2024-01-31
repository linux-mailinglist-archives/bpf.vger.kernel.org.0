Return-Path: <bpf+bounces-20792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D71843810
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 08:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F326B23FA6
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 07:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692A654BD3;
	Wed, 31 Jan 2024 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Cd/wnz99"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230BC5DF0F
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 07:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706686902; cv=none; b=p1dmBrrFDkUt0+yap/LiE02BHOSTKp8hJRQ85X8WdBbtuWbMO1/KBDsWlO3UwI/XWUUUjkmKNO+eNuiViUV9SZCiZxPByWIVq5kbHl4Ngnwuc/mz0bKRepzYozeAERxAs09/TKT2JwsVhcQol9Z3VcYXWBbglr/0P6gwEFUHtqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706686902; c=relaxed/simple;
	bh=WIZSG4WD2ongEQ/cNcLe1xGpAbaFWDxY1m4OdYmrvaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qBDeXFnVhX/J7SMXxKXsDVN1bH7omHrE997l8yD99pycJRG7yFvVHjQ3yaNpQNCfJcst/vsEnWE+klGG3xdQZK1GopypVEjrhMAZm7jnsA18As2AmOrbu3DI641e/GzYfVBiBxQG5uDHCQ815yvLh7NkFt/Gm+vRuhr7SNzhEh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Cd/wnz99; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dad95ccc-1e24-4994-ab37-44288d6ff26b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706686898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CNess5ug0bSU730FS+R6F2A9oyLbCGvlO7+1nCzDd/E=;
	b=Cd/wnz99RN463PUd5FoTS4PrTgwjs1D8xN0JMZ+xwZQ5uUSxmGYg8+W5vUdlpfEB3uvGoF
	69QyX0eq42V9prvEspj/mGi0cK4Idfhuu3RFkKPB62uLQhwyaBGukSX6gYRTlhIXBXB0Yx
	+KdHo7cWIbYl6+dUWm9IIlQfAh86T4k=
Date: Tue, 30 Jan 2024 23:41:33 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: fix bench runner SIGSEGV
Content-Language: en-GB
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
References: <20240130193649.3753476-1-andrii@kernel.org>
 <20240130193649.3753476-6-andrii@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240130193649.3753476-6-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/30/24 11:36 AM, Andrii Nakryiko wrote:
> Some benchmarks don't anticipate "consumer" and/or "producer" sides. Add

For this, you mean some future potential benchmarks, right?

> NULL checks in corresponding places and warn about inappropriate
> consumer/producer count argument values.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   tools/testing/selftests/bpf/bench.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
> index 73ce11b0547d..36962fc305eb 100644
> --- a/tools/testing/selftests/bpf/bench.c
> +++ b/tools/testing/selftests/bpf/bench.c
> @@ -330,7 +330,7 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
>   		break;
>   	case 'c':
>   		env.consumer_cnt = strtol(arg, NULL, 10);
> -		if (env.consumer_cnt <= 0) {
> +		if (env.consumer_cnt < 0) {
>   			fprintf(stderr, "Invalid consumer count: %s\n", arg);
>   			argp_usage(state);
>   		}
> @@ -607,6 +607,10 @@ static void setup_benchmark(void)
>   		bench->setup();
>   
>   	for (i = 0; i < env.consumer_cnt; i++) {
> +		if (!bench->consumer_thread) {
> +			fprintf(stderr, "benchmark doesn't have consumers!\n");
> +			exit(1);
> +		}
>   		err = pthread_create(&state.consumers[i], NULL,
>   				     bench->consumer_thread, (void *)(long)i);
>   		if (err) {
> @@ -626,6 +630,10 @@ static void setup_benchmark(void)
>   		env.prod_cpus.next_cpu = env.cons_cpus.next_cpu;
>   
>   	for (i = 0; i < env.producer_cnt; i++) {
> +		if (!bench->producer_thread) {
> +			fprintf(stderr, "benchmark doesn't have producers!\n");
> +			exit(1);
> +		}
>   		err = pthread_create(&state.producers[i], NULL,
>   				     bench->producer_thread, (void *)(long)i);
>   		if (err) {

