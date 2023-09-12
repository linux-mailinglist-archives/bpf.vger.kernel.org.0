Return-Path: <bpf+bounces-9694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68B379C13B
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 02:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69841C20AC8
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 00:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DF817D9;
	Tue, 12 Sep 2023 00:43:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74119138E;
	Tue, 12 Sep 2023 00:43:18 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AB618B8B4;
	Mon, 11 Sep 2023 17:21:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B6F732185A;
	Tue, 12 Sep 2023 00:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694478004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=miCkGFoxKxVBRFGfrRVmp7107zCZ87ZsGupuJ8/qi4I=;
	b=y+XJ5licnv6p4VsbMaYCCmjo88xpeuPolvb06IFTBaohmZvi/sfa6ct/tsx/rT903MwHja
	feieLTBbRrr7hs0PQAhssAyrPqBBQWX4zmAHc8gS4JuL7um1lHz3M+ZofnVQg4X0c7oJa6
	zntywi97zFwmCzO4Bh5EOVScVd7Yopo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694478004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=miCkGFoxKxVBRFGfrRVmp7107zCZ87ZsGupuJ8/qi4I=;
	b=gWiZ8WawDBD37dgffca3X5PwhwfGLc4J5xDCDY4r5blSjYZHqemjX9l8+4vwn4kc0fSi9z
	aQgqVsD/spaBrZAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F699139DB;
	Tue, 12 Sep 2023 00:20:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 3zaDGbSu/2StUQAAMHmgww
	(envelope-from <krisman@suse.de>); Tue, 12 Sep 2023 00:20:04 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@google.com,  axboe@kernel.dk,  asml.silence@gmail.com,
  willemdebruijn.kernel@gmail.com,  kuba@kernel.org,  martin.lau@linux.dev,
  bpf@vger.kernel.org,  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,  io-uring@vger.kernel.org,  pabeni@redhat.com
Subject: Re: [PATCH v5 5/8] io_uring/cmd: return -EOPNOTSUPP if net is disabled
In-Reply-To: <ZP9EeunfcbWos80w@gmail.com> (Breno Leitao's message of "Mon, 11
	Sep 2023 09:46:50 -0700")
Organization: SUSE
References: <20230911103407.1393149-1-leitao@debian.org>
	<20230911103407.1393149-6-leitao@debian.org> <87ledc904p.fsf@suse.de>
	<ZP9EeunfcbWos80w@gmail.com>
Date: Mon, 11 Sep 2023 20:20:03 -0400
Message-ID: <87jzsw5jkc.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Breno Leitao <leitao@debian.org> writes:

> On Mon, Sep 11, 2023 at 11:53:58AM -0400, Gabriel Krisman Bertazi wrote:
>> Breno Leitao <leitao@debian.org> writes:
>> 
>> > Protect io_uring_cmd_sock() to be called if CONFIG_NET is not set. If
>> > network is not enabled, but io_uring is, then we want to return
>> > -EOPNOTSUPP for any possible socket operation.
>> >
>> > This is helpful because io_uring_cmd_sock() can now call functions that
>> > only exits if CONFIG_NET is enabled without having #ifdef CONFIG_NET
>> > inside the function itself.
>> >
>> > Signed-off-by: Breno Leitao <leitao@debian.org>
>> > ---
>> >  io_uring/uring_cmd.c | 8 ++++++++
>> >  1 file changed, 8 insertions(+)
>> >
>> > diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
>> > index 60f843a357e0..a7d6a7d112b7 100644
>> > --- a/io_uring/uring_cmd.c
>> > +++ b/io_uring/uring_cmd.c
>> > @@ -167,6 +167,7 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
>> >  }
>> >  EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
>> >  
>> > +#if defined(CONFIG_NET)
>> >  int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
>> >  {
>> >  	struct socket *sock = cmd->file->private_data;
>> > @@ -193,3 +194,10 @@ int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
>> >  	}
>> >  }
>> >  EXPORT_SYMBOL_GPL(io_uring_cmd_sock);
>> > +#else
>> > +int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
>> > +{
>> > +	return -EOPNOTSUPP;
>> > +}
>> > +#endif
>> > +
>> 
>> Is net/socket.c even built without CONFIG_NET? if not, you don't even need
>> the alternative EOPNOTSUPP implementation.
>
> It seems so. net/socket.o is part of obj-y:
>
> https://github.com/torvalds/linux/blob/master/net/Makefile#L9

Yes. But also:

[0:cartola linux]$ grep 'net/' Kbuild
obj-$(CONFIG_NET)       += net/

I doubled checked and it should build fine without it.  Technically, you
also want to also guard the declaration in the header file, IMO, even if
it compiles fine.  Also, there is an extra blank line warning when applying
the patch but, surprisingly, checkpatch.pl seems to miss it.

-- 
Gabriel Krisman Bertazi

