Return-Path: <bpf+bounces-9735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3251779CBFF
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 11:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1490A1C20AC8
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 09:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A395C168B5;
	Tue, 12 Sep 2023 09:37:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6B61643D
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 09:37:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA6A4E67
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 02:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694511454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lFvEVHqhU+e2PFkmxQBvXlSSPTjXEKHDQREd4bomtkc=;
	b=g8EZfN47Q1cMGJdReujitw894+iz2FdLBdo1H6QGZ1siLJynjSNuKMx9olUUERUe22rGnx
	76nTySlQlxDMJE6vVzQHgRLuIt4RzfhyS0WcPcc/9AvouIjb7FqG/+JMG54r+l4/GhdmWW
	UuBImYgmp539m2ya9bG7kpWFdWpqFTQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-DbGAVkaDPDao8JRHGnd3ZA-1; Tue, 12 Sep 2023 05:37:33 -0400
X-MC-Unique: DbGAVkaDPDao8JRHGnd3ZA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-502c8388d97so296845e87.1
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 02:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694511451; x=1695116251;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lFvEVHqhU+e2PFkmxQBvXlSSPTjXEKHDQREd4bomtkc=;
        b=SzRoLO+R+qiJN5PKwvZpXCaSDZDECEJswB2jc653PBCQa+3E0K5e2/mW+mryhlH+xu
         NzTmdR4Ana5y1hnuVKm3wdORNzvL53Zv/5ZUloLWUUXdj6cA6mVXoS26IHbBKcPQWKfN
         kdiaKdN8emGAlniP3afNS0F/1IIPlhzN940qggWT3WnA4DrBWeHFMtoWs/WcNZboNd12
         tEvfmMUCkXEqgaBl4RUJh5hRAGXtsg2Fz2g85zLTpb0Sm6M4rLOOEtMLKKC2Nbd8YA0s
         CfGKcDAoz4zwGNS5J8TRIC9znM1BDeoN4HGFvFb/s3cDcWEWsWQQEoxJhVJ3WKLxPdC/
         eGGg==
X-Gm-Message-State: AOJu0Yw5CDK8ocl3hf5atOKJsO32QKBgsL8QJt9HXKA33lU/pNEWdhmz
	FBaETD9r/WN8yoTuRpxDZ2Ohk3wOZtzTMBtcu9m7ajLQ2xJ7lFCHMM2TxlI80DlUETc1+jrQOOH
	8RWylaEFtph/a4/3W6YxF
X-Received: by 2002:a19:7402:0:b0:501:c223:fa22 with SMTP id v2-20020a197402000000b00501c223fa22mr7676656lfe.6.1694511451699;
        Tue, 12 Sep 2023 02:37:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd1bL9Eqlc/wzr89p1BVJNrnI+WoJPE61CRSC3Rf2uCQyoF3lLczz77hzK19iwY/RrIkkchg==
X-Received: by 2002:a19:7402:0:b0:501:c223:fa22 with SMTP id v2-20020a197402000000b00501c223fa22mr7676633lfe.6.1694511451290;
        Tue, 12 Sep 2023 02:37:31 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-231.dyn.eolo.it. [146.241.249.231])
        by smtp.gmail.com with ESMTPSA id w20-20020a1709064a1400b00991faf3810esm6640960eju.146.2023.09.12.02.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 02:37:30 -0700 (PDT)
Message-ID: <e90e954cf5f75ca301c19f9b16add93d3811547c.camel@redhat.com>
Subject: Re: [PATCH v5 2/8] net/socket: Break down __sys_getsockopt
From: Paolo Abeni <pabeni@redhat.com>
To: Breno Leitao <leitao@debian.org>, sdf@google.com, axboe@kernel.dk, 
 asml.silence@gmail.com, willemdebruijn.kernel@gmail.com, kuba@kernel.org, 
 martin.lau@linux.dev, krisman@suse.de, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org,  io-uring@vger.kernel.org
