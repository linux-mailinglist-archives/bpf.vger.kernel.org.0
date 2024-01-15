Return-Path: <bpf+bounces-19524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595A582D8CA
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 13:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E8331C212FB
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 12:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5F22C6A6;
	Mon, 15 Jan 2024 12:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LjOF42nU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LjOF42nU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06C42C699;
	Mon, 15 Jan 2024 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BEC801F84E;
	Mon, 15 Jan 2024 12:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705321015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xcBuIksqeddwzDRn2EfzHYBcKJWb6r0wGsUV/u7lfA4=;
	b=LjOF42nUhYCQyNhjwxSDZcbTbPnEII5drs0yggelA/qOje17Ug0GcszOPYCzpH39zJlbmA
	+dNbQ8hYqP1jaLTCmAAQSCWX0C91wEwj05xz0tbHRMFSkkiWcfamj9MF5i56G/q6ASiabG
	LEXc/nw2/aCHYrtpXm0rbRqoz98fE5c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705321015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xcBuIksqeddwzDRn2EfzHYBcKJWb6r0wGsUV/u7lfA4=;
	b=LjOF42nUhYCQyNhjwxSDZcbTbPnEII5drs0yggelA/qOje17Ug0GcszOPYCzpH39zJlbmA
	+dNbQ8hYqP1jaLTCmAAQSCWX0C91wEwj05xz0tbHRMFSkkiWcfamj9MF5i56G/q6ASiabG
	LEXc/nw2/aCHYrtpXm0rbRqoz98fE5c=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68D66132FA;
	Mon, 15 Jan 2024 12:16:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X9suGTcipWXUSgAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Mon, 15 Jan 2024 12:16:55 +0000
Date: Mon, 15 Jan 2024 13:16:54 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, cake@lists.bufferbloat.net, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Stephen Hemminger <stephen@networkplumber.org>, 
	Petr Pavlu <ppavlu@suse.cz>, Michal Kubecek <mkubecek@suse.cz>, 
	Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH v3 1/4] net/sched: Add helper macros with module names
Message-ID: <hjq6ce7stwsvkpsgnk6hakroctokduw7mgout6oyeyt6okokgj@huhmqx2755ff>
References: <20240112180646.13232-1-mkoutny@suse.com>
 <20240112180646.13232-2-mkoutny@suse.com>
 <d570871f-1b59-4d75-a473-b3b0a21fe6c2@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5surq3w7pmvniitm"
Content-Disposition: inline
In-Reply-To: <d570871f-1b59-4d75-a473-b3b0a21fe6c2@mojatatu.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=LjOF42nU
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.21 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLhcw5w5rtick65589d1tggrs1)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 SIGNED_PGP(-2.00)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 BAYES_HAM(-0.60)[81.81%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[29];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,lists.bufferbloat.net,davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,gmail.com,resnulli.us,iogearbox.net,linux.dev,toke.dk,intel.com,networkplumber.org,suse.cz,suse.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -2.21
X-Rspamd-Queue-Id: BEC801F84E
X-Spam-Flag: NO


--5surq3w7pmvniitm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 03:38:34PM -0300, Pedro Tammela <pctammela@mojatatu=
=2Ecom> wrote:
> request_module(TC_CLS_ALIAS_PREFIX "%s", cls_name);

Yeah, that would be more systemic without proliferating literal strings.

> Would look better. In any case, net-next is currently closed. You will ne=
ed
> to repost once it reopens.
>=20
> It seems you are also missing a rebase. We recently removed act_ipt :).

I see, I rebased only on torvalds/master then (commit de927f6c0b07
("Merge tag 's390-6.8-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux")).
I'm not familiar with netdev tree, I will post after Jan 22 as
suggested.

Thanks,
Michal

--5surq3w7pmvniitm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZaUiNAAKCRAGvrMr/1gc
joKcAQD6yZsniLleSd4IMIop4YCU01zNNd4RVQqk9P/iGC9iRQEAmNK9zIQqjaIo
FO23i1EHvkh9LUJw1tfsRuw+z5tleQo=
=EIJ0
-----END PGP SIGNATURE-----

--5surq3w7pmvniitm--

