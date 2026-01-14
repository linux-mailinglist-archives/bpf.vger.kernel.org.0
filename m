Return-Path: <bpf+bounces-78841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12870D1C92B
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 06:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C34A930CA885
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 05:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C56F356A37;
	Wed, 14 Jan 2026 05:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeDmr5RM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB4634EEE7;
	Wed, 14 Jan 2026 05:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768367925; cv=none; b=SgGV7ISHE39pH1bfEoORdLJhnDMIatGKDLQsyxrAuBCs2ZKRwY/nUuVmnJO8P831Jd7nnQ66i2nC2LQ9n+hIciM4CjQEU2e65r4650Y8p/bdIsL6/hujup9q7BZti/MIecfy6i382fi7xgwjK2nos/xjFniwXWyZ34eiUVMo51A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768367925; c=relaxed/simple;
	bh=+7Hm/PDz0Jbdey+/Y65d2diKY+FwEKxnGd4vOxZXWQQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=OuOyEeiVKZyIfEGpJ7FvpMUi0qx5tH0OxlwFg3GXIxCuLvDAQNAdMbMJE1xSNCaiBxMpuQpM96oJlk7VKNexhNoURaNpD7EesKqyUwMzHbx/XkbFEX7wNqGuL1rTq0NPwmkH1fMulTIiA532ShA34hhGvtFTsdOGXLGhu3eKW9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeDmr5RM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2E0C4CEF7;
	Wed, 14 Jan 2026 05:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768367925;
	bh=+7Hm/PDz0Jbdey+/Y65d2diKY+FwEKxnGd4vOxZXWQQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=XeDmr5RMYXXtKW6yGo87A8q/KWl288Zt42Wbh0MTncbvYDMXJGU28YWSTWQrgLx0H
	 N6n5mDLLQ2HcZG95WXq8ARvnAteR3EuDapo0zL/wUP4E8ioXQBUQ0jAQXIG+zbmp2Q
	 MarcJRcMp7ZMWsWk2r+uJOBovHYv9jkQGwGrW6uBhgBe/zuIpMEWrREPTbaRq75IC+
	 3852ThU8GUiDcOBj+Ghckc0/MxJpok302OFM4WSMaebjnQVmnGEyhmypaHgUj9lnaL
	 KrYJXd3KFfOVebYUkT4X/fnrj3zI6GcLZeQAoJCc0JvaZR5+ZLxj52vZ5OGc+8FLE6
	 Iu5wfFe4TcRww==
Content-Type: multipart/mixed; boundary="===============2804728330588876411=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <17dcbb5af344c64488806ab2e291d4d7a0de3c51b8d9b0478bb1f0106a584530@mail.kernel.org>
In-Reply-To: <20260114045509.1281217-1-saiaunghlyanhtet2003@gmail.com>
References: <20260114045509.1281217-1-saiaunghlyanhtet2003@gmail.com>
Subject: Re: [bpf-next,v2] bpf: cpumap: report queue_index to xdp_rxq_info
From: bot+bpf-ci@kernel.org
To: saiaunghlyanhtet2003@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,netdev@vger.kernel.org,saiaunghlyanhtet2003@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 14 Jan 2026 05:18:45 +0000 (UTC)

--===============2804728330588876411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 14e6f2a2fb77..4a409802cdac 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -648,6 +648,8 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
>
>  		xdp_convert_frame_to_buff(frame, xdp);
>  		xdp->rxq = &rq->xdp_rxq;
> +		/* Preserve original queue_index from frame */
> +		rq->xdp_rxq.queue_index = frame->queue_index;
                ^^^^^^^^^^^^^^^^^^^^^^^^

Unlike cpumap.c and devmap.c which use a stack-local rxq variable,
this writes to the persistent rq->xdp_rxq structure.

In veth_poll(), the code reads queue_index before calling veth_xdp_rcv():

    int queue_idx = rq->xdp_rxq.queue_index;
    ...
    peer_txq = peer_dev ? netdev_get_tx_queue(peer_dev, queue_idx) : NULL;
    ...
    done = veth_xdp_rcv(rq, budget, &bq, &stats);

After processing a frame from a device with many queues (e.g. queue 32),
the next poll will read the corrupted queue_index and pass it to
netdev_get_tx_queue(). If the peer device has fewer TX queues, this
causes an out-of-bounds access to dev->_tx[].

For comparison, cpumap.c uses a local variable:

    struct xdp_rxq_info rxq = {};
    ...
    rxq.queue_index = xdpf->queue_index;

Should veth also use a local rxq variable like cpumap and devmap do,
rather than modifying the persistent rq->xdp_rxq?

> [ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20983017884

--===============2804728330588876411==--

