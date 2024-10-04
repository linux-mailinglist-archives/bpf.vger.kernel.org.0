Return-Path: <bpf+bounces-40934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0F4990297
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 14:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EABD1C20F7D
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 12:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8618E15852F;
	Fri,  4 Oct 2024 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="MPVX8o+j"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A99C1FAA
	for <bpf@vger.kernel.org>; Fri,  4 Oct 2024 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728043234; cv=none; b=R8zKPUQOH0s1UnGJ1fliQ8rHoRGaaynii1fcbdItyLv1Lo5HGXssn3Z5T+JhjA/8TR/BQjAwsWVgB89tIl3D3fdvSXw5WbDNzTKnMmsyT+Cn+pcjgqqofTGzZ/vYAMISI2dl48ZPIkzqfUHN7kqAOBY3OoGBZ4ZdLN44CabjTAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728043234; c=relaxed/simple;
	bh=gd9ePzkhKdhnCVIqyoGGXxcnRuI9cYgH9N6euSSDmV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYmU3ygHwIg6JTozL7oE942b+tpTHE8mVGWpJziFX2VOFFz3n0Z0ZjiZAUQpA74/C/1pV3VSTIXEDH15aWQM27uvgMh56P4n6+K/7a0c1NYVuMcF5ds9CF8GYULNkeRiksTJsaYHaCr/d9punapGhht0V3rQEeOuj3TKFzHaOlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=MPVX8o+j; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Ssr3oa/J0uDwMCbh5IAmJd/aJaUp+YVgNfbC0eRVOQk=; b=MPVX8o+j9tjUQBmG+whM5W/IK9
	HqSFN6oneoK4/k/p8cAw6EfDiSnlhdlVrW6gGzHodzoWcSNMyK819dbFCw8D4JkMs4Cx4uTwRVCsX
	RykEv+zx8DGni0zgMXIejGTbdNDoDYMbqVcL4AfueKclSg9gBcmiCUTLSF+UaOuQ5WbeJ7l9VkA7n
	dUP5XRW6L4tP8Q3Tj64r5eghqSEB0rvMsPmhGlmaoPeXv9Uh2CNprQEvbVMBfEAFpz/LdePwz0/V0
	2sQrO3y91GDSWAXe+4oVOxQEwsr3afjGw2W5QB4L3XXw1g8RS+JeEN5kIpgWdQeurJq5HBN2JUHFu
	fkKiBn0w==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1swgyz-0001bh-3R; Fri, 04 Oct 2024 14:00:28 +0200
Received: from [178.197.249.47] (helo=[192.168.1.114])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1swgyy-0000yj-1g;
	Fri, 04 Oct 2024 14:00:28 +0200
Message-ID: <a67821e7-e0e2-442e-a7c4-30889a482806@iogearbox.net>
Date: Fri, 4 Oct 2024 14:00:28 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpf: add get_netns_cookie helper to tc
 programs
To: Mahe Tardy <mahe.tardy@gmail.com>, bpf@vger.kernel.org
Cc: martin.lau@linux.dev, john.fastabend@gmail.com
References: <f05e5f07-467d-441a-8113-0a7c4cb2c842@iogearbox.net>
 <20241002175726.304608-1-mahe.tardy@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20241002175726.304608-1-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27417/Fri Oct  4 10:53:24 2024)

On 10/2/24 7:57 PM, Mahe Tardy wrote:
> This is needed in the context of Cilium and Tetragon to retrieve netns
> cookie from hostns when traffic leaves Pod, so that we can correlate
> skb->sk's netns cookie.
> 
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>   net/core/filter.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index cd3524cb326b..6e80991125ba 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5138,6 +5138,17 @@ static u64 __bpf_get_netns_cookie(struct sock *sk)
>   	return net->net_cookie;
>   }
> 
> +BPF_CALL_1(bpf_get_netns_cookie, struct sk_buff *, skb)
> +{
> +	return __bpf_get_netns_cookie(skb->sk ? skb->sk : NULL);
> +}
> +
> +static const struct bpf_func_proto bpf_get_netns_cookie_proto = {
> +	.func           = bpf_get_netns_cookie,
> +	.ret_type       = RET_INTEGER,
> +	.arg1_type      = ARG_PTR_TO_CTX_OR_NULL,

This basically tells the verifier that NULL or context can be passed to the
helper. As-is above, the `skb->sk ?` will trigger a NULL pointer dereference.

If you look into other implementations, the above should rather look like:

   return __bpf_get_netns_cookie(skb && skb->sk ? skb->sk : NULL);

> +};
> +
>   BPF_CALL_1(bpf_get_netns_cookie_sock, struct sock *, ctx)
>   {
>   	return __bpf_get_netns_cookie(ctx);
> @@ -8209,6 +8220,8 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   		return &bpf_skb_under_cgroup_proto;
>   	case BPF_FUNC_get_socket_cookie:
>   		return &bpf_get_socket_cookie_proto;
> +	case BPF_FUNC_get_netns_cookie:
> +		return &bpf_get_netns_cookie_proto;
>   	case BPF_FUNC_get_socket_uid:
>   		return &bpf_get_socket_uid_proto;
>   	case BPF_FUNC_fib_lookup:
> --
> 2.34.1
> 

