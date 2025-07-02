Return-Path: <bpf+bounces-62108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97361AF156C
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 14:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35EC4A8204
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 12:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB84526E17A;
	Wed,  2 Jul 2025 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="P4epZKvA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D52726F46C
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 12:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751458640; cv=none; b=TE6sPzJH6oyLTIAwqLBBT5UDZoN/z1YhwsCAWspLXMxOnAEejjcFIod369yJPqcT9pOShrXivgqkMe5ltb7dN9Wn+cJ+4dHHBGbdvaB1lExwimost3+SVZRgsCzgiak2Fkl+hXTKZuI2fgZlFOrbVN6w4uThJ8mr374Ypk9GW9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751458640; c=relaxed/simple;
	bh=uzbmKudiCVqbCWHjsvWpIONLcOqXoBM4sksfA7jU3N4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OCl/Dx+3TdpAqPmrd7cqmT2MshHBvCA7MKi81y214CRQKdPnLA/dKrYtO46lrPmptXHK6HRckU3aQ0f3SAEuETG1twNeuIyRacHGCV/dqDn61wngPh+9auTU20xivcV8CABS4JzAoOHOOODB2pdFSlmpYGFsTQ9dsq3jkGzqiQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=P4epZKvA; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60c4f796446so11407487a12.1
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 05:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751458636; x=1752063436; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uzbmKudiCVqbCWHjsvWpIONLcOqXoBM4sksfA7jU3N4=;
        b=P4epZKvA0luTXkjDRr1G4JmggNRPZfOa+42wwyhAgrTIxm2CBjn+vQPOxjT2uFTn7e
         1HoSwvatZQaWHvH2NrAg9GbeX1fjPqQdTTqrAYDDJlx/p3hAjT3VBsRBxb0rST0yet5t
         /XOBZGoGtwgOT3Ox6ikhNvVzHGh4y6n7Z77Bu5AO1JgHX5yqWji4qOi6DXv8YQJHZDPm
         4M/OgvAIzaXX2LwMydQSu9qeZbDWiXg9vaH8yLh4ty1fy/opeTm/+lIyghNi4qU/w+LZ
         lBhjFQRwVtKhFZa9jqIUEGf9dLMPzBgUGU9Erffhculxj/I04RROb61NSd7I6hNRHsge
         +kkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751458636; x=1752063436;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzbmKudiCVqbCWHjsvWpIONLcOqXoBM4sksfA7jU3N4=;
        b=fWn0/opTdUP4IsxjmjOuIi6b5C8NdLLP9eS2NU/1dFobFKFTTfFMlihxwh6sxGpIfL
         fhDAEWrZ21+1jbM+D46KHJryb5hudASz3iR8oIs2mqrJ1zJzjh60FSqlWQfdygqe+qJ0
         ABnatPf/5Ri2ANLWEwE1G8IkEt0rgRY9SoonooIAMBGMLSQzzxSzVi0ZnieT2J8V1qMT
         89Kwkj981d9upYNs2egK9U9yZl20wG0QcvyxzfJ9AWjgxpXazD9WoQG00UWG89bi7BC6
         WCbVnzadn7XyUumVY+4VJm+Bxcb541LW2nNMYdNaXkhbN1LQq3oZ+ktE8guWkDNXos+W
         9G5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeji5UpeRSSxXM3mmhwLG3HM80U8sjmlekonUw0Nl9Av9tDXKAjHbgQCkWa6ByKc2M2Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW3ymv3G7yTAKpqFP5aIbayP385T/3vw5ENADo6BfdrA6Pecfg
	gnscIDXRUM2Rz/puC/wkpJ7r5kbWWQMTz3sXdUymgV0Ux33LLL6NhGKxcQ8H0VNcN5E=
X-Gm-Gg: ASbGncuD736/UVw/MLdN2ln+hFbZ9WjiVyLIuwjUeyoD5bUExObaie/lncVlLa7wNu+
	hbgdR2W8OdNyzxZaB50+brfxt1Ei/pc+JY+v1ZGmrMtNw/5m/dH30Sv2/AEVBYyP0YiuVC8IgzF
	rfSPFboV4G+xT+bOsdBG62ivndlM62W4eI8N22rEfi+NTgosrUzvMu0HTvEO5IXW677zAcPc2vo
	kEvoqChyVtRmrSHwjlkuCbS3JToCebg+zf4RKpHVDzVrW/RzFpbjUtC5hmm2ULCh9cJ7a5eX6Uq
	0b4/kXGTV99Sve+/BFjLcwrHRfzjR8oq1YWFqT22SBC0LW1iOriAy0c=
X-Google-Smtp-Source: AGHT+IE1QJ3AjK7fa64xTgB3aheM3DjGwzgHhV3/DYIftQwwZX3WczE3Ty9UlDMRgc+foEdD2NDunw==
X-Received: by 2002:a17:907:7fa8:b0:ae3:5e27:8e66 with SMTP id a640c23a62f3a-ae3c2bdcc36mr284553666b.27.1751458635631;
        Wed, 02 Jul 2025 05:17:15 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:e7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35365a090sm1075241466b.56.2025.07.02.05.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 05:17:14 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Cong Wang <xiyou.wangcong@gmail.com>, zijianzhang@bytedance.com
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  john.fastabend@gmail.com,
  zhoufeng.zf@bytedance.com,  Amery Hung <amery.hung@bytedance.com>,  Cong
 Wang <cong.wang@bytedance.com>
Subject: Re: [Patch bpf-next v4 4/4] tcp_bpf: improve ingress redirection
 performance with message corking
In-Reply-To: <20250701011201.235392-5-xiyou.wangcong@gmail.com> (Cong Wang's
	message of "Mon, 30 Jun 2025 18:12:01 -0700")
References: <20250701011201.235392-1-xiyou.wangcong@gmail.com>
	<20250701011201.235392-5-xiyou.wangcong@gmail.com>
Date: Wed, 02 Jul 2025 14:17:13 +0200
Message-ID: <87ecuyn5x2.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 30, 2025 at 06:12 PM -07, Cong Wang wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
>
> The TCP_BPF ingress redirection path currently lacks the message corking
> mechanism found in standard TCP. This causes the sender to wake up the
> receiver for every message, even when messages are small, resulting in
> reduced throughput compared to regular TCP in certain scenarios.

I'm curious what scenarios are you referring to? Is it send-to-local or
ingress-to-local? [1]

If the sender is emitting small messages, that's probably intended -
that is they likely want to get the message across as soon as possible,
because They must have disabled the Nagle algo (set TCP_NODELAY) to do
that.

Otherwise, you get small segment merging on the sender side by default.
And if MTU is a limiting factor, you should also be getting batching
from GRO.

What I'm getting at is that I don't quite follow why you don't see
sufficient batching before the sockmap redirect today?

> This change introduces a kernel worker-based intermediate layer to provide
> automatic message corking for TCP_BPF. While this adds a slight latency
> overhead, it significantly improves overall throughput by reducing
> unnecessary wake-ups and reducing the sock lock contention.

"Slight" for a +5% increase in latency is an understatement :-)

IDK about this being always on for every socket. For send-to-local
[1], sk_msg redirs can be viewed as a form of IPC, where latency
matters.

I do understand that you're trying to optimize for bulk-transfer
workloads, but please consider also request-response workloads.

[1] https://github.com/jsitnicki/kubecon-2024-sockmap/blob/main/cheatsheet-sockmap-redirect.png

> Reviewed-by: Amery Hung <amery.hung@bytedance.com>
> Co-developed-by: Cong Wang <cong.wang@bytedance.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> ---

