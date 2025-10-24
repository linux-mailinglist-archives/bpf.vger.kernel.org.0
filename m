Return-Path: <bpf+bounces-72150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA86C07D1E
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 20:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB133A7502
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 18:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6814834B41E;
	Fri, 24 Oct 2025 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVQmupvK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9143054E8
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761331928; cv=none; b=IvqpM4QebENDSZBTyOc85pypN9A9AGiLObEIYgXg8tceiy3FgyCX6r/TZiOZg0+wqw/tQ3l1v076l4+yaXEXhilPHpfyf0YqrIjHGHmUBK5WRKjtwmHWLPqL9ZSUNSfd96ONyMlcxtuweDOWZPIAhDNOjREy3kUDxSqWtd8S2n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761331928; c=relaxed/simple;
	bh=Wz135uwetxCwe/8eH3Kl+AzNgbfF3r35YAD2LnYmJvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObfhA4AU0ZApo4KfhMg32TBb+1pVPAOKymCVTOrPFS+h6uUWHjylIh1AjRDtpis2SvlRGoeUIxTdxyH5V+gZfkO7Zg7ssUuxrSi3xBUK7rHmlzZzSFCMB1a1bCnkxhL1CkfkXb+ISDCFY3Ot43wSs87pdIAjj3uuWcz3XC92mM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVQmupvK; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6cf1a95273so1765994a12.1
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 11:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761331924; x=1761936724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QPSvA2tqe3+8UGVytFzavc2q7JOKTx1l11r2cyagv24=;
        b=QVQmupvK1/jMSKut4Kkk9hiapnVMZkDTSO65inOKsgynHPl9tB92JjxyiuSlZwiM6Z
         NElfdE8296L5VgvFwuBE286gxaNgsXBE8HwEjckzqmpn5UZlEz2ALzAyxrD8jkosmtcW
         wpLs55cfCe2EvuSRhYKc9KRAi24nKedgpb4tLXaLHjORbBOk5+67kN4/jajlEC5/ZZFb
         skkoWFNinGbrNwW+RYIK5eh47icnLxv7JP7Wmh2rr0qx2UHNG4HVzeij80c4LIqH11wP
         YVyMRCD528BVTRwyd0JBHB9/SG3ybeGqrsUl1DXslLlsgoAxDdHxXdoOhUQTEXw3Bvr6
         xK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761331924; x=1761936724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPSvA2tqe3+8UGVytFzavc2q7JOKTx1l11r2cyagv24=;
        b=pjXcBTR4LFNZxUAI0vYjduzdgtppLRLvnbjjTdEFSiRjtDVbgCzImrYV+qP6fPxJh5
         YlXV6PYdQ8G7/wnuLEzj42PYQtr4wanX7M8qMHQzPkdN37VoDtNfbSrcAOi+0O5/HDKw
         g121+bXOfaaJ5hni9i6IOv50qjhA4WDyEQ+0Hgh9EiKJmpbqftBZc+K1/QRf+9fYu2Sj
         QyqbaWgVTHq/ZfV9lMkNwDO8hyMMFNDaSRZWLKojw/UjmyXzXMVlwcALYw8ChPvjiyVY
         4iPW1YMNBVfvyWSkzztBSbzOVJctZVE3CVYwfw9FIHwWmlUcK8Xeua+wqIOpEU9qurXY
         n9Xg==
X-Forwarded-Encrypted: i=1; AJvYcCU8ZY8dH5e9FAABWFYmdNvkXq99dAQZ45Ffvwc9cYncbu8pq4nkxEKACKJ9GIvb6q0BOw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrQHi+V1xrPt7Y/1e6eWGZtz2LKjuWGO/WC6vSt77Voj0HKFkX
	F9JAr9sSrp1VhRk/VJB0BWTRGgpWJG/7lN8QQNjzmh7Ea0KCOHrxPkE=
