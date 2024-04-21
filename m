Return-Path: <bpf+bounces-27347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D28F48AC21A
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 01:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02D011C20C8A
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 23:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E06246433;
	Sun, 21 Apr 2024 23:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IjERKFur";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gbeOhgDI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IjERKFur";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gbeOhgDI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59544437;
	Sun, 21 Apr 2024 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713741779; cv=none; b=VHjECJhAweST09sRyVDbYTfC2uKMIMS87tVrU7M457DFlb7c3gROOFEGHyhClnvj9GistHxTQ2zzzB17F4WY9Oywj+kshCow2gSeKDC2tg4omYQF0ov5WQLn7ImDjQQ+bCNMKRSmQB9qCt3cwbUY/KQPUK2PQGBjNrQbKCioZN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713741779; c=relaxed/simple;
	bh=x7/9k3VUkArG5pgm3qecA36nkdPnWUn28VxB8zg3sgs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=tyKMaR3ZAWVwh6AxqwZwkDcFQzwMNbOtX6q2wh3cdiNwEUpYO+WxWncFlwH2dia4gP/m9/Id9ceq5l3A1iiArJqqR9Rq00hEx0gODmW5r/8uZaauyC/t9FPI33BglyjaI6NpjjbU7Jf8RtfbjgcTZo1pUiJUvC7ZvrcrcTZuUXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IjERKFur; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gbeOhgDI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IjERKFur; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gbeOhgDI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B492F3470C;
	Sun, 21 Apr 2024 23:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713741775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itTVdaSaWpVAwo/eRp+XlnufM44f07MOYwHHeFt+cBo=;
	b=IjERKFurEfo0l04lIurGTVPkHlOCkl6lPkxF9FFO30jMUDg8cOfPI6XY9rl8cVahn77gHv
	g8ly4QKY9rQkFxqbNmgmp5ht1aC6mspXRP/1LYq28jQzVqUW24M5ajthM+o7RL8KPzFcvs
	aLCArjw/wQUL6S71p9/yy/hqMkLbDzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713741775;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itTVdaSaWpVAwo/eRp+XlnufM44f07MOYwHHeFt+cBo=;
	b=gbeOhgDIjmhSRmotPdrLXo3RqSblX5SSy9WqeZrguDNV9/3Avxf/qeFAKKyZLXhH5QM+WM
	o4AC2/uGGbOTkWAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IjERKFur;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gbeOhgDI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713741775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itTVdaSaWpVAwo/eRp+XlnufM44f07MOYwHHeFt+cBo=;
	b=IjERKFurEfo0l04lIurGTVPkHlOCkl6lPkxF9FFO30jMUDg8cOfPI6XY9rl8cVahn77gHv
	g8ly4QKY9rQkFxqbNmgmp5ht1aC6mspXRP/1LYq28jQzVqUW24M5ajthM+o7RL8KPzFcvs
	aLCArjw/wQUL6S71p9/yy/hqMkLbDzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713741775;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itTVdaSaWpVAwo/eRp+XlnufM44f07MOYwHHeFt+cBo=;
	b=gbeOhgDIjmhSRmotPdrLXo3RqSblX5SSy9WqeZrguDNV9/3Avxf/qeFAKKyZLXhH5QM+WM
	o4AC2/uGGbOTkWAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F37E13687;
	Sun, 21 Apr 2024 23:22:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ar9KAMmfJWYobAAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 21 Apr 2024 23:22:49 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Lex Siegel" <usiegl00@gmail.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>,
 "Trond Myklebust" <trond.myklebust@hammerspace.com>,
 "Anna Schumaker" <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] xprtsock: Fix a loop in xs_tcp_setup_socket()
In-reply-to: <20240420104801.94701-1-usiegl00@gmail.com>
References: <20240420104801.94701-1-usiegl00@gmail.com>
Date: Mon, 22 Apr 2024 09:22:35 +1000
Message-id: <171374175513.12877.8993642908082014881@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.27 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.76)[84.23%];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B492F3470C
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.27

On Sat, 20 Apr 2024, Lex Siegel wrote:
> When using a bpf on kernel_connect(), the call can return -EPERM.
> This causes xs_tcp_setup_socket() to loop forever, filling up the
> syslog and causing the kernel to freeze up.
>=20
> Signed-off-by: Lex Siegel <usiegl00@gmail.com>
> ---
>  net/sunrpc/xprtsock.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index bb9b747d58a1..47b254806a08 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -2446,6 +2446,8 @@ static void xs_tcp_setup_socket(struct work_struct *w=
ork)
>  		/* Happens, for instance, if the user specified a link
>  		 * local IPv6 address without a scope-id.
>  		 */
> +	case -EPERM:
> +		/* Happens, for instance, if a bpf is preventing the connect */

This will propagate -EPERM up into other layers which might not be ready
to handle it.
It might be safer to map EPERM to an error we would be more likely to
expect  from the network system - such as ECONNREFUSED or ENETDOWN.

Better still would be for kernel_connect() to return a more normal error
code - not EPERM.  If that cannot be achieved, then I think it would be
best for the sunrpc code to map EPERM to something else at the place
where kernel_connect() is called - catch it early.

NeilBrown


>  	case -ECONNREFUSED:
>  	case -ECONNRESET:
>  	case -ENETDOWN:
> --=20
> 2.39.3
>=20
>=20


