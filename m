Return-Path: <bpf+bounces-41934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D0799DBC1
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 03:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90BEB287E88
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 01:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8CE1C9EDF;
	Tue, 15 Oct 2024 01:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc7uga/S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB84619F132;
	Tue, 15 Oct 2024 01:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956091; cv=none; b=kLTODDMRCV1Z3ED3kYO15Hd/pTQ9M428q/ZT/SgQBDrvFc+A+9KrEvA61yZEyPy/Np3aA/f8FTLxxeLd91Ri32HUKpv9m3A6wSXrE+nefurf8LWyLzc8DqBcO1EWouFBllHMQ9swuWOLhxcZC4BAvTQ5dHWifvY9YMAMTPj6TPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956091; c=relaxed/simple;
	bh=yfVHow1OLv8U4dQgETPUm0GzN9fVcqCSwpUy3ljkjEo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YGUAw5wPdwgsFUSM8FTBhTskQUcCQsuRar2S5E50xBQ8aMm6ZDGrcYp/haxTF4Z0VRzubqxpOf00ZNRdN5yLgHZTVWMT9jdHN3nTQLnpk1BFlIOxQFT+IT4p2xDbQYUWr7rqthjjwF4lUNSEGnrjuuIA6gHgR+MMexFvi+IwknA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rc7uga/S; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b110709ebeso352154385a.1;
        Mon, 14 Oct 2024 18:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728956089; x=1729560889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODO04k9pH4CjSgM5UeKPFpV2r3miCaiPBdGQu3/TJGw=;
        b=Rc7uga/SKvQ3vjXTGqYA2yFbqyybJ6B8mKconMe9FqlgYK0eHOYpAo9zlORky4DQjz
         T9Zv1YrzDex2axc90BDVAXrcRkbvASUWGHLZ07sZqvIv9R+q1q/dRlx5sKwR6iMQdpT/
         v8PDkwHGSf1T5eiNNWxEHEJlJf61akssdJEkLnR3kIJ1CkIkoDMbBfXGfDPQFbeOKJAk
         s1tSOsu1U2oT4PxDl0iTRr+M2Asyc5zchr9iO1JfaigaU4bBWyp5QhaO+DP69ZPRdbJd
         Klprk0Q29LSaZXc5uA7+pc4CxuMHRwDSY34oq5hN5/0RWYnpk0/aK2ucvSxe+cCxX5aS
         ZHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728956089; x=1729560889;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ODO04k9pH4CjSgM5UeKPFpV2r3miCaiPBdGQu3/TJGw=;
        b=XF+M4NOlo6zLlmoQH1wgp6qGPl/Dwrvu32wgFv6Irp3F22gn5yvHJ0nghQY1g6lhM9
         FY7j3RCEB9CYDkzQtsIbz46PGX5WhEb+H4fObozSQ9lrQ6NPqTAgw5fPFGme1DHJnp2L
         F0dKVqFHRDfJ3kvUMXaQA448BqBsRXRGgonK689JFZDA1FjtMefwK6BrhDrHZGI7QrAv
         qQMnWJCKb4CCXR23ODsqP3qnkZC8AQ6HcZMotHkJfLy3v7L/vMbetVK/j/sVkKZmpcmd
         XZoXeLbkj2eguH72W1XQRyJ8RAFtf8+mWsWz6tkSBl2C6d2c5Auhasr7L+58vfdl1/1A
         z2QA==
X-Forwarded-Encrypted: i=1; AJvYcCVyEQ99BsgO+aT3czmZfIZojZgFq5XXwW2msN6FSkyEJi9N1f/gTitN61yDDS6fAQFjRRXRPCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6XEwT0BbFmZloto01UzTA2ytrP1mSmPSVtVZ0pXrwiCo/TYwR
	VwPlYmWndUB7QEus/lQasDnPWCiXxN1vuqV+BtkitvVY3xxf6BHU
X-Google-Smtp-Source: AGHT+IGC9zI6pNoHiihN4TO/ihfyFC+6H91m9Wl2c5+lxB3lvB9B8BKn0Cj6q5qI98JuNo/ezkdqlA==
X-Received: by 2002:a05:620a:40d2:b0:7af:cdd9:5905 with SMTP id af79cd13be357-7b11a36bd0dmr1928184385a.22.1728956088658;
        Mon, 14 Oct 2024 18:34:48 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1363c9663sm12091285a.125.2024.10.14.18.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 18:34:48 -0700 (PDT)
