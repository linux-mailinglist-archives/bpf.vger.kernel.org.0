Return-Path: <bpf+bounces-54060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E8BA6179B
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 18:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF2C18830AC
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 17:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B1F2036FF;
	Fri, 14 Mar 2025 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pAJgzl9J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CgrjTBeh"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD285204680;
	Fri, 14 Mar 2025 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973274; cv=none; b=g1v0hRNwsn5xFpygi7gvdoeLKkdy75MpxAdxg+xxvlRGjZ4Xl1RdDyKJc8KY8PmSxb69Qdazx/C7ETMyLZpuDIZJNOCbaUVDkWmZoaG7Qfgto5YIPSmAuO4PMgHrhezIGietE/wTtIOKPk3sEh450vFfyCb0FLGWIhF7k/+rx6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973274; c=relaxed/simple;
	bh=yGxgdF+OHwBPS6fl+QKaxNcmsUSJgirsc4Ag+DtLmcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1r6ghF3Icwf13vRTFKDqZqbiFHIcMydFNJHjS3keTHP/R8kuwwZOlFG8ZRWvy5LKwViYew345/hVu8jmk0X8LPprIuTq8uxZg36a5JFALOrKk0JttYwjGyfgfYONhHAT5Agf7ZK8vod4WUYZh5F07o6LsWdHcMyGZD8GvDrlkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pAJgzl9J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CgrjTBeh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 18:27:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741973270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wcRCFIBiAQNI1L/e3qYxgTree8WI127fpfM7PwFeH8k=;
	b=pAJgzl9JA7bq+lH2EEHM2+Sq9VQrAel6kyYkh18y+6OlAeOZgdy+4aaW5X5E8hL67dTC/W
	nq98URRZw8U7o+eKg72Gv1gbBm5GOqi+mA0JrTzWyaRN7+ZIViSM4lJZVe2gEn4U0xhFzZ
	ry3nqUZ3RQLGZQQ1BXXq7GT4trV81n2SMj4+ztdbZrjZ3uYmIllPHA3pvRjRZ7QRzJ3M1Y
	CECA7OpfW9c2Tm5FSF8zfbXLcGRNbZJ4kVT+RDSIuZSLS1c2hz7pmk1KhrSFljifn2LNYK
	pWYDBgUTr152UlSsXL3c0hfhyj0Zb6MpZD+H806O1VVSRrrdJ6BCONiwcpScqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741973270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wcRCFIBiAQNI1L/e3qYxgTree8WI127fpfM7PwFeH8k=;
	b=CgrjTBehA7t1aEFnDlXacuc37fxZk2+ByxJyRvUSaxNaXJhgjPjHw+Gr0RQ5Zz25ynF/Dn
	1IoHt7Hn5atxMHBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	Ricardo =?utf-8?Q?Ca=C3=B1uelo?= Navarro <rcn@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Use after free in BPF/ XDP during XDP_REDIRECT
Message-ID: <20250314172749.hsmtyM3N@linutronix.de>
References: <20250313183911.SPAmGLyw@linutronix.de>
 <87ecz0u3w9.fsf@toke.dk>
 <20250313203226.47_0q7b6@linutronix.de>
 <871pv0rmr8.fsf@toke.dk>
 <20250314153041.9BKexZXH@linutronix.de>
 <875xkbha5k.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <875xkbha5k.fsf@toke.dk>

On 2025-03-14 17:03:35 [+0100], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > While at it, is there anything that ensures that only bpf_prog_run_xdp()
> > can invoke the map_redirect callback? Mainline only assigns the task
> > pointer in NAPI callback so any usage outside of bpf_prog_run_xdp() will
> > lead to a segfault and I haven't seen a report yet so=E2=80=A6
>=20
> Yes, the verifier restricts which program types can call the
> map_redirect helper.

Okay. So checks for the BPF_PROG_TYPE_XDP type for the map_redirect and
that is the only one setting it. Okay. Now I remember Alexei mentioning
something=E2=80=A6

> > --- a/include/net/xdp.h
> > +++ b/include/net/xdp.h
> > @@ -486,7 +486,12 @@ static __always_inline u32 bpf_prog_run_xdp(const =
struct bpf_prog *prog,
> >  	 * under local_bh_disable(), which provides the needed RCU protection
> >  	 * for accessing map entries.
> >  	 */
> > -	u32 act =3D __bpf_prog_run(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
> > +	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
> > +	u32 act;
> > +
>=20
> Add an if here like
>=20
> if (ri->map_id | ri->map_type) { /* single | to make it a single branch */
>=20
> > +	ri->map_id =3D INT_MAX;
> > +	ri->map_type =3D BPF_MAP_TYPE_UNSPEC;
>=20
> }
>=20
> Also, ri->map_id should be set to 0, not INT_MAX.

The or variant does

|         add %gs:this_cpu_off(%rip), %rax        # this_cpu_off, tcp_ptr__
|         movl    32(%rax), %edx  # _51->map_id, _51->map_id
|         orl     36(%rax), %edx  # _51->map_type, tmp311
|         je      .L1546  #,
|         movq    $0, 32(%rax)    #, MEM <vector(2) unsigned int> [(unsigne=
d int *)_51 + 32B]
| .L1546:

while the || does

|         add %gs:this_cpu_off(%rip), %rax        # this_cpu_off, tcp_ptr__
|         cmpq    $0, 32(%rax)    #, *_51
|         je      .L1546  #,
|         movq    $0, 32(%rax)    #, MEM <vector(2) unsigned int> [(unsigne=
d int *)_51 + 32B]
| .L1546:

gcc isn't bad at optimizing here ;)

This is the or version as asked for. I don't mind doing any of the both.
I everyone agrees then I would send it to Greg.

--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -486,7 +486,14 @@ static __always_inline u32 bpf_prog_run_xdp(const stru=
ct bpf_prog *prog,
 	 * under local_bh_disable(), which provides the needed RCU protection
 	 * for accessing map entries.
 	 */
-	u32 act =3D __bpf_prog_run(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
+	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	u32 act;
+
+	if (ri->map_id | ri->map_type) {
+		ri->map_id =3D 0;
+		ri->map_type =3D BPF_MAP_TYPE_UNSPEC;
+	}
+	act =3D __bpf_prog_run(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
=20
 	if (static_branch_unlikely(&bpf_master_redirect_enabled_key)) {
 		if (act =3D=3D XDP_TX && netif_is_bond_slave(xdp->rxq->dev))

> -Toke

Sebastian

