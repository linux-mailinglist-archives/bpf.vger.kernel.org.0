Return-Path: <bpf+bounces-18670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF7481E6BB
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 10:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B4C42836FF
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 09:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605814D5AE;
	Tue, 26 Dec 2023 09:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="It3RE/TP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2CE4D594
	for <bpf@vger.kernel.org>; Tue, 26 Dec 2023 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a26db3be219so309747066b.0
        for <bpf@vger.kernel.org>; Tue, 26 Dec 2023 01:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1703584385; x=1704189185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FGcSKy9VLe5UH4WPuhkVUffKMD3KkfmFrJxOaiIXVDA=;
        b=It3RE/TPxQ6sFBvGMgIGOLCpWWZkQJ3Gq/osIVT1YXuDO/LCG98zHEv9++8WvmJERz
         b+NgFwV9s4RZrGhHALNeCnQzWBRaJQlTplexm+rClGAgXh6zGe5UTjOEUoks2IcjxhfK
         qkid4/MItlgbN+s2Ay6DEn7F+RsbKv0Z0PDAt5rjXRTven3UzBleT+0RseNA6fBm9gqz
         FyYyiYSrrWi4e5vVQqA8e5xoVCv2fx9+TIb0vsf5H0GVNo+zS1LYZqqtFJT8J30uvDr6
         /IVJpteIXhRIMWQ0Zb1f/IaJnBkn2DpUqXhzBsjIfoPiRf3ighwFNk0VrAacy/zQZWIF
         EWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703584385; x=1704189185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGcSKy9VLe5UH4WPuhkVUffKMD3KkfmFrJxOaiIXVDA=;
        b=d1fo+qzzcx7PRLRT/DmYYn4Cz2B2pgUZR7u5pgTOPiuJFLtfyZ0CtpVrUuRhtCk3pX
         8+BBXAnleMiH4wrqGHBYd5tcUqLYHF2DHSyEDEe9OjTcI3STr0PAEFa9fVmzE3ecQUYh
         ZGFMaZUV26k0xZ+1+RU1ie9moJvbViT1TrWmQSxlLzeHsZPvGBISIlbjyxtYQP5d/X3f
         LloBxQPKxIpLj1uBvUqH5SsdzJGnmrLAbGUfzgh2Hn9jqP6VkLbHLXJJvSrOjuyeQ4Ib
         M7LiBnI7cvMD2oXx0+FAfBFDEHZJ1O1teq4Eb6Y8n5jk5B/3kRbORbEJvfXCyn+tMeSc
         r31A==
X-Gm-Message-State: AOJu0YywVJvfTJaVPbkT/qYgJVFVZfB4Rd92yxYdtfbRxoQOxcbyxvfo
	vYjvTA6m5+Rj5U7JePVOn6+IC9HXesyQjg==
X-Google-Smtp-Source: AGHT+IHfkRM7maTPnpWNurNP3VuGJUQU+a17hwG/pPR1gKXEUpEQHINoAyYIu6TPQ9EVT5AshPgxPA==
X-Received: by 2002:a17:906:6047:b0:a26:aaa1:4ff1 with SMTP id p7-20020a170906604700b00a26aaa14ff1mr6672885ejj.13.1703584385194;
        Tue, 26 Dec 2023 01:53:05 -0800 (PST)
Received: from u94a (2001-b011-fa04-d3bc-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:d3bc:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id g24-20020a170902fe1800b001d0c41b1d03sm9636234plj.32.2023.12.26.01.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 01:53:04 -0800 (PST)
Date: Tue, 26 Dec 2023 17:52:56 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Maxim Mikityanskiy <maxim@isovalent.com>
Subject: Re: [PATCH bpf-next 01/15] selftests/bpf: Fix the
 u64_offset_to_skb_data test
Message-ID: <w7xg34uqlrnbb3o3rspng6y563astp3hkfxjtz3xp32rqr4a42@xgpeu7qevatg>
References: <20231220214013.3327288-1-maxtram95@gmail.com>
 <20231220214013.3327288-2-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220214013.3327288-2-maxtram95@gmail.com>

On Wed, Dec 20, 2023 at 11:39:59PM +0200, Maxim Mikityanskiy wrote:
> From: Maxim Mikityanskiy <maxim@isovalent.com>
> 
> The u64_offset_to_skb_data test is supposed to make a 64-bit fill, but
> instead makes a 16-bit one. Fix the test according to its intention. The
> 16-bit fill is covered by u16_offset_to_skb_data.

Cover letter mentioned

  Patch 1 (Maxim): Fix for an existing test, it will matter later in the
  series.

However no subsequent patch touch upon u64_offset_to_skb_data(). Was the
followup missing from this series?

> Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
> [...]
>  SEC("tc")
>  __description("Spill u32 const scalars.  Refill as u64.  Offset to skb->data")
> -__failure __msg("invalid access to packet")
> +__failure __msg("math between pkt pointer and register with unbounded min value is not allowed")
>  __naked void u64_offset_to_skb_data(void)
>  {
>  	asm volatile ("					\
> @@ -253,7 +253,7 @@ __naked void u64_offset_to_skb_data(void)
>  	w7 = 20;					\
>  	*(u32*)(r10 - 4) = r6;				\
>  	*(u32*)(r10 - 8) = r7;				\
> -	r4 = *(u16*)(r10 - 8);				\
> +	r4 = *(u64*)(r10 - 8);				\
>  	r0 = r2;					\
>  	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=65535 */\
>  	r0 += r4;					\

