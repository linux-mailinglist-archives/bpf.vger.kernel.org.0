Return-Path: <bpf+bounces-55551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48966A82BF5
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 18:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5867B7A90DF
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 16:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5281925DD13;
	Wed,  9 Apr 2025 16:10:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7F6259C;
	Wed,  9 Apr 2025 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744215009; cv=none; b=A8bE4CkGHanAEOQa0ner9sfOcXUYefars1YL0HQYmcjFhZYUwUhS1NAMNJgO3WIkLDxYW0WRdZ65pRbdF9Mjbq0KcrGqyodg4Qhb0DEePkDzS7uEFZllSkqyay0p9XcubinhcT9m7Y0wuZjgsja7mJxZ9Y89aDuzvOKI8WcXJxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744215009; c=relaxed/simple;
	bh=KoaylkJAFwie8qe4eWrllGQZ9xFpIomToI9+3Wyddbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dfhfu6CNIaPeUkxmNsKsf2rg/1HYkR68YC0r3JocLLu7l8QBetIj/bPJD/sJm00JaOOxGIK/Zsi+SwHjMMFSqJh3QJFobXTXiNZGqNuHUsCh1deAYSTmNaNr3gkehuzOmQOn8DIj9mqvmgev/rDMLTh1N7huKz7m3CHp1jcIb24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F06C4CEE2;
	Wed,  9 Apr 2025 16:10:05 +0000 (UTC)
Date: Wed, 9 Apr 2025 12:11:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, mrpre@163.com, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jakub Sitnicki
 <jakub@cloudflare.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1] bpf, sockmap: Introduce tracing capability
 for sockmap
Message-ID: <20250409121125.48510acb@gandalf.local.home>
In-Reply-To: <20250409102937.15632-1-jiayuan.chen@linux.dev>
References: <20250409102937.15632-1-jiayuan.chen@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Apr 2025 18:29:33 +0800
Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

> +#define trace_sockmap_skmsg_redirect(sk, prog, msg, act)	\
> +	trace_sockmap_redirect((sk), "msg", (prog), (msg)->sg.size, (act))
> +
> +#define trace_sockmap_skb_redirect(sk, prog, skb, act)		\
> +	trace_sockmap_redirect((sk), "skb", (prog), (skb)->len, (act))
> +
> +TRACE_EVENT(sockmap_redirect,
> +	    TP_PROTO(const struct sock *sk, const char *type,
> +		     const struct bpf_prog *prog, int length, int act),
> +	    TP_ARGS(sk, type, prog, length, act),
> +
> +	TP_STRUCT__entry(
> +		__field(const void *, sk)
> +		__field(const char *, type)

On 64bit, const char * is 8 bytes, and you are pointing it to a string of
size 4 bytes (3 chars and '\0'). Why not just make it a constant string, or
better yet, an enum?

-- Steve


> +		__field(__u16, family)
> +		__field(__u16, protocol)
> +		__field(int, prog_id)
> +		__field(int, length)
> +		__field(int, act)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->sk		= sk;
> +		__entry->type		= type;
> +		__entry->family		= sk->sk_family;
> +		__entry->protocol	= sk->sk_protocol;
> +		__entry->prog_id	= prog->aux->id;
> +		__entry->length		= length;
> +		__entry->act		= act;
> +	),
> +

