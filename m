Return-Path: <bpf+bounces-55944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74190A89A9C
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 12:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904DF3AA83F
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 10:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8929028BA89;
	Tue, 15 Apr 2025 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="myBOLQ1I"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6501728BAAE
	for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744713811; cv=none; b=coZ4bNb7JOzLK+ksAyi/zoyq0M3PZjJSTuGt4GTA20QIcU7McSafedNRFqtXnF5/WrmfP+CFDPRmqSNpLysmQd5PYm9aNFiUnxtJllmoW3O22WHYu6I2UXSTbyvRFWxFBDC2O1I+MhF27o7vRXUAoCEcrOa2JAELaEvyfFDdWRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744713811; c=relaxed/simple;
	bh=4U96eowgfbvaJlzDFToCTa/U5/w4n4+bF3SOKBLWlzQ=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=KreIPyNhtdHzA8YQJ71OB4DaOs404RykBW4UJ4uN1xqH82zPLDGxQZUoOMbrJ6Ba8gxqyogHMLricLkHG6vNFxrZH2Juz2EHqkY6E/Kotnc71/oI/VcPg2k5l7ULgxd/LfVHeFYnkEMmzWbPS0sl6wuc7R6QsSxtOwIYDtlt/1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=myBOLQ1I; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744713796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KqiOn2VInB+Asd2vXJW680IADszcS3SrPzukVOXmi7Y=;
	b=myBOLQ1IuzYKH87xWhc/cQHLiBf/V0SWXRHYF5e8u9h8qtPF7IM5AeZehFWwhQ5YIaX2G0
	IohGMKwu7bx4Yt7z1ykpaVZuP2iorfmcnr/utgO5v4SvoTVUDsCy2fXd29SFcq9LR63l/+
	v8AocLzRN3Mzcleemn8qbI7adr2t/5E=
Date: Tue, 15 Apr 2025 10:43:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <8d7a4c203ef9ac8ac359dcfd6684e8ec074f8e84@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net 1/2] net: tls: explicitly disallow disconnect
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Jakub Kicinski"
 <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, borisp@nvidia.com,
 john.fastabend@gmail.com, sd@queasysnail.net, "Jakub Kicinski"
 <kuba@kernel.org>, syzbot+b4cd76826045a1eb93c1@syzkaller.appspotmail.com,
 bpf@vger.kernel.org, "Alexei Starovoitov" <ast@kernel.org>
In-Reply-To: <e0ea9f710fde34bdce42515f8c68722015403ab9@linux.dev>
References: <20250404180334.3224206-1-kuba@kernel.org>
 <e0ea9f710fde34bdce42515f8c68722015403ab9@linux.dev>
X-Migadu-Flow: FLOW_OUT

April 15, 2025 at 11:16, "Ihor Solodrai" <ihor.solodrai@linux.dev> wrote:



>=20
>=20On 4/4/25 11:03 AM, Jakub Kicinski wrote:
>=20
>=20>=20
>=20> syzbot discovered that it can disconnect a TLS socket and then
> >=20
>=20>  run into all sort of unexpected corner cases. I have a vague
> >=20
>=20>  recollection of Eric pointing this out to us a long time ago.
> >=20
>=20>  Supporting disconnect is really hard, for one thing if offload
> >=20
>=20>  is enabled we'd need to wait for all packets to be _acked_.
> >=20
>=20>  Disconnect is not commonly used, disallow it.
> >=20
>=20>  The immediate problem syzbot run into is the warning in the strp,
> >=20
>=20>  but that's just the easiest bug to trigger:
> >=20
>=20>  WARNING: CPU: 0 PID: 5834 at net/tls/tls_strp.c:486 tls_strp_msg_l=
oad+0x72e/0xa80 net/tls/tls_strp.c:486
> >=20
>=20>  RIP: 0010:tls_strp_msg_load+0x72e/0xa80 net/tls/tls_strp.c:486
> >=20
>=20>  Call Trace:
> >=20
>=20>  <TASK>
> >=20
>=20>  tls_rx_rec_wait+0x280/0xa60 net/tls/tls_sw.c:1363
> >=20
>=20>  tls_sw_recvmsg+0x85c/0x1c30 net/tls/tls_sw.c:2043
> >=20
>=20>  inet6_recvmsg+0x2c9/0x730 net/ipv6/af_inet6.c:678
> >=20
>=20>  sock_recvmsg_nosec net/socket.c:1023 [inline]
> >=20
>=20>  sock_recvmsg+0x109/0x280 net/socket.c:1045
> >=20
>=20>  __sys_recvfrom+0x202/0x380 net/socket.c:2237
> >=20
>=20>  Fixes: 3c4d7559159b ("tls: kernel TLS support")
> >=20
>=20>  Reported-by: syzbot+b4cd76826045a1eb93c1@syzkaller.appspotmail.com
> >=20
>=20>  Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> >=20
>=20
> Hi everyone.
>=20
>=20This patch has broken a BPF selftest and as a result BPF CI:
>=20
>=20* https://github.com/kernel-patches/bpf/actions/runs/14458537639
>=20
>=20* https://github.com/kernel-patches/bpf/actions/runs/14457178732
>=20
>=20The test in question is test_sockmap_ktls_disconnect_after_delete
>=20
>=20(tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c) [1].
>=20
>=20Since the test is about disconnect use-case, and the patch disallows
>=20
>=20it, I assume it's appropriate to simply remove the test?
>=20
>=20Please let me know. Thanks.
>=20
>=20[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/t=
ree/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c#n28
>=20
>=20>=20
>=20> ---
> >  net/tls/tls_main.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >  diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> >  index cb86b0bf9a53..a3ccb3135e51 100644
> >  --- a/net/tls/tls_main.c
> >  +++ b/net/tls/tls_main.c
> >  @@ -852,6 +852,11 @@ static int tls_setsockopt(struct sock *sk, int =
level, int optname,
> >  return do_tls_setsockopt(sk, optname, optval, optlen);
> >  }
> >=20
>=20>=20=20
>=20>  +static int tls_disconnect(struct sock *sk, int flags)
> >=20
>=20>  +{
> >  + return -EOPNOTSUPP;
> >  +}
> >  +
> >  struct tls_context *tls_ctx_create(struct sock *sk)
> >  {
> >  struct inet_connection_sock *icsk =3D inet_csk(sk);
> >=20
>=20>  @@ -947,6 +952,7 @@ static void build_protos(struct proto prot[TLS=
_NUM_CONFIG][TLS_NUM_CONFIG],
> >=20
>=20>  prot[TLS_BASE][TLS_BASE] =3D *base;
> >  prot[TLS_BASE][TLS_BASE].setsockopt =3D tls_setsockopt;
> >  prot[TLS_BASE][TLS_BASE].getsockopt =3D tls_getsockopt;
> >  + prot[TLS_BASE][TLS_BASE].disconnect =3D tls_disconnect;
> >  prot[TLS_BASE][TLS_BASE].close =3D tls_sk_proto_close;
> >=20
>=20>=20
>=20>  prot[TLS_SW][TLS_BASE] =3D prot[TLS_BASE][TLS_BASE];
> >
>

The original selftest patch d1ba1204f2ee was to re-produce the endless
loop fiexed by 4da6a196f93b.

sk->sk_prot->unhash
        tcp_bpf_unhash
            sk->sk_prot->unhash
                ...
It's try to use disconnect to trigger unhash handler.
I believe we can remove it and use another selftest
instead later.

