Return-Path: <bpf+bounces-78883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4736FD1E9B2
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 13:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B82BF3088FBA
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 11:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4551F393DCF;
	Wed, 14 Jan 2026 11:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WlHvul2y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F68392829
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768391539; cv=none; b=ftRr4Pg7YLakbKQw7Uq/jledxL5AmsJPBz5aHmy1nh9fMlFBms102oN8zQ21WBsg5nznveBQHZfl6NX3O8heT1xQbwRNzXnCs0QSkN1kQWqr4U5mC27h9kU98Zg7nZMH0PlKXDNZxpt5+75nbJfLYJgjPj570rlxGZw7pGHMTqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768391539; c=relaxed/simple;
	bh=8+8711yLJZZdjomCtegalYdi6yMl/i06ay+AE5+sCgE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iPmGrxo7a2P1O0xkN1p0flfPxhTVegaw1eQt6TSBhem8aGXcET9XjH8WjHj0TW0w4+pJ1P9BLx0jg2N09kQ1HHGtBGbWBtOeety18h33cbpmn6sug1h0CmZaWKHcPWqN8S3aM/4z0WcYFey6KHz9dH3bwTzm31pUECGWLOdf39k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WlHvul2y; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-64b58553449so13687796a12.1
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 03:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768391534; x=1768996334; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IlADXTpmTXTOrFGBVzHHxJm8P+TszlCVzr4tthKySrs=;
        b=WlHvul2ytMJyQxGnisXnWSdF+COeMD61RHnAxk6XBZ0PD+uekz8KO8fb+eTtOWsXSw
         IRWx5pLw9kiHOitgA/1UNj1iElE/Gjw/lyG20OIxk8a8KAt/MSHqww/AadYi+aS9nTSu
         DBfh78bquvjzFCtZbPUTjRQ46cuGb4UQBDkR1cNnLp74ubElYpY6cK6KNLWqHPllc5Uk
         PLIG94MA3wRYRlae7ZU7xwl0yFo005NaryP7CmsjrvbMcw4XXeEDC07XoJxJimcfLHSD
         5pmyVh6o1nM63Yn3JTU+F+USiMNRU+ieozLp2WCGNAjwJbDfCizh4t+0XzClDdiwakSe
         SaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768391534; x=1768996334;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IlADXTpmTXTOrFGBVzHHxJm8P+TszlCVzr4tthKySrs=;
        b=kF/l27gSKBlemfR8Rmcp8E53vWd2QnEGNrJEeCk/DsPAy27cqwFyKVpQbpnSPtW/DE
         B9XGw04Y2qC+TSr8G37U2O8weXWT+QK8tveoGczK6Utvw8QxwqmdMEjv5kD93dhb/hAE
         MK64ZApldRK4YkLkPXnfnLMppvTe5eoRp58uhwqdvvbfCXgrwNSCWjReKn7YCpGscq+/
         ndMoTFpATeL/mZwkIPtW0LuRGx6XmDGHFZoua7wJ4AUwMNFGdlh/27/E+cP78HpcRGlM
         e4SiKSP06gGGcd2nkl1dt48+q4VF9dsrkHGPXODdJ0x823sI7r4uzRRyp0kADZKZDz1d
         ZLcg==
X-Gm-Message-State: AOJu0Yw5uP6OTo8gBddQfciJVnUsX+DxAI69cfznZsqgJZfvJ7AUZqVa
	fw9WWJp5YBgHuiPtrNgoZ+R9t83zbkJd2gRkpxlMGcZk04C+3PpqCaUrRAupy64l1ctZU4L6VZu
	7p6tUtAo=
X-Gm-Gg: AY/fxX446eBw597S4RhyHaIBgDyRd2ll++IUrreXk7EJ7HilGwr8KT7HFfkCsoPM0GO
	KCmPsLOdDzNZFkGn+4obW2nmcGA3ODHepcwC1C44Ednnc+lF9h+yZYidnS9qqCZI0By8qz2crqX
	2yJGQ+Q+wae+Kz4gKBWB/fYv76QLpeIG02qnIy6AEG+OvxwVQ1sYo3/ikNHfUh9bCzQ0UAUJmeV
	lZSAMvuJ4njT5Mni5I1pTm/issslFLUP6i2J9YsG6PbvLYSv1t4hBwXjzpobfcuoNQ8yxy4Dkma
	08gCZxXSYTve5VCzVrJ9dd1QQ5+g/gaFMZFSo81aFhOIrDhjj8TYsWM3JYhTDl+Ap0jC68uN7s2
	6eGGEXyVRFaLSo3r/G064myE4dqJAQhncEt4xAzI9jNuOnwUXo2aOsdV8kt0GyW6nnKZb8ZqreQ
	sJ8TA=
X-Received: by 2002:a05:6402:5209:b0:64d:250b:5a8c with SMTP id 4fb4d7f45d1cf-653ec459b6bmr1772660a12.25.1768391533839;
        Wed, 14 Jan 2026 03:52:13 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:bd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf6d5d4sm22805284a12.32.2026.01.14.03.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 03:52:13 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Jesper Dangaard Brouer
 <hawk@kernel.org>,  John Fastabend <john.fastabend@gmail.com>,  Stanislav
 Fomichev <sdf@fomichev.me>,  Simon Horman <horms@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Martin KaFai Lau <martin.lau@linux.dev>,
  Eduard Zingerman <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,
  Yonghong Song <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,
  Hao Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,
  kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next v2 00/16] Decouple skb metadata tracking from
 MAC header offset
In-Reply-To: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
	(Jakub Sitnicki's message of "Mon, 05 Jan 2026 13:14:25 +0100")
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
Date: Wed, 14 Jan 2026 12:52:12 +0100
Message-ID: <87ikd4v2c3.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jan 05, 2026 at 01:14 PM +01, Jakub Sitnicki wrote:
> This series continues the effort to provide reliable access to xdp/skb
> metadata from BPF context on the receive path.

FYI, I'm dropping the effort to make xdp/skb metadata survive L2
encap/decap, following the discussion here and in [1].

Instead, I'll work on an skb local storage backed by an skb extension,
similar to what we have for cgroups/sockets/etc.

This approach avoids patching skb_push/pull call sites and implicit
allocations on hot paths.
 
I'm happy to split out BPF_EMIT_CALL support for prologue/epilogue if
it's considered useful on its own.

[1] https://lore.kernel.org/r/20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com

Thanks,
-jkbs

