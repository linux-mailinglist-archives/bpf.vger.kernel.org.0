Return-Path: <bpf+bounces-19720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 789538302BA
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 10:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD481C24C2D
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 09:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA4014299;
	Wed, 17 Jan 2024 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Yri3To1y"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D8A1DFCA
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484860; cv=none; b=Fs2nTy+Xmj5y20v6Fi/0ZdTKtpusmJ/BIZzaCj5ZJi586FJojC3aDu924IF7oqgmesRkLDxJSAtZ3lsasAnuciHK8IUs0HBhWJ5dgF5Dvy6tkfViujbXF9143UYu7nS0JI0beQWGd/ZN3je+G1ScVV8NSQD6biQ2WNxNuXcHKD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484860; c=relaxed/simple;
	bh=gi9miwff+fvLkq/0B7Nyr2+s4zE+bZDcS2xz/CJEY1E=;
	h=DKIM-Signature:Received:Received:Subject:To:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-Authenticated-Sender:
	 X-Virus-Scanned; b=cEgfsBODadVxycnUUDgKO7N3RMN3+bkqkCuAkkK7UfJ9imWV/FIdVHDt36H8fRBOorYCP48UannzllA1jVAIlYm2UEjSkeziNOPbu0kwAZL29UXFh/h4NlKj3l/s3ib1qr54swQlWT8XEKyKelrk3+PUEbj/tXfGkqYz1cBFzW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Yri3To1y; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Pq1jh6XT69PTlzh5vaa/u7sf8d9G+0ICj0tHi25mGIY=; b=Yri3To1ybBYCKC/qlrPWHUwk2l
	ZvYdS5df8kFwkb2IffYkdTS/q7yw5Dtchtq7eMcVaCgLLqfs1L5KGeFGJBWCdyQYDiSDlw3jgZUQh
	7MbUOqmQF3W/Pyu+hczHRWyOgunmrzrYvT7gH0/UgogRnIL1SCyXALQjdL46nThO6AqTcB4AS/GSR
	p7E91MmwwVLCWNeva6hGEvAXB84UtSkPGDxA/k4bmoKOT5VzPz0p7cqBhxp9CPVzzKrD09PgpmZXW
	nuTyEFe1qGAvzVs+PLeg9iXztmA9U7Pf6smhgrsI1lwPAUfHgVnb8aWIJ1VZ0I/0vO7TGgo3QdBMO
	fh3quWGw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rQ2WF-000CnN-Dj; Wed, 17 Jan 2024 10:47:35 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rQ2WF-000VIn-6O; Wed, 17 Jan 2024 10:47:35 +0100
Subject: Re: [PATCH] fix bpf_redirect_peer header doc
To: Victor Stewart <v@nametag.social>, borkmann@iogearbox.net,
 bpf@vger.kernel.org
References: <20240116202952.241009-1-v@nametag.social>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2fdc2af6-6c86-d8e5-9121-fced266dcf32@iogearbox.net>
Date: Wed, 17 Jan 2024 10:47:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240116202952.241009-1-v@nametag.social>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27156/Tue Jan 16 10:38:07 2024)

On 1/16/24 9:29 PM, Victor Stewart wrote:
> ammend bpf_redirect_peer header doc to mention tcx and netkit
> 
> ---
>   include/uapi/linux/bpf.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 754e68ca8..01cc6abe2 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -4839,9 +4839,9 @@ union bpf_attr {
>    * 		going through the CPU's backlog queue.
>    *
>    * 		The *flags* argument is reserved and must be 0. The helper is
> - * 		currently only supported for tc BPF program types at the ingress
> - * 		hook and for veth device types. The peer device must reside in a
> - * 		different network namespace.
> + * 		currently only supported for tc and tcx BPF program types at the
> + * 		ingress hook and for veth and netkit target device types. The peer
> + * 		device must reside in a different network namespace.
>    * 	Return
>    * 		The helper returns **TC_ACT_REDIRECT** on success or
>    * 		**TC_ACT_SHOT** on error.
> 

Thanks Victor, I fixed this up a bit, added SoB, and pushed it out (see below
link). In general we don't specifically mention tcx program types since it's
the same program type as tc BPF (just a different method to attach it).

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=985b8ea9ec7efe6abb6acfc266459e31e9755e6d

