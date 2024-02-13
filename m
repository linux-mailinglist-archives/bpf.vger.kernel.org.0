Return-Path: <bpf+bounces-21891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EF3853C6F
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 21:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 995571C26BEA
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 20:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED060612FC;
	Tue, 13 Feb 2024 20:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVcvjLa4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744FE3D988;
	Tue, 13 Feb 2024 20:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857458; cv=none; b=hpwz3Wht9tIFjX71lUWsP95EoL8DSfoAYZZX6/1mszWu0c/IHzMdGvLUljKiW/BiEokyAUOFaq0pAIwVkOtuLPwpeBOOLaT6cVUBaldUh6HCAU1D2oTvu+dWLYDCZoNXnysT10z9ReVg50Fm0MX4G548X6Nuad+HYhAxGAxfVH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857458; c=relaxed/simple;
	bh=UI5b/w7RgtJ1ToBVh7JDMlg5UZl4CX5RxCI4pRoLJ7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CuLWFasUScRiIQpdauSgz5dHjBXZ5Ly5HVZuCt1HYJ84MQFJzGhpvfTkz4IlhUzXxX/+IsQ0frRw7P9mo5d5G+gJLiFmPaWH3m/cI0Rw17wqMvdSe80Su4r8ktGoRraVbuj+8nqNO8qnvgn0VD2g9DSqqOHGZzvtvFm2hJNlgWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVcvjLa4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D26AC433F1;
	Tue, 13 Feb 2024 20:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707857458;
	bh=UI5b/w7RgtJ1ToBVh7JDMlg5UZl4CX5RxCI4pRoLJ7s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XVcvjLa4M1R8Jq/a3j3jii1nUahNfcwd+LiKlgrDAaz2GbuX6mACL+0NRauXwQ43/
	 A3p0HvMAsnXmiTf/RZZ/o7IHmw1Awc1TOblra+qXHRgLP+e63u3DwUTtgyyhkE/ZOc
	 FpI1w+NZvN+I/a8+UWEIjQz6V22jjqlqDi/Em/2RUVKh2faJbx7NKVvv4ZybktVPqH
	 QkyOkI5M/ERfB+jjup5r+i/h6O3t+d5m7eB+v5VdKdL4PugD5L9nbzl2YmWgzRSfN+
	 hKc6ep6A96MOv5detwV6VvsI/LaERxRmT5KJiw6aD7COe0GMnyB/D+ddwZQ0VELTbB
	 AAns5HSwDWkCA==
Message-ID: <66d9ee60-fbe3-4444-b98d-887845d4c187@kernel.org>
Date: Tue, 13 Feb 2024 21:50:51 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 1/2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>,
 Hao Luo <haoluo@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Paolo Abeni <pabeni@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Yonghong Song <yonghong.song@linux.dev>
References: <20240213145923.2552753-1-bigeasy@linutronix.de>
 <20240213145923.2552753-2-bigeasy@linutronix.de>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20240213145923.2552753-2-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/02/2024 15.58, Sebastian Andrzej Siewior wrote:
> The XDP redirect process is two staged:
> - bpf_prog_run_xdp() is invoked to run a eBPF program which inspects the
>    packet and makes decisions. While doing that, the per-CPU variable
>    bpf_redirect_info is used.
> 
> - Afterwards xdp_do_redirect() is invoked and accesses bpf_redirect_info
>    and it may also access other per-CPU variables like xskmap_flush_list.
> 
> At the very end of the NAPI callback, xdp_do_flush() is invoked which
> does not access bpf_redirect_info but will touch the individual per-CPU
> lists.
> 
> The per-CPU variables are only used in the NAPI callback hence disabling
> bottom halves is the only protection mechanism. Users from preemptible
> context (like cpu_map_kthread_run()) explicitly disable bottom halves
> for protections reasons.
> Without locking in local_bh_disable() on PREEMPT_RT this data structure
> requires explicit locking to avoid corruption if preemption occurs.
> 
> PREEMPT_RT has forced-threaded interrupts enabled and every
> NAPI-callback runs in a thread. If each thread has its own data
> structure then locking can be avoided and data corruption is also avoided.
> 
> Create a struct bpf_xdp_storage which contains struct bpf_redirect_info.
> Define the variable on stack, use xdp_storage_set() to set a pointer to
> it in task_struct of the current task. Use the __free() annotation to
> automatically reset the pointer once function returns. Use a pointer which can
> be used by the __free() annotation to avoid invoking the callback the pointer
> is NULL. This helps the compiler to optimize the code.
> The xdp_storage_set() can nest. For instance local_bh_enable() in
> bpf_test_run_xdp_live() may run NET_RX_SOFTIRQ/ net_rx_action() which
> also uses xdp_storage_set(). Therefore only the first invocations
> updates the per-task pointer.
> Use xdp_storage_get_ri() as a wrapper to retrieve the current struct
> bpf_redirect_info.
> 
> This is only done on PREEMPT_RT. The !PREEMPT_RT builds keep using the
> per-CPU variable instead. This should also work for !PREEMPT_RT but
> isn't needed.
>  > Signed-off-by: Sebastian Andrzej Siewior<bigeasy@linutronix.de>

I generally like the idea around bpf_xdp_storage.

I only skimmed the code, but noticed some extra if-statements (for
!NULL). I don't think they will make a difference, but I know Toke want
me to test it...

I'll hopefully have time to look at code closer tomorrow.

--Jesper

