Return-Path: <bpf+bounces-36714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FCE94C5B6
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 22:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 744441C20E1E
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 20:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6BE158D8B;
	Thu,  8 Aug 2024 20:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c1NGn8wV"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BFBBE40
	for <bpf@vger.kernel.org>; Thu,  8 Aug 2024 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148886; cv=none; b=U8SriUSx40iyvyRGrPeTt7pYHux3h0itMG+acTg7tk/cnSVD3nsnjk3OC0uKwsQGJrthXDHCNrDONNlY1uozMMM0H38UwqtfDMhH3PBcKbGpK4lQTCriSBBlzaVqhEqGVxnohoo7/ZaOD5LKRlPlY1PpZ6ZICpXVR2dknnIfwl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148886; c=relaxed/simple;
	bh=UYaccT1J/Pha745PlQEp8yA74yzRrR3uK/f+s8YD7NE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E65mIB6mIUOc1cz5lJuHK10DdZrhM4iixY2NVTvJIC2Y7bqGtPdmNH0ETkM2zh2w7OQWr2+syBduvgT3kB9a9EdiVw22w57WA7gI7LtZIqUsyZ4gh2kJ8hCO8Ci/ADGTcTsQpVaKK5CvHRy0L516EVuHxjo+/im9yx6PwjwkgXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c1NGn8wV; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <da9922b7-c5f3-4a33-a707-14672a8a30dd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723148881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gz3zF6EK+XdejdeNF2jznmAemgJdyxYfO4qFSJY1cfo=;
	b=c1NGn8wViphMka9yckGX5kHCHLyKHwZkmeZOP6W0VWa4emM9vMPALNpgGNCUYjU2zqQJV3
	JTjEZjygi02+MO8WoPr0nOhXKHPVHdnIGevhph+v2ByydrV5pDNdqgLEJZQTCAkJAhPhZa
	t5juMkvVvg8N8PCbSr3wmOhdtXWpdKM=
Date: Thu, 8 Aug 2024 13:27:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 3/6] selftests/bpf: netns_new() and
 netns_free() helpers.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sdf@fomichev.me,
 geliang@kernel.org, sinquersw@gmail.com, kuifeng@meta.com
References: <20240807183149.764711-1-thinker.li@gmail.com>
 <20240807183149.764711-4-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240807183149.764711-4-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/7/24 11:31 AM, Kui-Feng Lee wrote:
> +struct netns_obj *netns_new(const char *nsname, bool open)
> +{
> +	struct netns_obj *netns_obj = malloc(sizeof(*netns_obj));
> +	const char *test_name, *subtest_name;
> +	int r;
> +
> +	if (!netns_obj)
> +		return NULL;
> +	memset(netns_obj, 0, sizeof(*netns_obj));
> +
> +	netns_obj->nsname = strdup(nsname);
> +	if (!netns_obj->nsname)
> +		goto fail;
> +
> +	/* Create the network namespace */
> +	r = make_netns(nsname);
> +	if (r)
> +		goto fail;
> +
> +	/* Set the network namespace of the current process */
> +	if (open) {
> +		netns_obj->nstoken = open_netns(nsname);
> +		if (!netns_obj->nstoken)
> +			goto fail;
> +	}
> +
> +	/* Start traffic monitor */
> +	if (env.test->should_tmon ||
> +	    (env.subtest_state && env.subtest_state->should_tmon)) {
> +		test_name = env.test->test_name;
> +		subtest_name = env.subtest_state ? env.subtest_state->name : NULL;
> +		netns_obj->tmon = traffic_monitor_start(nsname, test_name, subtest_name);

The traffic_monitor_start() does open/close_netns(). close_netns() will restore 
to the previous netns. Is it better to do traffic_monitor_start() before the 
above open_netns() such that we don't have to worry about the stacking 
open_netns and which netns the close_netns will restore?


> +		if (!netns_obj->tmon)
> +			fprintf(stderr, "Failed to start traffic monitor for %s\n", nsname);
> +	} else {
> +		netns_obj->tmon = NULL;
> +	}
> +
> +	system("ip link set lo up");

The "bool open" could be false here. This command could be acted on the 
init_netns and the intention is to set lo up at the newly created netns.

> +
> +	return netns_obj;
> +fail:
> +	close_netns(netns_obj->nstoken);
> +	remove_netns(nsname);
> +	free(netns_obj->nsname);
> +	free(netns_obj);
> +	return NULL;
> +}
> +
> +/* Delete the network namespace.
> + *
> + * This function should be paired with netns_new() to delete the namespace
> + * created by netns_new().
> + */
> +void netns_free(struct netns_obj *netns_obj)
> +{
> +	if (!netns_obj)
> +		return;
> +	if (netns_obj->tmon)
> +		traffic_monitor_stop(netns_obj->tmon);
> +	close_netns(netns_obj->nstoken);
> +	remove_netns(netns_obj->nsname);
> +	free(netns_obj->nsname);
> +	free(netns_obj);
> +}
> +
>   /* extern declarations for test funcs */
>   #define DEFINE_TEST(name)				\
>   	extern void test_##name(void) __weak;		\
> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
> index 966011eb7ec8..3ad131de14c6 100644
> --- a/tools/testing/selftests/bpf/test_progs.h
> +++ b/tools/testing/selftests/bpf/test_progs.h
> @@ -430,6 +430,10 @@ int write_sysctl(const char *sysctl, const char *value);
>   int get_bpf_max_tramp_links_from(struct btf *btf);
>   int get_bpf_max_tramp_links(void);
>   
> +struct netns_obj;
> +struct netns_obj *netns_new(const char *name, bool open);
> +void netns_free(struct netns_obj *netns);
> +
>   #ifdef __x86_64__
>   #define SYS_NANOSLEEP_KPROBE_NAME "__x64_sys_nanosleep"
>   #elif defined(__s390x__)


