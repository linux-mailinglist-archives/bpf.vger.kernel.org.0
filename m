Return-Path: <bpf+bounces-64059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D592B0DF03
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 16:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1176216F564
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 14:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD762EA750;
	Tue, 22 Jul 2025 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQhe4s58"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D224D38FA3
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194947; cv=none; b=AS8kVgmyKuIxQEei+ZyrOz2Lb8LOe/7BfKH/BAePVAD6ysPKCbj+9G9HVEelzjx5fiAEftnR8cg8w6gWf8ztnfQekxzvUGhMVCVmLTIc+uRFqFwLlinJho8Of99oyat+zcz4z1OigHzjdzZVFBqvLA2cl00IEYd2fF7rlHW4diY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194947; c=relaxed/simple;
	bh=FtMcpts9tF0PQFNX2Xy1OLTiS5qBzXfp3waJCk/dUso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emNtWGkRg2i6oYEkie1x2ZvCqsf+mEpL8eGEYtUoVDwTt/mFElDy7m6El5/QyAYSv7p4D8ta7WL5JYXkBrH1NbSfrj3xt9ah8WSRLFINV2eKM0PWG/EX7ek5kpBgMGi2hKCYQ0xT1GWVSmkVpVrZKF7Xa56viEi+6p+/gEzkIOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CQhe4s58; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753194944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fzB7P1BusfnapG0uVAVGElcUdQoH/V3AcX2/zWIOBVg=;
	b=CQhe4s58x3OrdWIaGeUPYxARs9lxw+HkDnH/FSY6+/yiSIl9evtvgoLWNwyRV1FrIrQKxr
	4j+h5neymW7ntf1Oyki0O9fJYygeUJFFHUyxPF/g1JwRliRHT9hciztjYBdD4iOgI6CxZ8
	9ZqsIscRzUsxOxX3hsxM3+6XIuKsKu4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-B7FdzCWgPM22z8HNyw-_rQ-1; Tue, 22 Jul 2025 10:35:42 -0400
X-MC-Unique: B7FdzCWgPM22z8HNyw-_rQ-1
X-Mimecast-MFC-AGG-ID: B7FdzCWgPM22z8HNyw-_rQ_1753194941
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ae3c8477f1fso478306766b.3
        for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 07:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753194941; x=1753799741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzB7P1BusfnapG0uVAVGElcUdQoH/V3AcX2/zWIOBVg=;
        b=OSUDZ77w+WTlkMe01ymOj0u/JynkvzvmZzhxJ9GHcJEbxUhmTx6lIIpT+aANv4aMUi
         BGmAKKtvddyUqmLX/4DzkYsq9io2YjhXZFldvSCwC5nCeyJNSaAUBqHFxQAV+Tt3LJfc
         c3vJx4Jgqn17inEFNf+CmPebBO1j/ityUDsyNW/kizd2ViwsE78Jh6tvmbHZMXXo/BRS
         oM5AEZOFI58silh/3wd7MeJEya2p/TqZDBcf/Hxp+dusrv+kTU+otVC0Pjz/YA3LfFe4
         sBa5B1ORin92Efe68GXvOYLOAhlxoaKVJneiMTVkM0lmxmZpFyF0RqvidttrcJja8o0o
         qj6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaFuELfcLNxG6ecuZDc2BsDhToF/upgnUPXts/Xr3AdirDax5i1Y056HppXsJ79hzF3no=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxtl2pSXtANfdQsYOKi7NiMvoq+b4a9+Rmk88Jwns+gKC9ji82
	F5uOqdB1unM5MyGCX2ISvfRscrd8ETTZuCYOFxkbApvOKhh91XtHlb+duazDtbOsbJFzoYzKFWz
	Uz1hFobayvz6NvmyNyzEhoZvQdeU/kN3I1w0EYvnTtyfXi6BJSSwycQ==
X-Gm-Gg: ASbGncswIGifQsNMgGBwgrf/rm60vWKZhSDr2kjN9QK90bI+YdDX16yt1HCt0JLWv6G
	DnDUrDl1RqXFX7WJOXixeX+nIUtq+n4mS9v5J8pzcOHsKsocvhAEFqQM+giNCdafhPZIBd7beDS
	0OSSwTtPKfsqgEwuY1YpYLu0vm+87n1E1CSIiriDHglckjhwz93iNNWFO23j4FqwbNbAUdSFE7p
	IfEuoH9KGXXH3dr95dBMnLMoZgNcc+K2qEvogddNGOjVYkr0s4/lM0G1W8LVf8P+uTgug7/xYTj
	M8oT54kOnbvgH/rWLCCH5P3iGFfBdQRGrbc03clZI5WV/7LXIMssqhpUjWawcLOiWqxwCq817fe
	tZdiHWjkfvPxU4Qs=
