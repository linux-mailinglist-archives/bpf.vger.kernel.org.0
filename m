Return-Path: <bpf+bounces-15673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CBC7F4C04
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 17:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27CE1C20AC7
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 16:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143CD4C3CF;
	Wed, 22 Nov 2023 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iVmy9Md0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA088BC;
	Wed, 22 Nov 2023 08:11:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E47D21853;
	Wed, 22 Nov 2023 16:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1700669486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tjxIQeXSz4B6dutTyQbVvz42XSlpNrvZxeWc0EaGPkQ=;
	b=iVmy9Md0SMd/ZAJ7hwv0SH0uCj0+7Q7+bXx7BTix8G6I8LAt6xZhdlFHnJkWS5GJL3pZEK
	7Khhvp+aPQtZe8JnN6dreGhynuyoOpUSlFBatVXG14e/EdRIJM+GNlGz9My2mMKwNaIFe1
	EZMIOmP/kuZ8cTVzBME/0cHY2+zEorw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8BC7813467;
	Wed, 22 Nov 2023 16:11:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id mwpQIS0oXmVlNwAAMHmgww
	(envelope-from <mkoutny@suse.com>); Wed, 22 Nov 2023 16:11:25 +0000
Date: Wed, 22 Nov 2023 17:11:24 +0100
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
Message-ID: <rfhthr7f6st26h3ggfanaeyfi7ndld5mo46qhq7gufr6fbmzst@fbi27atd6djs>
References: <20231121175640.9981-1-mkoutny@suse.com>
 <CAM0EoM=id7xo1=F5SY2f+hy8a8pkXQ5a0xNJ+JKd9e6o=--RQg@mail.gmail.com>
 <yerqczxbz6qlrslkfbu6u2emb5esqe7tkrexdbneite2ah2a6i@l6arp7nzyj75>
 <CAM0EoMk_OgpjV7Huh-NHF_WxkJtQYGAMY+kutsL=qD9oYthh_w@mail.gmail.com>
 <CAM0EoM=Pq02p-sbkMSQBg8=dwTC5z+AeLjeXdzeHTA1AFSLuRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ellx3u2ji6sqqzad"
Content-Disposition: inline
In-Reply-To: <CAM0EoM=Pq02p-sbkMSQBg8=dwTC5z+AeLjeXdzeHTA1AFSLuRg@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-2.90)[99.56%];
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


--ellx3u2ji6sqqzad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 22, 2023 at 10:55:29AM -0500, Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> Out of curiosity - how did you end up looking at this?

The trigger for this case was tcindex module -- removed in upstream, so
we don't want to have implicit autoloads for it while we retain it in
our distro.

The user has to modprobe explicitly or un-blacklist the module.

(For instance, we've been leveraging this for the fs-* modules due to
various support status of filesystem modules in SLE.)


Michal

--ellx3u2ji6sqqzad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZV4oKgAKCRAGvrMr/1gc
jiYdAQCazlPSmBnTX8+0PP94jKGjnQ3eWojW1rjG+rqiKhgBeAEAkw8NYL7FaIsQ
H0omuGkVP0DS2VuIKSLV7NokhGLa0QI=
=XKw4
-----END PGP SIGNATURE-----

--ellx3u2ji6sqqzad--

