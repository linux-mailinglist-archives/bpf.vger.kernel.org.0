Return-Path: <bpf+bounces-64152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD62CB0ECE4
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 10:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054DF543C25
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 08:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C602797BA;
	Wed, 23 Jul 2025 08:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgTqu8uC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA3D2741A6
	for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 08:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753258415; cv=none; b=d8tA6FfNsA99V0XrduV5VioDt9GaBGq+SRGicyXu0sq+t5GHMjXqnbWMhsSu1UAsxA2wfemj6qWdjew9SOtNzo7qHJSxaDh0K9GHhVJjE/xSDM5VFqqzZKzj/xhYRcrwvfTFEg32pKWtUsdPdnUYO2c6AaXYp7obGbAyfssjpi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753258415; c=relaxed/simple;
	bh=/DL1CY01W6pWlInDzGMht4Vbn/XB1kN09a3nLVRDXpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sd4U9hcEpz2JuBRJ4zs1e3B/K8glRNY3rsLebkCYkoLHBjnUiNRFsvJVw2PtKM/SNuHcmTkuORiqpz/6jQsMX5fpH3SfZdFUbvcyBemdtNrqU6/oJ3ZZgI7XxaKNfg1+S3A40LGhRwtV5fgwECdtZ/R+qtbBD1USdNleljnmsds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgTqu8uC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4560add6cd2so4896545e9.0
        for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 01:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753258412; x=1753863212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AsXrqit8itefEDeEgbgEnlICKQbXCmGrl/GcWe6GOsQ=;
        b=IgTqu8uCYlDl+12JWSwxmDtwQ6Szx4yHhQMCXMQIOvIkeVlR2BidZGvUegSZLSy/ZA
         jisFaswKOr0WPY09qocmLIY1M4KkHpGJ025en+lV5rcd82XK+kNe4LfRQj/i9MvF4kjV
         T3zeEUxRsmI0epzs63K8mUqaENkjtRi0WByxEzHSdrpsJwY8GWbCrNKcRhJQgHZgMcMg
         ihjc3X31ANwvpTPKIlfihq1CPmaWIL56oJhDWdRNiZHSQafCq+Vq9w1pIgUWcSm5i1xp
         2FrWauSW+ENmib6k1ow/2qdIi90B6mn5iDk0iMX32OaemE5/z6Kq+ZvcEE318Nw5GsvZ
         TqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753258412; x=1753863212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsXrqit8itefEDeEgbgEnlICKQbXCmGrl/GcWe6GOsQ=;
        b=ACrMiZl2UrWzs9YjTc0rqAGFzQvol/cxOSBevUk3z5mBM6UQSVU+A+yze0HscAlCeL
         7WfPpnireqHrGrKYfnEp9OfHGQawYxLWV35lPmi4ORiWr/PrYqgysPwB8LbX5EYLZhWn
         M4MYEfrzFDgzUfig8E8NDQZVSUgIken2pO4C5V0FBQ1v1eRV87O7uEgfRl9zWRI4YinA
         tLvhWuAgfzlqzK3VR5VsaW0TLLdvFKRUJHnclm2ejgLnZgLWY1iSRPOraleHZatBrdXa
         7uVhCwkmlroCtwaafxOSd39PFY1qFUDA6yZvmh6X/X+ErJHL8UGbULho0DTRf+bddep4
         lPsA==
X-Gm-Message-State: AOJu0YyrhDOboXj9H0x2xYD3TUawSbplNyGvi5Nkw770vncZvZjxe0dq
	0l6rCimIgIkzs0VOq86Le6YynlAWrIqCeFH2VCHMznITjlvY5DyJ8nn9
X-Gm-Gg: ASbGnctWi+9TSoqPdvOUO/XiHcTIors+VDQf5vd8DSs8c4i8T5Rae7ir/NoCAh+RNUJ
	aeEZZ+MCYD0uB2hAvPViQ/5M3fwgzVtX5eBG7PcLyTvimWBEQg4nzD6B/6UUrlc9NOxejLAmbrJ
	cOqKKgQ2pNWpRRJ/6LPZ+SOLDIYbg47XuZMddAfZ6OViO1YcWvzjqON2876jcncHYADJ0BlYAf6
	ibCnRAkrPYTvPEdWYfQ6/bBV5jhMLSNCZ8Ja2090CqBr5npvEE2X4PG2XKw18p86rnn7m2W5K8A
	ixaIjhREiWHeprv39vbiYwenYCVFca39RBbwJwlB4cavjqotJLCP9FFnrwiAsAzktjgFZCQ1uOp
	CRe6kQyO//A280Hs9/LXNUpdq8j/Eoh8lPcvgZjIvyhQW6V5SPOcjSr5MzpIs4QYaIfFkOUdrNm
	BS7kmnQOy7u1iwQA2XHUQ=
X-Google-Smtp-Source: AGHT+IH71sqzN4WZeVT+3Etew/5XxNCKy5AihjhmwFthEUzI+BUrzP5TPG2OhTweXcKQCRp7LyXd+w==
X-Received: by 2002:a05:600c:4614:b0:456:18b3:df2a with SMTP id 5b1f17b1804b1-4586271864dmr37698955e9.7.1753258412137;
        Wed, 23 Jul 2025 01:13:32 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00cfa108e383da6697.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:cfa1:8e3:83da:6697])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458693f36cesm14833015e9.33.2025.07.23.01.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 01:13:31 -0700 (PDT)
Date: Wed, 23 Jul 2025 10:13:29 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Reject narrower access to pointer
 ctx fields
Message-ID: <aICZqWFT77dvmJqc@mail.gmail.com>
References: <3b8dcee67ff4296903351a974ddd9c4dca768b64.1753194596.git.paul.chaignon@gmail.com>
 <0e81620a-a03f-4a95-9f7d-45ca63813368@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e81620a-a03f-4a95-9f7d-45ca63813368@linux.dev>

On Tue, Jul 22, 2025 at 03:28:40PM -0700, Martin KaFai Lau wrote:
> On 7/22/25 7:32 AM, Paul Chaignon wrote:
> > The following BPF program, simplified from a syzkaller repro, causes a
> > kernel warning:
> > 
> >      r0 = *(u8 *)(r1 + 169);
> >      exit;
> > 
> > With pointer field sk being at offset 168 in __sk_buff. This access is
> > detected as a narrower read in bpf_skb_is_valid_access because it
> > doesn't match offsetof(struct __sk_buff, sk). It is therefore allowed
> > and later proceeds to bpf_convert_ctx_access. At that point,
> > target_size is null and the verifier errors with a kernel warning and:
> 
> I think it meant target_size is 0. I suspect !cnt is the condition causing
> the 'verifier bug: ...'. Please check. No need to resend. The patch lgtm.

I also initially though the error was triggered because cnt was 0, but
it is not. In case of narrower load, the offset is aligned before
calling convert_ctx_access, which means we match
offsetof(struct __sk_buff, sk) in bpf_convert_ctx_access. An
instruction is added and cnt is thus 1. target_size however stays 0 so
we hit the verifier bug error.

