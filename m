Return-Path: <bpf+bounces-53540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 464A6A56127
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 07:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F52E1723CB
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 06:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5C21A0BE1;
	Fri,  7 Mar 2025 06:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cTXLJSVr"
X-Original-To: bpf@vger.kernel.org
Received: from out199-8.us.a.mail.aliyun.com (out199-8.us.a.mail.aliyun.com [47.90.199.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F87C1632D9;
	Fri,  7 Mar 2025 06:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741330165; cv=none; b=EZDlH9dmoKq6ie3PsIhbJ7SDXV/PIftALq+l4xUvNHYaWUXDxc1aqGu2JfWJPmhoimWzhvwelsXup2fpE9KRNWFXsfnZwXv82CQZ6NGGLy45jvtkQAzPj4v7yWSEfxJfqL+kNaC3kmvaK2oY0UvCxEQHazgmbKY0NS4d49gYpbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741330165; c=relaxed/simple;
	bh=+si5xtfKaTrCo5XkcrRh9/5zv/jMenw3VsyRd5+2yic=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=oHpJdqOOCZpYpwZljV/84YoB0awQx1GBYrzVoG/XHTuuAuUiHNeJZct6KLL62mAQKHUxpMkEaeslhziUew/NrzRMX8AaQcApbCmr4t9R9kIotqWBzeljAw3LjR+kB3AoxSdGr75UaKWUKm4kq8sr3JgyHyNO/8ir+BIBlQgZ1eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cTXLJSVr; arc=none smtp.client-ip=47.90.199.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741330148; h=Message-ID:Subject:Date:From:To;
	bh=COzCScwAqWPN27zgbIWMNSKbrRKvc4+xm4mvYs8QRho=;
	b=cTXLJSVrbxo0h61RYidhCFEXcJEbHR7WRRZZtWzrscbeGOcOKjU5a2EiFv3ziWPWeljsFKwjY1qWeEFaxBqHGOptB2PMNsEMOPG9l6OCFQShUMPqpPgc36iRtW4UWHYu3l9THmgrPThIXvHa+IAYEtZ3AbEU4iZhqOtXi4KH7NY=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WQr6i8Z_1741330146 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Mar 2025 14:49:06 +0800
Message-ID: <1741330136.4796808-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 0/4] virtio-net: Link queues to NAPIs
Date: Fri, 7 Mar 2025 14:48:56 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Joe Damato <jdamato@fastly.com>
Cc: mkarsten@uwaterloo.ca,
 gerhard@engleder-embedded.com,
 jasowang@redhat.com,
 kuba@kernel.org,
 mst@redhat.com,
 leiyang@redhat.com,
 Joe Damato <jdamato@fastly.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_)),
 Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 linux-kernel@vger.kernel.org (open list),
 Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
 netdev@vger.kernel.org
References: <20250307011215.266806-1-jdamato@fastly.com>
In-Reply-To: <20250307011215.266806-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

