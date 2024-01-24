Return-Path: <bpf+bounces-20229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A3B83AACD
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 14:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10D451C22D17
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 13:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083DC77F0F;
	Wed, 24 Jan 2024 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bz6kD9qW";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bz6kD9qW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8B5199D9;
	Wed, 24 Jan 2024 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706102357; cv=none; b=M3B/izpafJH1nucHSTicXYVCPHFcN0yq23tJruNMfhy7u3UZMlJ6H9DEFfQWRhY5iWlcrr6M61ys8Fowyn+/k0JNFzzmIMKbEccEEgnrYyPGpE+X4PpoOynGt2i4jbaBuoXSZJFTF1SLLBexk1xid3kgL+FXyW8PZV4CLxO8XSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706102357; c=relaxed/simple;
	bh=Dw5Y24FsnrJYP+D+z59dK/OTKiFGVJdVulW9OIL7cik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLYzA79fNhF9uv6M8VQ9MybkpZ4BZAYiMCuq+PgNqQpWYFfZpac65HgeDJKuuQYO25j32Uksqi1ym86zU3d3gcnMAfnH9aYMk1DNw5OmsXxFz510ceiIiOG9geaUsvWsBEyXFSca41Fct54mt45BI/Du32MrvU6hgLjI1eajvXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bz6kD9qW; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bz6kD9qW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 010141F7F3;
	Wed, 24 Jan 2024 13:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706102352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dw5Y24FsnrJYP+D+z59dK/OTKiFGVJdVulW9OIL7cik=;
	b=bz6kD9qWPvkzAeNXgqd5JafgBzmjbr4n0HjQw2PAqESR1EYG3M4535vrce+ScLw6l5vENd
	QDVqcF9yCAR4GjzzEFtRq3ljGFkxvj8hNaoTKg7H7xQTfun9fMUvTEaLgE630fTzjkxyEV
	bMF4BsWhZkpWLwXnopJZa5sH5GEdke4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706102352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dw5Y24FsnrJYP+D+z59dK/OTKiFGVJdVulW9OIL7cik=;
	b=bz6kD9qWPvkzAeNXgqd5JafgBzmjbr4n0HjQw2PAqESR1EYG3M4535vrce+ScLw6l5vENd
	QDVqcF9yCAR4GjzzEFtRq3ljGFkxvj8hNaoTKg7H7xQTfun9fMUvTEaLgE630fTzjkxyEV
	bMF4BsWhZkpWLwXnopJZa5sH5GEdke4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D330413786;
	Wed, 24 Jan 2024 13:19:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HaFYM08OsWUVQwAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Wed, 24 Jan 2024 13:19:11 +0000
Date: Wed, 24 Jan 2024 14:19:10 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, cake@lists.bufferbloat.net, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, Petr Pavlu <ppavlu@suse.cz>, Michal Kubecek <mkubecek@suse.cz>, 
	Martin Wilck <mwilck@suse.com>, Pedro Tammela <pctammela@mojatatu.com>
Subject: Re: [PATCH v4 0/4] net/sched: Load modules via alias
Message-ID: <mdosj4utmgvuaezdceoyde2d2q44amozbpdvzo3clljqaxh5ap@x5i22jkftljg>
References: <20240123135242.11430-1-mkoutny@suse.com>
 <CAM0EoMkA1Hp61mp2n06P8aMdnteJZD5tvJPDOuAKi_PNrb+T9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c45fhlz26gbnaf7f"
Content-Disposition: inline
In-Reply-To: <CAM0EoMkA1Hp61mp2n06P8aMdnteJZD5tvJPDOuAKi_PNrb+T9A@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.00
X-Spamd-Result: default: False [-3.00 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RL63s8thh5w8zyxj4waeg9pq8e)];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 SIGNED_PGP(-2.00)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 BAYES_HAM(-1.60)[92.45%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[29];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,lists.bufferbloat.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,iogearbox.net,linux.dev,toke.dk,intel.com,networkplumber.org,suse.cz,suse.com,mojatatu.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO


--c45fhlz26gbnaf7f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 07:17:27AM -0500, Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> A small nit seeing Simon's comment which will have you respin.
> cls_tcindex is no longer in the kernel.
> Can you use another example?

I'd better do.

> Also Stephen had some comments last time, not sure if you addressed
> those (nothing on the logs says you did=20

It's these lines:

| Changes from v2 (https://lore.kernel.org/r/20231206192752.18989-1-mkoutny=
@suse.com)
| ...
| - used alias names more fitting the existing net- aliases
| - more info in commit messages and cover letter

> and i didnt see him say anything).

Me neither. I may amend the patches more if I missed anything.

Thanks,
Michal

--c45fhlz26gbnaf7f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZbEOTAAKCRAGvrMr/1gc
jtrQAP9uYuOAQQ0Tojol8e+XnFvLh7Mb0btYxYqEVoWfIxoPdgEAoQkQeB0uf7Xq
XZWaDSG2PTOdZK59odVCHeGSTaXsnwU=
=JlzC
-----END PGP SIGNATURE-----

--c45fhlz26gbnaf7f--

