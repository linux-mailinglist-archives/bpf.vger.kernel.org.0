Return-Path: <bpf+bounces-39414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC37972C7A
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 10:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A26A1F24F84
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 08:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D560187857;
	Tue, 10 Sep 2024 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2r0+MNe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEECC17DFFD;
	Tue, 10 Sep 2024 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958089; cv=none; b=jI3Oe33fFrwlqfTMY81Dic4/NJjb9sEK1rqHjYEmyoPRbFAwxSVOmh0A9LbY8fei7E7uEkC9A7W/VKLf4Iu2NZUlMyCRjyN+NvJ3EH47kZuo2eVsM2klsDI9fS/ckdoGbKtHGvhDPp/TabGWYlG6B2eIcWfD0OPsuK+2nZCT7t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958089; c=relaxed/simple;
	bh=noGUHiHs9Zgm+97JzXrmCR7Pe+55n1E+td0QbsIhGos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/WEDpFOMXSA4Id00t6Ig670WN1+zHLXboV0kxiqoSDWmjyneUiR+rl6849f+ldVIrCddqUh80oJJwLwlRiSORJJfM38IDUrQy1KZlFzPwDXfLgxkQH6GbVDcRgHtErnIe1FTEOExWoVg4atLGM/8UQekKcmCnjSuY9JFzb/IJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2r0+MNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0BEC4CEC3;
	Tue, 10 Sep 2024 08:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725958089;
	bh=noGUHiHs9Zgm+97JzXrmCR7Pe+55n1E+td0QbsIhGos=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m2r0+MNeB2u9StkmzgwwW/TCbugtRSVWg3UcYjI6B0svQIl7eBYZCj/mf2xTuIdBB
	 TGTVn/fgu6xJuyt9a2oJpatsxeNIiPm1/4WV03U2Sh0qBRp7Fxwnr0akkah7A9hCfR
	 p1POAOYSCG/NciqVHR5XZJEZrQDDOPRqDVdHZKjvqilVpWQhQuYL+0Twp4TJwG1Vtb
	 cXuS/oLZP9ZLm2bdBwl/EByEva/bIYZgV0YWDH6p+rj0RbwnBlt7yd1UxIQP51N7MH
	 BxxrMjeNkXQspjQJBGweadLGHAQcZFBmjmNzMYr25wIKiaiwLuStl27k024YW4cuA1
	 cKyV2I3C8DLAQ==
Message-ID: <e34bc47d-aada-4bf8-ac29-d3462f351f20@kernel.org>
Date: Tue, 10 Sep 2024 10:48:03 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: cpumap: Move xdp:xdp_cpumap_kthread
 tracepoint before rcv
To: Daniel Xu <dxu@dxuuu.xyz>, davem@davemloft.net, ast@kernel.org,
 kuba@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, lorenzo@kernel.org,
 aleksander.lobakin@intel.com, kernel-team@meta.com
References: <47615d5b5e302e4bd30220473779e98b492d47cd.1725585718.git.dxu@dxuuu.xyz>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <47615d5b5e302e4bd30220473779e98b492d47cd.1725585718.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/09/2024 03.22, Daniel Xu wrote:
> cpumap takes RX processing out of softirq and onto a separate kthread.
> Since the kthread needs to be scheduled in order to run (versus softirq
> which does not), we can theoretically experience extra latency if the
> system is under load and the scheduler is being unfair to us.
> 
> Moving the tracepoint to before passing the skb list up the stack allows
> users to more accurately measure enqueue/dequeue latency introduced by
> cpumap via xdp:xdp_cpumap_enqueue and xdp:xdp_cpumap_kthread tracepoints.
> 

It makes sense for me to move this :-)
It actually fits my use-case even better.

> f9419f7bd7a5 ("bpf: cpumap add tracepoints") which added the tracepoints
> states that the intent behind them was for general observability and for
> a feedback loop to see if the queues are being overwhelmed. This change
> does not mess with either of those use cases but rather adds a third
> one.

Yes, my use-case is to this as a feedback loop, to see when queue is
overwhelmed as you say.  I will soon be playing with this feature in
production environments, so I'm excited that it looks like you have
similar use-cases for this :-)

> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

> ---
>   kernel/bpf/cpumap.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index fbdf5a1aabfe..a2f46785ac3b 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -354,12 +354,14 @@ static int cpu_map_kthread_run(void *data)
>   
>   			list_add_tail(&skb->list, &list);
>   		}
> -		netif_receive_skb_list(&list);
>   
> -		/* Feedback loop via tracepoint */
> +		/* Feedback loop via tracepoint.
> +		 * NB: keep before recv to allow measuring enqueue/dequeue latency.
> +		 */
>   		trace_xdp_cpumap_kthread(rcpu->map_id, n, kmem_alloc_drops,
>   					 sched, &stats);
>   
> +		netif_receive_skb_list(&list);
>   		local_bh_enable(); /* resched point, may call do_softirq() */
>   	}
>   	__set_current_state(TASK_RUNNING);

