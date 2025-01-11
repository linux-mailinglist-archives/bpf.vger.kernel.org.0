Return-Path: <bpf+bounces-48615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABCBA09F9D
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 01:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE664188F23B
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 00:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E474E12E7E;
	Sat, 11 Jan 2025 00:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GtV6AaI0"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2C9BE46
	for <bpf@vger.kernel.org>; Sat, 11 Jan 2025 00:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736556321; cv=none; b=rlklKMhgwpPODVUm+ahSsyazTyy2QufqJAS/l8YKc8mTZvKf26bJnxjK2dMw1dN1KTRwbghBIX/sVJEc7s+mk7ezLniU/V7o0nHwi0x7r414RMWnNwee2Si+Exa0zLTQyYbnRZPNeALtw/Wv1DY4gpgmA7r1hSugg2B7Kbauhl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736556321; c=relaxed/simple;
	bh=2ZPNOo/CjUEM4HIQ9PpOP5qwGakBy8OHBdk40Oknmh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAJoDX2zUf+2shdvtfWNmEwhzRwCCQgzzsTF9bKiwrFw2JAiadH7Xx4g/txFc4LKR15C/67f651hxpUR93QtmP9OzT8/c1E234x5AYajB5wrMfQldN7lmhfe3E8/oP2pnl9jvTvpeR4bget/igDuNzaPxAyd9THZhqE+eSzgNLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GtV6AaI0; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c11d669a-ebe8-4afe-9fc4-b8bc6cdf10b4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736556299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TQkHQJIFEQ5Y/qZGoa0YTq4nC0p5J3GzJb8Pg4WHHIk=;
	b=GtV6AaI0MUsEA9Stjjcv2zVsBev12JihwudHq5qh8nYG/bpKJrw53VEzYMJopdfCSymvNS
	IOD5RXM7A2dAJIjDhC+PzXfhz6Hmkt+Zj3IPBx2q8CTi7blnHgxPW+b0XhyNIRjW9qV+7b
	FDRJ2U+KlxaIdup/v3RhYTf2zprF6dA=
Date: Fri, 10 Jan 2025 16:44:51 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: Fix bpf_sk_select_reuseport() memory leak
To: Michal Luczaj <mhal@rbox.co>, Jakub Kicinski <kuba@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250110-reuseport-memleak-v1-1-fa1ddab0adfe@rbox.co>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250110-reuseport-memleak-v1-1-fa1ddab0adfe@rbox.co>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/10/25 5:21 AM, Michal Luczaj wrote:
> As pointed out in the original comment, lookup in sockmap can return a TCP
> ESTABLISHED socket. Such TCP socket may have had SO_ATTACH_REUSEPORT_EBPF
> set before it was ESTABLISHED. In other words, a non-NULL sk_reuseport_cb
> does not imply a non-refcounted socket.
> 
> Drop sk's reference in both error paths.

Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>

Jakub, can you directly take this to the net tree? Thanks!

