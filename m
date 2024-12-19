Return-Path: <bpf+bounces-47374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC079F8832
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 23:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E7716BE46
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 22:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF891DC9B2;
	Thu, 19 Dec 2024 22:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pTHkA93C"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6CC155743
	for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 22:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734649171; cv=none; b=ZV3E4uTTB4HSfwCsmB9/Z4Ax4SYpxDzkU48LfrRjQ1mXvgqiAlLYRpA0b1OWtJi8WnTCThEPNnSjs+wE8VC0QvOS99jj2Yj13ZDNPlAQXES3CZHfywox6ZYbR+RcZaw/88U6crLD4uoxEPqYCAEv6yYr+ezXk/isrTrWUfbQHwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734649171; c=relaxed/simple;
	bh=hlg8xwkylNI5eAv8KQzJt8kXxJW9Zb549XA7kLLl+i0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pdy0jlYorYt4rXJq1Gl+hpuu9Z33uafXDAIi4tMnrl6DWLHcLK/Y8N4H12GlvsE0EwRVYM23gYP2JzHtJoXT1deJ5eUZDzXmPn1qpXfRT4lRvBCVUIdr5GlyMlKjjZfgAfq3rsQb4cAkXVcxfSbTG6mOu4ZIo+tomog87rLxCT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pTHkA93C; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e3bf6bf6-5e81-4b6b-a9cd-40476cff67df@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734649164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IhXQOLtk7dKTmN52PYjr4l//xRRdGTGNVljbAp+LMuQ=;
	b=pTHkA93CLNr7gPLJS8+OkIAh4fP5+3TQ0a8bkD3WTAtQci6/BqQkCHjE69xFVEtEcRRqhD
	57YQiXJGXm9z29MWyLwektE+NnbKNsndiBzCOImSMyQSekGIdwQzgLm9rZPioo9IP/AiS2
	oikpjouDIbPjUilemOqugGqetV4nfPI=
Date: Thu, 19 Dec 2024 14:59:15 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 5/5] bpf/selftests: add selftest for
 bpf_smc_ops
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, pabeni@redhat.com,
 song@kernel.org, sdf@google.com, haoluo@google.com, yhs@fb.com,
 edumazet@google.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 jolsa@kernel.org, guwen@linux.alibaba.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org
References: <20241218024422.23423-1-alibuda@linux.alibaba.com>
 <20241218024422.23423-6-alibuda@linux.alibaba.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241218024422.23423-6-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/17/24 6:44 PM, D. Wythe wrote:
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_tracing_net.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct smc_sock {

I suspect this should be "smc_sock___local". Otherwise, it can't compile if the 
same type is found in vmlinux.h.

I only looked at the high level of prog_tests/test_bpf_smc.c. A few comments,

Try to reuse the helpers in network_helpers.c and test_progs.c, e.g. netns 
creation helpers, start_server, ...etc. There are many examples in 
selftests/bpf/prog_tests using them.

I see 1s timeout everywhere. BPF CI could be slow some time. Please consider how 
reliable the multi-thread test is. If the test is too flaky, it will be put in 
the selftests/bpf/DENYLIST.

> +	struct sock sk;
> +	struct smc_sock *listen_smc;
> +	bool use_fallback;
> +} __attribute__((preserve_access_index));
> +


