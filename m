Return-Path: <bpf+bounces-55732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 003ACA85E19
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 15:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E863BA57D
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 12:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388212367D4;
	Fri, 11 Apr 2025 12:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CncDUBw/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F752367C7
	for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744376351; cv=none; b=gwb0+9hAEbf36fswBQGcuAMJdVM4N//zE2zFcmXhX+NXn+rWu/LMAoDH5LX7uy41F531XOGLsZpxnx7q0dlxrb+bTj4URO7mGZdCyjfCsARkl1A00lIdsGdSRnil/140l25MdZCUm8Trc0pLgmvgq+Syj01xf4X4szAKpb6hY9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744376351; c=relaxed/simple;
	bh=rY1UFxG66AZgsLjOZDqEKWwTBbAxmKs5ER3eJZuwnGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DC/pHH1a+vT8663FtWLh/Dj4rBG4B4jUpR01jbi7nJNEftp6QV80Yge5GdvGi+laID740D9CrbNmchTutJSC6CA8j94//yRYbkRfRB9fJi8Fv1VMKbBIIRKIU8Qf+ZbvF/4/W8zKSWH4mC5IedwpBgwqs9dWz4Ou3abBvAYGuis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CncDUBw/; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so337343766b.0
        for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 05:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1744376348; x=1744981148; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YSGIw4q8pstTZ6OBCwLFEQhJ8StUrT9v8m/BBXZBL8A=;
        b=CncDUBw/A4Kg04P7zM39ZFW7gZyxvSPni3Wfl/W9tfJkc4igXvyX+mJnbAR0NfLl4C
         DLdG2/XXKSRBLj7GQzSJBmnh1xwWcPvxfsqRUqsGb4ALr2AGUWg6r80JQMOFPNtJx8Wt
         2DErJAvjyP8BID0t/qKxVpjXVCt8z34FH1SN8s8IwHsUTPZ60Z+fHd6DrvoXjP0UI7qy
         RvKWR95JImXsWkPdf2bs+yHu8+fKgHjnF78g46ZSZcjR0ABT5uAfGoLb9tJxGolnGw88
         fT5z9wzH/XEM+ie9E2xSKZHiDddXMetEhfT3rF3vcT2XFXZWk0JoiPt2gcXmZHbKpF1E
         Z4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744376348; x=1744981148;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSGIw4q8pstTZ6OBCwLFEQhJ8StUrT9v8m/BBXZBL8A=;
        b=JWc0EPHKigB7E+FLrWzwfhMQufMmUUPSEU/Q8nKGec5cb0+REQQVDP0X4OusVyfKXM
         yKBTsAJ447eeuiiXzZQuKM4SlHhMKx4FPjjcKac3l1SOMlUimuwAetB1AjmEBrUDFHaH
         MprQmc6eewz49Mub2gntC4jt7lrR5WMsdqCak02Ll3QCS2LSyDXDzbZGhSxO2k6sw1mD
         TYR4KRJDih6qiFWN5kVEZgLEKrNiat29WDjyAfmUNCmAj6i0iDyY4b0dpQoH1jN7bE8g
         O3ZV+2aIfYxS21kEq0INjggkZTwVqGXSmE6SRB5EmvJaVe9hB8NTvAPkRkcH9PXURA2A
         YZBg==
X-Forwarded-Encrypted: i=1; AJvYcCV/Q55PPgsLWs5MEQhR3qkfxrgISSG8zMJF3i1EeR/RF95360XgC5OKKUSH3V+h9lLD68s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGv0zXlUUBURN0fnm3ByF03OPfxdbHsFp5SaWoTO3rC3JQpz/F
	EdJOE0ly5M9qMrQSXpUVwwob6X3zwMxiD9vjhQVGV1nbo3a5qydHjSJC2kAvG9c=
