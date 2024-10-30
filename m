Return-Path: <bpf+bounces-43552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 569B19B6640
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 15:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E84EEB224C8
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 14:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB3E1EF94E;
	Wed, 30 Oct 2024 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q87V6h2S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2F8B672;
	Wed, 30 Oct 2024 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299423; cv=none; b=izdjgpDtfxmMPvcwxjZAJCsBEu5a7xIn1wUMx2u/fC4R+VE+At303Hu5el2dyoKw0R0NX5VZcS2S3UNG8jbhdSWzQ45Rn6zfWq5yA627mo/gsBl4d1yPhej2NmhZS5BwCpfHGL3b9/POpXrk21GHsxWwRaxVd17pw+dwz0y1rSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299423; c=relaxed/simple;
	bh=olNxa36OenCXZDSRtWxpBo3OPrtt1ORr8iiTeXjyn7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbGORyPYj0IcPGEcL66sfKRJUISwdR4ixyBWwQI0hrUj07GD7QBSOgznSw3U6g0gbi5grKi7xa8ua87HYV0F+wd8JR9dXNgx5BZeDx1kKQr0gWTUfcrfNBPciBquOlh3jlGKlWm6t2PnIfcJKsZ9XSvXNByFQjb1pRANJcQr7Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q87V6h2S; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e953f4e7cso4960004b3a.3;
        Wed, 30 Oct 2024 07:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730299421; x=1730904221; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EzEFtEvodZMIY3TcdOA4u9YfoRg5tUWYSWh1VKJyGMg=;
        b=Q87V6h2SSvkwx5+pW5PAB7jGwx9IzZR//BqFObwz/9qv29EQqP4sm0MzwccksROcuI
         w1CHB4RTKAoXKL0ZZoMxMLpDGDT/JtGFPm3BkDDSiU/uAg2vEAt6Ztu3WISAXxAKTgKr
         5NwHVWIr4ZgvQrz2ss3ijGqz3ntD4h+iIUbsMwJIEG70aFr6OesqHx2bElt1BHbfsmI6
         Ia4WUTsD+uD1AQkwCNfdn/AhzYKVyr0ldpefY+SQuqsvrThHpOyf1EP7nPw80BXFWOjs
         kzOWZ6dEdySBCuWTtkamU66nKgzYZTzOSahS+ad44EQ/AGpbSeWqyCEyszDlhzFSYVqv
         Z73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730299421; x=1730904221;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EzEFtEvodZMIY3TcdOA4u9YfoRg5tUWYSWh1VKJyGMg=;
        b=psOuCAUftzXO+E4wloWLnKaImJY/jxtf5RsOLY5K29zFj0LfR+8YUq95OIYQM2d24W
         /B1+neN93M4ovohYQpYwAoy3I//xvZiw51lj4VZg7qIG1v3QslbrJCdj8KEd6CdqmJhN
         GKatH2Vc3H35vN1BX6qOaFbV93A1Dh9LqQAYrsEV90CR9wXelJ5YHEDIEHQw86Qg7cZR
         gXImhCX49ZmlpQuJVJ1FMHuQG+dqXgNtyUCSCCWkMvzxEGW9HajsbBSw5MyW9bFZcAGF
         ETFV6HBBEv5MwP10vbhyEiMc7KGw9nnIpzOYJMFoiw8Ohv0mc3o+wGnYZ3gSH5Ju8EEz
         C27g==
X-Forwarded-Encrypted: i=1; AJvYcCVdzN7tCioYqCQTT5hUoOGQsqkIgbClAtOM2eB/Y1j+KNcdVjKij5DnbzGgMfyZezsiG6Y=@vger.kernel.org, AJvYcCXsyswX4BC/YLaSPax8/5W6KGJDa6a8fMLuxpt1IZBTgBPXnxwNy5GN/K4f74WXqpQPvTcKBT1s@vger.kernel.org
X-Gm-Message-State: AOJu0Yw18zbCibmqMbZ3JT9abRYx/EnRDZZVUOsGHzZWXbzYNbdF4faN
	WCFGLrdhUbyhcfFittuhYQRT/Uc1ye5KoXgK7UyCQz6X+4527E8=
X-Google-Smtp-Source: AGHT+IGDJiuBkdeXlxc32ojbr2QziFJCH7t9Zj8FLjEsOFhNKu3pi5/rIocq+tO1UUODrOzDPFSl6g==
X-Received: by 2002:a05:6a00:3e1f:b0:720:36c5:b548 with SMTP id d2e1a72fcca58-72062fb8112mr20516374b3a.16.1730299420815;
        Wed, 30 Oct 2024 07:43:40 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057921863sm9294250b3a.33.2024.10.30.07.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:43:40 -0700 (PDT)
Date: Wed, 30 Oct 2024 07:43:39 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	syzbot+d121e098da06af416d23@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf] bpf, test_run: Fix LIVE_FRAME frame update after a
 page has been recycled
Message-ID: <ZyJGG7aWRb0Lvk13@mini-arch>
References: <20241030-test-run-mem-fix-v1-1-41e88e8cae43@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241030-test-run-mem-fix-v1-1-41e88e8cae43@redhat.com>

On 10/30, Toke Høiland-Jørgensen wrote:
> The test_run code detects whether a page has been modified and
> re-initialises the xdp_frame structure if it has, using
> xdp_update_frame_from_buff(). However, xdp_update_frame_from_buff()
> doesn't touch frame->mem, so that wasn't correctly re-initialised, which
> led to the pages from page_pool not being returned correctly. Syzbot
> noticed this as a memory leak.
> 
> Fix this by also copying the frame->mem structure when re-initialising
> the frame, like we do on initialisation of a new page from page_pool.
> 
> Reported-by: syzbot+d121e098da06af416d23@syzkaller.appspotmail.com
> Tested-by: syzbot+d121e098da06af416d23@syzkaller.appspotmail.com
> Fixes: e5995bc7e2ba ("bpf, test_run: fix crashes due to XDP frame overwriting/corruption")
> Fixes: b530e9e1063e ("bpf: Add "live packet" mode for XDP in BPF_PROG_RUN")
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

