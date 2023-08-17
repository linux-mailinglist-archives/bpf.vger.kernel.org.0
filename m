Return-Path: <bpf+bounces-8014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D0577FDFA
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 20:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE921C214EE
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 18:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D0E174D2;
	Thu, 17 Aug 2023 18:38:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C563239;
	Thu, 17 Aug 2023 18:38:59 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4133AB7;
	Thu, 17 Aug 2023 11:38:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EDA212185F;
	Thu, 17 Aug 2023 18:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692297528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xiRLnWYooWdIse820sUkn3VOskBnTLuUjpNFT0aca9A=;
	b=xXQBljOhpGUYUdIAM2snwHchjIJcRKxh2WSkKbzoCROp7glu49dqSlslONL4Xj6SKzYUl8
	LYfbTRuwYfn0Z6Rxe3aqAAIEniz37WZTuUg5erHnqtPGBOvdIOswhYYakdx9h140Vz9vkk
	w6CJEr84wwdOPFM9J4ZeZYjItwIm7sI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692297528;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xiRLnWYooWdIse820sUkn3VOskBnTLuUjpNFT0aca9A=;
	b=BLrE5EHyIFHBOzEPUzpJHXObnqJqzU+c4bj8RR0I/52qH2n2XSLEsDCXAUDzDjIkoHtF2J
	Z7KT1eP5u1LdD9DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B15FC1358B;
	Thu, 17 Aug 2023 18:38:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id bB9VIjhp3mRvLQAAMHmgww
	(envelope-from <krisman@suse.de>); Thu, 17 Aug 2023 18:38:48 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@google.com,  axboe@kernel.dk,  asml.silence@gmail.com,
  willemdebruijn.kernel@gmail.com,  martin.lau@linux.dev,
  bpf@vger.kernel.org,  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,  io-uring@vger.kernel.org,  kuba@kernel.org,
  pabeni@redhat.com
Subject: Re: [PATCH v3 6/9] io_uring/cmd: Introduce SOCKET_URING_OP_GETSOCKOPT
In-Reply-To: <20230817145554.892543-7-leitao@debian.org> (Breno Leitao's
	message of "Thu, 17 Aug 2023 07:55:51 -0700")
Organization: SUSE
References: <20230817145554.892543-1-leitao@debian.org>
	<20230817145554.892543-7-leitao@debian.org>
Date: Thu, 17 Aug 2023 14:38:46 -0400
Message-ID: <87zg2p345l.fsf@suse.de>
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

> +#if defined(CONFIG_NET)
>  int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
>  {
>  	struct socket *sock = cmd->file->private_data;
> @@ -189,8 +219,16 @@ int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
>  		if (ret)
>  			return ret;
>  		return arg;
> +	case SOCKET_URING_OP_GETSOCKOPT:
> +		return io_uring_cmd_getsockopt(sock, cmd, issue_flags);
>  	default:
>  		return -EOPNOTSUPP;
>  	}
>  }
> +#else
> +int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
>  EXPORT_SYMBOL_GPL(io_uring_cmd_sock);

The CONFIG_NET guards are unrelated and need to go in a separate commit.
Specially because it is not only gating getsockopt, but also the already
merged SOCKET_URING_OP_SIOCINQ/_OP_SIOCOUTQ.

-- 
Gabriel Krisman Bertazi

