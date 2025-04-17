Return-Path: <bpf+bounces-56082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B381A90FFF
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 02:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B8546040C
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 00:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E43846C;
	Thu, 17 Apr 2025 00:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hr7E1RmL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C042479CF;
	Thu, 17 Apr 2025 00:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744848539; cv=none; b=BaJ3Ryej6OupE+K2VoFtl+hfhN+q13sL9+haIJAe+o0PkOPsKUaRs4VgNLyZN+uEDZvZUAtMZ6ZrrQnzDPybiGJtmszgFqrEzSmVEQRsb/TIEy0k8O8o7AF9mXYbMCQkwCbUusRd6pgr/tCu7p1llJ3bdtPNeauY08fqdeSE2rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744848539; c=relaxed/simple;
	bh=VS3LVZY+zuP2UHLVuC8I4hhS1Y2XmPsmcUWcoKDowOo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZ6XgzXz+2sz4PFuEdrnINPH8QufcU+BzoUyB8RjjPw3SpUenWOwJzsr6CeQ2y6rvQRsY/1/vCUUuoGz/MfGqsqz1AUwy+/M84mjLJFKsqU9SusoPwtNOJPVCA2DM3uqSKpYFr9+ThxIwNWjzUV6zgGAMR4Xodki8bQixCS2Pc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hr7E1RmL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC42C4CEE2;
	Thu, 17 Apr 2025 00:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744848539;
	bh=VS3LVZY+zuP2UHLVuC8I4hhS1Y2XmPsmcUWcoKDowOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hr7E1RmL3siQy77g4rph6xqk3Z7uUq3Db/Xd0QyNX1Op3j7rxby2YwRkDQU69deBB
	 ZsHplT6FQJX5LMfKcUyOJvfOrpRtogg7cSSgCFbFDz7TgmVTFq3pCSWLjsjEk1OV+d
	 XL555eA1dURtyZ8dvsSMVmNx8VeQrLsOkv7zVmT783inykrCqkIo8v/QU7vvSqsjdu
	 okljT38q0x/nhqiZLfcJV/nEkxWhmzMWdhQYp/5Q5MCiG6wz0D0FJzpuE/bSxPwMx/
	 LPfzAwGaOm6jGojbOBhqd1xokqt37vnhoLY7kw0juH8FuHN4RK8bFMJ6SdeKpEwtGB
	 0hcT/T2H3RJvQ==
Date: Wed, 16 Apr 2025 17:08:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Wang <jasowang@redhat.com>
Cc: Bui Quang Minh <minhquangbui99@gmail.com>,
 virtualization@lists.linux.dev, "Michael S . Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, "David S . Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 3/3] selftests: net: add a virtio_net deadlock
 selftest
Message-ID: <20250416170857.2e46a3be@kernel.org>
In-Reply-To: <CACGkMEvceXT+=HJRRe6D3Zk3k40E2ADJiXNb4qqAYm=PZnxNpQ@mail.gmail.com>
References: <20250415074341.12461-1-minhquangbui99@gmail.com>
	<20250415074341.12461-4-minhquangbui99@gmail.com>
	<20250415212709.39eafdb5@kernel.org>
	<1603c373-024d-4ec2-b655-b9e7fb942bba@gmail.com>
	<CACGkMEvceXT+=HJRRe6D3Zk3k40E2ADJiXNb4qqAYm=PZnxNpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Apr 2025 15:46:42 +0800 Jason Wang wrote:
> On Wed, Apr 16, 2025 at 2:54=E2=80=AFPM Bui Quang Minh <minhquangbui99@gm=
ail.com> wrote:
> > On 4/16/25 11:27, Jakub Kicinski wrote: =20
> > > Unfortunately this doesn't work on a basic QEMU setup:
> > >
> > > # ethtool -G eth0 rx 128
> > > [   15.680655][  T287] virtio_net virtio2 eth0: resize rx fail: rx qu=
eue index: 0 err: -2
> > > netlink error: No such file or directory
> > >
> > > Is there a way to enable more capable virtio_net with QEMU? =20
>=20
> What's the qemu command line and version?
>=20
> Resize depends on queue_reset which should be supported from Qemu 7.2

I'm using virtme-ng with --net loop and:

QEMU emulator version 9.1.3 (qemu-9.1.3-2.fc41)

--net loop resolves to:

	-device virtio-net-device,netdev=3Dn0 \
	-netdev hubport,id=3Dn0,hubid=3D0 \
	-device virtio-net-device,netdev=3Dn1 \
	-netdev hubport,id=3Dn1,hubid=3D0

> > I guess that virtio-pci-legacy is used in your setup. =20
>=20
> Note that modern devices are used by default.
>=20
> >
> > Here is how I setup virtio-net with Qemu
> >
> >      -netdev tap,id=3Dhostnet1,vhost=3Don,script=3D$NETWORK_SCRIPT,down=
script=3Dno \
> >      -device
> > virtio-net-pci,netdev=3Dhostnet1,iommu_platform=3Don,disable-legacy=3Do=
n \

That works! I rejigged the CI, for posterity I used two times:

	-device	virtio-net-pci,netdev=3Dn0,iommu_platform=3Don,disable-legacy=3Don=
,mq=3Don,vectors=3D18
	-netdev tap,id=3Dn0,ifname=3Dtap4,vhost=3Don,script=3Dno,downscript=3Dno,q=
ueues=3D8=20

and then manually bridged the taps together on the hypervisor side.

> > The iommu_platform=3Don is necessary to make vring use dma API which is=
 a
> > requirement to enable xsk_pool in virtio-net (XDP socket will be in
> > zerocopy mode for this case). Otherwise, the XDP socket will fallback to
> > copy mode, xsk_pool is not enabled in virtio-net that makes the
> > probability to reproduce bug to be very small. Currently, when you don't
> > have iommu_platform=3Don, you can pass the test even before the fix, so=
 I
> > think I will try to harden the selftest to make it return skip in this =
case. =20
>=20
> I would like to keep the resize test as it doesn't require iommu_platform.

Sounds good but lets just add them to the drivers/net/hw directory.
I don't think there's anything virtio specific in the test itself?

Right now drivers/net/virtio_net has a test which expects to see
both netdevs in the VM, while drivers / Python based tests expect
to have the env prepared where only one end is on the local machine,=20
and the other is accessible over SSH or in another netns. So it's a bit
painful to marry the two kinds of tests in the CI. At least our netdev
CI does not know how to figure this out :( It preps the env and then
runs the whole kselftest TARGET in the same setup.

