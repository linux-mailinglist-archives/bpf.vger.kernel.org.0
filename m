Return-Path: <bpf+bounces-78753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EED2D1B30F
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 21:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 357D93033D46
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 20:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60937387379;
	Tue, 13 Jan 2026 20:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="S5t4E9Op"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA72350A28
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 20:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768335779; cv=none; b=XsRldPOvji51aJ06PtXIwzY55QFQNJUaD/mQUDBpzsnSdABjSwHz4GmE7pyp7IhAw9iVJVUsOgMyJ1VD3J++pci+DUD9iStur4oek0+iNR6jIA61e27LrRxMfoBn4HwhXYTpc1QKr+Rei9FJfm2ElmXsXiMKQLCHrEQF4F3TtP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768335779; c=relaxed/simple;
	bh=N4vJNx3dUa8zDPVZMwGwt/ppJvMqFmg3kxgkj5Re3hg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i9NB2jN94/Ft4ThZWTBiFtDG28dQrV91wfUem6hvh4X4hEtKolPl1YdZsjerdZ8ICgJY4UQ9lnneMdlppM1ERAohunLGd7tc22o3BYkPt09yGM3O6PJ+QzRrKuD4SsdYYX80RUwsATYgXG2GCWkWCXqyX0VVVqfzHoTeVpgkyHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=S5t4E9Op; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64b7a38f07eso12176307a12.0
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 12:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768335777; x=1768940577; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SEW+k25GxtoGpssMWcEBFy4Kv0XQW2KgqZU+s4uI3s0=;
        b=S5t4E9OpNiiuR6TsjF1K3JFlVtQxEkkjXN49CcvjpsvKDvignDGZPt5Ul38UTrcOI0
         zCQBTQlkMOqUoMUygYghfor56xbzScRq88LXOIEbfYYdQCPTDNWerC1y/dh88q4J/HeD
         PtAf/igt0u152z7ZUw90O23KBmUx+2ZF3L0ubr6u2ct6tkhjQXfrqziouI/3lIxBm8Sj
         +bcYJw5rAiCq2WuYvLoZsQpTIciLZIouU2x0Upwxu189nZ1VrDtGkD4RGADHh1S3zUgZ
         7ekLjQq6N0ZfXrAg5q3f/xScReTDD1J/nmUq7JRDyOem2MKioroesvA7YO5DnGSOHwYz
         T+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768335777; x=1768940577;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SEW+k25GxtoGpssMWcEBFy4Kv0XQW2KgqZU+s4uI3s0=;
        b=OPEgKRSp+bokYg+46r6WzWwjup+2H6JVdWPVakzd5Coi2VGNQaTeL1qgiPYgcQT9y1
         qJqP3wMIvY2nil+bF84uQi8JMzb5m180l5CM58SS312+vPnolFGKFNDHLnD/FiM1C+Db
         hWT0b3WlLpxlC1rcOczqqperFqivJi9Ikq0oE4bX2DTGo+7fWJPpIZqGdL3N2iU6H708
         J6lczT8X2NYL7/FLG6bGMAXglvOZ5cAni3iCCOUZRukk9E7ftsg+ZA6sxzqTZu3gDhpb
         ioJZwsay+3pY4hBay8Kikxm8DbYPqkXBE5y7p8/muzuhq9fgnrcu80xeJv6FtK3YAHWe
         bBAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqIThVrvtP6JPMc7HupjMm0FDkSsyTbkFizmHRHxC6SqYjkey3XmRVbffG2Y/6Ewj8lx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlZAKuMItlDjww96rgcSWw5kk0Wh9mMTvyOLjpLotxE3jKYmnu
	198oyKlDGVIl8bkhXnE/LHIwZBwx8fdqZuMJ/IJMSy6Y52k2kFCtXzgo0s1mxiuaH6g=
X-Gm-Gg: AY/fxX5RV7ao6p+aNjzOxxEY0hDBmXtZQlKhDVICHM2peirLl+zWMATBvlGZ+u9cfo8
	h64H3zLYP4QvIOb/gJnhzC7vtjd1eusQNT7Oo+EM9INGygoN+qab2o8iV1x6ydHcTMZrlXAeK1/
	A1NlLqtrssoZ4S7ZzSFc4zwJQviVThTpUOnimWFuiMyBYZilo2kcbyWOnbCGe5aIndH0YmyS+LB
	lTRjnxgJZYu8ifUqFtWj4DO2iCun/Vj/OlZssu0j55s73Hx4psJ+9sQo+dkWhBM5z6J+C8dVaqa
	vdKIN4U8RoqbIKIsKf3257oZxAIf9yNHDymCU3WEebmGpa1cZF0pbtMKx1BhWlpriDTuQv6dOTI
	4tUTrcUoChH+Jan7WWYEyf2FQ0GQgmODJ2uwa7w25II/AA5qEtnt1Ai66WcNMsU9yaB515oIdsJ
	dAfz0=
