Return-Path: <bpf+bounces-20217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 331A383A71E
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 11:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659AC1C22BB0
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 10:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8EA19475;
	Wed, 24 Jan 2024 10:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ca35CYqz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ca35CYqz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30F217C65;
	Wed, 24 Jan 2024 10:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706093138; cv=none; b=V7hW7NPL9ICeJz5DvEZ03NbqbEReYf0YWAdeHv8fPC6bJjgTgLgtACsh5L7Bytk6/S57cqSk3ry9KhggPgmqgHgs3B7VSTvdlnGtlC7sIJFV9663kYA6o4UQW7KS1lfA8drbZB3fMOZ4HTjg9in7UxKXq0W6KJ+VFgtYsFeJgTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706093138; c=relaxed/simple;
	bh=vDYamFwd5bvpNdoZJxjLLuH6adTcx66pEKYFC55fGvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrWcPnyH0+Gg19+pzHvk93jJFeZIcTwwOlqp8NXpNjmD9u1OoH6XuRcS+nRsaoZMvgoTj7raTWFLqqTUkZajeCaMEPEmfSqUuKP5M8n9LFP49Cs/2XOSutim85Arm5thiF+FFtXNJPJc/yiU4B0Ue9PkMFgrJ+8Yi2hDkddFt8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ca35CYqz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ca35CYqz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A56F421FE0;
	Wed, 24 Jan 2024 10:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706093134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vDYamFwd5bvpNdoZJxjLLuH6adTcx66pEKYFC55fGvQ=;
	b=ca35CYqzpEv1O6x7kDOtHFG7O6T3WcBTmabdm4u4ubV0Ls4nZg0s4glAWzIiT08w8wZgZh
	vXt5WR4QWWZ0H8F1wG+GlawIAfygv94xJsvFqVdTNy6nJzf9CXDdsV6D+TIMKSyqnSTKxm
	TLlxbMo3/dvYCyD8H10KcjSC2brNu7E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706093134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vDYamFwd5bvpNdoZJxjLLuH6adTcx66pEKYFC55fGvQ=;
	b=ca35CYqzpEv1O6x7kDOtHFG7O6T3WcBTmabdm4u4ubV0Ls4nZg0s4glAWzIiT08w8wZgZh
	vXt5WR4QWWZ0H8F1wG+GlawIAfygv94xJsvFqVdTNy6nJzf9CXDdsV6D+TIMKSyqnSTKxm
	TLlxbMo3/dvYCyD8H10KcjSC2brNu7E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CCF413786;
	Wed, 24 Jan 2024 10:45:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UDguHk7qsGVAEQAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Wed, 24 Jan 2024 10:45:34 +0000
Date: Wed, 24 Jan 2024 11:45:33 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Simon Horman <horms@kernel.org>
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
	Martin Wilck <mwilck@suse.com>, Pedro Tammela <pctammela@mojatatu.com>
Subject: Re: [PATCH v4 3/4] net/sched: Load modules via their alias
Message-ID: <7u63ta73ldxnf5ucoywzu4irl6mer66ur4letgpavghkcnvlke@6ajcojmjk5nv>
References: <20240123135242.11430-1-mkoutny@suse.com>
 <20240123135242.11430-4-mkoutny@suse.com>
 <20240123174002.GN254773@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m7zrpn5dfxhi46pl"
Content-Disposition: inline
In-Reply-To: <20240123174002.GN254773@kernel.org>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.77 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-1.57)[92.18%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 R_RATELIMIT(0.00)[to_ip_from(RL63s8thh5w8zyxj4waeg9pq8e)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[30];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,lists.bufferbloat.net,davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,gmail.com,resnulli.us,iogearbox.net,linux.dev,toke.dk,intel.com,networkplumber.org,suse.cz,suse.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.77


--m7zrpn5dfxhi46pl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 23, 2024 at 05:40:02PM +0000, Simon Horman <horms@kernel.org> wrote:
> name doesn't exist in this context, perhaps the line above should be:

Well spotted (and shame on me for unchecked last-moment edits).

I will resend after some more feedback or time.

Thanks,
Michal

--m7zrpn5dfxhi46pl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZbDqSwAKCRAGvrMr/1gc
jmDPAP4kh0vASWmR2BIYzLZ9ltAfmTpMmdRiYjUTl0+b1KWtYwD+NflnVdzmVBHe
rylTGmjlroohIQGBpbUFvMZZAXcJ6AQ=
=ko42
-----END PGP SIGNATURE-----

--m7zrpn5dfxhi46pl--