X-Received: by 2002:a17:906:7946:b0:ae9:8dcb:4dac with SMTP id a640c23a62f3a-ae9c99bac5fmr2438077066b.14.1753194941099;
        Tue, 22 Jul 2025 07:35:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/TeWm8DeewR5crPsEXii/8MlhRmlF6n2C6fHO5dz/5iDDWZFbxMXiWYmWah7yJm8iOWS6rw==
X-Received: by 2002:a17:906:7946:b0:ae9:8dcb:4dac with SMTP id a640c23a62f3a-ae9c99bac5fmr2438071766b.14.1753194940260;
        Tue, 22 Jul 2025 07:35:40 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it. [79.45.205.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d9941sm879107266b.56.2025.07.22.07.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 07:35:39 -0700 (PDT)
Date: Tue, 22 Jul 2025 16:35:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, bryantan@vmware.com, vdasa@vmware.com, pv-drivers@vmware.com, 
	dan.carpenter@linaro.org, simon.horman@corigine.com, oxffffaa@gmail.com, 
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	bpf@vger.kernel.org, bobby.eshleman@bytedance.com, jiang.wang@bytedance.com, 
	amery.hung@bytedance.com, xiyou.wangcong@gmail.com
Subject: Re: [RFC PATCH net-next v6 00/14] virtio/vsock: support datagrams
Message-ID: <dsamf7k2byoflztkwya3smj7jyczyq7aludvd36lufdrboxdqk@u73iwrcyb5am>
References: <20240710212555.1617795-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240710212555.1617795-1-amery.hung@bytedance.com>

Hi Amery,

On Wed, Jul 10, 2024 at 09:25:41PM +0000, Amery Hung wrote:
>Hey all!
>
>This series introduces support for datagrams to virtio/vsock.

any update on v7 of this series?

Thanks,
Stefano

>
>It is a spin-off (and smaller version) of this series from the summer:
>  https://lore.kernel.org/all/cover.1660362668.git.bobby.eshleman@bytedance.com/
>
>Please note that this is an RFC and should not be merged until
>associated changes are made to the virtio specification, which will
>follow after discussion from this series.
>
>Another aside, the v4 of the series has only been mildly tested with a
>run of tools/testing/vsock/vsock_test. Some code likely needs cleaning
>up, but I'm hoping to get some of the design choices agreed upon before
>spending too much time making it pretty.
>
>This series first supports datagrams in a basic form for virtio, and
>then optimizes the sendpath for all datagram transports.
>
>The result is a very fast datagram communication protocol that
>outperforms even UDP on multi-queue virtio-net w/ vhost on a variety
>of multi-threaded workload samples.
>
>For those that are curious, some summary data comparing UDP and VSOCK
>DGRAM (N=5):
>
>	vCPUS: 16
>	virtio-net queues: 16
>	payload size: 4KB
>	Setup: bare metal + vm (non-nested)
>
>	UDP: 287.59 MB/s
>	VSOCK DGRAM: 509.2 MB/s
>
>Some notes about the implementation...
>
>This datagram implementation forces datagrams to self-throttle according
>to the threshold set by sk_sndbuf. It behaves similar to the credits
>used by streams in its effect on throughput and memory consumption, but
>it is not influenced by the receiving socket as credits are.
>
>The device drops packets silently.
>
>As discussed previously, this series introduces datagrams and defers
>fairness to future work. See discussion in v2 for more context around
>datagrams, fairness, and this implementation.
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>Signed-off-by: Amery Hung <amery.hung@bytedance.com>
>---
>Changes in v6:
>- allow empty transport in datagram vsock
>- add empty transport checks in various paths
>- transport layer now saves source cid and port to control buffer of skb
>  to remove the dependency of transport in recvmsg()
>- fix virtio dgram_enqueue() by looking up the transport to be used when
>  using sendto(2)
>- fix skb memory leaks in two places
>- add dgram auto-bind test
>- Link to v5: https://lore.kernel.org/r/20230413-b4-vsock-dgram-v5-0-581bd37fdb26@bytedance.com
>
>Changes in v5:
>- teach vhost to drop dgram when a datagram exceeds the receive buffer
>  - now uses MSG_ERRQUEUE and depends on Arseniy's zerocopy patch:
>	"vsock: read from socket's error queue"
>- replace multiple ->dgram_* callbacks with single ->dgram_addr_init()
>  callback
>- refactor virtio dgram skb allocator to reduce conflicts w/ zerocopy series
>- add _fallback/_FALLBACK suffix to dgram transport variables/macros
>- add WARN_ONCE() for table_size / VSOCK_HASH issue
>- add static to vsock_find_bound_socket_common
>- dedupe code in vsock_dgram_sendmsg() using module_got var
>- drop concurrent sendmsg() for dgram and defer to future series
>- Add more tests
>  - test EHOSTUNREACH in errqueue
>  - test stream + dgram address collision
>- improve clarity of dgram msg bounds test code
>- Link to v4: https://lore.kernel.org/r/20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com
>
>Changes in v4:
>- style changes
>  - vsock: use sk_vsock(vsk) in vsock_dgram_recvmsg instead of
>    &sk->vsk
>  - vsock: fix xmas tree declaration
>  - vsock: fix spacing issues
>  - virtio/vsock: virtio_transport_recv_dgram returns void because err
>    unused
>- sparse analysis warnings/errors
>  - virtio/vsock: fix unitialized skerr on destroy
>  - virtio/vsock: fix uninitialized err var on goto out
>  - vsock: fix declarations that need static
>  - vsock: fix __rcu annotation order
>- bugs
>  - vsock: fix null ptr in remote_info code
>  - vsock/dgram: make transport_dgram a fallback instead of first
>    priority
>  - vsock: remove redundant rcu read lock acquire in getname()
>- tests
>  - add more tests (message bounds and more)
>  - add vsock_dgram_bind() helper
>  - add vsock_dgram_connect() helper
>
>Changes in v3:
>- Support multi-transport dgram, changing logic in connect/bind
>  to support VMCI case
>- Support per-pkt transport lookup for sendto() case
>- Fix dgram_allow() implementation
>- Fix dgram feature bit number (now it is 3)
>- Fix binding so dgram and connectible (cid,port) spaces are
>  non-overlapping
>- RCU protect transport ptr so connect() calls never leave
>  a lockless read of the transport and remote_addr are always
>  in sync
>- Link to v2: https://lore.kernel.org/r/20230413-b4-vsock-dgram-v2-0-079cc7cee62e@bytedance.com
>
>
>Bobby Eshleman (14):
>  af_vsock: generalize vsock_dgram_recvmsg() to all transports
>  af_vsock: refactor transport lookup code
>  af_vsock: support multi-transport datagrams
>  af_vsock: generalize bind table functions
>  af_vsock: use a separate dgram bind table
>  virtio/vsock: add VIRTIO_VSOCK_TYPE_DGRAM
>  virtio/vsock: add common datagram send path
>  af_vsock: add vsock_find_bound_dgram_socket()
>  virtio/vsock: add common datagram recv path
>  virtio/vsock: add VIRTIO_VSOCK_F_DGRAM feature bit
>  vhost/vsock: implement datagram support
>  vsock/loopback: implement datagram support
>  virtio/vsock: implement datagram support
>  test/vsock: add vsock dgram tests
>
> drivers/vhost/vsock.c                   |   62 +-
> include/linux/virtio_vsock.h            |    9 +-
> include/net/af_vsock.h                  |   24 +-
> include/uapi/linux/virtio_vsock.h       |    2 +
> net/vmw_vsock/af_vsock.c                |  343 ++++++--
> net/vmw_vsock/hyperv_transport.c        |   13 -
> net/vmw_vsock/virtio_transport.c        |   24 +-
> net/vmw_vsock/virtio_transport_common.c |  188 ++++-
> net/vmw_vsock/vmci_transport.c          |   61 +-
> net/vmw_vsock/vsock_loopback.c          |    9 +-
> tools/testing/vsock/util.c              |  177 +++-
> tools/testing/vsock/util.h              |   10 +
> tools/testing/vsock/vsock_test.c        | 1032 ++++++++++++++++++++---
> 13 files changed, 1638 insertions(+), 316 deletions(-)
>
>-- 
>2.20.1
>


