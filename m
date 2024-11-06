Return-Path: <bpf+bounces-44128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3FF9BEF70
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 14:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC471F22E91
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 13:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B8E1F9ABA;
	Wed,  6 Nov 2024 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9M6C7uj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E09D188CC9;
	Wed,  6 Nov 2024 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730900947; cv=none; b=bS5O6Jcs3P8YA46FoxlKrRYn+88d2uSvzofSkSNzzvh4d16EK40E16KrNTPBo18Sfm3/F05357PhZhuGplR4UtAQyXlbbBSsuGraGSOy9UVOw1oQ2/AMCrLXweaZvc7hiiqcUn1p+GNerqgU3/OrYyF59htFURMzUQDTtSkP0DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730900947; c=relaxed/simple;
	bh=kP5RNnwnRakHjp7IiUrY3EZP4voLJK0ckjyows/28Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDV0v7PXYrDGsqyHRhXbXyvOuxeLNGXPpE7Xg54/BEMfP1vx/ljQzN3L+uF6nL4IaYnZ/EdvLeStTLwUeh8UburEtgRlwjkkuZFRjWP0fDNun3XtUXcC6s8sja8TBK48Pwc0irPbbG+kFxNpzPC3Gb0fJ/AwyRp8E9vJ5K5+5G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9M6C7uj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B356FC4CEC6;
	Wed,  6 Nov 2024 13:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730900947;
	bh=kP5RNnwnRakHjp7IiUrY3EZP4voLJK0ckjyows/28Og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G9M6C7ujoR2l2An6oFv/Nne/k7peIsT4TOU71BCK/kvL6ynxw2avyJtD+gZFfTNs4
	 ZJzkq4hByd83nVmbB8zRY9EWxQcPYXPEbVBT86ovTdP0e2HF7h4tXDGLBA8f5SZvyD
	 NVuowSQJ70ZkhDM6W6aaQCt5VNphlChlgHuAnLm2v/T030CXUqWR4xyMh9Ik4L5Tnw
	 XHiWKwhhAfmvpzbmAHMPV4RU77bZRvsS6Cr+i6nr0Q+YmYYRUEzje1IKU5TabziiSD
	 b4kc7YfsaH8qE1Zx8hYtFElzpCH3bhkN8uVCHioGQqWKSKJKbqtMogWyR/344YKnZY
	 0XfFyW6hUlUIg==
Date: Wed, 6 Nov 2024 13:49:02 +0000
From: Simon Horman <horms@kernel.org>
To: mrpre <mrpre@163.com>
Cc: yonghong.song@linux.dev, john.fastabend@gmail.com,
	martin.lau@kernel.org, edumazet@google.com, jakub@cloudflare.com,
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bpf: Introduce cpu affinity for sockmap
Message-ID: <20241106134902.GP4507@kernel.org>
References: <20241101023832.32404-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101023832.32404-1-mrpre@163.com>

On Fri, Nov 01, 2024 at 10:38:31AM +0800, mrpre wrote:

...

> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 07d6aa4e39ef..36e9787c60de 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -465,7 +465,7 @@ static int sock_map_get_next_key(struct bpf_map *map, void *key, void *next)
>  }
>  
>  static int sock_map_update_common(struct bpf_map *map, u32 idx,
> -				  struct sock *sk, u64 flags)
> +				  struct sock *sk, u64 flags, s32 target_cpu)
>  {
>  	struct bpf_stab *stab = container_of(map, struct bpf_stab, map);
>  	struct sk_psock_link *link;
> @@ -490,6 +490,8 @@ static int sock_map_update_common(struct bpf_map *map, u32 idx,
>  	psock = sk_psock(sk);
>  	WARN_ON_ONCE(!psock);
>  
> +	psock->target_cpu = target_cpu;
> +
>  	spin_lock_bh(&stab->lock);
>  	osk = stab->sks[idx];
>  	if (osk && flags == BPF_NOEXIST) {

Hi Jiayuan Chen,

The code immediately following the hunk above is:

		ret = -EEXIST;
		goto out_unlock;
	} else if (!osk && flags == BPF_EXIST) {
		ret = -ENOENT;
		goto out_unlock;
	}

And it seems that these gotos are the only code paths that lead to
out_unlock, which looks like this:

out_unlock:
	spin_unlock_bh(&stab->lock);
	if (psock)
		sk_psock_put(sk, psock);
out_free:
	sk_psock_free_link(link);
	return ret;
}

As you can see, the code under out_unlock expects that psock may be NULL.
But the code added to this function by your patch dereferences it
unconditionally. This seems inconsistent.

Flagged by Smatch.

...

