Return-Path: <bpf+bounces-53271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B430A4F3E8
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 02:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8238B16EAB5
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 01:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F6114658D;
	Wed,  5 Mar 2025 01:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jbouURjl"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A113AA2E
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 01:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741138586; cv=none; b=dcTsDUEGHLFvSdD3gb5Nw9ee/0ywa9mH73oOoqHb/VV/NE5VbuVPvEBvnUevEuxdtUmUKtqUG/kA1ABOBFsfJJ7ug8UXpq6WJx+oOPLFacqdFtac8KAIKNDXQWb8QOt4k84vlM7euGQ9pRElxYkJkFtJ/cuvHAo8DOBUndI/P7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741138586; c=relaxed/simple;
	bh=TJPyH+gD3BQboOZnrQdHUE8MCY+GRYwqfHzs4ORkRmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDSpktcURdGp0KmPWWeDiW7jARLRKDLk/+hnj9ksr1YbEFkqQLCYFye1J9rtIE8x2CHsWkTWzb6IUyuyXsIFbxfatak4x5rJSQvppERkaiEqeyeAqRcyW3wRSqxYV9LeoRstODV5Yx/p81Q/qzKSrH1tVrrmMgUs1o406S8edv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jbouURjl; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <716c1a2d-f4fb-407f-b77d-03019e0dd2a5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741138581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pAgdv4FIdU+D6X/ZKT+V/A2GWtawi5z/1zlXFT6xdeE=;
	b=jbouURjlivSM1EAeuj4aeHbt2ccTztdNhYBLzsWNLV1AMruNjyUuNdmw3expSqo/ouNTld
	32ChbAY8k6gHfAgMXLwtp24A+Qfu3V/0UfcVgjXGy98iOIgIEjhQqgEVo3Tr+f8ICkQHVt
	n2EO6deQ8saLumVqwneuNV693iz5tjY=
Date: Tue, 4 Mar 2025 17:36:14 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Fix dangling stdout seen
 by traffic monitor thread
To: Amery Hung <ameryhung@gmail.com>
Cc: daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com,
 martin.lau@kernel.org, kernel-team@meta.com, bpf@vger.kernel.org
References: <20250304163626.1362031-1-ameryhung@gmail.com>
 <20250304163626.1362031-3-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250304163626.1362031-3-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/4/25 8:36 AM, Amery Hung wrote:
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index ab0f2fed3c58..5b89f6ca5a0a 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -88,7 +88,11 @@ static void stdio_hijack(char **log_buf, size_t *log_cnt)
>   #endif
>   }
>   
> -static void stdio_restore_cleanup(void)
> +static pthread_mutex_t stdout_lock = PTHREAD_MUTEX_INITIALIZER;
> +
> +static bool in_crash_handler(void);
> +
> +static void stdio_restore(void)
>   {
>   #ifdef __GLIBC__
>   	if (verbose() && env.worker_id == -1) {
> @@ -98,34 +102,34 @@ static void stdio_restore_cleanup(void)
>   
>   	fflush(stdout);
>   
> -	if (env.subtest_state) {
> +	pthread_mutex_lock(&stdout_lock);
> +
> +	if (!env.subtest_state || in_crash_handler()) {

Can the stdio restore be done in the crash_handler() itself instead of having a 
special case here and adding another in_crash_handler()?

Theoretically, the crash_handler() only needs to
fflush(stdout /* whatever the current stdout is */) and...

> +		if (stdout == env.stdout_saved)
> +			goto out;
> +
> +		fclose(env.test_state->stdout_saved);
> +		env.test_state->stdout_saved = NULL;
> +		stdout = env.stdout_saved;
> +		stderr = env.stderr_saved;

... restore std{out,err} = env.std{out,err}_saved.

At the crash point, it does not make a big difference to 
fclose(evn.test_state->stdout_saved) or not?

If the crash_handler() does not close the stdout that the traffic monitor might 
potentially be using, then crash_handler() does not need to take mutex, right?

> +	} else {
>   		fclose(env.subtest_state->stdout_saved);
>   		env.subtest_state->stdout_saved = NULL;
>   		stdout = env.test_state->stdout_saved;
>   		stderr = env.test_state->stdout_saved;
> -	} else {
> -		fclose(env.test_state->stdout_saved);
> -		env.test_state->stdout_saved = NULL;
>   	}
> +out:
> +	pthread_mutex_unlock(&stdout_lock);
>   #endif
>   }
>   

[ ... ]

> +static bool in_crash_handler(void)
> +{
> +	struct sigaction sigact;
> +
> +	/* sa_handler will be cleared if invoked since crash_handler is
> +	 * registered with SA_RESETHAND
> +	 */
> +	sigaction(SIGSEGV, NULL, &sigact);
> +
> +	return sigact.sa_handler != crash_handler;
> +}
> +

