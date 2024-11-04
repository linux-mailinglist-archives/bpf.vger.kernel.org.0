Return-Path: <bpf+bounces-43971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBE59BC0A7
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 23:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BC191F22A93
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 22:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5E31FDFB9;
	Mon,  4 Nov 2024 22:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bxxrK5b8"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F32D1FDF89
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 22:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730758422; cv=none; b=qoWoev+FpsiJ5aX4oBpSvTHNC7feOceRDhC+UDw5pxZVpxBtA/b+pGjIujwWN94a1pGOSQ0ifd+a9OO/iHITFR8tTCNvveJThuFhDeotQp7bvz4SvxzVonHiJrACHrEGLuHMeWnnQSu3vfd87Vd3NRuqfidkNYLQCjWzGZ5ziYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730758422; c=relaxed/simple;
	bh=tceBlETue3lL/TSdBT7AJUOGkv6bX9R/YdQQZlAwvhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sXBbZ2TqzgqyjAj9aHPvreEGtRo95GvObD4uiIdAvcINK/JtVIy9ZoQf9Aq/jQb8tOMHfg+O/rwQ6GJO4nZqj4ZYvWloM1PEAUiQIu4fsaVLDp1jTHF1rI7jO5nvCL/6XcEK8aEuY4fWtYb/9S0CoCV3TeTKCke5QEcikZAgOdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bxxrK5b8; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <85160853-cc20-40df-b090-62b4359bec37@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730758418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GCShT93ddGN+Y+xNVN9M7zP6TIePg8VUy8uvLGC3xt4=;
	b=bxxrK5b8f7mdHfGK94QArguecX+6PgP8HaSyAlXuqK+SI6bPFg3RuCIUeSiORq98awi8DP
	22Mxn5kJ46Fol5Jxu98Jjzb704HYZV5CVqqNDVO6WNQ+88X1gKvyyA680COyuBzSEv+ofB
	IUaouAtJcPc/wpAfGYHZoowJ4zWyXQY=
Date: Mon, 4 Nov 2024 14:13:30 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf: Add kernel symbol for struct_ops
 trampoline
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Kui-Feng Lee <thinker.li@gmail.com>
References: <20241101111948.1570547-1-xukuohai@huaweicloud.com>
 <CAADnVQKnJkJpWkuxC32UPc4cvTnT2+YEnm8TktrEnDNO7ZbCdA@mail.gmail.com>
 <5c16fb2f-efa2-4639-862d-99acbd231660@huaweicloud.com>
 <CAADnVQLvpwLp=t1oz3ic-EKnaio2DhOCanmuBQ+8nSf-jzBePw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAADnVQLvpwLp=t1oz3ic-EKnaio2DhOCanmuBQ+8nSf-jzBePw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/4/24 9:53 AM, Alexei Starovoitov wrote:

> As a separate clean up I would switch the freeing to call_rcu_tasks.
> Synchronous waiting is expensive.
> 
> Martin,
> 
> any suggestions?

There is a map->rcu now. May be add a "bool free_after_rcu_tasks_gp" to "struct 
bpf_map" and do the call_rcu_tasks() in bpf_map_put(). The 
bpf_struct_ops_map_alloc() can set the map->free_after_rcu_tasks_gp.

Take this chance to remove the "st_map->rcu" from "struct bpf_struct_ops_map" 
also. It is a left over after cleaning up the kvalue->refcnt in the
commit b671c2067a04 ("bpf: Retire the struct_ops map kvalue->refcnt.").

Xu, it will be great if you can follow up with this cleanup. Otherwise, I will 
put it under the top of my todo list. Let me know what you prefer.

