Return-Path: <bpf+bounces-54780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C86BA7298E
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 06:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E4963B46B2
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 04:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10401BCA0E;
	Thu, 27 Mar 2025 04:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NxuVphwP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA788AD21
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 04:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743051584; cv=none; b=c7CIArDWEf/IEZO/bu4nOe2dn9nUsJIWr7vo1bWzzMUridGxa0YbKYva5aXkKFmafhqkwu5qoyeBZ2jxOs0IwLaBuAJu1BWevk0chwGkXs+4S0LoCE5f4UL1QGtN4BqFugthfE8CzHvABQDqyBD8QluHPwUHEpTE/kUbngzdJzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743051584; c=relaxed/simple;
	bh=0xgWQBUgBmTnndS66WlYcMLJwKm8NVOlZEeL7gYQRGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ku2L8g+QkmykNREpp/rWhmqYbLpbuMJTVBuIn214AMwebraGg+Mi1FA/PVAGEe6LfE5Ipj6wdKV5TJpN1EI4DCIT8LW8SzNS6sAoUUAVwEDkIA70KXvyXlPuy01UVTUxnz7JgV4bJ5P7GsHjLHHBPhskKMpOiUC1QVnlW1aiQtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NxuVphwP; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2264c9d0295so126735ad.0
        for <bpf@vger.kernel.org>; Wed, 26 Mar 2025 21:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743051581; x=1743656381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xgWQBUgBmTnndS66WlYcMLJwKm8NVOlZEeL7gYQRGE=;
        b=NxuVphwPy4BcjZGrSTm5q6YGn0TdbD4LoUmCyvKQ7Sa8bc0x0fjyKMzoW0cafFOYha
         QrmxfzbzYkzNw8uEinYt/j8j86DAMLVgm5aG8OghiMDe21dTo3964ix5/4z5EX17xPGC
         7sK6wM1y6yzkJutaHKLNSd2lzI84p/4VVQNEiK9Gv5dM5uLEvKdQH4UKiJmprtGFHrMM
         xuRHw3RkQb5zdw1T2Nwb1YH48WF7K4N7ek7gHHdpU3CFMpgnKFnqRNIf2b3CzoIS+emc
         uWMy5HUxkiaEmEJ2JxZhkTCEtyNh7R4U2tFD3ph3M9C+k8zO8fpDt8zlM08jRxfWs0Tz
         jTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743051581; x=1743656381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xgWQBUgBmTnndS66WlYcMLJwKm8NVOlZEeL7gYQRGE=;
        b=JSBa3IshGc19Cct0KgU+eGHc2e2Ak5uakeGtgPu+lOODao02LzTbA8zTw61HZPQCIX
         N6sFEK7eoJq/+5APy/wuNYao3FA/X+J++t9SYoBjzRRADZbMjWIvQf9ycSo24GO8XqR+
         JF0GjosIu3z9DUkWbsE8NIccLMEUlsKxSzKteuX4/nOMg+cgnI8SfgEsNUz9dyb3t1p8
         Etjo5/JJ+vGsy8Rj57ear0vgxTCfe1X7woxH7fOh9wx2TpdvzCcN4ino6T4KXgEwaJNb
         7+NYhkvJsjWZB9JCQrpQE9qcQucGRfUOjOGLDqQAko6vud/UeETBCsIjWWd0KIyqrFGD
         Q+2A==
X-Forwarded-Encrypted: i=1; AJvYcCULYCe63J5OJstGSilMn8uDlkKuY+gkpjLW89LWpqesrdXfNHQVSdmKBSxqM+PfGcyeWO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0n7YRiX+YBwh+1mdcIrPCXrJ/oUp/eITjhn7YUHN+ZeJW+JsD
	ufDooj5g4jclRYKU8eUNWVg7XGw/GqhCFaswbqmiqVf/HqlcwbKNXcMVyts7t7TtJT3i84rMKJu
	n0gdTNPbF5kpBdzQy78YDgKpgktkYoyFSBF2b
X-Gm-Gg: ASbGncuBxUxSUT9E7bAVVOaUmnZYNl6z0SqL+VMC2VcDZkEM9Ocs0M4LjrdpxGWFuJK
	5osQgS/lG/euvQHbpidkRwtN7NFRB6aGpm2+X6dfGPKMVQb2EwxxxKQv+JZBzYpLM9LMGOHjuyc
	xvxgESSsFeQSi1hSkFIRp17182MyA=
X-Google-Smtp-Source: AGHT+IF0s/GL6MGZcOQirhOil9Z2LYOTGQkcFqDLrlKFFE7owCzr/ZTwokplwNC7ei/E8n2Q7ElvPfvNpzACxJtepBE=
X-Received: by 2002:a17:902:d68b:b0:215:f0c6:4dbf with SMTP id
 d9443c01a7336-22806bdf5demr1524155ad.14.1743051580749; Wed, 26 Mar 2025
 21:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325-page-pool-track-dma-v2-0-113ebc1946f3@redhat.com>
 <20250325-page-pool-track-dma-v2-3-113ebc1946f3@redhat.com>
 <Z-RF4_yotcfvX0Xz@x130> <f1a33452-31a4-4651-8d4a-3650fd27174b@huawei.com>
In-Reply-To: <f1a33452-31a4-4651-8d4a-3650fd27174b@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 26 Mar 2025 21:59:27 -0700
X-Gm-Features: AQ5f1Jo9fgAhoERMV5502HOGec-jhjpS6HzgrC5Fcd3htnByWUcvPEsIqXM0Lu4
Message-ID: <CAHS8izPA+hmOkP=jZd3mm1Zux2uaqpOf0poEci-Jn1g7msfkbA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yonglong Liu <liuyonglong@huawei.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, 
	Yuying Ma <yuma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 8:54=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
> >>
> >> Since all the tracking added in this patch is performed on DMA
> >> map/unmap, no additional code is needed in the fast path, meaning the
> >> performance overhead of this tracking is negligible there. A
> >> micro-benchmark shows that the total overhead of the tracking itself i=
s
> >> about 400 ns (39 cycles(tsc) 395.218 ns; sum for both map and unmap[2]=
).
> >> Since this cost is only paid on DMA map and unmap, it seems like an
> >> acceptable cost to fix the late unmap issue. Further optimisation can
> >> narrow the cases where this cost is paid (for instance by eliding the
> >> tracking when DMA map/unmap is a no-op).
> >>
> > What I am missing here, what is the added cost of those extra operation=
s on
> > the slow path compared to before this patch? Total overhead being
> > acceptable doesn't justify the change, we need diff before and after.
>
> Toke used my data in [2] below:
> The above 400ns is the added cost of those extra operations on the slow p=
ath,
> before this patch the slow path only cost about 170ns, so there is more t=
han
> 200% performance degradation for the page tracking in this patch, which I
> failed to see why it is acceptable:(
>

You may be correct about the absolute value of the overhead added
(400ns), I'm not sure it's a 200% regression though.

what time_bench_page_pool03_slow actually does each iteration:
- Allocates a page *from the fast path*
- Frees a page to through the slow path (recycling disabled).

Notably it doesn't do anything in the slow path that I imagine is
actually expensive: alloc_page, dma_map_page, & dma_unmap_page.

We do not have an existing benchmark case that actually tests the full
cost of the slow path (i.e full cost of page_pool_alloc from slow path
with dma-mapping and page_pool_put_page to the slow path with
dma-unmapping). That test case would have given us the full picture in
terms of % regression.

This is partly why I want to upstream the benchmark. Such cases can be
added after it is upstreamed.

--
Thanks,
Mina

