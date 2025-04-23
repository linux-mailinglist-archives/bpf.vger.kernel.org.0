Return-Path: <bpf+bounces-56544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5400A99B7D
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 00:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149B317D7F6
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 22:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D4A201264;
	Wed, 23 Apr 2025 22:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwHxWrxI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9471DE4E6;
	Wed, 23 Apr 2025 22:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745447015; cv=none; b=GX8WSwZRQPFsCWEL4IW/CzckejVliKHFUkC7NCC4DzooQPmXqMc3jy4pers/ZNstxXgbO2xTq7qKZervLx4b5SqAQXO2TE5gXK6Obxhs5ycTL6HoYWevdbLlR7HfkdXwdYtzfHh89OwjOQHRjXL/ZJ+Fq5ndfsEN8/okl6gz+BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745447015; c=relaxed/simple;
	bh=qqSBEb+/qPVwuJ9A5adUvrR49J/1UvzOCF45ID5ipMA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aOccdRkg8lbHvJvv0rDcDLfFhwtl0iVkcTKY/UsS+QlumS+uNL92Yu+IVqHGGcOX5Smmd/xZn1j4/aOJrc9UcQW4J3yGeK48DfiJEaMaZ6At0rWEN+Niekv/hSFObqJmsIz+ndkwUNMIXXUQXhV+cRiV2HFrP7wLol5f68bqfjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwHxWrxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15BDC4CEE2;
	Wed, 23 Apr 2025 22:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745447014;
	bh=qqSBEb+/qPVwuJ9A5adUvrR49J/1UvzOCF45ID5ipMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kwHxWrxIYnB2RawAF8JmxUsZPpPerbNkwWAJDkN7tShsZyr/hzL8LOEFamcjqxae5
	 CMsYkZZglwWTd9dbqlv9PslT/ckoFLcZ5SppzQtcMCz4Zj6S2F5NbtS0kCfZase2gS
	 6HS5Q6QcVajj9R2er+oaPald3LQ0+wjb4OS2AVaMQ2l4d6OHDUZUZfrNrTGjdeJOfK
	 rqaqPXA2w5DnunXDCdtfYc1whn7usIJ7QlimT6xu82Vf7s9hbo1VPg/ulwPKJ7dCZm
	 p/ymqyz3YKQHHoE6h/TAjAwbcAnRIL1h24LzHBi5FsQ8fwB9ynTW7svac74yb+JUzn
	 0VvnJtlSdK3Ww==
Date: Wed, 23 Apr 2025 15:23:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 4/4] selftests: net: add a virtio_net deadlock
 selftest
Message-ID: <20250423152333.68117196@kernel.org>
In-Reply-To: <aac402b4-d04c-4d7e-91c8-ab6c20c9a74d@gmail.com>
References: <20250417072806.18660-1-minhquangbui99@gmail.com>
	<20250417072806.18660-5-minhquangbui99@gmail.com>
	<20250422184151.2fb4fffe@kernel.org>
	<aac402b4-d04c-4d7e-91c8-ab6c20c9a74d@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Apr 2025 22:20:41 +0700 Bui Quang Minh wrote:
> I've tried to make the setup_xsk into each test. However, I've an issue=20
> that the XDP socket destruct waits for an RCU grace period as I see this=
=20
> sock's flag SOCK_RCU_FREE is set. So if we start the next test right=20
> away, we can have the error when setting up XDP socket again because=20
> previous XDP socket has not unbound the network interface's queue yet. I=
=20
> can resolve the issue by putting the sleep(1) after closing the socket=20
> in xdp_helper:
>=20
> diff --git a/tools/testing/selftests/net/lib/xdp_helper.c=20
> b/tools/testing/selftests/net/lib/xdp_helper.c
> index f21536ab95ba..e882bb22877f 100644
> --- a/tools/testing/selftests/net/lib/xdp_helper.c
> +++ b/tools/testing/selftests/net/lib/xdp_helper.c
> @@ -162,5 +162,6 @@ int main(int argc, char **argv)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 close(sock_fd);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sleep(1);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>  =C2=A0}
>=20
> Do you think it's enough or do you have a better suggestion here?

Interesting :S What errno does the kernel return? EBUSY?
Perhaps we could loop for a second retrying the bind()
if kernel returns EBUSY in case it's just a socket waiting
to be cleaned up?

