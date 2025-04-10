Return-Path: <bpf+bounces-55659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A97DEA84646
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 16:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE7019E7F0A
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 14:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB412853F5;
	Thu, 10 Apr 2025 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y6SZsQaG"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D402A2836B1
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744295254; cv=none; b=uGHa89leOzJhcE6QHxKulc5+gAj+KOR+XgDOpXfWSMkZWjjcG/mSC/XGme1Q7X2EGAa3xREkNOd1n0c3xYGAmTlirXaDxc3macJJi+k1qYsM4GUUmUhdR9TWAwKJAXJ2bfkgz5z3ZdSNKBkE+9Q/iVrUIVpYhesTcXc1S5YRajI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744295254; c=relaxed/simple;
	bh=brhRcL/BA3B7ayxZCilOde7eFu+DE09Bp210LvtFnKg=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=ZShVC7KKg6r78bATqnyWR0auCOMOonP6p+8Nql3VOXRc4Rsa+H/bF64fZfcLBzRnzSmps5rGFLWBK8zLEMKeZcIfI9Lea61IwPN43GoSsYZKCvj4Qjep8VYi+xfgd/8NY8GWqKukCu6vYME8RlfkBxuYv2nOKPdLxnOCb0hg7Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y6SZsQaG; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744295239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pen+hTCi9Y0t6tkeXWgyEYw/3+/q7c9d33Ri3lI9qsM=;
	b=Y6SZsQaGbhuKaFQxQJXLzu9VuBRzLyBRcr2xzt/+kfdp36cUBZi3yBrxhWAMrONFS20CQG
	GjuI6Tgtr82vmGj0iQMqzjj8RL7otQ8C50uhO9lFA7B0WnRPngcAuwzT/247rwygKo5SaL
	BRjvd2xMMm7/0WcJBOQY7DHmq9/hasU=
Date: Thu, 10 Apr 2025 14:27:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <0cfe4cc98a818d83a9b4bbe55006a17a7452ee38@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v1] bpf, sockmap: Introduce tracing capability
 for sockmap
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, mrpre@163.com, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin  KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "KP  Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao  Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, "Mathieu  Desnoyers"
 <mathieu.desnoyers@efficios.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub 
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon 
 Horman" <horms@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
In-Reply-To: <87ikncgyyd.fsf@cloudflare.com>
References: <20250409102937.15632-1-jiayuan.chen@linux.dev>
 <87ikncgyyd.fsf@cloudflare.com>
X-Migadu-Flow: FLOW_OUT

April 10, 2025 at 17:14, "Jakub Sitnicki" <jakub@cloudflare.com> wrote:



>=20
>=20On Wed, Apr 09, 2025 at 06:29 PM +08, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> Sockmap has the same high-performance forwarding capability as XDP,=
 but
> >=20
>=20>  operates at Layer 7.
> >=20
>=20>  Introduce tracing capability for sockmap, similar to XDP, to trace=
 the
