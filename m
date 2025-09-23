Return-Path: <bpf+bounces-69396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E86D9B95B6D
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 13:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90324480EDE
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 11:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02C1322A0A;
	Tue, 23 Sep 2025 11:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5BOYbMS"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91BE32277F
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 11:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758627741; cv=none; b=H5g3IkRoawqbBAAd/4+CcTjfQ1O73oyQ8OkMQnXKDK2SbkhYV4ELs1vRAvCitny2ywXZ6cqsBRJAXurpQo72w5BSR2SOzCmhw/0HBbPQfI7jUs1omjtcJHzMUXNY7drnx8vFvSbZscNL7vprMQT3oe56O/ejHMyScC8FS+QgMXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758627741; c=relaxed/simple;
	bh=G8RMdmZL4fdCH9fRdyOpBtwiZHkjTotcoV1Ff2ChtfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hzA/mbJMBkCJOBiZLngLmcbF55tIB7IOAuYpyFbw5sFGvoyJolohZsm9EyOtEhAxP5TavJUJ/CwkecoWNfBCu8H0dCq1Uwt4m8YttC7o7VN19gy8zPDgxyVdxM/pX43Y+QELHt1Kf5fTzhPuROdUaNTC/H24vIUT/XqpciP4V0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E5BOYbMS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758627737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8TUxr2PcYQo3Gqe2ITI3w1kddbm1Woi0UL2ab5WEwRM=;
	b=E5BOYbMS5CsB+QoyIuZRV70C7pWhItlksHL95it5Kmero/Eadz+oI4d5Bx+o2Fk046YGjt
	G+7Noj7X8qbVcNqGP7LroOcLXBJvQxNHYSuvS2U6zHvehPqe6NDWxbJlSYq3JMAgxwNWEw
	8YikTzCw2AdK3iM73NU6OG4m5oG/p7M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-vqUTZmmkMBCJdhfg5kk1hw-1; Tue, 23 Sep 2025 07:42:16 -0400
X-MC-Unique: vqUTZmmkMBCJdhfg5kk1hw-1
X-Mimecast-MFC-AGG-ID: vqUTZmmkMBCJdhfg5kk1hw_1758627730
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b2b2ce400a8so301780766b.3
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 04:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758627730; x=1759232530;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8TUxr2PcYQo3Gqe2ITI3w1kddbm1Woi0UL2ab5WEwRM=;
        b=N5LK3yRP9zRGchP7PsamgmLFUHNGEQhAzuHrE209zkw3McchGdU8Oql11wA+wSiyx5
         wCgQa8jaPFUBu4y+X5hFqgDVFTs+goePJs5Sg651meTxZ2sKV86HB2mVf5IiWvCvypl7
         j86TiYSBPj/Kb39fPhIrSoSVmv3xsoSXuFy4ZVaZiMw0b5E2OoSoAUQ7KIJAw7T9VNOx
         KQAi8lwidXzxmgGDnAXHrO1ugqr/1jHF7qxwcFPS/NniIJ2mHZ8ivVtaAtB8xkHs72GK
         Jz8IMCexkNooR/F7L2IxXxuDdHOuUimu+KWuv2ixq9mg5eZZdnYueD1C0noqQOQZgjA3
         51kg==
X-Gm-Message-State: AOJu0Yz7etuvy85EaZtkADZrgnzRd94Qtzq8aI7od98/kV4dk4/OdtrC
	OPOb6c0iqrWodJm02HY7Y5/ZXWUEJSACD+ddvW7Zgwc3HZJ3yFojWlHxxSJIVnJcpH9alsYgxZt
	JaDSKFNALSLQ0Tp6MSGgi94H1/hhKprxFGx8peMMlTLB97n8HxDu+6Q==
X-Gm-Gg: ASbGncsNGPkP+XVW9ifkUnLGLirDauZQSI0ytUu5y/UIAAPMiPmd/DuMp644T61e0ey
	33aF9be1Qw5+VwZVuLb/CfoUd6OK2Sm80IO4yovHNlDmHH9SC/E/wo62ikDRMEGMG3SYhxzIk+h
	nabkFfBbogFSTPnllYODGnDQgnE8L3mJqVoSEBCdd8d8MqwPURKTONSdU6AdGxh7HPP2O+c0/Gx
	hj61kb8h3fr041GRDcJg4/GkViM41TCxhN3vlj68xP0Hq/DKQ4BsHuzsq7r2WYpulTTiBuBYIji
	gBN7LKO5Cgi5w7B/JMRjB/FmHjpxMr4stBX9zxEvERk2cJHQZGbfyAitfEojkSIyF+w=
