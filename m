Return-Path: <bpf+bounces-56584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FFAA9AB55
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 13:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A60897A6CC5
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 11:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7737226888;
	Thu, 24 Apr 2025 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqK3M/FA"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B191224239
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745492596; cv=none; b=cb+YFR0SG14AXKqL6cqK61mjB+VzVBanwF2YUA+tutFryyfsBs5ODdjjBObVYiEbdfwAkAUIlgF8mLyhpmRgqz6wJ3UneCeO6f/4Y5IBxIIhZZJXnXoI/WVoz/f5fUQSeqxEvcjkvsKNY+LqbbJA9m08Zl2DeNWU5p7YVXCMNto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745492596; c=relaxed/simple;
	bh=OnEK4+ktkuTBVd4LCgvO2/u1sSZlYN0t7X50RZpIPls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGKDjWWQQUX/nue+njJT+fglP9GYx7BLw0Ic3A1gUKXOOqEV5ID8z+HXJZwzJNFGl2/reYpbbYsWOIooYtPZZu4UWH3/+sMLDu5KU9zDZ4KcN+1o0/osZPTwr3AXvB4QWMee/pnq4oCx5xGe/hXFkORU+0E6iWgCC2UT1lSqeVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XqK3M/FA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745492592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OB+hDp/hkN/T5Zk53qLd2kwTdWBUeriKnar6WFmgAY8=;
	b=XqK3M/FA19y+Zafg23+eyMEbbOPPf/yzrtpEFMRVYFu2O+1twQksdUjOxrI8VItvxIYtOV
	coXDSOyQR4uxH/GC6DjxuNZJeWzTeH6U8IIbx1sa8uH81buSCiqRU3v+Pgg5NW6WzrtptX
	BtD7hw66i9AisuLtsdz70ylvql3mof0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-Wr-wjddRMHyoorUQFOlQIQ-1; Thu, 24 Apr 2025 07:03:10 -0400
X-MC-Unique: Wr-wjddRMHyoorUQFOlQIQ-1
X-Mimecast-MFC-AGG-ID: Wr-wjddRMHyoorUQFOlQIQ_1745492589
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d00017e9dso4868065e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 04:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745492589; x=1746097389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OB+hDp/hkN/T5Zk53qLd2kwTdWBUeriKnar6WFmgAY8=;
        b=oTl1v1i7rEV8PDaP6o6dy18HbrnTWZWy48mvZES4o54ukP/tNWhQ+qslS/Q6q+6uD2
         wrNBWhNAjNL0tpYYdzgHYgSDfqStfgG9GcX8UwendRpqDD37uTJp0RZk7MuiTsOYIDtf
         EJWqkIjP+aUeHspT2DJ1S7xUDkcRnwTMzIV1+hStKGIoqMAzJrsO5maSYVXGt5OpBD51
         Cs3TLlGrzBaBBEUhYbnq9IkAcYY1qXVPfHWD+xWK08JHwpSbByKEn1XqzyVTQBm+7tud
         bb19l98RjNniMes8HhcKVnqSOE17Np9lmh3H9rHwxjV2h9FC8Naanz4Ba2RKLqmcVkTr
         Tu0A==
X-Forwarded-Encrypted: i=1; AJvYcCUD4k30I0+8jziLO96AXRaZxzRt2osn2+73HvhB5/oFaA2O2slGHS372QVUhv9zjHblwAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnBqVDCmL8cLtSLc2HHV3iPs3FZTNJ6Ovnhs+42NAGmIYm1CU3
	iaxfeP/1AiGVWUk1l+HdVC4uRL7lYoMJwiLoBriE6aE9meqZVnZKlSQpdSHonG6oxSQ1pk5/RnQ
	NFBvIa01T1YyVJ/dz9qKVxdOoHWZEClmiTaqrjwssQywKmRIA8g==
X-Gm-Gg: ASbGnctpNd9pz5UakIr+wEZ6qWOBA12yZJCHsXs/J/1ihrr6hwPdfUbujr/IGKNhbcP
	8+IICSel8/pLYvvfXwrZcD7UTeRnfp4pXddollPdVVCD9fQopbLUgVQhN/G44xQjj3RF7zItfu7
	O0PC+Q92FYjyMDgz/kT5qn5uY/Patq/TcAlDKlHGQbKxaB3ypDTFD/n2k7TBoA3CNcxBuINmJrw
	TNFvvxU4RZvP+Jo1zA3xTggC1L+yGy2HmwQTTOkF8bvUEG0N3dw1PXLZuLxjLEu/az3qw9kX+2x
	5FV/NA==
X-Received: by 2002:a05:600c:3516:b0:43d:1840:a13f with SMTP id 5b1f17b1804b1-4409bda6055mr16048915e9.25.1745492589464;
        Thu, 24 Apr 2025 04:03:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtu0yCr7M7AP7EC3ZZSx9xsMrsn304Zj6V6BYFUjfak8chlhsmlR6+Poqw3gaQbMFvkrartg==
X-Received: by 2002:a05:600c:3516:b0:43d:1840:a13f with SMTP id 5b1f17b1804b1-4409bda6055mr16048345e9.25.1745492588928;
        Thu, 24 Apr 2025 04:03:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4408d839711sm57806515e9.0.2025.04.24.04.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 04:03:08 -0700 (PDT)
Date: Thu, 24 Apr 2025 07:03:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v5 0/3] virtio-net: disable delayed refill when pausing rx
Message-ID: <20250424070300-mutt-send-email-mst@kernel.org>
References: <20250424104716.40453-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424104716.40453-1-minhquangbui99@gmail.com>

On Thu, Apr 24, 2025 at 05:47:13PM +0700, Bui Quang Minh wrote:
> Hi everyone,
> 
> This only includes the selftest for virtio-net deadlock bug. The fix
> commit has been applied already.
> 
> Link: https://lore.kernel.org/virtualization/174537302875.2111809.8543884098526067319.git-patchwork-notify@kernel.org/T/

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Version 5 changes:
> - Refactor the selftest
> 
> Version 4 changes:
> - Add force zerocopy mode to xdp_helper
> - Make virtio_net selftest use force zerocopy mode
> - Move virtio_net selftest to drivers/net/hw
> 
> Version 3 changes:
> - Patch 1: refactor to avoid code duplication
> 
> Version 2 changes:
> - Add selftest for deadlock scenario
> 
> Thanks,
> Quang Minh.
> 
> Bui Quang Minh (3):
>   selftests: net: move xdp_helper to net/lib
>   selftests: net: add flag to force zerocopy mode in xdp_helper
>   selftests: net: add a virtio_net deadlock selftest
> 
>  tools/testing/selftests/drivers/net/Makefile  |  2 -
>  .../testing/selftests/drivers/net/hw/Makefile |  1 +
>  .../selftests/drivers/net/hw/xsk_reconfig.py  | 68 +++++++++++++++++++
>  tools/testing/selftests/drivers/net/queues.py |  4 +-
>  tools/testing/selftests/net/lib/.gitignore    |  1 +
>  tools/testing/selftests/net/lib/Makefile      |  1 +
>  .../{drivers/net => net/lib}/xdp_helper.c     | 19 +++++-
>  7 files changed, 90 insertions(+), 6 deletions(-)
>  create mode 100755 tools/testing/selftests/drivers/net/hw/xsk_reconfig.py
>  rename tools/testing/selftests/{drivers/net => net/lib}/xdp_helper.c (90%)
> 
> -- 
> 2.43.0


