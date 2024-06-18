Return-Path: <bpf+bounces-32398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D636190C702
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 12:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A522B23613
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 10:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1E01A4F09;
	Tue, 18 Jun 2024 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8++fdDC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09F313A272;
	Tue, 18 Jun 2024 08:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698727; cv=none; b=W0knaFsfDMrSPe4vDk+R4HXZe84cE7GCv0omyYyMQNfgJbyZ5BCkV+np+xid5AEFG/qWGL6fJVBLQEYc0WuGdcyszUna/bE4zRmwPENks90+mdGySzBBHHBJ3CJf4STJRTrzqqRPv99pikjnIMizvqD1mJGyDM/nCmzJcFw9ZLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698727; c=relaxed/simple;
	bh=cPCZEvw0UPMUPOeBUbgA27MdruCVrKhEgVI4A378S2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cU2IOGq5Wy6Fx3i3Euxfpy3oIAtrPDUIgVAe0xkDc+cY0uiKYtNoqU6SHshRfV3DFEZo+eztNhAC4YPGHaQqnjtzryM9kOOCfzW+SZMpeQkG9+SgCfdLewc8CYvQmksSIDAcWkx//QS82x3/zogdjmsBWFp1DkJKdqR1X/PRZ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8++fdDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA194C3277B;
	Tue, 18 Jun 2024 08:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718698727;
	bh=cPCZEvw0UPMUPOeBUbgA27MdruCVrKhEgVI4A378S2w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y8++fdDC9VKbFvwON83cjJWbBSxzD+ozwgTVDJOn8bCRpPdlumNUQoDviYy1fqGEt
	 Jnj3xGjIdtDyr55A1y9e78uvdOqz4OFUW9tWtdrBmyg1Sz1Xgr0rQf+ac4k9sTkiCw
	 dUOhYXHmUjjyfVtLNoaMrEAIaZi72/F1qDXpqukz9W+llt6ScFb0TwxHuOHMG0riUR
	 rc8jmRtnG5OMszPoMWSesGHIBgtjH2/1pwezbQaCaCuU+zc59X3LPjmoQOJZUH5DrH
	 i2SGAoQzZDXxpW/sVE6z9UZlqF23engkOpPuLasfs54hAmqDnL3xLVfd2l9YiXHcH5
	 ruc+vvmjlN5mQ==
Message-ID: <3f0fb527-ac58-4f73-b4f1-1e35bf064feb@kernel.org>
Date: Tue, 18 Jun 2024 10:17:42 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 15/15] net: Move per-CPU flush-lists to
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
References: <20240618072526.379909-1-bigeasy@linutronix.de>
 <20240618072526.379909-16-bigeasy@linutronix.de>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20240618072526.379909-16-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18/06/2024 09.13, Sebastian Andrzej Siewior wrote:
> The per-CPU flush lists, which are accessed from within the NAPI callback
> (xdp_do_flush() for instance), are per-CPU. There are subject to the
> same problem as struct bpf_redirect_info.
> 
> Add the per-CPU lists cpu_map_flush_list, dev_map_flush_list and
> xskmap_map_flush_list to struct bpf_net_context. Add wrappers for the
> access. The lists initialized on first usage (similar to
> bpf_net_ctx_get_ri()).
> 
> Cc: "Björn Töpel"<bjorn@kernel.org>
> Cc: Alexei Starovoitov<ast@kernel.org>
> Cc: Andrii Nakryiko<andrii@kernel.org>
> Cc: Eduard Zingerman<eddyz87@gmail.com>
> Cc: Hao Luo<haoluo@google.com>
> Cc: Jesper Dangaard Brouer<hawk@kernel.org>
> Cc: Jiri Olsa<jolsa@kernel.org>
> Cc: John Fastabend<john.fastabend@gmail.com>
> Cc: Jonathan Lemon<jonathan.lemon@gmail.com>
> Cc: KP Singh<kpsingh@kernel.org>
> Cc: Maciej Fijalkowski<maciej.fijalkowski@intel.com>
> Cc: Magnus Karlsson<magnus.karlsson@intel.com>
> Cc: Martin KaFai Lau<martin.lau@linux.dev>
> Cc: Song Liu<song@kernel.org>
> Cc: Stanislav Fomichev<sdf@google.com>
> Cc: Toke Høiland-Jørgensen<toke@redhat.com>
> Cc: Yonghong Song<yonghong.song@linux.dev>
> Cc:bpf@vger.kernel.org
> Reviewed-by: Toke Høiland-Jørgensen<toke@redhat.com>
> Signed-off-by: Sebastian Andrzej Siewior<bigeasy@linutronix.de>

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

> ---
>   include/linux/filter.h | 42 ++++++++++++++++++++++++++++++++++++++++++
>   kernel/bpf/cpumap.c    | 19 +++----------------
>   kernel/bpf/devmap.c    | 11 +++--------
>   net/xdp/xsk.c          | 12 ++++--------
>   4 files changed, 52 insertions(+), 32 deletions(-)

