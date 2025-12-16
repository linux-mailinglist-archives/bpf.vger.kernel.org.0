Return-Path: <bpf+bounces-76677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4BECC0BA3
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 04:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4718D30336BA
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 03:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B879B2E06EF;
	Tue, 16 Dec 2025 03:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhjUqGaX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330FA26059B;
	Tue, 16 Dec 2025 03:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765856053; cv=none; b=fa2aqZGMwI8S5J9qBi8De3MKjWGTrpdQ77/c64x3dUTgbiZx881xdxMy8eCHEypJ2RNaO4s8AzkOUHu9fdfLYJiy/PmYEicggvXiTTRyuEpzD4bQBZkACkICDJyli4l4tOZMNHKoHAuRXmhXqFog1NSHl62LfwIKCoQVFBNhF8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765856053; c=relaxed/simple;
	bh=KeCxncnuSFJjzzaRe8K2a8BqmNbS4k4iVP3dvPsYyns=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=H6bK3rpagmu0umVqJ6jDPoi3F5DXJkopId3DMf+ZLiGK5QZHLgyIHn/i1Hh/Ox3QRKYR7/X8aYtGRWP9hu9WXs1MomCNtMWL3xChDc+vf0xLlp/co3v5nv7Y6P4XMUr6qyI+f3i3mYxMyaUPBEKBsRCmW38xEqBxkfWTL9yxSss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhjUqGaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C13C4CEF5;
	Tue, 16 Dec 2025 03:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765856052;
	bh=KeCxncnuSFJjzzaRe8K2a8BqmNbS4k4iVP3dvPsYyns=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=mhjUqGaXnUXFG/D7Hdv3D+2Y8oGBbTElQdwfKCo54UDO5vfD3rmbK8Hy95aaxa8mt
	 cb8rAYx78CZ40kdR/Tu23CxAavfHK/wBjmbPz/VcSaNGAWPf7A4DUJrQhvfKV38Pkx
	 XJI3b46GNX2uCu9qhDL0JiV75NXnV87X32UMl2r8PNsDYCYR7UXlIGUWg4BhoMg/zK
	 bWejhJqTLuq9vUBx3X+kCZ9+IRRFyigQVyoWZPFSaw2sxyqkk1WhlkHeVnZ1UlC7HY
	 wio2Thtdce8g5g2tl9QX0QVGjQ2fcL0xS9HcLhgDRj1ArVMtPmP72QvksRMUm4Agdy
	 unWS7gsyJbtEw==
Content-Type: multipart/mixed; boundary="===============2241353678792354598=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3c943df286f9886735ac6212e4096731b80f6db4f245303cd2864157fac2072d@mail.kernel.org>
In-Reply-To: <20251216031018.1615363-1-donglaipang@126.com>
References: <20251216031018.1615363-1-donglaipang@126.com>
Subject: Re: [PATCH] bpf: Fix NULL deref in __list_del_clearprev for flush_node
From: bot+bpf-ci@kernel.org
To: donglaipang@126.com,syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com
Cc: andrii@kernel.org,ast@kernel.org,bpf@vger.kernel.org,daniel@iogearbox.net,davem@davemloft.net,eddyz87@gmail.com,haoluo@google.com,hawk@kernel.org,john.fastabend@gmail.com,jolsa@kernel.org,kpsingh@kernel.org,kuba@kernel.org,linux-kernel@vger.kernel.org,martin.lau@linux.dev,netdev@vger.kernel.org,sdf@fomichev.me,song@kernel.org,syzkaller-bugs@googlegroups.com,yonghong.song@linux.dev,donglaipang@126.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 16 Dec 2025 03:34:12 +0000 (UTC)

--===============2241353678792354598==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 04171fbc39cb..6ab6eae31989 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -450,6 +450,7 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
>
>  	for_each_possible_cpu(i) {
>  		bq = per_cpu_ptr(rcpu->bulkq, i);
> +		INIT_LIST_HEAD(&bq->flush_node);
>  		bq->obj = rcpu;
>  	}
>

[ ... ]

> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index 2625601de76e..7a7347e709cc 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -428,7 +428,8 @@ void __dev_flush(struct list_head *flush_list)
>  		bq_xmit_all(bq, XDP_XMIT_FLUSH);
>  		bq->dev_rx = NULL;
>  		bq->xdp_prog = NULL;
> -		__list_del_clearprev(&bq->flush_node);
> +		if (bq->flush_node.prev)
> +			__list_del_clearprev(&bq->flush_node);
                ^^^^

The devmap code adds the same defensive check but doesn't initialize
flush_node the way cpumap does. Looking at dev_map_notification(), when
NETDEV_REGISTER occurs, it calls:

    alloc_percpu(struct xdp_dev_bulk_queue)

And then only initializes the dev field:

    per_cpu_ptr(netdev->xdp_bulkq, cpu)->dev = netdev;

Without INIT_LIST_HEAD(&bq->flush_node), if alloc_percpu() returns
memory with non-zero bytes, bq->flush_node.prev could contain garbage.

The enqueue path in bq_enqueue() uses:

    if (!bq->dev_rx)
        list_add(&bq->flush_node, flush_list);

So if dev_rx contains non-zero garbage, the node never gets added to the
list. But this flush code checks bq->flush_node.prev which could also be
garbage, causing __list_del_clearprev() to be called with invalid
pointers.

Does devmap need INIT_LIST_HEAD(&bq->flush_node) similar to cpumap? The
commit message states that initialization is part of the fix, but only
cpumap gets it.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20255377282

--===============2241353678792354598==--

