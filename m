Return-Path: <bpf+bounces-55612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 403F3A835AB
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 03:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904F28C118F
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 01:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECE31E7C10;
	Thu, 10 Apr 2025 01:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GAcXiJHG"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A173D1E3DEB
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 01:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744247958; cv=none; b=sdJMAousrqeuL5QaSrT5+jJOhVk29ZF42I+7RK0IJNwnpqRaAHIR+SSzmWpcZ/qVgYnPRsnPRuBjQtb8H3PUxrqzH42URa47NNh1bLaXr39jDQuvJH6SZojSGZVvviyWCrsovplf/rFfCdsMTukij+A5i9LFm0wZqitTNNaSRXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744247958; c=relaxed/simple;
	bh=+695x7pXlPBW4JoEVk0G/GsLItaAy4Iw2gNHwnHxeKU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=IEKuKG2dr+EvqcrL2tkh55aFymem+vns/aI/LGWDhsctRzwS5u6I0ybphO53cxomT6z5Z7BLK5W8WCDd1iwwChP2gjraBSbwYFp+GhwDAyfMYF8fHs/JTMuyoVunhpkA9lgJwprIvmo8l/P+HPtZMLlgmgvigYgtAc7f2xk8ykk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GAcXiJHG; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744247952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwjIhL5eq5nuQH6KgO5e7NYXc2vM8c1wzFZaJmX6O2s=;
	b=GAcXiJHGnyDBkayIqUeCiyu7aMXAjter9wJQKpd97FONtEJHyKqKoDubyMXwzB1eWQfFoL
	/83eZu+U7YthXohR6oeZYn4FdhhjnTIS3NqIVs/NexOPxf24HlwtTMd73gYpb3NwLJPisK
	IkrroqAAaGWUJnaEeTYmMIJqFKlOUGM=
Date: Thu, 10 Apr 2025 01:19:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <b560604b7b97a58d13c60655747b30a5b9f27a4d@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v1] bpf, sockmap: Introduce tracing capability
 for sockmap
To: "Cong Wang" <xiyou.wangcong@gmail.com>
Cc: bpf@vger.kernel.org, mrpre@163.com, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "KP Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Steven Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu"
 <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
In-Reply-To: <Z/aosJ3uvzTZTEXS@pop-os.localdomain>
References: <20250409102937.15632-1-jiayuan.chen@linux.dev>
 <Z/aosJ3uvzTZTEXS@pop-os.localdomain>
X-Migadu-Flow: FLOW_OUT

April 10, 2025 at 01:04, "Cong Wang" <xiyou.wangcong@gmail.com> wrote:
>=20
>=20On Wed, Apr 09, 2025 at 06:29:33PM +0800, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> Sockmap has the same high-performance forwarding capability as XDP,=
 but
> >=20
>=20>  operates at Layer 7.
> >=20
>=20>=20=20
>=20>=20
>=20>  Introduce tracing capability for sockmap, similar to XDP, to trace=
 the
> >=20
>=20>  execution results of BPF programs without modifying the programs
> >=20
>=20>  themselves, similar to the existing trace_xdp_redirect{_map}.
> >=20
>=20>=20=20
>=20>=20
>=20>  It is crucial for debugging BPF programs, especially in production
> >=20
>=20>  environments.
> >=20
>=20>=20=20
>=20>=20
>=20>  Additionally, a header file was added to bpf_trace.h to automatica=
lly
> >=20
>=20>  generate tracepoints.
> >=20
>=20>=20=20
>=20>=20
>=20>  Test results:
> >=20
>=20>  $ echo "1" > /sys/kernel/tracing/events/sockmap/enable
> >=20
>=20>=20=20
>=20>=20
>=20>  skb:
> >=20
>=20>  sockmap_redirect: sk=3D00000000d3266a8d, type=3Dskb, family=3D2, p=
rotocol=3D6, \
> >=20
>=20>  prog_id=3D73, length=3D256, action=3DPASS
> >=20
>=20>=20=20
>=20>=20
>=20>  msg:
> >=20
>=20>  sockmap_redirect: sk=3D00000000528c7614, type=3Dmsg, family=3D2, p=
rotocol=3D6, \
> >=20
>=20>  prog_id=3D185, length=3D5, action=3DREDIRECT
> >=20
>=20>=20=20
>=20>=20
>=20>  tls:
> >=20
>=20>  sockmap_redirect: sk=3D00000000d04d2224, type=3Dskb, family=3D2, p=
rotocol=3D6, \
> >=20
>=20>  prog_id=3D143, length=3D35, action=3DPASS
> >=20
>=20>=20=20
>=20>=20
>=20>  strparser:
> >=20
>=20>  sockmap_skb_strp_parse: sk=3D00000000ecab0b30, family=3D2, protoco=
l=3D6, \
> >=20
>=20>  prog_id=3D170, size=3D5
> >=20
>=20
> Nice work!
>=20
>=20While you are on it, could we also trace skb->_sk_redir bits too? It =
is
>=20
>=20very useful to distinguish, at least, ingress from egress redirection=
.
>=20
>=20Thanks!
>

Thanks for your suggestion!
The skb->_sk_redir contains a lot of important information about
redirection, so it's definitely worth including.

