Return-Path: <bpf+bounces-43816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E679BA099
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 14:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678E21F212E1
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 13:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D091199384;
	Sat,  2 Nov 2024 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nyvx0Zlu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11FA175D34;
	Sat,  2 Nov 2024 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730555046; cv=none; b=sgOn8QXEtTGjXXfnS8Zkwfga+GG8h2zyoA5QvOehOK3masQenDVRmcS38Ij0hHKqewtQWdFH9BV6MNRcx8IDi/T91JmjYSE8MPzQIyz0UX9kzIjMQzIESc5FM7wel/TJ14Xbbjs8Ip1/e5VkjI0p4dm51iEl+FlZR6wocgHljD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730555046; c=relaxed/simple;
	bh=Fh1tOp6zu5S7ndDQm3e4S5z+1IAX7J4sD51WBJXNmIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgiQPw5bQNWp52l4dSaBTq8vhnxIFDKWACjoviYmo51N3XF3vb9gxba3T8qEdaXd8DSKHGl3UHqmBC+8gx/aCBNgi3wK7Ny9nCAo4v43CDoXtBHxMfSESjOzsD41BDETsikye/lFGjhLGktvR/ddvmnK9WtJKSW1C8GdQgk9ftI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nyvx0Zlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A526C4CEC3;
	Sat,  2 Nov 2024 13:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730555046;
	bh=Fh1tOp6zu5S7ndDQm3e4S5z+1IAX7J4sD51WBJXNmIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nyvx0ZluaFgFw0qtEwyN/1zOCzvMLn5alJ1Mp0kObq9Ud8NCOJgd9j4BkFbGOD1KR
	 gmpwwftLbjGoSjiqNajdyptbFaGTos6NAUxy+kb24vuC4+wLUetnUlZXlni2rKfw7U
	 nhwk55QiN/GvA3TBoEkyWaQmcNLX4Mfy13tQ8+OJOqj8Tn4nhTlcHlN39EcbAWt3cB
	 OZNuGOBJfFRIfIvCJ0QwCPqjqCqzioXCvdegwIG/GV8argT8oF8TygLY6oum4+XU9J
	 1r0HNdewhrtbLa2Bcon+alBeBqL3Z6XeJigT5wbpi7WPcCtYLq4JLT8LUTuE3Vixt5
	 2ippRyRLDo1nA==
Date: Sat, 2 Nov 2024 13:43:57 +0000
From: Simon Horman <horms@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com, willemb@google.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
	ykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3 02/14] net-timestamp: allow two features to
 work parallelly
Message-ID: <20241102134357.GK1838431@kernel.org>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-3-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028110535.82999-3-kerneljasonxing@gmail.com>

On Mon, Oct 28, 2024 at 07:05:23PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> This patch has introduced a separate sk_tsflags_bpf for bpf
> extension, which helps us let two feature work nearly at the
> same time.
> 
> Each feature will finally take effect on skb_shinfo(skb)->tx_flags,
> say, tcp_tx_timestamp() for TCP or skb_setup_tx_timestamp() for
> other types, so in __skb_tstamp_tx() we are unable to know which
> feature is turned on, unless we check each feature's own socket
> flag field.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/net/sock.h |  1 +
>  net/core/skbuff.c  | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 7464e9f9f47c..5384f1e49f5c 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -445,6 +445,7 @@ struct sock {
>  	u32			sk_reserved_mem;
>  	int			sk_forward_alloc;
>  	u32			sk_tsflags;
> +	u32			sk_tsflags_bpf;

Please add sk_tsflags_bpf to the Kernel doc for this structure.
Likewise for sk_tskey_bpf_offset which is added by a subsequent patch.

>  	__cacheline_group_end(sock_write_rxtx);
>  
>  	__cacheline_group_begin(sock_write_tx);

...

