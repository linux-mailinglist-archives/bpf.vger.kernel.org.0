Return-Path: <bpf+bounces-73889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02217C3CDE0
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 18:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F757502830
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 17:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399A02BDC3E;
	Thu,  6 Nov 2025 17:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ewp025nY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3E134FF4C
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 17:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450212; cv=none; b=eGJOBGDigGJeLY+0vvKTp4cIXySX+sNzC8ZyGqzKQpa90jhcT4vjOHbxq4HcpVoz8gZmU+YwGeh6ITvVUhczGjVkH7JykgV3pIzMSJMop71MAsApnO8VpXawd12H9fz1f74kRpctHsB8ZkY55nNEeJZHxdo5e/PfKe1ORV6/Bfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450212; c=relaxed/simple;
	bh=Uelx4wn1CFd2HD4/yw5xsex/k/69qK2lLkxSoTmtxk4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JPb1kkm0VeY4YN3DpxSbU2Gpm5z/zddVTCx1hcarf21VFAty58wTmR7xW7e2ZyCYve1+l6hiKzZPte6rrB/vH3uyHdONR9Z0t/BZr0+R8tAKyVeFROFvXaKT2ZyWBvslTy91kzhaOgjBE+SIvb7uzJqAG/VWyydd1YhT0vFYJfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ewp025nY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF029C4CEFB;
	Thu,  6 Nov 2025 17:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762450212;
	bh=Uelx4wn1CFd2HD4/yw5xsex/k/69qK2lLkxSoTmtxk4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Ewp025nYDBLNQ0y7GgU5AcHu+sPu+AUbxBWZwaVsK3I+srQ9PlDvFzsDZ1KUj4wTC
	 3GyDYlMNkAC8W6+XnASTro/DXVgtxPMZsrRWBeeyh4QthwNiTDAST3S/nNYfARg8aO
	 vbqyAlCFDjVaDeEfLT0Pa5z8ZIARWcRC5BHu1TiOw5rkbMobYIFHImy50qZ/xnamYx
	 V+MhCnalQcoYvQUXw0jiFpBTyNcxAon5kDgemk/CH1lC8jVwn3nEBgTfOjaXfI+rey
	 qsxe+W5t8KO6VBrZlw//VAkvIYKAdOOH/m/w0HW7Hr+o0Ofkz/bvWSzeXJS9VxBvdB
	 oEmTxNXSHO1mw==
Content-Type: multipart/mixed; boundary="===============8475527710490481038=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <07d47ff900decea1efa670a5973e6499b0722d7a33609a21e204a616252eef58@mail.kernel.org>
In-Reply-To: <20251106170608.4800-1-puranjay@kernel.org>
References: <20251106170608.4800-1-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v2] bpf: Use kmalloc_nolock() in range tree
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  6 Nov 2025 17:30:11 +0000 (UTC)

--===============8475527710490481038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
> index 37b80a23a..99c63d982 100644
> --- a/kernel/bpf/range_tree.c
> +++ b/kernel/bpf/range_tree.c

[ ... ]

> @@ -150,9 +149,7 @@ int range_tree_clear(struct range_tree *rt, u32 start, u32 len)
>  		range_it_insert(rn, rt);
>
>  		/* Add a range */
> -		migrate_disable();
> -		new_rn = bpf_mem_alloc(&bpf_global_ma, sizeof(struct range_node));
> -		migrate_enable();
> +		new_rn = kmalloc_nolock(sizeof(struct range_node), 0, NUMA_NO_NODE);
>  		if (!new_rn)
>  			return -ENOMEM;

Was the change in memcg accounting behavior intentional here?

The old code used bpf_mem_alloc(&bpf_global_ma, ...) which charges
allocations to the root memcg (bpf_global_ma is initialized at
late_initcall with get_obj_cgroup_from_current()).

The new code uses kmalloc_nolock() with gfp_flags=0, which does not
include __GFP_ACCOUNT, so these allocations are not charged to any
memcg.

While these are small metadata structures (40 bytes each), and the
actual arena pages are still properly charged via bpf_map_alloc_pages(),
this changes the accounting behavior. Looking at other BPF code, there's
a bpf_map_kmalloc_nolock() wrapper in kernel/bpf/syscall.c that handles
memcg accounting properly with set_active_memcg() and __GFP_ACCOUNT.

Should the range_node allocations use __GFP_ACCOUNT to maintain
consistent accounting, or was the removal of memcg charging intentional?

> @@ -172,9 +169,7 @@ int range_tree_clear(struct range_tree *rt, u32 start, u32 len)
>  	} else {
>  		/* in the middle of the clearing range */
>  		range_it_remove(rn, rt);
> -		migrate_disable();
> -		bpf_mem_free(&bpf_global_ma, rn);
> -		migrate_enable();
> +		kfree_nolock(rn);
>  	}
>  }
>  	return 0;

[ ... ]

> @@ -227,9 +222,7 @@ int range_tree_set(struct range_tree *rt, u32 start, u32 len)
>  		range_it_remove(right, rt);
>  		left->rn_last = right->rn_last;
>  		range_it_insert(left, rt);
> -		migrate_disable();
> -		bpf_mem_free(&bpf_global_ma, right);
> -		migrate_enable();
> +		kfree_nolock(right);

Same memcg accounting question applies to the kfree_nolock() calls
as well.

[ ... ]

> @@ -241,9 +234,7 @@ int range_tree_set(struct range_tree *rt, u32 start, u32 len)
>  		right->rn_start = start;
>  		range_it_insert(right, rt);
>  	} else {
> -		migrate_disable();
> -		left = bpf_mem_alloc(&bpf_global_ma, sizeof(struct range_node));
> -		migrate_enable();
> +		left = kmalloc_nolock(sizeof(struct range_node), 0, NUMA_NO_NODE);
>  		if (!left)
>  			return -ENOMEM;

Same memcg accounting question applies here as well.

[ ... ]

> @@ -259,7 +250,7 @@ void range_tree_destroy(struct range_tree *rt)
>
>  	while ((rn = range_it_iter_first(rt, 0, -1U))) {
>  		range_it_remove(rn, rt);
> -		bpf_mem_free(&bpf_global_ma, rn);
> +		kfree_nolock(rn);
>  	}
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19143736343

--===============8475527710490481038==--

