Return-Path: <bpf+bounces-74445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0168EC5AEE5
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 02:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5CB843437A2
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 01:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93581261B8C;
	Fri, 14 Nov 2025 01:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t/xuhW6c"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B18239E7E
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 01:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763084211; cv=none; b=Y9JijyB/BOZze+TMnx+Lio/ROpoSAYpXLwmvvzNc7KFTfSYOCvyqQVREXQW7pZtglWjUrPYbAUfGa6Vt77IX3gVRfibg3b00olYR+N5zWCu2GfFGnkYXi+c0OT1ovEZQPprLxRE6C9pPrCMf2tSyS7bvdd4F6rC0CrQzDhTkrr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763084211; c=relaxed/simple;
	bh=184T6RWPKkrI9yGxqY80YK5leWWcLPxzmE9thnr28BY=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Dmf9TaNpeF7Pjh7CJ20Ycbz416WoTvmCbgQq0irrGpdbLiPboLlUU/maPtMXgVxe7wbo6S6jGZVnx/JgP1BuGkfBXZcFIOCHu/PDVMK2czMvYtMZYnT8P8l3OqfK0OA+lMVcoejbRQbOwDoeWB6aqgPvNNToY4qXcoPT1nQ57ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t/xuhW6c; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763084195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rhAvhoW0qGIKNwEfFjd214od0HqLgMRWs7YHTP4WZaA=;
	b=t/xuhW6cYzNRhoXeqwXsrq+DVpCFpEEZ10t9Hro34mdAneBTjRM8fcvOodXL4GzWCL08QT
	w5yBZIDqjrzULT/Bml/Q14gUs+7099w1Lo6UWJV/hf+EAI+ry5Q8OoKTumBnDTAaCcoI57
	h0iRQ7TrtIz0Fbe6Uq3NbwiDiI7zRGo=
Date: Fri, 14 Nov 2025 01:36:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <c052bf6e1e5584b806c41dcb63a1d67f6aafa293@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v5 3/3] selftests/bpf: Add mptcp test with sockmap
To: "Martin KaFai Lau" <martin.lau@linux.dev>, "Matthieu Baerts"
 <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, "Mat Martineau" <martineau@kernel.org>, "Geliang
 Tang" <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>, "Florian Westphal"
 <fw@strlen.de>, "Christoph Paasch" <cpaasch@apple.com>, "Peter Krystad"
 <peter.krystad@linux.intel.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
In-Reply-To: <a92e2c4a-bfde-4a74-8bb5-5e2b8ca87199@linux.dev>
References: <20251111060307.194196-1-jiayuan.chen@linux.dev>
 <20251111060307.194196-4-jiayuan.chen@linux.dev>
 <a92e2c4a-bfde-4a74-8bb5-5e2b8ca87199@linux.dev>
X-Migadu-Flow: FLOW_OUT

2025/11/14 05:48, "Martin KaFai Lau" <martin.lau@linux.dev mailto:martin.=
lau@linux.dev?to=3D%22Martin%20KaFai%20Lau%22%20%3Cmartin.lau%40linux.dev=
%3E > =E5=86=99=E5=88=B0:


>=20
>=20>=20
>=20> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools=
/testing/selftests/bpf/prog_tests/mptcp.c
> >  index f8eb7f9d4fd2..b976fe626343 100644
> >  --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> >  +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> >  @@ -6,11 +6,14 @@
> >  #include <netinet/in.h>
> >  #include <test_progs.h>
> >  #include <unistd.h>
> >  +#include <error.h>
> >=20
>=20I changed to errno.h to be specific. I think you only need the values=
 of an errno here.
>=20
>=20>=20
>=20> #include "cgroup_helpers.h"
> >  #include "network_helpers.h"
> >  +#include "socket_helpers.h"
> >  #include "mptcp_sock.skel.h"
> >  #include "mptcpify.skel.h"
> >  #include "mptcp_subflow.skel.h"
> >  +#include "mptcp_sockmap.skel.h"
> >  > #define NS_TEST "mptcp_ns"
> >  #define ADDR_1 "10.0.1.1"
> >  @@ -436,6 +439,142 @@ static void test_subflow(void)
> >  close(cgroup_fd);
> >  }
> >  > +/* Test sockmap on MPTCP server handling non-mp-capable clients. =
*/
> >  +static void test_sockmap_with_mptcp_fallback(struct mptcp_sockmap *=
skel)
> >  +{
> >  + int listen_fd =3D -1, client_fd1 =3D -1, client_fd2 =3D -1;
> >  + int server_fd1 =3D -1, server_fd2 =3D -1, sent, recvd;
> >  + char snd[9] =3D "123456789";
> >  + char rcv[10];
> >  +
> >  + /* start server with MPTCP enabled */
> >  + listen_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
> >  + if (!ASSERT_OK_FD(listen_fd, "sockmap-fb:start_mptcp_server"))
> >  + return;
> >  +
> >  + skel->bss->trace_port =3D ntohs(get_socket_local_port(listen_fd));
> >  + skel->bss->sk_index =3D 0;
> >  + /* create client without MPTCP enabled */
> >  + client_fd1 =3D connect_to_fd_opts(listen_fd, NULL);
> >  + if (!ASSERT_OK_FD(client_fd1, "sockmap-fb:connect_to_fd"))
> >  + goto end;
> >  +
> >  + server_fd1 =3D xaccept_nonblock(listen_fd, NULL, NULL);
> >  + skel->bss->sk_index =3D 1;
> >  + client_fd2 =3D connect_to_fd_opts(listen_fd, NULL);
> >  + if (!ASSERT_OK_FD(client_fd2, "sockmap-fb:connect_to_fd"))
> >  + goto end;
> >  +
> >  + server_fd2 =3D xaccept_nonblock(listen_fd, NULL, NULL);
> >  + /* test normal redirect behavior: data sent by client_fd1 can be
> >  + * received by client_fd2
> >  + */
> >  + skel->bss->redirect_idx =3D 1;
> >  + sent =3D xsend(client_fd1, snd, sizeof(snd), 0);
> >  + if (!ASSERT_EQ(sent, sizeof(snd), "sockmap-fb:xsend(client_fd1)"))
> >  + goto end;
> >  +
> >  + /* try to recv more bytes to avoid truncation check */
> >  + recvd =3D recv_timeout(client_fd2, rcv, sizeof(rcv), MSG_DONTWAIT,=
 2);
> >=20
>=20I removed the socket_helpers.h usage. The _nonblock, _timeout, and
> MSG_DONTWAIT are unnecessary. I replaced them with the regular accept,
> send, and recv. All fds from network_helpers.c have a default 3s
> timeout instead of 30s in xaccept_nonblock. This matches how most of
> the selftests/bpf are doing it as well.
>=20
>=20I also touched up the commit message in patch 2 based on Matt's comme=
nt.
>=20
>=20Applied. Thanks.
>=20

Thanks=20for the cleanup and applying!

