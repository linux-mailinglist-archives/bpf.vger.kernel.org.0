Return-Path: <bpf+bounces-62794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B81AFEA99
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 15:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC103AE86F
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 13:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004182E3B17;
	Wed,  9 Jul 2025 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="MXB+x5qv"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A498A28C2D6;
	Wed,  9 Jul 2025 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068711; cv=none; b=X00hs9ijKHjR7QJi967ILTR3pib6dc7Huul0wdTKRdQGK3bhnVwIaCENgnkEg3IhP3QB1ZrxhW0Hqa9qI2bUAMCmxECljFjph/YZE6yKrt0CFWfPkwUg0cCuiAhkEZk59s47DqGc9hgSfP3XM5T+chiuPMm9nc3GoISR8KuXfak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068711; c=relaxed/simple;
	bh=aPHsDSBdtEEptbtmIwoK6MNqu46gsm8gDMnyidk10rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RoFatNvH+EQHASj9Udtm7hvb2FceB7QL5icN3jgBtcHaVa4DdbNIAfujzvqYsDX7pKEy01fAC4Gy3oO3JtjF1xJ9W2An0eJ8GIhNlXAFCBpuTpOXraz8avvlEf7T8Paq6Vdt/6Pp4ojHwOehDQxUTO8bfX/BCZHATpW9P0sR9gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=MXB+x5qv; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=H/uqrPFxDiQ80xovGsc1jjlvo/n5Lc6EIccoR88PfBo=; b=MXB+x5qvtF/CtdbY8lu+q4wOqG
	rqm6ohGnlPOqs+dmX2cid6ovz0mQtqA9EIbRHUL3tkyR8q9zijOMp6tNPYm2zqh0YwUli9/lZPLAP
	b75OrEAwGWPQHEH8CqEtIPozrqrS3Cr/rJAhmCOx5pAploGziWbWsn29pbOj97I4H2wbYSuSx7XUd
	qrQ8Gu5TRsv+wUhZtAMIaDq44SqKCl9MtqVX7aZXMWd2aNtQnVvmonVkdxhRlSWrSLpE1RjCR7PCv
	cmBwDVA8slCNqkAqZekKhE0HVulkUKa0kq/6WcSK+jE+z3azLs6W0GovpdtJi5TvlaxyqTEWMrBZa
	5yiadZCw==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uZUeE-000AUS-3B;
	Wed, 09 Jul 2025 15:15:43 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1uZUeC-0003Lj-2A;
	Wed, 09 Jul 2025 15:15:41 +0200
Message-ID: <9393fab5-2b8a-4e56-aa5a-5f601d570b47@iogearbox.net>
Date: Wed, 9 Jul 2025 15:15:40 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/7] bpf: Add attach_type in bpf_link
To: Tao Chen <chen.dylane@linux.dev>, razor@blackwall.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, horms@kernel.org, willemb@google.com,
 jakub@cloudflare.com, pablo@netfilter.org, kadlec@netfilter.org,
 hawk@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org
References: <20250709030802.850175-1-chen.dylane@linux.dev>
 <20250709030802.850175-2-chen.dylane@linux.dev>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20250709030802.850175-2-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27694/Wed Jul  9 10:42:34 2025)

On 7/9/25 5:07 AM, Tao Chen wrote:
> Attach_type will be set when link created from user, it is better
> to record attach_type in bpf_link directly suggested by Andrii. So
> add the attach_type field in bpf_link and move the sleepable field to
> the end just to fill the byte hole.
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>   drivers/net/netkit.c           |  2 +-
>   include/linux/bpf.h            | 28 ++++++++++++++++-----------
>   kernel/bpf/bpf_iter.c          |  3 ++-
>   kernel/bpf/bpf_struct_ops.c    |  5 +++--
>   kernel/bpf/cgroup.c            |  4 ++--
>   kernel/bpf/net_namespace.c     |  2 +-
>   kernel/bpf/syscall.c           | 35 +++++++++++++++++++++-------------
>   kernel/bpf/tcx.c               |  3 ++-
>   kernel/bpf/trampoline.c        | 10 ++++++----
>   kernel/trace/bpf_trace.c       |  4 ++--
>   net/bpf/bpf_dummy_struct_ops.c |  3 ++-
>   net/core/dev.c                 |  3 ++-
>   net/core/sock_map.c            |  3 ++-
>   net/netfilter/nf_bpf_link.c    |  3 ++-
>   14 files changed, 66 insertions(+), 42 deletions(-)
[...]

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 34dd90ec7fa..dd5070039de 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1729,12 +1729,10 @@ struct bpf_link {
>   	enum bpf_link_type type;
>   	const struct bpf_link_ops *ops;
>   	struct bpf_prog *prog;
> -	/* whether BPF link itself has "sleepable" semantics, which can differ
> -	 * from underlying BPF program having a "sleepable" semantics, as BPF
> -	 * link's semantics is determined by target attach hook
> -	 */
> -	bool sleepable;
> +
>   	u32 flags;
> +	enum bpf_attach_type attach_type;
> +
>   	/* rcu is used before freeing, work can be used to schedule that
>   	 * RCU-based freeing before that, so they never overlap
>   	 */
> @@ -1742,6 +1740,11 @@ struct bpf_link {
>   		struct rcu_head rcu;
>   		struct work_struct work;
>   	};
> +	/* whether BPF link itself has "sleepable" semantics, which can differ
> +	 * from underlying BPF program having a "sleepable" semantics, as BPF
> +	 * link's semantics is determined by target attach hook
> +	 */
> +	bool sleepable;
>   };

lgtm, it looks a bit weird at the end here after rcu/work but in future if other
attributes get added to the link obj and a new hole frees up we can move it up
again. Definitely good the rationale for the move is documented in the commit msg.

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

