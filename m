Return-Path: <bpf+bounces-73522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C63C335E8
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 00:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98F9B34BE8D
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 23:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02212DEA78;
	Tue,  4 Nov 2025 23:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQhqUswO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C062DC777
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 23:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762298548; cv=none; b=Lb62V0t+QkUAIfcDRhyQpm5za4pMpw2qj/UOlkI4sOMft2JiRFkkALfD8j1ci3+jkDEQMa57J40MTdjPORy7H4uFuuK6ASxzHqcQatlYRXngWa6zZUXhpmsiHFqFDLVxBUmCjij1NV2ts2xADpqrq00wE4NY1Z6kf59+DZ1zYEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762298548; c=relaxed/simple;
	bh=7nfSPumsytiTRTmDQeIgSscuCD4jFGL/qPUnn97EP+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyQxc3lekVyYLuYQtzYqhJF0EnngIMvSHt2l2wc7fAU6whGoybk2P8O4sybyrCFo55nwKKBJazEW0IgPO+qhdeczYC8Vu1mXoZJ1OHNx9V5i49N75lKY/TYV+bad/g4g42gKq3d0JZL6rm4mRvR4R+77kyHDlJXxEl/k/xXriLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQhqUswO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29568d93e87so30888995ad.2
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 15:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762298546; x=1762903346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9B+k56MhML3w6peCidIaihxbl7v6WGNiwGQSlC8dp4w=;
        b=TQhqUswOLONh4bjxx7HwNfiElN/2ZG8p7OVRqPwdNHkcK70wTQJPvfANk3hw8ZW3lv
         5aUBCdmWZcBcJw/Nk4s6R/G63uIuziKjGHW3N5ro/W08VABapjGuGEXiW0TGkoQhSqy4
         oojIdA8UPbwz5VTjdwPHNvqr44gDKFhmMvmW185KeJGf6CcO0O+/hlQ710hkZVnJv5MW
         ZMFtkU5K9Zz4yuNZRWgSfGrsA7tEItfn0VYr4m9qCZvy/VWbv4gd0JqQTdXm5MHC4u0X
         R6fLX17WA7RxFXqE2Nw1o7d2rqqEk+7rA0niEe5/e/L2DbT3+hUhLB6iU4yGQgR9YBWo
         y1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762298546; x=1762903346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9B+k56MhML3w6peCidIaihxbl7v6WGNiwGQSlC8dp4w=;
        b=XlyXuoOIdgQ8eMBfoM5oyMsKeEhyoGdCTLSPtB5szST6gREJJVEIRW/NmePl5TORwx
         7KvYCaXlYuoDwfgDsdcRlYNRJeghIDTATVucEDmJit1rxqXlBEnl99sSR3SFqS/hufsj
         J0U+7cXcJE6dPWlQeW4wEH7JuVbzCIe7bg0IJfe/biGgdATAQNap7Zy02eT0pQM809ZR
         JbBLCCAymxpcdTYCuE0O0/CaI1R9GuBQ/DbInAtx5jO/UD1Fto+7rcY9vT4zfcyCv10m
         pJPRj0RxaqafdygZ6+Nc7inq3cpbbR9BnVrf3x8qvAq+DOJCRXAXb/JVA1XOV6/TA1hL
         Z3EA==
X-Forwarded-Encrypted: i=1; AJvYcCVS4McDScedNIicCTpUAhYZKr1VRvYfKdm9TM0/58BndfoH8AWkAtmGZgX0rqHB2SMwc74=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWb/9kH9u1EtQGYOYv84hcFcoc6vqp1gwshZ3llR+2o4727a/R
	nd8r2X/A/BvMM8IRnLTsvnoRcPnt3puRjIQdbBJt7zzTeAoMRU/e8No=
