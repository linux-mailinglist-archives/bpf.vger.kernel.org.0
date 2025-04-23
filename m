Return-Path: <bpf+bounces-56545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74620A99B8B
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 00:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F7307B0AC7
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 22:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F30521FF2C;
	Wed, 23 Apr 2025 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dhKTNHhj"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480031F418D
	for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 22:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745447409; cv=none; b=M8hG/n3tCtZTSjXf/Hkqge56alq8cDQna7YFyQStwQxlGPVKzwrtmdbzNs+T+guspdckhrSt4WJoCwmkp/4ejWTWJX3O8XAND5OR++tQJlF60Od5cCQz8zAmUa16vgYAILRFiORi62cbXjhrMx/ss7/uck2lww+9BS+f4tZxdoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745447409; c=relaxed/simple;
	bh=PSn2Ym+IrgVLRTNnl+RAsPv/cJDcB9cRnBpKHyLT9ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g3yf7+DWWsC9EnczKTQyfgc1ISSTjpmnwGhmy2wjtqfYq0GcOPE34mJ3nPXPmbqBafUQs6QzJgl0z9ZdzNuiaw4ySa8BBLU8sJJzcM3KGKUYyrrFhNQjC7krCBlYHSqSlnBLNu6XavO0yCf38yrENITOLo3KDhQTnVPLepQwMCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dhKTNHhj; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c865305d-b10b-4f67-b466-cc05a57dccfe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745447402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BppaMnUaT5ao5D/mw/RQZpbCdeA3kIveXo6RuEuwJPY=;
	b=dhKTNHhjOqFRp5rH5Wtxb5SOrqw6w5RohSfdq0CVRYUo8/BjCDIySx0agC7qtXvHhvIMPo
	dSpS91ni0GUM7N7OSgq1DKcwI+ttqFLwIHBMsoiRq5YDykdheghqT8D5ADA/36k2DoHrIJ
	mQq3i8JWf7/lTjNBrS+O6fK3KHwG6L0=
Date: Wed, 23 Apr 2025 15:29:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf: Allow XDP dev-bound programs to perform
 XDP_REDIRECT into maps
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250423-xdp-prog-bound-fix-v2-1-51742a5dfbce@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250423-xdp-prog-bound-fix-v2-1-51742a5dfbce@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/23/25 10:44 AM, Lorenzo Bianconi wrote:
> In the current implementation if the program is dev-bound to a specific
> device, it will not be possible to perform XDP_REDIRECT into a DEVMAP
> or CPUMAP even if the program is running in the driver NAPI context and
> it is not attached to any map entry. This seems in contrast with the
> explanation available in bpf_prog_map_compatible routine.
> Fix the issue introducing __bpf_prog_map_compatible utility routine in
> order to avoid bpf_prog_is_dev_bound() check running bpf_check_tail_call()
> at program load time (bpf_prog_select_runtime()).
> Continue forbidding to attach a dev-bound program to XDP maps
> (BPF_MAP_TYPE_PROG_ARRAY, BPF_MAP_TYPE_DEVMAP and BPF_MAP_TYPE_CPUMAP).
> 
> Fixes: 3d76a4d3d4e59 ("bpf: XDP metadata RX kfuncs")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v2:
> - Introduce __bpf_prog_map_compatible() utility routine in order to skip
>    bpf_prog_is_dev_bound check in bpf_check_tail_call()
> - Extend xdp_metadata selftest
> - Link to v1: https://lore.kernel.org/r/20250422-xdp-prog-bound-fix-v1-1-0b581fa186fe@kernel.org
> ---
>   kernel/bpf/core.c                                  | 27 +++++++++++++---------
>   .../selftests/bpf/prog_tests/xdp_metadata.c        | 22 +++++++++++++++++-
>   tools/testing/selftests/bpf/progs/xdp_metadata.c   | 13 +++++++++++

The change lgtm. Please separate the selftest changes to patch 2. Thanks.

pw-bot: cr


