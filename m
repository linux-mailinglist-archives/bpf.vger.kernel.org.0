Return-Path: <bpf+bounces-41290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EF5995776
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 21:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDED32888A8
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 19:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97862139B1;
	Tue,  8 Oct 2024 19:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pMkV/RV2"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B62212EF2
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 19:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728414831; cv=none; b=hPc6JLLyI+UNGv9mzKABwe9u9XgpvxhYS4L7peC/pTQ8I22kT7rfk5KQMzS871vK3kszjv4tDvZivxrkznYZt7xcDoGn9LbnO1HUiQE7OoMVtddU5ROQGZb3R6Ai8NPYendgU7gj7ILN02p+ibiuCcuxFvL/f1nBdWcn/XHC+l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728414831; c=relaxed/simple;
	bh=84VLykOVJanK2JuOPLXMEjUqAHC796Bd+w3gVOB0JG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f1o6zk85J+ID7aaqPob6j8U946TORCjp40jzzjfLddXRS2vzy+XwNsI8x4dpTxQAE+EPL7ugH5dcI9nhWLn7yimTT/+PXy5oM/OEAR3Lv35PsZeFSqmuVqoWf3Oub4TEHTbjqvUAM7K/maJip1amRnB5JfK5ksKoo2IncsMvc1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pMkV/RV2; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8f35cf0f-c56b-4fd0-93ef-e7e4f1c49dba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728414827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G4QRXGY5GGdSn95A7ChAPdYKlTgS12Bqr4q8uRR1npU=;
	b=pMkV/RV2eM848IEhXJT5XDaTOS4LLWphrseJp06+0INRBfvs8lNsx5rwwOeU746t9J5QoU
	Nca08Ks4AglL+3gb+k69bro81PXC5GBXyOZ8gycxuLc57owsqmo0mu8pxHT6VX897gvBcD
	m4jGuj3Fm5y/hwbP6w/H6GFYoe9u+0w=
Date: Tue, 8 Oct 2024 20:13:39 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 3/9] net-timestamp: introduce TS_SW_OPT_CB to
 generate driver timestamp
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 willemdebruijn.kernel@gmail.com, willemb@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
 <20241008095109.99918-4-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241008095109.99918-4-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/10/2024 10:51, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> When the skb is about to send from driver to nic, we can print timestamp
> by setting BPF_SOCK_OPS_TS_SW_OPT_CB in bpf program.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>   include/uapi/linux/bpf.h       | 5 +++++
>   net/core/skbuff.c              | 8 +++++++-
>   tools/include/uapi/linux/bpf.h | 5 +++++
>   3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 3cf3c9c896c7..0d00539f247a 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7024,6 +7024,11 @@ enum {
>   					 * feature is on. It indicates the
>   					 * recorded timestamp.
>   					 */
> +	BPF_SOCK_OPS_TS_SW_OPT_CB,	/* Called when skb is about to send
> +					 * to the nic when SO_TIMESTAMPING
> +					 * feature is on. It indicates the
> +					 * recorded timestamp.
> +					 */
>   };
>   
>   /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index e697f50d1182..8faaa96c026b 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5556,11 +5556,17 @@ static bool bpf_skb_tstamp_tx(struct sock *sk, u32 scm_flag,
>   		case SCM_TSTAMP_SCHED:
>   			cb_flag = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
>   			break;
> +		case SCM_TSTAMP_SND:
> +			cb_flag = BPF_SOCK_OPS_TS_SW_OPT_CB;
> +			break;
>   		default:
>   			return true;
>   		}
>   
> -		tstamp = ktime_to_timespec64(ktime_get_real());
> +		if (hwtstamps)
> +			tstamp = ktime_to_timespec64(hwtstamps->hwtstamp);
> +		else
> +			tstamp = ktime_to_timespec64(ktime_get_real());

Looks like this chunk belongs to another patch?

>   		tcp_call_bpf_2arg(sk, cb_flag, tstamp.tv_sec, tstamp.tv_nsec);
>   		return true;
>   	}
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index d60675e1a5a0..020ec14ffae6 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7023,6 +7023,11 @@ enum {
>   					 * feature is on. It indicates the
>   					 * recorded timestamp.
>   					 */
> +	BPF_SOCK_OPS_TS_SW_OPT_CB,	/* Called when skb is about to send
> +					 * to the nic when SO_TIMESTAMPING
> +					 * feature is on. It indicates the
> +					 * recorded timestamp.
> +					 */
>   };
>   
>   /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect


