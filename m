Return-Path: <bpf+bounces-30148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25248CB381
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 20:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62067B22030
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 18:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D3914884F;
	Tue, 21 May 2024 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRoKrGrQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59202B9A7;
	Tue, 21 May 2024 18:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716316263; cv=none; b=hDq1sX2Id6iFDbluyCDf71XCWMsIjhiX5/mBYQute0FZe+8FrEb4y7Zafzt6S2BDU8VaJar//8SHiGyF684zYWF3omOyzjzsk/5mhX7edNft9XbIMOs6QmdezzRBS7kfino9TI0xW7TlZ2wjas0eI4gw8Vm7zMW1MzUBgzjq99Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716316263; c=relaxed/simple;
	bh=UzsGdwJz/Brc2hgT0ha+Ss2WZxJOw4KDyYb7rLojnz8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AH3gjtMWYbq/B0Gx3ehMv1GYqCfmBwrfs4iSflqrCImW0NnSmNcDd1sbK+LYBrW/OHkdymCAzx+c7ogNtedIo1116vj9qS8tr+zDQJrfXkRSBvmOqYX1m7eFWSAyWt2TLFqeOfg6415ZCXK1n0Q8n+JalE6m15Mmr5rChNTBStU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRoKrGrQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039D7C2BD11;
	Tue, 21 May 2024 18:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716316263;
	bh=UzsGdwJz/Brc2hgT0ha+Ss2WZxJOw4KDyYb7rLojnz8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=WRoKrGrQZOCjJuFjxcJt5qdA5n7OpRVziUqYEnc15RYyic+NZImF4s98u9PMiiuTr
	 18QobjbvQ5vs3AFanAADzoy1LIYstrJzvc0/C6Njfd+a5R4fh37UvTTkuqI6OmFiVT
	 icb0xlGuM60UbeMVWPXidJGp/jfAnC8IMbW/WMdXEzltAefy9iQr4Fkvm8JpS/sQJl
	 DDEPefAJ6TqHnGo0svWlYl4uFYM2id8vG3EmN4MIRcwbzbf+i1xQjuqCjXJ/xZqE20
	 a1UWn0bCGIMkXwJAqszVzB6888P7bULfz1rgq4kyi6yhHUzt5w8y9PsZKBT7bWe0pM
	 zz7MSbWLDaOxw==
Date: Tue, 21 May 2024 11:31:02 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Alexander Duyck <alexander.duyck@gmail.com>, 
    Ayush Sawal <ayush.sawal@chelsio.com>, Eric Dumazet <edumazet@google.com>, 
    Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
    Jason Wang <jasowang@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
    Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
    Vincent Guittot <vincent.guittot@linaro.org>, 
    Dietmar Eggemann <dietmar.eggemann@arm.com>, 
    Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
    Mel Gorman <mgorman@suse.de>, 
    Daniel Bristot de Oliveira <bristot@redhat.com>, 
    Valentin Schneider <vschneid@redhat.com>, 
    John Fastabend <john.fastabend@gmail.com>, 
    Jakub Sitnicki <jakub@cloudflare.com>, David Ahern <dsahern@kernel.org>, 
    Matthieu Baerts <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>, 
    Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
    Jiri Pirko <jiri@resnulli.us>, Boris Pismenny <borisp@nvidia.com>, 
    bpf@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [RFC v4 11/13] net: replace page_frag with page_frag_cache
In-Reply-To: <20240515130932.18842-12-linyunsheng@huawei.com>
Message-ID: <b405347e-3fde-8521-6541-c0afc6a48e3d@kernel.org>
References: <20240515130932.18842-1-linyunsheng@huawei.com> <20240515130932.18842-12-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 15 May 2024, Yunsheng Lin wrote:

> Use the newly introduced prepare/probe/commit API to
> replace page_frag with page_frag_cache for sk_page_frag().
>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
> .../chelsio/inline_crypto/chtls/chtls.h       |   3 -
> .../chelsio/inline_crypto/chtls/chtls_io.c    | 100 ++++---------
> .../chelsio/inline_crypto/chtls/chtls_main.c  |   3 -
> drivers/net/tun.c                             |  44 ++----
> include/linux/sched.h                         |   4 +-
> include/net/sock.h                            |  14 +-
> kernel/exit.c                                 |   3 +-
> kernel/fork.c                                 |   3 +-
> net/core/skbuff.c                             |  59 +++++---
> net/core/skmsg.c                              |  22 +--
> net/core/sock.c                               |  46 ++++--
> net/ipv4/ip_output.c                          |  33 +++--
> net/ipv4/tcp.c                                |  35 ++---
> net/ipv4/tcp_output.c                         |  28 ++--
> net/ipv6/ip6_output.c                         |  33 +++--
> net/kcm/kcmsock.c                             |  30 ++--
> net/mptcp/protocol.c                          |  67 +++++----
> net/sched/em_meta.c                           |   2 +-
> net/tls/tls_device.c                          | 139 ++++++++++--------
> 19 files changed, 349 insertions(+), 319 deletions(-)
>

Hi Yunsheng -

The MPTCP content looks ok to me. The MPTCP regression tests pass as well.

Acked-by: Mat Martineau <martineau@kernel.org>

