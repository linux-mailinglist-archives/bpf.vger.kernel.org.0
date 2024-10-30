Return-Path: <bpf+bounces-43495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BBD9B5BCC
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 07:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD011C20FFF
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 06:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52761D271C;
	Wed, 30 Oct 2024 06:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="geUyzb9V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QiAEZIGI"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E8B1991DF;
	Wed, 30 Oct 2024 06:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270209; cv=none; b=PB6K76jt+Z3m8gIX9bBTQebASPHV4fpsWWk2k8HuqXLWut6nLiCYpAMLVRf33cUPY8t7XbW3wHkRPbJegG261L1VP8syPDjMZLe5G2f4a7+jASQr9pCWicxZZb/o7YTQGFOIsfot8oXDYsyTmEIg8+r+uaJJUBRIAG/zYHgniQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270209; c=relaxed/simple;
	bh=dy77vAiFl23zCx0+uO/faRJWNj+H1FMp8LkdWFPtLho=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=chrojjvWqpTw6dcRzzI/mjF2P6N5Qazqp2+/3bRqlEHnMGmlZa0KUU6qZ9Tqmsf2U8p/Zm8xrz5QgOtm1UCxTxex+4H/oCxJtsqXwJfgclPKocTCYhoESuobuwGZaJjp+8680arR4wKiNOfACGTdbSDX2cWqC04IGEV6mH5AHJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=geUyzb9V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QiAEZIGI; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4F117254011D;
	Wed, 30 Oct 2024 02:36:45 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Wed, 30 Oct 2024 02:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1730270205;
	 x=1730356605; bh=vf6UVZw2Jx/Bk5pWy/xW+BJX6Pm927G1nPmeMePZtKU=; b=
	geUyzb9V6h+D1T6ggc9Zj+O424d77lrB1Arbg11Qqe1T7uTtD3sJdb2uIOO7cumg
	PwABKLZeZfENhRGN6LHBXh4vCVXUs8pQwgXyZes0anH/ncRpdnGqOuBWF4qFHFxm
	sGt2FOsEv9wIhH34O95iYpuVUlu9r6n5ON+H8u9WU+5C/W4vx9Nez6GvKSrZuU/m
	wLTLQLEnzpmd+JRCwEZsR8Sto0orHAo5OEb34UbqDOIvFAA8Sfw6AaBxM6tXUoaz
	SuE2riy7NiGPMkbe512ymcxZ7hPLdYeILY3unEj9SRioAk9UJcOql+uA4XA1wu5s
	vdnzZnFbjDg/TODfI1akzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1730270205; x=1730356605; bh=v
	f6UVZw2Jx/Bk5pWy/xW+BJX6Pm927G1nPmeMePZtKU=; b=QiAEZIGIibMvgWfu1
	IysSrjMiPTIwusRXuOkfiuTGDZl3uASG5zWEpBhq+2USngcnlV6vCRiHhPraaQg4
	/t9mr/mWVPr5/HKIQ4YFFmDBYSPE31isuT+1n0ppTn8r8g3nhJ95AExfu5Xh6/uB
	DxBZn8FEvw4+dn17IAbnE8DFJSEJJKig1Qk9fDlkVQgAQQhac77dc8Vlt7G3O7cZ
	/qAzjh0Sja9LvLiuwZxnvHkg1qtqQwUaKq/yruHY8Oxhh6Verm5CCCZWNtq5xBNg
	KAYMa5PabphiVD9tgrEPHvzgrfyf6qfmT3mMwZoyUJsjsz/H+Al83JmQ4y/3WvlZ
	p2B1g==
X-ME-Sender: <xms:_NMhZzDk4I8Q3NsIg5hKVoTLK45rSue4d8eTy6OmgIsA8VOKE1IsJw>
    <xme:_NMhZ5hk-pNZTNgESz0w0DCgekLunRhOnFndkbkKHK6--UQfYiYZn-OdkbcuHwS8x
    9P5ZgOkwmtoDhoNvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekvddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdlfeehmdenucfjughrpefoggffhffvkfgj
    fhfutgfgsehtjeertdertddtnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguh
    esugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepteffffffueelieffveehvdev
    gfelveejieffleeuvdehkedvleffgfelgeefveejnecuffhomhgrihhnpehgihhthhhusg
    drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegugihusegugihuuhhurdighiiipdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgt
    phhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_NMhZ-m8fXsKRAaibdVaVN08qoG7Z_h1aq8ckLdZ6odWZ97nUkavug>
    <xmx:_NMhZ1wx8gVro7jpFZeUBFKHfJ6cigq5WWNkfdKt01_B7Hr-eQIb4g>
    <xmx:_NMhZ4Rwi6XOLEpzQzRWosfEoiUWqe5bWbTlatOouqWGistNU3ZeYw>
    <xmx:_NMhZ4YcDHYjqVnHMZuaWdyE6VTkij3vu7flsaGACRU2hAvfV5_YeA>
    <xmx:_dMhZ-dMTfw8RRnfH8krpdc2bo3M3ybNxgn-9myzvvqdos6hUpwTycHJ>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 90F6718A0068; Wed, 30 Oct 2024 02:36:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 30 Oct 2024 15:36:24 +0900
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "Daniel Borkmann" <daniel@iogearbox.net>
Message-Id: <eb20fd2c-0fb7-48f7-9fd0-4d654363f4da@app.fastmail.com>
In-Reply-To: <cover.1692748902.git.dxu@dxuuu.xyz>
References: <cover.1692748902.git.dxu@dxuuu.xyz>
Subject: Re: [RFC PATCH bpf-next 0/2] Improve prog array uref semantics
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hey Daniel,

On Wed, Aug 23, 2023, at 9:08 AM, Daniel Xu wrote:
> This patchset changes the behavior of TC and XDP hooks during attachment
> such that any BPF_MAP_TYPE_PROG_ARRAY that the prog uses has an extra
> uref taken.
>
> The goal behind this change is to try and prevent confusion for the
> majority of use cases. The current behavior where when the last uref is
> dropped the prog array map is emptied is quite confusing. Confusing
> enough for there to be multiple references to it in ebpf-go [0][1].
>
> Completely solving the problem is difficult. As stated in c9da161c6517
> ("bpf: fix clearing on persistent program array maps"), it is
> difficult-to-impossible to walk the full dependency graph b/c it is too
> dynamic.
>
> However in practice, I've found that all progs in a tailcall chain
> share the same prog array map. Knowing that, if we take a uref on any
> used prog array map when the program is attached, we can simplify the
> majority use case and make it more ergonomic.
>
> I'll be the first to admit this is not a very clean solution. It does
> not fully solve the problem. Nor does it make overall logic any simpler.
> But I do think it makes a pretty big usability hole slightly smaller.
>
> I've done some basic testing using a repro program [3] I wrote to debug
> the original issue that eventually led me to this patchset. If we wanna
> move forward with this approach, I'll resend with selftests.
>
> [0]: 
> https://github.com/cilium/ebpf/blob/01ebd4c1e2b9f8b3dd4fd2382aa1092c3c9bfc9d/doc.go#L22-L24
> [1]: 
> https://github.com/cilium/ebpf/blob/d1a52333f2c0fed085f8d742a5a3c164795d8492/collection.go#L320-L321
> [2]: https://github.com/danobi/tc_tailcall_repro

I recently remembered about this again. Was suggested I poke you in case you're interested.
I looked again and I think this is kinda a neat hack. I probably won't have time to pick this back
up either way.