Date: Tue, 12 Sep 2023 11:37:29 +0200
In-Reply-To: <20230911103407.1393149-3-leitao@debian.org>
References: <20230911103407.1393149-1-leitao@debian.org>
	 <20230911103407.1393149-3-leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-09-11 at 03:34 -0700, Breno Leitao wrote:
> Split __sys_getsockopt() into two functions by removing the core
> logic into a sub-function (do_sock_getsockopt()). This will avoid
> code duplication when executing the same operation in other callers, for
> instance.
>=20
> do_sock_getsockopt() will be called by io_uring getsockopt() command
> operation in the following patch.
>=20
> Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/net/sock.h |  3 +++
>  net/socket.c       | 51 ++++++++++++++++++++++++++++------------------
>  2 files changed, 34 insertions(+), 20 deletions(-)
>=20
> diff --git a/include/net/sock.h b/include/net/sock.h
> index aa8fb54ad0af..fbd568a43d28 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1863,6 +1863,9 @@ int sock_setsockopt(struct socket *sock, int level,=
 int op,
>  		    sockptr_t optval, unsigned int optlen);
>  int do_sock_setsockopt(struct socket *sock, bool compat, int level,
>  		       int optname, char __user *user_optval, int optlen);
> +int do_sock_getsockopt(struct socket *sock, bool compat, int level,
> +		       int optname, char __user *user_optval,
> +		       int __user *user_optlen);
> =20
>  int sk_getsockopt(struct sock *sk, int level, int optname,
>  		  sockptr_t optval, sockptr_t optlen);
> diff --git a/net/socket.c b/net/socket.c
> index 360332e098d4..3ec779a56f79 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2333,28 +2333,17 @@ SYSCALL_DEFINE5(setsockopt, int, fd, int, level, =
int, optname,
>  INDIRECT_CALLABLE_DECLARE(bool tcp_bpf_bypass_getsockopt(int level,
>  							 int optname));
> =20
> -/*
> - *	Get a socket option. Because we don't know the option lengths we have
> - *	to pass a user mode parameter for the protocols to sort out.
> - */
> -int __sys_getsockopt(int fd, int level, int optname, char __user *optval=
,
> -		int __user *optlen)
> +int do_sock_getsockopt(struct socket *sock, bool compat, int level,
> +		       int optname, char __user *optval,
> +		       int __user *optlen)
>  {
>  	int max_optlen __maybe_unused;
>  	const struct proto_ops *ops;
> -	int err, fput_needed;
> -	struct socket *sock;
> -
> -	sock =3D sockfd_lookup_light(fd, &err, &fput_needed);
> -	if (!sock)
> -		return err;
> +	int err;
> =20
>  	err =3D security_socket_getsockopt(sock, level, optname);
>  	if (err)
> -		goto out_put;
> -
> -	if (!in_compat_syscall())
> -		max_optlen =3D BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
> +		return err;
> =20
>  	ops =3D READ_ONCE(sock->ops);
>  	if (level =3D=3D SOL_SOCKET)
> @@ -2362,14 +2351,36 @@ int __sys_getsockopt(int fd, int level, int optna=
me, char __user *optval,
>  	else if (unlikely(!ops->getsockopt))
>  		err =3D -EOPNOTSUPP;
>  	else
> -		err =3D ops->getsockopt(sock, level, optname, optval,
> -					    optlen);
> +		err =3D ops->getsockopt(sock, level, optname, optval, optlen);
> =20
> -	if (!in_compat_syscall())
> +	if (!compat) {
> +		max_optlen =3D BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
>  		err =3D BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock->sk, level, optname,
>  						     optval, optlen, max_optlen,
>  						     err);
> -out_put:
> +	}
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(do_sock_getsockopt);
> +
> +/*	Get a socket option. Because we don't know the option lengths we have
> + *	to pass a user mode parameter for the protocols to sort out.
> + */
> +int __sys_getsockopt(int fd, int level, int optname, char __user *optval=
,
> +		     int __user *optlen)
> +{
> +	int err, fput_needed;
> +	bool compat =3D in_compat_syscall();
> +	struct socket *sock;

Please respect the reverse x-mas tree order, thanks!

Paolo


