Return-Path: <bpf+bounces-56682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87775A9C1AD
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 10:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174B51BA7CEA
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 08:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F89236426;
	Fri, 25 Apr 2025 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="islUnSNc"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79468253946
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 08:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745570158; cv=none; b=uPNuekOnoVzQ8bOjWW3z6HTaNWmZJI5URU8+j+rEuAspJiaqY9JEk5LesdhxKOEAWLxHA4FkGImU/BU5SIMnjPxOVWlPG8o7BAelJAByeRQn8X2MNQhn0eg+bT391+QOOz/82TlWb8DxqYmp8Xhhiu9BMLLp4PG6BREdcy+oB4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745570158; c=relaxed/simple;
	bh=W0OGvNpepYMtQUI2P000WddWaGAaKqDLXnohX671FZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSP1ApYQcEtHDVzBTz6RyAmAa0sQAf7vjwNQsCkJSXRoaNcWveltV0hSkdJUojgN/EvdSPIylaeykZnQM5SaXGuZ1cJsiDrVb+tQ+kPZMFeK5nWvYvG/0M4W2X2GqTXSHfDJtqw+xYRT5OPgsB4KdcDqrYGMBLFFnKTXIWzyfjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=islUnSNc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745570155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VIpzb0kJnabV+/Rbk1AeDaWRoPqgDoiA6nLSqcAP3Qs=;
	b=islUnSNcmoHVw1oYCIr7DD1r5DIOY0N12VIVvTP6wxn0Umm+snMczVx2tSZytw3G8VrLle
	aj1hplCxbH8ma5y+pvLvB+iiS2FFc5xBBDUX5+HfaYPD0AoKhqYp7G3RSmkt2YPgk324KL
	5C15Z7D8U1r7O7wH2j+jsuwnZQgneBs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-_ESF_sPwPMq43Sck7DJJHw-1; Fri, 25 Apr 2025 04:35:53 -0400
X-MC-Unique: _ESF_sPwPMq43Sck7DJJHw-1
X-Mimecast-MFC-AGG-ID: _ESF_sPwPMq43Sck7DJJHw_1745570152
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43eea5a5d80so8644945e9.1
        for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 01:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745570152; x=1746174952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIpzb0kJnabV+/Rbk1AeDaWRoPqgDoiA6nLSqcAP3Qs=;
        b=ORXwIxrE2rsvx2x3ENgOyKSdSoDOCuMNdjSlS9jwTwhcT8Wcj+xn41cC/LId1zKwYc
         iR5KBWhI6j7VyEzsAZXDDZr4HmRceA0LDgmxsiNd6wWX417z5srOlo8Im9vprHwKTYNp
         U+Q9UtFGfJmlLPwbvGTUXlGVSJCN1Yq6oXBdljf2/QlwJcpWd0O1DjTjBhcjm5VykFXP
         BDiH9yAvebbKNg2cQ7cEkXPck9rSKi4s434qk9XSL9W0lnfnSxwCaRAiPszZKYOmElj7
         K8qHnx/UeX7eFYpWzbyKIkeJV7N+LwrmlFbqo1edVJo/ZUHTlbX18nCWG03cFBKmYubM
         Ny/w==
X-Forwarded-Encrypted: i=1; AJvYcCVZyFwuAIZC1sxkPUJnxSxP5hrkJ6sBCtvffADCdLVabcgb6LkuK7tQ+b2wN/fmLq9r/Kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI5OZMbpNawkK5GfmN2dAV4RxgThhmkhrimG0aWe2IECynxTQE
	n16OY5oPHG+PGmaNqW4x9dRSiWh0eBNrQgqbne3CtjbBTptJTojyU3l9r46w9CJ2oniXN3zMFHm
	Q7oA+vFy8Fo9aehqlBjqL/pmoeToxltziV7O4AtMXsIY44fnHxA==
X-Gm-Gg: ASbGncsAC0iUz9BMdHkGP2z/l6fAMp0X+uvnXeitaTFcyIThVW/FjWalnlVjnjB/i2h
	YadssJawyelQWk8sv9HY2Rd44ZiM7ebat+XpQy3LWQ+6hA5sRCFuIV25kk/AGLqla9mGNLs6Otr
	6bejI6VumHs6ch5koGceny6qJikLbVcx9xjAFf6mdyWzZfraX6FZzWRyPz69AMyXgdZiZ9NYxi6
	sTVmbXQ/rdeqBvj6GWaQ/hB//68d8UIQgEYzxE/kLk89I01c68AqU4NM83+7G4WJWWjyMbpAC7b
	sSSjgw==
X-Received: by 2002:a05:600d:19:b0:43c:fabf:9146 with SMTP id 5b1f17b1804b1-440a66d9ba5mr12028225e9.17.1745570152502;
        Fri, 25 Apr 2025 01:35:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVwMxFD5f3mySi27LmA61xgw9SkI2YEf5bOWu+NSzAJvOJz2O8GeJpN1BaqSOng5t4z7wJTg==
X-Received: by 2002:a05:600d:19:b0:43c:fabf:9146 with SMTP id 5b1f17b1804b1-440a66d9ba5mr12027935e9.17.1745570152192;
        Fri, 25 Apr 2025 01:35:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a5310a8fsm17114375e9.22.2025.04.25.01.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 01:35:51 -0700 (PDT)
Date: Fri, 25 Apr 2025 04:35:47 -0400
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
Subject: Re: [PATCH v6 0/4] virtio-net: disable delayed refill when pausing rx
Message-ID: <20250425043542-mutt-send-email-mst@kernel.org>
References: <20250425071018.36078-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425071018.36078-1-minhquangbui99@gmail.com>

On Fri, Apr 25, 2025 at 02:10:14PM +0700, Bui Quang Minh wrote:
> Hi everyone,
> 
> This only includes the selftest for virtio-net deadlock bug. The fix
> commit has been applied already.
> 
> Link: https://lore.kernel.org/virtualization/174537302875.2111809.8543884098526067319.git-patchwork-notify@kernel.org/T/

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Version 6 changes:
> - Rebase on net-next and resolve conflicts
> - Move the retry logic to xdp_helper
> 
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
> Bui Quang Minh (4):
>   selftests: net: move xdp_helper to net/lib
>   selftests: net: add flag to force zerocopy mode in xdp_helper
>   selftests: net: retry when bind returns EBUSY in xdp_helper
>   selftests: net: add a virtio_net deadlock selftest
> 
>  .../testing/selftests/drivers/net/.gitignore  |  1 -
>  tools/testing/selftests/drivers/net/Makefile  |  1 -
>  .../testing/selftests/drivers/net/hw/Makefile |  1 +
>  .../selftests/drivers/net/hw/xsk_reconfig.py  | 60 +++++++++++++++++++
>  .../selftests/drivers/net/napi_id_helper.c    |  2 +-
>  tools/testing/selftests/drivers/net/queues.py |  4 +-
>  tools/testing/selftests/net/lib/.gitignore    |  1 +
>  tools/testing/selftests/net/lib/Makefile      |  1 +
>  .../selftests/{drivers/net => net/lib}/ksft.h |  0
>  .../{drivers/net => net/lib}/xdp_helper.c     | 39 +++++++++---
>  10 files changed, 98 insertions(+), 12 deletions(-)
>  create mode 100755 tools/testing/selftests/drivers/net/hw/xsk_reconfig.py
>  rename tools/testing/selftests/{drivers/net => net/lib}/ksft.h (100%)
>  rename tools/testing/selftests/{drivers/net => net/lib}/xdp_helper.c (78%)
> 
> -- 
> 2.43.0


