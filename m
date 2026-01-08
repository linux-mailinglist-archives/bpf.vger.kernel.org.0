Return-Path: <bpf+bounces-78217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9043D028C4
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 13:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA4AE311CC9D
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 11:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4357837E2E7;
	Thu,  8 Jan 2026 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNGbmWg7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1660C4D2EC4;
	Thu,  8 Jan 2026 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767871305; cv=none; b=mteJ4YF7MPEe0RrQqupbskkELyl6htwKUmrKjeigPd/OQSfgs8PFvcUzFnwjX7oieCB99Ws/oozPOzsr7mpNiT5+NroUzPmRXcay/QKyujih5RxIHn7uFom4Wm2Hk1vYQmE4bZ33cocvK4iXt8qc1cJ5lpRT2J9Vq2+2Qe2CNsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767871305; c=relaxed/simple;
	bh=uPop86H0Bu9yQ7+VBXaeXRbzihvoA91Q1qMjyWMQ33Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ROzuzmF/DbFkFs/OVQdm3gWGcUBwuQy8hvsArPxJQfHKYtATX8HWM3q+qUrfXlSpVGI+GRF0qIK4O+l2AGVAwrYTQGoSz0sx0gImbNQL180CW18soM8rri2kZYigYfshOi23Lpd+gqjhzSE5PZ1nR1Ar6JG+MUWf1PeAE1PPAtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNGbmWg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73380C116C6;
	Thu,  8 Jan 2026 11:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767871304;
	bh=uPop86H0Bu9yQ7+VBXaeXRbzihvoA91Q1qMjyWMQ33Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=NNGbmWg7hvUQkzoHN27pU4JP7habAa5Eq8LGNoRZbYwShkKsYF9w7I22kDZGGmLx5
	 7svGLKz8k1yYT8wCSjIcwyP8cba5Ac+n1RSP5QSsK1aiYR61F+hYhQRkGgOp8N4lNC
	 BJHDdEfMFGANm6Ln28WTMID066HptVoN6ON8C1IKIwzvh8AI2XsPA+xQNSzl5wQjBA
	 KzrVQtECR55KmAJweJsdTjJ9QLVcDgvqtZ5MiklRgodnVK+wsKLplC5a28AHvb8NSw
	 +LTTHaRUfCR9aApiQOA8izgirxv6ky6B+RrRgZz5MI6ooA0FYUCJ9KjbEyS1roHBh3
	 U8KJ7k/6hs9KA==
Content-Type: multipart/mixed; boundary="===============7903862845410419672=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <495e261276ae70d5936875e2c5b1d1a03646a1589526ff83cd7b70b6baf1614b@mail.kernel.org>
In-Reply-To: <20260108105343.1694-2-qikeyu2017@gmail.com>
References: <20260108105343.1694-2-qikeyu2017@gmail.com>
Subject: Re: [PATCH bpf] xsk: fix init race causing NPD/UAF in xsk_create()
From: bot+bpf-ci@kernel.org
To: qikeyu2017@gmail.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,qikeyu2017@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  8 Jan 2026 11:21:44 +0000 (UTC)

--===============7903862845410419672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index f093c3453f64..63b48e4b8b65 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1922,10 +1922,6 @@ static int __init xsk_init(void)
>  	if (err)
>  		goto out;
>
> -	err = sock_register(&xsk_family_ops);
> -	if (err)
> -		goto out_proto;
> -
>  	err = register_pernet_subsys(&xsk_net_ops);
>  	if (err)
>  		goto out_sk;

[ ... ]

> @@ -1942,16 +1938,20 @@ static int __init xsk_init(void)
>  		goto out_unreg_notif;
>  	}
>
> +	err = sock_register(&xsk_family_ops);
> +	if (err)
> +		goto out_proto;
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
> +out_sk:
> +	sock_unregister(PF_XDP);

The error unwind path looks incorrect. If register_pernet_subsys() fails,
the code jumps to out_sk which now calls sock_unregister(PF_XDP). However,
at that point sock_register() has not been called yet since it was moved
to after kmem_cache_create().

Looking at the execution path:

    proto_register() succeeds
    register_pernet_subsys() fails
    goto out_sk
    -> out_sk: sock_unregister(PF_XDP)  // sock_register() was never called

The same issue affects register_netdevice_notifier() and kmem_cache_create()
failures - they all eventually fall through to out_sk and call
sock_unregister() before sock_register() was ever called.

Should out_sk be placed before out_proto in the error unwind section, or
should the goto targets be updated? The original code had the error unwind
labels in the correct order relative to the registration sequence.

>  out:
>  	return err;
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20814824025

--===============7903862845410419672==--

