Return-Path: <bpf+bounces-78821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 68643D1C287
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 03:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BEF983014EBD
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678B43148C7;
	Wed, 14 Jan 2026 02:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBudthnk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6BAA945;
	Wed, 14 Jan 2026 02:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768358661; cv=none; b=AOzYtxzPHaDF9GAKjIYHAgoT0TnBg0y3bYgg9erLAAKd2z/T7mZhlSbbyRdqXRiLgruDEuyX/PotrlAZRfkxCzJ9IYwI2sKFapsvigEmGgZy61RTFF5oAayq1Ne28nFHdiSszSpKDirFw26/eTUFJ/z85woWRt7kCyj7YVdV9Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768358661; c=relaxed/simple;
	bh=Wwal9vaDVR63Q0cWKi0y+u1strxx7+v2N6jTiHNDP4I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=H/u43R3/JYSXklpxbANtvM0fQuG8v6cBnpsqRpYhEDsAnEQee3ETdKaPavMZQGdu3YNpVa4oJy2w6iYesTmybjq37ZcFLdM1r6jLB3YoMwgdc5vCugq9LHNjLrBxfqEIoerMdotawK/O/PEK+7OMuomxqTuIxYJnjVaGtSw1Bsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBudthnk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677E1C116C6;
	Wed, 14 Jan 2026 02:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768358660;
	bh=Wwal9vaDVR63Q0cWKi0y+u1strxx7+v2N6jTiHNDP4I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=YBudthnkocEzp/9apWrCNd3oy3e0KJ/xFUQYZlJXyt7e1hm6pUrIXyb8uobdOJ3qt
	 uNHZSNzFuh7XJZiiSvwJpT+/LhClLNxw6r33jcHCwM24gpwlTNOp8Rf76d9dWiYko6
	 PIQnpbL6NlnZ8NBzFZByDIzRJkX/8pBbiIs8I7+Fu8GL5C+OdIzYzUvCFGbguZYskI
	 iXADQWKqc2lwf9k4qbM7QBitH8sJmTy9udMMloYNW+eUoujiUZgjGzMjxKdsYzMyqv
	 x3FGbhlR76/iBuLmlS4jV49PZCvnohaBOFMjA4LZYYjLQx1qWmcxnDEzBXH+5nPbWM
	 /3ksiSTIWUJrQ==
Content-Type: multipart/mixed; boundary="===============2427180407077981129=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <718d0ad2565e1df204d3d73cc8130f7a37527e056affe7f3637f2898fb886c8f@mail.kernel.org>
In-Reply-To: <20260114021202.1272096-1-saiaunghlyanhtet2003@gmail.com>
References: <20260114021202.1272096-1-saiaunghlyanhtet2003@gmail.com>
Subject: Re: [PATCH] bpf: cpumap: report queue_index to xdp_rxq_info
From: bot+bpf-ci@kernel.org
To: saiaunghlyanhtet2003@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,netdev@vger.kernel.org,saiaunghlyanhtet2003@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 14 Jan 2026 02:44:20 +0000 (UTC)

--===============2427180407077981129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index aa742f413c35..feafeed327a2 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h

[ ... ]

> @@ -421,6 +422,7 @@ int xdp_update_frame_from_buff(const struct xdp_buff *xdp,
>  	xdp_frame->metasize = metasize;
>  	xdp_frame->frame_sz = xdp->frame_sz;
>  	xdp_frame->flags = xdp->flags;
> +	xdp_frame->queue_index = xdp->rxq->queue_index;
>
>  	return 0;
>  }

The new assignment unconditionally writes queue_index from xdp->rxq to the
frame. Several callers of xdp_update_frame_from_buff() do not set up
rxq.queue_index, which means they will write incorrect values.

In dev_map_bpf_prog_run() (kernel/bpf/devmap.c):

    struct xdp_rxq_info rxq = { .dev = rx_dev };
    ...
    xdp.rxq = &rxq;
    ...
    err = xdp_update_frame_from_buff(&xdp, xdpf);

The local rxq has queue_index implicitly set to 0, so any frame passing
through devmap with XDP_PASS will have its queue_index overwritten to 0.
Should devmap also preserve queue_index similar to cpumap, perhaps like:

    rxq.queue_index = xdpf->queue_index;

In veth_xdp_rcv_one() (drivers/net/veth.c):

    xdp_convert_frame_to_buff(frame, xdp);
    xdp->rxq = &rq->xdp_rxq;
    ...
    if (xdp_update_frame_from_buff(xdp, frame))

Here the frame's queue_index will be overwritten with veth's own queue
index, not the original source queue. Is this intended behavior?

Additionally, xdp_convert_zc_to_xdp_frame() in net/core/xdp.c creates
frames for XSK buff pool memory but does not set queue_index:

    xdpf = addr;
    memset(xdpf, 0, sizeof(*xdpf));
    ...
    xdpf->frame_sz = PAGE_SIZE;
    xdpf->mem_type = MEM_TYPE_PAGE_ORDER0;
    /* queue_index not set, remains 0 from memset */

Should this also copy xdp->rxq->queue_index to maintain consistency with
the regular conversion path?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20980088225

--===============2427180407077981129==--