X-Gm-Gg: ASbGncvIBS2/J/8DayfBeOHN28k1d57X0g+8uHMwXiok9qVTqpKyuiUmAnk5HGYQihu
	02qFKPNnAvz2RbfLOr1oqrkSyk5qpKfdYe13hw/LOu9PQogfWbsKrvWm9Kk6qGHrA/68KDkbwsl
	x2ajHRIhCv8Q0sKCXPUVrbBfyhWacIBgAvGx5V575oOCPJiIpVuWfMhXWJ14gnh8vNSLHqodChc
	cTyc0zKLL3I68Z04g/gJo/UufWGmoW6QQ/PEbqwV6aK3UTwx5IsaF9nKiKuaF87fHrUP9w5s1aM
	Ao62WJzy40VHhRRAezFs/vhX9uCg31afCtE7P9U+4ueNNUp02eafDoqSCJcQcDOiITeqfzlS/l4
	cjSYXd0xDsSwQ9HWQ+m8LBV+0yjY/gpYbaGcI7bYEPbrDA72lwGLQSKuC6kPMF/raHUonaDnQ8v
	iNk2DeEiuD6ELEbsU4mPaPTOf8NKQXiLmqRX0+wiB9OYPNfRvMiiRFeEYnMjK5ZAdwSNelVg8ml
	tcIXVJEoMzMQqUzRbAuGeI43/fSdmVkjM3RVAw7RcB5mDWlIzsIepoV
X-Google-Smtp-Source: AGHT+IHNP2zSm0iR5tnsW6DxXVYzXMNKSGdfZXQAgP6iuwMkLSQncO5CWHZG+W8pqjtvzK10tU+k+Q==
X-Received: by 2002:a17:902:e805:b0:27c:56af:88ea with SMTP id d9443c01a7336-2962ae93ffbmr14100715ad.60.1762298545481;
        Tue, 04 Nov 2025 15:22:25 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296019729f4sm39075475ad.14.2025.11.04.15.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 15:22:24 -0800 (PST)
Date: Tue, 4 Nov 2025 15:22:24 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v4 00/14] netkit: Support for io_uring zero-copy
 and AF_XDP
Message-ID: <aQqKsGDdeYQqA91s@mini-arch>
References: <20251031212103.310683-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251031212103.310683-1-daniel@iogearbox.net>

On 10/31, Daniel Borkmann wrote:
> Containers use virtual netdevs to route traffic from a physical netdev
> in the host namespace. They do not have access to the physical netdev
> in the host and thus can't use memory providers or AF_XDP that require
> reconfiguring/restarting queues in the physical netdev.
> 
> This patchset adds the concept of queue peering to virtual netdevs that
> allow containers to use memory providers and AF_XDP at native speed.
> These mapped queues are bound to a real queue in a physical netdev and
> act as a proxy.
> 
> Memory providers and AF_XDP operations takes an ifindex and queue id,
> so containers would pass in an ifindex for a virtual netdev and a queue
> id of a mapped queue, which then gets proxied to the underlying real
> queue. Peered queues are created and bound to a real queue atomically
> through a generic ynl netdev operation.
> 
> We have implemented support for this concept in netkit and tested the
> latter against Nvidia ConnectX-6 (mlx5) as well as Broadcom BCM957504
> (bnxt_en) 100G NICs. For more details see the individual patches.
> 
> v3->v4:
>  - ndo_queue_create store dst queue via arg (Nikolay)
>  - Small nits like a spelling issue + rev xmas (Nikolay)
>  - admin-perm flag in bind-queue spec (Jakub)
>  - Fix potential ABBA deadlock situation in bind (Jakub, Paolo, Stan)
>  - Add a peer dev_tracker to not reuse the sysfs one (Jakub)
>  - New patch (12/14) to handle the underlying device going away (Jakub)
>  - Improve commit message on queue-get (Jakub)
>  - Do not expose phys dev info from container on queue-get (Jakub)
>  - Add netif_put_rx_queue_peer_locked to simplify code (Stan)
>  - Rework xsk handling to simplify the code and drop a few patches
>  - Rebase and retested everything with mlx5 + bnxt_en

I mostly looked at patches 1-8 and they look good to me. Will it be
possible to put your sample runs from 13 and 14 into a selftest form? Even
if you require real hw, that should be doable, similar to
tools/testing/selftests/drivers/net/hw/devmem.py, right?

