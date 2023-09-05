Return-Path: <bpf+bounces-9247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E627922AB
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 14:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBC42811D7
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 12:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EE6D2FC;
	Tue,  5 Sep 2023 12:32:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D1C101E1;
	Tue,  5 Sep 2023 12:32:23 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D760E1A8;
	Tue,  5 Sep 2023 05:32:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 97B7821A15;
	Tue,  5 Sep 2023 12:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1693917136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ySKOzKRhLxYxgmPuW7PEIWS3Ad71H0naGt3Q1rkzjYI=;
	b=G4zJ9JpngSyrlT33LqTuRu8lChiXlisPFWLxKCx0LuE3ZaSG1+WZ80ei5NQDpbHDavMuwl
	13tet6G/HEHMJ9q5XfsAqnhjwudoQVD/+6n0Jh8uqR49VSiCGMZGYyRhkTAsM6XeqwDHGI
	Ilm+UscvCHyf/7PIw2nODZzD/tfVIT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1693917136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ySKOzKRhLxYxgmPuW7PEIWS3Ad71H0naGt3Q1rkzjYI=;
	b=hSPcw9xTytibfGmI51steO9u0QUN6n8erX8fcX1vU/XeH7rDFC+ObiF+83vkmnqQ4zfVt/
	ke2tcLcf3FOKvoAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6060513911;
	Tue,  5 Sep 2023 12:32:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id +dHJEdAf92RsFwAAMHmgww
	(envelope-from <krisman@suse.de>); Tue, 05 Sep 2023 12:32:16 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@google.com,  axboe@kernel.dk,  asml.silence@gmail.com,
  willemdebruijn.kernel@gmail.com,  martin.lau@linux.dev,
  bpf@vger.kernel.org,  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,  io-uring@vger.kernel.org,  kuba@kernel.org,
  pabeni@redhat.com
Subject: Re: [PATCH v4 07/10] io_uring/cmd: return -EOPNOTSUPP if net is
 disabled
In-Reply-To: <20230904162504.1356068-8-leitao@debian.org> (Breno Leitao's
	message of "Mon, 4 Sep 2023 09:25:00 -0700")
Organization: SUSE
References: <20230904162504.1356068-1-leitao@debian.org>
	<20230904162504.1356068-8-leitao@debian.org>
Date: Tue, 05 Sep 2023 08:32:15 -0400
Message-ID: <871qfcby28.fsf@suse.de>
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
> index 60f843a357e0..6a91e1af7d05 100644
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
> @@ -192,4 +193,11 @@ int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
>  		return -EOPNOTSUPP;
>  	}
>  }
> +#else
> +int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
> +
>  EXPORT_SYMBOL_GPL(io_uring_cmd_sock);

It doesn't make much sense to export the symbol on the !CONFIG_NET case.
Usually, you'd make it a 'static inline' in the header file (even though
it won't be ever inlined in this case):

in include/linux/io_uring.h:

#if defined(CONFIG_NET)
int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags);
#else
static inline int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
{
	return -EOPNOTSUPP;
}
#endif

But this is a minor detail. I'd say to consider doing it if you end up doing
another spin of the patchset.  Other than that, looks good to me.

Thanks,

-- 
Gabriel Krisman Bertazi

