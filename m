Return-Path: <bpf+bounces-70054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EFBBAE3B3
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 19:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F35C168F5D
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 17:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBCA30ACE4;
	Tue, 30 Sep 2025 17:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+75qEIn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6805926B0AE;
	Tue, 30 Sep 2025 17:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759254092; cv=none; b=pGGCG15a295nLSHHwfF/V5M4xzy1Hm48Ql/Q1/LAMIif4+5neMJN/muToxopzv82EBHp1SUUJfarO3wr811cGTSEWNQGF0XKHEDfvUPe+//okGRoaZ8V7AMdpGkdJqlc65RwRiL9Obmdko7ofTz+VhvK0NAVE+6Am1lTRJ57xEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759254092; c=relaxed/simple;
	bh=+GAiL9WWo8nrQPuPanEEryisnD2Dhz+PKoalgEDD2go=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E51Un5Bb2sC4I4WGnCq5aAfHoBc6cY/g7FeHTbG555SVTgbiVXVJFAwU2Fnn9Ye09UZPh4cLlZSftDMbEaUX6VZWfN8YwiX5tLniTE9V2xM5jc/xNfk2QqnEdc9lQ2LocH+ARtOyNVeSa5uGoOvWmDZU9rw/jYUunxoXVo1c/Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+75qEIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E12C4CEF0;
	Tue, 30 Sep 2025 17:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759254090;
	bh=+GAiL9WWo8nrQPuPanEEryisnD2Dhz+PKoalgEDD2go=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N+75qEInhs//Fd/PRwsQcywfT2xJ2F92dckA/h2rFBE1SQk6u8nB2UkXOCgGUR2SO
	 M61AfxC0n3gJQgSPCuOsBqBQJcxZ0BiYAt5VvCwZbwz4VbKWjem1MASwO86/WzbfzZ
	 MUdw4bvHLyzoPGVFJZjIyyxCb8FaouTNqSQjBEueXb4jFMRfVtf/rD09nGN9p85n3E
	 KOV3ztWIKWR+HefyiRMTgaE601XfNHSlBqnGoTEBdQKtbVGYi5TWlXghVNKdTK3pCJ
	 odG6wq/ERXZZEYd8mhBIarJn/iCuNGOB84QSSmsLKq5ebgITEZaTxOjeN5PgDKVc6Y
	 01bhMTyRG0U/A==
Date: Tue, 30 Sep 2025 10:41:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Octavian Purdila <tavip@google.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
 toke@redhat.com, lorenzo@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com,
 Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH net] xdp: use multi-buff only if receive queue supports
 page pool
Message-ID: <20250930104129.20a2aa7e@kernel.org>
In-Reply-To: <CAGWr4cSwEbuSPEJp6=-8gRbD7O-pOqzn_1fXPxWv-ZX3b7NX_w@mail.gmail.com>
References: <20250924060843.2280499-1-tavip@google.com>
	<20250924170914.20aac680@kernel.org>
	<CAGWr4cQCp4OwF8ESCk4QtEmPUCkhgVXZitp5esDc++rgxUhO8A@mail.gmail.com>
	<aNUObDuryXVFJ1T9@boxer>
	<20250925191219.13a29106@kernel.org>
	<CAGWr4cSiVDTUDfqAsHrsu1TRbumDf-rUUP=Q9PVajwUTHf2bYg@mail.gmail.com>
	<aNZ33HRt+SxltbcP@boxer>
	<20250926124010.4566617b@kernel.org>
	<CAGWr4cSwEbuSPEJp6=-8gRbD7O-pOqzn_1fXPxWv-ZX3b7NX_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Sep 2025 17:01:49 -0700 Octavian Purdila wrote:
>         local_lock_nested_bh(&system_page_pool.bh_lock);
> -       err = skb_cow_data_for_xdp(this_cpu_read(system_page_pool.pool), pskb, prog);
> +       pool = this_cpu_read(system_page_pool.pool);
> +       err = skb_cow_data_for_xdp(pool, pskb, prog);
> +       rxq->mem.type = MEM_TYPE_PAGE_POOL;
> +       rxq->mem.id = pool->xdp_mem_id;
>         local_unlock_nested_bh(&system_page_pool.bh_lock);

Yes, LGTM. I _think_ that only skb_cow_data_for_xdp() has to be under
the lock here, but doesn't really matter.

