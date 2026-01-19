Return-Path: <bpf+bounces-79386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B680D39C04
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 02:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DA9430080F8
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 01:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4061F09A5;
	Mon, 19 Jan 2026 01:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzRZXCMK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923302C86D
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 01:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768787042; cv=none; b=etEsxmXzF7kS8zqKFEFLbo9teUS34iBZhB+ALM8ZTrobFhHIg48t8cKfHnaGswZMix3EgZtavizyeIIErVw52uaMzsuQVkYZhHoqsfa1WGV+AqZWETBtjwsC0wQji51euPIX+j1RndANCJ8OUh9cBBuQN2O9waDoHAgVXJsY2Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768787042; c=relaxed/simple;
	bh=Mix0Ftnx+BxVDygDOXrtQuC7sxcn6TtpX8USBjwJolU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=of8x/ijq5Cu3fb06tDwdrPA00ZwHg1pgxjstGQh5PVnxnj63xDt+X6xPBxWW+0Kn25xO1uCp7/TLuu8Oksmtr9hdwOvhjZPG2TQX4YiYbuiOZHupb+WBPxKRgy+h8n3ao7Lg+VMLS7TVEEsfXn2OMwYW7ZfLjt/+DK6vx0VexV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzRZXCMK; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1233bc1117fso2408882c88.0
        for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 17:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768787041; x=1769391841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uc0UZ+YA//A4FjfGDE4kvF/Ys5up+mdRLfJ0LnYTjqU=;
        b=TzRZXCMKE4JlLS1isNOv/Qb5qqgdaWc/HkxaS/rqhjtCW5+MDOssBNg7mz3cavg81k
         KibgoLarm/NMLYFd4xboIHfU+kisAWuzOpcJxAZH4jkh269NULz1KsgrQAEl0uBwhPp6
         hoh0iH4M5C7gimADw0DxwVDCSq8tUyxmUzDWbaL1gtdMDA8QEM71R5ecT9bYwo7CHnyE
         Hqp1nNKzCC2gemB2XdfKph6eKXHSKIE/6OBsvMRlp3uCa8lKg4DIyHrtrpUIlNLhRjBI
         SaG5jbqaq7fwltl95cbVJiWybLW25XRynvVz8ouy79FbWKvBebdcoP77RrUW0ozWFPbW
         BrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768787041; x=1769391841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uc0UZ+YA//A4FjfGDE4kvF/Ys5up+mdRLfJ0LnYTjqU=;
        b=VhFQkwXNY1culeCQfSfVU6KnTS7jfvN0B6GE9pTOdEz6N0eD/buuN/InTp9FrLYy9R
         y/1/uxBJRgJ9KE575w/HPpY+gPJgf7vxM+U0Xt26Ldga5W+qqrz1iIzVgb6OHev4eSBa
         zLxeNJLszhOErRFA7ssxIa46KC24EWh/64rsBBHtIkZhImr00v/1ry+JPe5mGmmn/Oy8
         8l6s/VTiX8sNhinVf8foDHLMFeftnRE+sOZ0WWXhHP9E+jYefPmopGeMN64WjHvByEE+
         1t5L6klCIc2PjNOy6f6e1NLnzw5LhV9hcZ0GMdqVHmc2ikudPZKlBFKEBSp+bqNakP4F
         r7EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTZ92ZP0X/LxKYmhv3LpDYVzf+anXZJhYZoonXmLai9WFbxq+yfE4bfpjp5NM0tzV64e0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK+KRpxwEJ2StGlaqCVcjJIy+5qznEmOhsrJscP2VE70ej6nWw
	Guqr580XGcYFN2z8S8Kdd6f/6Te5DN6L1VP4n80ZUj5f687Ohuf3kdk=
X-Gm-Gg: AY/fxX5/SVTtBfDR651Up2e6hsNdvO8ZlX+f9Sxcc9n2bC89tg6QgXzIdeSopYe+WN9
	KnjDxOthB1zpwRlZ6DBZGo/SVEzBEJ8rrx8Y2diCA/voeLrN5i0DU0n32H4wnoGyQL1Gyz2vpAC
	arB7YFWDI7si401e+X7yc2xhYsh6m+tB/vQSwA2eJiCe+uq0jB9YHFcO8KDFrUbjKt3t0ZaPgSP
	PZOTZhsLoHy3LMcTIRGdN+0dtQMO1IQ+BJKTLS1zAqDoSl71TRsmXzNRBxfpa34yPVX+/Zx8X7T
	oSXyqrctO+NGlUzeBREdlxn/UspQg3tk+vJcEjRm0DoyRL2K7oBKEiAKGH4I91iwK+3VNotzdq4
	MC5dXzl9JDhsxBa6CY6VGhygsTnOCWxq2CHAuMjmEd4m+aF0kvVkE/rM8rmv+Fwo8pkBc4t2MI9
	sWRzvdar9P95C/+/39hso5qjAhHdB5k9xppNr8x1lRtZOjcPLoLw5K6swob93eJopGySZhyTidE
	m+lpA==
X-Received: by 2002:a05:7300:30c8:b0:2b4:5618:be67 with SMTP id 5a478bee46e88-2b6b3498c2dmr9318945eec.5.1768787040352;
        Sun, 18 Jan 2026 17:44:00 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b351e38bsm10958149eec.14.2026.01.18.17.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 17:43:59 -0800 (PST)
Date: Sun, 18 Jan 2026 17:43:58 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 01/16] net: Add queue-create operation
Message-ID: <aW2MXiopZOUZLgSE@mini-arch>
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-2-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115082603.219152-2-daniel@iogearbox.net>

On 01/15, Daniel Borkmann wrote:
> Add a ynl netdev family operation called queue-create that creates a
> new queue on a netdevice:
> 
>       name: queue-create
>       attribute-set: queue
>       flags: [admin-perm]
>       do:
>         request:
>           attributes:
>             - ifindex
>             - type
>             - lease
>         reply: &queue-create-op
>           attributes:
>             - id
> 
> This is a generic operation such that it can be extended for various
> use cases in future. Right now it is mandatory to specify ifindex,
> the queue type which is enforced to rx and a lease. The newly created
> queue id is returned to the caller.
> 
> A queue from a virtual device can have a lease which refers to another
> queue from a physical device. This is useful for memory providers
> and AF_XDP operations which take an ifindex and queue id to allow
> applications to bind against virtual devices in containers. The lease
> couples both queues together and allows to proxy the operations from
> a virtual device in a container to the physical device.
> 
> In future, the nested lease attribute can be lifted and made optional
> for other use-cases such as dynamic queue creation for physical
> netdevs. The lack of lease and the specification of the physical
> device as an ifindex will imply that we need a real queue to be
> allocated. Similarly, the queue type enforcement to rx can then be
> lifted as well to support tx.
> 
> An early implementation had only driver-specific integration [0], but
> in order for other virtual devices to reuse, it makes sense to have
> this as a generic API in core net.
> 
> For leasing queues, the virtual netdev must have real_num_rx_queue
> less than num_rx_queues at the time of calling queue-create. The
> queue-type must be rx as only rx queues are supported for leasing
> for now. We also enforce that the queue-create ifindex must point
> to a virtual device, and that the nested lease attribute's ifindex
> must point to a physical device. The nested lease attribute set
> contains a netns-id attribute which is currently only intended for
> dumping as part of the queue-get operation. Also, it is modeled as
> an s32 type similarly as done elsewhere in the stack.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> Link: https://bpfconf.ebpf.io/bpfconf2025/bpfconf2025_material/lsfmmbpf_2025_netkit_borkmann.pdf [0]

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

