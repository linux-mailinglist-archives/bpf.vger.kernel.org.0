Return-Path: <bpf+bounces-5792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38BB7608D3
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 06:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB9D2816DB
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 04:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DA27486;
	Tue, 25 Jul 2023 04:44:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E69186F;
	Tue, 25 Jul 2023 04:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C42BC433C7;
	Tue, 25 Jul 2023 04:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690260254;
	bh=+ACqNdes4jmCi8Obnif4i7hbEQJMXGCeCk+pRu6qhsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hOgwA36ZJTCd8ep9foyK0Ml6RVutpQV8FWOfYn7vpM+S6O0aWLUKjFZoTDm3u8Y+3
	 jWWWu6hOO00usmnVc/wGuEbZzZPEU+i/cSm9N+l1uUXJuZxV4w3P2VDzq1Kmf8tHyo
	 yXf8qsQwLVFfEN8rE39M9L8iCe/FQkzOUAtzuUNwe/cDH4lUNlPCbzjEiOumg+WgNu
	 jVDPn8W+a3poZOXFm/5eQgf+iAD1JmZyuMbnhIGf+OqKlbb+LANjw6lxOVUWFU/yRB
	 nBnE73BheMbhgboucKa9fjeYxDfvkbwhVJeo23Pmj1EzCgbxVinfshWVOw8bGU0Bf3
	 8xrmZxrTB2KTA==
Date: Tue, 25 Jul 2023 07:44:09 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Lin Ma <linma@zju.edu.cn>, kuba@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	ast@kernel.org, martin.lau@kernel.org, yhs@fb.com,
	void@manifault.com, andrii@kernel.org, houtao1@huawei.com,
	inwardvessel@gmail.com, kuniyu@amazon.com, songliubraving@fb.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2] bpf: Add length check for
 SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing
Message-ID: <20230725044409.GF11388@unreal>
References: <20230725023330.422856-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725023330.422856-1-linma@zju.edu.cn>

On Tue, Jul 25, 2023 at 10:33:30AM +0800, Lin Ma wrote:
> The nla_for_each_nested parsing in function bpf_sk_storage_diag_alloc
> does not check the length of the nested attribute. This can lead to an
> out-of-attribute read and allow a malformed nlattr (e.g., length 0) to
> be viewed as a 4 byte integer.
> 
> This patch adds an additional check when the nlattr is getting counted.
> This makes sure the latter nla_get_u32 can access the attributes with
> the correct length.
> 
> Fixes: 1ed4d92458a9 ("bpf: INET_DIAG support in bpf_sk_storage")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> ---
> V1 -> V2: moves the check to the counting loop as Jakub suggested,
>           alters the commit message accordingly.
> 
>  net/core/bpf_sk_storage.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index d4172534dfa8..cca7594be92e 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -496,8 +496,11 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla_stgs)
>  		return ERR_PTR(-EPERM);
>  
>  	nla_for_each_nested(nla, nla_stgs, rem) {
> -		if (nla_type(nla) == SK_DIAG_BPF_STORAGE_REQ_MAP_FD)
> +		if (nla_type(nla) == SK_DIAG_BPF_STORAGE_REQ_MAP_FD) {
> +			if (nla_len(nla) != sizeof(u32))

Jakub, it seems like Lin adds this check to all nla_for_each_nested() loops.
IMHO, the better change will be to change nla_for_each_nested() skip empty/not valid NLAs.

Thanks

> +				return ERR_PTR(-EINVAL);
>  			nr_maps++;
> +		}
>  	}
>  
>  	diag = kzalloc(struct_size(diag, maps, nr_maps), GFP_KERNEL);
> -- 
> 2.17.1
> 
> 

