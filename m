Return-Path: <bpf+bounces-59273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F74FAC7797
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 07:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72FA61BC78A0
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 05:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9682425392A;
	Thu, 29 May 2025 05:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HKcZheI0"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACA21DFDA1
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 05:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748496136; cv=none; b=sItt3HQmbJU4LoqLsAv84h0ybqXs6MTQS9DDtsUoxCt+9oxxnCgdPHfAQ3Ryix0ofaoC1g2fCMPny6wgN6EwWxaw4+CPvc3IPjQQA5h2nuhxoTahkHSvbsXFlYgmuD2GDx8BpgziPciHbBs3KDzdONQ8MpCBxzEpM2ZwQxOzrDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748496136; c=relaxed/simple;
	bh=Q0dYWEUysB3GuQeUb/vsTHteP71rkcgHtc4w3rTJccA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=fqCQUAGLH5f3QqaJ2dS9LM9qJBc5UQ1/9Qzr9U+dEN42wURNERJVhMr3MFosZWYFlID7UW+B0PEBc60tcfSpmi3GU0mnPD2IF1UwHlLvHDDI4oNOS9KMzwQAHU7Uc4Hk+NabPwE4hanQkRdmzV5vth+Je3drN9K+x21j3wtymNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HKcZheI0; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748496122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wU9EzffLrL7PxroXLmZyG9lwBwQuWjgJ24KpvgENI4Y=;
	b=HKcZheI0CJnM/qIGmWwPoafY4CpgoiRkuLFRXo8awY74aHYEnkYnCPq+zI4+Ut6io5vi3S
	4g4B9H+s5EZcAJvWhPo8JAwhBI9/Nkzl9jgitUOl1s6GZAIs2zi0x7dEP7DK4JSmqaax8b
	Re8EeLV9XxqJL6CLBMeUMxDSWJqSDPQ=
Date: Thu, 29 May 2025 05:22:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <9e1e9066f16378f810304ad60b972afe7e4d421a@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v1] bpf, sockmap: Fix psock incorrectly pointing
 to sk
To: "John Fastabend" <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, "Jakub Sitnicki" <jakub@cloudflare.com>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528234650.n5orke2yq55qnoen@gmail.com>
References: <20250523162220.52291-1-jiayuan.chen@linux.dev>
 <20250528234650.n5orke2yq55qnoen@gmail.com>
X-Migadu-Flow: FLOW_OUT

May 29, 2025 at 07:46, "John Fastabend" <john.fastabend@gmail.com> wrote:

>=20
>=20On 2025-05-24 00:22:19, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> We observed an issue from the latest selftest: sockmap_redir where
> >=20
>=20>  sk_psock(psock->sk) !=3D psock in the backlog. The root cause is t=
he special
> >=20
>=20>  behavior in sockmap_redir - it frequently performs map_update() an=
d
> >=20
>=20>  map_delete() on the same socket. During map_update(), we create a =
new
> >=20
>=20>  psock and during map_delete(), we eventually free the psock via rc=
u_work
> >=20
>=20>  in sk_psock_drop(). However, pending workqueues might still exist =
and not
> >=20
>=20>  be processed yet. If users immediately perform another map_update(=
), a new
> >=20
>=20>  psock will be allocated for the same sk, resulting in two psocks p=
ointing
> >=20
>=20>  to the same sk.
> >=20
>=20>=20=20
>=20>=20
>=20>  When the pending workqueue is later triggered, it uses the old pso=
ck to
> >=20
>=20>  access sk for I/O operations, which is incorrect.
> >=20
>=20>=20=20
>=20>=20
>=20>  Timing Diagram:
> >=20
>=20>=20=20
>=20>=20
>=20>  cpu0 cpu1
> >=20
>=20>=20=20
>=20>=20
>=20>  map_update(sk):
> >=20
>=20>  sk->psock =3D psock1
> >=20
>=20>  psock1->sk =3D sk
> >=20
>=20>  map_delete(sk):
> >=20
>=20>  rcu_work_free(psock1)
> >=20
>=20>=20=20
>=20>=20
>=20>  map_update(sk):
> >=20
>=20>  sk->psock =3D psock2
> >=20
>=20>  psock2->sk =3D sk
> >=20
>=20>  workqueue:
> >=20
>=20>  wakeup with psock1, but the sk of psock1
> >=20
>=20>  doesn't belong to psock1
> >=20
>=20>  rcu_handler:
> >=20
>=20>  clean psock1
> >=20
>=20>  free(psock1)
> >=20
>=20>=20=20
>=20>=20
>=20>  Previously, we used reference counting to address the concurrency =
issue
> >=20
>=20>  between backlog and sock_map_close(). This logic remains necessary=
 as it
> >=20
>=20>  prevents the sk from being freed while processing the backlog. But=
 this
> >=20
>=20>  patch prevents pending backlogs from using a psock after it has be=
en
> >=20
>=20>  freed.
> >=20
>=20
> Nit, its not that psock would be freed because we do have the
>=20
>=20cancel_delayed_work_sync() before the kfree(psock). But this
>=20
>=20is not a good state with two psocks referenceing the same sk.
>=20

BTW,=20did we miss ingress_lock while processing ingress_skb in backlog?
will we have the concurrency issue when skb was appended into ingress_skb
in sk_psock_skb_redirect().

