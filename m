Return-Path: <bpf+bounces-50352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDFEA269C5
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 02:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC351885B5C
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 01:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B486E12D758;
	Tue,  4 Feb 2025 01:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LjSES1OB"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B508634C
	for <bpf@vger.kernel.org>; Tue,  4 Feb 2025 01:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738632143; cv=none; b=qzYEfKDimnb3UzOcqeFydJHoxUQiBtElQnncDYztDGH1i9Vy9vNrhPNw/mkYkbSxmicDLlLrb7NXcD15DdNV10SQCwQeT5GPUZIQHKkQ1QMack2StUPKIzxA7DHWkdlf13zeHNKNKwfPa+uVJLcqHkSypPm4QSxFjBi9uO5fIYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738632143; c=relaxed/simple;
	bh=sLSXWZSYc/3bcZ6OcpKrj87pJYAu9qQli2k+lYpavSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KQtEqlEHyqWpNxqI8DERWVM4WisVKjWknzm9TXkaXquDQGiRRWkb2WD1MeUJ2cxUKSaZx/XAy/Ho1HPZUzcyEti+hK2XZ+fiSVbzQ3NTbAg060PeT42+UL2Xyw7BNrx0QFgTrvTQXtcE5enFIjDLCWEJp5isc/vPTx/yFYhwbQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LjSES1OB; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b02ff49f-4ffe-475d-ac5e-4fa0eb5919c1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738632138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7KP5eJUX1J228pXqtIx2euWql/OgbFixny58dO4sSOE=;
	b=LjSES1OBXaEMSnNuCEHpu+FV87ErXFmFqBzDRTucPhrEOsFXanC/HiqxoC9pw7eIi2S8ZJ
	Lkqx+BRIX/WXvku7X1q9fJ65wbnNrQOk/wPz9uCFiqCDlyBl33aC6Og3OsSgUsYII7JyaY
	tVhS4vibCCC2qp6CQ6kuPTRUREqGeRc=
Date: Mon, 3 Feb 2025 17:21:51 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 12/13] net-timestamp: introduce cgroup lock to
 avoid affecting non-bpf cases
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
 <20250128084620.57547-13-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250128084620.57547-13-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/28/25 12:46 AM, Jason Xing wrote:
> Introducing the lock to avoid affecting the applications which

s/lock/static key/

Unless it needs more static-key guards in the next re-spin, I would squash this 
one liner with patch 10.

> are not using timestamping bpf feature.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   net/ipv4/tcp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index b2f1fd216df1..a2ac57543b6d 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -493,7 +493,8 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
>   			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
>   	}
>   
> -	if (SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb) {
> +	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> +	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb) {
>   		struct skb_shared_info *shinfo = skb_shinfo(skb);
>   		struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
>   