Date: Mon, 14 Oct 2024 21:34:47 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <670dc6b7a1cea_2e174229441@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241012040651.95616-3-kerneljasonxing@gmail.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-3-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v2 02/12] net-timestamp: open gate for
 bpf_setsockopt
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> For now, we support bpf_setsockopt only TX timestamps flags. Users
> can use something like this in bpf program to turn on the feature:
> 
> flags = SOF_TIMESTAMPING_TX_SCHED;
> bpf_setsockopt(skops, SOL_SOCKET, SO_TIMESTAMPING, &flags, sizeof(flags));
> 
> Later, I will support each Tx flags one by one based on this.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/net/sock.h |  2 ++
>  net/core/filter.c  | 27 +++++++++++++++++++++++++++
>  net/core/sock.c    | 35 ++++++++++++++++++++++++-----------
>  3 files changed, 53 insertions(+), 11 deletions(-)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 8cf278c957b3..66ecd78f1dfe 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2890,6 +2890,8 @@ void sock_def_readable(struct sock *sk);
>  
>  int sock_bindtoindex(struct sock *sk, int ifindex, bool lock_sk);
>  void sock_set_timestamp(struct sock *sk, int optname, bool valbool);
> +int sock_get_timestamping(struct so_timestamping *timestamping,
> +			  sockptr_t optval, unsigned int optlen);
>  int sock_set_timestamping(struct sock *sk, int optname,
>  			  struct so_timestamping timestamping);
>  
> diff --git a/net/core/filter.c b/net/core/filter.c
> index bd0d08bf76bb..996426095bd9 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5204,10 +5204,30 @@ static const struct bpf_func_proto bpf_get_socket_uid_proto = {
>  	.arg1_type      = ARG_PTR_TO_CTX,
>  };
>  
> +static int bpf_sock_set_timestamping(struct sock *sk,
> +				     struct so_timestamping *timestamping)
> +{
> +	u32 flags = timestamping->flags;
> +
> +	if (flags & ~SOF_TIMESTAMPING_MASK)
> +		return -EINVAL;
> +
> +	if (!(flags & (SOF_TIMESTAMPING_TX_SCHED | SOF_TIMESTAMPING_TX_SOFTWARE |
> +	      SOF_TIMESTAMPING_TX_ACK)))
> +		return -EINVAL;
> +
> +	WRITE_ONCE(sk->sk_tsflags[BPFPROG_TS_REQUESTOR], flags);
> +
> +	return 0;
> +}
> +
>  static int sol_socket_sockopt(struct sock *sk, int optname,
>  			      char *optval, int *optlen,
>  			      bool getopt)
>  {
> +	struct so_timestamping ts;
> +	int ret = 0;
> +
>  	switch (optname) {
>  	case SO_REUSEADDR:
>  	case SO_SNDBUF:
> @@ -5225,6 +5245,13 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
>  		break;
>  	case SO_BINDTODEVICE:
>  		break;
> +	case SO_TIMESTAMPING_NEW:
> +	case SO_TIMESTAMPING_OLD:
> +		ret = sock_get_timestamping(&ts, KERNEL_SOCKPTR(optval),
> +					    *optlen);
> +		if (!ret)
> +			ret = bpf_sock_set_timestamping(sk, &ts);
> +		return ret;
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 52c8c5a5ba27..a6e0d51a5f72 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -894,6 +894,27 @@ static int sock_timestamping_bind_phc(struct sock *sk, int phc_index)
>  	return 0;
>  }
>  
> +int sock_get_timestamping(struct so_timestamping *timestamping,
> +			  sockptr_t optval, unsigned int optlen)
> +{
> +	int val;
> +
> +	if (copy_from_sockptr(&val, optval, sizeof(val)))
> +		return -EFAULT;

Ideally don't read this again.

If you do, then move it in the else clause.

> +
> +	if (optlen == sizeof(*timestamping)) {
> +		if (copy_from_sockptr(timestamping, optval,
> +				      sizeof(*timestamping))) {
> +			return -EFAULT;
> +		}
> +	} else {
> +		memset(timestamping, 0, sizeof(*timestamping));
> +		timestamping->flags = val;
> +	}
> +
> +	return 0;
> +}
> +
>  int sock_set_timestamping(struct sock *sk, int optname,
>  			  struct so_timestamping timestamping)
>  {
> @@ -1402,17 +1423,9 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
>  
>  	case SO_TIMESTAMPING_NEW:
>  	case SO_TIMESTAMPING_OLD:
> -		if (optlen == sizeof(timestamping)) {
> -			if (copy_from_sockptr(&timestamping, optval,
> -					      sizeof(timestamping))) {
> -				ret = -EFAULT;
> -				break;
> -			}
> -		} else {
> -			memset(&timestamping, 0, sizeof(timestamping));
> -			timestamping.flags = val;
> -		}
> -		ret = sock_set_timestamping(sk, optname, timestamping);
> +		ret = sock_get_timestamping(&timestamping, optval, optlen);
> +		if (!ret)
> +			ret = sock_set_timestamping(sk, optname, timestamping);
>  		break;
>  
>  	case SO_RCVLOWAT:
> -- 
> 2.37.3
> 



