Return-Path: <bpf+bounces-45091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3142D9D1225
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 14:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E600B28193E
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 13:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1E11A0AE0;
	Mon, 18 Nov 2024 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xqBj3tYo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i6Ttu225"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02691A9B22
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 13:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731937184; cv=none; b=myJAcqi6FatxyTYDLn+DNrUdPAQpijHytl2q9ljqvM9l5NcSi86sSBMi1LRl1VMS144+9kSbN2o9sKWsNEBO3a/fLMDh1zOr39cTHrt6tVcKRW806/x8T+Gb7MKB6JLpJVhm5L2lVhi3uh0RH28za+oT/1jlSP6v+1Fkz5OemBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731937184; c=relaxed/simple;
	bh=mO8CWt557HTNzUd1RC6lG/3TLwTfSrdvOFp17qz4dOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwCaGWxk3Oj+ALqH+QZSw+ZzY0uK8D6KmYpQ5oz0IqnLqy6LtUDL6DPe185DMdShU9exoPMAY6QhxwPUrZouzvVergE/yy2CW0jahgQQsUqGp0GFx47Sb/snouSRnUoSO12jQz5kYXnKyBTxGsYYl4246wIvpGbWoW2Co266uCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xqBj3tYo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i6Ttu225; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Nov 2024 14:39:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731937179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=utlXgDsKPK+R1Kc8WsvdWru5Tu7HJ/AsbbFn+bgDdNo=;
	b=xqBj3tYonzb4aAVjNwRz7wBeeUmPLbllIRHoWiwlw9dHHmn7Oh9xKMoXwy7YkWIBKcXxQr
	fLfLEIkIFdhJdA/V+Qu2dkU+CmolaBrSjgmTLlnRb2CEf7TvYxhUfhhi4cmfoFXCqU2aZF
	JFep5ovrnRm9QEIK5hfd89++RP/65e4aHWfO8iIv59elQbJki3tr7vaLEeeU9SP16jdXBN
	1nM8Ls5HLdwjmxZGlNGO+a/7BWcYTmskVfxvocemZUsDoPLmysey0weNRkvsFQVbNvXOO8
	t3unFcF1/r/7Z9oIYgNQvZ6cj7xedLuKtFkEN41VrR9Dvz7z7w1b0xquxAP6Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731937179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=utlXgDsKPK+R1Kc8WsvdWru5Tu7HJ/AsbbFn+bgDdNo=;
	b=i6Ttu225GMIM1rXoiP9XAZTMccAUpMeCHkNFoATgqCHT/447M/pGnKOZr7XdIg+cDPbjMI
	5nnuzFkjZl2AqaDg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, houtao1@huawei.com, xukuohai@huawei.com
Subject: Re: [PATCH bpf-next 03/10] bpf: Handle BPF_EXIST and BPF_NOEXIST for
 LPM trie
Message-ID: <20241118143028-304ae6cf-d766-4604-8663-49887a02e06e@linutronix.de>
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
 <20241118010808.2243555-4-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118010808.2243555-4-houtao@huaweicloud.com>

On Mon, Nov 18, 2024 at 09:08:01AM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> There is exact match during the update of LPM trie, therefore, add the
> missed handling for BPF_EXIST and BPF_NOEXIST flags.

"There is" can be interpreted as "this can be true" and "this will
always be true".

Maybe:

Add the currently missing handling for the BPF_EXIST and BPF_NOEXIST
flags, as these can be specified by users.

> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/lpm_trie.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> index c6f036e3044b..4300bd51ec6e 100644
> --- a/kernel/bpf/lpm_trie.c
> +++ b/kernel/bpf/lpm_trie.c
> @@ -375,6 +375,10 @@ static long trie_update_elem(struct bpf_map *map,
>  	 * simply assign the @new_node to that slot and be done.
>  	 */
>  	if (!node) {
> +		if (flags == BPF_EXIST) {
> +			ret = -ENOENT;
> +			goto out;
> +		}
>  		rcu_assign_pointer(*slot, new_node);
>  		goto out;
>  	}
> @@ -383,18 +387,31 @@ static long trie_update_elem(struct bpf_map *map,
>  	 * which already has the correct data array set.
>  	 */
>  	if (node->prefixlen == matchlen) {
> +		if (!(node->flags & LPM_TREE_NODE_FLAG_IM)) {
> +			if (flags == BPF_NOEXIST) {
> +				ret = -EEXIST;
> +				goto out;
> +			}
> +			trie->n_entries--;
> +		} else if (flags == BPF_EXIST) {
> +			ret = -ENOENT;
> +			goto out;
> +		}
> +
>  		new_node->child[0] = node->child[0];
>  		new_node->child[1] = node->child[1];
>  
> -		if (!(node->flags & LPM_TREE_NODE_FLAG_IM))
> -			trie->n_entries--;
> -
>  		rcu_assign_pointer(*slot, new_node);
>  		free_node = node;
>  
>  		goto out;
>  	}
>  
> +	if (flags == BPF_EXIST) {
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +
>  	/* If the new node matches the prefix completely, it must be inserted
>  	 * as an ancestor. Simply insert it between @node and *@slot.
>  	 */
> -- 
> 2.29.2
> 

