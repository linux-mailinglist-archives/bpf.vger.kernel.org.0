Return-Path: <bpf+bounces-27351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02E48AC32C
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 05:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6251C20956
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 03:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989F4101EE;
	Mon, 22 Apr 2024 03:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YNFGQJ5d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FHThv/+A";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YNFGQJ5d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FHThv/+A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F412E542;
	Mon, 22 Apr 2024 03:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713757507; cv=none; b=cCv0+QVtAkILKnWlzEQFt7MNfRZOLdiMD5qn7FCR+7JD3ckE96QDvxPvQ3Kq+oCpwHpkHTJn/431k/tnP4WowEkFOfSjkpzePM4ZMWokJdH7ZnlSDvqEKqmOXQry3lluOHYtILYEUL22IQZ85CXYKy7RgMo1O9W7ubktkiAh2sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713757507; c=relaxed/simple;
	bh=08JXntusgK41+ycFBthAXi0xoPBt/thnoLFKZQXR61c=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=noSsFO0rAz6wu5t41t6udkZFmWbFbhatvsQh0mVWLWihsvgYeajAzi2iLaGKoZmZw6C2V0cCZ1e74ROKJ8EAurAz+RjMJHO7hYDGN+sRtfStOzWKRyRSYgKRihykmqiKpQju4W3AXXAUXzbcj9H7mTry9KaUj39icVzO2vioPyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YNFGQJ5d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FHThv/+A; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YNFGQJ5d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FHThv/+A; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F1F95C849;
	Mon, 22 Apr 2024 03:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713757503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdzU1hv8xkzQkP0Voc7ZJKo+cz0pH/lZ8F7iWLkQ2E8=;
	b=YNFGQJ5dJbJkYPh2nYz8QEqGXYVy2wYftPNbZX4DNyJTPbC/VIju0v7wPuA+wod1eZ4uCL
	EnhKGvnskGjylCkVIDcee0fjGOmwfT2Pkzabl3qbH0jpZTC1UWEisb6DSddb5860GzNCOE
	oG/OUhKHKjNx/jBK28VP9TnxqAxYCRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713757503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdzU1hv8xkzQkP0Voc7ZJKo+cz0pH/lZ8F7iWLkQ2E8=;
	b=FHThv/+AznOXKLSIRBqC1PLEBtwZWbrDd5lF8ZPMCwR4vsKeUy+qzaNWbuT3FhHWHMqTu1
	HsnuQObNvr8PPNBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713757503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdzU1hv8xkzQkP0Voc7ZJKo+cz0pH/lZ8F7iWLkQ2E8=;
	b=YNFGQJ5dJbJkYPh2nYz8QEqGXYVy2wYftPNbZX4DNyJTPbC/VIju0v7wPuA+wod1eZ4uCL
	EnhKGvnskGjylCkVIDcee0fjGOmwfT2Pkzabl3qbH0jpZTC1UWEisb6DSddb5860GzNCOE
	oG/OUhKHKjNx/jBK28VP9TnxqAxYCRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713757503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdzU1hv8xkzQkP0Voc7ZJKo+cz0pH/lZ8F7iWLkQ2E8=;
	b=FHThv/+AznOXKLSIRBqC1PLEBtwZWbrDd5lF8ZPMCwR4vsKeUy+qzaNWbuT3FhHWHMqTu1
	HsnuQObNvr8PPNBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 274A113687;
	Mon, 22 Apr 2024 03:44:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LOmcLjjdJWbeLgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 22 Apr 2024 03:44:56 +0000
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
In-reply-to:
 <CAHCWhjScokCi7u_98-i6E_xHaSJnFGY6dnkv9-C5-yrpihVJFg@mail.gmail.com>
References:
 <>, <CAHCWhjScokCi7u_98-i6E_xHaSJnFGY6dnkv9-C5-yrpihVJFg@mail.gmail.com>
Date: Mon, 22 Apr 2024 13:44:45 +1000
Message-id: <171375748540.7600.5672163982570379489@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email]

On Mon, 22 Apr 2024, Lex Siegel wrote:
> > Better still would be for kernel_connect() to return a more normal error
> > code - not EPERM.  If that cannot be achieved, then I think it would be
> > best for the sunrpc code to map EPERM to something else at the place
> > where kernel_connect() is called - catch it early.
>=20
> The question is whether a permission error, EPERM, should cause a retry or
> return. Currently xs_tcp_setup_socket() is retrying. For the retry to clear,
> the connect call will have to not return a permission error to halt the ret=
ry
> attempts.
>=20
> This is a default behavior because EPERM is not an explicit case of the swi=
tch
> statement. Because bpf appropriately uses EPERM to show that the kernel_con=
nect
> was not permitted, it highlights the return handling for this case is missi=
ng.
> It is unlikely that retry was ever the intended result.
>=20
> Upstream, the bpf that caused this is at:
> https://github.com/cilium/cilium/blob/v1.15/bpf/bpf_sock.c#L336
>=20
> This cilium bpf code has two return statuses, EPERM and ENXIO, that fall
> through to the default case of retrying. Here, cilium expects both of these
> statuses to indicate the connect failed. A retry is not the intended result.
>=20
> Handling this case without a retry aligns this code with the udp behavior. =
This
> precedence for passing EPERM back up the stack was set in 3dedbb5ca10ef.
>=20
> I will amend my patch to include an explicit case for ENXIO as well, as thi=
s is
> also in cilium's bpf and will cause the same bug to occur.
>=20

I think it should be up to cilium to report an errno that the kernel
understands, not up to the kernel to understand whatever errno cilium
chooses to return.

I don't think EPERM or ENXIO are appropriate errors for network
problems.
EHOSTUNREACH or ECONNREFUSED would make much more sense.

NeilBrown


>=20
> On Mon, Apr 22, 2024 at 8:22=E2=80=AFAM NeilBrown <neilb@suse.de> wrote:
> >
> > On Sat, 20 Apr 2024, Lex Siegel wrote:
> > > When using a bpf on kernel_connect(), the call can return -EPERM.
> > > This causes xs_tcp_setup_socket() to loop forever, filling up the
> > > syslog and causing the kernel to freeze up.
> > >
> > > Signed-off-by: Lex Siegel <usiegl00@gmail.com>
> > > ---
> > >  net/sunrpc/xprtsock.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> > > index bb9b747d58a1..47b254806a08 100644
> > > --- a/net/sunrpc/xprtsock.c
> > > +++ b/net/sunrpc/xprtsock.c
> > > @@ -2446,6 +2446,8 @@ static void xs_tcp_setup_socket(struct work_struc=
t *work)
> > >               /* Happens, for instance, if the user specified a link
> > >                * local IPv6 address without a scope-id.
> > >                */
> > > +     case -EPERM:
> > > +             /* Happens, for instance, if a bpf is preventing the conn=
ect */
> >
> > This will propagate -EPERM up into other layers which might not be ready
> > to handle it.
> > It might be safer to map EPERM to an error we would be more likely to
> > expect  from the network system - such as ECONNREFUSED or ENETDOWN.
> >
> > Better still would be for kernel_connect() to return a more normal error
> > code - not EPERM.  If that cannot be achieved, then I think it would be
> > best for the sunrpc code to map EPERM to something else at the place
> > where kernel_connect() is called - catch it early.
> >
> > NeilBrown
> >
> >
> > >       case -ECONNREFUSED:
> > >       case -ECONNRESET:
> > >       case -ENETDOWN:
> > > --
> > > 2.39.3
> > >
> > >
> >
>=20


