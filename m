Return-Path: <bpf+bounces-58998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6F1AC52A2
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 18:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDCF016F741
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 16:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3B527E7CF;
	Tue, 27 May 2025 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAfHfOjj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D94013D8A3;
	Tue, 27 May 2025 16:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748361953; cv=none; b=PskXGZnDVFpNWhY5LlVhWu22LfwdK+eA9B+G4/xLakg2zTTLDj25jgODqGYvJdT1NjMVGxafCXA0d1SNXl961hsi02szV551AwPtt8dnB7mzbq4Hn2RjSOhO3sZK0rlx5C69+ArkzDCFmpioYRdgik4Tk8pB9OmPw1uiLXwio1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748361953; c=relaxed/simple;
	bh=3uVamAYw/ZZsmkv6b5apdDz4d9BOYuF8j0j1I7FdKeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfzyvBUdnD2M7Roax2DB/3dzqi3X1XWopnmCcSzmXzAAJTZIU1+L2+WNczzGostPS18d4XMDIRVXG3o64ZcQeF5+/DmX5uj4a2akoDzAxVGyskyhudyfG6ZGFtI9pvYs7aHgdJ7UkznyVgzmlsYc0Zggn+KvuCRmFnIEwtF+7Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAfHfOjj; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3081fe5987eso2729050a91.3;
        Tue, 27 May 2025 09:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748361951; x=1748966751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Qry7udYRwjpqYXgqHUem8Ub7uWZYWgOWIelkcLeOFI=;
        b=CAfHfOjjs8iYx1lgQxda7Nknp9Pi53EzXGLio3ePcmET5xMiIR26wozsu/UCEUtX9l
         kpxOHDe/IAqKi05VLPIn09YqyTXgmNXOxkWZ0VgE0WMaZF/f89QHTXXMU0I5GaG2usK9
         dkiygIbfa3gHgNm5aS2m2BxEhxvMUkCUzXJlryscE2UmWVfPWbiQ+Auw1Rk80nV4WyCH
         FcmituzgxjBfuJ8RB4TYZ77JyvWXrcQSsHLCH9m7FU3wr70uWysap8QM7mCm+V15epar
         w7pdWs8Onl7lcfquUBQg4JCIvCcR6uDxkf8IiXv63i92US+uO1+A7LHNt8DwPwilu6be
         n3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748361951; x=1748966751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Qry7udYRwjpqYXgqHUem8Ub7uWZYWgOWIelkcLeOFI=;
        b=TBNhbMBbb/cI/vveFnGdYWWyy6XbEojiPNXOjWgumAjziiCFiaztB2WjwGlzyfaFyB
         PfVboW8wG6tzLDCo6xqG+VqWVX5nZEsEc/zMbZG2WTxSeGIAX7e6DWsY12MZoWpzQc84
         k17+TnzFga3d/MpOsarPCF1G7Z0TzCGhT5sqyiVsiHGcZuemUyo1gaWZDtb8mFc/nfHp
         1qr4lQOAA0UQZRyOnHvtpR5s8pdycn1ZL2ZsV/a71FV/ddpT6LlN7jiSn8PfyBrY2PF6
         mNjcue9f+0gzunjOF8Wy+1OQJfljeA5P1tKwoChDrT/EAsiGOSArf4lgfjBtXNXhBR2x
         sQSA==
X-Forwarded-Encrypted: i=1; AJvYcCVz3YxTI7QjB+Bq8NPoI+g527cKidWF9I4ybVGtGeNkNO5diZ5nmon7IKEdoqG7x9wj77Ouv23oiguG+CkG@vger.kernel.org, AJvYcCWZSrqvmad6cpbYiEUupxsXOsYa08vzGLvrO9Iz1JF5vWR6iy7sJglbnin5naLUcg153i4=@vger.kernel.org, AJvYcCXMUxbmxYZZtsHH9/IiAVbGyFjZnemxvjRQoH2XKr/+fEb7gPFXLOWJPNwGPE2H1WzrxB14sgIW@vger.kernel.org, AJvYcCXzR+mBh9TUHQ7jwpCNZyCHPlzDxVeo8Wy8+7bTk4GuvfimztyH5HQDtYkIgGPmldDy42DmwEnElkyJQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIoqZE3/laNBKMJJ146GX7TEypYmFttcVUjFo4ZIEWWbqeJ3vL
	h+S0pjRJQ+BcU87w5mhprRUi+0T2Misjs1v9sFz9o4GGFF7xXSm3f7M=
