Return-Path: <bpf+bounces-17332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A4F80B8A7
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 04:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8AFD1C20990
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 03:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FF51FDE;
	Sun, 10 Dec 2023 03:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MVA3ncTv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D0A11C
	for <bpf@vger.kernel.org>; Sat,  9 Dec 2023 19:49:30 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5c627dd2accso1449693a12.0
        for <bpf@vger.kernel.org>; Sat, 09 Dec 2023 19:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702180170; x=1702784970; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MW0tH0tCLOPnmE9TK7jB709vE7J7udoTWRcjSJbRbzw=;
        b=MVA3ncTv2ztH8VVDR196PceGHb1j2OlSZrlL9Lw2Z9wX6UV2E/Z7XDjt5ZD7SDGkQY
         tlWHdq4lxTiyvBUAkbTmLAnlnhSqqlhFoLb51b5SdgrG3NTW42ditNtt2dquiK22e2xx
         Nw689Lh4It2U5heO9IEQmZwv3c3mM3nARmOuJMgEG3Fs+Rwa45tEbyggTQPX1s+IcwtO
         u3Wiqqvto7KipLkZsC4PQE1A8RgR5sT+O1xaA8N2w+wHjPG1xRdP1x6zOnuCs9mKTdFv
         04hbe0IOyZyj/hqPtSfyu4DtiDdktMxlvPL5bH+Fgu9pBBtlLtruM13bGr+El8lT1Frm
         WP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702180170; x=1702784970;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MW0tH0tCLOPnmE9TK7jB709vE7J7udoTWRcjSJbRbzw=;
        b=CBPf0ys22+r5GkkR4/447T1aDBnz+cfIiL6lhPqbpqAUZDJDLbc7BgB05QGZty7NMA
         q0pzPCyQNVY3MchuJf6PzDBS9eo4MsC90Hr5b72y9YJYyG3W+pm7zdMDH2qYnyYj+Nj/
         j81poh2P4lmrTQW3BMDEB/7xetj10HTBL8gRD8lZQbMhLbyqWSSWTdWxw5B3TAtexaKV
         ueQlF6KUXFnceMRfG3o8x1J7DoN0p1oeqne1Oytm6A31DD1/Ej6Pww0Fib/GzBZXW4GT
         C6kiiKIz5d1kRKgglxXnnx6VpQZLYlewYxr0g27pSiVk4OGg7k/7XQ0j6cYOjpQfeZWU
         43tQ==
X-Gm-Message-State: AOJu0Yx/uVLgSiacRjLUYc4ZSITYzHBvy2bW2jIpsV9f05SLHqGTnms3
	xpgVAMj6Y1PvQPljA7/yUUYwDWB+78ymZg==
X-Google-Smtp-Source: AGHT+IHLBajZsz0VxcL0CaCLjiP+JcpZ3Z6iSNDh4oLOCNKWTm9OPBX9RXcqYsgny9cLWKIkHF4CYYDwWcNIvw==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a63:7317:0:b0:5b8:fe99:152d with SMTP id
 o23-20020a637317000000b005b8fe99152dmr15385pgc.7.1702180170422; Sat, 09 Dec
 2023 19:49:30 -0800 (PST)
Date: Sun, 10 Dec 2023 03:49:28 +0000
In-Reply-To: <20231208005250.2910004-2-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com> <20231208005250.2910004-2-almasrymina@google.com>
Message-ID: <20231210034928.mk4ufxqis2w3wesg@google.com>
Subject: Re: [net-next v1 01/16] net: page_pool: factor out releasing DMA from
 releasing the page
From: Shakeel Butt <shakeelb@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Dec 07, 2023 at 04:52:32PM -0800, Mina Almasry wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> Releasing the DMA mapping will be useful for other types
> of pages, so factor it out. Make sure compiler inlines it,
> to avoid any regressions.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 

Reviewed-by: Shakeel Butt <shakeelb@google.com>

