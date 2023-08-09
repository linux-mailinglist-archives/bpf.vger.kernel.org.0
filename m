Return-Path: <bpf+bounces-7383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521C977655E
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 18:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877E4281D99
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 16:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60781BB3D;
	Wed,  9 Aug 2023 16:46:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACA918C2E;
	Wed,  9 Aug 2023 16:46:31 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FD81BF7;
	Wed,  9 Aug 2023 09:46:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5673021866;
	Wed,  9 Aug 2023 16:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691599589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6rO3bUwCxHrhMQ/KnyWVceX9aLTMN6xCVxviePeeskU=;
	b=txUbbjWI5xw5IUefZ5+yIFbM4fAhuTkdbK68tmd9ICSYbBAuJ++hpQQg6rxjeL0n2VXzel
	zj2aZuTBkvwIOmCjEr7Y6at53HwZkrlpX/bcUlaDc/gM1tsNuSrUwU9J3XXEPKaw0XSmPn
	3biEZDSHLsaLDk4yVAXY3G/xW3CIDBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691599589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6rO3bUwCxHrhMQ/KnyWVceX9aLTMN6xCVxviePeeskU=;
	b=D6SVisjaDadmt9fliy1dxxoVcIW1VNppOcFZSit1E54dGhJ4h7QqGkljwSTY9FmUIB0Oy3
	6rqA/qJDBVQvv/BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1562F133B5;
	Wed,  9 Aug 2023 16:46:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id UXouO+TC02SQbAAAMHmgww
	(envelope-from <krisman@suse.de>); Wed, 09 Aug 2023 16:46:28 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@google.com,  axboe@kernel.dk,  asml.silence@gmail.com,
  willemdebruijn.kernel@gmail.com,  bpf@vger.kernel.org,
  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org,
  io-uring@vger.kernel.org,  kuba@kernel.org,  pabeni@redhat.com
Subject: Re: [PATCH v2 7/8] io_uring/cmd: BPF hook for getsockopt cmd
In-Reply-To: <20230808134049.1407498-8-leitao@debian.org> (Breno Leitao's
	message of "Tue, 8 Aug 2023 06:40:47 -0700")
References: <20230808134049.1407498-1-leitao@debian.org>
	<20230808134049.1407498-8-leitao@debian.org>
Date: Wed, 09 Aug 2023 12:46:27 -0400
Message-ID: <87wmy46u58.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Breno Leitao <leitao@debian.org> writes:

> Add BPF hooks support for getsockopts io_uring command. So, bpf cgroups
> programs can run when SOCKET_URING_OP_GETSOCKOPT command is called.
>
> This implementation follows a similar approach to what
> __sys_getsockopt() does, but, using USER_SOCKPTR() for optval instead of
> kernel pointer.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  io_uring/uring_cmd.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> index dbba005a7290..3693e5779229 100644
> --- a/io_uring/uring_cmd.c
> +++ b/io_uring/uring_cmd.c
> @@ -5,6 +5,8 @@
>  #include <linux/io_uring.h>
>  #include <linux/security.h>
>  #include <linux/nospec.h>
> +#include <linux/compat.h>
> +#include <linux/bpf-cgroup.h>
>  
>  #include <uapi/linux/io_uring.h>
>  #include <uapi/asm-generic/ioctls.h>
> @@ -179,17 +181,23 @@ static inline int io_uring_cmd_getsockopt(struct socket *sock,
>  	if (err)
>  		return err;
>  
> -	if (level == SOL_SOCKET) {
> +	err = -EOPNOTSUPP;
> +	if (level == SOL_SOCKET)
>  		err = sk_getsockopt(sock->sk, level, optname,
>  				    USER_SOCKPTR(optval),
>  				    KERNEL_SOCKPTR(&optlen));
> -		if (err)
> -			return err;
>  
> +	if (!in_compat_syscall())
> +		err = BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock->sk, level,
> +						     optname,
> +						     USER_SOCKPTR(optval),
> +						     KERNEL_SOCKPTR(&optlen),
> +						     optlen, err);

I'm not sure if it makes sense to use in_compat_syscall() here.  Can't
this be invoked in a ring with ctx->compat set, but from outside a
compat syscall context (i.e. from sqpoll or even a !compat
io_uring_enter syscall)? I suspect you might need to check ctx->compact
instead, but I'm not sure. Did you consider that?

> +
> +	if (!err)
>  		return optlen;
> -	}
>  
> -	return -EOPNOTSUPP;
> +	return err;
>  }
>  
>  static inline int io_uring_cmd_setsockopt(struct socket *sock,

-- 
Gabriel Krisman Bertazi

