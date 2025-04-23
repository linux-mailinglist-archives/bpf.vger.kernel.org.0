Return-Path: <bpf+bounces-56475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1373BA97C33
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 03:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF1C63AC706
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 01:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0053262D29;
	Wed, 23 Apr 2025 01:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUz+CU3V"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190501EFFBE;
	Wed, 23 Apr 2025 01:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745372514; cv=none; b=OqnfqEAL63iHZfjsAfO3YD3CnAlm3YwTM6Pd79LmibBi2HfbEN2Uk5DRl4SaSJ5mR1fT2yqo6Pej9LnblaUCY66DGFf3Lj59aBAum8ANpk9ekziMG1z+0qwDg+7csoDdsmZSZXuES8Cj9kFeHOVTbNG6Nc40dIOQfWENAix//NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745372514; c=relaxed/simple;
	bh=x20Xqy3N6oQmptfey0Z2+QB1DWZUT41kOcINg+dlCvo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q0OoalEBBRglP/heOvVDQqKB1amZBTQBqaqG5/8oh3yfhsTVZLpWflIlAMuc9uLYCFpRD/yn5DdHkBLeVIuG9Maw47aA1kNMy69YFDfzISwroI1PWPgphxOME6Q+zsZ8F3FqBJVf2UE1JQjtvTsBHENeAM/7VHfpISZ8jYcMIeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUz+CU3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFC3C4CEE9;
	Wed, 23 Apr 2025 01:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745372513;
	bh=x20Xqy3N6oQmptfey0Z2+QB1DWZUT41kOcINg+dlCvo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nUz+CU3V3ZYW8R389v8ud02QPJjMXKfHgq/Vc/tTpIOzO5md27YOQLdR9fv5vQmmG
	 v2Q4ZgGqcc/eWgdL+B4DqY6PKnYh8/oGLkKd6gV1U0Kgs7uCSmigJE9HDsFhZRHqWC
	 4cdDPTR8Dz3ycCCmCZkI77Qh8fwfQlfJQUHaB2j3irOH70C1RJfcsfAUfOHl4XqLHs
	 DKelC0B3tQrrq3sPm67xHDVteWAUHLdQ+rFU4yFBZDJnJZphSjpaSVL8xmud6rG8eB
	 Di0jRsOu98XW66wm7LwfomwBBhKmrG4SkH2dV5lFCYiP8g2y/fg51CfBbcaF8UI+WB
	 X0+M+21Hc1xtg==
Date: Tue, 22 Apr 2025 18:41:51 -0700
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
Message-ID: <20250422184151.2fb4fffe@kernel.org>
In-Reply-To: <20250417072806.18660-5-minhquangbui99@gmail.com>
References: <20250417072806.18660-1-minhquangbui99@gmail.com>
	<20250417072806.18660-5-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 14:28:06 +0700 Bui Quang Minh wrote:
> The selftest reproduces the deadlock scenario when binding/unbinding XDP
> program, XDP socket, rx ring resize on virtio_net interface.
> 
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  .../testing/selftests/drivers/net/hw/Makefile |  1 +
>  .../selftests/drivers/net/hw/virtio_net.py    | 65 +++++++++++++++++++
>  2 files changed, 66 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/hw/virtio_net.py
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index 07cddb19ba35..b5af7c1412bf 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -21,6 +21,7 @@ TEST_PROGS = \
>  	rss_ctx.py \
>  	rss_input_xfrm.py \
>  	tso.py \
> +	virtio_net.py \

Maybe xsk_reconfig.py ? Other drivers will benefit from this test, too,
and that's a more descriptive name.

>  	#
>  
>  TEST_FILES := \
> diff --git a/tools/testing/selftests/drivers/net/hw/virtio_net.py b/tools/testing/selftests/drivers/net/hw/virtio_net.py
> new file mode 100755
> index 000000000000..7cad7ab98635
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/virtio_net.py
> @@ -0,0 +1,65 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# This is intended to be run on a virtio-net guest interface.
> +# The test binds the XDP socket to the interface without setting
> +# the fill ring to trigger delayed refill_work. This helps to
> +# make it easier to reproduce the deadlock when XDP program,
> +# XDP socket bind/unbind, rx ring resize race with refill_work on
> +# the buggy kernel.
> +#
> +# The Qemu command to setup virtio-net
> +# -netdev tap,id=hostnet1,vhost=on,script=no,downscript=no
> +# -device virtio-net-pci,netdev=hostnet1,iommu_platform=on,disable-legacy=on
> +
> +from lib.py import ksft_exit, ksft_run
> +from lib.py import KsftSkipEx, KsftFailEx
> +from lib.py import NetDrvEnv
> +from lib.py import bkg, ip, cmd, ethtool
> +import re
> +
> +def _get_rx_ring_entries(cfg):
> +    output = ethtool(f"-g {cfg.ifname}").stdout
> +    values = re.findall(r'RX:\s+(\d+)', output)

no need for the regexps, ethtool -g supports json formatting:

	output = ethtool(f"-g {cfg.ifname}", json=True)[0]
	return output["rx"]

?

> +    return int(values[1])
> +
> +def setup_xsk(cfg, xdp_queue_id = 0) -> bkg:
> +    # Probe for support
> +    xdp = cmd(f'{cfg.net_lib_dir / "xdp_helper"} - -', fail=False)
> +    if xdp.ret == 255:
> +        raise KsftSkipEx('AF_XDP unsupported')
> +    elif xdp.ret > 0:
> +        raise KsftFailEx('unable to create AF_XDP socket')
> +
> +    try:
> +        xsk_bkg = bkg(f'{cfg.net_lib_dir / "xdp_helper"} {cfg.ifindex} ' \
> +                      '{xdp_queue_id} -z', ksft_wait=3)

This process will time out after 3 seconds but the test really
shouldn't leave things running after it exits. Don't worry about
the couple of seconds of execution time. Wrap each test in

	with bkg(f"... the exec info ... "):
		# test code here

The bkg() class has an __exit__() handle once the test finishes
and leaves the with block it will terminate.

> +        return xsk_bkg
> +    except:
> +        raise KsftSkipEx('Failed to bind XDP socket in zerocopy. ' \
> +                         'Please consider adding iommu_platform=on ' \
> +                         'when setting up virtio-net-pci')
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

Why guess the ring size? What if it's already 128? I usually do:

	rx_ring = _get_rx_ring_entries(cfg)
	ethtool(f"-G %s rx %d" % (cfg.ifname, rx_ring / 2))
	ethtool(f"-G %s rx %d" % (cfg.ifname, rx_ring))

IOW flip between half or double and current.

> +def main():
> +    with NetDrvEnv(__file__, nsim_test=False) as cfg:
> +        try:
> +            xsk_bkg = setup_xsk(cfg)
> +        except KsftSkipEx as e:
> +            print(f"WARN: xsk pool is not set up, err: {e}")
> +
> +        ksft_run([check_xdp_bind, check_rx_resize],
> +                 args=(cfg, ))
> +    ksft_exit()
> +
> +if __name__ == "__main__":
> +    main()


