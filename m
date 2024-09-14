Return-Path: <bpf+bounces-39874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DFD978C0F
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 02:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6515286640
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 00:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E469528EB;
	Sat, 14 Sep 2024 00:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wI2qoVS3"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5D61361
	for <bpf@vger.kernel.org>; Sat, 14 Sep 2024 00:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726272693; cv=none; b=HmBdujMC6cMbX2XQL/KoU/Io4N0Q4+f5tQVWpbKUfpIr/kb7A4LMa3Rxr+15c7yCkzcxIWAU0dTDA9D55oCgk8bk/9OHNdWiQ8EqxxBoFFiCCG/IXdvedYgR5m5ooKWdSc5IsJnwhhN7vyKvo6Bphw9wJ2CpbzNcLcQASr2pxR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726272693; c=relaxed/simple;
	bh=k6AXiUShqFWnxWyumWyKNaJ9AtMfMG21fL87GVsnwjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MtHh8WwAum12c9EsNnCKCED6gzM+5xx+OGwLT4AOEu3zi8cUUEz0S4U7qIcLstkGQMAkKNkPSR0hNFW3Dk3KBMA4CeHRX25qLbDWsz1qUbjvVVGOgS5FjY67TJyj9Cgeg6T6oam3hntB4u6w6paxbqQEMJg3sSozmbyod3zwpfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wI2qoVS3; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <07c19c1a-a526-4307-be44-5abb312cc6d4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726272687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=alJRYqj31UINifc+9zDFA1uwYd1fHAfT9abqylFnCv0=;
	b=wI2qoVS3horHkaIWfNWXFpS4fT0pUSGPNSNprNYeuMy/M8wezSxElBzI8+aDikwS+cLPCi
	QAo7N7m7k1gEvJJjt+SnSL5dKTQqjkx6H+mZ+rBKQXi/hRm0Djbv4kg0nRqJxm2VcPM9qM
	RoiQyyifYZRJeZ/SjnSnbi8d9quBwNc=
Date: Fri, 13 Sep 2024 17:11:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next/net v6 2/3] selftests/bpf: Add getsockopt to
 inspect mptcp subflow
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240911-upstream-bpf-next-20240506-mptcp-subflow-test-v6-0-7872294c466b@kernel.org>
 <20240911-upstream-bpf-next-20240506-mptcp-subflow-test-v6-2-7872294c466b@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240911-upstream-bpf-next-20240506-mptcp-subflow-test-v6-2-7872294c466b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/11/24 8:16 AM, Matthieu Baerts (NGI0) wrote:
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> new file mode 100644
> index 000000000000..179b74c1205f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> +#ifndef __MPTCP_BPF_H__
> +#define __MPTCP_BPF_H__
> +
> +#include "bpf_experimental.h"
> +
> +/* list helpers from include/linux/list.h */
> +static inline int list_is_head(const struct list_head *list,
> +			       const struct list_head *head)
> +{
> +	return list == head;
> +}
> +
> +#define list_entry(ptr, type, member)					\
> +	container_of(ptr, type, member)
> +
> +#define list_first_entry(ptr, type, member)				\
> +	list_entry((ptr)->next, type, member)
> +
> +#define list_next_entry(pos, member)					\
> +	list_entry((pos)->member.next, typeof(*(pos)), member)
> +
> +#define list_entry_is_head(pos, head, member)				\
> +	list_is_head(&pos->member, (head))
> +
> +/* small difference: 'cond_break' has been added in the conditions */
> +#define list_for_each_entry(pos, head, member)				\
> +	for (pos = list_first_entry(head, typeof(*pos), member);	\
> +	     cond_break, !list_entry_is_head(pos, head, member);	\

It probably should use can_loop.
See commit ba39486d2c43 ("bpf: make list_for_each_entry portable")


