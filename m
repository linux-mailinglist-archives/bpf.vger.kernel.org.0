Return-Path: <bpf+bounces-17205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C296780AAD2
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 18:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C059E1C20432
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 17:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D743C3A27E;
	Fri,  8 Dec 2023 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qHOH+oWq"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8021FE0
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 09:30:55 -0800 (PST)
Message-ID: <85a5312a-ba79-4e1d-b1be-434a7fe64cf0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702056653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W3LSIJ5MOo+V2yKmlGwqREu13pcbpdr4OK9OsDJ1Brs=;
	b=qHOH+oWqGIgZFnQbDG6bzwJKJGd5rW073ih8YZnjihSTvyCKzlcnejtfp2TZATqBGC8/bD
	uu9P6xxkZIuO0c/MkalUQzXxWxnhsf/dmix9ROJ78RGHzngWOIs9oO7HPsA44HNV20chbY
	GZQs34oxpWQkgoJLLDGy6OTjzZbgndU=
Date: Fri, 8 Dec 2023 09:30:49 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 0/1] use preserve_static_offset in bpf uapi
 headers
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, jose.marchesi@oracle.com
References: <20231208000531.19179-1-eddyz87@gmail.com>
 <012efc61-e067-4c21-8cab-47dec9bbaf0c@linux.dev>
 <0275c6985bcb299890da7ea7fb96642802cdcdbe.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <0275c6985bcb299890da7ea7fb96642802cdcdbe.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/8/23 6:34 AM, Eduard Zingerman wrote:
> On Thu, 2023-12-07 at 18:28 -0800, Yonghong Song wrote:
> [...]
>> All context types are defined in include/linux/bpf_types.h.
>> The context type bpf_nf_ctx is missing.
> convert_ctx_access() is not applied for bpf_nf_ctx. Searching through
> kernel code shows that BPF programs access this structure directly
> (net/netfilter/nf_bpf_link.c):
>
>      static unsigned int nf_hook_run_bpf(void *bpf_prog, struct sk_buff *skb,
>                          const struct nf_hook_state *s)
>      {
>          const struct bpf_prog *prog = bpf_prog;
>          struct bpf_nf_ctx ctx = {
>              .state = s,
>              .skb = skb,
>          };
>
>          return bpf_prog_run(prog, &ctx);
>      }
>
> I added __bpf_ctx only for types that are subject to convert_ctx_access()
> transformation. On the other hand, applying it to each context type
> should not hurt either. Which way would you prefer?
>
> [...]
>
>>> How to add the same definitions in vmlinux.h is an open question,
>>> and most likely requires bpftool modification:
>>> - Hard code generation of __bpf_ctx based on type names?
>>> - Mark context types with some special
>>>     __attribute__((btf_decl_tag("preserve_static_offset")))
>>>     and convert it to __attribute__((preserve_static_offset))?
>> The number of context types is limited, I would just go through
>> the first approach with hard coding the list of ctx types and
>> mark them with preserve_static_offset attribute in vmlinux.h.
> Tbh, I'm with Alan here, generic approach seems a tad nicer.
> Lets collect some more votes :)

I just want to propose to have less work :-) since we are only dealing 
with a few structs in bpf domain. Note that eventually generated 
vmlinux.h will be the same whether we use 'hard code' approach or the 
decl_tag approach. The difference is just how to do it: - dwarf/btf with 
decl tag -> bpftool vmlinux.h gen, or - dwarf/btf without decl tag + 
hardcoded bpf ctx info -> bpftool vmlinux.h gen If we intends to cover 
all uapi data structures (to prevent unnecessary CORE relocation, esp. 
for troublesome bitfield operations), hardcoded approach won't work and 
we may have to go to decl tag approach.


