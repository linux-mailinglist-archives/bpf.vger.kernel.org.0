Return-Path: <bpf+bounces-7380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F253B77652D
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 18:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8EF281DB5
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 16:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D3D1B7F6;
	Wed,  9 Aug 2023 16:32:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224601D2E2;
	Wed,  9 Aug 2023 16:32:36 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F5710F3;
	Wed,  9 Aug 2023 09:32:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B52B71F390;
	Wed,  9 Aug 2023 16:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691598754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7QFcbq83iTfdOitDUN6evIcZyqpeTumZWQXVO5WSyTw=;
	b=w1WP5bAZE/zSuw7kqB93vtowYM7zVuuhl8Rc2SRSan8LvPe8Lfx2xAZ7f327XDzSDFoVOM
	HE+jCPblCOa+kKKjgT5n+lBklNdbXAIipUBF4mp0nnMwXIjyyl/C7J7fjSmb6FaNeYkO/b
	ZxPpcHNe2bgsaMb5k8sMMUurew7OBP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691598754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7QFcbq83iTfdOitDUN6evIcZyqpeTumZWQXVO5WSyTw=;
	b=5O/IJFSzRRrH1RkxV+y6NJZEypfhjSGMjUDCaG74+GsY1CDQkTgw5zNxPnqqCq1bWIWHNY
	XSDjMn6ZbnYO8CCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60335133B5;
	Wed,  9 Aug 2023 16:32:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id voffEaK/02TLZgAAMHmgww
	(envelope-from <krisman@suse.de>); Wed, 09 Aug 2023 16:32:34 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@google.com,  axboe@kernel.dk,  asml.silence@gmail.com,
  willemdebruijn.kernel@gmail.com,  bpf@vger.kernel.org,
  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org,
  io-uring@vger.kernel.org,  kuba@kernel.org,  pabeni@redhat.com
Subject: Re: [PATCH v2 4/8] io_uring/cmd: Extend support beyond SOL_SOCKET
In-Reply-To: <20230808134049.1407498-5-leitao@debian.org> (Breno Leitao's
	message of "Tue, 8 Aug 2023 06:40:44 -0700")
References: <20230808134049.1407498-1-leitao@debian.org>
	<20230808134049.1407498-5-leitao@debian.org>
Date: Wed, 09 Aug 2023 12:32:33 -0400
Message-ID: <871qgc89cu.fsf@suse.de>
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

> Add generic support for SOCKET_URING_OP_SETSOCKOPT, expanding the
> current case, that just execute if level is SOL_SOCKET.
>
> This implementation basically calls sock->ops->setsockopt() with a
> kernel allocated optval;
>
> Since the callback for ops->setsockopt() is already using sockptr_t,
> then the callbacks are leveraged to be called directly, similarly to
> __sys_setsockopt().
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  io_uring/uring_cmd.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> index 5404b788ca14..dbba005a7290 100644
> --- a/io_uring/uring_cmd.c
> +++ b/io_uring/uring_cmd.c
> @@ -205,10 +205,14 @@ static inline int io_uring_cmd_setsockopt(struct socket *sock,
>  	if (err)
>  		return err;
>  
> -	err = -EOPNOTSUPP;
>  	if (level == SOL_SOCKET && !sock_use_custom_sol_socket(sock))
>  		err = sock_setsockopt(sock, level, optname,
>  				      USER_SOCKPTR(optval), optlen);
> +	else if (unlikely(!sock->ops->setsockopt))
> +		err = -EOPNOTSUPP;
> +	else
> +		err = sock->ops->setsockopt(sock, level, optname,
> +					    USER_SOCKPTR(koptval), optlen);

Perhaps move this logic into a helper in net/ so io_uring doesn't need
to know details of struct socket and there is no duplication of this code
in __sys_getsockopt.

>  	return err;
>  }

-- 
Gabriel Krisman Bertazi

