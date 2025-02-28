Return-Path: <bpf+bounces-52937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32768A4A698
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 00:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6B31729E4
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 23:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093C41DED57;
	Fri, 28 Feb 2025 23:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dfqfdHn2"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D147A1957FF
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 23:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740785466; cv=none; b=luAC9dMmtMA/UvSfr/yWIbOo90pZE1Vk8Ig73hpGWgv9l1GCKxF98EnE0R8h0QB/EB5WynyNxVVyCoTOI/XVzAf13XtAF9UWavhG/kftNgsgmEjA8T8A0QJdTY4fm612AMOOpAZjqDpn+7PazCaxOG55zg6cf7wK0pN8LCga25s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740785466; c=relaxed/simple;
	bh=wB8qVAaCky52uTas5Ww1ay0x4BhwaGARam/KuKzRKDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4qod0sRft1Vt9U+CxDgc/au3hjGnHlIcBOFHURmzygj7AudG0NgHesmCNJavgfOIR19U2gHa9aBx1ApOoVki30mov+6dL9TS6WuDHh5xrnOmzeY7xvVk6g9ZowMGkz101XKBIHClvtQ2mlmlvlL7A3kSQfrOOQwgSb4yU7IU68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dfqfdHn2; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <96e57b71-169e-4534-b3af-d44df2b54a0b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740785458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NmgrE8kDFqDqk0z/6uNEmq6kQwu+LzWHdXQZgcmEzx0=;
	b=dfqfdHn2tLnhR5FUXVR1nYoaL+6ojEW1L6Pyz5qd/BecbDyhbMHy9gDPBV8M5siOZGiFv9
	No819LMULTEmB0sI5uKr+oMkC6IQOZbOzXYC5+j8oNwZk57OPeviwzvh3pmKxoELbI5Rwd
	zrmogrNRe4OzvOdGffuDfzp9lE5cE8E=
Date: Fri, 28 Feb 2025 15:30:53 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/1] selftests/bpf: Fix dangling stdout seen
 by traffic monitor thread
To: Amery Hung <ameryhung@gmail.com>
Cc: daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com,
 martin.lau@kernel.org, kernel-team@meta.com, bpf@vger.kernel.org
References: <20250227222336.2236460-1-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250227222336.2236460-1-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/27/25 2:23 PM, Amery Hung wrote:
> Traffic monitor thread may see dangling stdout as the main thread closes
> and reassigns stdout without protection. This happens when the main thread
> finishes one subtest and moves to another one in the same netns_new()
> scope. Fix it by first consolidating stdout assignment into
> stdio_restore_cleanup() and then protecting the use/close/reassignment of
> stdout with a lock. The locking in the main thread is always performed
> regradless of whether traffic monitor is running or not for simplicity.
> It won't have any side-effect.
> 
> The issue can be reproduced by running test_progs repeatedly with traffic
> monitor enabled:
> 
> for ((i=1;i<=100;i++)); do
>     ./test_progs -a flow_dissector_skb* -m '*'
> done
> 
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>   tools/testing/selftests/bpf/network_helpers.c |  8 ++++-
>   tools/testing/selftests/bpf/network_helpers.h |  6 ++--
>   tools/testing/selftests/bpf/test_progs.c      | 29 +++++++++++++------
>   3 files changed, 31 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index 737a952dcf80..5014fd063d67 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -743,6 +743,7 @@ struct tmonitor_ctx {
>   	pcap_t *pcap;
>   	pcap_dumper_t *dumper;
>   	pthread_t thread;
> +	pthread_mutex_t *stdout_lock;
>   	int wake_fd;
>   
>   	volatile bool done;
> @@ -953,6 +954,7 @@ static void *traffic_monitor_thread(void *arg)
>   		ifindex = ntohl(ifindex);
>   		ptype = packet[10];
>   
> +		pthread_mutex_lock(ctx->stdout_lock);
>   		if (proto == ETH_P_IPV6) {
>   			show_ipv6_packet(payload, ifindex, ptype);
>   		} else if (proto == ETH_P_IP) {
> @@ -967,6 +969,7 @@ static void *traffic_monitor_thread(void *arg)
>   			printf("%-7s %-3s Unknown network protocol type 0x%x\n",
>   			       ifname, pkt_type_str(ptype), proto);
>   		}
> +		pthread_mutex_unlock(ctx->stdout_lock);
>   	}
>   
>   	return NULL;
> @@ -1055,7 +1058,8 @@ static void encode_test_name(char *buf, size_t len, const char *test_name, const
>    * in the give network namespace.
>    */
>   struct tmonitor_ctx *traffic_monitor_start(const char *netns, const char *test_name,
> -					   const char *subtest_name)
> +					   const char *subtest_name,
> +					   pthread_mutex_t *stdout_lock)