> >=20
>=20>  execution results of BPF programs without modifying the programs
> >=20
>=20>  themselves, similar to the existing trace_xdp_redirect{_map}.
> >=20
>=20>  It is crucial for debugging BPF programs, especially in production
> >=20
>=20>  environments.
> >=20
>=20>  Additionally, a header file was added to bpf_trace.h to automatica=
lly
> >=20
>=20>  generate tracepoints.
> >=20
>=20>  Test results:
> >=20
>=20>  $ echo "1" > /sys/kernel/tracing/events/sockmap/enable
> >=20
>=20>  skb:
> >=20
>=20>  sockmap_redirect: sk=3D00000000d3266a8d, type=3Dskb, family=3D2, p=
rotocol=3D6, \
> >=20
>=20>  prog_id=3D73, length=3D256, action=3DPASS
> >=20
>=20>  msg:
> >=20
>=20>  sockmap_redirect: sk=3D00000000528c7614, type=3Dmsg, family=3D2, p=
rotocol=3D6, \
> >=20
>=20>  prog_id=3D185, length=3D5, action=3DREDIRECT
> >=20
>=20>  tls:
> >=20
>=20>  sockmap_redirect: sk=3D00000000d04d2224, type=3Dskb, family=3D2, p=
rotocol=3D6, \
> >=20
>=20>  prog_id=3D143, length=3D35, action=3DPASS
> >=20
>=20>  strparser:
> >=20
>=20>  sockmap_skb_strp_parse: sk=3D00000000ecab0b30, family=3D2, protoco=
l=3D6, \
> >=20
>=20>  prog_id=3D170, size=3D5
> >=20
>=20>  Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >=20
>=20>  ---
> >=20
>=20>  MAINTAINERS | 1 +
> >=20
>=20>  include/linux/bpf_trace.h | 2 +-
> >=20
>=20>  include/trace/events/sockmap.h | 89 ++++++++++++++++++++++++++++++=
++++
> >=20
>=20>  net/core/skmsg.c | 6 +++
> >=20
>=20>  4 files changed, 97 insertions(+), 1 deletion(-)
> >=20
>=20>  create mode 100644 include/trace/events/sockmap.h
> >=20
>=20>  diff --git a/MAINTAINERS b/MAINTAINERS
> >=20
>=20>  index a7a1d121a83e..578e16d86853 100644
> >=20
>=20>  --- a/MAINTAINERS
> >=20
>=20>  +++ b/MAINTAINERS
> >=20
>=20>  @@ -4420,6 +4420,7 @@ L: netdev@vger.kernel.org
> >=20
>=20>  L: bpf@vger.kernel.org
> >=20
>=20>  S: Maintained
> >=20
>=20>  F: include/linux/skmsg.h
> >=20
>=20>  +F: include/trace/events/sockmap.h
> >=20
>=20>  F: net/core/skmsg.c
> >=20
>=20>  F: net/core/sock_map.c
> >=20
>=20>  F: net/ipv4/tcp_bpf.c
> >=20
>=20>  diff --git a/include/linux/bpf_trace.h b/include/linux/bpf_trace.h
> >=20
>=20>  index ddf896abcfb6..896346fb2b46 100644
> >=20
>=20>  --- a/include/linux/bpf_trace.h
> >=20
>=20>  +++ b/include/linux/bpf_trace.h
> >=20
>=20>  @@ -3,5 +3,5 @@
> >=20
>=20>  #define __LINUX_BPF_TRACE_H__
> >=20
>=20>=20=20
>=20>=20
>=20>  #include <trace/events/xdp.h>
> >=20
>=20>  -
> >=20
>=20>  +#include <trace/events/sockmap.h>
> >=20
>=20>  #endif /* __LINUX_BPF_TRACE_H__ */
> >=20
>=20>  diff --git a/include/trace/events/sockmap.h b/include/trace/events=
/sockmap.h
> >=20
>=20>  new file mode 100644
> >=20
>=20>  index 000000000000..2a69b011e88f
> >=20
>=20>  --- /dev/null
> >=20
>=20>  +++ b/include/trace/events/sockmap.h
> >=20
>=20>  @@ -0,0 +1,89 @@
> >=20
>=20>  +/* SPDX-License-Identifier: GPL-2.0 */
> >=20
>=20>  +#undef TRACE_SYSTEM
> >=20
>=20>  +#define TRACE_SYSTEM sockmap
> >=20
>=20>  +
> >=20
>=20>  +#if !defined(_TRACE_SOCKMAP_H) || defined(TRACE_HEADER_MULTI_READ=
)
> >=20
>=20>  +#define _TRACE_SOCKMAP_H
> >=20
>=20>  +
> >=20
>=20>  +#include <linux/filter.h>
> >=20
>=20>  +#include <linux/tracepoint.h>
> >=20
>=20>  +#include <linux/bpf.h>
> >=20
>=20>  +#include <linux/skmsg.h>
> >=20
>=20>  +
> >=20
>=20>  +TRACE_DEFINE_ENUM(__SK_DROP);
> >=20
>=20>  +TRACE_DEFINE_ENUM(__SK_PASS);
> >=20
>=20>  +TRACE_DEFINE_ENUM(__SK_REDIRECT);
> >=20
>=20>  +TRACE_DEFINE_ENUM(__SK_NONE);
> >=20
>=20>  +
> >=20
>=20>  +#define show_act(x) \
> >=20
>=20>  + __print_symbolic(x, \
> >=20
>=20>  + { __SK_DROP, "DROP" }, \
> >=20
>=20>  + { __SK_PASS, "PASS" }, \
> >=20
>=20>  + { __SK_REDIRECT, "REDIRECT" }, \
> >=20
>=20>  + { __SK_NONE, "NONE" })
> >=20
>=20>  +
> >=20
>=20>  +#define trace_sockmap_skmsg_redirect(sk, prog, msg, act) \
> >=20
>=20>  + trace_sockmap_redirect((sk), "msg", (prog), (msg)->sg.size, (act=
))
> >=20
>=20>  +
> >=20
>=20>  +#define trace_sockmap_skb_redirect(sk, prog, skb, act) \
> >=20
>=20>  + trace_sockmap_redirect((sk), "skb", (prog), (skb)->len, (act))
> >=20
>=20>  +
> >=20
>=20>  +TRACE_EVENT(sockmap_redirect,
> >=20
>=20>  + TP_PROTO(const struct sock *sk, const char *type,
> >=20
>=20>  + const struct bpf_prog *prog, int length, int act),
> >=20
>=20>  + TP_ARGS(sk, type, prog, length, act),
> >=20
>=20>  +
> >=20
>=20>  + TP_STRUCT__entry(
> >=20
>=20>  + __field(const void *, sk)
> >=20
>=20>  + __field(const char *, type)
> >=20
>=20>  + __field(__u16, family)
> >=20
>=20>  + __field(__u16, protocol)
> >=20
>=20>  + __field(int, prog_id)
> >=20
>=20>  + __field(int, length)
> >=20
>=20>  + __field(int, act)
> >=20
>=20>  + ),
> >=20
>=20>  +
> >=20
>=20>  + TP_fast_assign(
> >=20
>=20>  + __entry->sk =3D sk;
> >=20
>=20>  + __entry->type =3D type;
> >=20
>=20>  + __entry->family =3D sk->sk_family;
> >=20
>=20>  + __entry->protocol =3D sk->sk_protocol;
> >=20
>=20>  + __entry->prog_id =3D prog->aux->id;
> >=20
>=20>  + __entry->length =3D length;
> >=20
>=20>  + __entry->act =3D act;
> >=20
>=20>  + ),
> >=20
>=20>  +
> >=20
>=20>  + TP_printk("sk=3D%p, type=3D%s, family=3D%d, protocol=3D%d, prog_=
id=3D%d, length=3D%d, action=3D%s",
> >=20
>=20>  + __entry->sk, __entry->type, __entry->family, __entry->protocol,
> >=20
>=20>  + __entry->prog_id, __entry->length,
> >=20
>=20>  + show_act(__entry->act))
> >=20
>=20
> sk address is useful if you're going to attach a bpf program to the
> tracepoint. Not so much if you're printing the recorded trace.
>=20
>=20I'd print the netns and the socket inode instead, or in addition to.
> These can be cross-referenced against `lsns` and `ss` output.

Good suggestions. I will print all of this.
sk address helps us track connection more easily.

Thanks~

