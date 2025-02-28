Return-Path: <bpf+bounces-52892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AA2A4A243
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 19:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897263B7EE1
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 18:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7718230BC1;
	Fri, 28 Feb 2025 18:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JiW3mquv"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898211F8734;
	Fri, 28 Feb 2025 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740768943; cv=none; b=igVFRe1KA5phCpeqKDcRMUYxlX02aMm+d59ycJPURdUc3MQl/F8YXuusbzxIYRweNtRVTspelEQblSVjNWCt/0ssXiiY/bsMBUcJU8DmyJoGQF7WfvXqwmAVGyI9LYtsD6mkMAzk+q3yf6PdaqkByGBmvx0QzKpLYSXGJ9RL1fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740768943; c=relaxed/simple;
	bh=/KcXav0rabKJcPCYp34mQZzZViXUMDBOctIouFNUP98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kCNurjdPcgCZCMQ2e7NEwLo99HN4L4cJbV8yJtSq1ZB5MsW+1ZyqKTHKxc2UrjatX7Rhev5lraFkyMuLmAKYATb708CsGR9ndsKJMaDNsUEsOa0JRcEuGahbNb/H/j6iUYYXOeqV1fX/oxP7ouf9ZysrRRf7ebZZ97UEyWZOkt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JiW3mquv; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <331d97f7-c1de-4b46-a1e5-75a3261d4e97@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740768929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1iKOUsrjeukuigNTKIIt0ORYtWT59cRVVyENYRJLiyo=;
	b=JiW3mquvsYYc9+1X3hlSZ6D3wCDFr3YthSmAfPn2WKNtyuXY5diXF9fTzP/3k7YagJDkV1
	AX0eb51cjtxIsG5kFnYBxVX8I0btbzILvOQ8EMHaKmq47f7ykhmHx8VslkRmkWxw+YP+21
	Ani+b4ufzj/fMQxszueUhOr2es1MUeo=
Date: Fri, 28 Feb 2025 10:55:19 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: filter: Avoid shadowing variable in
 bpf_convert_ctx_access()
Content-Language: en-GB
To: Breno Leitao <leitao@debian.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250228-fix_filter-v1-1-ce13eae66fe9@debian.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250228-fix_filter-v1-1-ce13eae66fe9@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2/28/25 10:43 AM, Breno Leitao wrote:
> Rename the local variable 'off' to 'offset' to avoid shadowing the existing
> 'off' variable that is declared as an `int` in the outer scope of
> bpf_convert_ctx_access().
>
> This fixes a compiler warning:
>
>   net/core/filter.c:9679:8: warning: declaration shadows a local variable [-Wshadow]
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Make sense to me.

Acked-by: Yonghong Song <yonghong.song@linux.dev>


