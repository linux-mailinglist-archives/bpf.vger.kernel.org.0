Return-Path: <bpf+bounces-12335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5427CB28C
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 20:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCEA21C20B21
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 18:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C2F30CF8;
	Mon, 16 Oct 2023 18:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UTJrC6C3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S5UiA4Hq"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F07F34190;
	Mon, 16 Oct 2023 18:33:22 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A46A2;
	Mon, 16 Oct 2023 11:33:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9340E21941;
	Mon, 16 Oct 2023 18:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1697481195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QkCIkhPVNqzKHJQMduEVPWqZGb5aCwOZAMiw/zbXR9E=;
	b=UTJrC6C3SO/r3WQH6r5yJ9nuRF9VCxPuDyNRGuH7VkK9ichOpyY0/zEFJ5q4dn76WUhDx+
	JC/Py8aMsEHrlKqhR4bPyvmJ8trS0KaX3qS7sAFW2c/jBLLOzYbowPDIcMSAdXVO7vH2Nx
	Iy9FESfaLUjCH4c+60EgFHVZSFZjMsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1697481195;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QkCIkhPVNqzKHJQMduEVPWqZGb5aCwOZAMiw/zbXR9E=;
	b=S5UiA4Hq3Lwb/q9XN1YM7jBOWslZ3JKRi8PR5zmnZb7R7Xx5Q0Iz7zQafcSb645qj8DvhQ
	eKUMkLOW3a8z3rCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DE9C138EF;
	Mon, 16 Oct 2023 18:33:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id tLOLEeuBLWWWYQAAMHmgww
	(envelope-from <krisman@suse.de>); Mon, 16 Oct 2023 18:33:15 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@google.com,  axboe@kernel.dk,  asml.silence@gmail.com,
  willemdebruijn.kernel@gmail.com,  kuba@kernel.org,  pabeni@redhat.com,
  martin.lau@linux.dev,  bpf@vger.kernel.org,
  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org,
  io-uring@vger.kernel.org
Subject: Re: [PATCH v7 09/11] io_uring/cmd: Introduce
 SOCKET_URING_OP_GETSOCKOPT
In-Reply-To: <20231016134750.1381153-10-leitao@debian.org> (Breno Leitao's
	message of "Mon, 16 Oct 2023 06:47:47 -0700")
References: <20231016134750.1381153-1-leitao@debian.org>
	<20231016134750.1381153-10-leitao@debian.org>
Date: Mon, 16 Oct 2023 14:33:14 -0400
Message-ID: <87bkcybeol.fsf@>
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

> Add support for getsockopt command (SOCKET_URING_OP_GETSOCKOPT), where
> level is SOL_SOCKET. This is leveraging the sockptr_t infrastructure,
> where a sockptr_t is either userspace or kernel space, and handled as
> such.
>
> Differently from the getsockopt(2), the optlen field is not a userspace
> pointers. In getsockopt(2), userspace provides optlen pointer, which is
> overwritten by the kernel.  In this implementation, userspace passes a
> u32, and the new value is returned in cqe->res. I.e., optlen is not a
> pointer.
>
> Important to say that userspace needs to keep the pointer alive until
> the CQE is completed.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

I suspect you forgot to collect my previous r-b on this :).  Either way,
still good to me:

Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>

-- 
Gabriel Krisman Bertazi