On Fri,  7 Mar 2025 01:12:08 +0000, Joe Damato <jdamato@fastly.com> wrote:
> Greetings:
>
> Welcome to v6. Only patch updated is patch 3. See changelog below.
>
> Jakub recently commented [1] that I should not hold this series on
> virtio-net linking queues to NAPIs behind other important work that is
> on-going and suggested I re-spin, so here we are :)
>
> As per the discussion on the v3 [2], now both RX and TX NAPIs use the
> API to link queues to NAPIs. Since TX-only NAPIs don't have a NAPI ID,
> commit 6597e8d35851 ("netdev-genl: Elide napi_id when not present") now
> correctly elides the TX-only NAPIs (instead of printing zero) when the
> queues and NAPIs are linked.
>
> As per the discussion on the v4 [3], patch 3 has been refactored to hold
> RTNL only in the specific locations which need it as Jason requested.
>
> As per the discussion on the v5 [4], patch 3 now leaves refill_work
> as-is and does not use the API to unlink and relink queues and NAPIs. A
> comment has been left as suggested by Jakub [5] for future work.
>
> See the commit message of patch 3 for an example of how to get the NAPI
> to queue mapping information.
>
> See the commit message of patch 4 for an example of how NAPI IDs are
> persistent despite queue count changes.
>
> Thanks,
> Joe
>
> [1]: https://lore.kernel.org/netdev/20250221142650.3c74dcac@kernel.org/
> [2]: https://lore.kernel.org/netdev/20250127142400.24eca319@kernel.org/
> [3]: https://lore.kernel.org/netdev/CACGkMEv=ejJnOWDnAu7eULLvrqXjkMkTL4cbi-uCTUhCpKN_GA@mail.gmail.com/
> [4]: https://lore.kernel.org/lkml/Z8X15hxz8t-vXpPU@LQ3V64L9R2/
> [5]: https://lore.kernel.org/lkml/20250303160355.5f8d82d8@kernel.org/
>
> v6:
>   - Patch 3 has been updated to avoid using the queue linking API from
>     refill_work and a comment has been added to instruct future
>     work on the code.
>
> v5: https://lore.kernel.org/lkml/20250227185017.206785-1-jdamato@fastly.com/
>   - Patch 1 added Acked-by's from Michael and Jason. Added Tested-by
>     from Lei. No functional changes.
>   - Patch 2 added Acked-by's from Michael and Jason. Added Tested-by
>     from Lei. No functional changes.
>   - Patch 3:
>     - Refactored as Jason requested, eliminating the
>       virtnet_queue_set_napi helper entirely, and explicitly holding
>       RTNL in the 3 locations where needed (refill_work, freeze, and
>       restore).
>     - Commit message updated to outline the known paths at the time the
>       commit was written.
>   - Patch 4 added Acked-by from Michael. Added Tested-by from Lei. No
>     functional changes.
>
> v4: https://lore.kernel.org/lkml/20250225020455.212895-1-jdamato@fastly.com/
>   - Dropped Jakub's patch (previously patch 1).
>   - Significant refactor from v3 affecting patches 1-3.
>   - Patch 4 added tags from Jason and Gerhard.
>
> rfcv3: https://lore.kernel.org/netdev/20250121191047.269844-1-jdamato@fastly.com/
>   - patch 3:
>     - Removed the xdp checks completely, as Gerhard Engleder pointed
>       out, they are likely not necessary.
>
>   - patch 4:
>     - Added Xuan Zhuo's Reviewed-by.
>
> v2: https://lore.kernel.org/netdev/20250116055302.14308-1-jdamato@fastly.com/
>   - patch 1:
>     - New in the v2 from Jakub.
>
>   - patch 2:
>     - Previously patch 1, unchanged from v1.
>     - Added Gerhard Engleder's Reviewed-by.
>     - Added Lei Yang's Tested-by.
>
>   - patch 3:
>     - Introduced virtnet_napi_disable to eliminate duplicated code
>       in virtnet_xdp_set, virtnet_rx_pause, virtnet_disable_queue_pair,
>       refill_work as suggested by Jason Wang.
>     - As a result of the above refactor, dropped Reviewed-by and
>       Tested-by from patch 3.
>
>   - patch 4:
>     - New in v2. Adds persistent NAPI configuration. See commit message
>       for more details.
>
> v1: https://lore.kernel.org/netdev/20250110202605.429475-1-jdamato@fastly.com/
>
>
> Joe Damato (4):
>   virtio-net: Refactor napi_enable paths
>   virtio-net: Refactor napi_disable paths
>   virtio-net: Map NAPIs to queues
>   virtio_net: Use persistent NAPI config
>
>  drivers/net/virtio_net.c | 101 ++++++++++++++++++++++++++++-----------
>  1 file changed, 74 insertions(+), 27 deletions(-)
>
>
> base-commit: 8e0e8bef484160ac01ea7bcc3122cc1f0405c982
> --
> 2.45.2
>

