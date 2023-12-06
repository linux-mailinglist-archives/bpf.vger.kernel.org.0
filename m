Return-Path: <bpf+bounces-16946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B774807BA9
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 23:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410282824DD
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 22:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718281A709;
	Wed,  6 Dec 2023 22:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nexB1Co3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A5718D;
	Wed,  6 Dec 2023 14:49:18 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D79221D58;
	Wed,  6 Dec 2023 22:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701902957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XDqpg+LUdyOlEWaBHsub44B0wZvESYFrEQIjfsMYOcQ=;
	b=nexB1Co3kCo16eDdcRZbb3sDYY7j4Z69EWGxdzZAgFwlsNG4nCUKukmwMMoezEqTacJFC/
	cal/QC5PdQXJxX4IMpYvSGkyV83dGAwRAgVOKecuLfvRVBZAagyGtrRcXejEz8xa5AAcVU
	y8XM2i6nkKOkooimHA7rzwv/RuBIt/U=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E01313403;
	Wed,  6 Dec 2023 22:49:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id yN7CEGz6cGWIDAAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Wed, 06 Dec 2023 22:49:16 +0000
Date: Wed, 6 Dec 2023 23:49:14 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Pedro Tammela <pctammela@mojatatu.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, cake@lists.bufferbloat.net, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Petr Pavlu <ppavlu@suse.cz>, Michal Kubecek <mkubecek@suse.cz>, 
	Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH 0/3] net/sched: Load modules via alias
Message-ID: <53ohvb547tegxv2vuvurhuwqunamfiy22sonog7gll54h3czht@3dnijc44xilq>
References: <20231206192752.18989-1-mkoutny@suse.com>
 <7789659d-b3c5-4eef-af86-540f970102a4@mojatatu.com>
 <vk6uhf4r2turfxt2aokp66x5exzo5winal55253czkl2pmkkuu@77bhdfwfk5y3>
 <20231206142857.38403344@hermes.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="66n2qidccontofol"
Content-Disposition: inline
In-Reply-To: <20231206142857.38403344@hermes.local>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.45
X-Spamd-Result: default: False [-1.45 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.05)[59.33%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_TWELVE(0.00)[29];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[mojatatu.com,vger.kernel.org,lists.bufferbloat.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,iogearbox.net,linux.dev,toke.dk,intel.com,suse.cz,suse.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]


--66n2qidccontofol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 06, 2023 at 02:28:57PM -0800, Stephen Hemminger <stephen@networkplumber.org> wrote:
> It is not clear to me what this patchset is trying to fix.
> Autoloading happens now, but it does depend on the name not alias.

There are some more details in the thread of v1 [1] [2].
Does it clarify?

Thanks,
Michal

[1] https://lore.kernel.org/r/yerqczxbz6qlrslkfbu6u2emb5esqe7tkrexdbneite2ah2a6i@l6arp7nzyj75/
[2] Oh, I realize I forgot to add v2 to today's posting.



--66n2qidccontofol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZXD6YQAKCRAGvrMr/1gc
jqKFAQDa7o9BcCuJ6Pa60x4aCDwIHPwW8c0plGxYwzl/GytgSwEA69HAX+Do+75V
ojElrep1jaK+lwg9eIeAo2Oof7/dTwM=
=i4t/
-----END PGP SIGNATURE-----

--66n2qidccontofol--

