Return-Path: <bpf+bounces-9664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FD879A9FF
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 17:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652231C20B23
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 15:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4781A125C2;
	Mon, 11 Sep 2023 15:54:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108FE11C80;
	Mon, 11 Sep 2023 15:54:02 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221B4193;
	Mon, 11 Sep 2023 08:54:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D02C021858;
	Mon, 11 Sep 2023 15:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694447639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w1hU2rySzchPvfa0Wrv+/KzNAllK1m5RVyNxjuW0p78=;
	b=P/ihoVSGa95xiemo3MTPD96SZx5qps7CdKbeHaotHJ6dKb/WrX1hQ8UmJu5t30xLUrQkdf
	ZaMsiNXgVEyNOHEQYTMGlkEz/CaYvaoXL2hK56fFN8mlphFYmgk8/f+oxK8saKV1VYUsju
	E0zpK/64S1G4tobdIazXal9MXF+1ar8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694447639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w1hU2rySzchPvfa0Wrv+/KzNAllK1m5RVyNxjuW0p78=;
	b=hz1uI0y1MedAGwyeWiiY5Eh+W+SEWc3LQ//38EsqFtkHMtSJe2vSwvuhfRefgC/GZIaKTR
	D4LHrr/4TDlgi8Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9920013780;
	Mon, 11 Sep 2023 15:53:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id kmfoHxc4/2S/dwAAMHmgww
	(envelope-from <krisman@suse.de>); Mon, 11 Sep 2023 15:53:59 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@google.com,  axboe@kernel.dk,  asml.silence@gmail.com,
  willemdebruijn.kernel@gmail.com,  kuba@kernel.org,  martin.lau@linux.dev,
  bpf@vger.kernel.org,  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,  io-uring@vger.kernel.org,  pabeni@redhat.com
Subject: Re: [PATCH v5 5/8] io_uring/cmd: return -EOPNOTSUPP if net is disabled
In-Reply-To: <20230911103407.1393149-6-leitao@debian.org> (Breno Leitao's
	message of "Mon, 11 Sep 2023 03:34:04 -0700")
Organization: SUSE
References: <20230911103407.1393149-1-leitao@debian.org>
	<20230911103407.1393149-6-leitao@debian.org>
Date: Mon, 11 Sep 2023 11:53:58 -0400
Message-ID: <87ledc904p.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Breno Leitao <leitao@debian.org> writes:

> Protect io_uring_cmd_sock() to be called if CONFIG_NET is not set. If
> network is not enabled, but io_uring is, then we want to return
> -EOPNOTSUPP for any possible socket operation.
>
> This is helpful because io_uring_cmd_sock() can now call functions that
> only exits if CONFIG_NET is enabled without having #ifdef CONFIG_NET
> inside the function itself.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  io_uring/uring_cmd.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> index 60f843a357e0..a7d6a7d112b7 100644
> --- a/io_uring/uring_cmd.c
> +++ b/io_uring/uring_cmd.c
> @@ -167,6 +167,7 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
>  }
>  EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
>  
> +#if defined(CONFIG_NET)
>  int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
>  {
>  	struct socket *sock = cmd->file->private_data;
> @@ -193,3 +194,10 @@ int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
>  	}
>  }
>  EXPORT_SYMBOL_GPL(io_uring_cmd_sock);
> +#else
> +int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
> +

Is net/socket.c even built without CONFIG_NET? if not, you don't even need
the alternative EOPNOTSUPP implementation.

-- 
Gabriel Krisman Bertazi

