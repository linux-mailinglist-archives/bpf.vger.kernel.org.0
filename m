Return-Path: <bpf+bounces-54778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B85A7282C
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 02:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78621898DCD
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 01:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B60F50276;
	Thu, 27 Mar 2025 01:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dc2n6ttF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345BD224D6
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 01:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743039475; cv=none; b=PMjo6b4cvbCrdU18u7La7RyAHuuOPGwOp26DPzPHiCXVjSrCHPIoABWnAKcg8KkD3gEEFMb5McJYGUsez7j9ms3kiNlQsIqf3Rjvqi9TbHpg3On0OTDPNRqJgHZRp1SHZOI9Tv6SIw2yfylqUItTG746KVrvVPY8DPoZhROlcLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743039475; c=relaxed/simple;
	bh=cHwMT+3FgNwEQkr669gNNkCyBOJVEsIajaRLpg15NhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MrLL0yaSb5u9/hb4hMnrsk8keA+dlBD3gOVi52IKtugH/wIBIFvMpntLUaqGvEMSpWehJVdu6Dn174oNgUsDu1hDPnaUsas0lCFV43mMdbS2CbOJGxg605Au51ylsHCTCVRPtgLcsGZlTYjSRYA/RBmU1aydRbbxfc8QfTrrb7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dc2n6ttF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2264c9d0295so103375ad.0
        for <bpf@vger.kernel.org>; Wed, 26 Mar 2025 18:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743039473; x=1743644273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHwMT+3FgNwEQkr669gNNkCyBOJVEsIajaRLpg15NhE=;
        b=dc2n6ttFQ2hYyeVMz/J83IzhKhoHGRi35wzOTy4ioOuEZozolQQDkkNuca0bVfCIr5
         Wd/eJNeph4wn6uy2rpC0iXeQWBNK3nbYityr5LFL3GmEjSbZGYKIOhVJv6t17Q1+/DDt
         6amJE6nlMz6DVwGURMIUTg/ctFrFF+vC6iwwXCUmilZtN1Vr5UxTujj0QvmB/cjKqWPt
         BFECEh83TXuzldI/98p3LogtsCsfUVWQZ5jCdBcZ93mLQ7nGra118shWLDLjOtH5yGSy
         FIXvhU7nQEznk7+KLwyWOm+cIjQOw1quuG3H69XLYi1vVQXIPztEZhqIrMam22Qa7jyZ
         zVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743039473; x=1743644273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHwMT+3FgNwEQkr669gNNkCyBOJVEsIajaRLpg15NhE=;
        b=RokWNeUYswBuKY6PQdIj0tc5IL2QtKwEqiZ1t20wJYcVRBeV4YoZhzcCS9ee5yg+PL
         opkfATlAtQ9xeEirBL99C35z1zJZabUp1RUNTxA2uIiwZHG6ooDl2F1Mle5kfFnwauzj
         tjzGUrzOaubrt/6hn1dalEAKpqO651BKZZnfFRudX/K/8YUYryIuFBwXrmSWoyVIm7sX
         4shSKuCJJzZwA/FnGZiQ1C42tVcS1dtSr9jXOX5eULwPOs5wPDBBfJFT8jyqfd3v4K/I
         Mlr7G7zQg7dkRYepGzZAym9/qEpUCXJGJN2MYSffO6wfUgd3yg83tqjcUqQz1DQmWzrp
         AeOg==
X-Forwarded-Encrypted: i=1; AJvYcCXCIp2sAhxVyvceP9RrTj5Mro80KJUEg7mnDf8+vH1Amt/hPHJrWxnXhz+EfnFnnoqrSwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3e7HVFvZ8pW/4Bhu5mWrHegriKWKMzhE8X5ypkFxZ1FOOKXcv
	UqV7BxNXBDtIKoMEHIi5QHMC12nKyYinKWe3yqwjhNkxGj+KSqA7I0zZF32Sedeb6fxWvGy/YGG
	A598wYhk/kvlIwlPuf1azRxB+YHSnlTLPlbpa
X-Gm-Gg: ASbGncsCTRqPMiwbcdJ3oMzVSwkLV2CC5hoLcfF509vq8M74nDfP3W5wLMC1o+zLtZZ
	MDAi79XvYEI2xNZgGdL7mg3mldlNlQ4dAnbkACgOmH1OK3cQicEovI8q1+tRMbgWbJzMXmRuHHQ
	cGzgLaZTfdEjs7Ri81aEESk2HZQns=
