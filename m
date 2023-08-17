Return-Path: <bpf+bounces-8016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D5777FE56
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 21:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B432B282085
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 19:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7C21805C;
	Thu, 17 Aug 2023 19:08:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE88154B3;
	Thu, 17 Aug 2023 19:08:51 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63142D70;
	Thu, 17 Aug 2023 12:08:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7C65321853;
	Thu, 17 Aug 2023 19:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692299329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jgox/zl3coqkVq6gQr6F0Rvr1rOTV3VTU1eRiO0bmmM=;
	b=Ie5LkbT03bviX+r0VYA6eNsCtH+gX542hg35BAoMmvSYWDN7c6urBo9Ksh+kl5Tlm0Vs1K
	e0jiuwpS6sVIRDyQD45eUISa2ArPazUbOYgBvAeVTpSvVJ4+GNgfLI83fq3OCqCcfYgBBp
	BGoE4sDzwRWbOwCRTMYVxOi1xeN6gJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692299329;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jgox/zl3coqkVq6gQr6F0Rvr1rOTV3VTU1eRiO0bmmM=;
	b=PXDQfIJTELvrAl6u3MFsfMJulTmvpKVpZweG+FxayXne4SUDDExTV2Tvo6wBu3uBX9S2pC
	17B4ixJs3Nvnt+CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42A211358B;
	Thu, 17 Aug 2023 19:08:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id PMPsA0Fw3mRZPAAAMHmgww
	(envelope-from <krisman@suse.de>); Thu, 17 Aug 2023 19:08:49 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@google.com,  axboe@kernel.dk,  asml.silence@gmail.com,
  willemdebruijn.kernel@gmail.com,  martin.lau@linux.dev,
  bpf@vger.kernel.org,  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,  io-uring@vger.kernel.org,  kuba@kernel.org,
  pabeni@redhat.com
Subject: Re: [PATCH v3 8/9] io_uring/cmd: BPF hook for getsockopt cmd
In-Reply-To: <20230817145554.892543-9-leitao@debian.org> (Breno Leitao's
	message of "Thu, 17 Aug 2023 07:55:53 -0700")
References: <20230817145554.892543-1-leitao@debian.org>
	<20230817145554.892543-9-leitao@debian.org>
Date: Thu, 17 Aug 2023 15:08:47 -0400
Message-ID: <87pm3l32rk.fsf@suse.de>
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
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Breno Leitao <leitao@debian.org> writes:

> Add BPF hook support for getsockopts io_uring command. So, BPF cgroups
> programs can run when SOCKET_URING_OP_GETSOCKOPT command is executed
> through io_uring.
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
> index a567dd32df00..9e08a14760c3 100644
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
> @@ -184,17 +186,23 @@ static inline int io_uring_cmd_getsockopt(struct socket *sock,
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
> +	if (!(issue_flags & IO_URING_F_COMPAT))
> +		err = BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock->sk, level,
> +						     optname,
> +						     USER_SOCKPTR(optval),
> +						     KERNEL_SOCKPTR(&optlen),
> +						     optlen, err);
> +
> +	if (!err)
>  		return optlen;
> -	}

Shouldn't you call sock->ops->getsockopt for level!=SOL_SOCKET prior to
running the hook?  Before this patch, it would bail out with EOPNOTSUPP,
but now the bpf hook gets called even for level!=SOL_SOCKET, which
doesn't fit __sys_getsockopt. Am I misreading the code?

-- 
Gabriel Krisman Bertazi

