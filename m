Return-Path: <bpf+bounces-49993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C04B3A214E0
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 00:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5011670A6
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 23:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEDD1EE039;
	Tue, 28 Jan 2025 23:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uRSzQLKO"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223EA19E82A
	for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 23:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738105392; cv=none; b=kF9tk1x/JjXw3Z6W01E86vtNKUlScrFI85JOFl9YmURH7AmwaKqyHHlsk83z52oUD85glFKaQfr+RARFuizuMjvESlU4Pbx/ZZI14M1zfG2T4h5qHW5t9ma6K1xc+YVx+Q2L2WHxaz+QCcgf0Ub8hKpOiGVBsbkSoD7Yw/ID7L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738105392; c=relaxed/simple;
	bh=/EAxo+FiqTJQD3j+vVs/MHYnU1ZqIZPGB9C+tQcQfs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l9nNXNg/tXpNPsrG1n9r4CelaLr3iaOSO17ThwxTKkqB0E6qxECVWKB4+XsNzOu95G3v8yfXx56cSkfDYgqHxPxhZ3UhgxNw3Yi6FuhzRH8+LkPEgN/KHvyEsll6WH3jJagznnhOglbZBMwCMv4rPhbEtaab56Shw4u9RBTBJ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uRSzQLKO; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f0eb6d62-695b-461c-9a45-3926f590e413@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738105389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WnJRkvRrb5lrPsTYQXDZXAjjTMS0jVj7cVr6R2qq15k=;
	b=uRSzQLKOsqbFZGi3UU5T/sVGXbQgJu0fH2bOvTiesw4L50O9eNWX/6EuIBllutUkiO3h0w
	TDMra5ugWePCU65hB03Ed3sDmvoLzqDTzkFua44uiuNZ6dweKguIjJnaWf+oNUOTvwUPCx
	6qmb2SeoT1SftGAlYv3y6muC/Q6Ro24=
Date: Tue, 28 Jan 2025 15:03:01 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 12/14] selftests/bpf: test_xdp_veth: Add XDP
 broadcast redirection tests
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Alexis Lothore <alexis.lothore@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250128-redirect-multi-v3-0-c1ce69997c01@bootlin.com>
 <20250128-redirect-multi-v3-12-c1ce69997c01@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250128-redirect-multi-v3-12-c1ce69997c01@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/28/25 1:57 AM, Bastien Curutchet (eBPF Foundation) wrote:
> Set the tests to run serially to avoid conflicts with
> test_xdp_veth_redirect

I think this has been fixed in v3?

Others lgtm also. Thanks for working on this.

> +void test_xdp_veth_broadcast_redirect(void)
> +{
> +	if (test__start_subtest("0/BROADCAST"))
> +		xdp_veth_broadcast_redirect(0, BPF_F_BROADCAST);
> +
> +	if (test__start_subtest("0/(BROADCAST | EXCLUDE_INGRESS)"))
> +		xdp_veth_broadcast_redirect(0, BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS);
> +
> +	if (test__start_subtest("DRV_MODE/BROADCAST"))
> +		xdp_veth_broadcast_redirect(XDP_FLAGS_DRV_MODE, BPF_F_BROADCAST);
> +
> +	if (test__start_subtest("DRV_MODE/(BROADCAST | EXCLUDE_INGRESS)"))
> +		xdp_veth_broadcast_redirect(XDP_FLAGS_DRV_MODE,
> +					    BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS);
> +
> +	if (test__start_subtest("SKB_MODE/BROADCAST"))
> +		xdp_veth_broadcast_redirect(XDP_FLAGS_SKB_MODE, BPF_F_BROADCAST);
> +
> +	if (test__start_subtest("SKB_MODE/(BROADCAST | EXCLUDE_INGRESS)"))
> +		xdp_veth_broadcast_redirect(XDP_FLAGS_SKB_MODE,
> +					    BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS);
> +}

