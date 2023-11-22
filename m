Return-Path: <bpf+bounces-15637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0213F7F4411
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 11:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B170128159D
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 10:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165773E487;
	Wed, 22 Nov 2023 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uWzO5A9x"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C76693;
	Wed, 22 Nov 2023 02:41:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF46521961;
	Wed, 22 Nov 2023 10:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1700649666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6kSomUq3ZgKD9Dy04ZZVsli1peGLtP7gkcJ/caQ/Ogw=;
	b=uWzO5A9xEDIEYoWmSXMXHUWo7vnjLVJPopQxOm/IJeUt0FjiDe0bGnYS7kWRz7fShbr+22
	XjLqlF14nZbgecSPqMVT/lyoUGnE7wITx8wmm0kwFIIJaUW91mm5UEZ6YhDTdgJQkkTRsU
	x65avsS0HGJH0F1/MQw7aqoBkBowMw0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74C19139FD;
	Wed, 22 Nov 2023 10:41:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 78ipG8LaXWWdGwAAMHmgww
	(envelope-from <mkoutny@suse.com>); Wed, 22 Nov 2023 10:41:06 +0000
Date: Wed, 22 Nov 2023 11:41:05 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Petr Pavlu <ppavlu@suse.cz>, Michal Kubecek <mkubecek@suse.cz>, 
	Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH] net/sched: cls: Load net classifier modules via alias
Message-ID: <yerqczxbz6qlrslkfbu6u2emb5esqe7tkrexdbneite2ah2a6i@l6arp7nzyj75>
References: <20231121175640.9981-1-mkoutny@suse.com>
 <CAM0EoM=id7xo1=F5SY2f+hy8a8pkXQ5a0xNJ+JKd9e6o=--RQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hvfgyyhk2fzdpfpi"
Content-Disposition: inline
In-Reply-To: <CAM0EoM=id7xo1=F5SY2f+hy8a8pkXQ5a0xNJ+JKd9e6o=--RQg@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -8.25
X-Spamd-Result: default: False [-8.25 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 REPLY(-4.00)[];
	 BAYES_HAM(-2.85)[99.34%];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[24];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,suse.cz,suse.com];
	 RCVD_COUNT_TWO(0.00)[2];
	 SUSPICIOUS_RECIPS(1.50)[]


--hvfgyyhk2fzdpfpi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 21, 2023 at 05:37:37PM -0500, Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> What's speacial about the "tcf- '' that makes it work
> better for filtering than existing "cls_" prefix?

tcf-foo is an alias.
cls_foo is the canonical name of the kernel module.

request_module() + blacklist (as described in modprobe.d(5)) works only
when calling with the alias. The actual string is not important, being
an alias is the crux.

> What about actions (prefix "act_") etc?

I focused only on "cls_" for the first iteration. Do you want me to look
at other analogous loads?

Thanks,
Michal

--hvfgyyhk2fzdpfpi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZV3arwAKCRAGvrMr/1gc
jkwzAQDHQdxXiLSK9txPaG5n5I1nu0X31MhXkwtgeqnEsbGX6gD+IXMKMqFV4nxO
NvX00/KWQgqRxpCHccYwaoAj7w4rgAc=
=Wm5L
-----END PGP SIGNATURE-----

--hvfgyyhk2fzdpfpi--

