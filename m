Return-Path: <bpf+bounces-21121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40658847E00
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 01:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A571C22476
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 00:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDD3A3D;
	Sat,  3 Feb 2024 00:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brycekahle.com header.i=@brycekahle.com header.b="bsCX27+6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ri2mQSbJ"
X-Original-To: bpf@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E700010F9
	for <bpf@vger.kernel.org>; Sat,  3 Feb 2024 00:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706921935; cv=none; b=SBYS1GJ7hHQ1CgX2V2qdoQ5/wXpeV/XBCgBWcxKAKjwLzPIyKxzFRVbGVPbOK4Nui8uDWE2Gxhkho/LwCUSKifzX0KJvm0lVwls/eEscM8WBKqvx9IwzH05m/2pNL8V9JRlBVuszt/iqi7/OTnXu1V5Z4/kSv2hA8P+Nne1oct8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706921935; c=relaxed/simple;
	bh=eNuq+d3+EK7uJokXS1qOV8jdv1lft7GaM67R6KkJ3U0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=nEUxgCgXvikx4ZXVoeXiCvsOWnYv3xYp+xZeHqXqK7PAy1K4ECTqdUf6SqhvxGX9kJ8x5u3bo8OtUN0dWlwGIIxAxyPdTrOa35qzCZzgoVVeU5qiaXksdQL7bEIFpkJj1yX7/x5u2yU45EVPuz7uOjxpKtzBqZ2qaxpW07TKoHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brycekahle.com; spf=pass smtp.mailfrom=brycekahle.com; dkim=pass (2048-bit key) header.d=brycekahle.com header.i=@brycekahle.com header.b=bsCX27+6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ri2mQSbJ; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brycekahle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brycekahle.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 7AD8B3200A24;
	Fri,  2 Feb 2024 19:58:51 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute7.internal (MEProxy); Fri, 02 Feb 2024 19:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=brycekahle.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1706921930; x=
	1707008330; bh=TbsBCCZiVNiuZDpEnuIMx7WHulEBSIcFS/kQ/xnCFN4=; b=b
	sCX27+6rbPKM7979iAFEuIDEwQn+4XMcv2W7R9o4bmdcGVU9XsxbSwEAwn2AY9dE
	OMdMdcQtDNvXstwulB/5atwUrH0BnFkhWqBCWjWvFxJetdwrjhZ728w4yemWBvE9
	k8hJeufyoQSq9f5PEp/rTO5BiAcHUJWwuMZLSV7QbstR38bJY7auo59leO6nUuHk
	/ZSlk2hKUOly2sVbeA1nCh9+59EaNgjelEh7HU9eoHRZgLBH6+wntOq7AFZzW23u
	UJ+wVtRZvJoTWs21PuJ0lRicwCgZPbIQ8UbaEWokIozBdVaNHOr5Zsw+BuYR0aVA
	V+QBSUXqVQsVOtYh3RCgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706921930; x=1707008330; bh=TbsBCCZiVNiuZDpEnuIMx7WHulEB
	SIcFS/kQ/xnCFN4=; b=Ri2mQSbJ8UeoCVed5Ltn2if145qC/GOgE1yxW/HeP6wu
	euCgKtIMx2VaTVgUb80SekjZv1XDXJSo9OVnvsc2BTFSIO9Um8ofqJut87ef4FLU
	uuktvaGBA9Tn1xrwys1bgYgxMY8/EAYOEoTgVAN+PueCcfBVKL/efzqXcDBsndlb
	j/fbe3Xzwmj0GPVNmDLtsa4cLHQAIZOXYs4+jXOPRjHHmQ4f+XyWOzaildqUXyHE
	W3reoWSNYgo2cjwOs4E9WsDqamNItbtGi7WwBLKyc21Gh4ZOJKkb3XTT6qPSGwlR
	JLgmFFwIfbPggNAURPh8cm+oMqzehF8bUeLFJjre9A==
X-ME-Sender: <xms:yo-9ZTGGuZI0aAOLxbiQ4Q-OTLlOrZukiMzxrsLzphoT9tZeBPqGFw>
    <xme:yo-9ZQVFsKJwNJhzWLOkgpbQjoEzFPBywtUHrthcKerPrRtQcbhDKzscCMyrhNLCw
    xltyT3-K2CsfyC6cnc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduhedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfuehr
    higtvgcumfgrhhhlvgdfuceoghhithessghrhigtvghkrghhlhgvrdgtohhmqeenucggtf
    frrghtthgvrhhnpeetkeekteetteffhfehffeukeeijeegveffgfekhfehvdefffekjeeg
    fedtfefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehgihhtsegsrhihtggvkhgrhhhlvgdrtghomh
X-ME-Proxy: <xmx:yo-9ZVI5DJH6jrvQu_wfR158zZ29TatQcqcc0X0BuMZy9CE7Z-EFwg>
    <xmx:yo-9ZRGAL_aOCakDOXItbbWn5yyXqVgWJ6hAEdakDL1iYinq6tibWg>
    <xmx:yo-9ZZWROInXz0iK59D5WsRZn5a0qudKxai9p6YMFqVh0exeK1ZvgQ>
    <xmx:yo-9ZcTRTYNuMk4AvJNo0fa1Pcz2c-_0RnRlaS5hOtCSd-VcjQkHuw>
Feedback-ID: ib4b944d5:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 76E3E36A0076; Fri,  2 Feb 2024 19:58:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dfcd6c3b-dbaa-4e72-acc5-89aed8a836f9@app.fastmail.com>
In-Reply-To: 
 <CAEf4Bza=mroJ6+zhK-fCKLutuH_1z9ESeJs+BHbNbCrATrwRdA@mail.gmail.com>
References: <20240130230510.791-1-git@brycekahle.com>
 <9b054832-3469-4659-9484-00bcfef87563@isovalent.com>
 <CALvGib8u_owyjKCWcD3ZrFTkUw6dwE2Aev6nG2AD+D++b+R77A@mail.gmail.com>
 <CAEf4Bza=mroJ6+zhK-fCKLutuH_1z9ESeJs+BHbNbCrATrwRdA@mail.gmail.com>
Date: Fri, 02 Feb 2024 16:58:29 -0800
From: "Bryce Kahle" <git@brycekahle.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>,
 "Bryce Kahle" <bryce.kahle@datadoghq.com>
Cc: "Quentin Monnet" <quentin@isovalent.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH bpf-next v4] bpftool: add support for split BTF to gen min_core_btf
Content-Type: text/plain

On Fri, Feb 2, 2024, at 2:10 PM, Andrii Nakryiko wrote:
> 
> Maybe the right solution is to concat vmlinux and all the relevant
> module BTFs first, dedup it again, then minimize against that "super
> BTF". But yes, you'd have to specify both vmlinux and all the module
> BTFs at the same time (which bpftool allows you to do easily with its
> CLI interface, so not really a problem)
> 

How would you handle the Type ID conflicts between the modules, since they all start at vmlinux+1? Is there a danger of conflicting type names, where there are two types with the same name but different layouts?

I was trying to mirror the sysfs file layout, so a loader didn't have different behavior between user-supplied BTF and kernel-provided BTF.

