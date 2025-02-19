Return-Path: <bpf+bounces-51892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC50A3AF39
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 03:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04950175397
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 02:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594CB15C15C;
	Wed, 19 Feb 2025 02:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="STq9dNmP"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF553596A
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 02:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739930482; cv=none; b=C9LfCh3SGP9f6c1IxgP9vClYwUsR2uGNhaYj6ePVNkDaj6h0vEobkVuNpOiM+KhXOufS62aiPJZoaBzIqzi38RCS0ndG9B0Xa9gMEDWS/EVBCkS7+Bv2RAf327EO9+rhp6SMZnXQM1hhC+fChTYWDZ2qs6/lFBVPYP4QnyFhtXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739930482; c=relaxed/simple;
	bh=B+y7aKIb8LX3y21if8vnuwQMNR9mHxasMxj1pZePSGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l5XUx2BBeOUJ0vLdB+3q4JMK/JcOuEtfGhJvXsNEm1aGS+9vdWuvwYUO1oN5zesUSi/EnR3wkvlIDetUeiWBR8gnBlf+zffThJyuOc+ot3g8J3Y+C/kBJnQCBZB8A9Gqsyuo/hJL/yZcsFo0FqcopEbo5FzgIOxMuL64AX4kpY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=STq9dNmP; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <71d6c5e8-058b-470d-b411-347e2a1266a5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739930478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FEtjXGl1qqa76BD2EjdGCsJVy0dC9Gkc8kcKoXrX2U8=;
	b=STq9dNmPFvDlCfRrU5Dxr1aA/Vvuxk6url/morHDvl1zQW/mWXfDzl8W3nn9K49CcBml41
	0We28uwBOIkbLJmTml1dfX5i/knf7th2B878nta4Vql2IFk4rThG19hAZBklljdA5NQTC/
	eaWZttr0yQkFPwAG9sX5D9KP2jj8K/Q=
Date: Tue, 18 Feb 2025 18:01:10 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: add rto max for
 bpf_setsockopt test
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, kuniyu@amazon.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 ykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250217034245.11063-1-kerneljasonxing@gmail.com>
 <20250217034245.11063-4-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250217034245.11063-4-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/16/25 7:42 PM, Jason Xing wrote:
> Add TCP_RTO_MAX_MS selftests for active and passive flows
> in various bpf callbacks. Even though the TCP_RTO_MAX_MS
> can be used in established phase, we highly discourage
> to do so because it may trigger unexpected behaviour.
> On the contrary, it's highly recommended that the maximum
> value of RTO is set before first time of transmission, such
> as BPF_SOCK_OPS_{PASSIVE|ACTIVE}_ESTABLISHED_CB,

s/,/./

What unexpected behavior when setting in BPF after the established state?

Setting it after the established state or not is not specific to BPF. syscall 
can choose to do it after the connection established also. The above makes it 
unclear what unexpected behavior that the BPF prog will cause if TCP_RTO_MAX_MS 
is used in BPF instead of syscall.

If there is subtle difference between calling TCP_RTO_MAX_MS from bpf and from 
syscall, please write it clearly what are the unexpected behaviors when calling 
in BPF after the established states.

Otherwise, the commit message can be just this:

Test the TCP_RTO_MAX_MS optname in the existing setget_sockopt test.

> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   tools/include/uapi/linux/tcp.h                      | 1 +
>   tools/testing/selftests/bpf/progs/bpf_tracing_net.h | 1 +
>   tools/testing/selftests/bpf/progs/setget_sockopt.c  | 1 +
>   3 files changed, 3 insertions(+)
> 
> diff --git a/tools/include/uapi/linux/tcp.h b/tools/include/uapi/linux/tcp.h
> index 13ceeb395eb8..7989e3f34a58 100644
> --- a/tools/include/uapi/linux/tcp.h
> +++ b/tools/include/uapi/linux/tcp.h
> @@ -128,6 +128,7 @@ enum {
>   #define TCP_CM_INQ		TCP_INQ
>   
>   #define TCP_TX_DELAY		37	/* delay outgoing packets by XX usec */
> +#define TCP_RTO_MAX_MS		44	/* max rto time in ms */

Have you checked if this change is really needed?

>   
>   
>   #define TCP_REPAIR_ON		1
> diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> index 59843b430f76..eb6ed1b7b2ef 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> @@ -49,6 +49,7 @@
>   #define TCP_SAVED_SYN		28
>   #define TCP_CA_NAME_MAX		16
>   #define TCP_NAGLE_OFF		1
> +#define TCP_RTO_MAX_MS		44
>   
>   #define TCP_ECN_OK              1
>   #define TCP_ECN_QUEUE_CWR       2
> diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/testing/selftests/bpf/progs/setget_sockopt.c
> index 6dd4318debbf..106fe430f41b 100644
> --- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
> +++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
> @@ -61,6 +61,7 @@ static const struct sockopt_test sol_tcp_tests[] = {
>   	{ .opt = TCP_NOTSENT_LOWAT, .new = 1314, .expected = 1314, },
>   	{ .opt = TCP_BPF_SOCK_OPS_CB_FLAGS, .new = BPF_SOCK_OPS_ALL_CB_FLAGS,
>   	  .expected = BPF_SOCK_OPS_ALL_CB_FLAGS, },
> +	{ .opt = TCP_RTO_MAX_MS, .new = 2000, .expected = 2000, },
>   	{ .opt = 0, },
>   };
>   


