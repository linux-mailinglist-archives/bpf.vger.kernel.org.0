Return-Path: <bpf+bounces-56023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DB2A8AF00
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 06:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFAEA3AE9E2
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 04:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A631227EB2;
	Wed, 16 Apr 2025 04:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyEWX1XQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770BC228C86;
	Wed, 16 Apr 2025 04:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744777632; cv=none; b=UN6sMarx6AXw7zVYvfLGVGDdofHYtI27nOu+BeGl7tTBJPYr30MyCuL5hAIIXzvdBPiYhzV7lhQQMz8RiREX6Xt6aSUb8Ok0bGRAi/p72HwTR/6UuVqDGBSDzYISEskdxFB5PUXmHt6I2+M3+phAa1RItulv9aKCHQgyD3VdDBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744777632; c=relaxed/simple;
	bh=W7Voch1+j4hseVkaXNSIgcrVP+fBZoaIxH+l4PLXxjE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3HyAo5or+z8O2N5XbLn2RSSuFevf/dZpyJlrV1qmbHjqGWNln+lApGjoFvnJIbh3wRzFrOQNMrLPSQXjcrdUBeY2pTx7jAPmoXjW+PTCspb5/ROdORixx4cl+csZ/jxz8sO9RYJPQu/iQ3elNSFFyuhILkASaiEMlna53vSqMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyEWX1XQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20038C4CEE2;
	Wed, 16 Apr 2025 04:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744777631;
	bh=W7Voch1+j4hseVkaXNSIgcrVP+fBZoaIxH+l4PLXxjE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VyEWX1XQDYIgd3Wx2060YIKWdVLbIis3o96RWRP//C8p63CLQ/9vzB8fHW3kPvVXB
	 kXmbhMXmTEX+n4jLaXn1k1eoRqukZ8KPrcLm0IMAPfbqY5FOoXupzVXXRrqZ4E6X/z
	 H77AGG8LlZd4G8wC7ZSqpW7zU6dbCpJrnKsyvEj1KGdTfn0pF5Va5Q87rlRf9CC7dz
	 Brt7ytIcNyXzvVcrXlvWotssMpfvcNlcBBkjpJKy0rWfZrpjM1VsQiFZw9LggGySlJ
	 FD349Ye/93dz6StnkZn7HwtFur6V8R4364Y6g/AHtfVN0cFLu2CKCVkgRQs3LLmwgm
	 hWhyPPUXUfOZg==
Date: Tue, 15 Apr 2025 21:27:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, "David S . Miller"
 <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 3/3] selftests: net: add a virtio_net deadlock
 selftest
Message-ID: <20250415212709.39eafdb5@kernel.org>
In-Reply-To: <20250415074341.12461-4-minhquangbui99@gmail.com>
References: <20250415074341.12461-1-minhquangbui99@gmail.com>
	<20250415074341.12461-4-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 14:43:41 +0700 Bui Quang Minh wrote:
> +def setup_xsk(cfg, xdp_queue_id = 0) -> bkg:
> +    # Probe for support
> +    xdp = cmd(f'{cfg.net_lib_dir / "xdp_helper"} - -', fail=False)
> +    if xdp.ret == 255:
> +        raise KsftSkipEx('AF_XDP unsupported')
> +    elif xdp.ret > 0:
> +        raise KsftFailEx('unable to create AF_XDP socket')
> +
> +    return bkg(f'{cfg.net_lib_dir / "xdp_helper"} {cfg.ifindex} {xdp_queue_id}',
> +               ksft_wait=3)
> +
> +def check_xdp_bind(cfg):
> +    ip(f"link set dev %s xdp obj %s sec xdp" %
> +       (cfg.ifname, cfg.net_lib_dir / "xdp_dummy.bpf.o"))
> +    ip(f"link set dev %s xdp off" % cfg.ifname)
> +
> +def check_rx_resize(cfg, queue_size = 128):
> +    rx_ring = _get_rx_ring_entries(cfg)
> +    ethtool(f"-G %s rx %d" % (cfg.ifname, queue_size))
> +    ethtool(f"-G %s rx %d" % (cfg.ifname, rx_ring))

Unfortunately this doesn't work on a basic QEMU setup:

# ethtool -G eth0 rx 128
[   15.680655][  T287] virtio_net virtio2 eth0: resize rx fail: rx queue index: 0 err: -2
netlink error: No such file or directory

Is there a way to enable more capable virtio_net with QEMU?