X-Google-Smtp-Source: AGHT+IGyejTjcOqm9GhRjNM27uprdZ+w9l6Vw5AAoXb7lkUEV1bgap3tiBcG/R07VPwIsNrbRpfXRtioIUysEK92hYU=
X-Received: by 2002:a17:902:d4d1:b0:216:2839:145 with SMTP id
 d9443c01a7336-22808f6d3b0mr343815ad.1.1743039473091; Wed, 26 Mar 2025
 18:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325-page-pool-track-dma-v2-0-113ebc1946f3@redhat.com>
 <20250325-page-pool-track-dma-v2-3-113ebc1946f3@redhat.com>
 <Z-RF4_yotcfvX0Xz@x130> <CAHS8izMj2aBeu=TreUM-O3XNqqF75vb4rvMvf7pr8mGh+N_+kw@mail.gmail.com>
 <Z-Sb0Q-inlkdTopW@x130>
In-Reply-To: <Z-Sb0Q-inlkdTopW@x130>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 26 Mar 2025 18:37:38 -0700
X-Gm-Features: AQ5f1JqcogOvbg_4h2M8tFNkIPcgLEda3D9T4-VFCwVABZiq4bBI80W1nsox_KU
Message-ID: <CAHS8izNe1pttBsZWneDcWjtPEug5fgTGQpASLdv3BeRf37Y_hA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
To: Saeed Mahameed <saeedm@nvidia.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yonglong Liu <liuyonglong@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org, linux-mm@kvack.org, 
	Qiuling Ren <qren@redhat.com>, Yuying Ma <yuma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 5:29=E2=80=AFPM Saeed Mahameed <saeedm@nvidia.com> =
wrote:
>
> On 26 Mar 13:02, Mina Almasry wrote:
> >On Wed, Mar 26, 2025 at 11:22=E2=80=AFAM Saeed Mahameed <saeedm@nvidia.c=
om> wrote:
> >>
> >> On 25 Mar 16:45, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> >When enabling DMA mapping in page_pool, pages are kept DMA mapped unt=
il
> >> >they are released from the pool, to avoid the overhead of re-mapping =
the
> >> >pages every time they are used. This causes resource leaks and/or
> >> >crashes when there are pages still outstanding while the device is to=
rn
> >> >down, because page_pool will attempt an unmap through a non-existent =
DMA
> >> >device on the subsequent page return.
> >> >
> >>
> >> Why dynamically track when it is guaranteed the page_pool consumer (dr=
iver)
> >> will return all outstanding pages before disabling the DMA device.
> >> When a page pool is destroyed by the driver, just mark it as "DMA-inac=
tive",
> >> and on page_pool_return_page() if DMA-inactive don't recycle those pag=
es
> >> and immediately DMA unmap and release them.
> >
> >That doesn't work, AFAIU. DMA unmaping after page_pool_destroy has
> >been called in what's causing the very bug this series is trying to
> >fix. What happens is:
> >
> >1. Driver calls page_pool_destroy,
>
> Here the driver should already have returned all inflight pages to the
> pool, the problem is that those returned pages are recycled back, instead
> of being dma unmapped, all we need to do is to mark page_pool as "don't
> recycle" after the driver destroyed it.
>
> >2. Driver removes the net_device (and I guess the associated iommu
> >structs go away with it).
>
> if the driver had not yet released those pages at this point then there i=
s a
> more series leak than just dma leak. If the pool has those pages, which i=
s
> probably the case, then they were already release by the driver, the prob=
lem
> is that they were recycled back.
>
> >3. Page-pool tries to unmap after page_pool_destroy is called, trying
> >to fetch iommu resources that have been freed due to the netdevice
> >gone away =3D bad stuff.
> >
> >(but maybe I misunderstood your suggestion)
>
> Yes, see above, but I just double checked the code and I though that the
> page_pool_destroy would wait for all inflight pages to be release before =
it
> returns back to the caller, but apparently I was mistaken, if the pages a=
re
> still being held by stack/user-space then they will still be considered
> "inflight" although the driver is done with them :/.
>

Right, I think we're on the same page now. page_pool_destroy doesn't
(currently) wait for all the inflight pages to be returned before it
returns to the driver calling it, even if the driver is fully done
with all the pages. There could be pages still held by the
userspace/net stack.

> So yes tracking "ALL" pages is one way to solve it, but I still think tha=
t
> the correct way to deal with this is to hold the driver/netdev while ther=
e
> are inflight pages, but no strong opinion if we expect pages to remain in
> userspace for "too" long, then I admit, tracking is the only way.
>

AFAICT, the amount of time the userspace can hold onto an inflight
page is actually indefinite. The pathological edge case is the
userspace opens a receive socket, never closes it, and never
recvmsg()'s it. In that case skbs will wait in the socket's receive
queue forever.

FWIW Jakub did suggest a fix where the page_pool will stall the
netdevice removal while there are inflight pages. I never provided
Reviewed-by because I was nervous about GVE failing to soft reset or
unload or something because some userspace is holding onto a page_pool
page, but maybe you like it better:

https://lore.kernel.org/netdev/20240809205717.0c966bad@kernel.org/T/#mbca7f=
9391ba44840444e747c9038ef6617142048

My personal feeling is that adding overhead to the slow page_alloc +
dma mapping path is preferable to blocking netdev unregister.

--=20
Thanks,
Mina

