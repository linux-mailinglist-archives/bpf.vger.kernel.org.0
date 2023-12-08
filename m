Return-Path: <bpf+bounces-17201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F2680AA8A
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 18:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA0428199C
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 17:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88BD38FBE;
	Fri,  8 Dec 2023 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WXNmNox/"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [IPv6:2001:41d0:1004:224b::bb])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7AF213F
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 09:19:16 -0800 (PST)
Message-ID: <9e4e70d9-aeda-4100-a879-1b7413db567d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702055947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Nk40iqcg9q9a5ygXVdmw68sO1dMfcLiviOJRYvD9RU=;
	b=WXNmNox/pKzYbTno78gwg8kESC9CdQNZpQrJabV4HidPHapCCdUF52iANWkN+CSf47Vr4S
	TmlcVyNn47FauFBvfE602ixPcmbAu5QMyeHmjhzIkAaBMHQOX+EdalqXXlmTeYweQocDmI
	gQnM0lItmWBYNbi35R+jWWm3BmDqOEg=
Date: Fri, 8 Dec 2023 09:19:02 -0800
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

The error message should happen here:

check_mem_access
  ...
  } else if (reg->type == PTR_TO_CTX) {
   check_ptr_off_reg
    __check_ptr_off_reg
         if (!fixed_off_ok && reg->off) {
                 verbose(env, "dereference of modified %s ptr R%d off=%d disallowed\n",
                         reg_type_str(env, reg->type), regno, reg->off);
                 return -EACCES;
         }
   ...

So the verification error message will be emitted earlier, before convert_ctx_access.
Could you double check?

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

