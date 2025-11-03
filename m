Return-Path: <bpf+bounces-73347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 046C7C2BD69
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 13:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAD224EFB07
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 12:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363CB2E62A6;
	Mon,  3 Nov 2025 12:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RmGgkokm"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847652DF719
	for <bpf@vger.kernel.org>; Mon,  3 Nov 2025 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173867; cv=none; b=pV64uK4spgeQ96+af8uOLcjXqjeqtt/HAjxjDT5vaKVm4E9EAzY7iiITTDz+R5Pao7Fx3JyAtIqZ2doTi1g88j7zOWvT/2V7ycolOngqY7kqFacBwyzIFz6f4uab5A++88Ztu2pLgzzacf8y8q5Cnwe+vUfwofHqVQY4GpxAnGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173867; c=relaxed/simple;
	bh=vT6PArFNlD9ATQBYI/ysNDAumFVMhzxz9dljQq1FEo4=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=jDIgKKQPwlGeptfPI/WrCNGAF/ytKU6f7nwKkTS6KAfHklf1dP/Bqy3G2CUBQU70OYKJxDsmH1h8IINNl/mbUjz+g3h0Fjq4Sup1HEILU4HMJy7BWIkj3pOZqXFY/5ysvmLSn01bteKlx9f/ens2nGHLIKLa9q8odhiYSg3M4Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RmGgkokm; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762173862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HCESdiFfePQnHxAf5Hjx+NZwOKZOc1DIfGTWc/CkQFI=;
	b=RmGgkokmZWSo8UB9yGc4Wq07j7MdQpgB0b3cW0rSbLfwQyuO9LTYotTkkJPN3r4augRIlF
	l7yY27AMCqp6lE9/YHUWl6UdnxZg/JOhepCTkF7MTPAISgKfqjWtkrarP+kHNzCwFXBDP/
	MJigcA7V0TLszG04FEJ92ouXtktg/jA=
Date: Mon, 03 Nov 2025 12:44:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <3ddd7d72644ebd5826caa244cad6a6491410c00a@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v3 1/3] net,mptcp: fix proto fallback detection with
 BPF sockmap
To: "Paolo Abeni" <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: stable@vger.kernel.org, "Jakub Sitnicki" <jakub@cloudflare.com>, "John
 Fastabend" <john.fastabend@gmail.com>, "Eric Dumazet"
 <edumazet@google.com>, "Kuniyuki Iwashima" <kuniyu@google.com>, "Willem
 de Bruijn" <willemb@google.com>, "David S. Miller" <davem@davemloft.net>,
 "Jakub Kicinski" <kuba@kernel.org>, "Simon Horman" <horms@kernel.org>,
 "Matthieu Baerts" <matttbe@kernel.org>, "Mat Martineau"
 <martineau@kernel.org>, "Geliang Tang" <geliang@kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "KP
 Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao
 Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, "Florian Westphal" <fw@strlen.de>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
In-Reply-To: <c10939d2-437e-47fb-81e9-05723442c935@redhat.com>
References: <20251023125450.105859-1-jiayuan.chen@linux.dev>
 <20251023125450.105859-2-jiayuan.chen@linux.dev>
 <c10939d2-437e-47fb-81e9-05723442c935@redhat.com>
X-Migadu-Flow: FLOW_OUT

October 28, 2025 at 19:30, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni=
@redhat.com?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:


>=20
>=20On 10/23/25 2:54 PM, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> When the server has MPTCP enabled but receives a non-MP-capable req=
uest
> >  from a client, it calls mptcp_fallback_tcp_ops().
> >=20=20
>=20>  Since non-MPTCP connections are allowed to use sockmap, which repl=
aces
> >  sk->sk_prot, using sk->sk_prot to determine the IP version in
> >  mptcp_fallback_tcp_ops() becomes unreliable. This can lead to assign=
ing
> >  incorrect ops to sk->sk_socket->ops.
> >=20
>=20I don't see how sockmap could modify the to-be-accepted socket sk_pro=
t
> before mptcp_fallback_tcp_ops(), as such call happens before the fd is
> installed, and AFAICS sockmap can only fetch sockets via fds.
>=20
>=20Is this patch needed?

"mptcp_fallback_tcp_ops" is only called during the accept process. Howeve=
r,
before that, for an already established TCP socket, its sk_prot is replac=
ed via the following path:
tcp_rcv_state_process()
  tcp_init_transfer(BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB)
    call bpf prog
        bpf_sock_map_update(sk)
           tcp_bpf_update_proto()

However, after discussing with Matthieu, we've concluded that this patch =
is indeed no
longer necessary, as we have a simpler way to intercept the operation."

Thanks~

