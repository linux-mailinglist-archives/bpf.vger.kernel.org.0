Return-Path: <bpf+bounces-31920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC587905191
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 13:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5701C215EF
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 11:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF0E16F0ED;
	Wed, 12 Jun 2024 11:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mlq5cMyg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AE316F0D4;
	Wed, 12 Jun 2024 11:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718192840; cv=none; b=FIizpR61pGKr2uYHUTbbMMDUv6udiHot0hqbYhBvJHHk5wrYwuu7Qsw7td2XxCCVVtbHkbxwAQmeMDSocEimMDLKr4iGukmsthjFY6PZbHUsX8NIAulLVAUJos8cQ9lipm2PyAgFoA+TMCz+L9c/3dl9enVSHdGfru3hWFopNnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718192840; c=relaxed/simple;
	bh=9hhKdWRWeHdnep9EmCQ2ydO249LRUvb2wjqwPasDnTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RfS2ds3RbRdhP9yOwXmdBYZ7Dz8QNUMAuK/xV7+EXo80QSoIYau2K6NEh3b2O1Z9FTMXV3eeZ8++eya9CpqzevcvGD/Oi/bbcjWpHT2bz6msopFfxEYF1ey3PvEOaN2XUnQG7yuP1wU4gmDMcKkuTEgCc90URbnm6rN1C3HZZfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mlq5cMyg; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-79788e61d4fso14225985a.2;
        Wed, 12 Jun 2024 04:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718192837; x=1718797637; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0cQ8+9M9XrUdsQ2so3wZoyj9wWPi1xavCUXiIuHKB7U=;
        b=Mlq5cMygTzCbBE58Z3axkbpw+Xo51sixg2G4FuM8PXweWGiaG71ixzMzvszxb3c7Xk
         yQSx684CYus1/jDotcYVWm/TuRSWbgFosfcNcmu22nBU+dbdY+Qlx3Ga/FhEtj4TPN55
         olSuMb3Ih0TceeAtmcswr364GzQDlPt7xZv5HLjR5ohwNIFZIjKfMYgh8DwVBQuhrecQ
         r6lCpU5n/8PCsQREl869rRBto7hGBMjPbI7wLe9mMYcPghWKDT0WLJbWk5NMf1iDsuet
         BhjFd8UNchjpixo/a64WXdcKVYA02llHJ3IYt/fSFU7oiDpxdDUVa/yuk+UZJpCSOvmM
         e0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718192837; x=1718797637;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0cQ8+9M9XrUdsQ2so3wZoyj9wWPi1xavCUXiIuHKB7U=;
        b=fY0FeUd21hUJE9Gsow8EsjGsHInAc7FK5h0x11t6XtmiS6IzR4szjqJU0fx2EghSOM
         GZZZvQ/63YIiNPbJn6Z1MQhLSyQR8mmRserZqjI7WDIulVFYT0kPJ1pAQ0TQSIxnM9lS
         bw66Vs+hNIwi46a1YyUF+fZCmXByW3/Sq7DQ/zMIkqegE/cyFHwRrL7ELZIHtqhh+rie
         1AWzC9PGFqFTHpDgM0S0H4xf6ILxYDvT6S2BxTm+kF37pBc1qKmcX/+uxqZ2cdMr5c2I
         rI8WDq+4Y7XdaXYvaDeiuwjVol50ue+vKABUgQOQbkdyZpgiEY9EJ8fu06SRpnSmIDqo
         +Gfw==
X-Forwarded-Encrypted: i=1; AJvYcCXI38XqeFPUn6PtI3PwYc5cWp5GIdOgGElkUre6YiyY/oBng87ey0A4TbOugbhol84rK6XQjXQ1HILW3JeNn/xZV6VV
X-Gm-Message-State: AOJu0YwEiADf2GlVXEh5mIqNs/4qraKdvFRu1VOk9tWjqe8GUTscakEH
	tJ2hbsEjWclW6lU0iKtREJVLA76NlBaLurW7+0NOshuJm8A4qGhcV2wpf5wlMF5trR8L++Q2ZYh
	ERickh7uNSVMAQzJKCfHDHdMKL3Q=
X-Google-Smtp-Source: AGHT+IHlJR4VEr/Msg4XKTavKSgBBbmLsty4g00X/B3XuqGDkCPZGuXQftvmMdiKT60xdWM54Ts5Cqste5w8vAAj66w=
X-Received: by 2002:a05:6214:483:b0:6ae:4e11:837c with SMTP id
 6a1803df08f44-6b19149847cmr15578886d6.1.1718192837519; Wed, 12 Jun 2024
 04:47:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718138187.git.zhuyifei@google.com>
