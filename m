Return-Path: <bpf+bounces-77794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DB2CF1FD3
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 06:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16B8C300F32E
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 05:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85232325705;
	Mon,  5 Jan 2026 05:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vm8yiR9z"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D958326951
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 05:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767590883; cv=none; b=irXH2ogfm2W+aDRSYiMF8sMEAUgQrctH3u+jzYKUyDbsTTMqKvRwa676BypsCaylhlCYiY1IiLW5/PGr+MVZtqWxUq1pxgEB0IlXbyabW4fum9W5hLaJCazJqNyCeU117ax7lBvL8BlH2nHkUwnLtCyRKn3BmIaJbDYbtIcOt0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767590883; c=relaxed/simple;
	bh=foWwT0mt+rj59iH1KVGIInZRkYBoqdVxBaoqrC3sp6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KeOhB85pzYIrpQQ/Dhv9jvZ1Sfg6XFkJVZKlmvSGoYu/qC6ANZDWklZ1/5lmB6ZzZrmCwSekvsGd6E5zhQs5MnOwxAUHtKRNaqVASVQJRK7UZsuDRYQP9qXq1jT8Pg0hm3SFIEE1uazXvFgP7sg8XVd6Y4Viroxk9fc3eCmxhCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vm8yiR9z; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <248eab0f-0071-40de-a9ba-cbd548ad28f7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767590866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAEotLk51p4D5KLtJz1rfZB7RPGPlJ5yytYlR3nYTq8=;
	b=Vm8yiR9zD3YlovNFDyoXZnnXL8/0xkaaPX3Jf0ASbwVJHes1l7GTuhmFJDIflyWUls03Gg
	hDF9RtdKNYe/ZDC6COrAFaBpQgFL11SaP3zcy/NZMiIxO9apPzveVLBOq7naRuXRvVYusP
	HdAzBtiEUP/Xtu5J7SpgT1pEWi1V4dY=
Date: Sun, 4 Jan 2026 21:27:29 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next] bpftool: Make skeleton C++ compatible with
 explicit casts
Content-Language: en-GB
To: WanLi Niu <kiraskyler@163.com>, Quentin Monnet <qmo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 WanLi Niu <niuwl1@chinatelecom.cn>, Menglong Dong <dongml2@chinatelecom.cn>
References: <20251231102929.3843-1-kiraskyler@163.com>
 <20260104021402.2968-1-kiraskyler@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260104021402.2968-1-kiraskyler@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/3/26 6:14 PM, WanLi Niu wrote:
> From: WanLi Niu <niuwl1@chinatelecom.cn>
>
> Fix C++ compilation errors in generated skeleton by adding explicit
> pointer casts and using integer subtraction for offset calculation.
>
> Use struct outer::inner syntax under __cplusplus to access nested skeleton map
> structs, ensuring C++ compilation compatibility while preserving C support
>
> error: invalid conversion from 'void*' to '<obj_name>*' [-fpermissive]
>        |         skel = skel_alloc(sizeof(*skel));
>        |                ~~~~~~~~~~^~~~~~~~~~~~~~~
>        |                          |
>        |                          void*
>
> error: arithmetic on pointers to void
>        |         skel->ctx.sz = (void *)&skel->links - (void *)skel;
>        |                        ~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~
>
> error: assigning to 'struct <obj_name>__<ident> *' from incompatible type 'void *'
>        |                 skel-><ident> = skel_prep_map_data((void *)data, 4096,
>        |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>        |                                                 sizeof(data) - 1);
>        |                                                 ~~~~~~~~~~~~~~~~~
>
> error: assigning to 'struct <obj_name>__<ident> *' from incompatible type 'void *'
>        |         skel-><ident> = skel_finalize_map_data(&skel->maps.<ident>.initial_value,
>        |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>        |                                         4096, PROT_READ | PROT_WRITE, skel->maps.<ident>.map_fd);
>        |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Signed-off-by: WanLi Niu <niuwl1@chinatelecom.cn>
> Co-developed-by: Menglong Dong <dongml2@chinatelecom.cn>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

LGTM. Could you add a minimum reproducer in the commit message?

Acked-by: Yonghong Song <yonghong.song@linux.dev>


