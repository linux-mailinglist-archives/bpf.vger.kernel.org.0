Return-Path: <bpf+bounces-41875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4D099D504
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 18:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA348B26450
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 16:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141521BBBC6;
	Mon, 14 Oct 2024 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f74EEPZg"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6451B4F2A
	for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728924820; cv=none; b=eRMmF3P5B/oJohGs2fDzlmBmDX6jO67tNRV80ztPPWH2HBLdT/JngjLfJMYENIaYOPKMxW6xZU3rEeC0LalYiRTdatuS9sNTw69njI/1wCKEXMW5RA0/JrG325ytJ+2JdwGwWKR3kBict7t/sqx9r7waMCR3nxK83U4vwrjyZpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728924820; c=relaxed/simple;
	bh=4SHm+utpXRET2yjmO/8mS3DU9RALdHvXcAAgFMcXx3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQ3KXofi1p9lfq98UmbllMxapQ/hld5yq7nYcT9o6i8xqlskrRij3XkahmbA8XrS2nh4txtCGuV09yo1Rkna4vN10060DiWABQIJecBhjFdaEU2iz6fKq3ay+gP0qCfAdeq5w2Uodu2RjDXECu84NMKf8fT1VH2/qONWW0U9Vps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f74EEPZg; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1a82ab3c-7d40-4f8f-82f2-c8f39ddfd8b5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728924815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LSi0yL69EZ5TMhzii1BGYxNrDeqzgg4uR8V5HaPOfmM=;
	b=f74EEPZgHB99I+d7QQOi4hefOC6BPTNS0nZ27EVDO4He7YiHxj5e7GOlnnHBhBCP6qe38p
	hoqGn+shxUT0ZosUT9edLmn6pqwJoCRRX4yU3vYHKmixjHXLek6vDmZXs7hmfW/sQN4JYt
	Mk0oE1uKb09057zkpFUvE29LLMZN6Oo=
Date: Mon, 14 Oct 2024 09:53:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] bpf: Fix truncation bug in coerce_reg_to_size_sx()
Content-Language: en-GB
To: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shung-Hsi Yu <shung-hsi.yu@suse.com>, Zac Ecob <zacecob@protonmail.com>
References: <20241014121155.92887-1-dimitar.kanaliev@siteground.com>
 <20241014121155.92887-2-dimitar.kanaliev@siteground.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241014121155.92887-2-dimitar.kanaliev@siteground.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/14/24 5:11 AM, Dimitar Kanaliev wrote:
> coerce_reg_to_size_sx() updates the register state after a sign-extension
> operation. However, there's a bug in the assignment order of the unsigned
> min/max values, leading to incorrect truncation:
>
>    0: (85) call bpf_get_prandom_u32#7    ; R0_w=scalar()
>    1: (57) r0 &= 1                       ; R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
>    2: (07) r0 += 254                     ; R0_w=scalar(smin=umin=smin32=umin32=254,smax=umax=smax32=umax32=255,var_off=(0xfe; 0x1))
>    3: (bf) r0 = (s8)r0                   ; R0_w=scalar(smin=smin32=-2,smax=smax32=-1,umin=umin32=0xfffffffe,umax=0xffffffff,var_off=(0xfffffffffffffffe; 0x1))
>
> In the current implementation, the unsigned 32-bit min/max values
> (u32_min_value and u32_max_value) are assigned directly from the 64-bit
> signed min/max values (s64_min and s64_max):
>
>    reg->umin_value = reg->u32_min_value = s64_min;
>    reg->umax_value = reg->u32_max_value = s64_max;
>
> Due to the chain assigmnent, this is equivalent to:
>
>    reg->u32_min_value = s64_min;  // Unintended truncation
>    reg->umin_value = reg->u32_min_value;
>    reg->u32_max_value = s64_max;  // Unintended truncation
>    reg->umax_value = reg->u32_max_value;
>
> Fixes: 1f9a1ea821ff ("bpf: Support new sign-extension load insns")
> Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Reported-by: Zac Ecob <zacecob@protonmail.com>
> Signed-off-by: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>

Thanks for the fix!

Acked-by: Yonghong Song <yonghong.song@linux.dev>


