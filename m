Return-Path: <bpf+bounces-22909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D3A86B737
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 19:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8615B1F26AB4
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 18:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A6D71EC2;
	Wed, 28 Feb 2024 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbG9uOYs"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97C8200DA
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 18:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709145072; cv=none; b=hezIuCHez56QF/sAedGzqf+4m4/cYebxVf3KcTJ85j5F+zntHXwz3/jKmFZwuWWbNpgnhCNPBXHdY8rh7I2To76JTWyvdOeRI3DkLToYfWBZlY9bm80utJcQK/uznW9YJtqusTXXXML6OBFXU4VjTJAbI/xklOQxaHW+hZ3dEZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709145072; c=relaxed/simple;
	bh=s/2MSjG8UyaUs97mrM1q6zQgCW0Xk0or22c3BdoaHmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E14zfBgsTwgQM92FZl3EUsNGG/dm5kNlAzS2hLrGQWNEJZyC875RCIyWhGaGVaKR/iUuxQollCmiqOdhkec1U1jgLi1NRyPOxpRVk17oEx4f+QO0qGRpd6ld8Lw6jnKF6AgV31Idaju9UhpPGt7Yokjj4zCK+w5bSOf+45s17v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bbG9uOYs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709145068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=weArB08m8SQ4hme6AVbC9RsZWLdEnvH6fsjtADsJEm8=;
	b=bbG9uOYs5e/eFxyr/drVE+4CE8YHANICxX4H6wuIpnNSDHTUjQCLg9ZnKVE9887VIqyuwb
	P/8TNB8ng9Hv412MjXs3zY53kpvOZHezrxqK+zZypRFk8FahYX3GgwgGij+KgjKl2+pnc5
	gv5RrJuidaVw6+h9TzEmK0xcIB3r2w8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-fOKSs1mXOhWLjs3R6hH0fg-1; Wed, 28 Feb 2024 13:31:07 -0500
X-MC-Unique: fOKSs1mXOhWLjs3R6hH0fg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-412a44c72c1so190835e9.1
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 10:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709145066; x=1709749866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weArB08m8SQ4hme6AVbC9RsZWLdEnvH6fsjtADsJEm8=;
        b=GGsf6swZ6OXhhRz+YfEP/iaxAP4y0NcgOAeWdxKapZ8FDFqhlS/+AaxiixmT9h4EIe
         icbs0wpvp/nSO8DzLhRgyznWdGDCubcO9j/Ti3x31dDlWHlxeRGOXS24CpY9+X58RSTv
         xkOvim0LKQPnnxy9BrYIyuSGJ50Arg1StVKc0TWxJunRjnvF0altNsGD++S3vx9qNfXa
         v/tPUzHUNo11pcPpSLoSB9NfO7rYLzewCTCJrZIaCRf9mzHasFVK7jkW5RfYYudH8Zp8
         9+aUJI+IbiV+xL8Y2gnMGazHoybrXsLs9xLrypfpZJUka4YKBCOnv9ZPvBwBjVQ9bybR
         VW0w==
X-Forwarded-Encrypted: i=1; AJvYcCXOAMduSEjvKy7Cav0klrBu0OHMFXCMXnLrv3i0MNrM77gUQRhdahP9+yxxFlqeeQHg23A32lYtLikpTZEgIgIflu8Z
X-Gm-Message-State: AOJu0YxarrB/I+t3hxAM3iU9IGUrLAhLRpCRBQloSGc/FZ4QP/inUBl4
	aoH0LF1aIt3gnsO2OKOLgjJWghLswQMLHj5hwwTU/0q5YUYtzYa4vWfBAXlk+VYErbnjf34Ettn
	vu4JYwyHNBmpWkMNYIt7pNTzpSaXjSGoYSG8S2+5NQj0ElLhjhA==
X-Received: by 2002:adf:9bdc:0:b0:33d:50cd:4672 with SMTP id e28-20020adf9bdc000000b0033d50cd4672mr256188wrc.21.1709145066136;
        Wed, 28 Feb 2024 10:31:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbucOOcYdc5E7w1hWPrlSDUK3hHwk9fJn5afQ97oLMcIn3c+BDLdxi5c2NUzfMbk+v1xT5yw==
X-Received: by 2002:adf:9bdc:0:b0:33d:50cd:4672 with SMTP id e28-20020adf9bdc000000b0033d50cd4672mr256168wrc.21.1709145065820;
        Wed, 28 Feb 2024 10:31:05 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:d6b0:a21c:61c4:2098:5db])
        by smtp.gmail.com with ESMTPSA id bx10-20020a5d5b0a000000b0033b2799815csm15646500wrb.86.2024.02.28.10.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 10:31:05 -0800 (PST)
Date: Wed, 28 Feb 2024 13:31:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yunjian Wang <wangyunjian@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com, kuba@kernel.org,
	bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	davem@davemloft.net, bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, xudingke@huawei.com,
	liwei395@huawei.com
Subject: Re: [PATCH net-next v2 0/3] tun: AF_XDP Tx zero-copy support
Message-ID: <20240228133035-mutt-send-email-mst@kernel.org>
References: <1709118281-125508-1-git-send-email-wangyunjian@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1709118281-125508-1-git-send-email-wangyunjian@huawei.com>

On Wed, Feb 28, 2024 at 07:04:41PM +0800, Yunjian Wang wrote:
> Hi all:
> 
> Now, some drivers support the zero-copy feature of AF_XDP sockets,
> which can significantly reduce CPU utilization for XDP programs.
> 
> This patch set allows TUN to also support the AF_XDP Tx zero-copy
> feature. It is based on Linux 6.8.0+(openEuler 23.09) and has
> successfully passed Netperf and Netserver stress testing with
> multiple streams between VM A and VM B, using AF_XDP and OVS.
> 
> The performance testing was performed on a Intel E5-2620 2.40GHz
> machine. Traffic were generated/send through TUN(testpmd txonly
> with AF_XDP) to VM (testpmd rxonly in guest).
> 
> +------+---------+---------+---------+
> |      |   copy  |zero-copy| speedup |
> +------+---------+---------+---------+
> | UDP  |   Mpps  |   Mpps  |    %    |
> | 64   |   2.5   |   4.0   |   60%   |
> | 512  |   2.1   |   3.6   |   71%   |
> | 1024 |   1.9   |   3.3   |   73%   |
> +------+---------+---------+---------+
> 
> Yunjian Wang (3):
>   xsk: Remove non-zero 'dma_page' check in xp_assign_dev
>   vhost_net: Call peek_len when using xdp
>   tun: AF_XDP Tx zero-copy support


threading broken pls repost.

vhost bits look ok though:

Acked-by: Michael S. Tsirkin <mst@redhat.com>


>  drivers/net/tun.c       | 177 ++++++++++++++++++++++++++++++++++++++--
>  drivers/vhost/net.c     |  21 +++--
>  include/linux/if_tun.h  |  32 ++++++++
>  net/xdp/xsk_buff_pool.c |   7 --
>  4 files changed, 220 insertions(+), 17 deletions(-)
> 
> -- 
> 2.41.0


