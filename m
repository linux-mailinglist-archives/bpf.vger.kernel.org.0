Return-Path: <bpf+bounces-46888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E57DE9F1596
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 20:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E6A77A1006
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 19:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0221EC4C3;
	Fri, 13 Dec 2024 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iLAGx6Ln"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9FD1E47D9
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 19:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734117228; cv=none; b=WDmLI3I81pPewCPtVQTywwJnk4aEwdET51aM9I39HE4MZ1AMDhoX2gXgqKzCGY23TCW0kvW4vVX/Yi1bx4cT82izuqqA8Axn+aJJ1SPxnJlPP30zrIz5aWs45ovofjqj8PZIqqprQXNhnZvb/qJ5a2tKf6mETbM8n0g6hFufKeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734117228; c=relaxed/simple;
	bh=kZ6EcUzq2jNdidPybk0fuP8u4Ugi0Aq98UlB6cj6uvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iKsxB3oYRpTLlqpmLXooXixatUgAHLt5pl7OyGyaTX9awUEOn8HW2jYr960tnT/XOL1X1QZq4MzUK9kR8hzbko8WeaKg5P4O1EGjbYDUJO004IBN5vdaeNQf4JnmmwLC1DkfGV/2uc9Kk1FcuVcpL4YC8uOQdxWtcsgNEqF0u7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iLAGx6Ln; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-467896541e1so31781cf.0
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 11:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734117225; x=1734722025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZ6EcUzq2jNdidPybk0fuP8u4Ugi0Aq98UlB6cj6uvg=;
        b=iLAGx6LnNkgwcTULek/3abeKGn5V84GGIKpqrra195wc3SC2sza0AJA/eGnnU0EotC
         8mU6Ob0v2J47UVXC9iI/8n+pmJR4cvFUN1r47/k/BGosMoUCLXVHDfmLL7qzLqHI3YDL
         LBpECFL/4BgILVgI+mwaG2CcS8WU9r7jdHUFlbHqYmBw4K6vOaUbOkbjkhS1xqsuzyWz
         CgCYiwGfhtY+YmSF+mWgysmHlP3AE5X1I1QSfBkzl/zKIO2z3PWUva9id6BwdC+1ln54
         OOoBf7OesAtcBWkfJcXj/0SLBZgxr5yYLu309b2zag5sVaYtoqwA3BIRcMTsaq1n2rBX
         Zxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734117225; x=1734722025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZ6EcUzq2jNdidPybk0fuP8u4Ugi0Aq98UlB6cj6uvg=;
        b=tkgCsjE82tXCgrK/4latMPEcaBTWf1OccOrlObiWgf2TJl8XF5WQH3Ozhkx9DvdY9q
         ddx06qrBmq51pZgmWw9kT6FpCJWfFsAz9NiaHrAZEDixKYvRflAoxfy7qqWKv/La2BTw
         23HOUvo5acT1U5JT2FocH7BbcphJEpFy5K9XCeusjMbl2sUYH3eLgDeEH7DcPjfo0/R2
         GRlPoIrWt3MzuxQr+og3qxFCLPH3yh2jfX1IgpzKpZfhD+wXsu2dDqGRTnQuZSmkzFaz
         +YrmJurjgXkGULFr1tJY8OVDVFh2R3Mq1EE2D/q3F0VummCX1rgmV5rA6thX0Z9iTIs4
         au2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRBOTj9PHTNFhgdLD9l6mqh33AC1MV6vE8fXSHO4Q1dETI/3iFmYCFgwxXX2QViLojkBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3qDS2WeN/bSzTtvWO5jxaar9EkSpxqXUdIkI5FHO3eRd6UU0n
	ni0qcGW/mH/2BniU3vySCUksQhQiDtjVTUfV2WeQUu67paBy2HeFnVPzIwEG3PB+NoUnLOy7zSA
	N+zPcH6lB49vHAH1SsNRrXPB8ngcv7xBuYlC8
X-Gm-Gg: ASbGncv6DZxE9pqo1lDGCCcQQ2mw2ILgnIp+NwJ720+7RnYG+EPnQcQIgaLkhHWapor
	gE5395g1jX58dPCYjHrr6AEvT7ZNIOlgQMXclAw==
X-Google-Smtp-Source: AGHT+IF8Lt9b9Tc5G9jT4uQCd6qUIHKsCG+ri6mk/aF10xNf22rSX0wOK1yGdKJJt1WdnMH1NLbi3qayMa41u3rZCLw=
X-Received: by 2002:a05:622a:89:b0:467:7f81:ade0 with SMTP id
 d75a77b69052e-467b30b4e71mr129381cf.24.1734117224728; Fri, 13 Dec 2024
 11:13:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211172649.761483-1-aleksander.lobakin@intel.com> <20241211172649.761483-10-aleksander.lobakin@intel.com>
In-Reply-To: <20241211172649.761483-10-aleksander.lobakin@intel.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 13 Dec 2024 11:13:33 -0800
Message-ID: <CAHS8izNEzoeuAQieg9=v7rHp8TCWXyw60UbrZgEm5LCKhtCEAg@mail.gmail.com>
Subject: Re: [PATCH net-next 09/12] page_pool: add a couple of netmem counterparts
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	"Jose E. Marchesi" <jose.marchesi@oracle.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Jason Baron <jbaron@akamai.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Nathan Chancellor <nathan@kernel.org>, 
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 9:31=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> Add the following Page Pool netmem wrappers to be able to implement
> an MP-agnostic driver:
>

Sorry, we raced a bit here. Jakub merged my "page_pool_alloc_netmem",
which does similar to what this patch does.

> * page_pool{,_dev}_alloc_best_fit_netmem()
>
> Same as page_pool{,_dev}_alloc(). Make the latter a wrapper around
> the new helper (as a page is always a netmem, but not vice versa).
> 'page_pool_alloc_netmem' is already busy, hence '_best_fit' (which
> also says what the helper tries to do).
>

I freed the page_pool_alloc_netmem name by doing a rename, and now
page_pool_alloc_netmem is the netmem counterpart to page_pool_alloc. I
did not however add a page_pool_dev_alloc equivalent.

> * page_pool_dma_sync_for_cpu_netmem()
>
> Same as page_pool_dma_sync_for_cpu(). Performs DMA sync only if
> the netmem comes from the host.
>

My series also adds page_pool_dma_sync_netmem_for_cpu, which should be
the same as your page_pool_dma_sync_for_cpu_netmem.

