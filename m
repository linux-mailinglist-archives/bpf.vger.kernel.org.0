Return-Path: <bpf+bounces-59793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C870ACF844
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 21:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D3C16B38B
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 19:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E0E27E7FB;
	Thu,  5 Jun 2025 19:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HkZRSyKy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345BF1F866B
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 19:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749152852; cv=none; b=eYrvX9gCLvGauyj53VPs3jZWG+u3djbim1BsWbmZPseT3YoKIe4LT5jeq7qEW/Mny7aRQwwtvCCGxPMuic1WVhK+dFk/Rnf3Y/eBP7l6pqWv5aiFYQFBvaupRqKQp5aokC6uvGriDh6nPBnupnisu4YFXiV0Y9DOqQR2wd6hAFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749152852; c=relaxed/simple;
	bh=UCKucqpwIyXj8QqMkDicaIUSsgwwLiTElK59LUrl4fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMHoiAag79fapzZMvR9SJIMrLaJs4O12Z++L7oGNRDGApRf5vo59sq4MIXPFtRnL6Ykb3Ueo00GvgARl5QMBZEksFU7KwXzJq2KOsXfOY5u6BZ1UvD1PbPIyvb4LC03ph55K+AX0jHa8xLWy2R+TE+6kaVpMivJ9ZwE/YPDGOFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HkZRSyKy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235e389599fso52955ad.0
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 12:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749152848; x=1749757648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCKucqpwIyXj8QqMkDicaIUSsgwwLiTElK59LUrl4fE=;
        b=HkZRSyKy1rL1pwe3LUs3LLl61kUzlQxWkvjm8DGMH0Jh1+YuGJ+VVhi7cx77uKFbBg
         Gnz0BDN8p9d9rzjxv1aUXQlPYomT18gULbI1Sg0884mf/SxaE0ViWcIdM4Le2N/d/WUk
         z3hWfH5ybmnBIdBHaP1f9yuyEWc3uVTCUzWpCBa5kNN9dor8zHrVEjokX3TXZGx2iZZr
         wZk6AmSJLK16W37apSBo1VmYyLncIpg3dCaCRVhVO3x3tc1fFrOYA9icQBw9tFcmqfPy
         nyZw1ZIYiEjHKQMJQ0Tof8z6lROTtXn26JffSpcK2hfYZcwbdR70IBWM7ZrxXEbl5cwk
         rF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749152848; x=1749757648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCKucqpwIyXj8QqMkDicaIUSsgwwLiTElK59LUrl4fE=;
        b=G4L85dgOuEAR7C489ih4D+AOKC6s0VK88rcZJWz/N2e2POxl2fwaAwk8O5JdruYyJ3
         EN6ZeqRxcabSWnxpAQgDB948a7DTeqbMRMC+51wDa/wNLZ1DEPGFueKTQT/28J0BE7G3
         Ii2ereGQRPsWoeVfpBq5Z2voqtaTNCALRgDC0I1IU/BWeRfVzS5wNMZ9xtdFjUICTj4M
         esgnrreIZ0qzv8CW2R5/KBT/YuRiIITHM26QwDk+dVi2cDFRFdGDh/lrgbi44bCTfjsg
         okTqTEgJky68INIRrgJz08OCvF54/UuHcOoH4lBfD+lBt3Z7GKAnWRizX/rkDNWhAvIM
         SSBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAT9/wlsqIblHOCTZUqgpBNW70OMYuca5fwQTl+yBUONc9fpFTEieGfQK19mOlbI6nuIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMHlaR+5NaFB5BPjq9bGZv6T48YpWeBU7WlmgIHQmGhDpdP7W+
	dcXrf4tq1UwE9HbUBk+dea+BQzJ7zCMvSy5yFe4oVs2bqcB09eGckKfJ4zFxUUiZR/LRmRFbPlW
	dTHvvTpJr0u6pnAhzFuZnzesaM21owBdnu694uGhD
X-Gm-Gg: ASbGncvvFpWrdALsgF5wjXqgcXzc1XH2VsoZ/Ncd4FTExcAd/cTqG3lyjkKj6MqQP0z
	2d+5yNhLtbU32JvcSzt/YyPTQQjCsY5tzmqP8wRj8Hr/pINcr/wz4zARoBnkYa3tws/S3ZVRXa+
	q5uxaT4VpjcjiRcyMsJ4ofJYopB4IDoCqfgnRQIKHeKY3S
X-Google-Smtp-Source: AGHT+IGEZRKG6xvZHogMtre77VgiSxDaYZdqjTk10sRxgiSBiBGpyaYgS/fptxzapbkZ7Jl7Refn+g7Umm+MVSkwFF8=
X-Received: by 2002:a17:903:22cf:b0:235:e1e4:efc4 with SMTP id
 d9443c01a7336-236021cbd7cmr556885ad.14.1749152847887; Thu, 05 Jun 2025
 12:47:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604025246.61616-1-byungchul@sk.com> <20250604025246.61616-19-byungchul@sk.com>
 <390073b2-cc7f-4d31-a1c8-4149e884ce95@gmail.com> <aEGEM3Snkl8z8v4N@hyeyoo>
In-Reply-To: <aEGEM3Snkl8z8v4N@hyeyoo>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 5 Jun 2025 12:47:14 -0700
X-Gm-Features: AX0GCFuQUodCCzxMMKtUv6I9nARNgb_4QREwvin7nUUsfjMZH4C0VBF2D5sefUE
Message-ID: <CAHS8izPvdKZncxARWUqUqjXgoMb2MmMy+PaYa8XCcWHCQT-CSg@mail.gmail.com>
Subject: Re: [RFC v4 18/18] page_pool: access ->pp_magic through struct
 netmem_desc in page_pool_page_is_pp()
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, Byungchul Park <byungchul@sk.com>, willy@infradead.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kernel_team@skhynix.com, kuba@kernel.org, ilias.apalodimas@linaro.org, 
	hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net, 
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 4:49=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wro=
te:
>
> On Thu, Jun 05, 2025 at 11:56:14AM +0100, Pavel Begunkov wrote:
> > On 6/4/25 03:52, Byungchul Park wrote:
> > > To simplify struct page, the effort to separate its own descriptor fr=
om
> > > struct page is required and the work for page pool is on going.
> > >
> > > To achieve that, all the code should avoid directly accessing page po=
ol
> > > members of struct page.
> >
> > Just to clarify, are we leaving the corresponding struct page fields
> > for now until the final memdesc conversion is done?
>
> Yes, that's correct.
>
> > If so, it might be better to leave the access in page_pool_page_is_pp()
> > to be "page->pp_magic", so that once removed the build fails until
> > the helper is fixed up to use the page->type or so.
>
> When we truly separate netmem from struct page, we won't have 'lru' field
> in memdesc (because not all types of memory are on LRU list),
> so NETMEM_DESC_ASSERT_OFFSET(lru, pp_magic) should fail.
>
> And then page_pool_page_is_pp() should be changed to check lower bits
> of memdesc pointer to identify its type.
>

Oh boy, I'm not sure that works. We already do LSB tricks with
netmem_ref to tell what kind of ref it is. I think the LSB pointer
tricks with netmem_ref and netmem_desc may trample each other's toes.
I guess we'll cross that bridge when we get to it...

--=20
Thanks,
Mina

