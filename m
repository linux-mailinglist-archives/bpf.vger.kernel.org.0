Return-Path: <bpf+bounces-14303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF2F7E2BEC
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 19:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579942817AB
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 18:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BD32D029;
	Mon,  6 Nov 2023 18:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kPF7DE0n"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23E628E2C
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 18:29:49 +0000 (UTC)
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C586094
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 10:29:48 -0800 (PST)
Message-ID: <f807c58c-526c-0647-fc1c-9b488d351b1d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699295386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h59f/+9iIB9tLtU9EcEdpIuLhw5gmM5oYL+jhpq0UM4=;
	b=kPF7DE0nQpK16mCczxInbwjbcmXOI9TCESNfd0EcDqIDHfDeu8QKqK6RJITGT3uYIRy+bU
	QUB+E8d6n66cHhHTFpTWJTW8DsDBduW1lhjbe+pPCBsvQaR+jVG8H+N7y7gBQXUpVv1ed2
	ICGYElNMCqLBewdoDh2oONM7b7G59VM=
Date: Mon, 6 Nov 2023 10:29:40 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/2] bpf: Let verifier consider {task,cgroup} is
 trusted in bpf_iter_reg
Content-Language: en-US
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, bpf@vger.kernel.org
References: <20231105133458.1315620-1-zhouchuyi@bytedance.com>
 <20231105133458.1315620-2-zhouchuyi@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231105133458.1315620-2-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/5/23 5:34 AM, Chuyi Zhou wrote:
> BTF_TYPE_SAFE_TRUSTED(struct bpf_iter__task) in verifier.c wanted to
> teach BPF verifier that bpf_iter__task -> task is a trusted ptr. But it
> doesn't work well.
> 
> The reason is, bpf_iter__task -> task would go through btf_ctx_access()
> which enforces the reg_type of 'task' is ctx_arg_info->reg_type, and in
> task_iter.c, we actually explicitly declare that the
> ctx_arg_info->reg_type is PTR_TO_BTF_ID_OR_NULL.
> 
> This patch sets ctx_arg_info->reg_type is PTR_TO_BTF_ID_OR_NULL |
> PTR_TRUSTED in task_reg_info.
> 
> Similarly, bpf_cgroup_reg_info -> cgroup is also PTR_TRUSTED since we are
> under the protection of cgroup_mutex and we would check cgroup_is_dead()
> in __cgroup_iter_seq_show().
> 

Make sense. I think the bpf_tcp_iter made similar change in tcp_seq_info also. 
What may be the Fixes tag? Is it fixing the recent kfunc of the css_task iter?


