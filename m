Return-Path: <bpf+bounces-68682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF08EB8140F
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 19:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90F777A612E
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 17:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217112FFF92;
	Wed, 17 Sep 2025 17:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WbGs5oyC"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE22C2FFDE0
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758131714; cv=none; b=nyOV19ZRGPi3Zjg7SdeYLzl3IYVEKRIvbFWtqpeaiEimpcycYpteMlG34rAogID8lnNPsdAqKbLv50/k6JD1/a3Xiu6Dia67lEH6F0KNX1Z6oKCEegrg6Lf0Y0JPlqs0ZK4PalTV0KLR9BtyQUt++GNUAcfb6Th65PLjiWz9e+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758131714; c=relaxed/simple;
	bh=ofFEnoomr9zWU+tWjXkp+bAT4Dziq/sGt4TDVyE8xWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HPWNPtmLWbjMXYR7Rwe4EQlL3iWF3UtajJ3eIU5hV4m44u/tDNKat8/aKrIW34TuC4TmdwMUHNmcUK4J6IoSdcmUZ2ZyCmH3zdYCs/8WQiud+K6QkIF1Xkc0u8dqSYOjo1kwnbFgPL85ZWMCbkofif0d6osTCbzazjgTuaY3O+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WbGs5oyC; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <28df67a9-528d-41e9-8441-722237b9add9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758131700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=59R9HA7jlm2dD2+dCG2KHNnU9UurkcLnLEbQfzZDzBU=;
	b=WbGs5oyC0EOgmSoY0o0b9VbHmMLQ607VpU28tO4E7PfFIEqK75aAaozK1XGjzGVu4W+5Kw
	bbhp/oSw+HyEDp5G4Q2bsMS5GCXJ8tPIj5ViNXoJSS0/8qCOamYtZzg9q+guZb8W9BvQ03
	jWToEGRc7SBWIHXYEoKhRZhPes4UKL4=
Date: Wed, 17 Sep 2025 10:54:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 5/6] selftests/bpf: Test bpf_xdp_pull_data
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 paul.chaignon@gmail.com, kuba@kernel.org, stfomichev@gmail.com,
 martin.lau@kernel.org, mohsin.bashr@gmail.com, noren@nvidia.com,
 dtatulea@nvidia.com, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, maciej.fijalkowski@intel.com, kernel-team@meta.com
References: <20250915224801.2961360-1-ameryhung@gmail.com>
 <20250915224801.2961360-6-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250915224801.2961360-6-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/15/25 3:48 PM, Amery Hung wrote:
> +/* Find sizes of struct skb_shared_info and struct xdp_frame so that
> + * we can calculate the maximum pull lengths for test cases
> + */
> +int find_xdp_sizes(struct test_xdp_pull_data *skel, int frame_sz)

static

> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	struct xdp_md ctx = {};
> +	int prog_fd, err;
> +	__u8 *buf;
> +
> +	buf = calloc(frame_sz, sizeof(__u8));

buf is leaked.

> +	if (!ASSERT_OK_PTR(buf, "calloc buf"))
> +		return -ENOMEM;
> +
> +	topts.data_in = buf;
> +	topts.data_out = buf;
> +	topts.data_size_in = frame_sz;
> +	topts.data_size_out = frame_sz;
> +	/* Pass a data_end larger than the linear space available to make sure
> +	 * bpf_prog_test_run_xdp() will fill the linear data area so that
> +	 * xdp_find_data_hard_end can infer the size of struct skb_shared_info
> +	 */
> +	ctx.data_end = frame_sz;
> +	topts.ctx_in = &ctx;
> +	topts.ctx_out = &ctx;
> +	topts.ctx_size_in = sizeof(ctx);
> +	topts.ctx_size_out = sizeof(ctx);
> +
> +	prog_fd = bpf_program__fd(skel->progs.xdp_find_sizes);
> +	err = bpf_prog_test_run_opts(prog_fd, &topts);
> +	ASSERT_OK(err, "bpf_prog_test_run_opts");
> +
> +	return err;
> +}
> +
> +/* xdp_pull_data_prog will directly read a marker 0xbb stored at buf[1024]
> + * so caller expecting XDP_PASS should always pass pull_len no less than 1024
> + */
> +void run_test(struct test_xdp_pull_data *skel, int retval,

static



