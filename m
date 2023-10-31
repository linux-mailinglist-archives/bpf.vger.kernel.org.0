Return-Path: <bpf+bounces-13647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB8C7DC3C8
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 02:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16CD1C20B6F
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 01:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A48F7F3;
	Tue, 31 Oct 2023 01:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fz0Nghnn"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17FC36D
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 01:09:40 +0000 (UTC)
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B8AC1
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 18:09:38 -0700 (PDT)
Message-ID: <736a8485-c9c0-fd75-6e8b-3207df8dda6a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698714576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vY8xf/EMvJncYtt6qBiDIvTky7rhTF1/p/6C9eAN43Y=;
	b=Fz0Nghnnw6vPmd5fzOZlAVoppu3YHfaFOid+CGNM+Uny4ZCQMBynhc38lKLgHopX2Egjy/
	gBBB4sDI1kBwxGAyCoigDUIv7hJBFelxDpfs1K2YK8n8tVpAqEij14MnB67qizva5TqWvk
	xq7dbd8I9T2Zbvfpkgnag9FQeqv7S0w=
Date: Mon, 30 Oct 2023 18:09:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 03/10] bpf: add struct_ops_tab to btf.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20231030192810.382942-1-thinker.li@gmail.com>
 <20231030192810.382942-4-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231030192810.382942-4-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/30/23 12:28 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Maintain a registry of registered struct_ops types in the per-btf (module)
> struct_ops_tab. This registry allows for easy lookup of struct_ops types
> that are registered by a specific module.
> 
> Every struct_ops type should have an associated module BTF to provide type
> information since we are going to allow modules to define and register new
> struct_ops types. Once this change is made, the bpf_struct_ops subsystem
> knows where to look up type info with just a bpf_struct_ops.

I think this part needs better description. I found it hard to parse. In particular:

...
   the "bpf_struct_ops" subsystem
        knows where to look up type info with just
     a "bpf_struct_ops"
...

May be something like:

It is a preparation work for supporting kernel module struct_ops in a latter 
patch. Each struct_ops will be registered under its own kernel module btf and 
will be stored in the newly added btf->struct_ops_tab. The bpf verifier and bpf 
syscall (e.g. prog and map cmd) can find the struct_ops and its btf 
type/size/id... information from btf->struct_ops_tab.

> 
> The subsystem looks up struct_ops types from a given module BTF although it
> is always btf_vmlinux now. Once start using struct_ops_tab, btfs other than
> btf_vmlinux can be used as well.

I think this describes about the "struct btf *btf" argument change in this 
patch. This seems unrelated to the "add struct_ops_tab to btf" change. Can it be 
in its own preparation patch?

[ ... ]

> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index e35d6321a2f8..0bc21a39257d 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -186,6 +186,7 @@ static void bpf_struct_ops_init_one(struct bpf_struct_ops_desc *st_ops_desc,
>   			pr_warn("Error in init bpf_struct_ops %s\n",
>   				st_ops->name);
>   		} else {
> +			st_ops_desc->btf = btf;
>   			st_ops_desc->type_id = type_id;
>   			st_ops_desc->type = t;
>   			st_ops_desc->value_id = value_id;
> @@ -222,7 +223,7 @@ void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
>   extern struct btf *btf_vmlinux;
>   
>   static const struct bpf_struct_ops_desc *
> -bpf_struct_ops_find_value(u32 value_id)
> +bpf_struct_ops_find_value(struct btf *btf, u32 value_id)

The "!btf_vmlinux" check a few lines below should also be changed to "!btf". I 
think I had commented on a similar point in v5.

>   {
>   	unsigned int i;
>   
> @@ -237,7 +238,8 @@ bpf_struct_ops_find_value(u32 value_id)
>   	return NULL;
>   }
>   
> -const struct bpf_struct_ops_desc *bpf_struct_ops_find(u32 type_id)
> +const struct bpf_struct_ops_desc *
> +bpf_struct_ops_find(struct btf *btf, u32 type_id)

same here.

>   {
>   	unsigned int i;
>   

[ ... ]

> +static struct bpf_struct_ops_desc *
> +btf_add_struct_ops(struct btf *btf, struct bpf_struct_ops *st_ops)
> +{
> +	struct btf_struct_ops_tab *tab, *new_tab;
> +	int i;
> +
> +	if (!btf)
> +		return ERR_PTR(-ENOENT);
> +
> +	/* Assume this function is called for a module when the module is
> +	 * loading.
> +	 */
> +
> +	tab = btf->struct_ops_tab;
> +	if (!tab) {
> +		tab = kzalloc(offsetof(struct btf_struct_ops_tab, ops[4]),
> +			      GFP_KERNEL);
> +		if (!tab)
> +			return ERR_PTR(-ENOMEM);
> +		tab->capacity = 4;
> +		btf->struct_ops_tab = tab;
> +	}
> +
> +	for (i = 0; i < tab->cnt; i++)
> +		if (tab->ops[i].st_ops == st_ops)
> +			return ERR_PTR(-EEXIST);
> +
> +	if (tab->cnt == tab->capacity) {
> +		new_tab = krealloc(tab, sizeof(*tab) +
> +				   sizeof(struct bpf_struct_ops *) *
> +				   tab->capacity * 2, GFP_KERNEL);

nit. Use a similar offsetof() like a few lines above.

> +		if (!new_tab)
> +			return ERR_PTR(-ENOMEM);
> +		tab = new_tab;
> +		tab->capacity *= 2;
> +		btf->struct_ops_tab = tab;
> +	}
> +
> +	btf->struct_ops_tab->ops[btf->struct_ops_tab->cnt].st_ops = st_ops;

nit. s/btf->struct_ops_tab/tab/

> +
> +	return &btf->struct_ops_tab->ops[btf->struct_ops_tab->cnt++];
> +}


