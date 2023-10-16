Return-Path: <bpf+bounces-12336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 063EF7CB28F
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 20:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99C4AB20E03
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 18:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCF3339AE;
	Mon, 16 Oct 2023 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DEEpborb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wSh31jxG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115EC3418A;
	Mon, 16 Oct 2023 18:33:45 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8471195;
	Mon, 16 Oct 2023 11:33:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2808521941;
	Mon, 16 Oct 2023 18:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1697481222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uh1d2YtOaoK7v9g+0MCKG7i4FzpumtsR1ohj9YLCVzo=;
	b=DEEpborbMwJOw2CqqeT0La1WoXpMB4iSb6jelaHeeahu0XJzJFc4zY/mmcJVBJIrShIlYO
	uDL9Cg8szjvn/RfRLYe/eJK7S9YbsArF9EVpxgAm61miLAsUOo0NZs58MmtINiSfJoIBP7
	VBKeG5xXaRG0zXb4resQO6GGJGyHzLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1697481222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uh1d2YtOaoK7v9g+0MCKG7i4FzpumtsR1ohj9YLCVzo=;
	b=wSh31jxG5lMPPxuJ7w2GOPeTptKgeW6wHgAL4qipnjs37aWKk3kaP8du+5Lu2cnpjVoqEg
	hVGYQcKXhptrB9BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E62FE138EF;
	Mon, 16 Oct 2023 18:33:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ZU3RMgWCLWW8YQAAMHmgww
	(envelope-from <krisman@suse.de>); Mon, 16 Oct 2023 18:33:41 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@google.com,  axboe@kernel.dk,  asml.silence@gmail.com,
  willemdebruijn.kernel@gmail.com,  kuba@kernel.org,  pabeni@redhat.com,
  martin.lau@linux.dev,  bpf@vger.kernel.org,
  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org,
  io-uring@vger.kernel.org
Subject: Re: [PATCH v7 10/11] io_uring/cmd: Introduce
 SOCKET_URING_OP_SETSOCKOPT
In-Reply-To: <20231016134750.1381153-11-leitao@debian.org> (Breno Leitao's
	message of "Mon, 16 Oct 2023 06:47:48 -0700")
References: <20231016134750.1381153-1-leitao@debian.org>
	<20231016134750.1381153-11-leitao@debian.org>
Date: Mon, 16 Oct 2023 14:33:40 -0400
Message-ID: <877cnmbenv.fsf@>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.40
X-Spamd-Result: default: False [-0.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.00)[32.44%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-0.998];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 INVALID_MSGID(1.70)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 FREEMAIL_CC(0.00)[google.com,kernel.dk,gmail.com,kernel.org,redhat.com,linux.dev,vger.kernel.org]
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_MSGID,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Breno Leitao <leitao@debian.org> writes:

> Add initial support for SOCKET_URING_OP_SETSOCKOPT. This new command is
> similar to setsockopt. This implementation leverages the function
> do_sock_setsockopt(), which is shared with the setsockopt() system call
> path.
>
> Important to say that userspace needs to keep the pointer's memory alive
> until the operation is completed. I.e, the memory could not be
> deallocated before the CQE is returned to userspace.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

likewise..

Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>

-- 
Gabriel Krisman Bertazi

