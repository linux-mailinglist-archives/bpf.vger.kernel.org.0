Return-Path: <bpf+bounces-55920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 261FAA8927B
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 05:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3260B17941C
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 03:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C6E2185A6;
	Tue, 15 Apr 2025 03:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D1Xcyjef"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7AC2147E0
	for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 03:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744686993; cv=none; b=q11L/CA5ydKfTwybxl7BTnH7IecYdupRsHjCGKhHUyf3uRvIjTv3CIVKAj0/MNAlV7FTYRS2ewvcK0lrbhweTc8jgEB/ZBGH4kSxlUSE+Y+KxdXee/w5QfMK3mxu4D7eCldL9i1GfaVmKQ2jS+KUkw3TpP0Wlw9YXi4ScjNCQQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744686993; c=relaxed/simple;
	bh=egYq5oQ8uWxK01aUz4bqh3F5CRFMzIP7009xke1jJOs=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=OK5l4s0uiwrP9xSZIZnXASVfHs/Jc8PbTdYw2sl8tvjx1lXg1scASn7Ow9Kj84yivPBDBLvx+b25lKB1v4OEvP1YMsS+53A2TudTq4OKnwQyRI5UY6LuYC0WGjZ1CL0VzKunqUyFH37ZLUcKEIvy9x16H/zuZtnOS6RZ0BAnOXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D1Xcyjef; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744686989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NVECWiEciGZO2Y89k4JZZArkGKsMmKIC5OfnrLxA/Ks=;
	b=D1XcyjefqoNuPvIsJKqr+vx7DBatxPNW0PZaQO/pyFwVmW87dKXHK9Qgs2VnJHuAbcbXnT
	xX7+cxj820Y9wJe9oNdFH1nKS9BKnWRTsGj+1tQXpORoptUz4qLGAWbLzAoPWFzGRJmy/H
	KIiZT0Shm9WN27N5gzwSHHHqUnv1+lM=
Date: Tue, 15 Apr 2025 03:16:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <e0ea9f710fde34bdce42515f8c68722015403ab9@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net 1/2] net: tls: explicitly disallow disconnect
To: "Jakub Kicinski" <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, borisp@nvidia.com,
 john.fastabend@gmail.com, sd@queasysnail.net, "Jakub Kicinski"
 <kuba@kernel.org>, syzbot+b4cd76826045a1eb93c1@syzkaller.appspotmail.com,
 bpf@vger.kernel.org, jiayuan.chen@linux.dev, "Alexei Starovoitov"
 <ast@kernel.org>
In-Reply-To: <20250404180334.3224206-1-kuba@kernel.org>
References: <20250404180334.3224206-1-kuba@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 4/4/25 11:03 AM, Jakub Kicinski wrote:
> syzbot discovered that it can disconnect a TLS socket and then
> run into all sort of unexpected corner cases. I have a vague
> recollection of Eric pointing this out to us a long time ago.
> Supporting disconnect is really hard, for one thing if offload
> is enabled we'd need to wait for all packets to be _acked_.
> Disconnect is not commonly used, disallow it.
>
> The immediate problem syzbot run into is the warning in the strp,
> but that's just the easiest bug to trigger:
>
>   WARNING: CPU: 0 PID: 5834 at net/tls/tls_strp.c:486 tls_strp_msg_load=
+0x72e/0xa80 net/tls/tls_strp.c:486
>   RIP: 0010:tls_strp_msg_load+0x72e/0xa80 net/tls/tls_strp.c:486
>   Call Trace:
>    <TASK>
>    tls_rx_rec_wait+0x280/0xa60 net/tls/tls_sw.c:1363
>    tls_sw_recvmsg+0x85c/0x1c30 net/tls/tls_sw.c:2043
>    inet6_recvmsg+0x2c9/0x730 net/ipv6/af_inet6.c:678
>    sock_recvmsg_nosec net/socket.c:1023 [inline]
>    sock_recvmsg+0x109/0x280 net/socket.c:1045
>    __sys_recvfrom+0x202/0x380 net/socket.c:2237
>
> Fixes: 3c4d7559159b ("tls: kernel TLS support")
> Reported-by: syzbot+b4cd76826045a1eb93c1@syzkaller.appspotmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Hi everyone.

This patch has broken a BPF selftest and as a result BPF CI:
* https://github.com/kernel-patches/bpf/actions/runs/14458537639
* https://github.com/kernel-patches/bpf/actions/runs/14457178732

The test in question is test_sockmap_ktls_disconnect_after_delete
(tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c) [1].

Since the test is about disconnect use-case, and the patch disallows
it, I assume it's appropriate to simply remove the test?

Please let me know. Thanks.

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/=
tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c#n28

> ---
>  net/tls/tls_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index cb86b0bf9a53..a3ccb3135e51 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -852,6 +852,11 @@ static int tls_setsockopt(struct sock *sk, int lev=
el, int optname,
>  	return do_tls_setsockopt(sk, optname, optval, optlen);
>  }
>=20=20
>=20+static int tls_disconnect(struct sock *sk, int flags)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  struct tls_context *tls_ctx_create(struct sock *sk)
>  {
>  	struct inet_connection_sock *icsk =3D inet_csk(sk);
> @@ -947,6 +952,7 @@ static void build_protos(struct proto prot[TLS_NUM_=
CONFIG][TLS_NUM_CONFIG],
>  	prot[TLS_BASE][TLS_BASE] =3D *base;
>  	prot[TLS_BASE][TLS_BASE].setsockopt	=3D tls_setsockopt;
>  	prot[TLS_BASE][TLS_BASE].getsockopt	=3D tls_getsockopt;
> +	prot[TLS_BASE][TLS_BASE].disconnect	=3D tls_disconnect;
>  	prot[TLS_BASE][TLS_BASE].close		=3D tls_sk_proto_close;
>=20=20
>=20 	prot[TLS_SW][TLS_BASE] =3D prot[TLS_BASE][TLS_BASE];