X-Received: by 2002:a05:6402:27d3:b0:634:5705:5705 with SMTP id 4fb4d7f45d1cf-63467777e5dmr2034133a12.12.1758627730047;
        Tue, 23 Sep 2025 04:42:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVsCDpc5IWoUNh9WXpVz7PEvJx30W355c6iit1K0jZJgJ5OlHyps2N1qPVh8fX81j05Kd6qg==
X-Received: by 2002:a05:6402:27d3:b0:634:5705:5705 with SMTP id 4fb4d7f45d1cf-63467777e5dmr2034107a12.12.1758627729508;
        Tue, 23 Sep 2025 04:42:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5d06a15sm11013207a12.1.2025.09.23.04.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:42:08 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id BEABB276C0D; Tue, 23 Sep 2025 13:42:07 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 19/20] netkit: Add xsk support for af_xdp
 applications
In-Reply-To: <20250919213153.103606-20-daniel@iogearbox.net>
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-20-daniel@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 23 Sep 2025 13:42:07 +0200
Message-ID: <87zfalpf8w.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniel Borkmann <daniel@iogearbox.net> writes:

> Enable support for AF_XDP applications to operate on a netkit device.
> The goal is that AF_XDP applications can natively consume AF_XDP
> from network namespaces. The use-case from Cilium side is to support
> Kubernetes KubeVirt VMs through QEMU's AF_XDP backend. KubeVirt is a
> virtual machine management add-on for Kubernetes which aims to provide
> a common ground for virtualization. KubeVirt spawns the VMs inside
> Kubernetes Pods which reside in their own network namespace just like
> regular Pods.
>
> Raw QEMU AF_XDP backend example with eth0 being a physical device with
> 16 queues where netkit is bound to the last queue (for multi-queue RSS
> context can be used if supported by the driver):
>
>   # ethtool -X eth0 start 0 equal 15
>   # ethtool -X eth0 start 15 equal 1 context new
>   # ethtool --config-ntuple eth0 flow-type ether \
>             src 00:00:00:00:00:00 \
>             src-mask ff:ff:ff:ff:ff:ff \
>             dst $mac dst-mask 00:00:00:00:00:00 \
>             proto 0 proto-mask 0xffff action 15
>   # ip netns add foo
>   # ip link add numrxqueues 2 nk type netkit single
>   # ynl-bind eth0 15 nk
>   # ip link set nk netns foo
>   # ip netns exec foo ip link set lo up
>   # ip netns exec foo ip link set nk up
>   # ip netns exec foo qemu-system-x86_64 \
>           -kernel $kernel \
>           -drive file=${image_name},index=0,media=disk,format=raw \
>           -append "root=/dev/sda rw console=ttyS0" \
>           -cpu host \
>           -m $memory \
>           -enable-kvm \
>           -device virtio-net-pci,netdev=net0,mac=$mac \
>           -netdev af-xdp,ifname=nk,id=net0,mode=native,queues=1,start-queue=1,inhibit=on,map-path=$dir/xsks_map \
>           -nographic

So AFAICT, this example relies on the control plane installing an XDP
program on the physical NIC which will redirect into the right socket;
and since in this example, qemu will install the XSK socket at index 1
in the xsk map, that XDP program will also need to be aware of the queue
index mapping. I can see from your qemu commit[0] that there's support
on the qemu side for specifying an offset into the map to avoid having
to do this translation in the XDP program, but at the very least that
makes this example incomplete, no?

However, even with a complete example, this breaks isolation in the
sense that the entire XSK map is visible inside the pod, so a
misbehaving qemu could interfere with traffic on other queues (by
clearing the map, say). Which seems less than ideal?

Taking a step back, for AF_XDP we already support decoupling the
application-side access to the redirected packets from the interface,
through the use of sockets. Meaning that your use case here could just
as well be served by the control plane setting up AF_XDP socket(s) on
the physical NIC and passing those into qemu, in which case we don't
need this whole queue proxying dance at all.

So, erm, what am I missing that makes this worth it (for AF_XDP; I can
see how it is useful for other things)? :)

-Toke

[0] https://gitlab.com/qemu-project/qemu/-/commit/e53d9ec7ccc2dbb9378353fe2a89ebdca5cd7015