Thinking out loud here and see if the following will be better than passing a 
pthread_mutex_t.

How about passing a print function pointer instead and this function can do what 
is needed before printf(), i.e. lock mutex here. Something like the 
"libbpf_print_fn_t __libbpf_pr" in libbpf.c.

May be the test_progs.c can set it once by calling tm_set_print (similar to 
libbpf_set_print) instead of passing as an arg during every traffic_monitor_start().

wdyt?

>   {
>   	struct nstoken *nstoken = NULL;
>   	struct tmonitor_ctx *ctx;
> @@ -1109,6 +1113,8 @@ struct tmonitor_ctx *traffic_monitor_start(const char *netns, const char *test_n
>   		goto fail_eventfd;
>   	}
>   
> +	ctx->stdout_lock = stdout_lock;
> +
>   	r = pthread_create(&ctx->thread, NULL, traffic_monitor_thread, ctx);
>   	if (r) {
>   		log_err("Failed to create thread");
> diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
> index 9f6e05d886c5..b80954eab8d8 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -251,11 +251,13 @@ struct tmonitor_ctx;
>   
>   #ifdef TRAFFIC_MONITOR
>   struct tmonitor_ctx *traffic_monitor_start(const char *netns, const char *test_name,
> -					   const char *subtest_name);
> +					   const char *subtest_name,
> +					   pthread_mutex_t *stdout_lock);
>   void traffic_monitor_stop(struct tmonitor_ctx *ctx);
>   #else
>   static inline struct tmonitor_ctx *traffic_monitor_start(const char *netns, const char *test_name,
> -							 const char *subtest_name)
> +							 const char *subtest_name,
> +							 pthread_mutex_t *stdout_lock)
>   {
>   	return NULL;
>   }
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 0cb759632225..db9ea69e8ba1 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -88,7 +88,9 @@ static void stdio_hijack(char **log_buf, size_t *log_cnt)
>   #endif
>   }
>   
> -static void stdio_restore_cleanup(void)
> +static pthread_mutex_t stdout_lock = PTHREAD_MUTEX_INITIALIZER;
> +
> +static void stdio_restore_cleanup(bool restore_default)
>   {
>   #ifdef __GLIBC__
>   	if (verbose() && env.worker_id == -1) {
> @@ -98,15 +100,25 @@ static void stdio_restore_cleanup(void)
>   
>   	fflush(stdout);
>   
> +	pthread_mutex_lock(&stdout_lock);
> +
>   	if (env.subtest_state) {
>   		fclose(env.subtest_state->stdout_saved);
>   		env.subtest_state->stdout_saved = NULL;
> -		stdout = env.test_state->stdout_saved;
> -		stderr = env.test_state->stdout_saved;
>   	} else {
>   		fclose(env.test_state->stdout_saved);
>   		env.test_state->stdout_saved = NULL;
>   	}
> +
> +	if (restore_default) {

Why a new "bool restore_default" is needed? Testing env.subtest_state is not enough?

Thanks for debugging this.

> +		stdout = env.stdout_saved;
> +		stderr = env.stderr_saved;
> +	} else if (env.subtest_state) {
> +		stdout = env.test_state->stdout_saved;
> +		stderr = env.test_state->stdout_saved;
> +	}
> +
> +	pthread_mutex_unlock(&stdout_lock);
>   #endif
>   }
>   
> @@ -121,10 +133,7 @@ static void stdio_restore(void)
>   	if (stdout == env.stdout_saved)
>   		return;
>   
> -	stdio_restore_cleanup();
> -
> -	stdout = env.stdout_saved;
> -	stderr = env.stderr_saved;
> +	stdio_restore_cleanup(true);
>   #endif
>   }
>   
> @@ -541,7 +550,8 @@ void test__end_subtest(void)
>   				   test_result(subtest_state->error_cnt,
>   					       subtest_state->skipped));
>   
> -	stdio_restore_cleanup();
> +	stdio_restore_cleanup(false);
> +
>   	env.subtest_state = NULL;
>   }
>   
> @@ -779,7 +789,8 @@ struct netns_obj *netns_new(const char *nsname, bool open)
>   	    (env.subtest_state && env.subtest_state->should_tmon)) {
>   		test_name = env.test->test_name;
>   		subtest_name = env.subtest_state ? env.subtest_state->name : NULL;
> -		netns_obj->tmon = traffic_monitor_start(nsname, test_name, subtest_name);
> +		netns_obj->tmon = traffic_monitor_start(nsname, test_name, subtest_name,
> +							&stdout_lock);
>   		if (!netns_obj->tmon) {
>   			fprintf(stderr, "Failed to start traffic monitor for %s\n", nsname);
>   			goto fail;