X-Gm-Gg: ASbGncsPLgne8cs3wrH7S2/goQaGYQBh5ZWW+gXxjA9L5Ec1Uy5Ffaw0uXXrARV3yTr
	azdxWQn3nFZ6URp65cjjYvERlkbVHNTrZLhCM3z2ZifjfAD8F0TYeUvVFoUjDFpJEJ9HT0DOXVK
	2oteCsjmWuOyzpIhhaBbaewURlDG91yvatphGJkZGqYYPfBhFm8zLAJAhhOOOHpNv/UPNqh6iB1
	BHR0/ozWCYwLMUJiKgWoZTDwPFxJmgv3xVc7anEN67umMMZssTWxH9zGfNMIHA/VXLIZ3z5HuzY
	yqryO3EPB5d9f/XqnUMq1sMdU3e4dEhcQOXG9zjkY1nqR6TZXOp/olRPlw0qqM+Yl3+3ZrtDBhj
	5/Fad477rCqunBCMb1kHeBIaUDDgsh5ZAapVCSsz0thOWvY7KLLar7WsGm1w7y1HN8iFLBGJ07E
	JO20sItJDxsbNLF2H6HG/3JLS4FzNNoQmXXlGxe8L2wnpUulTGE99eeY6ruVC/U3hIzAwHrNQRU
	ChJWK0tjhfHnZH0/SeYr/Ba8mZudvr/+95FA0JwC959GihlxBV8mrCy
X-Google-Smtp-Source: AGHT+IGqWSsq0Vg7wkMd2FZCssMLWr4Rkrrt1nos4O7oKC+6IfLNMi+/H9tWY/uOFIaAlybXBdO1og==
X-Received: by 2002:a17:902:e944:b0:290:a3b9:d4c6 with SMTP id d9443c01a7336-290caf831b6mr375381935ad.36.1761331923437;
        Fri, 24 Oct 2025 11:52:03 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-33e223e334fsm9906023a91.8.2025.10.24.11.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 11:52:03 -0700 (PDT)
Date: Fri, 24 Oct 2025 11:52:02 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to,
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3 8/9] xsk: support generic batch xmit in copy
 mode
Message-ID: <aPvK0pFuBpplxbXX@mini-arch>
References: <20251021131209.41491-1-kerneljasonxing@gmail.com>
 <20251021131209.41491-9-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251021131209.41491-9-kerneljasonxing@gmail.com>

On 10/21, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> - Move xs->mutex into xsk_generic_xmit to prevent race condition when
>   application manipulates generic_xmit_batch simultaneously.
> - Enable batch xmit eventually.
> 
> Make the whole feature work eventually.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/xsk.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 1fa099653b7d..3741071c68fd 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -891,8 +891,6 @@ static int __xsk_generic_xmit_batch(struct xdp_sock *xs)
>  	struct sk_buff *skb;
>  	int err = 0;
>  
> -	mutex_lock(&xs->mutex);
> -
>  	/* Since we dropped the RCU read lock, the socket state might have changed. */
>  	if (unlikely(!xsk_is_bound(xs))) {
>  		err = -ENXIO;
> @@ -982,21 +980,17 @@ static int __xsk_generic_xmit_batch(struct xdp_sock *xs)
>  	if (sent_frame)
>  		__xsk_tx_release(xs);
>  
> -	mutex_unlock(&xs->mutex);
>  	return err;
>  }
>  
> -static int __xsk_generic_xmit(struct sock *sk)
> +static int __xsk_generic_xmit(struct xdp_sock *xs)
>  {
> -	struct xdp_sock *xs = xdp_sk(sk);
>  	bool sent_frame = false;
>  	struct xdp_desc desc;
>  	struct sk_buff *skb;
>  	u32 max_batch;
>  	int err = 0;
>  
> -	mutex_lock(&xs->mutex);
> -
>  	/* Since we dropped the RCU read lock, the socket state might have changed. */
>  	if (unlikely(!xsk_is_bound(xs))) {
>  		err = -ENXIO;
> @@ -1071,17 +1065,22 @@ static int __xsk_generic_xmit(struct sock *sk)
>  	if (sent_frame)
>  		__xsk_tx_release(xs);
>  
> -	mutex_unlock(&xs->mutex);
>  	return err;
>  }
>  
>  static int xsk_generic_xmit(struct sock *sk)
>  {
> +	struct xdp_sock *xs = xdp_sk(sk);
>  	int ret;
>  
>  	/* Drop the RCU lock since the SKB path might sleep. */
>  	rcu_read_unlock();
> -	ret = __xsk_generic_xmit(sk);
> +	mutex_lock(&xs->mutex);
> +	if (xs->batch.generic_xmit_batch)
> +		ret = __xsk_generic_xmit_batch(xs);
> +	else
> +		ret = __xsk_generic_xmit(xs);

What's the point of keeping __xsk_generic_xmit? Can we have batch=1 by
default and always use __xsk_generic_xmit_batch?

