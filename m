Return-Path: <bpf+bounces-32050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8F49068DB
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 11:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4664B1C2405C
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 09:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639A813F438;
	Thu, 13 Jun 2024 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhVPUx1a"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA99C381C4;
	Thu, 13 Jun 2024 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718271203; cv=none; b=AHQqVIaBUVOduacvCW8vd1bFzFkJf2FeZ/kVZnXkvuIrWPs4my+d+BBZBBb2LGDAAwN1bt4pmcQTCVtLlQZtIX47kyuxFxVD8cI26Dr9mkWiZ7OrfT8GsUrFEc1nLO65BgGS5bohuOCzJD3qkMdtjQJj7QK9WZGHzHhxrOsSEKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718271203; c=relaxed/simple;
	bh=FWl6WVfBlpItvEzqF3u++D6qEfqM0dklJ5gklTNJdEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SfjDEx6vNTbsVM8FuUj/eaqtwNQO1UcLrh96UenkvjahPivSvzS3N/wjufijcvpvQEEnFUkWwM/jhpfnIEFF4aBLTcaKhyg6SG0gPA+zmzHDktkDSrE4V2oetX0JieX71LAj0LZqLdtPC76KK1X8er4HtliNP6lNMErIfvoox0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhVPUx1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D98C2BBFC;
	Thu, 13 Jun 2024 09:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718271202;
	bh=FWl6WVfBlpItvEzqF3u++D6qEfqM0dklJ5gklTNJdEQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hhVPUx1aTpkibvfD8f5rMYGoHBBZazMbx62UeXCIfOcCEBK2nUvKbduGu97uQP9Ir
	 G35Ew/uYrKje4//JhHIXXqjTiAS5mEeZtXApx1ZoEODg2usu0x9CpWQtmLVv9G3UBa
	 4SZzLj75cjVy7p+1hUVn6FSNsrGN+/ZYxdy20Yp3fRlK3ECN3XnrsnLIYqhdmNlIOh
	 bYAuXxSovtTnDMPnNMj/5Z6mNVt8yiTW9nXilynB8rbFzy40tPwSGiF872vnhPKCRz
	 9zo/9vBE+Zpmb58fRvsxbIuN18z3wnRfF9M+Eg0jE1T8Q+xM2kZjDchiVMLrhRhmCN
	 JhKJo381qFn6Q==
Message-ID: <4d79cd91-50dc-402e-a4f5-785093341efc@kernel.org>
Date: Thu, 13 Jun 2024 11:33:13 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 15/15] net: Move per-CPU flush-lists to
 bpf_net_context on PREEMPT_RT.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Daniel Bristot de Oliveira <bristot@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Eric Dumazet <edumazet@google.com>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vu?=
 =?UTF-8?Q?sen?= <toke@redhat.com>, Yonghong Song <yonghong.song@linux.dev>,
 bpf@vger.kernel.org
References: <20240612170303.3896084-1-bigeasy@linutronix.de>
 <20240612170303.3896084-16-bigeasy@linutronix.de>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20240612170303.3896084-16-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/06/2024 18.44, Sebastian Andrzej Siewior wrote:
> The per-CPU flush lists, which are accessed from within the NAPI callback
> (xdp_do_flush() for instance), are per-CPU. There are subject to the
> same problem as struct bpf_redirect_info.
> 
> Add the per-CPU lists cpu_map_flush_list, dev_map_flush_list and
> xskmap_map_flush_list to struct bpf_net_context. Add wrappers for the
> access. The lists initialized on first usage (similar to
> bpf_net_ctx_get_ri()).
> 
[...]
> Reviewed-by: Toke Høiland-Jørgensen<toke@redhat.com>
> Signed-off-by: Sebastian Andrzej Siewior<bigeasy@linutronix.de>
> ---
>   include/linux/filter.h | 42 ++++++++++++++++++++++++++++++++++++++++++
>   kernel/bpf/cpumap.c    | 19 +++----------------
>   kernel/bpf/devmap.c    | 11 +++--------
>   net/xdp/xsk.c          | 12 ++++--------
>   4 files changed, 52 insertions(+), 32 deletions(-)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

