Return-Path: <bpf+bounces-49579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DF8A1A7F7
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 17:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CC0316735B
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 16:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95431213241;
	Thu, 23 Jan 2025 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hjDq7i+y"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAD61386DA
	for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737650302; cv=none; b=HrQhSJvHbRKnY6jr/e5eNplMNUrqJ4IP6qKkZ5PdeAad0QF2irY8RkFUhlB48gNZ+jtXOkSnTOPn4gQU62IiezseHdr+z4uwSeUWQKMZHi6fVW67etZ9gz4k7R931v90fJOQMK/QkIC6iZmCdXZOBslzrjaPPjn8qrlhJJFS3xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737650302; c=relaxed/simple;
	bh=fQllFcMWAPgxJPO9jl9X9/ja7J1uVtN03bRxkZfZpQk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QZ0rYeqRMbpjbhF4mWFXaEoGwHoUy7TutlJ71e2m3V79OVGV6ShAjAb+YJiMI+tVmfcXoyQXGMxYjipCJprIHAwlxowgjbFTEUbkk+MBe1PDuf7rigAh9teS0vbh7ZDsyc0oy3afYy+EAeXqQ8J+cW/WjKroaQLOr0IP5gvMseM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hjDq7i+y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737650299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Gp4Lqmck0xLIjlUYaNawF6i7JeDue6Z19dmeCYgLeo=;
	b=hjDq7i+ySg482akgV7MoKDZdwAnnEalYKL6/Zfdx+E6X1KF8daphu7K+4ZBOmPl8fj29lf
	b1WIbD1s+ftPpPQWgY7R4YaLFdeSVB0qpMcTaAtZIXCi17yJo5C3wOEkC3GDZqdfF1H+CY
	C29e5TUbttEJMTOWSCOSzSKEaPxk5tM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-JUuCQRo-O_Gs7kP2Ecbg0g-1; Thu, 23 Jan 2025 11:38:17 -0500
X-MC-Unique: JUuCQRo-O_Gs7kP2Ecbg0g-1
X-Mimecast-MFC-AGG-ID: JUuCQRo-O_Gs7kP2Ecbg0g
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa69e84128aso106164966b.1
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 08:38:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737650296; x=1738255096;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Gp4Lqmck0xLIjlUYaNawF6i7JeDue6Z19dmeCYgLeo=;
        b=alX12ZwGeaRd5+YqO70BAdwqJgUmYS0gWB0YT2RCBy3XwviTQQxquaiPeSbG6wW/zS
         Oeynnz2+XBpHWC2fR2Jysw1hWpsB5ZF4ukOEe+Qw2ssPjDkLKqthnZk7Zucvy7yGEGc8
         5A+Dv8LRVDSGj10JgaqqcrGomSjif3C86vrCq1+dCiXwCIrhFsYCo3raFZT4ybpoICRO
         +OybQhsAvgtBftsiAvy17lUIEy+ID5pCENUFqNofDU6jsP7WR4X8nNw8NX+gwwZ0GrSg
         KWCI2jwkVFvTUU7lkIKkjEiAPeNzgl7Fg4lMSgleNlkxTIgm/zpfPaY6lejR1AoYqQWj
         S6QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdomSZR0EwAH0DngNDKX91W1v64OBeGqBZ4DlFEw/g3DdLPQinkipYB7iZ89NlfKbES2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWbQivSOjJS2NAJKhnbmJlSW9wc1MnJccvQm4ZGIHlATbXni8t
	QLUg8mP+xG3lkYx6UTKCdm8Pgy23EzJT3LEpDPzFBDN8xitIIt7VrHROXy5ukTUzafmTqAnurDh
	fHK9BC2EeZKROgKVjUJj+coB5AFDBEPbkrbbsfGNE954+/wGGZw==
X-Gm-Gg: ASbGncsyDp828FjTgUWOYZ6qZQUG70uiwoJHCRv8/FNFCb/CZV1P9Npg7A3U9EXz6Xb
	U5cFaWjIE5IRS9bVAPvxdnQxWjNYJgfdFIMAg4MMX1QhsjmoM3rAq7z2CA/4j5OV+ROUSWjeaPq
	vfiUJVUyTcPYgO54alFRIu8u9B8tnv4yh1CTsaMIijrLdXzHN71SCNxHWrJTNBcBnbC2jdVmHNk
	fJ0ZtwNsUPcUzvvftLS3Lcnbrl2J8VZa4KfbCrZqJYQl/Fe+F/h29Khw8pq9F2r5sb81SV2ElxX
	Jr2ot1qlEXzIYTtLylg=
X-Received: by 2002:a17:907:6ea1:b0:aa6:89b9:e9c6 with SMTP id a640c23a62f3a-ab38b111647mr1889989566b.21.1737650296515;
        Thu, 23 Jan 2025 08:38:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeseCJzIERzaXWgZcksOt2phO/IlkO0qodKrzTiLkTNIPsYlBA/4wPbBOANdU3ADTZbVrmMQ==
X-Received: by 2002:a17:907:6ea1:b0:aa6:89b9:e9c6 with SMTP id a640c23a62f3a-ab38b111647mr1889988166b.21.1737650296152;
        Thu, 23 Jan 2025 08:38:16 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f87d86sm1091662966b.146.2025.01.23.08.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 08:38:15 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9BD13180A83C; Thu, 23 Jan 2025 17:38:14 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>, bpf@vger.kernel.org
Cc: Stanislav Fomichev <sdf@google.com>
Subject: Re: RX metadata kfuncs cause kernel panic with XDP generic mode
In-Reply-To: <dae862ec-43b5-41a0-8edf-46c59071cdda@hetzner-cloud.de>
References: <dae862ec-43b5-41a0-8edf-46c59071cdda@hetzner-cloud.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 23 Jan 2025 17:38:14 +0100
Message-ID: <87msfhqydl.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de> writes:

> There is probably a check missing somewhere that prevents the use of
> these kfuncs in the scope of do_xdp_generic?

Heh, yeah, we should definitely block device-bound programs from being
attached in generic mode. Something like the below, I guess. Care to
test that out?

-Toke

diff --git a/net/core/dev.c b/net/core/dev.c
index afa2282f2604..c1fa68264989 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9924,6 +9924,10 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
                        NL_SET_ERR_MSG(extack, "Program bound to different device");
                        return -EINVAL;
                }
+               if (bpf_prog_is_dev_bound(new_prog->aux) && mode == XDP_MODE_SKB) {
+                       NL_SET_ERR_MSG(extack, "Can't attach device-bound programs in generic mode");
+                       return -EINVAL;
+               }
                if (new_prog->expected_attach_type == BPF_XDP_DEVMAP) {
                        NL_SET_ERR_MSG(extack, "BPF_XDP_DEVMAP programs can not be attached to a device");
                        return -EINVAL;


