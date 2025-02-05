Return-Path: <bpf+bounces-50470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB05A28179
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 02:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A121C162DA1
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 01:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527B620FAAB;
	Wed,  5 Feb 2025 01:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBAd6l2E"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C8220D4E3;
	Wed,  5 Feb 2025 01:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738720254; cv=none; b=CdQtDEDw3yWARTkz1VoW6eSsp0xz5EnszL+qQ4CfogaeeCD4oduvT23d87cb+quAGgI28fxzDtnf75ILz7hoYJ4/SaqQLwGt/Blg+1NpV2JvxqT5uuK+KQAtkzi6eycZRxBYk20hkiyggdif8/1IxfcsMuJl1zKdT24sFNM3I7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738720254; c=relaxed/simple;
	bh=7s7GRHQ5AVO0CnKkXPTk9Zu1R2RTZUaBUWi/BL/K/xs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t3EM9za00zLj1zWYCqn/IO+8+X7Ddx6dU7v1i+P0d8sxD6QrZ/eFrTOYYAz9xvq7HEDcC0OBhaP+zkpV66EebE8ClAJqDPf5CBWUtQl91qS/x3QKadwI534xOjWu4Z866DfmWD3G/e6o1E5dCJ6AmOsvKX6U8QMR1XxSh8uXoY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBAd6l2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211F9C4CEDF;
	Wed,  5 Feb 2025 01:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738720254;
	bh=7s7GRHQ5AVO0CnKkXPTk9Zu1R2RTZUaBUWi/BL/K/xs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rBAd6l2E4+/n4ycZRvBBlgGzYIcSxCt4/9dCKojo3Ber7opXnKS6i1EKI9s0aXfqU
	 /YsRohBuit7WwHNy4rX7PlfkweAHlLMpQF3O1iQAarHAKOJmjBcoUQT7t/z5KrF7EU
	 +i3KjDESbm6NtIr+FNj8ZUykuflAhBdpBOOZ9prZnqJLNRuhWquptbqieaJYM6StzY
	 dt1ZzKHSumtc932xJxuhG5pW1j12Gh5hA/Ypb6zJp4iDpdCXjHEXkMVUkVuZz94f9P
	 mHifvVAqvRHX/eFicNMaR7RTEPP5oCnzcWAD87/ETNpw6kO23iFQmPRjN8lqewV3gY
	 B84R1VMG5sXKA==
Date: Tue, 4 Feb 2025 17:50:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 dsahern@kernel.org, willemdebruijn.kernel@gmail.com, willemb@google.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v8 05/12] net-timestamp: prepare for isolating
 two modes of SO_TIMESTAMPING
Message-ID: <20250204175052.6abc3d2d@kernel.org>
In-Reply-To: <20250204183024.87508-6-kerneljasonxing@gmail.com>
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
	<20250204183024.87508-6-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Feb 2025 02:30:17 +0800 Jason Xing wrote:
>  void __skb_tstamp_tx(struct sk_buff *orig_skb,
>  		     const struct sk_buff *ack_skb,
>  		     struct skb_shared_hwtstamps *hwtstamps,
> -		     struct sock *sk, int tstype)
> +		     struct sock *sk, bool sw, int tstype)
>  {
>  	struct sk_buff *skb;
>  	bool tsonly, opt_stats = false;
> @@ -5551,6 +5576,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
>  	if (!sk)
>  		return;
>  
> +	if (!skb_enable_app_tstamp(orig_skb, tstype, sw))

maybe keep the order of @tstype vs @sw consistent?