X-Gm-Gg: ASbGncuDJsH1eQzFoJ+CCs4g5gk8Q5jZoOO/coNcfCXuGPgbCGpkLh3ChsLLW+lDas5
	LEa7fcWZ+z9PAJ1qMBg8o9Di2Ygq77Vjx3zHxFjR9sotWfFNPPZftWSoSGcRWjd5WnmH0TUr1BU
	+LKEZyO3roIvaBQ3M0spZEnbjIO5cUtAawZcJ/mmI9j3qaVViSXKZO7CMQmjoW16dI4GW9h2Hw+
	JCueGfGEKX2WJT+iJLGYjB45FsGBomGqDg3kczQO6WFzf1FsHZXDUk94RaQ9dLpQwjKAbcH5F15
	14JfsTMBMTp37pN6aNNPfsunm3yVdJmv
X-Google-Smtp-Source: AGHT+IFUOH4el20wLJrnf4kez8QMAu2dwjSG3e+nwIJ6hcuc3ODkPFTqhx4cYs897gW+Rvgo+MBUiw==
X-Received: by 2002:a17:907:3cd4:b0:aca:d1db:9c63 with SMTP id a640c23a62f3a-acad3445ef8mr221448266b.5.1744376348155;
        Fri, 11 Apr 2025 05:59:08 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:506a:2387::38a:3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ccad01sm438171566b.125.2025.04.11.05.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 05:59:07 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,
  bpf@vger.kernel.org,  tom@herbertland.com,  Eric Dumazet
 <eric.dumazet@gmail.com>,  "David S. Miller" <davem@davemloft.net>,  Paolo
 Abeni <pabeni@redhat.com>,  Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>,
  dsahern@kernel.org,  makita.toshiaki@lab.ntt.co.jp,
  kernel-team@cloudflare.com
Subject: Re: [PATCH net-next V2 0/2] veth: qdisc backpressure and qdisc
 check refactor
In-Reply-To: <174412623473.3702169.4235683143719614624.stgit@firesoul> (Jesper
	Dangaard Brouer's message of "Tue, 08 Apr 2025 17:31:13 +0200")
References: <174412623473.3702169.4235683143719614624.stgit@firesoul>
Date: Fri, 11 Apr 2025 14:59:06 +0200
Message-ID: <87ecxyhn1h.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Apr 08, 2025 at 05:31 PM +02, Jesper Dangaard Brouer wrote:
> This series addresses TX drops observed in production when using veth
> devices with threaded NAPI, and refactors a common qdisc check into a
> shared helper.
>
> In threaded NAPI mode, packet drops can occur when the ptr_ring backing
> the veth peer fills up. This is typically due to a combination of
> scheduling delays and the consumer (NAPI thread) being slower than the
> producer. When the ring overflows, packets are dropped in veth_xmit().
>
> Patch 1 introduces a backpressure mechanism: when the ring is full, the
> driver returns NETDEV_TX_BUSY, signaling the qdisc layer to requeue the
> packet. This allows Active Queue Management (AQM) - such as fq or sfq -
> to spread traffic more fairly across flows and reduce damage from
> elephant flows.
>
> To minimize invasiveness, this backpressure behavior is only enabled when
> a qdisc is attached. If no qdisc is present, the driver retains its
> original behavior (dropping packets on a full ring), avoiding behavior
> changes for configurations without a qdisc.
>
> Detecting the presence of a "real" qdisc relies on a check that is
> already duplicated across multiple drivers (e.g., veth, vrf). Patch-2
> consolidates this logic into a new helper, qdisc_txq_is_noop(), to avoid
> duplication and clarify intent.
>
> ---
>
> Jesper Dangaard Brouer (2):
>       veth: apply qdisc backpressure on full ptr_ring to reduce TX drops
>       net: sched: generalize check for no-op qdisc
>
>
>  drivers/net/veth.c        | 49 ++++++++++++++++++++++++++++++++-------
>  drivers/net/vrf.c         |  3 +--
>  include/net/sch_generic.h |  7 +++++-
>  3 files changed, 48 insertions(+), 11 deletions(-)

This setup scenario is currently not covered by the veth selftest [1].
Would be great to extend it so the code gets exercised by the CI.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/tools/testing/selftests/net/veth.sh