In-Reply-To: <cover.1718138187.git.zhuyifei@google.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 12 Jun 2024 13:47:06 +0200
Message-ID: <CAJ8uoz2-Kt2o-v3CuLpf2VDv2VtUJL2T307rp04di5hY2ihYHg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 0/3] selftests: Add AF_XDP functionality test
To: YiFei Zhu <zhuyifei@google.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Stanislav Fomichev <sdf@google.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 22:43, YiFei Zhu <zhuyifei@google.com> wrote:
>
> We have observed that hardware NIC drivers may have faulty AF_XDP
> implementations, and there seem to be a lack of a test of various modes
> in which AF_XDP could run. This series adds a test to verify that NIC
> drivers implements many AF_XDP features by performing a send / receive
> of a single UDP packet.
>
> I put the C code of the test under selftests/bpf because I'm not really
> sure how I'd build the BPF-related code without the selftests/bpf
> build infrastructure.

Happy to see that you are contributing a number of new tests. Would it
be possible for you to integrate this into the xskxceiver framework?
You can find that in selftests/bpf too. By default, it will run its
tests using veth, but if you provide an interface name after the -i
option, it will run the tests over a real interface. I put the NIC in
loopback mode to use this feature, but feel free to add a new mode if
necessary. A lot of the setup and data plane code that you add already
exists in xskxceiver, so I would prefer if you could reuse it. Your
tests are new though and they would be valuable to have.

You could make the default packet that is sent in xskxceiver be the
UDP packet that you want and then add all the other logic that you
have to a number of new tests that you introduce.

> Tested on Google Cloud, with GVE:
>
>   $ sudo NETIF=ens4 REMOTE_TYPE=ssh \
>     REMOTE_ARGS="root@10.138.15.235" \
>     LOCAL_V4="10.138.15.234" \
>     REMOTE_V4="10.138.15.235" \
>     LOCAL_NEXTHOP_MAC="42:01:0a:8a:00:01" \
>     REMOTE_NEXTHOP_MAC="42:01:0a:8a:00:01" \
>     python3 xsk_hw.py
>
>   KTAP version 1
>   1..22
>   ok 1 xsk_hw.ipv4_basic
>   ok 2 xsk_hw.ipv4_tx_skb_copy
>   ok 3 xsk_hw.ipv4_tx_skb_copy_force_attach
>   ok 4 xsk_hw.ipv4_rx_skb_copy
>   ok 5 xsk_hw.ipv4_tx_drv_copy
>   ok 6 xsk_hw.ipv4_tx_drv_copy_force_attach
>   ok 7 xsk_hw.ipv4_rx_drv_copy
>   [...]
>   # Exception| STDERR: b'/tmp/zzfhcqkg/pbgodkgjxsk_hw: recv_pfpacket: Timeout\n'
>   not ok 8 xsk_hw.ipv4_tx_drv_zerocopy
>   ok 9 xsk_hw.ipv4_tx_drv_zerocopy_force_attach
>   ok 10 xsk_hw.ipv4_rx_drv_zerocopy
>   [...]
>   # Exception| STDERR: b'/tmp/zzfhcqkg/pbgodkgjxsk_hw: connect sync client: max_retries\n'
>   [...]
>   # Exception| STDERR: b'/linux/tools/testing/selftests/bpf/xsk_hw: open_xsk: Device or resource busy\n'
>   not ok 11 xsk_hw.ipv4_rx_drv_zerocopy_fill_after_bind
>   ok 12 xsk_hw.ipv6_basic # SKIP Test requires IPv6 connectivity
>   [...]
>   ok 22 xsk_hw.ipv6_rx_drv_zerocopy_fill_after_bind # SKIP Test requires IPv6 connectivity
>   # Totals: pass:9 fail:2 xfail:0 xpass:0 skip:11 error:0
>
> YiFei Zhu (3):
>   selftests/bpf: Move rxq_num helper from xdp_hw_metadata to
>     network_helpers
>   selftests/bpf: Add xsk_hw AF_XDP functionality test
>   selftests: drv-net: Add xsk_hw AF_XDP functionality test
>
>  tools/testing/selftests/bpf/.gitignore        |   1 +
>  tools/testing/selftests/bpf/Makefile          |   7 +-
>  tools/testing/selftests/bpf/network_helpers.c |  27 +
>  tools/testing/selftests/bpf/network_helpers.h |  16 +
>  tools/testing/selftests/bpf/progs/xsk_hw.c    |  72 ++
>  tools/testing/selftests/bpf/xdp_hw_metadata.c |  27 +-
>  tools/testing/selftests/bpf/xsk_hw.c          | 844 ++++++++++++++++++
>  .../testing/selftests/drivers/net/hw/Makefile |   1 +
>  .../selftests/drivers/net/hw/xsk_hw.py        | 133 +++
>  9 files changed, 1102 insertions(+), 26 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/xsk_hw.c
>  create mode 100644 tools/testing/selftests/bpf/xsk_hw.c
>  create mode 100755 tools/testing/selftests/drivers/net/hw/xsk_hw.py
>
> --
> 2.45.2.505.gda0bf45e8d-goog
>
>