X-Received: by 2002:a05:6402:144b:b0:64b:7885:c971 with SMTP id 4fb4d7f45d1cf-653ec44348emr170193a12.20.1768335776737;
        Tue, 13 Jan 2026 12:22:56 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2969::420:33])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf661fesm22541348a12.25.2026.01.13.12.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 12:22:56 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,  Jakub Kicinski <kuba@kernel.org>,
  netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Simon Horman <horms@kernel.org>,  Michael
 Chan <michael.chan@broadcom.com>,  Pavan Chebbi
 <pavan.chebbi@broadcom.com>,  Andrew Lunn <andrew+netdev@lunn.ch>,  Tony
 Nguyen <anthony.l.nguyen@intel.com>,  Przemek Kitszel
 <przemyslaw.kitszel@intel.com>,  Saeed Mahameed <saeedm@nvidia.com>,  Leon
 Romanovsky <leon@kernel.org>,  Tariq Toukan <tariqt@nvidia.com>,  Mark
 Bloch <mbloch@nvidia.com>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  John Fastabend
 <john.fastabend@gmail.com>,  Stanislav Fomichev <sdf@fomichev.me>,
  intel-wired-lan@lists.osuosl.org,  bpf@vger.kernel.org,
  kernel-team@cloudflare.com,  Jesse Brandeburg
 <jbrandeburg@cloudflare.com>,  Willem Ferguson <wferguson@cloudflare.com>,
  Arthur Fabre <arthur@arthurfabre.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next 00/10] Call skb_metadata_set
 when skb->data points past metadata
In-Reply-To: <bd29d196-5854-4a0c-a78c-e4869a59b91f@kernel.org> (Jesper
	Dangaard Brouer's message of "Tue, 13 Jan 2026 19:52:53 +0100")
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
	<20260112190856.3ff91f8d@kernel.org>
	<36deb505-1c82-4339-bb44-f72f9eacb0ac@redhat.com>
	<bd29d196-5854-4a0c-a78c-e4869a59b91f@kernel.org>
Date: Tue, 13 Jan 2026 21:22:55 +0100
Message-ID: <87wm1luusg.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 13, 2026 at 07:52 PM +01, Jesper Dangaard Brouer wrote:
> *BUT* this patchset isn't doing that. To me it looks like a cleanup
> patchset that simply makes it consistent when skb_metadata_set() called.
> Selling it as a pre-requirement for doing copy later seems fishy.
 
Fair point on the framing. The interface cleanup is useful on its own -
I should have presented it that way rather than tying it to future work.

> Instead of blindly copying XDP data_meta area into a single SKB
> extension.  What if we make it the responsibility of the TC-ingress BPF-
> hook to understand the data_meta format and via (kfunc) helpers
> transfer/create the SKB extension that it deems relevant.
> Would this be an acceptable approach that makes it easier to propagate
> metadata deeper in netstack?

I think you and Jakub are actually proposing the same thing.
 
If we can access a buffer tied to an skb extension from BPF, this could
act as skb-local storage and solves the problem (with some operational
overhead to set up TC on ingress).
 
I'd also like to get Alexei's take on this. We had a discussion before
about not wanting to maintain two different storage areas for skb
metadata.
 
That was one of two reasons why we abandoned Arthur's patches and why I
tried to make the existing headroom-backed metadata area work.
 
But perhaps I misunderstood the earlier discussion. Alexei's point may
have been that we don't want another *headroom-backed* metadata area
accessible from XDP, because we already have that.
 
Looks like we have two options on the table:
 
Option A) Headroom-backed metadata
  - Use existing skb metadata area
  - Patch skb_push/pull call sites to preserve it
 
Option B) Extension-backed metadata
  - Store metadata in skb extension from BPF
  - TC BPF copies/extracts what it needs from headroom-metadata
 
Or is there an Option C I'm missing?

Thanks,
-jkbs

