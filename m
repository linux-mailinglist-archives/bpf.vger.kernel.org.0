Return-Path: <bpf+bounces-78221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE3CD02956
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 13:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B1723014EA9
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 12:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67A2425CC8;
	Thu,  8 Jan 2026 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUUQwlCw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8620834AAFC;
	Thu,  8 Jan 2026 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873188; cv=none; b=MFRfFHGjFWNrMdNway9CWwPB5b7cwqSiHnXag/81CGcAOj2omhyb5VBKZ0uupB2uGIYBgINbyQ4ldJlBssGKouN0WFldruMvEVpyDwIa8SaBWWnou+1lYTZSVAh/slsb89gQFdHFP7bh3YZsAFhiZuwaj8+7z7vuEna/LdVXdbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873188; c=relaxed/simple;
	bh=jFzmE241B1udsKtyhgLi92geTvL7BHI7YHVdATHOzHI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ucEVqn+YUuUC3Yf59XxlcNsozCWjJk0LoyoZyphR6B9PW+OUTc1MEieOGXPZxu3b4SQhZVUIxtR5E0gec7vPw2YZOzRUnBM4qxjwuGh8E2svv1lV9zG7ogkKs6Bvp7uYf+9XH7WdEXh892dW2ZNYlrUf4zBepoDg/+iJOKxyoTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUUQwlCw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CF2C116C6;
	Thu,  8 Jan 2026 11:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767873186;
	bh=jFzmE241B1udsKtyhgLi92geTvL7BHI7YHVdATHOzHI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=FUUQwlCw1vgHxJ+2dtjwVijtZR45C34OS79uiNJSOejWM4vlvl/shHEqD+5urdNMr
	 RzL40KWw4SuXAqyPBv8IT3CT1XPN6m6evWzlPTNs/kFGfv6lY0Y3xnPsahfAcMm6TK
	 ItzHoJIgyEnlxRDcFvtMAz+eG5+RLpjQLp4tDIlKnN2GVmPmPQkD7UpA64dlYTtMNA
	 dsWVRVz0IK6xdQ0mvWJ+XDGd+4xX9bQxhpHO74HNglIX76kdGEXPfP2n5gCyYq4HY7
	 OBf7Pp+Vr7TajC3xGtzHjk057p4Fz83AG1LeO1x/oOmZKGYu94XoALzW9O9h2yJkZo
	 lzEefl5pPO+UA==
Content-Type: multipart/mixed; boundary="===============7036563572323585494=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <33188e4423c52e3db72a6897e721674d8a9cb45534640e4999e906d1c4d948fa@mail.kernel.org>
In-Reply-To: <20260108113706.1715-1-qikeyu2017@gmail.com>
References: <20260108113706.1715-1-qikeyu2017@gmail.com>
Subject: Re: [PATCH bpf] xsk: fix init race causing NPD/UAF in xsk_create()
From: bot+bpf-ci@kernel.org
To: qikeyu2017@gmail.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,bjorn@kernel.org,hawk@kernel.org,pabeni@redhat.com,magnus.karlsson@intel.com,daniel@iogearbox.net,maciej.fijalkowski@intel.com,kuba@kernel.org,edumazet@google.com,horms@kernel.org,ast@kernel.org,sdf@fomichev.me,john.fastabend@gmail.com,qikeyu2017@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  8 Jan 2026 11:53:06 +0000 (UTC)

--===============7036563572323585494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index f093c3453f64..63b48e4b8b65 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1942,16 +1938,20 @@ static int __init xsk_init(void)
>  		goto out_unreg_notif;
>  	}
>
> +	err = sock_register(&xsk_family_ops);
> +	if (err)
> +		goto out_proto;

If sock_register() fails here, does xsk_tx_generic_cache get leaked?
The kmem_cache was successfully created just above this, but the error
path at out_proto does not appear to call kmem_cache_destroy().

Looking at the error unwind below:

> +
>  	return 0;
>
>  out_unreg_notif:
>  	unregister_netdevice_notifier(&xsk_netdev_notifier);
>  out_pernet:
>  	unregister_pernet_subsys(&xsk_net_ops);
> -out_sk:
> -	sock_unregister(PF_XDP);
>  out_proto:
>  	proto_unregister(&xsk_proto);

The path from sock_register() failure goes to out_proto, which only calls
proto_unregister() before falling through. There is no kmem_cache_destroy()
for xsk_tx_generic_cache in this error path.

Should there be a new label between out_unreg_notif and out_pernet that
destroys the kmem_cache, and should out_proto jump there instead?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20815690741

--===============7036563572323585494==--

