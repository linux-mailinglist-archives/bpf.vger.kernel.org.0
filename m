Return-Path: <bpf+bounces-78299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EAFD08B88
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 11:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E571E3002A7D
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 10:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB7B33A712;
	Fri,  9 Jan 2026 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="W4TbCNnq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E733358C9
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 10:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767955807; cv=none; b=UeoqrJ8w24SR2RJsaltb1KfdOtuK5QB4mPhmnWrgWvXaEC9v0p5OAKcPQTqzrlLhj519avCJyLX4bSE8S6MG83cYSprEDeG34nrE9fhcPl1D85zoCJv601e1xptb+88/+E8lQuFEfrumWNuCvFj2FNAxZTGaue/5QqO+C0C83Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767955807; c=relaxed/simple;
	bh=kAgWQkJ5yk/MYNStM3WlVvA9Wp6f85XIjpLeHbfgAQI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bhzYGDNO4fSWr3BrifQMpZ96KBZSS9qK3qJdYg0lQ4/0noqAlUvJz+qI3NXAebjcwX7uMnFuL5W1FKNZUfuei5s5UvjABK17RT5j6ryzcNMjvo3tbGWrLnUeoYGuKASFm9rQuPIEBwzD54UuswdrypWKHUUeltosYyLPa5J82Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=W4TbCNnq; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65063a95558so5914779a12.0
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 02:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767955805; x=1768560605; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vFjE5UMao2j4JAz5MJyWxNKmH2Rqw+0e59JALKeR3L8=;
        b=W4TbCNnqczI3gPJ9E8NxAa+YGg8KnswYtUlHeDZ5f4N5PSSRucdhpNalwhEjPr1BAO
         aj5sK3smAtNOJfVuD6NelqyAb8vakAMvjm3WD+7LKbHX1LzBufbv33o1+IwV7HkdI+1N
         XFWURMz9V9GpZmQ53x3NiZxEYm5NeyX5NzOeBs4nA8nOGGQT2xWfATJlaRN2YmjXSKoT
         n8okcIx3yRF0YBecerFytC9+tqwkfJDye+aKKTHPKRxIdREp400e9v0IB4MsG2SGB9K9
         psE9jqiv5xGxAmxuxLrOIDiZ+9e1LyoBmTYZ7BT5/OFr8aw3a2ruh5rq2Q0ppk8AuXrv
         JiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767955805; x=1768560605;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vFjE5UMao2j4JAz5MJyWxNKmH2Rqw+0e59JALKeR3L8=;
        b=SbNazZzAxfaCbZKB7kSfByqsFIT2Dm+NE+WpHhl4l+TIJ+GNGh02EYBK0FFMxhITUi
         eWNWhp+OVNSg1GLBvS/rzozj1fswzP3m3oyylZEA0GJe3Vm+riOiXZvE4MCqOOlKiAMg
         lPSi3AGV5emxcQ5j/Ya6b55e9fQw1ZTyH1H090uokAJH3x6ACnIxyx5ebamMRxP+Vp5V
         HmAies1zWEoC+QKvQzmpjlToIUR4l2ZvtE7IQ+NOgaPfsaGTWRNsY0k8T+NntO1EqpYL
         J7ESzmQeXHQUjZjBpYjaCfJbS8EJzEjeXq4Fj7/conUxjIrko66WJvOJYJRAQJb9ZuR4
         5hsw==
X-Gm-Message-State: AOJu0YyuBQWUZzOR9K7xZqMxYYuvO0rZ4RTJ2ltsTSLS95BCtlLkN4yQ
	OFVp73ksD5ltKqSX+2FK6gjoDKRaZbRdbhvxFWR0oHwkls72nKmEnFIciLAb45+21p0=
X-Gm-Gg: AY/fxX7a/x3WsxzGRE8rn7xnvUMGEoqq961+08BFo2x+20pKdYmKnqNOgGSPbG7d/JG
	gvvLiCmr94kTOk6p/mTlwxjJ3py78fyBTTznq1Z2feF+H7yGnGAbR9jnG0tDzo7AIJe4694N/pn
	xNx9b50MjjdX290H61ikstuc1olc8vGDw5nCACPzZ2zCgIK1xvfNnhdAOI3WC2cWeGRGKu6vISe
	7/CNVgOh5aisoFIIYDoRvzhg7rSR8fdfhuj3vM7MFiY+86nqlLHEDDO6MgR1u91UPWHjNkqWU4Z
	YzIdVULMoa5G7kRRV2f46Eo46UMbjUi40wkSfKBfmmpHNED8lSqAX76/kVplGU6aGfr7C3hUijS
	hZqSVnu3F5fXwcHO8qTJn7eziHZJHI36ZghXsS0xYPlUyAirjcJRPDJdhpOTjjqkWq0WIfZ7O8P
	G4ImxZbLRbmDiEOg==
X-Google-Smtp-Source: AGHT+IGUBZ5NlUYwTuvlC5bBR6YFkuq3nVxVfFstEiBG6clv3mYeTvUryHJruIxzhpf6L7f9weVDYA==
X-Received: by 2002:a17:907:a08:b0:b74:984c:a3de with SMTP id a640c23a62f3a-b84452837c3mr901273566b.28.1767955804513;
        Fri, 09 Jan 2026 02:50:04 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:e2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507be65197sm10018048a12.19.2026.01.09.02.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 02:50:04 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org,  netdev@vger.kernel.org,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo Abeni
 <pabeni@redhat.com>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Jesper Dangaard Brouer
 <hawk@kernel.org>,  John Fastabend <john.fastabend@gmail.com>,  Stanislav
 Fomichev <sdf@fomichev.me>,  Simon Horman <horms@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Martin KaFai Lau <martin.lau@linux.dev>,
  Eduard Zingerman <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,
  Yonghong Song <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,
  Hao Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,
  kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next v3 00/17] Decouple skb metadata tracking from
 MAC header offset
In-Reply-To: <20260108174903.59323f72@kernel.org> (Jakub Kicinski's message of
	"Thu, 8 Jan 2026 17:49:03 -0800")
References: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
	<20260108074741.00bd532f@kernel.org> <87ecnzj49h.fsf@cloudflare.com>
	<20260108174903.59323f72@kernel.org>
Date: Fri, 09 Jan 2026 11:50:03 +0100
Message-ID: <875x9bhxgk.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 08, 2026 at 05:49 PM -08, Jakub Kicinski wrote:
> To reduce the one-off feeling of the mechanism it'd be great to shove
> this state into an skb extension for example. Then if we optimize it
> and possibly make it live inline in the frame all the other skb
> extensions will benefit too.

Back to the drawing board then.

Here's how I think we can marry it with skb extension:

1. Move metadata from headroom to skb_ext chunk on skb_metadata_set().

2. If TC BPF prog uses data_meta pseudo-pointer, copy metadata contents
   in and out of headroom in BPF prologue and epilogue.

3. If TC BPF prog uses bpf_dynptr_from_skb_meta(), access the skb_ext
   chunk directly.

If that sounds sane, then I'll get cracking on an RFC.

We will need the driver tweaks from this series for (1) to work, so I'm
thinking to split that out and resubmit.

I would also split out the BPF verifier prologue/epilogue processing
tweaks for (2) to work without kfuncs.

Let me know what you think.

Thanks,
-jkbs

