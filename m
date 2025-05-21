Return-Path: <bpf+bounces-58644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C512ABEEB0
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 10:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B73177FAD
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 08:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE8721FF55;
	Wed, 21 May 2025 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpxq9At0"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DE823816E
	for <bpf@vger.kernel.org>; Wed, 21 May 2025 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747817823; cv=none; b=LGoY92T40XogsECKcbIorrgnwp+q2vltfU5lZowOEvRcrYPraw1Kg1DV7HkzMNdn8jpJ9A3Xu5xrWJRVC0ZBhbB6m2zyJpqHoVLdkdWdSo8p/At9TbNRgT1EJTntkwnOsC1LQocSUJMZBUfrKS2iZky+leWpjm1QdtgPA3H4YsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747817823; c=relaxed/simple;
	bh=XSVAWIQJLeLQ+EnAe2fX432Jiet3EaT40S7A2jVLi7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phc7RI9aq8YCl2tkoSD5tQI+MnGL0jhpKZehLjjUpEqiMc2Zm135HaRptxFCNsknKuR+jkxUwA7IvQ0ybRBqJ7BojBeo4Q9LyvGoYNykG5z/dEiPhd6BT42btzhgt/gM8P27L0qxvUuGUaqxqBLEc3gh+szTfG+uZ4its0aWtKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dpxq9At0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747817821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z5ISw/s/gG2J/o4w18hQ658TJ8AN+hELaWEkOZaX4Ho=;
	b=dpxq9At0kAiHjU3uajDx87HcHcLKdn+03nQyeml0gM8sXD6kAFSn2B0fUDoss4DQ2iDSi6
	v94T2T5vQVdaeHo0xFL9R5E3p/rvmTjqA/li2DfwFIqXYmElipd2W749S/SSgCjGXSsxVH
	sMmgdCutAecDvXve5wtD0taEgUVEmHk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-XY3U3MUVNH-7Xp0hroi6NQ-1; Wed, 21 May 2025 04:57:00 -0400
X-MC-Unique: XY3U3MUVNH-7Xp0hroi6NQ-1
X-Mimecast-MFC-AGG-ID: XY3U3MUVNH-7Xp0hroi6NQ_1747817818
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6f8e7b78eebso35157236d6.2
        for <bpf@vger.kernel.org>; Wed, 21 May 2025 01:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747817818; x=1748422618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5ISw/s/gG2J/o4w18hQ658TJ8AN+hELaWEkOZaX4Ho=;
        b=Njj3h2cVpJ/sexayGc/iyd4rENQaL12dmgGXlSsNWOostpKYn7/L0QOWICtHXIUWof
         UXFXx6XrEbbyc3yL+EUnqNcmUjZsQru9dPa4DGtQFdEzy+WMZCxwNUmsedCzjkBYzU4n
         Lh/K5ihA3YgSVKEKOxwKRRGbAtX0//YnCesGvdqH05QCklFNf/z6RoFwXVkGzK9b75jr
         XLQR6+yZmTVX20UUGt8n8vfMstRNEZBxN5wkX/5n4+GCeClaMzRKJcBMARwGE9OyRWT3
         /uYzSr2QyhzTSMAnVeUQxxP5jepYsWQnqvRul4y98D50PZrYQWIR2cd17vRVzbi2lvbP
         Veng==
X-Forwarded-Encrypted: i=1; AJvYcCWSspNAkKINqkRqol19ib8ED4k6NOtib4hLaj4yiag9FRhNPg3DVFJ/SXuk9OrCkzKSh5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD37odXnX8be/fZtbVD0nE2hrZQmSDkVjkEQYixlqXFxXcNJ2p
	KtXXhnoGOHSZEJXaa/53eWHvkN+WG2nddWCZIJ4x6mfvmeXeDCBS1+kO+hY0ONlduhz5V+6n+5h
	8U9rzOnfs7OV1b0VTrViusUk6q6dkYw9hXvI0QL3Wvye03SYabCwZaVfMWiKzZ8rVqfpJv7/fLC
	mrjfLWymSc/80+OVRSquZe4Ng5fiQk
X-Gm-Gg: ASbGncshBCi4h5zCGAz7nZFeb9Lrfbkdp0CaB9CuDqgC14uxf6rlGZDOTlElv1DU1Xz
	/Aegb5EEl0ZPeTOTll8D8Lx6YLpbQwvl3l/jX40sqeCuYt8jfXg/e81LTt9UI/s/ZCKo=
X-Received: by 2002:a05:6214:2681:b0:6f8:8df1:648 with SMTP id 6a1803df08f44-6f8b2c37a19mr343338826d6.7.1747817818412;
        Wed, 21 May 2025 01:56:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaO4WTOV6fJAlmH9DP3inkXOYir+cNPdLYhrMs4mbVZjO2ZBdSoayKvQmU0Z4z5PR9AxBgDQglVFmrFM7Wvjg=
X-Received: by 2002:a05:6214:2681:b0:6f8:8df1:648 with SMTP id
 6a1803df08f44-6f8b2c37a19mr343338606d6.7.1747817818106; Wed, 21 May 2025
 01:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1747253032-663457-1-git-send-email-tariqt@nvidia.com>
 <CAADnVQLSMvk3uuzTCjqQKXs6hbZH9-_XeYo2Uvu2uHAiYrnkog@mail.gmail.com>
 <dcb3053f-6588-4c87-be42-a172dacb1828@gmail.com> <09377c1a-dac5-487d-9fc1-d973b20b04dd@kernel.org>
In-Reply-To: <09377c1a-dac5-487d-9fc1-d973b20b04dd@kernel.org>
From: Samuel Dobron <sdobron@redhat.com>
Date: Wed, 21 May 2025 10:56:47 +0200
X-Gm-Features: AX0GCFu5dfswcCWTTkSyc0z9SXYg_lElASwlqEtz7krxELOPksJgTCJdKDQl7-M
Message-ID: <CA+h3auNLbmQFXrN1A5Ashek4UiMGa_j+EHaFFp-d74kGZvyjsA@mail.gmail.com>
Subject: Re: [PATCH net-next] net/mlx5e: Reuse per-RQ XDP buffer to avoid
 stack zeroing overhead
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Network Development <netdev@vger.kernel.org>, 
	linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Gal Pressman <gal@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, 
	Sebastiano Miano <mianosebastiano@gmail.com>, Benjamin Poirier <bpoirier@redhat.com>, 
	Toke Hoiland Jorgensen <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hey,
I ran tests just on stack zeroing kernel.

> The XDP_TX number are actually lower than I expected.
> Hmm... I wonder if we regressed here(?)

The absolute numbers look more or less the same,
so I would say no. The first results we have for TX is from
6.13.0-0.rc1.20241202gite70140ba0d2b.14.eln144
comparing it to 6.15.0-0.rc5.250509g9c69f8884904.47.eln148
there is actually 1% improvement. But that might be a
random fluctuation (numbers are based on 1 iteration).
We don't have data for earlier kernels...

However, for TX I get better results:

XDP_TX: DPA, swap macs:
- baseline: 9.75 Mpps
- patched 10.78 Mpps (+10%)

Maybe just different test configuration? We use xdp-bench
in dpa mode+swapping macs.

XDP_DROP:
> >>> Stack zeroing enabled:
> >>> - XDP_DROP:
> >>>      * baseline:                     24.32 Mpps
> >>>      * baseline + per-RQ allocation: 32.27 Mpps (+32.7%)

Same results on my side:
- baseline 16.6 Mpps
- patched  24.6 Mpps (+32.5%)

Seems to be fixed :)

Sam.