X-Gm-Gg: ASbGncuCsBEdtl7sk8A2z5NQFjufnU6Fk1rZ5AhOEYLT8YYn8k6CiFg85rwR7gIKUjS
	YSvSVZAEki8wqtJCSF+bjc3cmW7aJZjpbwmNrxxJsU9negP0Ud/zUrGvHmITWccSRnDnnyeKJxR
	eRyLZoVMJyS8IH3Ep+dc6m4Jj467tDSV9inoyM/nWIH9DiulrZcJduchzNhd8Z32rqsDVJYd77D
	yyBcC3tc9+tNG5qzxgrDrgS/iSA7sFYhKP+HEeOw+irXiFGluw20oBv7NQ1OteXpRvBlHRASYxT
	Vy6axOEawkoCGnbbzTfXKwMpJOTyi+gvApq7wD4DKrcWSvLo0FdQea3tj6Nsn/9eqYJ4vK6EiRB
	ZzRm389+r+z67
X-Google-Smtp-Source: AGHT+IGQle7yz7txHkcZJJeQ7vhqL2kOqgfxzaXuleoaBckDZAadK0HPUqlnTevvgVxcFugate7byg==
X-Received: by 2002:a17:90b:358e:b0:311:9c9a:58d7 with SMTP id 98e67ed59e1d1-3119c9a5b91mr5059535a91.19.1748361950545;
        Tue, 27 May 2025 09:05:50 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3110f0926c7sm7425747a91.27.2025.05.27.09.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 09:05:50 -0700 (PDT)
Date: Tue, 27 May 2025 09:05:49 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next V2 00/11] net/mlx5e: Add support for devmem and
 io_uring TCP zero-copy
Message-ID: <aDXi3VpAOPHQ576e@mini-arch>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>

On 05/23, Tariq Toukan wrote:
> This series from the team adds support for zerocopy rx TCP with devmem
> and io_uring for ConnectX7 NICs and above. For performance reasons and
> simplicity HW-GRO will also be turned on when header-data split mode is
> on.
> 
> Find more details below.
> 
> Regards,
> Tariq
> 
> Performance
> ===========
> 
> Test setup:
> 
> * CPU: Intel(R) Xeon(R) Platinum 8380 CPU @ 2.30GHz (single NUMA)
> * NIC: ConnectX7
> * Benchmarking tool: kperf [1]
> * Single TCP flow
> * Test duration: 60s
> 
> With application thread and interrupts pinned to the *same* core:
> 
> |------+-----------+----------|
> | MTU  | epoll     | io_uring |
> |------+-----------+----------|
> | 1500 | 61.6 Gbps | 114 Gbps |
> | 4096 | 69.3 Gbps | 151 Gbps |
> | 9000 | 67.8 Gbps | 187 Gbps |
> |------+-----------+----------|
> 
> The CPU usage for io_uring is 95%.
> 
> Reproduction steps for io_uring:
> 
> server --no-daemon -a 2001:db8::1 --no-memcmp --iou --iou_sendzc \
>         --iou_zcrx --iou_dev_name eth2 --iou_zcrx_queue_id 2
> 
> server --no-daemon -a 2001:db8::2 --no-memcmp --iou --iou_sendzc
> 
> client --src 2001:db8::2 --dst 2001:db8::1 \
>         --msg-zerocopy -t 60 --cpu-min=2 --cpu-max=2
> 
> Patch overview:
> ================
> 
> First, a netmem API for skb_can_coalesce is added to the core to be able
> to do skb fragment coalescing on netmems.
> 
> The next patches introduce some cleanups in the internal SHAMPO code and
> improvements to hw gro capability checks in FW.
> 
> A separate page_pool is introduced for headers. Ethtool stats are added
> as well.
> 
> Then the driver is converted to use the netmem API and to allow support
> for unreadable netmem page pool.
> 
> The queue management ops are implemented.
> 
> Finally, the tcp-data-split ring parameter is exposed.
> 
> Changelog
> =========
> 
> Changes from v1 [0]:
> - Added support for skb_can_coalesce_netmem().
> - Avoid netmem_to_page() casts in the driver.
> - Fixed code to abide 80 char limit with some exceptions to avoid
> code churn.

Since there is gonna be 2-3 weeks of closed net-next, can you
also add a patch for the tx side? It should be trivial (skip dma unmap
for niovs in tx completions plus netdev->netmem_tx=1).

And, btw, what about the issue that Cosmin raised in [0]? Is it addressed
in this series?

0: https://lore.kernel.org/netdev/9322c3c4826ed1072ddc9a2103cc641060665864.camel@nvidia.com/

