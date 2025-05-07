Return-Path: <bpf+bounces-57614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B717AAD424
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 05:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986E63BB0EC
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 03:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573001B4153;
	Wed,  7 May 2025 03:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t8fcsH4n"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0478619343B
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 03:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746589057; cv=none; b=NdszwYgVVRVAGp+IuIxU3gNZY83UWvvziFNKFnYYTLFem7jfMXZjBIEDZoit5V8yh9+pTFWLf86MoP8611HAZBrgfhR8ZoUjFKo+P+C9tbw2mohWG8zMRWOvoR4JXT7MJAo5ZgBnRQWEDVjTUBaOV6rlBUnFnt3qynMgTKWIMdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746589057; c=relaxed/simple;
	bh=Ii2HsbsJCi+o1eq0rP0UpxufBNOzNtLUmYan93+sP2g=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=U/TFstQ34GnI1u02VneA7MkU5EbafdpaEbYjB6IGir5hcxc8qf6FC4Uz+T8cynqL2qRw7eUz/wQ08BGkIcB8IABSCHFitmIOHYFbACR85Y1SPLBqrJQuQeREQLFScwYN2KEkbXavgJa8MKLCwNw7zy5hvfZUUB31X+UKP5FD9Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t8fcsH4n; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746589043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IOssk0YASQZK9VWKknBMj0km7yOvtPSfKPB8Te1c8xg=;
	b=t8fcsH4ncz3hp4xC8IN8nYQxChcrR/9K7LXfLj5pSoCyMwqDfK0zkrDcD4dgBhDdFU32+V
	OYLw8RFVkTH4rqkZ6eVerBlUINPBNGJJULrzKvPye4zPmVJCx8mSdHFx5UJUFv4ICUDMfs
	ka7pWGMieySXEoO4RrQPC7xViWVdBoY=
Date: Wed, 07 May 2025 03:37:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <9c311d9944fa57cec75e06cde94496d782fe4980@linux.dev>
TLS-Required: No
Subject: Re: [RESEND PATCH bpf-next v4 1/2] bpf, sockmap: Introduce tracing
 capability for sockmap
To: "Martin KaFai Lau" <martin.lau@linux.dev>, "Jakub Sitnicki"
 <jakub@cloudflare.com>, "John Fastabend" <john.fastabend@gmail.com>
Cc: "Cong Wang" <xiyou.wangcong@gmail.com>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "KP Singh"
 <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo"
 <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Masami Hiramatsu"
 <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <b776fa07-de4b-44be-ae68-8bc8c362ea81@linux.dev>
References: <20250506025131.136929-1-jiayuan.chen@linux.dev>
 <b776fa07-de4b-44be-ae68-8bc8c362ea81@linux.dev>
X-Migadu-Flow: FLOW_OUT

May 7, 2025 at 04:24, "Martin KaFai Lau" <martin.lau@linux.dev> wrote:

>=20
>=20On 5/5/25 7:51 PM, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> Sockmap has the same high-performance forwarding capability as XDP,=
 but
> >=20
>=20>  operates at Layer 7.
> >=20
>=20>  Introduce tracing capability for sockmap, to trace the execution r=
esults
> >=20
>=20>  of BPF programs without modifying the programs themselves, similar=
 to
> >=20
>=20>  the existing trace_xdp_redirect{_map}.
> >=20
>=20
> There were advancements in bpf tracing since the trace_xdp_xxx addition=
s.
>=20
>=20Have you considered the fexit bpf prog and why it is not sufficient ?
>=20

1.This=20patchset prints a large amount of information (e.g. inode ID, et=
c.),
some of which require kernel-internal helpers to access. These helpers ar=
e
not currently available as kfuncs, making it difficult to implement
equivalent functionality with fentry/fexit.

2. skb->_sk_redir implicitly stores both a redir action and the socket ad=
dress
in a single field. Decoding this structure in fentry/fexit would require
duplicating kernel-internal logic in BPF programs. This creates maintenan=
ce
risks, as any future changes to the kernel's internal representation woul=
d
necessitate corresponding updates to the BPF programs.

3. Similar to the debate between using built-in tracepoints vs kprobes/fe=
ntry,
each approach has its tradeoffs. The key advantage of a built-in tracepoi=
nt is
seamless integration with existing tools like perf and bpftrace, which na=
tively
support tracepoint-based tracing. For example, simply executing
'perf trace -e 'sockmap:*' ./producer' could provide sufficient visibilit=
y
without custom BPF programs.

