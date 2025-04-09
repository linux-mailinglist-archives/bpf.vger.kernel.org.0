Return-Path: <bpf+bounces-55554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6A4A82CC0
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 18:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09919887AFE
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 16:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A3126772C;
	Wed,  9 Apr 2025 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="flbivy0e"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163AB26E148
	for <bpf@vger.kernel.org>; Wed,  9 Apr 2025 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744216862; cv=none; b=pn1MzFVreBY3BpYPXhaP2u3xMwzbrxfam9jeYACwj2rlBwIwTA8MH8TgdlrUUiwAzXr2VrTNm0/yI63LksIEkBGv2WsWxsIElwT+JaBgkbdsOzVK8DLTP0w1lNyF/L5SEC1TUz1601hNQFRujfsINTh/sheYzoiy2eJLPHEBtrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744216862; c=relaxed/simple;
	bh=fHtzsqyFXqsqKFMN9o9Jg6YNOCKqxpR3FTSVZ+RDgH0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=bisbw/hNruKTPaR3CjmLlMfe6/IY/K+CKZxltECOKUvkG2IykCLhlt6jlVzfnfAj+3Z4hrZM0rLsIJ6mLHSJl8Xi49xscim3qNEame1Ba3RMK+N/f0poRndyb7e3vm+nUw+wEk0r5jx/o92T+gy0dh61dThaD9Q18hFKDq8N2F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=flbivy0e; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744216857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2uGpDWEkSr9vFQIbcnhzKP72TVIYwsPwOclwYbiHadg=;
	b=flbivy0eFa+1D3pp6XHzZXXaM/vyuD5kjKwpfeicfcJahclQRmqKai7pLKfClVn6NcPBQC
	odIONTf6B+d8QdgqeOfH3lULncL5hgF3qn7uCwEK0WVJQ9LLe9Vdz+hHiSn0MtHIhGIkfE
	Ou1Ya23bcILo4UFR8vebqPRdjlCCe4M=
Date: Wed, 09 Apr 2025 16:40:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <c292a4c4daa4d27f5062a23bd871ac58285ec406@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v1] bpf, sockmap: Introduce tracing capability
 for sockmap
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org, mrpre@163.com, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin  KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "KP  Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, "Mathieu  Desnoyers"
 <mathieu.desnoyers@efficios.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
In-Reply-To: <20250409121125.48510acb@gandalf.local.home>
References: <20250409102937.15632-1-jiayuan.chen@linux.dev>
 <20250409121125.48510acb@gandalf.local.home>
X-Migadu-Flow: FLOW_OUT

April 10, 2025 at 24:11, "Steven Rostedt" <rostedt@goodmis.org> wrote:

>=20
>=20On Wed, 9 Apr 2025 18:29:33 +0800
>=20
>=20Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>=20
>=20>=20
>=20> +#define trace_sockmap_skmsg_redirect(sk, prog, msg, act) \
> >  + trace_sockmap_redirect((sk), "msg", (prog), (msg)->sg.size, (act))
> >  +
> >  +#define trace_sockmap_skb_redirect(sk, prog, skb, act) \
> >  + trace_sockmap_redirect((sk), "skb", (prog), (skb)->len, (act))
> >  +
> >  +TRACE_EVENT(sockmap_redirect,
> >  + TP_PROTO(const struct sock *sk, const char *type,
> >  + const struct bpf_prog *prog, int length, int act),
> >  + TP_ARGS(sk, type, prog, length, act),
> >  +
> >  + TP_STRUCT__entry(
> >  + __field(const void *, sk)
> >  + __field(const char *, type)
> >=20
>=20
> On 64bit, const char * is 8 bytes, and you are pointing it to a string =
of
> size 4 bytes (3 chars and '\0'). Why not just make it a constant string=
, or
> better yet, an enum?
>=20
>=20-- Steve
>
Using an enum is indeed more appropriate in TRACE.

Thank you for the suggestion.

