Return-Path: <bpf+bounces-78209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C20ED0264D
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 12:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC80F309CAB0
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 11:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACC9345CC2;
	Thu,  8 Jan 2026 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBurWId2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0ZaHClA"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615B632A3CC
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 08:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861716; cv=none; b=sSVDPvsfLjzAVgoD6ohHszJS/a9ELDEK1RqbHcNL6ei4QBMHNwP53zEJR7CLQZBzWHqvOIhM1O+3GoT7Hh5KG+BYvTffvGdFL6DQ7qN94PmsilskCQFlg3QYc6FDq/bmr0Lmze8b9e3/UPj1wiissEODfdmScouqWV45bliH7fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861716; c=relaxed/simple;
	bh=T3g1hkv59Wof+KEXGfr6rRK1rS6rPS46Y5/WRoZTizA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=auwxx/aMgMcY+xJ1671SZCHfXkQlXL+NZx89GgWlvVemdNIah9Ht3uQgHpNQDGx4I/SYk80FectZiC2Mu8mCuK+aa0IYMDcHAiKvf1z+Glhk6Uomaos7irg/U1sbrxJfniu94qPwSr95BzLkJv30bQ2SVY7HfJVwjsAGvHhiauA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VBurWId2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H0ZaHClA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767861703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5RGxvIn5fQFYR3/ngtCtv4UC6h+IZmTY0D3VzGMTF2k=;
	b=VBurWId2HqDrerkVnZFpzr+u2oijSKw/y5AwinLgSSqHcGcgpuwRuA5rqmcZWF2crUSpTe
	RgcDPzslfnlUj/2Hr/2KycWtH0/2yuS2lGUT6xY69D3DF84Za6K3U2G1Z4229diie6+XUQ
	c2Y1jJGUlznxQPsD4sy68uJajZBycuA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-kWPnxg8OPBeLAEsZvTsQ1Q-1; Thu, 08 Jan 2026 03:41:42 -0500
X-MC-Unique: kWPnxg8OPBeLAEsZvTsQ1Q-1
X-Mimecast-MFC-AGG-ID: kWPnxg8OPBeLAEsZvTsQ1Q_1767861701
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477964c22e0so14115175e9.0
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 00:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767861701; x=1768466501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5RGxvIn5fQFYR3/ngtCtv4UC6h+IZmTY0D3VzGMTF2k=;
        b=H0ZaHClA6c3KoNXD+3tXrJmCoOMCR4qT4eAFmnf2dOeabJW5fsJqAWfno/Hnr6IrJF
         PZsl7U0+3YU3OI4CFlEzjkH45/HO0+BSrGX9ycowVi6hz+rbrBz7lDIeSMLATjJQ8fpj
         4bcunlq7X/5aKBSUWaT5w7dl3OVtHYcGXCexzwle5no4JMZ2LS/+MjdiFTy4ANdhEH/D
         EyZTVPMJdL1rs56ukgozYGLyIfpVz8OLhjT6Pu9aHsf61+U5LHYQAbpy+Mb13jGJg28V
         njkHf0BGhtJDYMe/xcmy1utfrDHkmj/67hrPfw1S16/xnMmMbWsfk3Xjx2at6abqluqP
         Y8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767861701; x=1768466501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5RGxvIn5fQFYR3/ngtCtv4UC6h+IZmTY0D3VzGMTF2k=;
        b=c/BgX5RNAQb/1nui4FfdrEz2IBPRrsgAKWTgERAO9MpvimCX7S4g5vQ/Ppc+QmRjbB
         oDBVCrpVvjPIxfxXiwqu4pjJhghAEbqnqE1mG8gwlgZxnfkD/JnVX6qZUXPQaOOcZao1
         PmSnsqqF/9yRVdcL0oy8CQXAeJrcXMNm6GVATGOFRpwCSvTONZqpegP6vx02He4qP2+P
         82ASlcfpp5M30HRv4R35/ZCdN31xSTpjzCx2EOca9cHZjSrDR7upkpl/I7hLsMbfzWX3
         aQP1FVSvjl9KciMgIGnCj9YU1g6HeVCEjTt37mBQW+3NiG/cB4nmIjzkt8Bbeq+zbD/w
         qtBg==
X-Forwarded-Encrypted: i=1; AJvYcCUMbtQFoz/U/bz7Q48l1cM5/ieDKB//GMhyKAAxTkdvzQ+H7Or3KsR3XfrQ+0ZK1RCrY60=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRX5YwsMJfW+oej5uq8jPfHlTdJBR6pYMVoTGnkzIsdohC8vxT
	ECEt/TsCj3KPhmMxBHzIqbkgqWFntqeXJO4hcDoclmsA/qqwSHE/XA0znKBvMl73tYkZBFx6BSk
	OEZqZmi7FkCNAWJDGO9i/I9BaIJzRDOkBTzGSt0Bh/iiCgSHM05XG0w==
X-Gm-Gg: AY/fxX7j6gsMwwEhd/Zc2f26tupFPNGzTLR8fIhICgNQkG2a7874XPnlLANWYYJWMtP
	eB3iiiCxhKoAfy2diwcuEt8NZpFOI3+xOWV8tev5tbzUgpQEvS2GTI6MXbC6xmeHF/INLnI/Fje
	8yuzg+/dQNkBaJ1q3sh3gA4dkukEoy54zBDzE2IpgJPhpGkpAtX2yiKInqi8v/XUlM+Fs8WDRSv
	QLl2r2ytoKq3MPh+b3jzwodssKxiYJnBf0H6z7fW/HtnQ+ecUC/JV4/M5n0RkwdqSbo/Gifn3SU
	fK67Bw7aqlTsrZw5uhA11uZ9acv2PuwLG6PyaG3X3lS6V4BDlnKn8TDqzF87TvYPt3I9YTjWdfM
	YBu9XQfyGejT9mw==
X-Received: by 2002:a05:600c:6749:b0:471:5c0:94fc with SMTP id 5b1f17b1804b1-47d84849fb2mr69623915e9.6.1767861700967;
        Thu, 08 Jan 2026 00:41:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMRmXfUT8h/fx23p3HVnSIevvQ/xZpWdXJvjJswXBBTxuR8fZK2hfXFsrWgfe2gcekBcZ2PQ==
X-Received: by 2002:a05:600c:6749:b0:471:5c0:94fc with SMTP id 5b1f17b1804b1-47d84849fb2mr69623615e9.6.1767861700621;
        Thu, 08 Jan 2026 00:41:40 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f703a8csm139970835e9.13.2026.01.08.00.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 00:41:40 -0800 (PST)
Message-ID: <56f6f3dd-14a8-44e9-a13d-eeb0a27d81d2@redhat.com>
Date: Thu, 8 Jan 2026 09:41:37 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 00/13] AccECN protocol case handling series
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/3/26 2:10 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Hello,
> 
> Plesae find the v7 AccECN case handling patch series, which covers
> several excpetional case handling of Accurate ECN spec (RFC9768),
> adds new identifiers to be used by CC modules, adds ecn_delta into
> rate_sample, and keeps the ACE counter for computation, etc.
> 
> This patch series is part of the full AccECN patch series, which is available at
> https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/
> 
> Best regards,
> Chia-Yu

I had just a minor comment on patch 11/13. I think this deserves
explicit ack from Eric, Neal or Kuniyuki; please wait a little longer
for them before resend.

Side note: it would be great to pair the AccECN behaviours with some
pktdrill tests, do you have plan for it?

Thanks,

Paolo


