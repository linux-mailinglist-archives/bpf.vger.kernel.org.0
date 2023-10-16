Return-Path: <bpf+bounces-12340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ECE7CB312
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 20:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F290281793
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 18:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E42339B2;
	Mon, 16 Oct 2023 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ufpjyZGe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+Rs73HKE"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75F830D1D;
	Mon, 16 Oct 2023 18:56:59 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9200B95;
	Mon, 16 Oct 2023 11:56:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1209921C8E;
	Mon, 16 Oct 2023 18:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1697482617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0E53cH1DZ1l9Ely009AkX8DhdKcgTVDFDGimcez8C88=;
	b=ufpjyZGeAyKi5GJSzP28xq0EkwVwOgXsBFH8ERtFHNYhIMHIVl6FCo71FPbzOa5fUTeymK
	J1aCi8Eees6D0hJjtVdDZPs6hsdvuK0Q5fuSmsBTgTgWN6pqV/JCzwkR4Q4OHBxFUGvAXM
	KI33qm0pYd8/6nwpeB62a+s27RvJdP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1697482617;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0E53cH1DZ1l9Ely009AkX8DhdKcgTVDFDGimcez8C88=;
	b=+Rs73HKE6JH5ANd+7EoiXjp7XRlArWWDblSjKvFhO2v5o5iD4st8v6s0bg3H60TOuyUZxs
	nw14HWn73IvfjZBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C882F133B7;
	Mon, 16 Oct 2023 18:56:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id B58LK3iHLWVPbAAAMHmgww
	(envelope-from <krisman@suse.de>); Mon, 16 Oct 2023 18:56:56 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@google.com,  axboe@kernel.dk,  asml.silence@gmail.com,
  willemdebruijn.kernel@gmail.com,  kuba@kernel.org,  pabeni@redhat.com,
  martin.lau@linux.dev,  bpf@vger.kernel.org,
  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org,
  io-uring@vger.kernel.org,  "Peter Zijlstra (Intel)"
 <peterz@infradead.org>,  Stefan Metzmacher <metze@samba.org>,  Josh
 Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH v7 06/11] tools headers: Grab copy of io_uring.h
In-Reply-To: <20231016134750.1381153-7-leitao@debian.org> (Breno Leitao's
	message of "Mon, 16 Oct 2023 06:47:44 -0700")
References: <20231016134750.1381153-1-leitao@debian.org>
	<20231016134750.1381153-7-leitao@debian.org>
Date: Mon, 16 Oct 2023 14:56:55 -0400
Message-ID: <87zg0i9z0o.fsf@>
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
	 BAYES_HAM(-0.01)[45.11%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-0.999];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 INVALID_MSGID(1.70)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 FREEMAIL_CC(0.00)[google.com,kernel.dk,gmail.com,kernel.org,redhat.com,linux.dev,vger.kernel.org,infradead.org,samba.org,joshtriplett.org]
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_MSGID,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Breno Leitao <leitao@debian.org> writes:

> This file will be used by mini_uring.h and allow tests to run without
> the need of installing liburing to run the tests.
>
> This is needed to run io_uring tests in BPF, such as
> (tools/testing/selftests/bpf/prog_tests/sockopt.c).
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Can't mini_uring rely on the kernel header like
selftests/net/io_uring_zerocopy_tx.c does?  That test doesn't depend on
liburing either.  I ask because this will be the third copy of these
definitions that we're gonna need to keep in sync (kernel, liburing and
here). Given this is only used for selftests, we better avoid the
duplication.

-- 
Gabriel Krisman Bertazi

